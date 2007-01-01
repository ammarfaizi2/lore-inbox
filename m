Return-Path: <linux-kernel-owner+w=401wt.eu-S1754781AbXAAXpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781AbXAAXpj (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 18:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbXAAXpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 18:45:39 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:55260 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754781AbXAAXpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 18:45:38 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Suspend problems on 2.6.20-rc2-git1
Date: Tue, 2 Jan 2007 00:47:02 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
       Dave Jones <davej@redhat.com>
References: <459771A2.6060301@shaw.ca> <200612311427.02175.rjw@sisk.pl> <200612311724.11423.rjw@sisk.pl>
In-Reply-To: <200612311724.11423.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701020047.02918.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 31 December 2006 17:24, Rafael J. Wysocki wrote:
> On Sunday, 31 December 2006 14:27, Rafael J. Wysocki wrote:
> > On Sunday, 31 December 2006 09:15, Robert Hancock wrote:
> > > Having some suspend problems on 2.6.20-rc2-git1 with Fedora Core 6. 
> > > First of all the normal user interface for hibernate isn't working 
> > > properly while it did in 2.6.19. When you select "Hibernate" it seems to 
> > > stop X and go into console mode but somehow doesn't seem to actually 
> > > start the process of suspending. I'm not sure at what point it is failing.
> > > 
> > > Secondly, if you try and suspend manually it claims there is no swap 
> > > device available when there clearly is:
> > > 
> > > [root@localhost rob]# cat /proc/swaps
> > > Filename                                Type            Size    Used 
> > > Priority
> > > /dev/mapper/VolGroup00-LogVol01         partition       1048568 0       -1
> > > [root@localhost rob]# echo disk > /sys/power/state
> > > bash: echo: write error: No such device or address
> > 
> > Hm, at first sight it looks like something broke the suspend to swap
> > partitions located on LVM.  For now I have no idea what it was.
> 
> _Or_ something broke your initrd setup.

No, this is a kernel problem, I think.

Can you please check if the appended patch fixes the issue?

Thanks,
Rafael


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
