Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262896AbUEKL0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbUEKL0E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 07:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUEKLZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 07:25:59 -0400
Received: from smtpq3.home.nl ([213.51.128.198]:50887 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S262896AbUEKLZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 07:25:50 -0400
Message-ID: <40A0B7DA.9090905@keyaccess.nl>
Date: Tue, 11 May 2004 13:24:10 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040117
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: B.Zolnierkiewicz@elka.pw.edu.pl, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
References: <409F4944.4090501@keyaccess.nl>	<200405102125.51947.bzolnier@elka.pw.edu.pl>	<409FF068.30902@keyaccess.nl>	<200405102352.24091.bzolnier@elka.pw.edu.pl>	<20040510215626.6a5552f2.akpm@osdl.org> <20040510221729.3b8e93da.akpm@osdl.org>
In-Reply-To: <20040510221729.3b8e93da.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------020508090905090200030103"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020508090905090200030103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

>>It's a bit grubby, but we could easily add a fourth state to
>> `system_state': split SYSTEM_SHUTDOWN into SYSTEM_REBOOT and SYSTEM_HALT. 
>> That would be a quite simple change.
> 
> Like this.  I checked all the SYSTEM_FOO users and none of them seem to
> care about the shutdown state at present.  Easy.

Wonderful. Placed the following quick hack on top:

[drivers/ide/ide-disk.c]

@@ -1704,10 +1704,11 @@

  static void ide_device_shutdown(struct device *dev)
  {
-       ide_drive_t *drive = container_of(dev, ide_drive_t, gendev);
-
-       printk("Shutdown: %s\n", drive->name);
-       dev->bus->suspend(dev, PM_SUSPEND_STANDBY);
+       if (system_state != SYSTEM_RESTART) {
+               ide_drive_t *drive = container_of(dev, ide_drive_t, gendev);
+               printk("Shutdown: %s\n", drive->name);
+               dev->bus->suspend(dev, PM_SUSPEND_STANDBY);
+       }
  }

  /*

Seems very wrong there; will likely want to be pushed up a few levels, 
but... Works For Me.

Have attached a patch of what I'm currently using against 2.6.6 just in 
case anyone interested lost track. It's bart+morton+hack.

Rene.

--------------020508090905090200030103
Content-Type: text/plain;
 name="linux-2.6.6_rollup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.6_rollup.diff"

diff -urN linux-2.6.6.orig/drivers/ide/ide-disk.c linux-2.6.6/drivers/ide/ide-disk.c
--- linux-2.6.6.orig/drivers/ide/ide-disk.c	2004-05-11 12:40:53.000000000 +0200
+++ linux-2.6.6/drivers/ide/ide-disk.c	2004-05-11 12:09:30.000000000 +0200
@@ -1704,10 +1704,11 @@
 
 static void ide_device_shutdown(struct device *dev)
 {
-	ide_drive_t *drive = container_of(dev, ide_drive_t, gendev);
-
-	printk("Shutdown: %s\n", drive->name);
-	dev->bus->suspend(dev, PM_SUSPEND_STANDBY);
+	if (system_state != SYSTEM_RESTART) {
+		ide_drive_t *drive = container_of(dev, ide_drive_t, gendev);
+		printk("Shutdown: %s\n", drive->name);
+		dev->bus->suspend(dev, PM_SUSPEND_STANDBY);
+	}
 }
 
 /*
@@ -1758,6 +1759,8 @@
 		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
 			drive->doorlocking = 0;
 	}
+	if (drive->usage != 1 || !drive->removable)
+		return 0;
 	drive->wcache = 0;
 	/* Cache enabled? */
 	if (drive->id->csfo & 1)
diff -urN linux-2.6.6.orig/include/linux/kernel.h linux-2.6.6/include/linux/kernel.h
--- linux-2.6.6.orig/include/linux/kernel.h	2004-05-10 09:31:47.000000000 +0200
+++ linux-2.6.6/include/linux/kernel.h	2004-05-11 11:18:09.000000000 +0200
@@ -109,14 +109,17 @@
 extern void bust_spinlocks(int yes);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
 extern int panic_on_oops;
-extern int system_state;		/* See values below */
 extern int tainted;
 extern const char *print_tainted(void);
 
 /* Values used for system_state */
-#define SYSTEM_BOOTING 0
-#define SYSTEM_RUNNING 1
-#define SYSTEM_SHUTDOWN 2
+extern enum system_states {
+	SYSTEM_BOOTING,
+	SYSTEM_RUNNING,
+	SYSTEM_HALT,
+	SYSTEM_POWER_OFF,
+	SYSTEM_RESTART,
+} system_state;
 
 #define TAINT_PROPRIETARY_MODULE	(1<<0)
 #define TAINT_FORCED_MODULE		(1<<1)
diff -urN linux-2.6.6.orig/init/main.c linux-2.6.6/init/main.c
--- linux-2.6.6.orig/init/main.c	2004-05-10 09:31:47.000000000 +0200
+++ linux-2.6.6/init/main.c	2004-05-11 11:18:09.000000000 +0200
@@ -95,7 +95,8 @@
 extern void tc_init(void);
 #endif
 
-int system_state;	/* SYSTEM_BOOTING/RUNNING/SHUTDOWN */
+enum system_states system_state;
+EXPORT_SYMBOL(system_state);
 
 /*
  * Boot command-line arguments
diff -urN linux-2.6.6.orig/kernel/sys.c linux-2.6.6/kernel/sys.c
--- linux-2.6.6.orig/kernel/sys.c	2004-05-10 09:31:47.000000000 +0200
+++ linux-2.6.6/kernel/sys.c	2004-05-11 11:18:09.000000000 +0200
@@ -447,7 +447,7 @@
 	switch (cmd) {
 	case LINUX_REBOOT_CMD_RESTART:
 		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
-		system_state = SYSTEM_SHUTDOWN;
+		system_state = SYSTEM_RESTART;
 		device_shutdown();
 		printk(KERN_EMERG "Restarting system.\n");
 		machine_restart(NULL);
@@ -463,7 +463,7 @@
 
 	case LINUX_REBOOT_CMD_HALT:
 		notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
-		system_state = SYSTEM_SHUTDOWN;
+		system_state = SYSTEM_HALT;
 		device_shutdown();
 		printk(KERN_EMERG "System halted.\n");
 		machine_halt();
@@ -473,7 +473,7 @@
 
 	case LINUX_REBOOT_CMD_POWER_OFF:
 		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
-		system_state = SYSTEM_SHUTDOWN;
+		system_state = SYSTEM_POWER_OFF;
 		device_shutdown();
 		printk(KERN_EMERG "Power down.\n");
 		machine_power_off();
@@ -489,7 +489,7 @@
 		buffer[sizeof(buffer) - 1] = '\0';
 
 		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, buffer);
-		system_state = SYSTEM_SHUTDOWN;
+		system_state = SYSTEM_RESTART;
 		device_shutdown();
 		printk(KERN_EMERG "Restarting system with command '%s'.\n", buffer);
 		machine_restart(buffer);

--------------020508090905090200030103--
