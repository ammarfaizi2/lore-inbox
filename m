Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWCUSF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWCUSF5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 13:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWCUSF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 13:05:57 -0500
Received: from relay04.roc.ny.frontiernet.net ([66.133.182.167]:33446 "EHLO
	relay04.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S932359AbWCUSF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 13:05:56 -0500
From: Bryan Holty <lgeek@frontiernet.net>
To: Dan Aloni <da-x@monatomic.org>
Subject: Re: [PATCH] scsi: properly count the number of pages in scsi_req_map_sg()
Date: Tue, 21 Mar 2006 12:05:45 -0600
User-Agent: KMail/1.9.1
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>, brking@us.ibm.com,
       dror@xiv.co.il
References: <20060321083830.GA2364@localdomain> <1142956494.4377.12.camel@mulgrave.il.steeleye.com> <20060321161912.GA32051@localdomain>
In-Reply-To: <20060321161912.GA32051@localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603211205.46196.lgeek@frontiernet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 March 2006 10:19, Dan Aloni wrote:
> On Tue, Mar 21, 2006 at 09:54:54AM -0600, James Bottomley wrote:
> > This is a good email to discuss on the scsi list:
> > linux-scsi@vger.kernel.org; whom I've added to the cc list.
> >
> > On Tue, 2006-03-21 at 10:38 +0200, Dan Aloni wrote:
> > > Improper calculation of the number of pages causes bio_alloc() to
> > > be called with nr_iovecs=0, and slab corruption later.
> > >
> > > For example, a simple scatterlist that fails: {(3644,452), (0, 60)},
> > > (offset, size). bufflen=512 => nr_pages=1 => breakage. The proper
> > > page count for this example is 2.
> >
> > Such a scatterlist would likely violate the device's underlying
> > boundaries and is not legal ... there's supposed to be special code
> > checking the queue alignment and copying the bio to an aligned buffer if
> > the limits are violated.  Where are you generating these scatterlists
> > from?
>
> These scatterlists can be generated using the sg driver. Though I am
> actually running a customized version of the sg driver, it seems the
> conversion from a userspace array of sg_iovec_t to scatterlist stays
> the same and also applies to the original driver (see
> st_map_user_pages()).

Hello,
    I am seeing the same issue when using direct io with sg.  sg will perform 
direct io on any date that is aligned with the devices dma_align.  The 
default for drivers that do not specify is 512.  sg builds the scatter gather 
list from the user specified location, offsetting the first entry in the list 
if not page aligned.  This is the case that causes the improper allocation of 
"nr_iovec" in scsi_req_map_sgand the later slab corruption.  

    I don't think it is necessary to calculate nr_pages from the entire list.  
Only sgl[0] is allowed to have an offset, so we can calculate from that as 
follows.
--- a/drivers/scsi/scsi_lib.c	2006-03-03 13:17:22.000000000 -0600
+++ b/drivers/scsi/scsi_lib.c	2006-03-21 11:36:39.389763804 -0600
@@ -368,12 +368,15 @@
 			   int nsegs, unsigned bufflen, gfp_t gfp)
 {
 	struct request_queue *q = rq->q;
-	int nr_pages = (bufflen + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	int nr_pages = 0;
 	unsigned int data_len = 0, len, bytes, off;
 	struct page *page;
 	struct bio *bio = NULL;
 	int i, err, nr_vecs = 0;
-
+	
+	if (nsegs)
+ 		nr_pages = (bufflen + sgl[0].offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	
 	for (i = 0; i < nsegs; i++) {
 		page = sgl[i].page;
 		off = sgl[i].offset;

--
 Bryan Holty
