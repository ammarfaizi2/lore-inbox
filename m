Return-Path: <linux-kernel-owner+w=401wt.eu-S1754987AbXABWL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754987AbXABWL1 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 17:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754998AbXABWL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 17:11:27 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:58316 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754987AbXABWLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 17:11:25 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][Fix] swsusp: Do not fail if resume device is not set
Date: Tue, 2 Jan 2007 23:12:48 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701022312.49215.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the kernels later than 2.6.19 there is a regression that makes swsusp fail
if the resume device is not explicitly specified.

It can be fixed by adding an additional parameter to
mm/swapfile.c:swap_type_of() allowing us to pass the (struct block_device *)
corresponding to the first available swap back to the caller.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 include/linux/swap.h |    2 +-
 kernel/power/swap.c  |    9 +++++----
 kernel/power/user.c  |    7 ++++---
 mm/swapfile.c        |    8 +++++++-
 4 files changed, 17 insertions(+), 9 deletions(-)

Index: linux-2.6.20-rc3/include/linux/swap.h
===================================================================
--- linux-2.6.20-rc3.orig/include/linux/swap.h
+++ linux-2.6.20-rc3/include/linux/swap.h
@@ -245,7 +245,7 @@ extern int swap_duplicate(swp_entry_t);
 extern int valid_swaphandles(swp_entry_t, unsigned long *);
 extern void swap_free(swp_entry_t);
 extern void free_swap_and_cache(swp_entry_t);
-extern int swap_type_of(dev_t, sector_t);
+extern int swap_type_of(dev_t, sector_t, struct block_device **);
 extern unsigned int count_swap_pages(int, int);
 extern sector_t map_swap_page(struct swap_info_struct *, pgoff_t);
 extern sector_t swapdev_block(int, pgoff_t);
Index: linux-2.6.20-rc3/kernel/power/swap.c
===================================================================
--- linux-2.6.20-rc3.orig/kernel/power/swap.c
+++ linux-2.6.20-rc3/kernel/power/swap.c
@@ -165,14 +165,15 @@ static int swsusp_swap_check(void) /* Th
 {
 	int res;
 
-	res = swap_type_of(swsusp_resume_device, swsusp_resume_block);
+	res = swap_type_of(swsusp_resume_device, swsusp_resume_block,
+			&resume_bdev);
 	if (res < 0)
 		return res;
 
 	root_swap = res;
-	resume_bdev = open_by_devnum(swsusp_resume_device, FMODE_WRITE);
-	if (IS_ERR(resume_bdev))
-		return PTR_ERR(resume_bdev);
+	res = blkdev_get(resume_bdev, FMODE_WRITE, O_RDWR);
+	if (res)
+		return res;
 
 	res = set_blocksize(resume_bdev, PAGE_SIZE);
 	if (res < 0)
Index: linux-2.6.20-rc3/mm/swapfile.c
===================================================================
--- linux-2.6.20-rc3.orig/mm/swapfile.c
+++ linux-2.6.20-rc3/mm/swapfile.c
@@ -434,7 +434,7 @@ void free_swap_and_cache(swp_entry_t ent
  *
  * This is needed for the suspend to disk (aka swsusp).
  */
-int swap_type_of(dev_t device, sector_t offset)
+int swap_type_of(dev_t device, sector_t offset, struct block_device **bdev_p)
 {
 	struct block_device *bdev = NULL;
 	int i;
@@ -450,6 +450,9 @@ int swap_type_of(dev_t device, sector_t 
 			continue;
 
 		if (!bdev) {
+			if (bdev_p)
+				*bdev_p = sis->bdev;
+
 			spin_unlock(&swap_lock);
 			return i;
 		}
@@ -459,6 +462,9 @@ int swap_type_of(dev_t device, sector_t 
 			se = list_entry(sis->extent_list.next,
 					struct swap_extent, list);
 			if (se->start_block == offset) {
+				if (bdev_p)
+					*bdev_p = sis->bdev;
+
 				spin_unlock(&swap_lock);
 				bdput(bdev);
 				return i;
Index: linux-2.6.20-rc3/kernel/power/user.c
===================================================================
--- linux-2.6.20-rc3.orig/kernel/power/user.c
+++ linux-2.6.20-rc3/kernel/power/user.c
@@ -58,7 +58,7 @@ static int snapshot_open(struct inode *i
 	memset(&data->handle, 0, sizeof(struct snapshot_handle));
 	if ((filp->f_flags & O_ACCMODE) == O_RDONLY) {
 		data->swap = swsusp_resume_device ?
-				swap_type_of(swsusp_resume_device, 0) : -1;
+			swap_type_of(swsusp_resume_device, 0, NULL) : -1;
 		data->mode = O_RDONLY;
 	} else {
 		data->swap = -1;
@@ -327,7 +327,8 @@ static int snapshot_ioctl(struct inode *
 			 * so we need to recode them
 			 */
 			if (old_decode_dev(arg)) {
-				data->swap = swap_type_of(old_decode_dev(arg), 0);
+				data->swap = swap_type_of(old_decode_dev(arg),
+							0, NULL);
 				if (data->swap < 0)
 					error = -ENODEV;
 			} else {
@@ -427,7 +428,7 @@ static int snapshot_ioctl(struct inode *
 			swdev = old_decode_dev(swap_area.dev);
 			if (swdev) {
 				offset = swap_area.offset;
-				data->swap = swap_type_of(swdev, offset);
+				data->swap = swap_type_of(swdev, offset, NULL);
 				if (data->swap < 0)
 					error = -ENODEV;
 			} else {
