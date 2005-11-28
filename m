Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbVK1SGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbVK1SGR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 13:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVK1SFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 13:05:52 -0500
Received: from hera.kernel.org ([140.211.167.34]:37354 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932148AbVK1SFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 13:05:22 -0500
Date: Mon, 28 Nov 2005 10:22:39 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andre Hedrick <andre@linux-ide.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Chris Ross <lak1646@tebibyte.org>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: [2.4 PATCH] Don't panic on IDE DMA errors
Message-ID: <20051128122239.GB24608@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



diff-tree e8f3e8dd41308fb66c026f51bb86b23205ad48c1 (from 0b85d6aa75faefe28d90362424035ef7b349974c)
Author: Chris Ross <lak1646@tebibyte.org>
Date:   Wed Nov 23 15:56:00 2005 +0000

    [PATCH] Don't panic on IDE DMA errors
    
    Kernel 2.4.32 and earlier can panic when trying to read a corrupted
    sector from an IDE disk.
    
    The function ide_dma_timeout_retry can end a request early by calling
    idedisk_error, but then goes on to use the request anyway causing a
    kernel panic due to a null pointer exception. This patch fixes that.

diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 3f6a0aa..6fc6f77 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -899,11 +899,13 @@ static ide_startstop_t ide_dma_timeout_r
 	rq = HWGROUP(drive)->rq;
 	HWGROUP(drive)->rq = NULL;
 
-	rq->errors = 0;
-	rq->sector = rq->bh->b_rsector;
-	rq->current_nr_sectors = rq->bh->b_size >> 9;
-	rq->hard_cur_sectors = rq->current_nr_sectors;
-	rq->buffer = rq->bh->b_data;
+	if (rq) {
+		rq->errors = 0;
+		rq->sector = rq->bh->b_rsector;
+		rq->current_nr_sectors = rq->bh->b_size >> 9;
+		rq->hard_cur_sectors = rq->current_nr_sectors;
+		rq->buffer = rq->bh->b_data;
+	}
 
 	return ret;
 }
