Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVABK4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVABK4g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 05:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVABK4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 05:56:32 -0500
Received: from dsl81-214-6222.adsl.ttnet.net.tr ([81.214.24.78]:62413 "EHLO
	yssyk.iliskisel.idealteknoloji.com") by vger.kernel.org with ESMTP
	id S261247AbVABK4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 05:56:16 -0500
Message-ID: <41D7D2D5.5090407@idealteknoloji.com>
Date: Sun, 02 Jan 2005 12:54:13 +0200
From: "M.Baris Demiray" <baris@idealteknoloji.com>
Organization: Ideal Teknoloji
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: alan@lxorguk.ukuu.org.uk
Subject: [PATCH] [2.6.10-ac2] Moxa driver causes compile-time errors
Content-Type: multipart/mixed;
 boundary="------------010302040508080908020702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010302040508080908020702
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi,
latest -ac tree patch ac2 replaces some obsolete save_flags()/cli()
with spin_lock_irqsave() but there are compile time errors caused by
seems-like-forgotten-to-add-but-used spinlock_t member in moxa_str
structure. Attached diff file fixes this error and several other
warnings.

[newbie_mode ON]
Also, there are two more save_flags()/cli() calls in moxa.c. Are they 
missed or kept for a specific reason? Attached patch also replaces them
with spin_lock_irqsave().
[newbie_mode OFF]

fix_moxa_str_structure_and_several_warnings.patch
o Add spinlock_t member `lock' to moxa_str structure
o Remove unused variable `page' from moxa_open()
o Replaces obsolete save_flags()/cli() pair in block_till_ready() and
   receive_data() with spin_lock_irqsave()
o Remove inclusion of linux/interrupt.h since remaining two
   save_flags()/cli() calls are removed

diffstat output:
----------------
  moxa.c |   13  5 +     8 -     0 !
  1 files changed, 5 insertions(+), 8 deletions(-)

Relevant .config lines:
-----------------------
1370:CONFIG_MOXA_INTELLIO=m
1371:CONFIG_MOXA_SMARTIO=m

I can send my .config file on request.

Relevant build output:
----------------------
   gcc -Wp,-MD,drivers/char/.moxa.o.d -nostdinc -iwithprefix include 
-D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs 
-fno-strict-aliasing -fno-common -O2     -fno-omit-frame-pointer -pipe 
-msoft-float -mpreferred-stack-boundary=2  -march=i686 
-Iinclude/asm-i386/mach-default    -DMODULE -DKBUILD_BASENAME=moxa 
-DKBUILD_MODNAME=moxa -c -o drivers/char/.tmp_moxa.o drivers/char/moxa.c
drivers/char/moxa.c: In function `moxa_open':
drivers/char/moxa.c:519: warning: unused variable `page'
drivers/char/moxa.c: In function `moxa_write':
drivers/char/moxa.c:632: structure has no member named `lock'
drivers/char/moxa.c:635: structure has no member named `lock'
drivers/char/moxa.c: In function `moxa_put_char':
drivers/char/moxa.c:705: structure has no member named `lock'
drivers/char/moxa.c:709: structure has no member named `lock'
drivers/char/moxa.c: In function `block_till_ready':
drivers/char/moxa.c:1007: warning: implicit declaration of function 
`save_flags'
drivers/char/moxa.c:1008: warning: implicit declaration of function `cli'
drivers/char/moxa.c:1011: warning: implicit declaration of function 
`restore_flags'
drivers/char/moxa.c: In function `setup_empty_event':
drivers/char/moxa.c:1057: structure has no member named `lock'
drivers/char/moxa.c:1064: structure has no member named `lock'
make[2]: *** [drivers/char/moxa.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

After applying attached patch gcc(-3.2.3) does not complain about
drivers/char/moxa.c anymore.

-- 
M.Baris Demiray

DOS: n., A small annoying boot virus that causes random spontaneous
system crashes, usually just before saving a massive project.
Easily cured by UNIX. See also MS-DOS, IBM-DOS, DR-DOS.

----
You have to understand, most of these people are not ready to be
unplugged. And many of them are no inert, so hopelessly dependent
on the system, that they will fight to protect it."
                                                           Morpheus

--------------010302040508080908020702
Content-Type: text/x-patch;
 name="fix_moxa_str_structure_and_several_warnings.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_moxa_str_structure_and_several_warnings.patch"

--- linux-2.6.10-ac2/drivers/char/moxa.c.orig	2005-01-02 01:10:54.000000000 +0200
+++ linux-2.6.10-ac2/drivers/char/moxa.c	2005-01-02 07:29:00.000000000 +0200
@@ -38,7 +38,6 @@
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/timer.h>
-#include <linux/interrupt.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/major.h>
@@ -153,6 +152,7 @@
 	int blocked_open;
 	long event; /* long req'd for set_bit --RR */
 	int asyncflags;
+	spinlock_t lock;
 	unsigned long statusflags;
 	struct tty_struct *tty;
 	int cflag;
@@ -516,7 +516,6 @@
 	struct moxa_str *ch;
 	int port;
 	int retval;
-	unsigned long page;
 
 	port = PORTNO(tty);
 	if (port == MAX_PORTS) {
@@ -1004,11 +1003,10 @@
 	printk("block_til_ready before block: ttys%d, count = %d\n",
 	       ch->line, ch->count);
 #endif
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&ch->lock, flags);
 	if (!tty_hung_up_p(filp))
 		ch->count--;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&ch->lock, flags);
 	ch->blocked_open++;
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -1129,10 +1127,9 @@
 	charptr = tp->flip.char_buf_ptr;
 	flagptr = tp->flip.flag_buf_ptr;
 	rc = tp->flip.count;
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&ch->lock, flags);
 	count = MoxaPortReadData(ch->port, charptr, space);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&ch->lock, flags);
 	for (i = 0; i < count; i++)
 		*flagptr++ = 0;
 	charptr += count;

--------------010302040508080908020702
Content-Type: text/x-vcard; charset=utf-8;
 name="baris.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="baris.vcf"

YmVnaW46dmNhcmQNCmZuOk0uQmFyaXMgRGVtaXJheQ0KbjpEZW1pcmF5O00uQmFyaXMNCm9y
ZzpJZGVhbCBUZWtub2xvamkNCmFkcjo7O1Rla25va2VudCBTaWxpa29uIEJpbmEgTm86MjQg
T0RUVTtBbmthcmE7OzA2NTMxO1R1cmtpeWUNCmVtYWlsO2ludGVybmV0OmJhcmlzQGlkZWFs
dGVrbm9sb2ppLmNvbQ0KdGl0bGU6WWF6aWxpbSBHZWxpc3RpcmljaQ0KdGVsO3dvcms6Kzkw
MzEyMjEwMTQ5MA0KdGVsO2ZheDorOTAzMTIyMTAxNDkyDQp4LW1vemlsbGEtaHRtbDpGQUxT
RQ0KdXJsOmh0dHA6Ly93d3cuaWRlYWx0ZWtub2xvamkuY29tDQp2ZXJzaW9uOjIuMQ0KZW5k
OnZjYXJkDQoNCg==
--------------010302040508080908020702--
