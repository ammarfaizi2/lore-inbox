Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWAITVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWAITVJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWAITVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:21:09 -0500
Received: from silver.veritas.com ([143.127.12.111]:45578 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751142AbWAITVG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:21:06 -0500
Date: Mon, 9 Jan 2006 19:21:18 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Doug Gilbert <dougg@torque.net>
cc: Jesper Juhl <jesper.juhl@gmail.com>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2
In-Reply-To: <Pine.LNX.4.61.0601091857430.15219@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0601091919000.15387@goblin.wat.veritas.com>
References: <20060107052221.61d0b600.akpm@osdl.org> 
 <9a8748490601070708p4353eb0ev9ea15edee132b13b@mail.gmail.com> 
 <9a8748490601090947i524d5f73uf5ccd06d8c693cae@mail.gmail.com> 
 <20060109175748.GD25102@redhat.com>  <9a8748490601091001y74fba5q2cd7e08a324701c3@mail.gmail.com>
  <Pine.LNX.4.61.0601091819160.14800@goblin.wat.veritas.com>
 <9a8748490601091048x46716e25u2fe2ebe9b5fbc9bb@mail.gmail.com>
 <Pine.LNX.4.61.0601091857430.15219@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jan 2006 19:21:06.0371 (UTC) FILETIME=[D69BD930:01C61551]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I mistyped Doug's email address, sorry to Doug and all.

On Mon, 9 Jan 2006, Jesper Juhl wrote:
> Ok, with that patch the page, flags, mapping, mapcount & count
> information prints again.

Good, thanks.

> I get the exact same backtrace as before though, but a slightly
> different hexdump :

(I find -mm's hexdump addition really irritating.  Perhaps it could
be helpful if properly formatted, but not that dump of bytes.)

> Bad page state in process 'kded'
> page:c1e75400 flags:0x00000000 mapping:00000000 mapcount:1 count:0
> Trying to fix it up, but a reboot is needed
> Backtrace:
> [<c0103e77>] dump_stack+0x17/0x20
> [<c0148999>] bad_page+0x69/0x160
> [<c0148e92>] __free_pages_ok+0xa2/0x120
> [<c0149c7f>] __free_pages+0x2f/0x60
> [<c02acb63>] sg_page_free+0x23/0x30
> [<c02abdb3>] sg_remove_scat+0x63/0xe0
....

Having sent you the patch to restore the KERN_EMERGs, I then took a
look at drivers/scsi/sg.c, and it looks as if changes have gone into
2.6.15-git which might make more urgent a fix we knew would be needed
in some cases.  Could you try the patch below and let us know if it
fixes your problems?  Thanks...


Remove sg_rb_correct4mmap() and its nasty __put_page()s, which are liable
to do quite the wrong thing.  Instead allocate pages with __GFP_COMP, then
high-orders should be safe for exposure to userspace by sg_vma_nopage(),
without any further manipulations.  Based on original patch by Nick Piggin.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.15-mm2/drivers/scsi/sg.c	2006-01-09 11:36:26.000000000 +0000
+++ linux/drivers/scsi/sg.c	2006-01-09 18:46:17.000000000 +0000
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
+		page_mask = GFP_ATOMIC | GFP_DMA | __GFP_NOWARN | __GFP_COMP;
 	else
-		page_mask = GFP_ATOMIC | __GFP_NOWARN;
+		page_mask = GFP_ATOMIC | __GFP_NOWARN | __GFP_COMP;
 
 	for (order = 0, a_size = PAGE_SIZE; a_size < rqSz;
 	     order++, a_size <<= 1) ;
