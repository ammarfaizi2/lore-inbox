Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTERI4z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 04:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbTERI4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 04:56:06 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:3786 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261245AbTERIzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 04:55:49 -0400
Message-ID: <3EC747AA.90807@colorfullife.com>
Date: Sun, 18 May 2003 10:43:22 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Improve inter-cpu object passing in slab 3/3
Content-Type: multipart/mixed;
 boundary="------------090509020104020600030507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090509020104020600030507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Final part of the slab updates:

Improve readability of /proc/slabinfo by adding a header, and add 
per-cpu statistics.
As a sideeffect, the "2.0" file format helps to mitigate the 2 vs 3 
parameter problem created by the previous patch: A script can check the 
file format version, and use 2 parameter for 1.x, three parameters for 2.x

Patch against 2.5.69-mm6, applies to 2.5.69-bk12 with some offsets.
--
    Manfred

--------------090509020104020600030507
Content-Type: text/plain;
 name="patch-slab-newstat"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-newstat"

--- 2.5/mm/slab.c	2003-05-17 17:44:08.000000000 +0200
+++ build-2.5/mm/slab.c	2003-05-17 17:50:08.000000000 +0200
@@ -277,10 +277,10 @@
 	unsigned long		reaped;
 	unsigned long 		errors;
 	unsigned long		max_freeable;
-	atomic_t		allochit;
-	atomic_t		allocmiss;
-	atomic_t		freehit;
-	atomic_t		freemiss;
+	unsigned long		allochit[NR_CPUS];
+	unsigned long		allocmiss[NR_CPUS];
+	unsigned long		freehit[NR_CPUS];
+	unsigned long		freemiss[NR_CPUS];
 #endif
 };
 
@@ -312,10 +312,10 @@
 					(x)->max_freeable = i; \
 				} while (0)
 
-#define STATS_INC_ALLOCHIT(x)	atomic_inc(&(x)->allochit)
-#define STATS_INC_ALLOCMISS(x)	atomic_inc(&(x)->allocmiss)
-#define STATS_INC_FREEHIT(x)	atomic_inc(&(x)->freehit)
-#define STATS_INC_FREEMISS(x)	atomic_inc(&(x)->freemiss)
+#define STATS_INC_ALLOCHIT(x)	((x)->allochit[smp_processor_id()]++)
+#define STATS_INC_ALLOCMISS(x)	((x)->allocmiss[smp_processor_id()]++)
+#define STATS_INC_FREEHIT(x)	((x)->freehit[smp_processor_id()]++)
+#define STATS_INC_FREEMISS(x)	((x)->freemiss[smp_processor_id()]++)
 #else
 #define	STATS_INC_ACTIVE(x)	do { } while (0)
 #define	STATS_DEC_ACTIVE(x)	do { } while (0)
@@ -2446,11 +2446,18 @@
 		 * Output format version, so at least we can change it
 		 * without _too_ many complaints.
 		 */
-		seq_puts(m, "slabinfo - version: 1.2"
 #if STATS
-				" (statistics)"
+		seq_puts(m, "slabinfo - version: 2.0 (statistics)\n");
+#else
+		seq_puts(m, "slabinfo - version: 2.0\n");
+#endif
+		seq_puts(m, "# name            active_objs num_objs objsize objperslab pagesperslab\n");
+		seq_puts(m, "#! tunables       batchcount limit sharedfactor\n");
+		seq_puts(m, "#! slabdata       active_slabs num_slabs sharedavail\n");
+#if STATS
+		seq_puts(m, "#! globalstat     listallocs maxobjs grown reaped error maxfreeable freelimit\n");
+		seq_puts(m, "#! cpustat N      allochit allocmiss freehit freemiss\n");
 #endif
-				"\n");
 	}
 	p = cache_chain.next;
 	while (n--) {
@@ -2536,13 +2543,16 @@
 	if (error)
 		printk(KERN_ERR "slab: cache %s error: %s\n", name, error);
 
-	seq_printf(m, "%-17s %6lu %6lu %6u %4lu %4lu %4u",
+	seq_printf(m, "%-17s %6lu %6lu %6u %4u %4d\n",
 		name, active_objs, num_objs, cachep->objsize,
-		active_slabs, num_slabs, (1<<cachep->gfporder));
-
-	seq_printf(m, " : %4u %4u", cachep->limit, cachep->batchcount);
+		cachep->num, (1<<cachep->gfporder));
+	seq_printf(m, "! tunables          %4u %4u %4u\n",
+			cachep->limit, cachep->batchcount,
+			cachep->lists.shared->limit/cachep->batchcount);
+	seq_printf(m, "! slabdata        %6lu %6lu %6u\n",
+			active_slabs, num_slabs, cachep->lists.shared->avail);
 #if STATS
-	{	// list3 stats
+	{	/* list3 stats */
 		unsigned long high = cachep->high_mark;
 		unsigned long allocs = cachep->num_allocations;
 		unsigned long grown = cachep->grown;
@@ -2551,22 +2561,26 @@
 		unsigned long max_freeable = cachep->max_freeable;
 		unsigned long free_limit = cachep->free_limit;
 
-		seq_printf(m, " : %6lu %7lu %5lu %4lu %4lu %4lu %4lu",
-				high, allocs, grown, reaped, errors, 
+		seq_printf(m, "! globalstat     %7lu %6lu %5lu %4lu %4lu %4lu %4lu\n",
+				allocs, high, grown, reaped, errors, 
 				max_freeable, free_limit);
 	}
-	{	// cpucache stats
-		unsigned long allochit = atomic_read(&cachep->allochit);
-		unsigned long allocmiss = atomic_read(&cachep->allocmiss);
-		unsigned long freehit = atomic_read(&cachep->freehit);
-		unsigned long freemiss = atomic_read(&cachep->freemiss);
-
-		seq_printf(m, " : %6lu %6lu %6lu %6lu",
-				allochit, allocmiss, freehit, freemiss);
+	/* cpu stats */
+	{
+		int i;
+		for (i=0;i<NR_CPUS;i++) {
+			unsigned long allochit = cachep->allochit[i];
+			unsigned long allocmiss = cachep->allocmiss[i];
+			unsigned long freehit = cachep->freehit[i];
+			unsigned long freemiss = cachep->freemiss[i];
+
+			if (allochit | allocmiss | freehit | freemiss)
+				seq_printf(m, "! cpustat %3d     %6lu %6lu %6lu %6lu\n",
+					i, allochit, allocmiss, freehit, freemiss);
+		}
 	}
 #endif
 	spin_unlock_irq(&cachep->spinlock);
-	seq_putc(m, '\n');
 	return 0;
 }
 

--------------090509020104020600030507--


