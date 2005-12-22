Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030353AbVLVWbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbVLVWbl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 17:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbVLVWbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 17:31:41 -0500
Received: from ns1.siteground.net ([207.218.208.2]:52154 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1030353AbVLVWbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 17:31:40 -0500
Date: Thu, 22 Dec 2005 14:31:39 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       shai@scalex86.org
Subject: [patch] mm: Patch to convert global dirty_exceeded flag to per-node node_dirty_exceeded
Message-ID: <20051222223139.GC3704@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to convert global dirty_exceeded flag to per-node
node_dirty_exceeded.

dirty_exceeded ping pongs between nodes in order to force all cpus in
the system to increase the frequency of calls to balance_dirty_pages.

Currently dirty_exceeded is used by balance_dirty_pages_ratelimited to
force all CPUs in the system call balance_dirty_pages often, in order to
reduce the amount of dirty pages in the entire system (based on
dirty_thresh and one CPU exceeding thee ratelimits).  As dirty_exceeded
is a global variable, it will ping-pong between nodes of a NUMA system
which is not good.

We think it is OK to reduce the affect of dirty_exceeded to node basis.
That will give us on one hand having multiple CPUs (of that node)
calling balance_dirty_pages often (based on same logic as before) and on
the other hand not causing ping-pong of dirty_exceeded with the other
nodes.

Following patch changes the global dirty_exceeded flag to a per-node
flag.  Hence, balance_dirty_pages is called more often only on the node
which exceeded the dirty_threshold.  The SMP case is left as was before.

Comments?

Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.15-rc6/mm/page-writeback.c
===================================================================
--- linux-2.6.15-rc6.orig/mm/page-writeback.c	2005-12-21 18:29:38.000000000 -0800
+++ linux-2.6.15-rc6/mm/page-writeback.c	2005-12-21 23:43:33.000000000 -0800
@@ -46,7 +46,20 @@
 static long ratelimit_pages = 32;
 
 static long total_pages;	/* The total number of pages in the machine. */
-static int dirty_exceeded;	/* Dirty mem may be over limit */
+
+/* 
+ * node_dirty_exceeded is used to indicate that dirty mem in the current node
+ * maybe over the limit and we need to increase the frequency of calls to 
+ * balance_dirty_pages
+ */
+#ifdef CONFIG_NUMA
+static DEFINE_PER_CPU(int, _dirty_exceeded) = { 0 };
+#define node_dirty_exceeded 					\
+	per_cpu(_dirty_exceeded, node_to_first_cpu(numa_node_id()))
+#else
+static int node_dirty_exceeded;
+#endif
+
 
 /*
  * When balance_dirty_pages decides that the caller needs to perform some
@@ -212,7 +225,7 @@
 		if (nr_reclaimable + wbs.nr_writeback <= dirty_thresh)
 			break;
 
-		dirty_exceeded = 1;
+		node_dirty_exceeded = 1;
 
 		/* Note: nr_reclaimable denotes nr_dirty + nr_unstable.
 		 * Unstable writes are a feature of certain networked
@@ -235,7 +248,7 @@
 	}
 
 	if (nr_reclaimable + wbs.nr_writeback <= dirty_thresh)
-		dirty_exceeded = 0;
+		node_dirty_exceeded = 0;
 
 	if (writeback_in_progress(bdi))
 		return;		/* pdflush is already working this queue */
@@ -272,7 +285,7 @@
 	long ratelimit;
 
 	ratelimit = ratelimit_pages;
-	if (dirty_exceeded)
+	if (node_dirty_exceeded)
 		ratelimit = 8;
 
 	/*
