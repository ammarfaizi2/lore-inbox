Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbVLOWoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbVLOWoI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbVLOWnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:43:46 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:19079 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751164AbVLOWno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:43:44 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH -mm 2/2] Additional function in swapfile.c (needed for swap suspend)
Date: Thu, 15 Dec 2005 23:41:37 +0100
User-Agent: KMail/1.9
Cc: Pavel Machek <pavel@suse.cz>
References: <200512152329.08537.rjw@sisk.pl>
In-Reply-To: <200512152329.08537.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200512152341.37617.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the modification that can be made to swsusp once the
function defined in the previous patch has been introduced.


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/swsusp.c |   84 +++++++++++---------------------------------------
 1 files changed, 19 insertions(+), 65 deletions(-)

Index: linux-2.6.15-rc5-mm3/kernel/power/swsusp.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/kernel/power/swsusp.c	2005-12-15 22:49:49.000000000 +0100
+++ linux-2.6.15-rc5-mm3/kernel/power/swsusp.c	2005-12-15 22:50:01.000000000 +0100
@@ -104,13 +104,7 @@
  * Saving part...
  */
 
-/* We memorize in swapfile_used what swap devices are used for suspension */
-#define SWAPFILE_UNUSED    0
-#define SWAPFILE_SUSPEND   1	/* This is the suspending device */
-#define SWAPFILE_IGNORED   2	/* Those are other swap devices ignored for suspension */
-
-static unsigned short swapfile_used[MAX_SWAPFILES];
-static unsigned short root_swap;
+static unsigned short root_swap = 0xffff;
 
 static int mark_swapfiles(swp_entry_t prev)
 {
@@ -146,7 +140,7 @@
  * devfs, since the resume code can only recognize the form /dev/hda4,
  * but the suspend code would see the long name.)
  */
-static int is_resume_device(const struct swap_info_struct *swap_info)
+static inline int is_resume_device(const struct swap_info_struct *swap_info)
 {
 	struct file *file = swap_info->swap_file;
 	struct inode *inode = file->f_dentry->d_inode;
@@ -157,54 +151,22 @@
 
 static int swsusp_swap_check(void) /* This is called before saving image */
 {
-	int i, len;
-
-	len=strlen(resume_file);
-	root_swap = 0xFFFF;
-
-	spin_lock(&swap_lock);
-	for (i=0; i<MAX_SWAPFILES; i++) {
-		if (!(swap_info[i].flags & SWP_WRITEOK)) {
-			swapfile_used[i]=SWAPFILE_UNUSED;
-		} else {
-			if (!len) {
-	    			printk(KERN_WARNING "resume= option should be used to set suspend device" );
-				if (root_swap == 0xFFFF) {
-					swapfile_used[i] = SWAPFILE_SUSPEND;
-					root_swap = i;
-				} else
-					swapfile_used[i] = SWAPFILE_IGNORED;
-			} else {
-	  			/* we ignore all swap devices that are not the resume_file */
-				if (is_resume_device(&swap_info[i])) {
-					swapfile_used[i] = SWAPFILE_SUSPEND;
-					root_swap = i;
-				} else {
-				  	swapfile_used[i] = SWAPFILE_IGNORED;
-				}
-			}
-		}
-	}
-	spin_unlock(&swap_lock);
-	return (root_swap != 0xffff) ? 0 : -ENODEV;
-}
-
-/**
- * This is called after saving image so modification
- * will be lost after resume... and that's what we want.
- * we make the device unusable. A new call to
- * lock_swapdevices can unlock the devices.
- */
-static void lock_swapdevices(void)
-{
 	int i;
 
+	if (!swsusp_resume_device)
+		return -ENODEV;
 	spin_lock(&swap_lock);
-	for (i = 0; i< MAX_SWAPFILES; i++)
-		if (swapfile_used[i] == SWAPFILE_IGNORED) {
-			swap_info[i].flags ^= SWP_WRITEOK;
+	for (i = 0; i < MAX_SWAPFILES; i++) {
+		if (!(swap_info[i].flags & SWP_WRITEOK))
+			continue;
+		if (is_resume_device(swap_info + i)) {
+			spin_unlock(&swap_lock);
+			root_swap = i;
+			return 0;
 		}
+	}
 	spin_unlock(&swap_lock);
+	return -ENODEV;
 }
 
 /**
@@ -222,19 +184,14 @@
 static int write_page(unsigned long addr, swp_entry_t *loc)
 {
 	swp_entry_t entry;
-	int error = 0;
+	int error = -ENOSPC;
 
-	entry = get_swap_page();
-	if (swp_offset(entry) &&
-	    swapfile_used[swp_type(entry)] == SWAPFILE_SUSPEND) {
-		error = rw_swap_page_sync(WRITE, entry,
-					  virt_to_page(addr));
-		if (error == -EIO)
-			error = 0;
-		if (!error)
+	entry = get_swap_page_of_type(root_swap);
+	if (swp_offset(entry)) {
+		error = rw_swap_page_sync(WRITE, entry, virt_to_page(addr));
+		if (!error || error == -EIO)
 			*loc = entry;
-	} else
-		error = -ENOSPC;
+	}
 	return error;
 }
 
@@ -614,10 +571,7 @@
 		printk(KERN_ERR "swsusp: cannot find swap device, try swapon -a.\n");
 		return error;
 	}
-	lock_swapdevices();
 	error = write_suspend_image(pblist, nr_pages);
-	/* This will unlock ignored swap devices since writing is finished */
-	lock_swapdevices();
 	return error;
 }
 

