Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWAQCEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWAQCEN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 21:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWAQCEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 21:04:13 -0500
Received: from ns1.siteground.net ([207.218.208.2]:37533 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751339AbWAQCEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 21:04:13 -0500
Date: Mon, 16 Jan 2006 18:03:52 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] mm: Convert global dirty_exceeded flag to per-node node_dirty_exceeded
Message-ID: <20060117020352.GB5313@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
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

This is a repost.  I did not get any comments when I last posted this
about a month back. So I guess this patch is all good :)

Andrew, can this get some exposure in -mm?

Thanks,
Kiran


Convert global dirty_exceeded flag to per-node node_dirty_exceeded.

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

Index: linux-2.6.15-mm4/mm/page-writeback.c
===================================================================
--- linux-2.6.15-mm4.orig/mm/page-writeback.c	2006-01-16 12:04:51.000000000 -0800
+++ linux-2.6.15-mm4/mm/page-writeback.c	2006-01-16 13:26:48.000000000 -0800
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
@@ -212,7 +225,7 @@ static void balance_dirty_pages(struct a
 		if (nr_reclaimable + wbs.nr_writeback <= dirty_thresh)
 			break;
 
-		dirty_exceeded = 1;
+		node_dirty_exceeded = 1;
 
 		/* Note: nr_reclaimable denotes nr_dirty + nr_unstable.
 		 * Unstable writes are a feature of certain networked
@@ -235,7 +248,7 @@ static void balance_dirty_pages(struct a
 	}
 
 	if (nr_reclaimable + wbs.nr_writeback <= dirty_thresh)
-		dirty_exceeded = 0;
+		node_dirty_exceeded = 0;
 
 	if (writeback_in_progress(bdi))
 		return;		/* pdflush is already working this queue */
@@ -272,7 +285,7 @@ void balance_dirty_pages_ratelimited(str
 	long ratelimit;
 
 	ratelimit = ratelimit_pages;
-	if (dirty_exceeded)
+	if (node_dirty_exceeded)
 		ratelimit = 8;
 
 	/*
