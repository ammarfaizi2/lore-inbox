Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbWBCDFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWBCDFq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 22:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWBCDFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 22:05:46 -0500
Received: from ns1.siteground.net ([207.218.208.2]:56279 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964864AbWBCDFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 22:05:45 -0500
Date: Thu, 2 Feb 2006 19:05:47 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: dada1@cosmosbay.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
       shai@scalex86.org, netdev@vger.kernel.org, pravins@calsoftinc.com,
       bcrl@kvack.org
Subject: Re: [patch 3/4] net: Percpufy frequently used variables -- proto.sockets_allocated
Message-ID: <20060203030547.GB3612@localhost.localdomain>
References: <20060126185649.GB3651@localhost.localdomain> <20060126190357.GE3651@localhost.localdomain> <43D9DFA1.9070802@cosmosbay.com> <20060127195227.GA3565@localhost.localdomain> <20060127121602.18bc3f25.akpm@osdl.org> <20060127224433.GB3565@localhost.localdomain> <20060127150106.38b9e041.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127150106.38b9e041.akpm@osdl.org>
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

On Fri, Jan 27, 2006 at 03:01:06PM -0800, Andrew Morton wrote:
> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> 
> 
> > > 
> > > If the benchmarks say that we need to.  If we cannot observe any problems
> > > in testing of existing code and if we can't demonstrate any benefit from
> > > the patched code then one option is to go off and do something else ;)
> > 
> > We first tried plain per-CPU counters for memory_allocated, found that reads
> > on memory_allocated was causing cacheline transfers, and then
> > switched over to batching.  So batching reads is useful.  To avoid
> > inaccuracy, we can maybe change percpu_counter_init to:
> > 
> > void percpu_counter_init(struct percpu_counter *fbc, int maxdev)
> > 
> > the percpu batching limit would then be maxdev/num_possible_cpus.  One would
> > use batching counters only when both reads and writes are frequent.  With
> > the above scheme, we would go fetch cachelines from other cpus for read
> > often only on large cpu counts, which is not any worse than the global
> > counter alternative, but it would still be beneficial on smaller machines,
> > without sacrificing a pre-set deviation.  
> > 
> > Comments?
> 
> Sounds sane.
>

Here's an implementation which delegates tuning of batching to the user.  We
don't really need local_t at all as percpu_counter_mod is not safe against
interrupts and softirqs  as it is.  If we have a counter which could be
modified in process context and irq/bh context, we just have to use a
wrapper like percpu_counter_mod_bh which will just disable and enable bottom
halves.  Reads on the counters are safe as they are atomic_reads, and the
cpu local variables are always accessed by that cpu only.

(PS: the maxerr for ext2/ext3 is just guesstimate)

Comments?

Index: linux-2.6.16-rc1mm4/include/linux/percpu_counter.h
===================================================================
--- linux-2.6.16-rc1mm4.orig/include/linux/percpu_counter.h	2006-02-02 11:18:54.000000000 -0800
+++ linux-2.6.16-rc1mm4/include/linux/percpu_counter.h	2006-02-02 18:29:46.000000000 -0800
@@ -16,24 +16,32 @@
 
 struct percpu_counter {
 	atomic_long_t count;
+	int	percpu_batch;
 	long *counters;
 };
 
-#if NR_CPUS >= 16
-#define FBC_BATCH	(NR_CPUS*2)
-#else
-#define FBC_BATCH	(NR_CPUS*4)
-#endif
 
-static inline void percpu_counter_init(struct percpu_counter *fbc)
+/* 
+ * Choose maxerr carefully. maxerr/num_possible_cpus indicates per-cpu batching 
+ * Set maximum tolerance for better performance on large systems.
+ */
+static inline void percpu_counter_init(struct percpu_counter *fbc, 
+					unsigned int maxerr)
 {
 	atomic_long_set(&fbc->count, 0);
-	fbc->counters = alloc_percpu(long);
+	fbc->percpu_batch = maxerr/num_possible_cpus();
+	if (fbc->percpu_batch) {
+		fbc->counters = alloc_percpu(long);
+		if (!fbc->counters)
+			fbc->percpu_batch = 0;
+	}
+	
 }
 
 static inline void percpu_counter_destroy(struct percpu_counter *fbc)
 {
-	free_percpu(fbc->counters);
+	if (fbc->percpu_batch)
+		free_percpu(fbc->counters);
 }
 
 void percpu_counter_mod(struct percpu_counter *fbc, long amount);
