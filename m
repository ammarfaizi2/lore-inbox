Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVBXH0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVBXH0E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 02:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVBXHYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 02:24:43 -0500
Received: from smtp108.mail.sc5.yahoo.com ([66.163.170.6]:23740 "HELO
	smtp108.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261879AbVBXHWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 02:22:45 -0500
Subject: [PATCH 7/13] better active balancing heuristic
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1109229700.5177.79.camel@npiggin-nld.site>
References: <1109229293.5177.64.camel@npiggin-nld.site>
	 <1109229362.5177.67.camel@npiggin-nld.site>
	 <1109229415.5177.68.camel@npiggin-nld.site>
	 <1109229491.5177.71.camel@npiggin-nld.site>
	 <1109229542.5177.73.camel@npiggin-nld.site>
	 <1109229650.5177.78.camel@npiggin-nld.site>
	 <1109229700.5177.79.camel@npiggin-nld.site>
Content-Type: multipart/mixed; boundary="=-fa3pMVTL+ITfaADRuwoU"
Date: Thu, 24 Feb 2005 18:22:40 +1100
Message-Id: <1109229760.5177.81.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fa3pMVTL+ITfaADRuwoU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

7/13


--=-fa3pMVTL+ITfaADRuwoU
Content-Disposition: attachment; filename=sched-less-alb.patch
Content-Type: text/x-patch; name=sched-less-alb.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Fix up active load balancing a bit so it doesn't get called when it shouldn't.
Reset the nr_balance_failed counter at more points where we have  found
conditions to be balanced. This reduces too aggressive active balancing seen
on some workloads.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>


Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-02-24 17:39:05.851128944 +1100
+++ linux-2.6/kernel/sched.c	2005-02-24 17:43:38.162526682 +1100
@@ -2009,6 +2009,7 @@
 
 	schedstat_inc(sd, lb_balanced[idle]);
 
+	sd->nr_balance_failed = 0;
 	/* tune up the balancing interval */
 	if (sd->balance_interval < sd->max_interval)
 		sd->balance_interval *= 2;
@@ -2034,16 +2035,14 @@
 	schedstat_inc(sd, lb_cnt[NEWLY_IDLE]);
 	group = find_busiest_group(sd, this_cpu, &imbalance, NEWLY_IDLE);
 	if (!group) {
-		schedstat_inc(sd, lb_balanced[NEWLY_IDLE]);
 		schedstat_inc(sd, lb_nobusyg[NEWLY_IDLE]);
-		goto out;
+		goto out_balanced;
 	}
 
 	busiest = find_busiest_queue(group);
 	if (!busiest || busiest == this_rq) {
-		schedstat_inc(sd, lb_balanced[NEWLY_IDLE]);
 		schedstat_inc(sd, lb_nobusyq[NEWLY_IDLE]);
-		goto out;
+		goto out_balanced;
 	}
 
 	/* Attempt to move tasks */
@@ -2054,11 +2053,16 @@
 			imbalance, sd, NEWLY_IDLE, &all_pinned);
 	if (!nr_moved)
 		schedstat_inc(sd, lb_failed[NEWLY_IDLE]);
+	else
+                sd->nr_balance_failed = 0;
 
 	spin_unlock(&busiest->lock);
-
-out:
 	return nr_moved;
+
+out_balanced:
+	schedstat_inc(sd, lb_balanced[NEWLY_IDLE]);
+	sd->nr_balance_failed = 0;
+	return 0;
 }
 
 /*

--=-fa3pMVTL+ITfaADRuwoU--


