Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030356AbWARPwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbWARPwp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 10:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbWARPwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 10:52:45 -0500
Received: from ns2.suse.de ([195.135.220.15]:31892 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030356AbWARPwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 10:52:44 -0500
Date: Wed, 18 Jan 2006 16:52:42 +0100
From: Nick Piggin <npiggin@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] sg: simplify page_count manipulations
Message-ID: <20060118155242.GB28418@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

What do you think about the following couple of patches? Hugh's had a
look and thinks they're OK.

Nick

--
Allocate a compound page for the user mapping instead of tweaking
the page refcounts.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/drivers/scsi/sg.c
===================================================================
--- linux-2.6.orig/drivers/scsi/sg.c
+++ linux-2.6/drivers/scsi/sg.c
@@ -1140,32 +1140,6 @@ sg_fasync(int fd, struct file *filp, int
 	return (retval < 0) ? retval : 0;
 }
 
-/* When startFinish==1 increments page counts for pages other than the 
-   first of scatter gather elements obtained from alloc_pages().
-   When startFinish==0 decrements ... */
-static void
-sg_rb_correct4mmap(Sg_scatter_hold * rsv_schp, int startFinish)
-{
-	struct scatterlist *sg = rsv_schp->buffer;
-	struct page *page;
-	int k, m;
-
-	SCSI_LOG_TIMEOUT(3, printk("sg_rb_correct4mmap: startFinish=%d, scatg=%d\n", 
-				   startFinish, rsv_schp->k_use_sg));
-	/* N.B. correction _not_ applied to base page of each allocation */
-	for (k = 0; k < rsv_schp->k_use_sg; ++k, ++sg) {
-		for (m = PAGE_SIZE; m < sg->length; m += PAGE_SIZE) {
-			page = sg->page;
-			if (startFinish)
-				get_page(page);
-			else {
-				if (page_count(page) > 0)
-					__put_page(page);
-			}
-		}
-	}
-}
-
 static struct page *
 sg_vma_nopage(struct vm_area_struct *vma, unsigned long addr, int *type)
 {
@@ -1237,10 +1211,7 @@ sg_mmap(struct file *filp, struct vm_are
 		sa += len;
 	}
 
-	if (0 == sfp->mmap_called) {
-		sg_rb_correct4mmap(rsv_schp, 1);	/* do only once per fd lifetime */
-		sfp->mmap_called = 1;
-	}
+	sfp->mmap_called = 1;
 	vma->vm_flags |= VM_RESERVED;
 	vma->vm_private_data = sfp;
 	vma->vm_ops = &sg_mmap_vm_ops;
@@ -2395,8 +2366,6 @@ __sg_remove_sfp(Sg_device * sdp, Sg_fd *
 		SCSI_LOG_TIMEOUT(6, 
 			printk("__sg_remove_sfp:    bufflen=%d, k_use_sg=%d\n",
 			(int) sfp->reserve.bufflen, (int) sfp->reserve.k_use_sg));
-		if (sfp->mmap_called)
-			sg_rb_correct4mmap(&sfp->reserve, 0);	/* undo correction */
 		sg_remove_scat(&sfp->reserve);
 	}
 	sfp->parentdp = NULL;
@@ -2478,9 +2447,9 @@ sg_page_malloc(int rqSz, int lowDma, int
 		return resp;
 
 	if (lowDma)
-		page_mask = GFP_ATOMIC | GFP_DMA | __GFP_NOWARN;
+		page_mask = GFP_ATOMIC | GFP_DMA | __GFP_COMP | __GFP_NOWARN;
 	else
-		page_mask = GFP_ATOMIC | __GFP_NOWARN;
+		page_mask = GFP_ATOMIC | __GFP_COMP | __GFP_NOWARN;
 
 	for (order = 0, a_size = PAGE_SIZE; a_size < rqSz;
 	     order++, a_size <<= 1) ;
