Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVBXHUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVBXHUF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 02:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVBXHUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 02:20:04 -0500
Received: from smtp111.mail.sc5.yahoo.com ([66.163.170.9]:14256 "HELO
	smtp111.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261891AbVBXHTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 02:19:11 -0500
Subject: [PATCH 4/13] find_busiest_group fixlets
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1109229491.5177.71.camel@npiggin-nld.site>
References: <1109229293.5177.64.camel@npiggin-nld.site>
	 <1109229362.5177.67.camel@npiggin-nld.site>
	 <1109229415.5177.68.camel@npiggin-nld.site>
	 <1109229491.5177.71.camel@npiggin-nld.site>
Content-Type: multipart/mixed; boundary="=-Ct2Z30CuYQHPwSV9nH4p"
Date: Thu, 24 Feb 2005 18:19:02 +1100
Message-Id: <1109229542.5177.73.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ct2Z30CuYQHPwSV9nH4p
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

4/13


--=-Ct2Z30CuYQHPwSV9nH4p
Content-Disposition: attachment; filename=sched-balance-fix.patch
Content-Type: text/x-patch; name=sched-balance-fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Fix up a few small warts in the periodic multiprocessor rebalancing
code.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-02-24 17:31:28.431609701 +1100
+++ linux-2.6/kernel/sched.c	2005-02-24 17:43:38.806447240 +1100
@@ -1830,13 +1830,12 @@
 	 * by pulling tasks to us.  Be careful of negative numbers as they'll
 	 * appear as very large values with unsigned longs.
 	 */
-	*imbalance = min(max_load - avg_load, avg_load - this_load);
-
 	/* How much load to actually move to equalise the imbalance */
-	*imbalance = (*imbalance * min(busiest->cpu_power, this->cpu_power))
-				/ SCHED_LOAD_SCALE;
+	*imbalance = min((max_load - avg_load) * busiest->cpu_power,
+				(avg_load - this_load) * this->cpu_power)
+			/ SCHED_LOAD_SCALE;
 
-	if (*imbalance < SCHED_LOAD_SCALE - 1) {
+	if (*imbalance < SCHED_LOAD_SCALE) {
 		unsigned long pwr_now = 0, pwr_move = 0;
 		unsigned long tmp;
 
@@ -1862,14 +1861,16 @@
 							max_load - tmp);
 
 		/* Amount of load we'd add */
-		tmp = SCHED_LOAD_SCALE*SCHED_LOAD_SCALE/this->cpu_power;
-		if (max_load < tmp)
-			tmp = max_load;
+		if (max_load*busiest->cpu_power <
+				SCHED_LOAD_SCALE*SCHED_LOAD_SCALE)
+			tmp = max_load*busiest->cpu_power/this->cpu_power;
+		else
+			tmp = SCHED_LOAD_SCALE*SCHED_LOAD_SCALE/this->cpu_power;
 		pwr_move += this->cpu_power*min(SCHED_LOAD_SCALE, this_load + tmp);
 		pwr_move /= SCHED_LOAD_SCALE;
 
-		/* Move if we gain another 8th of a CPU worth of throughput */
-		if (pwr_move < pwr_now + SCHED_LOAD_SCALE / 8)
+		/* Move if we gain throughput */
+		if (pwr_move <= pwr_now)
 			goto out_balanced;
 
 		*imbalance = 1;
@@ -1877,7 +1878,7 @@
 	}
 
 	/* Get rid of the scaling factor, rounding down as we divide */
-	*imbalance = (*imbalance + 1) / SCHED_LOAD_SCALE;
+	*imbalance = *imbalance / SCHED_LOAD_SCALE;
 
 	return busiest;
 

--=-Ct2Z30CuYQHPwSV9nH4p--


