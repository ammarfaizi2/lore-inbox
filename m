Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263147AbUGQWhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbUGQWhH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 18:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbUGQWgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 18:36:23 -0400
Received: from digitalimplant.org ([64.62.235.95]:19433 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262322AbUGQWe5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:34:57 -0400
Date: Sat, 17 Jul 2004 15:34:50 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz
Subject: [3/25] Merge pmdisk and swsusp
Message-ID: <Pine.LNX.4.50.0407171527330.22290-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ChangeSet 1.1845, 2004/07/17 09:18:23-07:00, mochel@digitalimplant.org

[Power Mgmt] Remove more duplicate code from pmdisk.

- Use read_swapfiles() in swsusp and rename to swsusp_swap_check().
- Use lock_swapdevices() in swsusp and rename to swsusp_swap_lock().


 kernel/power/pmdisk.c |   64 ++++++--------------------------------------------
 kernel/power/swsusp.c |   26 ++++++++++++--------
 2 files changed, 24 insertions(+), 66 deletions(-)


diff -Nru a/kernel/power/pmdisk.c b/kernel/power/pmdisk.c
--- a/kernel/power/pmdisk.c	2004-07-17 14:51:48 -07:00
+++ b/kernel/power/pmdisk.c	2004-07-17 14:51:48 -07:00
@@ -109,8 +109,10 @@
 #define SWAPFILE_SUSPEND   1	/* This is the suspending device */
 #define SWAPFILE_IGNORED   2	/* Those are other swap devices ignored for suspension */

-static unsigned short swapfile_used[MAX_SWAPFILES];
-static unsigned short root_swap;
+extern unsigned short swapfile_used[MAX_SWAPFILES];
+extern unsigned short root_swap;
+extern int swsusp_swap_check(void);
+extern void swsusp_swap_lock(void);


 static int mark_swapfiles(swp_entry_t prev)
@@ -136,56 +138,6 @@
 	return error;
 }

-static int read_swapfiles(void) /* This is called before saving image */
-{
-	int i, len;
-
-	len=strlen(resume_file);
-	root_swap = 0xFFFF;
-
-	swap_list_lock();
-	for(i=0; i<MAX_SWAPFILES; i++) {
-		if (swap_info[i].flags == 0) {
-			swapfile_used[i]=SWAPFILE_UNUSED;
-		} else {
-			if(!len) {
-				pr_debug("pmdisk: Default resume partition not set.\n");
-				if(root_swap == 0xFFFF) {
-					swapfile_used[i] = SWAPFILE_SUSPEND;
-					root_swap = i;
-				} else
-					swapfile_used[i] = SWAPFILE_IGNORED;
-			} else {
-	  			/* we ignore all swap devices that are not the resume_file */
-				if (1) {
-// FIXME				if(resume_device == swap_info[i].swap_device) {
-					swapfile_used[i] = SWAPFILE_SUSPEND;
-					root_swap = i;
-				} else
-				  	swapfile_used[i] = SWAPFILE_IGNORED;
-			}
-		}
-	}
-	swap_list_unlock();
-	return (root_swap != 0xffff) ? 0 : -ENODEV;
-}
-
-
-/* This is called after saving image so modification
-   will be lost after resume... and that's what we want. */
-static void lock_swapdevices(void)
-{
-	int i;
-
-	swap_list_lock();
-	for(i = 0; i< MAX_SWAPFILES; i++)
-		if(swapfile_used[i] == SWAPFILE_IGNORED) {
-			swap_info[i].flags ^= 0xFF; /* we make the device unusable. A new call to
-						       lock_swapdevices can unlock the devices. */
-		}
-	swap_list_unlock();
-}
-


 /**
@@ -625,7 +577,7 @@
 {
 	int error = 0;

-	if ((error = read_swapfiles()))
+	if ((error = swsusp_swap_check()))
 		return error;

 	drain_local_pages();
@@ -681,7 +633,7 @@
  *	IRQs are re-enabled here so we can resume devices and safely write
  *	to the swap devices. We disable them again before we leave.
  *
- *	The second lock_swapdevices() will unlock ignored swap devices since
+ *	The second swsusp_swap_lock() will unlock ignored swap devices since
  *	writing is finished.
  *	It is important _NOT_ to umount filesystems at this point. We want
  *	them synced (in case something goes wrong) but we DO not want to mark
@@ -693,9 +645,9 @@
 {
 	int error;
 	device_resume();
-	lock_swapdevices();
+	swsusp_swap_lock();
 	error = write_suspend_image();
-	lock_swapdevices();
+	swsusp_swap_lock();
 	return error;
 }

diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2004-07-17 14:51:48 -07:00
+++ b/kernel/power/swsusp.c	2004-07-17 14:51:48 -07:00
@@ -180,8 +180,8 @@
 #define SWAPFILE_SUSPEND   1	/* This is the suspending device */
 #define SWAPFILE_IGNORED   2	/* Those are other swap devices ignored for suspension */

-static unsigned short swapfile_used[MAX_SWAPFILES];
-static unsigned short root_swap;
+unsigned short swapfile_used[MAX_SWAPFILES];
+unsigned short root_swap;
 #define MARK_SWAP_SUSPEND 0
 #define MARK_SWAP_RESUME 2

@@ -243,7 +243,7 @@
 		resume_device == MKDEV(imajor(inode), iminor(inode));
 }

-static void read_swapfiles(void) /* This is called before saving image */
+int swsusp_swap_check(void) /* This is called before saving image */
 {
 	int i, len;

@@ -274,18 +274,23 @@
 		}
 	}
 	swap_list_unlock();
+	return (root_swap != 0xffff) ? 0 : -ENODEV;
 }

-static void lock_swapdevices(void) /* This is called after saving image so modification
-				      will be lost after resume... and that's what we want. */
+/**
+ * This is called after saving image so modification
+ * will be lost after resume... and that's what we want.
+ * we make the device unusable. A new call to
+ * lock_swapdevices can unlock the devices.
+ */
+void swsusp_swap_lock(void)
 {
 	int i;

 	swap_list_lock();
 	for(i = 0; i< MAX_SWAPFILES; i++)
 		if(swapfile_used[i] == SWAPFILE_IGNORED) {
-			swap_info[i].flags ^= 0xFF; /* we make the device unusable. A new call to
-						       lock_swapdevices can unlock the devices. */
+			swap_info[i].flags ^= 0xFF;
 		}
 	swap_list_unlock();
 }
@@ -675,9 +680,10 @@
 {
 	device_resume();

-	lock_swapdevices();
+	swsusp_swap_lock();
 	write_suspend_image();
-	lock_swapdevices();	/* This will unlock ignored swap devices since writing is finished */
+	/* This will unlock ignored swap devices since writing is finished */
+	swsusp_swap_lock();

 	/* It is important _NOT_ to umount filesystems at this point. We want
 	 * them synced (in case something goes wrong) but we DO not want to mark
@@ -788,7 +794,7 @@
 asmlinkage void do_magic_suspend_2(void)
 {
 	int is_problem;
-	read_swapfiles();
+	swsusp_swap_check();
 	device_power_down(3);
 	is_problem = suspend_prepare_image();
 	device_power_up();
