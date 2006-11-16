Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162254AbWKPCsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162254AbWKPCsk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162261AbWKPCsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:48:39 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:20872 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162259AbWKPCsG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:48:06 -0500
Message-Id: <20061116024902.947757000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:44:00 -0800
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
Subject: [patch 28/30] cciss: fix iostat
Content-Disposition: inline; filename=cciss-fix-iostat.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Jens Axboe <jens.axboe@oracle.com>

cciss needs to call disk_stat_add() for iostat to work.

Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/block/cciss.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-2.6.18.2.orig/drivers/block/cciss.c
+++ linux-2.6.18.2/drivers/block/cciss.c
@@ -1302,6 +1302,12 @@ static void cciss_softirq_done(struct re
 
 	complete_buffers(rq->bio, rq->errors);
 
+	if (blk_fs_request(rq)) {
+		const int rw = rq_data_dir(rq);
+
+		disk_stat_add(rq->rq_disk, sectors[rw], rq->nr_sectors);
+	}
+
 #ifdef CCISS_DEBUG
 	printk("Done with %p\n", rq);
 #endif				/* CCISS_DEBUG */

--
