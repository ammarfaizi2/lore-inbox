Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbVL0RJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbVL0RJU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 12:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbVL0RI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 12:08:56 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:63675 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751124AbVL0RIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 12:08:54 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 2/3] swsusp: improve handling of swap partitions
Date: Tue, 27 Dec 2005 17:57:32 +0100
User-Agent: KMail/1.9
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
References: <200512271747.43374.rjw@sisk.pl>
In-Reply-To: <200512271747.43374.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512271757.33362.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the handling of swap partitions by swsusp to avoid
locking of the swap devices that are not used for suspend and, consequently,
simplifies the code.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/swsusp.c |  128 ++++++++++++++------------------------------------
 1 files changed, 36 insertions(+), 92 deletions(-)

Index: linux-2.6.15-rc5-mm3/kernel/power/swsusp.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/kernel/power/swsusp.c	2005-12-15 23:00:12.000000000 +0100
+++ linux-2.6.15-rc5-mm3/kernel/power/swsusp.c	2005-12-16 23:15:14.000000000 +0100
@@ -104,13 +104,7 @@ static struct swsusp_info swsusp_info;
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
@@ -146,7 +140,7 @@ static int mark_swapfiles(swp_entry_t pr
  * devfs, since the resume code can only recognize the form /dev/hda4,
  * but the suspend code would see the long name.)
  */
-static int is_resume_device(const struct swap_info_struct *swap_info)
+static inline int is_resume_device(const struct swap_info_struct *swap_info)
 {
 	struct file *file = swap_info->swap_file;
 	struct inode *inode = file->f_dentry->d_inode;
@@ -157,54 +151,22 @@ static int is_resume_device(const struct
 
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
@@ -222,19 +184,14 @@ static void lock_swapdevices(void)
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
 
@@ -539,31 +496,38 @@ static int save_image_metadata(struct pb
  *	enough_swap - Make sure we have enough swap to save the image.
  *
  *	Returns TRUE or FALSE after checking the total amount of swap
- *	space avaiable.
- *
- *	FIXME: si_swapinfo(&i) returns all swap devices information.
- *	We should only consider resume_device.
+ *	space avaiable from the resume partition.
  */
 
 static int enough_swap(unsigned int nr_pages)
 {
-	struct sysinfo i;
+	unsigned int free_swap = swap_info[root_swap].pages -
+		swap_info[root_swap].inuse_pages;
 
-	si_swapinfo(&i);
-	pr_debug("swsusp: available swap: %lu pages\n", i.freeswap);
-	return i.freeswap > (nr_pages + PAGES_FOR_IO +
+	pr_debug("swsusp: free swap pages: %u\n", free_swap);
+	return free_swap > (nr_pages + PAGES_FOR_IO +
 		(nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE);
 }
 
 /**
- *	write_suspend_image - Write entire image and metadata.
+ *	swsusp_write - Write entire image and metadata.
+ *
+ *	It is important _NOT_ to umount filesystems at this point. We want
+ *	them synced (in case something goes wrong) but we DO not want to mark
+ *	filesystem clean: it is not. (And it does not matter, if we resume
+ *	correctly, we'll mark system clean, anyway.)
  */
-static int write_suspend_image(struct pbe *pblist, unsigned int nr_pages)
+
+int swsusp_write(struct pbe *pblist, unsigned int nr_pages)
 {
 	struct swap_map_page *swap_map;
 	struct swap_map_handle handle;
 	int error;
 
+	if ((error = swsusp_swap_check())) {
+		printk(KERN_ERR "swsusp: Cannot find swap device, try swapon -a.\n");
+		return error;
+	}
 	if (!enough_swap(nr_pages)) {
 		printk(KERN_ERR "swsusp: Not enough free swap\n");
 		return -ENOSPC;
@@ -601,26 +565,6 @@ Free_image_entries:
 	goto Free_swap_map;
 }
 
-/* It is important _NOT_ to umount filesystems at this point. We want
- * them synced (in case something goes wrong) but we DO not want to mark
- * filesystem clean: it is not. (And it does not matter, if we resume
- * correctly, we'll mark system clean, anyway.)
- */
-int swsusp_write(struct pbe *pblist, unsigned int nr_pages)
-{
-	int error;
-
-	if ((error = swsusp_swap_check())) {
-		printk(KERN_ERR "swsusp: cannot find swap device, try swapon -a.\n");
-		return error;
-	}
-	lock_swapdevices();
-	error = write_suspend_image(pblist, nr_pages);
-	/* This will unlock ignored swap devices since writing is finished */
-	lock_swapdevices();
-	return error;
-}
-
 /**
  *	swsusp_shrink_memory -  Try to free as much memory as needed
  *

