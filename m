Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932755AbWF3O5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932755AbWF3O5Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 10:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbWF3O5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 10:57:16 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:13517 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S932755AbWF3O5N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 10:57:13 -0400
Subject: [Patch] statistics infrastructure - update 8
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 16:57:08 +0200
Message-Id: <1151679428.2972.9.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

also calculate variance for utilisation indicator

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 Documentation/statistics.txt |    1 +
 lib/statistic.c              |   14 ++++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff -urp a/Documentation/statistics.txt b/Documentation/statistics.txt
--- a/Documentation/statistics.txt	2006-06-30 16:09:03.000000000 +0200
+++ b/Documentation/statistics.txt	2006-06-30 16:12:56.000000000 +0200
@@ -326,6 +326,7 @@ Provides a set of values comprising:
 - the minimum X
 - the average X
 - the maximum X
+- the variance of X
 
 This appears to be a useful fill level indicator for queues etc.
 
diff -urp a/lib/statistic.c b/lib/statistic.c
--- a/lib/statistic.c	2006-06-30 16:09:03.000000000 +0200
+++ b/lib/statistic.c	2006-06-30 16:12:56.000000000 +0200
@@ -903,6 +903,7 @@ struct statistic_entry_util {
 	u32 res;
 	u32 num;	/* FIXME: better 64 bit; do_div can't deal with it) */
 	s64 acc;
+	s64 sqr;
 	s64 min;
 	s64 max;
 };
@@ -912,6 +913,7 @@ static void statistic_reset_util(struct 
 	struct statistic_entry_util *util = ptr;
 	util->num = 0;
 	util->acc = 0;
+	util->sqr = 0;
 	util->min = LLONG_MAX;
 	util->max = LLONG_MIN;
 }
@@ -922,6 +924,7 @@ void statistic_add_util(struct statistic
 	struct statistic_entry_util *util = stat->pdata->ptrs[cpu];
 	util->num += incr;
 	util->acc += value * incr;
+	util->sqr += value * value * incr;
 	if (unlikely(value < util->min))
 		util->min = value;
 	if (unlikely(value > util->max))
@@ -935,6 +938,7 @@ static void statistic_set_util(struct st
 	util = (struct statistic_entry_util *) stat->pdata;
 	util->num = total;
 	util->acc = value * total;
+	util->sqr = value * value * total;
 	if (unlikely(value < util->min))
 		util->min = value;
 	if (unlikely(value > util->max))
@@ -946,6 +950,7 @@ static void statistic_merge_util(struct 
 	struct statistic_entry_util *dst = _dst, *src = _src;
 	dst->num += src->num;
 	dst->acc += src->acc;
+	dst->sqr += src->sqr;
 	if (unlikely(src->min < dst->min))
 		dst->min = src->min;
 	if (unlikely(src->max > dst->max))
@@ -974,8 +979,8 @@ static int statistic_fdata_util(struct s
 {
 	struct sgrb_seg *seg;
 	struct statistic_entry_util *util = data;
-	unsigned long long mean_w = 0, mean_d = 0,
-			   num = util->num, acc = util->acc;
+	unsigned long long mean_w = 0, mean_d = 0, var_w = 0, var_d = 0,
+			   num = util->num, acc = util->acc, sqr = util->sqr;
 	signed long long min = num ? util->min : 0,
 			 max = num ? util->max : 0;
 
@@ -983,9 +988,10 @@ static int statistic_fdata_util(struct s
 	if (unlikely(!seg))
 		return -ENOMEM;
 	statistic_div(&mean_w, &mean_d, acc, num, 3);
+	statistic_div(&var_w, &var_d, sqr - mean_w * mean_w, num, 3);
 	seg->offset += sprintf(seg->address + seg->offset,
-			       "%s %Lu %Ld %Ld.%03Ld %Ld\n", name,
-			       num, min, mean_w, mean_d, max);
+			       "%s %Lu %Ld %Ld.%03Ld %Ld %Ld.%03Ld\n", name,
+			       num, min, mean_w, mean_d, max, var_w, var_d);
 	return 0;
 }
 


