Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422892AbWBCTq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422892AbWBCTq7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422890AbWBCTq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:46:58 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:14507 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1422887AbWBCTq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:46:56 -0500
Date: Fri, 3 Feb 2006 19:46:24 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Ryan Richter <ryan@tau.solarneutrino.net>
cc: Linus Torvalds <torvalds@osdl.org>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Roland Dreier <rdreier@cisco.com>, Brian King <brking@us.ibm.com>,
       Willem Riede <osst@riede.org>, Doug Gilbert <dougg@torque.net>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Fw: crash on x86_64 - mm related?
In-Reply-To: <Pine.LNX.4.61.0601181556050.9110@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0602031842290.14065@goblin.wat.veritas.com>
References: <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local>
 <20060104172727.GA320@tau.solarneutrino.net> <Pine.LNX.4.63.0601042334310.5087@kai.makisara.local>
 <20060105201249.GB1795@tau.solarneutrino.net> <Pine.LNX.4.64.0601051312380.3169@g5.osdl.org>
 <20060109033149.GC283@tau.solarneutrino.net> <Pine.LNX.4.64.0601082000450.3169@g5.osdl.org>
 <Pine.LNX.4.61.0601090933160.7632@goblin.wat.veritas.com>
 <20060109185350.GG283@tau.solarneutrino.net> <Pine.LNX.4.61.0601091922550.15426@goblin.wat.veritas.com>
 <20060118001252.GB821@tau.solarneutrino.net> <Pine.LNX.4.61.0601181556050.9110@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 03 Feb 2006 19:45:47.0004 (UTC) FILETIME=[6D7643C0:01C628FA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2006, Hugh Dickins wrote:
> On Tue, 17 Jan 2006, Ryan Richter wrote:
> 
> > This machine experienced another random reboot today, nothing in the
> > logs or on the console etc.  This is the 3rd time now since I upgraded
> > from 2.6.11.3.  Is there any way to debug something like this?
> 
> Nasty.  I hope someone else can suggest something constructive.

Are they still happening?

> > I'm fairly certain it's not hardware-related.
> > Might this have something to do with the st problem?
> 
> Well, it might: I've not been able to explain that at all, so cannot
> rule out a relation to your reboots.

If no "Bad page state" has occurred earlier, we can now be sure that
these reboots are (unfortunately) unrelated to the st problem.

> The st problem (Bad page state,
> mapcount 2 while count 0, from sgl_unmap_user_pages) ought to be a lot
> easier to debug than a random reboot: but I've still no suggestion.

I guessed it last week, Ryan verified that booting with "iommu=nomerge"
worked around it, and then that the 2.6.15 patch below fixes it.

On some architectures (alpha, ia64, parisc, powerpc, sparc64, x86_64,
more?) in some configurations, dma_map_sg or pci_map_sg may coalesce
scatterlist entries, copying later entries down: bad news if we then
go on to use that coalesced scatterlist to free the pages afterwards -
we're quite liable to free the same page twice.

James' DMA-API.txt is perfectly clear that "The mapping process is
allowed to destroy information in the sg".  I wonder that this hasn't
been noticed before.  Perhaps we should have a debug option to destroy
everything in the scatterlist when unmapping.

The st code has moved on a little since 2.6.15, I'll send the 2.6.16-rc2
patch to Kai and lists in reply to this mail.  I've looked around for
similar culprits - fewer than I was expecting, but I'm not sure if
I've found them all:

drivers/infiniband/core/uverbs_mem.c
drivers/scsi/ipr.c
drivers/scsi/osst.c
drivers/scsi/sg.c

I'll reply with _untested_ patches to the maintainers and list for
those too.  Except for sg.c, which I'll send privately to Doug -
I've wasted a lot of time not quite understanding it, and don't
want to expose my ignorance in public.

Hugh

--- 2.6.15/drivers/scsi/st.c	2006-01-03 03:21:10.000000000 +0000
+++ linux/drivers/scsi/st.c	2006-01-29 17:21:47.000000000 +0000
@@ -188,11 +188,11 @@ static int from_buffer(struct st_buffer 
 static void move_buffer_data(struct st_buffer *, int);
 static void buf_to_sg(struct st_buffer *, unsigned int);
 
-static int st_map_user_pages(struct scatterlist *, const unsigned int, 
+static int st_map_user_pages(struct st_buffer *, const unsigned int, 
 			     unsigned long, size_t, int, unsigned long);
-static int sgl_map_user_pages(struct scatterlist *, const unsigned int, 
+static int sgl_map_user_pages(struct st_buffer *, const unsigned int, 
 			      unsigned long, size_t, int);
-static int sgl_unmap_user_pages(struct scatterlist *, const unsigned int, int);
+static int sgl_unmap_user_pages(struct st_buffer *, const unsigned int, int);
 
 static int st_probe(struct device *);
 static int st_remove(struct device *);
@@ -1402,7 +1402,7 @@ static int setup_buffering(struct scsi_t
 		i = STp->try_dio && try_wdio;
 	if (i && ((unsigned long)buf & queue_dma_alignment(
 					STp->device->request_queue)) == 0) {
-		i = st_map_user_pages(&(STbp->sg[0]), STbp->use_sg,
+		i = st_map_user_pages(STbp, STbp->use_sg,
 				      (unsigned long)buf, count, (is_read ? READ : WRITE),
 				      STp->max_pfn);
 		if (i > 0) {
@@ -1455,7 +1455,7 @@ static void release_buffering(struct scs
 
 	STbp = STp->buffer;
 	if (STbp->do_dio) {
-		sgl_unmap_user_pages(&(STbp->sg[0]), STbp->do_dio, 0);
+		sgl_unmap_user_pages(STbp, STbp->do_dio, 0);
 		STbp->do_dio = 0;
 	}
 }
@@ -4396,32 +4396,33 @@ static void do_create_class_files(struct
    - any page is above max_pfn
    (i.e., either completely successful or fails)
 */
-static int st_map_user_pages(struct scatterlist *sgl, const unsigned int max_pages, 
+static int st_map_user_pages(struct st_buffer *STbp, const unsigned int max_pages, 
 			     unsigned long uaddr, size_t count, int rw,
 			     unsigned long max_pfn)
 {
 	int i, nr_pages;
 
-	nr_pages = sgl_map_user_pages(sgl, max_pages, uaddr, count, rw);
+	nr_pages = sgl_map_user_pages(STbp, max_pages, uaddr, count, rw);
 	if (nr_pages <= 0)
 		return nr_pages;
 
 	for (i=0; i < nr_pages; i++) {
-		if (page_to_pfn(sgl[i].page) > max_pfn)
+		if (page_to_pfn(STbp->sg[i].page) > max_pfn)
 			goto out_unmap;
 	}
 	return nr_pages;
 
  out_unmap:
-	sgl_unmap_user_pages(sgl, nr_pages, 0);
+	sgl_unmap_user_pages(STbp, nr_pages, 0);
 	return 0;
 }
 
 
 /* The following functions may be useful for a larger audience. */
-static int sgl_map_user_pages(struct scatterlist *sgl, const unsigned int max_pages, 
+static int sgl_map_user_pages(struct st_buffer *STbp, const unsigned int max_pages, 
 			      unsigned long uaddr, size_t count, int rw)
 {
+	struct scatterlist *sgl = STbp->sg;
 	unsigned long end = (uaddr + count + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	unsigned long start = uaddr >> PAGE_SHIFT;
 	const int nr_pages = end - start;
@@ -4485,7 +4486,7 @@ static int sgl_map_user_pages(struct sca
 		sgl[0].length = count;
 	}
 
-	kfree(pages);
+	STbp->sg_pages = pages;
 	return nr_pages;
 
  out_unmap:
@@ -4500,13 +4501,13 @@ static int sgl_map_user_pages(struct sca
 
 
 /* And unmap them... */
-static int sgl_unmap_user_pages(struct scatterlist *sgl, const unsigned int nr_pages,
+static int sgl_unmap_user_pages(struct st_buffer *STbp, const unsigned int nr_pages,
 				int dirtied)
 {
 	int i;
 
 	for (i=0; i < nr_pages; i++) {
-		struct page *page = sgl[i].page;
+		struct page *page = STbp->sg_pages[i];
 
 		if (dirtied)
 			SetPageDirty(page);
@@ -4516,5 +4517,7 @@ static int sgl_unmap_user_pages(struct s
 		page_cache_release(page);
 	}
 
+	kfree(STbp->sg_pages);
+	STbp->sg_pages = NULL;
 	return 0;
 }
--- 2.6.15/drivers/scsi/st.h	2005-10-28 01:02:08.000000000 +0100
+++ linux/drivers/scsi/st.h	2006-01-29 16:52:02.000000000 +0000
@@ -37,6 +37,7 @@ struct st_buffer {
 	unsigned short frp_segs;	/* number of buffer segments */
 	unsigned int frp_sg_current;	/* driver buffer length currently in s/g list */
 	struct st_buf_fragment *frp;	/* the allocated buffer fragment list */
+	struct page **sg_pages;		/* pages to be freed from s/g list */
 	struct scatterlist sg[1];	/* MUST BE last item */
 };
 
