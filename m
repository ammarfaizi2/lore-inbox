Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274611AbRITS7R>; Thu, 20 Sep 2001 14:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274612AbRITS7H>; Thu, 20 Sep 2001 14:59:07 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:9482 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S274611AbRITS6x>;
	Thu, 20 Sep 2001 14:58:53 -0400
Message-ID: <3BAA3C17.557A2C4E@osdlab.org>
Date: Thu, 20 Sep 2001 11:57:27 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus <torvalds@transmeta.com>, lkml <linux-kernel@vger.kernel.org>,
        sfr@canb.auug.org.au, crutcher+kernel@datastacks.com
Subject: [PATCH:v2] fix register_sysrq() in 2.4.9++
In-Reply-To: <E15k86n-0005lE-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------EBFBE5401D3A3A1B30B564D4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------EBFBE5401D3A3A1B30B564D4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> 
> > Yeah, I considered that, and it doesn't matter to me whether it
> > reports 0 or -1, but it's the data pointer that (mostly) requires
> > the #ifdefs, unless the data is always present or a dummy data pointer
> > is used.... ?
> 
> #define it to an inline without some arguments ?
~~~~~~~~~~~~~~~~~~
I can't get that to work, but someone else may be able to...

Here's another version for you to consider.

The [un]register_sysrq_key() calls return 0 when CONFIG_MAGIC_SYSRQ
is not defined/configured.
However, it sacrifices one small data structure of 3 pointers.

~Randy
--------------EBFBE5401D3A3A1B30B564D4
Content-Type: text/plain; charset=us-ascii;
 name="sysrq-if2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysrq-if2.patch"

--- linux/arch/i386/kernel/apm.c.org	Mon Sep 17 10:15:45 2001
+++ linux/arch/i386/kernel/apm.c	Thu Sep 20 11:51:25 2001
@@ -703,6 +703,8 @@
 	help_msg:       "Off",
 	action_msg:     "Power Off\n"
 };
+#else
+struct sysrq_key_op sysrq_poweroff_op;
 #endif
 
 
--- linux/include/linux/sysrq.h.org	Mon Sep 17 10:21:07 2001
+++ linux/include/linux/sysrq.h	Thu Sep 20 11:42:15 2001
@@ -87,8 +87,17 @@
 }
 
 #else
-#define register_sysrq_key(a,b)		do {} while(0)
-#define unregister_sysrq_key(a,b)	do {} while(0)
+
+static inline int register_sysrq_key(int key, struct sysrq_key_op *op_p)
+{
+	return 0;
+}
+
+static inline int unregister_sysrq_key(int key, struct sysrq_key_op *op_p)
+{
+	return 0;
+}
+
 #endif
 
 /* Deferred actions */

--------------EBFBE5401D3A3A1B30B564D4--

