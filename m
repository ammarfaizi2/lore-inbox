Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWBJVAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWBJVAo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 16:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWBJVAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 16:00:44 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:39310 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751380AbWBJVAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 16:00:43 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: pktcdvd stack usage regression
References: <20060209020932.GY3524@stusta.de> <m3lkwl6pfu.fsf@telia.com>
	<20060210143947.GE19918@stusta.de>
From: Peter Osterlund <petero2@telia.com>
Date: 10 Feb 2006 21:56:54 +0100
In-Reply-To: <20060210143947.GE19918@stusta.de>
Message-ID: <m3pslv9bl5.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> On Thu, Feb 09, 2006 at 07:01:25AM +0100, Peter Osterlund wrote:
> > Adrian Bunk <bunk@stusta.de> writes:
> > 
> > > With PACKET_MAX_SIZE=128, this allocates more than 1 kB on the stack 
> > 
> > Yes, I know.
> > 
> > > which is not acceptable considering that we might have only 4 kB stack 
> > > altogether.
> > 
> > Why is it not acceptable? The pkt_start_write() function is only
> > called from the kcdrwd() kernel thread and the pkt_start_write()
> > function doesn't call anything else in the kernel that could require
> > lots of stack space.
> > 
> > The actual I/O is started from pkt_iosched_process_queue(), which
> > calls generic_make_request(). However pkt_iosched_process_queue() is
> > on a different call chain than pkt_start_write(), so I don't see how
> > this could be a problem.
> 
> You might be able to verify this is true today, but it is a bit fragile 
> and other changes might always add even more stack usage in some places. 

I don't think that would happen in this driver, but it doesn't really
matter, because I realized that those vectors aren't actually needed
at all. This patch removes them:


pktcdvd: Reduce stack usage.

Reduce stack usage in the pkt_start_write() function.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/block/pktcdvd.c |   43 +++++++++++++++++--------------------------
 1 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index d794f2b..f783af7 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -646,7 +646,7 @@ static void pkt_copy_bio_data(struct bio
  * b) The data can be used as cache to avoid read requests if we receive a
  *    new write request for the same zone.
  */
-static void pkt_make_local_copy(struct packet_data *pkt, struct page **pages, int *offsets)
+static void pkt_make_local_copy(struct packet_data *pkt, struct bio_vec *bvec)
 {
 	int f, p, offs;
 
@@ -654,15 +654,15 @@ static void pkt_make_local_copy(struct p
 	p = 0;
 	offs = 0;
 	for (f = 0; f < pkt->frames; f++) {
-		if (pages[f] != pkt->pages[p]) {
-			void *vfrom = kmap_atomic(pages[f], KM_USER0) + offsets[f];
+		if (bvec[f].bv_page != pkt->pages[p]) {
+			void *vfrom = kmap_atomic(bvec[f].bv_page, KM_USER0) + bvec[f].bv_offset;
 			void *vto = page_address(pkt->pages[p]) + offs;
 			memcpy(vto, vfrom, CD_FRAMESIZE);
 			kunmap_atomic(vfrom, KM_USER0);
-			pages[f] = pkt->pages[p];
-			offsets[f] = offs;
+			bvec[f].bv_page = pkt->pages[p];
+			bvec[f].bv_offset = offs;
 		} else {
-			BUG_ON(offsets[f] != offs);
+			BUG_ON(bvec[f].bv_offset != offs);
 		}
 		offs += CD_FRAMESIZE;
 		if (offs >= PAGE_SIZE) {
@@ -992,18 +992,17 @@ try_next_bio:
 static void pkt_start_write(struct pktcdvd_device *pd, struct packet_data *pkt)
 {
 	struct bio *bio;
-	struct page *pages[PACKET_MAX_SIZE];
-	int offsets[PACKET_MAX_SIZE];
 	int f;
 	int frames_write;
+	struct bio_vec *bvec = pkt->w_bio->bi_io_vec;
 
 	for (f = 0; f < pkt->frames; f++) {
-		pages[f] = pkt->pages[(f * CD_FRAMESIZE) / PAGE_SIZE];
-		offsets[f] = (f * CD_FRAMESIZE) % PAGE_SIZE;
+		bvec[f].bv_page = pkt->pages[(f * CD_FRAMESIZE) / PAGE_SIZE];
+		bvec[f].bv_offset = (f * CD_FRAMESIZE) % PAGE_SIZE;
 	}
 
 	/*
-	 * Fill-in pages[] and offsets[] with data from orig_bios.
+	 * Fill-in bvec with data from orig_bios.
 	 */
 	frames_write = 0;
 	spin_lock(&pkt->lock);
@@ -1025,11 +1024,11 @@ static void pkt_start_write(struct pktcd
 			}
 
 			if (src_bvl->bv_len - src_offs >= CD_FRAMESIZE) {
-				pages[f] = src_bvl->bv_page;
-				offsets[f] = src_bvl->bv_offset + src_offs;
+				bvec[f].bv_page = src_bvl->bv_page;
+				bvec[f].bv_offset = src_bvl->bv_offset + src_offs;
 			} else {
 				pkt_copy_bio_data(bio, segment, src_offs,
-						  pages[f], offsets[f]);
+						  bvec[f].bv_page, bvec[f].bv_offset);
 			}
 			src_offs += CD_FRAMESIZE;
 			frames_write++;
@@ -1043,7 +1042,7 @@ static void pkt_start_write(struct pktcd
 	BUG_ON(frames_write != pkt->write_size);
 
 	if (test_bit(PACKET_MERGE_SEGS, &pd->flags) || (pkt->write_size < pkt->frames)) {
-		pkt_make_local_copy(pkt, pages, offsets);
+		pkt_make_local_copy(pkt, bvec);
 		pkt->cache_valid = 1;
 	} else {
 		pkt->cache_valid = 0;
@@ -1056,17 +1055,9 @@ static void pkt_start_write(struct pktcd
 	pkt->w_bio->bi_bdev = pd->bdev;
 	pkt->w_bio->bi_end_io = pkt_end_io_packet_write;
 	pkt->w_bio->bi_private = pkt;
-	for (f = 0; f < pkt->frames; f++) {
-		if ((f + 1 < pkt->frames) && (pages[f + 1] == pages[f]) &&
-		    (offsets[f + 1] = offsets[f] + CD_FRAMESIZE)) {
-			if (!bio_add_page(pkt->w_bio, pages[f], CD_FRAMESIZE * 2, offsets[f]))
-				BUG();
-			f++;
-		} else {
-			if (!bio_add_page(pkt->w_bio, pages[f], CD_FRAMESIZE, offsets[f]))
-				BUG();
-		}
-	}
+	for (f = 0; f < pkt->frames; f++)
+		if (!bio_add_page(pkt->w_bio, bvec[f].bv_page, CD_FRAMESIZE, bvec[f].bv_offset))
+			BUG();
 	VPRINTK("pktcdvd: vcnt=%d\n", pkt->w_bio->bi_vcnt);
 
 	atomic_set(&pkt->io_wait, 1);

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
