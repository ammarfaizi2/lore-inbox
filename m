Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263640AbUGQXab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbUGQXab (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 19:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbUGQWoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 18:44:11 -0400
Received: from digitalimplant.org ([64.62.235.95]:51177 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262873AbUGQWgA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:36:00 -0400
Date: Sat, 17 Jul 2004 15:35:52 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz
Subject: [19/25] Merge pmdisk and swsusp
Message-ID: <Pine.LNX.4.50.0407171531460.22290-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.1861, 2004/07/17 13:21:29-07:00, mochel@digitalimplant.org

[Power Mgmt] Merge pmdisk and swsusp write wrappers.

- Merge suspend_save_image() from both into one.
- Rename to swsusp_write().
- Remove pmdisk_write().
- Fixup call in kernel/power/disk.c and software_suspend().
- Mark lock_swapdevices() static again.


 kernel/power/disk.c   |    4 ++--
 kernel/power/pmdisk.c |   43 -------------------------------------------
 kernel/power/swsusp.c |   28 +++++++++++++++-------------
 3 files changed, 17 insertions(+), 58 deletions(-)


diff -Nru a/kernel/power/disk.c b/kernel/power/disk.c
--- a/kernel/power/disk.c	2004-07-17 14:50:46 -07:00
+++ b/kernel/power/disk.c	2004-07-17 14:50:46 -07:00
@@ -24,7 +24,7 @@
 extern struct pm_ops * pm_ops;

 extern int swsusp_suspend(void);
-extern int pmdisk_write(void);
+extern int swsusp_write(void);
 extern int swsusp_read(void);
 extern int swsusp_resume(void);
 extern int pmdisk_free(void);
@@ -173,7 +173,7 @@
 		mb();
 		barrier();

-		error = pmdisk_write();
+		error = swsusp_write();
 		if (!error) {
 			error = power_down(pm_disk_mode);
 			pr_debug("PM: Power down failed.\n");
diff -Nru a/kernel/power/pmdisk.c b/kernel/power/pmdisk.c
--- a/kernel/power/pmdisk.c	2004-07-17 14:50:46 -07:00
+++ b/kernel/power/pmdisk.c	2004-07-17 14:50:46 -07:00
@@ -42,49 +42,6 @@
  */


-extern void swsusp_swap_lock(void);
-
-/**
- *	suspend_save_image - Prepare and write saved image to swap.
- *
- *	IRQs are re-enabled here so we can resume devices and safely write
- *	to the swap devices. We disable them again before we leave.
- *
- *	The second swsusp_swap_lock() will unlock ignored swap devices since
- *	writing is finished.
- *	It is important _NOT_ to umount filesystems at this point. We want
- *	them synced (in case something goes wrong) but we DO not want to mark
- *	filesystem clean: it is not. (And it does not matter, if we resume
- *	correctly, we'll mark system clean, anyway.)
- */
-
-static int suspend_save_image(void)
-{
-	extern int write_suspend_image(void);
-	int error;
-	device_resume();
-	swsusp_swap_lock();
-	error = write_suspend_image();
-	swsusp_swap_lock();
-	return error;
-}
-
-
-/**
- *	pmdisk_write - Write saved memory image to swap.
- *
- *	pmdisk_arch_suspend(0) returns after system is resumed.
- *
- *	pmdisk_arch_suspend() copies all "used" memory to "free" memory,
- *	then unsuspends all device drivers, and writes memory to disk
- *	using normal kernel mechanism.
- */
-
-int pmdisk_write(void)
-{
-	return suspend_save_image();
-}
-
 /**
  *	pmdisk_free - Free memory allocated to hold snapshot.
  */
diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2004-07-17 14:50:46 -07:00
+++ b/kernel/power/swsusp.c	2004-07-17 14:50:46 -07:00
@@ -246,7 +246,7 @@
  * we make the device unusable. A new call to
  * lock_swapdevices can unlock the devices.
  */
-void swsusp_swap_lock(void)
+static void lock_swapdevices(void)
 {
 	int i;

@@ -439,7 +439,7 @@
  *
  */

-int write_suspend_image(void)
+static int write_suspend_image(void)
 {
 	int error;

@@ -862,20 +862,22 @@
 	return 0;
 }

-static void suspend_save_image(void)
+
+/* It is important _NOT_ to umount filesystems at this point. We want
+ * them synced (in case something goes wrong) but we DO not want to mark
+ * filesystem clean: it is not. (And it does not matter, if we resume
+ * correctly, we'll mark system clean, anyway.)
+ */
+int swsusp_write(void)
 {
+	int error;
 	device_resume();
-
-	swsusp_swap_lock();
-	write_suspend_image();
+	lock_swapdevices();
+	error = write_suspend_image();
 	/* This will unlock ignored swap devices since writing is finished */
-	swsusp_swap_lock();
+	lock_swapdevices();
+	return error;

-	/* It is important _NOT_ to umount filesystems at this point. We want
-	 * them synced (in case something goes wrong) but we DO not want to mark
-	 * filesystem clean: it is not. (And it does not matter, if we resume
-	 * correctly, we'll mark system clean, anyway.)
-	 */
 }

 static void suspend_power_down(void)
@@ -1011,7 +1013,7 @@
 			res = swsusp_save();

 			if (!res && in_suspend) {
-				suspend_save_image();
+				swsusp_write();
 				suspend_power_down();
 			}
 			in_suspend = 0;
