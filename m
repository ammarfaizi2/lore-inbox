Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286390AbRLTVVf>; Thu, 20 Dec 2001 16:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286386AbRLTVV0>; Thu, 20 Dec 2001 16:21:26 -0500
Received: from [217.9.226.246] ([217.9.226.246]:49536 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S286385AbRLTVVP>; Thu, 20 Dec 2001 16:21:15 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Copying to loop device hangs up everything
From: Momchil Velikov <velco@fadata.bg>
Date: 20 Dec 2001 23:05:51 +0200
Message-ID: <873d25txe8.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, I'm convinced, given that writers are throttled above the loopback
thread.  Follows the Andrea's patch, but against 2.4.17-rc2 + removed
unused gfp_mask parameter of sync_page_buffers.

Regards,
-velco

--- 1.5/fs/buffer.c	Tue Dec 18 15:40:18 2001
+++ edited/fs/buffer.c	Thu Dec 20 22:45:36 2001
@@ -2432,7 +2432,7 @@
 	return 1;
 }
 
-static int sync_page_buffers(struct buffer_head *head, unsigned int gfp_mask)
+static int sync_page_buffers(struct buffer_head *head)
 {
 	struct buffer_head * bh = head;
 	int tryagain = 0;
@@ -2533,9 +2533,10 @@
 	/* Uhhuh, start writeback so that we don't end up with all dirty pages */
 	write_unlock(&hash_table_lock);
 	spin_unlock(&lru_list_lock);
+	gfp_mask = pf_gfp_mask(gfp_mask);
 	if (gfp_mask & __GFP_IO) {
 		if ((gfp_mask & __GFP_HIGHIO) || !PageHighMem(page)) {
-			if (sync_page_buffers(bh, gfp_mask)) {
+			if (sync_page_buffers(bh)) {
 				/* no IO or waiting next time */
 				gfp_mask = 0;
 				goto cleaned_buffers_try_again;
--- 1.2/include/linux/mm.h	Sat Dec  8 02:36:12 2001
+++ edited/include/linux/mm.h	Thu Dec 20 22:49:04 2001
@@ -547,6 +547,14 @@
    platforms, used as appropriate on others */
 
 #define GFP_DMA		__GFP_DMA
+static inline unsigned int pf_gfp_mask(unsigned int gfp_mask)
+{
+	/* avoid all memory balancing I/O methods if this task cannot block on I/O */
+	if (current->flags & PF_NOIO)
+		gfp_mask &= ~(__GFP_IO | __GFP_HIGHIO | __GFP_FS);
+
+	return gfp_mask;
+}
 
 /* vma is the first one with  address < vma->vm_end,
  * and even  address < vma->vm_start. Have to extend vma. */
--- 1.2/mm/vmscan.c	Tue Dec 18 15:40:23 2001
+++ edited/mm/vmscan.c	Thu Dec 20 22:49:47 2001
@@ -588,6 +588,8 @@
 	int priority = DEF_PRIORITY;
 	int nr_pages = SWAP_CLUSTER_MAX;
 
+	gfp_mask = pf_gfp_mask(gfp_mask);
+
 	do {
 		nr_pages = shrink_caches(classzone, priority, gfp_mask, nr_pages);
 		if (nr_pages <= 0)

