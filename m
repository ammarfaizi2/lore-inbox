Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270632AbTGZWi7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 18:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270639AbTGZWi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 18:38:58 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:8336 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S270632AbTGZWil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 18:38:41 -0400
Date: Sun, 27 Jul 2003 00:53:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: [PM] Fix up wrong comments
Message-ID: <20030726225344.GA510@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes add wrong comments, and adds comment about pitfalls of
calling BIOS.

Index: linux/drivers/input/power.c
===================================================================
--- linux.orig/drivers/input/power.c	2003-07-22 13:39:42.000000000 +0200
+++ linux/drivers/input/power.c	2003-07-20 14:35:05.000000000 +0200
@@ -45,9 +45,7 @@
 static int suspend_button_pushed = 0;
 static void suspend_button_task_handler(void *data)
 {
-        //extern void pm_do_suspend(void);
         udelay(200); /* debounce */
-        //pm_do_suspend();
         suspend_button_pushed = 0;
 }
 
@@ -67,8 +65,6 @@
 			case KEY_SUSPEND:
 				printk("Powering down entire device\n");
 
-				//pm_send_all(PM_SUSPEND, dev);
-
 				if (!suspend_button_pushed) {
                 			suspend_button_pushed = 1;
                         		schedule_work(&suspend_button_task);
Index: linux/drivers/acpi/sleep/main.c
===================================================================
--- linux.orig/drivers/acpi/sleep/main.c	2003-07-22 13:39:42.000000000 +0200
+++ linux/drivers/acpi/sleep/main.c	2003-07-22 12:53:27.000000000 +0200
@@ -69,10 +81,6 @@
  * First, we call to the device driver layer to save device state.
  * Once we have that, we save whatevery processor and kernel state we
  * need to memory.
- * If we're entering S4, we then write the memory image to disk.
- *
- * Only then is it safe for us to power down devices, since we may need
- * the disks and upstream buses to write to.
  */
 acpi_status
 acpi_system_save_state(
Index: linux/include/linux/reboot.h
===================================================================
--- linux.orig/include/linux/reboot.h	2003-07-22 13:39:42.000000000 +0200
+++ linux/include/linux/reboot.h	2003-07-17 22:22:58.000000000 +0200
@@ -21,7 +21,7 @@
  * CAD_OFF     Ctrl-Alt-Del sequence sends SIGINT to init task.
  * POWER_OFF   Stop OS and remove all power from system, if possible.
  * RESTART2    Restart system using given command string.
- * SW_SUSPEND  Suspend system using Software Suspend if compiled in
+ * SW_SUSPEND  Suspend system using software suspend if compiled in.
  */
 
 #define	LINUX_REBOOT_CMD_RESTART	0x01234567
Index: linux/arch/i386/kernel/acpi/wakeup.S
===================================================================
--- linux.orig/arch/i386/kernel/acpi/wakeup.S	2003-07-22 13:39:42.000000000 +0200
+++ linux/arch/i386/kernel/acpi/wakeup.S	2003-07-22 13:26:01.000000000 +0200
@@ -43,6 +43,11 @@
 
 	testl	$1, video_flags - wakeup_code
 	jz	1f
+	/* It is miracle that this works:
+	   * PCI may or may not be initialized at this point
+	   * I'm told we should pass device ID to video bios
+	   However it works on some real machines...
+	 */
 	lcall   $0xc000,$3
 	movw	%cs, %ax
 	movw	%ax, %ds					# Bios might have played with that

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
