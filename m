Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267958AbUHKGbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267958AbUHKGbY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 02:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267961AbUHKGbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 02:31:24 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:35458 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267958AbUHKGbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 02:31:16 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6 kernel won't reboot on AMD system - 8042 problem?
Date: Wed, 11 Aug 2004 01:31:13 -0500
User-Agent: KMail/1.6.2
Cc: "David N. Welton" <davidw@eidetix.com>, Sascha Wilde <wilde@sha-bang.de>
References: <4107E788.8030903@eidetix.com> <41122C82.3020304@eidetix.com>
In-Reply-To: <41122C82.3020304@eidetix.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408110131.14114.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 August 2004 07:48 am, David N. Welton wrote:
> By putting a series of 'crashme/reboot' calls into the kernel, I 
> narrowed a possibl cause of it down to this bit of code in 
> drivers/input/serio.c:753
> 
> /*
>  * Write CTR back.
>  */
> 
> 	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
> 		printk(KERN_ERR "i8042.c: Can't write CTR while initializing i8042.\n");
> 		return -1;
> 	}
> 
> If I do the reboot instructions before this, it reboots fine. 
> Afterwards, and it just sits there, no reboot.


Hi,

Could you please try the patch below? I am interested in tests both with
and without keyboard/mouse. The main idea is to leave ports that have been
disabled by BIOS alone... The patch compiles but otherwise untested. Against
2.6.7.

BTW, do you both have the same motherboard/chipset? Maybe a dmi entry is in
order...

Thanks!

-- 
Dmitry

--- 2.6.7/drivers/input/serio/i8042.c.2.6.7	2004-08-10 22:47:49.000000000 -0500
+++ 2.6.7/drivers/input/serio/i8042.c	2004-08-10 23:07:29.000000000 -0500
@@ -567,6 +567,13 @@
 	static int i8042_check_aux_cookie;
 
 /*
+ * Ignore possible presence of AUX port if interface is disabled by
+ * the BIOS.
+ */
+	if (~i8042_initial_ctr & I8042_CTR_AUXDIS)
+		return -1;
+
+/*
  * Check if AUX irq is available. If it isn't, then there is no point
  * in trying to detect AUX presence.
  */
@@ -610,6 +617,7 @@
 
 	if (i8042_command(&param, I8042_CMD_AUX_DISABLE))
 		return -1;
+
 	if (i8042_command(&param, I8042_CMD_CTL_RCTR) || (~param & I8042_CTR_AUXDIS)) {
 		printk(KERN_WARNING "Failed to disable AUX port, but continuing anyway... Is this a SiS?\n");
 		printk(KERN_WARNING "If AUX port is really absent please use the 'i8042.noaux' option.\n");
@@ -712,31 +720,34 @@
 
 	i8042_initial_ctr = i8042_ctr;
 
+	if (~i8042_initial_ctr & I8042_CTR_KBDDIS) {
 /*
- * Disable the keyboard interface and interrupt.
+ * Disable the keyboard interface and interrupt. Note that we only try
+ * initializing keyboard port if it was enabled by the BIOS, otherwise
+ * some chipsets get upset and interfere with reboot process.
  */
 
-	i8042_ctr |= I8042_CTR_KBDDIS;
-	i8042_ctr &= ~I8042_CTR_KBDINT;
+		i8042_ctr |= I8042_CTR_KBDDIS;
+		i8042_ctr &= ~I8042_CTR_KBDINT;
 
 /*
  * Handle keylock.
  */
 
-	if (~i8042_read_status() & I8042_STR_KEYLOCK) {
-		if (i8042_unlock)
-			i8042_ctr |= I8042_CTR_IGNKEYLOCK;
-		 else
-			printk(KERN_WARNING "i8042.c: Warning: Keylock active.\n");
-	}
+		if (~i8042_read_status() & I8042_STR_KEYLOCK) {
+			if (i8042_unlock)
+				i8042_ctr |= I8042_CTR_IGNKEYLOCK;
+			 else
+				printk(KERN_WARNING "i8042.c: Warning: Keylock active.\n");
+		}
 
 /*
  * If the chip is configured into nontranslated mode by the BIOS, don't
  * bother enabling translating and be happy.
  */
 
-	if (~i8042_ctr & I8042_CTR_XLATE)
-		i8042_direct = 1;
+		if (~i8042_ctr & I8042_CTR_XLATE)
+			i8042_direct = 1;
 
 /*
  * Set nontranslated mode for the kbd interface if requested by an option.
@@ -745,18 +756,19 @@
  * BIOSes.
  */
 
-	if (i8042_direct) {
-		i8042_ctr &= ~I8042_CTR_XLATE;
-		i8042_kbd_port.type = SERIO_8042;
-	}
+		if (i8042_direct) {
+			i8042_ctr &= ~I8042_CTR_XLATE;
+			i8042_kbd_port.type = SERIO_8042;
+		}
 
 /*
  * Write CTR back.
  */
 
-	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
-		printk(KERN_ERR "i8042.c: Can't write CTR while initializing i8042.\n");
-		return -1;
+		if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
+			printk(KERN_ERR "i8042.c: Can't write CTR while initializing i8042.\n");
+			return -1;
+		}
 	}
 
 	return 0;
@@ -772,17 +784,21 @@
 		unsigned char param;
 
 		if (i8042_command(&param, I8042_CMD_CTL_TEST))
-			printk(KERN_ERR "i8042.c: i8042 controller reset timeout.\n");
+			printk(KERN_WARNING "i8042.c: i8042 controller reset timeout.\n");
 	}
 
 /*
  * Restore the original control register setting.
  */
 
-	i8042_ctr = i8042_initial_ctr;
-
-	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR))
-		printk(KERN_WARNING "i8042.c: Can't restore CTR.\n");
+	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_RCTR))
+		printk(KERN_WARNING "i8042.c: Can't read CTR while resetting i8042.\n");
+	else
+		if (i8042_ctr != i8042_initial_ctr) {
+			i8042_ctr = i8042_initial_ctr;
+			if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR))
+				printk(KERN_WARNING "i8042.c: Can't restore CTR.\n");
+		}
 }
 
 
@@ -974,7 +990,8 @@
 			i8042_port_register(&i8042_aux_values, &i8042_aux_port);
 	}
 
-	i8042_port_register(&i8042_kbd_values, &i8042_kbd_port);
+	if (~i8042_initial_ctr & I8042_CTR_KBDDIS)
+		i8042_port_register(&i8042_kbd_values, &i8042_kbd_port);
 
 	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
 
