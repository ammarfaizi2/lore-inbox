Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288432AbSATVxW>; Sun, 20 Jan 2002 16:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288089AbSATVxD>; Sun, 20 Jan 2002 16:53:03 -0500
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:39943 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S287882AbSATVwv>;
	Sun, 20 Jan 2002 16:52:51 -0500
Date: Sun, 20 Jan 2002 16:41:00 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>, <torvalds@transmeta.com>
Subject: [PATCH] 2.5.3-pre2: drivers/ieee1394/video1394.c 
Message-ID: <Pine.LNX.4.33.0201201637220.1206-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
    This patch is for: MINOR -> minor updates, as well a 
remap_page_range() update for drivers/ieee1394/video1394.c . It's against 
2.5.3-pre2. Please review for inclusion.

Regards,
Frank

--- drivers/ieee1394/video1394.c.old	Mon Jan 14 21:54:46 2002
+++ drivers/ieee1394/video1394.c	Sun Jan 20 16:34:49 2002
@@ -807,8 +807,7 @@
 	reg_write(ohci, OHCI1394_IsoXmitIntMaskSet, 1<<d->ctx);
 }
 
-static int do_iso_mmap(struct ti_ohci *ohci, struct dma_iso_ctx *d, 
-		       const char *adr, unsigned long size)
+static int do_iso_mmap(struct vm_area_struct *vma, struct ti_ohci *ohci, struct dma_iso_ctx *d, const char *adr, unsigned long size)
 {
         unsigned long start=(unsigned long) adr;
         unsigned long page,pos;
@@ -828,7 +827,7 @@
         pos=(unsigned long) d->buf;
         while (size > 0) {
                 page = kvirt_to_pa(pos);
-                if (remap_page_range(start, page, PAGE_SIZE, PAGE_SHARED))
+                if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
                         return -EAGAIN;
                 start+=PAGE_SIZE;
                 pos+=PAGE_SIZE;
@@ -850,7 +849,7 @@
 		struct video_card *p;
 		list_for_each(lh, &video1394_cards) {
 			p = list_entry(lh, struct video_card, list);
-			if (p->id == MINOR(inode->i_rdev)) {
+			if (p->id == minor(inode->i_rdev)) {
 				video = p;
 				ohci = video->ohci;
 				break;
@@ -860,7 +859,7 @@
 	spin_unlock_irqrestore(&video1394_cards_lock, flags);
 
 	if (video == NULL) {
-		PRINT_G(KERN_ERR, __FUNCTION__": Unknown video card for minor %d", MINOR(inode->i_rdev));
+		PRINT_G(KERN_ERR, __FUNCTION__": Unknown video card for minor %d", minor(inode->i_rdev));
 		return -EFAULT;
 	}
 
@@ -1328,7 +1327,7 @@
 		struct video_card *p;
 		list_for_each(lh, &video1394_cards) {
 			p = list_entry(lh, struct video_card, list);
-			if (p->id == MINOR(file->f_dentry->d_inode->i_rdev)) {
+			if (p->id == minor(file->f_dentry->d_inode->i_rdev)) {
 				video = p;
 				break;
 			}
@@ -1338,7 +1337,7 @@
 
 	if (video == NULL) {
 		PRINT_G(KERN_ERR, __FUNCTION__": Unknown video card for minor %d",
-			MINOR(file->f_dentry->d_inode->i_rdev));
+			minor(file->f_dentry->d_inode->i_rdev));
 		return -EFAULT;
 	}
 
@@ -1348,7 +1347,7 @@
 	if (video->current_ctx == NULL) {
 		PRINT(KERN_ERR, ohci->id, "Current iso context not set");
 	} else
-		res = do_iso_mmap(ohci, video->current_ctx, 
+		res = do_iso_mmap(vma, ohci, video->current_ctx, 
 			   (char *)vma->vm_start, 
 			   (unsigned long)(vma->vm_end-vma->vm_start));
 	unlock_kernel();
@@ -1357,7 +1356,7 @@
 
 static int video1394_open(struct inode *inode, struct file *file)
 {
-	int i = MINOR(inode->i_rdev);
+	int i = minor(inode->i_rdev);
 	unsigned long flags;
 	struct video_card *video = NULL;
 	struct list_head *lh;
@@ -1397,7 +1396,7 @@
 		struct video_card *p;
 		list_for_each(lh, &video1394_cards) {
 			p = list_entry(lh, struct video_card, list);
-			if (p->id == MINOR(inode->i_rdev)) {
+			if (p->id == minor(inode->i_rdev)) {
 				video = p;
 				break;
 			}
@@ -1407,7 +1406,7 @@
 
 	if (video == NULL) {
 		PRINT_G(KERN_ERR, __FUNCTION__": Unknown device for minor %d",
-				MINOR(inode->i_rdev));
+				minor(inode->i_rdev));
 		return 1;
 	}
 