@@ -63,7 +71,8 @@ struct percpu_counter {
 	long count;
 };
 
-static inline void percpu_counter_init(struct percpu_counter *fbc)
+static inline void percpu_counter_init(struct percpu_counter *fbc, 
+					unsigned int maxerr)
 {
 	fbc->count = 0;
 }
Index: linux-2.6.16-rc1mm4/mm/swap.c
===================================================================
--- linux-2.6.16-rc1mm4.orig/mm/swap.c	2006-01-29 20:20:20.000000000 -0800
+++ linux-2.6.16-rc1mm4/mm/swap.c	2006-02-02 18:36:21.000000000 -0800
@@ -470,13 +470,20 @@ static int cpu_swap_callback(struct noti
 #ifdef CONFIG_SMP
 void percpu_counter_mod(struct percpu_counter *fbc, long amount)
 {
-	long count;
 	long *pcount;
-	int cpu = get_cpu();
+	long count;
+	int cpu;
 
+	/* Slow mode */
+	if (unlikely(!fbc->percpu_batch)) {
+		atomic_long_add(amount, &fbc->count);
+		return;
+	}
+	
+	cpu = get_cpu();
 	pcount = per_cpu_ptr(fbc->counters, cpu);
 	count = *pcount + amount;
-	if (count >= FBC_BATCH || count <= -FBC_BATCH) {
+	if (count >= fbc->percpu_batch || count <= -fbc->percpu_batch) {
 		atomic_long_add(count, &fbc->count);
 		count = 0;
 	}
Index: linux-2.6.16-rc1mm4/fs/ext2/super.c
===================================================================
--- linux-2.6.16-rc1mm4.orig/fs/ext2/super.c	2006-02-02 18:30:28.000000000 -0800
+++ linux-2.6.16-rc1mm4/fs/ext2/super.c	2006-02-02 18:36:39.000000000 -0800
@@ -610,6 +610,7 @@ static int ext2_fill_super(struct super_
 	int db_count;
 	int i, j;
 	__le32 features;
+	int maxerr;
 
 	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
@@ -835,9 +836,14 @@ static int ext2_fill_super(struct super_
 		printk ("EXT2-fs: not enough memory\n");
 		goto failed_mount;
 	}
-	percpu_counter_init(&sbi->s_freeblocks_counter);
-	percpu_counter_init(&sbi->s_freeinodes_counter);
-	percpu_counter_init(&sbi->s_dirs_counter);
+
+	if (num_possible_cpus() <= 16 )
+		maxerr = 256;
+	else
+		maxerr = 1024;
+	percpu_counter_init(&sbi->s_freeblocks_counter, maxerr);
+	percpu_counter_init(&sbi->s_freeinodes_counter, maxerr);
+	percpu_counter_init(&sbi->s_dirs_counter, maxerr);
 	bgl_lock_init(&sbi->s_blockgroup_lock);
 	sbi->s_debts = kmalloc(sbi->s_groups_count * sizeof(*sbi->s_debts),
 			       GFP_KERNEL);
Index: linux-2.6.16-rc1mm4/fs/ext3/super.c
===================================================================
--- linux-2.6.16-rc1mm4.orig/fs/ext3/super.c	2006-02-02 18:30:28.000000000 -0800
+++ linux-2.6.16-rc1mm4/fs/ext3/super.c	2006-02-02 18:38:10.000000000 -0800
@@ -1353,6 +1353,7 @@ static int ext3_fill_super (struct super
 	int i;
 	int needs_recovery;
 	__le32 features;
+	int maxerr;
 
 	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
@@ -1578,9 +1579,14 @@ static int ext3_fill_super (struct super
 		goto failed_mount;
 	}
 
-	percpu_counter_init(&sbi->s_freeblocks_counter);
-	percpu_counter_init(&sbi->s_freeinodes_counter);
-	percpu_counter_init(&sbi->s_dirs_counter);
+	if (num_possible_cpus() <= 16)
+		maxerr = 256;
+	else
+		maxerr = 1024;
+
+	percpu_counter_init(&sbi->s_freeblocks_counter, maxerr);
+	percpu_counter_init(&sbi->s_freeinodes_counter, maxerr);
+	percpu_counter_init(&sbi->s_dirs_counter, maxerr);
 	bgl_lock_init(&sbi->s_blockgroup_lock);
 
 	for (i = 0; i < db_count; i++) {
