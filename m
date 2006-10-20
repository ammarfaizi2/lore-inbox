Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992679AbWJTQ5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992679AbWJTQ5B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 12:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992681AbWJTQ5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 12:57:00 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:11073 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S2992679AbWJTQ47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 12:56:59 -0400
Subject: [Patch] statistics: adapt output format of utilisation indicator
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 18:56:55 +0200
Message-Id: <1161363415.3135.36.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Statistics might be compounds of several results, or buckets
(see histogram). For any mode of data aggregation, we use one
line per bucket in the output format - with the exception of
a "utilisation indicator", which squeezes a handful of numbers
into a single line (number of samples, minimim, average, maximum,
variance).

This patch splits this compound up into separate and appropriately
named output lines, ridding us of a nasty exception, and improving
readability.

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 Documentation/statistics.txt |   22 +++++++++++++++++-----
 lib/statistic.c              |   14 +++++++++++---
 2 files changed, 28 insertions(+), 8 deletions(-)

--- a/lib/statistic.c	2006-10-12 20:37:12.000000000 +0200
+++ b/lib/statistic.c	2006-10-19 19:53:03.000000000 +0200
@@ -952,14 +952,22 @@ static int statistic_fdata_util(struct s
 	signed long long min = num ? util->min : 0,
 			 max = num ? util->max : 0;
 
-	seg = sgrb_seg_find(&fpriv->read_seg_lh, 128);
+	seg = sgrb_seg_find(&fpriv->read_seg_lh, 512);
 	if (unlikely(!seg))
 		return -ENOMEM;
 	statistic_div(&mean_w, &mean_d, acc, num, 3);
 	statistic_div(&var_w, &var_d, sqr - mean_w * mean_w, num, 3);
 	seg->offset += sprintf(seg->address + seg->offset,
-			       "%s %Lu %Ld %Ld.%03Ld %Ld %Ld.%03Ld\n", name,
-			       num, min, mean_w, mean_d, max, var_w, var_d);
+			       "%s samples %Lu\n"
+			       "%s minimum %Ld\n"
+			       "%s average %Ld.%03Ld\n"
+			       "%s maximum %Ld\n"
+			       "%s variance %Ld.%03Ld\n",
+			       name, num,
+			       name, min,
+			       name, mean_w, mean_d,
+			       name, max,
+			       name, var_w, var_d);
 	return 0;
 }
 
--- a/Documentation/statistics.txt	2006-10-08 23:03:51.000000000 +0200
+++ b/Documentation/statistics.txt	2006-10-19 20:13:12.000000000 +0200
@@ -199,7 +199,11 @@ has been implemented:
   size_write 0x14000 12			|
   ...					|
   size_write 0x9000 1			/
-  queue_used_depth 970 1 18.122 32		> num min avg max for a queue
+  queue_used_depth samples 970			\
+  queue_used_depth minimum 1			|
+  queue_used_depth average 18.122		> utilisation of a queue
+  queue_used_depth maximum 32			|
+  queue_used_depth variance 53.324		/
 
 Such output can grow as needed in debugfs files. It is human-readable and
 could be parsed and postprocessed by simple scripts that are aware of what the
@@ -543,18 +547,26 @@ this:
   foo 0x1000 4
   foo 0x2000 1
   foo 0x5000 2
-  bar 961 1 42.000 128
+  bar samples 961
+  bar minimum 1
+  bar average 42.000
+  bar maximum 128
+  bar variance 149.254
 
 
 	Output formats of different statistic types
 
   Statistic Type	Output Format				Number of Lines
 
-  counter_inc		<name> <total of Y>				1
+  counter_inc		<name> <total of Y>			1
 
-  counter_prod		<name> <total of Xi*Yi>				1
+  counter_prod		<name> <total of Xi*Yi>			1
 
-  utilisation		<name> <total of Y> <min X> <avg X> <max X>	1
+  utilisation		<name> "samples" <total of Y>		5
+			<name> "minimum" <minimum X>
+			<name> "average" <average X>
+			<name> "maximum" <maximum X>
+			<name> "variance" <variance of X>
 
   sparse		<name> <Xn> <total of Y for Xn>		<= entries
 			...


