Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWCaF4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWCaF4A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 00:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWCaF4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 00:56:00 -0500
Received: from ns1.siteground.net ([207.218.208.2]:6802 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1750993AbWCaFz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 00:55:59 -0500
Date: Thu, 30 Mar 2006 21:56:48 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@engr.sgi.com>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Alok Kataria <alok.kataria@calsoftinc.com>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>
Subject: [patch] slab: add statistics for alien cache overflows
Message-ID: <20060331055648.GB4334@localhost.localdomain>
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

Add a statistics counter which is incremented everytime the alien
cache overflows.  alien_cache limit is hardcoded to 12 right now.
We can use this statistics to tune alien cache if needed in the future.

Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.16mm2/mm/slab.c
===================================================================
--- linux-2.6.16mm2.orig/mm/slab.c	2006-03-30 11:38:33.000000000 -0800
+++ linux-2.6.16mm2/mm/slab.c	2006-03-30 15:47:55.000000000 -0800
@@ -424,6 +424,7 @@ struct kmem_cache {
 	unsigned long max_freeable;
 	unsigned long node_allocs;
 	unsigned long node_frees;
+	unsigned long node_overflow;
 	atomic_t allochit;
 	atomic_t allocmiss;
 	atomic_t freehit;
@@ -469,6 +470,7 @@ struct kmem_cache {
 #define	STATS_INC_ERR(x)	((x)->errors++)
 #define	STATS_INC_NODEALLOCS(x)	((x)->node_allocs++)
 #define	STATS_INC_NODEFREES(x)	((x)->node_frees++)
+#define STATS_INC_ACOVERFLOW(x)   ((x)->node_overflow++)
 #define	STATS_SET_FREEABLE(x, i)					\
 	do {								\
 		if ((x)->max_freeable < i)				\
@@ -488,6 +490,7 @@ struct kmem_cache {
 #define	STATS_INC_ERR(x)	do { } while (0)
 #define	STATS_INC_NODEALLOCS(x)	do { } while (0)
 #define	STATS_INC_NODEFREES(x)	do { } while (0)
+#define STATS_INC_ACOVERFLOW(x)   do { } while (0)
 #define	STATS_SET_FREEABLE(x, i) do { } while (0)
 #define STATS_INC_ALLOCHIT(x)	do { } while (0)
 #define STATS_INC_ALLOCMISS(x)	do { } while (0)
@@ -3099,9 +3102,11 @@ static inline void __cache_free(struct k
 			if (l3->alien && l3->alien[nodeid]) {
 				alien = l3->alien[nodeid];
 				spin_lock(&alien->lock);
-				if (unlikely(alien->avail == alien->limit))
+				if (unlikely(alien->avail == alien->limit)) {
+					STATS_INC_ACOVERFLOW(cachep);
 					__drain_alien_cache(cachep,
 							    alien, nodeid);
+				}
 				alien->entry[alien->avail++] = objp;
 				spin_unlock(&alien->lock);
 			} else {
@@ -3779,7 +3784,7 @@ static void print_slabinfo_header(struct
 	seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
 #if STATS
 	seq_puts(m, " : globalstat <listallocs> <maxobjs> <grown> <reaped> "
-		 "<error> <maxfreeable> <nodeallocs> <remotefrees>");
+		 "<error> <maxfreeable> <nodeallocs> <remotefrees> <alienoverflow>");
 	seq_puts(m, " : cpustat <allochit> <allocmiss> <freehit> <freemiss>");
 #endif
 		seq_puts(m, " : shrinker stat <nr requested> <nr freed>");
@@ -3894,11 +3899,12 @@ static int s_show(struct seq_file *m, vo
 		unsigned long max_freeable = cachep->max_freeable;
 		unsigned long node_allocs = cachep->node_allocs;
 		unsigned long node_frees = cachep->node_frees;
+		unsigned long overflows = cachep->node_overflow;
 
 		seq_printf(m, " : globalstat %7lu %6lu %5lu %4lu \
-				%4lu %4lu %4lu %4lu", allocs, high, grown,
+				%4lu %4lu %4lu %4lu %4lu", allocs, high, grown,
 				reaped, errors, max_freeable, node_allocs,
-				node_frees);
+				node_frees, overflows);
 	}
 	/* cpu stats */
 	{
