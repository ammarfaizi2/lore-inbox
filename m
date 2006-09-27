Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965366AbWI0GEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965366AbWI0GEF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 02:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965370AbWI0GDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 02:03:47 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:50661 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965367AbWI0GDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 02:03:34 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 1/5] swsusp: Use partition device and offset to identify swap areas
Date: Wed, 27 Sep 2006 07:26:07 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>
References: <200609270720.28131.rjw@sisk.pl>
In-Reply-To: <200609270720.28131.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200609270726.07799.rjw@sisk.pl>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux kernel handles swap files almost in the same way as it handles swap
partitions and there are only two differences between these two types of swap
areas:
(1) swap files need not be contiguous,
(2) the header of a swap file is not in the first block of the partition that
holds it.  From the swsusp's point of view (1) is not a problem, because it is
already taken care of by the swap-handling code, but (2) has to be taken into
consideration.

In principle the location of a swap file's header may be determined with the
help of appropriate filesystem driver.  Unfortunately, however, it requires the
filesystem holding the swap file to be mounted, and if this filesystem is
journaled, it cannot be mounted during a resume from disk.  For this reason
we need some other means by which swap areas can be identified.

For example, to identify a swap area we can use the partition that holds the
area and the offset from the beginning of this partition at which the swap
header is located.

The following patch allows swsusp to identify swap areas this way.  It changes
swap_type_of() so that it takes an additional argument representing an offset
of the swap header within the partition represented by its first argument.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 include/linux/swap.h |    2 +-
 kernel/power/swap.c  |    2 +-
 kernel/power/user.c  |    5 +++--
 mm/swapfile.c        |   38 ++++++++++++++++++++++++++------------
 4 files changed, 31 insertions(+), 16 deletions(-)

Index: linux-2.6.18-mm1/mm/swapfile.c
===================================================================
--- linux-2.6.18-mm1.orig/mm/swapfile.c
+++ linux-2.6.18-mm1/mm/swapfile.c
@@ -427,34 +427,48 @@ void free_swap_and_cache(swp_entry_t ent
 
 #ifdef CONFIG_SOFTWARE_SUSPEND
 /*
- * Find the swap type that corresponds to given device (if any)
+ * Find the swap type that corresponds to given device (if any).
  *
- * This is needed for software suspend and is done in such a way that inode
- * aliasing is allowed.
+ * @offset - number of the PAGE_SIZE-sized block of the device, starting
+ * from 0, in which the swap header is expected to be located.
+ *
+ * This is needed for the suspend to disk (aka swsusp).
  */
-int swap_type_of(dev_t device)
+int swap_type_of(dev_t device, sector_t offset)
 {
+	struct block_device *bdev = NULL;
 	int i;
 
+	if (device)
+		bdev = bdget(device);
+
 	spin_lock(&swap_lock);
 	for (i = 0; i < nr_swapfiles; i++) {
-		struct inode *inode;
+		struct swap_info_struct *sis = swap_info + i;
 
-		if (!(swap_info[i].flags & SWP_WRITEOK))
+		if (!(sis->flags & SWP_WRITEOK))
 			continue;
 
-		if (!device) {
+		if (!bdev) {
 			spin_unlock(&swap_lock);
 			return i;
 		}
-		inode = swap_info[i].swap_file->f_dentry->d_inode;
-		if (S_ISBLK(inode->i_mode) &&
-		    device == MKDEV(imajor(inode), iminor(inode))) {
-			spin_unlock(&swap_lock);
-			return i;
+		if (bdev == sis->bdev) {
+			struct swap_extent *se;
+
+			se = list_entry(sis->extent_list.next,
+					struct swap_extent, list);
+			if (se->start_block == offset) {
+				spin_unlock(&swap_lock);
+				bdput(bdev);
+				return i;
+			}
 		}
 	}
 	spin_unlock(&swap_lock);
+	if (bdev)
+		bdput(bdev);
+
 	return -ENODEV;
 }
 
Index: linux-2.6.18-mm1/include/linux/swap.h
===================================================================
--- linux-2.6.18-mm1.orig/include/linux/swap.h
+++ linux-2.6.18-mm1/include/linux/swap.h
@@ -249,7 +249,7 @@ extern int swap_duplicate(swp_entry_t);
 extern int valid_swaphandles(swp_entry_t, unsigned long *);
 extern void swap_free(swp_entry_t);
 extern void free_swap_and_cache(swp_entry_t);
-extern int swap_type_of(dev_t);
+extern int swap_type_of(dev_t, sector_t);
 extern unsigned int count_swap_pages(int, int);
 extern sector_t map_swap_page(struct swap_info_struct *, pgoff_t);
 extern struct swap_info_struct *get_swap_info_struct(unsigned);
Index: linux-2.6.18-mm1/kernel/power/swap.c
===================================================================
--- linux-2.6.18-mm1.orig/kernel/power/swap.c
+++ linux-2.6.18-mm1/kernel/power/swap.c
@@ -74,7 +74,7 @@ static int mark_swapfiles(swp_entry_t st
 
 static int swsusp_swap_check(void) /* This is called before saving image */
 {
-	int res = swap_type_of(swsusp_resume_device);
+	int res = swap_type_of(swsusp_resume_device, 0);
 
 	if (res >= 0) {
 		root_swap = res;
Index: linux-2.6.18-mm1/kernel/power/user.c
===================================================================
--- linux-2.6.18-mm1.orig/kernel/power/user.c
+++ linux-2.6.18-mm1/kernel/power/user.c
@@ -54,7 +54,8 @@ static int snapshot_open(struct inode *i
 	filp->private_data = data;
 	memset(&data->handle, 0, sizeof(struct snapshot_handle));
 	if ((filp->f_flags & O_ACCMODE) == O_RDONLY) {
-		data->swap = swsusp_resume_device ? swap_type_of(swsusp_resume_device) : -1;
+		data->swap = swsusp_resume_device ?
+				swap_type_of(swsusp_resume_device, 0) : -1;
 		data->mode = O_RDONLY;
 	} else {
 		data->swap = -1;
@@ -264,7 +265,7 @@ static int snapshot_ioctl(struct inode *
 			 * so we need to recode them
 			 */
 			if (old_decode_dev(arg)) {
-				data->swap = swap_type_of(old_decode_dev(arg));
+				data->swap = swap_type_of(old_decode_dev(arg), 0);
 				if (data->swap < 0)
 					error = -ENODEV;
 			} else {

