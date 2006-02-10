Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWBJTKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWBJTKM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 14:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWBJTKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 14:10:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25234 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750955AbWBJTKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 14:10:10 -0500
Date: Fri, 10 Feb 2006 11:08:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: ashok.raj@intel.com, ntl@pobox.com, dada1@cosmosbay.com, riel@redhat.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, mingo@elte.hu,
       76306.1226@compuserve.com, wli@holomorphy.com,
       heiko.carstens@de.ibm.com, pj@sgi.com
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-Id: <20060210110844.602a1bb0.akpm@osdl.org>
In-Reply-To: <200602101310.59889.ak@muc.de>
References: <20060209160808.GL18730@localhost.localdomain>
	<200602101102.25437.ak@muc.de>
	<20060210024222.67db06f3.akpm@osdl.org>
	<200602101310.59889.ak@muc.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> On Friday 10 February 2006 11:42, Andrew Morton wrote:
> > Andi Kleen <ak@muc.de> wrote:
> > >
> > > On Thursday 09 February 2006 19:04, Andrew Morton wrote:
> > > > Ashok Raj <ashok.raj@intel.com> wrote:
> > > > >
> > > > > The problem was with ACPI just simply looking at the namespace doesnt
> > > > >  exactly give us an idea of how many processors are possible in this platform.
> > > > 
> > > > We need to fix this asap - the performance penalty for HOTPLUG_CPU=y,
> > > > NR_CPUS=lots will be appreciable.
> > > 
> > > What is this performance penalty exactly? 
> > 
> > All those for_each_cpu() loops will hit NR_CPUS cachelines instead of
> > hweight(cpu_possible_map) cachelines.
> 
> But are there any in real fast paths? iirc they are mostly in initialization,
> where it doesn't matter too much.
> 

Could be so.

I just added one to percpu_counters though.  And it'd be a pain to
introduce a cpu notifier for each and every percpu_counter.



From: Andrew Morton <akpm@osdl.org>

Implement percpu_counter_sum().  This is a more accurate but slower version of
percpu_counter_read_positive().

We need this for Alex's speedup-ext3_statfs patch.  Otherwise it would be too
inaccurate on large CPU counts.

Cc: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Alex Tomas <alex@clusterfs.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/percpu_counter.h |    6 ++++++
 mm/swap.c                      |   25 +++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff -puN include/linux/percpu_counter.h~percpu_counter_sum include/linux/percpu_counter.h
--- devel/include/linux/percpu_counter.h~percpu_counter_sum	2006-02-08 13:34:08.000000000 -0800
+++ devel-akpm/include/linux/percpu_counter.h	2006-02-08 13:34:08.000000000 -0800
@@ -39,6 +39,7 @@ static inline void percpu_counter_destro
 }
 
 void percpu_counter_mod(struct percpu_counter *fbc, long amount);
+long percpu_counter_sum(struct percpu_counter *fbc);
 
 static inline long percpu_counter_read(struct percpu_counter *fbc)
 {
@@ -92,6 +93,11 @@ static inline long percpu_counter_read_p
 	return fbc->count;
 }
 
+static inline long percpu_counter_sum(struct percpu_counter *fbc)
+{
+	return percpu_counter_read_positive(fbc);
+}
+
 #endif	/* CONFIG_SMP */
 
 static inline void percpu_counter_inc(struct percpu_counter *fbc)
diff -puN mm/swap.c~percpu_counter_sum mm/swap.c
--- devel/mm/swap.c~percpu_counter_sum	2006-02-08 13:34:08.000000000 -0800
+++ devel-akpm/mm/swap.c	2006-02-08 13:34:08.000000000 -0800
@@ -491,13 +491,34 @@ void percpu_counter_mod(struct percpu_co
 	if (count >= FBC_BATCH || count <= -FBC_BATCH) {
 		spin_lock(&fbc->lock);
 		fbc->count += count;
+		*pcount = 0;
 		spin_unlock(&fbc->lock);
-		count = 0;
+	} else {
+		*pcount = count;
 	}
-	*pcount = count;
 	put_cpu();
 }
 EXPORT_SYMBOL(percpu_counter_mod);
+
+/*
+ * Add up all the per-cpu counts, return the result.  This is a more accurate
+ * but much slower version of percpu_counter_read_positive()
+ */
+long percpu_counter_sum(struct percpu_counter *fbc)
+{
+	long ret;
+	int cpu;
+
+	spin_lock(&fbc->lock);
+	ret = fbc->count;
+	for_each_cpu(cpu) {
+		long *pcount = per_cpu_ptr(fbc->counters, cpu);
+		ret += *pcount;
+	}
+	spin_unlock(&fbc->lock);
+	return ret < 0 ? 0 : ret;
+}
+EXPORT_SYMBOL(percpu_counter_sum);
 #endif
 
 /*
_

