Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422888AbWBCTw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422888AbWBCTw6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422908AbWBCTw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:52:57 -0500
Received: from silver.veritas.com ([143.127.12.111]:38263 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1422888AbWBCTw4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:52:56 -0500
Date: Fri, 3 Feb 2006 19:53:34 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: [PATCH] st: don't doublefree pages from scatterlist
In-Reply-To: <Pine.LNX.4.61.0602031842290.14065@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0602031951280.14829@goblin.wat.veritas.com>
References: <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local>
 <20060104172727.GA320@tau.solarneutrino.net> <Pine.LNX.4.63.0601042334310.5087@kai.makisara.local>
 <20060105201249.GB1795@tau.solarneutrino.net> <Pine.LNX.4.64.0601051312380.3169@g5.osdl.org>
 <20060109033149.GC283@tau.solarneutrino.net> <Pine.LNX.4.64.0601082000450.3169@g5.osdl.org>
 <Pine.LNX.4.61.0601090933160.7632@goblin.wat.veritas.com>
 <20060109185350.GG283@tau.solarneutrino.net> <Pine.LNX.4.61.0601091922550.15426@goblin.wat.veritas.com>
 <20060118001252.GB821@tau.solarneutrino.net> <Pine.LNX.4.61.0601181556050.9110@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0602031842290.14065@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 03 Feb 2006 19:52:54.0932 (UTC) FILETIME=[6C86E540:01C628FB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On some architectures, mapping the scatterlist may coalesce entries:
if that coalesced list is then used for freeing the pages afterwards,
there's a danger that pages may be doubly freed (and others leaked).

Fix SCSI Tape's sgl_unmap_user_pages by freeing from the pagelist used
in sgl_map_user_pages.  Fixes Ryan Richter's crash on x86_64, with Bad
page state mapcount 2 from sgl_unmap_user_pages, and consequent mayhem.

But it's quite confusing for st's (un)map_user_pages to be named sgl_,
with sg's named st_: while we're changing its arg, rename st's to
st_map_user_pages and st_unmap_user_pages (and do sg's separately).

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 drivers/scsi/st.c |   20 ++++++++++++--------
 drivers/scsi/st.h |    1 +
 2 files changed, 13 insertions(+), 8 deletions(-)

--- 2.6.16-rc2/drivers/scsi/st.c	2006-02-03 09:32:25.000000000 +0000
+++ linux/drivers/scsi/st.c	2006-02-03 09:59:37.000000000 +0000
@@ -188,9 +188,9 @@ static int from_buffer(struct st_buffer 
 static void move_buffer_data(struct st_buffer *, int);
 static void buf_to_sg(struct st_buffer *, unsigned int);
 
-static int sgl_map_user_pages(struct scatterlist *, const unsigned int, 
+static int st_map_user_pages(struct st_buffer *, const unsigned int, 
 			      unsigned long, size_t, int);
-static int sgl_unmap_user_pages(struct scatterlist *, const unsigned int, int);
+static int st_unmap_user_pages(struct st_buffer *, const unsigned int, int);
 
 static int st_probe(struct device *);
 static int st_remove(struct device *);
@@ -1404,7 +1404,7 @@ static int setup_buffering(struct scsi_t
 
 	if (i && ((unsigned long)buf & queue_dma_alignment(
 					STp->device->request_queue)) == 0) {
-		i = sgl_map_user_pages(&(STbp->sg[0]), STbp->use_sg,
+		i = st_map_user_pages(STbp, STbp->use_sg,
 				      (unsigned long)buf, count, (is_read ? READ : WRITE));
 		if (i > 0) {
 			STbp->do_dio = i;
@@ -1456,7 +1456,7 @@ static void release_buffering(struct scs
 
 	STbp = STp->buffer;
 	if (STbp->do_dio) {
-		sgl_unmap_user_pages(&(STbp->sg[0]), STbp->do_dio, is_read);
+		st_unmap_user_pages(STbp, STbp->do_dio, is_read);
 		STbp->do_dio = 0;
 		STbp->sg_segs = 0;
 	}
@@ -4368,13 +4368,14 @@ static void do_create_class_files(struct
 }
 
 /* The following functions may be useful for a larger audience. */
-static int sgl_map_user_pages(struct scatterlist *sgl, const unsigned int max_pages, 
+static int st_map_user_pages(struct st_buffer *STbp, const unsigned int max_pages, 
 			      unsigned long uaddr, size_t count, int rw)
 {
 	unsigned long end = (uaddr + count + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	unsigned long start = uaddr >> PAGE_SHIFT;
 	const int nr_pages = end - start;
 	int res, i, j;
+	struct scatterlist *sgl = STbp->sg;
 	struct page **pages;
 
 	/* User attempted Overflow! */
@@ -4434,7 +4435,7 @@ static int sgl_map_user_pages(struct sca
 		sgl[0].length = count;
 	}
 
-	kfree(pages);
+	STbp->sg_pages = pages;
 	return nr_pages;
 
  out_unmap:
@@ -4449,13 +4450,14 @@ static int sgl_map_user_pages(struct sca
 
 
 /* And unmap them... */
-static int sgl_unmap_user_pages(struct scatterlist *sgl, const unsigned int nr_pages,
+static int st_unmap_user_pages(struct st_buffer *STbp, const unsigned int nr_pages,
 				int dirtied)
 {
 	int i;
 
+	/* Scatterlist entries may have been coalesced: free saved pagelist */
 	for (i=0; i < nr_pages; i++) {
-		struct page *page = sgl[i].page;
+		struct page *page = STbp->sg_pages[i];
 
 		if (dirtied)
 			SetPageDirty(page);
@@ -4465,5 +4467,7 @@ static int sgl_unmap_user_pages(struct s
 		page_cache_release(page);
 	}
 
+	kfree(STbp->sg_pages);
+	STbp->sg_pages = NULL;
 	return 0;
 }
--- 2.6.16-rc2/drivers/scsi/st.h	2006-02-03 09:32:25.000000000 +0000
+++ linux/drivers/scsi/st.h	2006-02-03 09:59:37.000000000 +0000
@@ -49,6 +49,7 @@ struct st_buffer {
 	unsigned short frp_segs;	/* number of buffer segments */
 	unsigned int frp_sg_current;	/* driver buffer length currently in s/g list */
 	struct st_buf_fragment *frp;	/* the allocated buffer fragment list */
+	struct page **sg_pages;		/* pages to be freed from s/g list */
 	struct scatterlist sg[1];	/* MUST BE last item */
 };
 
