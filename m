Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751706AbWJTN6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbWJTN6t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 09:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbWJTN6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 09:58:49 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:41275 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751706AbWJTN6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 09:58:48 -0400
Subject: [Patch] statistics: fix buffer overflow in histogram with linear
	scale
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 15:58:44 +0200
Message-Id: <1161352724.3135.18.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Values outside the range covered by a histogram with linear
scale resulted in invalid indices pointing to non-existing
'buckets'. Index is adjusted to array boundaries, if required.

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 statistic.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff -urp a/lib/statistic.c b/lib/statistic.c
--- a/lib/statistic.c	2006-10-08 23:03:56.000000000 +0200
+++ b/lib/statistic.c	2006-10-12 19:38:08.000000000 +0200
@@ -994,9 +994,12 @@ static s64 statistic_histogram_calc_valu
 
 static int statistic_histogram_calc_index_lin(struct statistic *stat, s64 value)
 {
-	unsigned long long i = value - stat->u.histogram.range_min;
+	unsigned long long i;
+	if (value <= stat->u.histogram.range_min)
+		return 0;
+	i = value - stat->u.histogram.range_min;
 	do_div(i, stat->u.histogram.base_interval);
-	return i;
+	return min(i, (unsigned long long)(stat->u.histogram.last_index));
 }
 
 static int statistic_histogram_calc_index_log2(struct statistic *stat,


