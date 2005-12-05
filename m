Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbVLEPas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbVLEPas (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 10:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVLEPas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 10:30:48 -0500
Received: from alfie.demon.co.uk ([80.177.172.67]:61457 "EHLO
	alfie.demon.co.uk") by vger.kernel.org with ESMTP id S932443AbVLEPar
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 10:30:47 -0500
Date: Mon, 5 Dec 2005 15:27:58 +0000
From: Nick Holloway <Nick.Holloway@pyrites.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH 2.6.15-rc4 1/1] cpia: use vm_insert_page() instead of remap_pfn_range()
Message-ID: <20051205152758.GA29108@pyrites.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use vm_insert_page() instead of remap_pfn_range(), and remove
the PageReserved fiddling.

Signed-off-by: Nick Holloway <Nick.Holloway@pyrites.org.uk>

---

Although the cpia driver functioned correctly after printing out the
"incomplete pfn remapping" message, I thought I would have a go at the
trivial conversion'' as I have access to the hardware.

Driver has been tested with a parport CPIA camera (using "motion").

 cpia.c |   22 ++++------------------
 1 files changed, 4 insertions(+), 18 deletions(-)

--- linux-2.6.15-rc4/drivers/media/video/cpia.c~	2005-12-03 10:04:33.000000000 +0000
+++ linux-2.6.15-rc4/drivers/media/video/cpia.c	2005-12-05 11:20:57.000000000 +0000
@@ -219,7 +219,6 @@ static void set_flicker(struct cam_param
 static void *rvmalloc(unsigned long size)
 {
 	void *mem;
-	unsigned long adr;
 
 	size = PAGE_ALIGN(size);
 	mem = vmalloc_32(size);
@@ -227,29 +226,15 @@ static void *rvmalloc(unsigned long size
 		return NULL;
 
 	memset(mem, 0, size); /* Clear the ram out, no junk to the user */
-	adr = (unsigned long) mem;
-	while (size > 0) {
-		SetPageReserved(vmalloc_to_page((void *)adr));
-		adr += PAGE_SIZE;
-		size -= PAGE_SIZE;
-	}
 
 	return mem;
 }
 
 static void rvfree(void *mem, unsigned long size)
 {
-	unsigned long adr;
-
 	if (!mem)
 		return;
 
-	adr = (unsigned long) mem;
-	while ((long) size > 0) {
-		ClearPageReserved(vmalloc_to_page((void *)adr));
-		adr += PAGE_SIZE;
-		size -= PAGE_SIZE;
-	}
 	vfree(mem);
 }
 
@@ -3753,7 +3738,8 @@ static int cpia_mmap(struct file *file, 
 	struct video_device *dev = file->private_data;
 	unsigned long start = vma->vm_start;
 	unsigned long size  = vma->vm_end - vma->vm_start;
-	unsigned long page, pos;
+	unsigned long pos;
+	struct page* page;
 	struct cam_data *cam = dev->priv;
 	int retval;
 
@@ -3781,8 +3767,8 @@ static int cpia_mmap(struct file *file, 
 
 	pos = (unsigned long)(cam->frame_buf);
 	while (size > 0) {
-		page = vmalloc_to_pfn((void *)pos);
-		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
+		page = vmalloc_to_page((void *)pos);
+		if (vm_insert_page(vma, start, page)) {
 			up(&cam->busy_lock);
 			return -EAGAIN;
 		}

-- 
 `O O'  | Nick.Holloway@pyrites.org.uk
// ^ \\ | http://www.pyrites.org.uk/
