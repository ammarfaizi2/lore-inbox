Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbUCDGyS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 01:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbUCDGyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 01:54:18 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28824 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261516AbUCDGyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 01:54:15 -0500
To: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.4-rc1 make i8042 work on a genuine i386 ibm ps/2 model 70.
References: <m1znb29css.fsf@ebiederm.dsl.xmission.com>
	<20040303101347.GB310@ucw.cz>
	<m1znax3gsq.fsf@ebiederm.dsl.xmission.com>
	<m1wu61wu4i.fsf@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Mar 2004 23:45:29 -0700
In-Reply-To: <m1wu61wu4i.fsf@ebiederm.dsl.xmission.com>
Message-ID: <m1k721156e.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Summary:
>From reading 2.4.x pc_keyb.c it appears old ibm powerpc laptops
do not support the XLAT bit, refuse to set it, and continue
to pass normal scancodes.

My ibm ps/2 model 70 also refuses to set the XLAT bit, refuses to set it,
and continues to pass ``normal'' scancodes, and works just fine under
2.4.21.

Old 2.4.x behavior was to either (a) not initialize the keyboard
controller at all, or (b) when it was initialized to always attempted
to set the XLATE bit, ignoring failure.

So it looks like the correct solution if the XLAT bit is not set, at
boot is to attempt to set the XLATE bit, and if it will not set assume
the keyboard controller will not go into plain serio mode.

Here is a patch that implements that.  For everything that implements
the XLATE bit the behavior should be exactly as the previous version.

Eric



diff -uNrX linux-ignore-files linux-2.6.4-rc1/drivers/input/serio/i8042.c linux-2.6.4-rc1.ps2kbdfix/drivers/input/serio/i8042.c
--- linux-2.6.4-rc1/drivers/input/serio/i8042.c	Sun Feb 22 16:24:11 2004
+++ linux-2.6.4-rc1.ps2kbdfix/drivers/input/serio/i8042.c	Wed Mar  3 23:11:08 2004
@@ -655,6 +655,7 @@
 
 static int i8042_controller_init(void)
 {
+	static unsigned char i8042_tmp_ctr;
 
 /*
  * Test the i8042. We need to know if it thinks it's working correctly
@@ -708,19 +709,49 @@
 			printk(KERN_WARNING "i8042.c: Warning: Keylock active.\n");
 	}
 
+/* 
+ * Enable translate mode for the kbd interface.
+ */
+
+	i8042_ctr |= I8042_CTR_XLATE;
+
+/*
+ * Write CTR back.
+ */
+
+	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
+		printk(KERN_ERR "i8042.c: Can't write CTR while initializing i8042.\n");
+		return -1;
+	}
+
+/*
+ * Read back CTR to see what happened.
+ */
+	if (i8042_command(&i8042_tmp_ctr, I8042_CMD_CTL_RCTR)) {
+		printk(KERN_ERR "i8042.c: Can't read CTR while initializing i8042.\n");
+	}
+
+/* 
+ * If simple serial in/out is not implemented, there is nothing more to do.
+ */
+
+	if (!(i8042_tmp_ctr & I8042_CTR_XLATE)) {
+		return 0;
+	}
+
 /*
- * If the chip is configured into nontranslated mode by the BIOS, don't
- * bother enabling translating and be happy.
+ * If the chip was configured into nontranslated mode by the BIOS, don't
+ * enable translation and be happy.
  */
 
-	if (~i8042_ctr & I8042_CTR_XLATE)
+	if (~i8042_initial_ctr & I8042_CTR_XLATE)
 		i8042_direct = 1;
 
 /*
  * Set nontranslated mode for the kbd interface if requested by an option.
  * After this the kbd interface becomes a simple serial in/out, like the aux
  * interface is. We don't do this by default, since it can confuse notebook
- * BIOSes.
+ * BIOSes, and it might not be implemented.
  */
 
 	if (i8042_direct) {
