Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWIGONB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWIGONB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 10:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWIGONA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 10:13:00 -0400
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:56226 "EHLO
	extu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S932121AbWIGOM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 10:12:59 -0400
Date: Thu, 7 Sep 2006 17:04:20 +0100 (BST)
From: James Cross <james_cross@symantec.com>
X-X-Sender: jscross@boogie.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Jens Axboe <axboe@suse.de>, Andries Brouwer <Andries.Brouwer@cwi.nl>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] fix /proc/partitions oops
Message-ID: <Pine.LNX.4.62.0609071703420.28780@boogie.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 07 Sep 2006 14:12:42.0764 (UTC) FILETIME=[AF273CC0:01C6D287]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If show_partition happens to race with re-reading a partition table
(rescan_partitions), sgp->part[n] can become NULL just after it's been
tested, and so cause an oops: read it once (and read nr_sects just the
once too, to avoid a chance of showing 0).

Signed-off-by: James Cross <james_cross@symantec.com>
---

 block/genhd.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- 2.6.18-rc6/block/genhd.c.orig	2006-09-07 12:14:32.183218000 +0100
+++ 2.6.18-rc6/block/genhd.c	2006-09-07 12:15:16.134498000 +0100
@@ -261,14 +261,18 @@ static int show_partition(struct seq_fil
 		(unsigned long long)get_capacity(sgp) >> 1,
 		disk_name(sgp, 0, buf));
 	for (n = 0; n < sgp->minors - 1; n++) {
-		if (!sgp->part[n])
+		struct hd_struct *partn;
+		unsigned long long nr_sects;
+
+		partn = sgp->part[n];
+		if (!partn)
 			continue;
-		if (sgp->part[n]->nr_sects == 0)
+		nr_sects = partn->nr_sects;
+		if (nr_sects == 0)
 			continue;
 		seq_printf(part, "%4d  %4d %10llu %s\n",
 			sgp->major, n + 1 + sgp->first_minor,
-			(unsigned long long)sgp->part[n]->nr_sects >> 1 ,
-			disk_name(sgp, n + 1, buf));
+			nr_sects >> 1, disk_name(sgp, n + 1, buf));
 	}
 
 	return 0;
