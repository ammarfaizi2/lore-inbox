Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbWCUIhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbWCUIhp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 03:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbWCUIho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 03:37:44 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:65110 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S964963AbWCUIho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 03:37:44 -0500
Date: Tue, 21 Mar 2006 10:38:30 +0200
From: Dan Aloni <da-x@monatomic.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: brking@us.ibm.com, James Bottomley <James.Bottomley@steeleye.com>,
       dror@xiv.co.il
Subject: [PATCH] scsi: properly count the number of pages in scsi_req_map_sg()
Message-ID: <20060321083830.GA2364@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Improper calculation of the number of pages causes bio_alloc() to
be called with nr_iovecs=0, and slab corruption later.

For example, a simple scatterlist that fails: {(3644,452), (0, 60)},
(offset, size). bufflen=512 => nr_pages=1 => breakage. The proper
page count for this example is 2.

Signed-off-by: Dan Aloni <da-x@monatomic.org>

---
commit 8faa94b01e6fd4518b760ce39a2db0ede9444ded
tree c2e3c6ee5f59a4c1e166e4798ddc6e938f448de2
parent c4a1745aa09fc110afdefea0e5d025043e348bae
author Dan Aloni <da-x@monatomic.org> Tue, 21 Mar 2006 10:19:11 +0200
committer Dan Aloni <da-x@monatomic.org> Tue, 21 Mar 2006 10:19:11 +0200

 drivers/scsi/scsi_lib.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 701a328..a42f3aa 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -368,13 +368,20 @@ static int scsi_req_map_sg(struct reques
 			   int nsegs, unsigned bufflen, gfp_t gfp)
 {
 	struct request_queue *q = rq->q;
-	int nr_pages = (bufflen + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	int nr_pages = 0;
 	unsigned int data_len = 0, len, bytes, off;
 	struct page *page;
 	struct bio *bio = NULL;
 	int i, err, nr_vecs = 0;
 
 	for (i = 0; i < nsegs; i++) {
+		off = sgl[i].offset;
+		len = sgl[i].length;
+
+		nr_pages += ((off + len + PAGE_SIZE - 1) >> PAGE_SHIFT) - (off >> PAGE_SHIFT);
+	}
+
+	for (i = 0; i < nsegs; i++) {
 		page = sgl[i].page;
 		off = sgl[i].offset;
 		len = sgl[i].length;


-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net, dan@xiv.co.il
