Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945919AbWBCThM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945919AbWBCThM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945918AbWBCThL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:37:11 -0500
Received: from ns1.siteground.net ([207.218.208.2]:43177 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1945919AbWBCThG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:37:06 -0500
Date: Fri, 3 Feb 2006 11:37:14 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: dada1@cosmosbay.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
       shai@scalex86.org, netdev@vger.kernel.org, pravins@calsoftinc.com,
       bcrl@kvack.org
Subject: Re: [patch 3/4] net: Percpufy frequently used variables -- proto.sockets_allocated
Message-ID: <20060203193714.GB3653@localhost.localdomain>
References: <20060126185649.GB3651@localhost.localdomain> <20060126190357.GE3651@localhost.localdomain> <43D9DFA1.9070802@cosmosbay.com> <20060127195227.GA3565@localhost.localdomain> <20060127121602.18bc3f25.akpm@osdl.org> <20060127224433.GB3565@localhost.localdomain> <20060127150106.38b9e041.akpm@osdl.org> <20060203030547.GB3612@localhost.localdomain> <20060202191600.3bf3a64a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060202191600.3bf3a64a.akpm@osdl.org>
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

On Thu, Feb 02, 2006 at 07:16:00PM -0800, Andrew Morton wrote:
> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> >
> > On Fri, Jan 27, 2006 at 03:01:06PM -0800, Andrew Morton wrote:
> > Here's an implementation which delegates tuning of batching to the user.  We
> > don't really need local_t at all as percpu_counter_mod is not safe against
> > interrupts and softirqs  as it is.  If we have a counter which could be
> > modified in process context and irq/bh context, we just have to use a
> > wrapper like percpu_counter_mod_bh which will just disable and enable bottom
> > halves.  Reads on the counters are safe as they are atomic_reads, and the
> > cpu local variables are always accessed by that cpu only.
> > 
> > (PS: the maxerr for ext2/ext3 is just guesstimate)
> 
> Well that's the problem.  We need to choose production-quality values for
> use in there.

The guesstimate was loosely based on keeping the per-cpu batch at atleast 8
on reasonably sized systems, while not letting maxerr grow too big.  I guess
machines with cpu counts more than 128 don't use ext3 :).  And if they do,
they can tune the counters with a higher maxerr.  I guess it might be a bit
ugly on the user side with all the if num_possibl_cpus(), but is there a
better alternative?

(I plan to test the counter values for ext2 and ext3 on a 16 way box, and
change these if they turn out to be not so good)

> 
> > Comments?
> 
> Using num_possible_cpus() in that header file is just asking for build
> errors.  Probably best to uninline the function rather than adding the
> needed include of cpumask.h.

Yup,

Here it is.

Change the percpu_counter interface so that user can specify the maximum
tolerable deviation.

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>

Index: linux-2.6.16-rc1mm4/include/linux/percpu_counter.h
===================================================================
--- linux-2.6.16-rc1mm4.orig/include/linux/percpu_counter.h	2006-02-02 11:18:54.000000000 -0800
+++ linux-2.6.16-rc1mm4/include/linux/percpu_counter.h	2006-02-03 11:04:05.000000000 -0800
@@ -16,24 +16,20 @@
 
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
-
-static inline void percpu_counter_init(struct percpu_counter *fbc)
-{
-	atomic_long_set(&fbc->count, 0);
-	fbc->counters = alloc_percpu(long);
-}
+/* 
+ * Choose maxerr carefully. maxerr/num_possible_cpus indicates per-cpu 
+ * batching. Set maximum tolerance for better performance on large systems.
+ */
+void percpu_counter_init(struct percpu_counter *fbc, unsigned int maxerr);
 
 static inline void percpu_counter_destroy(struct percpu_counter *fbc)
 {
-	free_percpu(fbc->counters);
+	if (fbc->percpu_batch)
+		free_percpu(fbc->counters);
 }
 
 void percpu_counter_mod(struct percpu_counter *fbc, long amount);
@@ -63,7 +59,8 @@ struct percpu_counter {
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
+++ linux-2.6.16-rc1mm4/mm/swap.c	2006-02-03 11:02:05.000000000 -0800
@@ -468,15 +468,39 @@ static int cpu_swap_callback(struct noti
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_SMP
+
+/* 
+ * Choose maxerr carefully. maxerr/num_possible_cpus indicates per-cpu
+ * batching. Set maximum tolerance for better performance on large systems.
+ */
+void percpu_counter_init(struct percpu_counter *fbc, unsigned int maxerr)
+{
+	atomic_long_set(&fbc->count, 0);
+	fbc->percpu_batch = maxerr/num_possible_cpus();
+	if (fbc->percpu_batch) {
+		fbc->counters = alloc_percpu(long);
+		if (!fbc->counters)
+			fbc->percpu_batch = 0;
+	}
+	
+}
+
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
@@ -484,6 +508,7 @@ void percpu_counter_mod(struct percpu_co
 	put_cpu();
 }
 EXPORT_SYMBOL(percpu_counter_mod);
+EXPORT_SYMBOL(percpu_counter_init);
 #endif
 
 /*
Index: linux-2.6.16-rc1mm4/fs/ext2/super.c
===================================================================
--- linux-2.6.16-rc1mm4.orig/fs/ext2/super.c	2006-02-03 11:03:54.000000000 -0800
+++ linux-2.6.16-rc1mm4/fs/ext2/super.c	2006-02-03 11:04:10.000000000 -0800
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
--- linux-2.6.16-rc1mm4.orig/fs/ext3/super.c	2006-02-03 11:03:54.000000000 -0800
+++ linux-2.6.16-rc1mm4/fs/ext3/super.c	2006-02-03 11:04:10.000000000 -0800
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
