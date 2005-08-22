Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbVHVT5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVHVT5Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 15:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbVHVT5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 15:57:16 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:46042 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750786AbVHVT5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 15:57:15 -0400
Message-ID: <430A3FB8.8040309@labristeknoloji.com>
Date: Mon, 22 Aug 2005 21:12:24 +0000
From: "M.Baris Demiray" <baris@labristeknoloji.com>
Organization: Labris Teknoloji
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH -mm] Replace cli()/sti() pair with spinlocks in cmd206 driver
Content-Type: multipart/mixed;
 boundary="------------000302010701090708060202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000302010701090708060202
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi Andrew,
Following patch replaces the deprecated cli()/sti() pair with spinlocks and
fixes the following warning:

<snipped>
    gcc -m32 -Wp,-MD,drivers/cdrom/.cm206.o.d  -nostdinc -isystem /usr/lib/gcc-lib/i486-slackware-linux/3.3.4/include
-D__KERNEL__ -Iinclude  -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding
-O2     -fno-omit-frame-pointer -fno-optimize-sibling-calls -g -pipe -msoft-float -mpreferred-stack-boundary=2
-march=i686  -mregparm=3 -Iinclude/asm-i386/mach-default     -DMODULE -DKBUILD_BASENAME=cm206 -DKBUILD_MODNAME=cm206 -c
-o drivers/cdrom/.tmp_cm206.o drivers/cdrom/cm206.c
drivers/cdrom/cm206.c: In function `send_command':
drivers/cdrom/cm206.c:473: warning: implicit declaration of function `cli'
drivers/cdrom/cm206.c: In function `receive_byte':
drivers/cdrom/cm206.c:494: warning: implicit declaration of function `sti'
</snipped>

o Replace the deprecated cli()/sti() pair with spinlocks and
    fix a warning in cmd206 cdrom driver

Signed-off-by: M.Baris Demiray <baris@labristeknoloji.com>

--- linux-2.6.13-rc6-mm1/drivers/cdrom/cm206.c.orig	2005-08-20 11:24:32.000000000 +0000
+++ linux-2.6.13-rc6-mm1/drivers/cdrom/cm206.c	2005-08-22 18:31:05.000000000 +0000
@@ -192,6 +192,7 @@
   #include <linux/mm.h>
   #include <linux/slab.h>
   #include <linux/init.h>
+#include <linux/spinlock.h>

   /* #include <linux/ucdrom.h> */

@@ -303,6 +304,7 @@
   static struct cm206_struct *cd;	/* the main memory structure */
   static struct request_queue *cm206_queue;
   static DEFINE_SPINLOCK(cm206_lock);
+static DEFINE_SPINLOCK(cm206_lock_port);

   /* First, we define some polling functions. These are actually
      only being used in the initialization. */
@@ -470,7 +472,8 @@
   	debug(("Sending 0x%x\n", command));
   	if (!(inw(r_line_status) & ls_transmitter_buffer_empty)) {
   		cd->command = command;
-		cli();		/* don't interrupt before sleep */
+		/* don't interrupt before sleep */
+		spin_lock_irq(&cm206_lock_port);
   		outw(dc_mask_sync_error | dc_no_stop_on_error |
   		     (inw(r_data_status) & 0x7f), r_data_control);
   		/* interrupt routine sends command */
@@ -487,11 +490,11 @@
   static uch receive_byte(int timeout)
   {
   	uch ret;
-	cli();
-	debug(("cli\n"));
+	spin_lock_irq(&cm206_lock_port);
+	debug(("cm206_lock_port locked\n"));
   	ret = cd->ur[cd->ur_r];
   	if (cd->ur_r != cd->ur_w) {
-		sti();
+		spin_unlock_irq(&cm206_lock_port);
   		debug(("returning #%d: 0x%x\n", cd->ur_r,
   		       cd->ur[cd->ur_r]));
   		cd->ur_r++;
@@ -1407,7 +1410,7 @@
   {
   	int irqs, irq;
   	outw(dc_normal | READ_AHEAD, r_data_control);	/* disable irq-generation */
-	sti();
+	spin_unlock_irq(&cm206_lock_port);
   	irqs = probe_irq_on();
   	reset_cm260();		/* causes interrupt */
   	udelay(100);		/* wait for it */
@@ -1447,14 +1450,14 @@
   	} else
   		printk(" IRQ %d found\n", cm206_irq);
   #else
-	cli();
+	spin_lock_irq(&cm206_lock_port);
   	reset_cm260();
   	/* Now, the problem here is that reset_cm260 can generate an
   	   interrupt. It seems that this can cause a kernel oops some time
   	   later. So we wait a while and `service' this interrupt. */
   	mdelay(1);
   	outw(dc_normal | READ_AHEAD, r_data_control);
-	sti();
+	spin_unlock_irq(&cm206_lock_port);
   	printk(" using IRQ %d\n", cm206_irq);
   #endif
   	if (send_receive_polled(c_drive_configuration) !=


-- 
"You have to understand, most of these people are not ready to be
unplugged. And many of them are no inert, so hopelessly dependent
on the system, that they will fight to protect it."
                                                          Morpheus


--------------000302010701090708060202
Content-Type: text/x-vcard; charset=utf-8;
 name="baris.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="baris.vcf"

YmVnaW46dmNhcmQNCmZuOk0uQmFyaXMgRGVtaXJheQ0KbjpEZW1pcmF5O00uQmFyaXMNCm9y
ZzpMYWJyaXMgVGVrbm9sb2ppDQphZHI6OztUZWtub2tlbnQgU2lsaWtvbiBCaW5hIE5vOjI0
IE9EVFU7QW5rYXJhOzswNjUzMTtUdXJrZXkNCmVtYWlsO2ludGVybmV0OmJhcmlzQGxhYnJp
c3Rla25vbG9qaS5jb20NCnRpdGxlOllhemlsaW0gR2VsaXN0aXJtZSBVem1hbmkNCnRlbDt3
b3JrOis5MDMxMjIxMDE0OTANCnRlbDtmYXg6KzkwMzEyMjEwMTQ5Mg0KeC1tb3ppbGxhLWh0
bWw6RkFMU0UNCnVybDpodHRwOi8vd3d3LmxhYnJpc3Rla25vbG9qaS5jb20vfmJhcmlzLw0K
dmVyc2lvbjoyLjENCmVuZDp2Y2FyZA0KDQo=
--------------000302010701090708060202--
