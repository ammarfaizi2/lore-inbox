Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291903AbSBIA3c>; Fri, 8 Feb 2002 19:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287872AbSBIA2D>; Fri, 8 Feb 2002 19:28:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42245 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291894AbSBIAZ7>;
	Fri, 8 Feb 2002 19:25:59 -0500
Message-ID: <3C646C95.3978AE16@mandrakesoft.com>
Date: Fri, 08 Feb 2002 19:25:57 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: [BK PATCH] remove swap_device from swap_info_struct
Content-Type: multipart/mixed;
 boundary="------------E7F003BB7E665B71DD08D61D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E7F003BB7E665B71DD08D61D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

 
--------------E7F003BB7E665B71DD08D61D
Content-Type: text/plain; charset=us-ascii;
 name="vm-2.5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-2.5.txt"



Pull from:  http://gkernel.bkbits.net/vm-2.5


---------------------------------------------------------------------------
ChangeSet@1.230, 2002-02-08 18:11:31-05:00, jgarzik@rum.normnet.org
  After Al Viro's recent swapfile cleanup, the swap_device member of
  swap_info_struct became pretty much superfluous.  As we are minimizing
  kdev_t usage anyway, I took the opportunity to remove swap_device
  member, and replace the remaining usages with SWP_BLOCKDEV bit flag.
  
  Adding SWP_BLOCKDEV in turn motivated a small cleanup of the
  SWP_xxx bit flags and their usage.
  
  Patch has been in light testing for a couple weeks, and
  has been glanced at by Al.  "looks sane"

 include/linux/swap.h |    9 ++++++---
 mm/swapfile.c        |   33 ++++++++++++++++++---------------
 2 files changed, 24 insertions(+), 18 deletions(-)

---------------------------------------------------------------------------


--------------E7F003BB7E665B71DD08D61D
Content-Type: text/plain; charset=us-ascii;
 name="rm-swapdev-swapinfo-2.5.4.3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rm-swapdev-swapinfo-2.5.4.3.patch"

diff -Nru a/include/linux/swap.h b/include/linux/swap.h
--- a/include/linux/swap.h	Fri Feb  8 19:10:16 2002
+++ b/include/linux/swap.h	Fri Feb  8 19:10:16 2002
@@ -50,8 +50,12 @@
 
 #include <asm/atomic.h>
 
-#define SWP_USED	1
-#define SWP_WRITEOK	3
+enum {
+	SWP_USED	= (1 << 0),	/* is slot in swap_info[] used? */
+	SWP_WRITEOK	= (1 << 1),	/* ok to write to this swap?	*/
+	SWP_BLOCKDEV	= (1 << 2),	/* is this swap a block device? */
+	SWP_ACTIVE	= (SWP_USED | SWP_WRITEOK),
+};
 
 #define SWAP_CLUSTER_MAX 32
 
