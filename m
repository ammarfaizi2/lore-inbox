Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162250AbWKPCr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162250AbWKPCr4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162266AbWKPCrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:47:53 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:14728 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162264AbWKPCro
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:47:44 -0500
Message-Id: <20061116024852.470435000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:43:59 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, maks@sternwelten.at,
       Jens Axboe <jens.axboe@oracle.com>
Subject: [patch 27/30] cpqarray: fix iostat
Content-Disposition: inline; filename=cpqarray-fix-iostat.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Jens Axboe <jens.axboe@oracle.com>

cpqarray needs to call disk_stat_add() for iostat to work.

Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/block/cpqarray.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- linux-2.6.18.2.orig/drivers/block/cpqarray.c
+++ linux-2.6.18.2/drivers/block/cpqarray.c
@@ -1000,6 +1000,7 @@ static inline void complete_buffers(stru
  */
 static inline void complete_command(cmdlist_t *cmd, int timeout)
 {
+	struct request *rq = cmd->rq;
 	int ok=1;
 	int i, ddir;
 
@@ -1031,12 +1032,18 @@ static inline void complete_command(cmdl
                 pci_unmap_page(hba[cmd->ctlr]->pci_dev, cmd->req.sg[i].addr,
 				cmd->req.sg[i].size, ddir);
 
-	complete_buffers(cmd->rq->bio, ok);
+	complete_buffers(rq->bio, ok);
 
-	add_disk_randomness(cmd->rq->rq_disk);
+	if (blk_fs_request(rq)) {
+		const int rw = rq_data_dir(rq);
 
-        DBGPX(printk("Done with %p\n", cmd->rq););
-	end_that_request_last(cmd->rq, ok ? 1 : -EIO);
+		disk_stat_add(rq->rq_disk, sectors[rw], rq->nr_sectors);
+	}
+
+	add_disk_randomness(rq->rq_disk);
+
+	DBGPX(printk("Done with %p\n", rq););
+	end_that_request_last(rq, ok ? 1 : -EIO);
 }
 
 /*

--
