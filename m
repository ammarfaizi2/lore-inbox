Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263692AbTKACbm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 21:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263693AbTKACbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 21:31:42 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:58375 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S263692AbTKACbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 21:31:40 -0500
Date: Sat, 1 Nov 2003 13:31:27 +1100
To: axboe@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BLOCK] phys_contig implies hw_contig
Message-ID: <20031101023127.GA14438@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

In ll_merge_requests_fn, it is checking blk_hw_contig_segments even if
blk_phys_contig_segments succeeds.  This means that it may cause two
physically contiguous segments to be separated because the hw check
fails.

This patch fixes that.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-source-2.5/drivers/block/ll_rw_blk.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/block/ll_rw_blk.c,v
retrieving revision 1.9
diff -u -r1.9 ll_rw_blk.c
--- kernel-source-2.5/drivers/block/ll_rw_blk.c	11 Oct 2003 06:29:20 -0000	1.9
+++ kernel-source-2.5/drivers/block/ll_rw_blk.c	1 Nov 2003 02:24:52 -0000
@@ -1046,16 +1046,16 @@
 		return 0;
 
 	total_phys_segments = req->nr_phys_segments + next->nr_phys_segments;
-	if (blk_phys_contig_segment(q, req->biotail, next->bio))
+	total_hw_segments = req->nr_hw_segments + next->nr_hw_segments;
+
+	if (blk_phys_contig_segment(q, req->biotail, next->bio)) {
 		total_phys_segments--;
+		total_hw_segments--;
+	} else if (blk_hw_contig_segment(q, req->biotail, next->bio))
+		total_hw_segments--;
 
 	if (total_phys_segments > q->max_phys_segments)
 		return 0;
-
-	total_hw_segments = req->nr_hw_segments + next->nr_hw_segments;
-	if (blk_hw_contig_segment(q, req->biotail, next->bio))
-		total_hw_segments--;
-
 	if (total_hw_segments > q->max_hw_segments)
 		return 0;
 

--SLDf9lqlvOQaIe6s--