@@ -63,7 +67,6 @@
  */
 struct swap_info_struct {
 	unsigned int flags;
-	kdev_t swap_device;
 	spinlock_t sdev_lock;
 	struct file *swap_file;
 	unsigned short * swap_map;
diff -Nru a/mm/swapfile.c b/mm/swapfile.c
--- a/mm/swapfile.c	Fri Feb  8 19:10:16 2002
+++ b/mm/swapfile.c	Fri Feb  8 19:10:16 2002
@@ -114,7 +114,7 @@
 
 	while (1) {
 		p = &swap_info[type];
-		if ((p->flags & SWP_WRITEOK) == SWP_WRITEOK) {
+		if ((p->flags & SWP_ACTIVE) == SWP_ACTIVE) {
 			swap_device_lock(p);
 			offset = scan_swap_map(p);
 			swap_device_unlock(p);
@@ -729,7 +729,7 @@
 	swap_list_lock();
 	for (type = swap_list.head; type >= 0; type = swap_info[type].next) {
 		p = swap_info + type;
-		if ((p->flags & SWP_WRITEOK) == SWP_WRITEOK) {
+		if ((p->flags & SWP_ACTIVE) == SWP_ACTIVE) {
 			if (p->swap_file->f_dentry == nd.dentry)
 				break;
 		}
@@ -752,7 +752,7 @@
 	}
 	nr_swap_pages -= p->pages;
 	total_swap_pages -= p->pages;
-	p->flags = SWP_USED;
+	p->flags &= ~SWP_WRITEOK;
 	swap_list_unlock();
 	unlock_kernel();
 	err = try_to_unuse(type);
@@ -770,7 +770,7 @@
 			swap_info[prev].next = p - swap_info;
 		nr_swap_pages += p->pages;
 		total_swap_pages += p->pages;
-		p->flags = SWP_WRITEOK;
+		p->flags |= SWP_WRITEOK;
 		swap_list_unlock();
 		goto out_dput;
 	}
@@ -778,7 +778,6 @@
 	swap_device_lock(p);
 	swap_file = p->swap_file;
 	p->swap_file = NULL;
-	p->swap_device = NODEV;
 	p->max = 0;
 	swap_map = p->swap_map;
 	p->swap_map = NULL;
@@ -822,7 +821,8 @@
 				}
 			len += sprintf(buf + len, "%-39s %s\t%d\t%d\t%d\n",
 				       path,
-				       !kdev_none(ptr->swap_device) ? "partition" : "file\t",
+				       (ptr->flags & SWP_BLOCKDEV) ?
+				       		"partition" : "file\t",
 				       ptr->pages << (PAGE_SHIFT - 10),
 				       usedswap << (PAGE_SHIFT - 10),
 				       ptr->prio);
@@ -837,9 +837,10 @@
 	int i;
 
 	for (i = 0 ; i < nr_swapfiles ; i++, ptr++) {
-		if (ptr->flags & SWP_USED)
-			if (kdev_same(ptr->swap_device, dev))
-				return 1;
+		if ((ptr->flags & SWP_USED) &&
+		    (ptr->flags & SWP_BLOCKDEV) &&
+		    (kdev_same(ptr->swap_file->f_dentry->d_inode->i_rdev, dev)))
+			return 1;
 	}
 	return 0;
 }
@@ -883,7 +884,6 @@
 		nr_swapfiles = type+1;
 	p->flags = SWP_USED;
 	p->swap_file = NULL;
-	p->swap_device = NODEV;
 	p->swap_map = NULL;
 	p->lowest_bit = 0;
 	p->highest_bit = 0;
@@ -911,8 +911,10 @@
 
 	error = -EINVAL;
 	if (S_ISBLK(swap_file->f_dentry->d_inode->i_mode)) {
-		p->swap_device = swap_file->f_dentry->d_inode->i_rdev;
-		set_blocksize(p->swap_device, PAGE_SIZE);
+		error = set_blocksize(swap_file->f_dentry->d_inode->i_rdev,
+				      PAGE_SIZE);
+		if (error < 0)
+			goto bad_swap;
 	} else if (!S_ISREG(swap_file->f_dentry->d_inode->i_mode))
 		goto bad_swap;
 
@@ -1035,7 +1037,9 @@
 	swap_list_lock();
 	swap_device_lock(p);
 	p->max = maxpages;
-	p->flags = SWP_WRITEOK;
+	p->flags = SWP_ACTIVE;
+	if (S_ISBLK(swap_file->f_dentry->d_inode->i_mode))
+		p->flags |= SWP_BLOCKDEV;
 	p->pages = nr_good_pages;
 	nr_swap_pages += nr_good_pages;
 	total_swap_pages += nr_good_pages;
@@ -1064,7 +1068,6 @@
 bad_swap_2:
 	swap_list_lock();
 	swap_map = p->swap_map;
-	p->swap_device = NODEV;
 	p->swap_file = NULL;
 	p->swap_map = NULL;
 	p->flags = 0;
@@ -1090,7 +1093,7 @@
 	swap_list_lock();
 	for (i = 0; i < nr_swapfiles; i++) {
 		unsigned int j;
-		if (swap_info[i].flags != SWP_USED)
+		if (!(swap_info[i].flags & SWP_USED))
 			continue;
 		for (j = 0; j < swap_info[i].max; ++j) {
 			switch (swap_info[i].swap_map[j]) {

--------------E7F003BB7E665B71DD08D61D--

