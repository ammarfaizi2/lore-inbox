Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261300AbSJHR4o>; Tue, 8 Oct 2002 13:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261307AbSJHR4n>; Tue, 8 Oct 2002 13:56:43 -0400
Received: from tolkor.sgi.com ([198.149.18.6]:31675 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S261300AbSJHRzk>;
	Tue, 8 Oct 2002 13:55:40 -0400
Date: Tue, 8 Oct 2002 21:15:13 -0400
From: Christoph Hellwig <hch@sgi.com>
To: Erich Focht <efocht@ess.nec.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pooling NUMA scheduler with initial load balancing
Message-ID: <20021008211513.A28583@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>,
	Erich Focht <efocht@ess.nec.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200210072209.41880.efocht@ess.nec.de> <1420721189.1034032091@[10.10.2.3]> <200210081933.06677.efocht@ess.nec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210081933.06677.efocht@ess.nec.de>; from efocht@ess.nec.de on Tue, Oct 08, 2002 at 07:33:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 07:33:06PM +0200, Erich Focht wrote:
> Aaargh, you got the wrong second patch :-( Sorry for that...
> 
> Thanks for the hints, I cleaned up the first patch, too. No
> CONFIG_NUMA_SCHED any more, switched to MAX_NUMNODES, including
> asm/numa.h from asm/topology.h, so no need for you to see it.


diff -urNp a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Fri Sep 27 23:49:54 2002
+++ b/arch/i386/kernel/smpboot.c	Tue Oct  8 11:37:56 2002
@@ -1194,6 +1194,11 @@ int __devinit __cpu_up(unsigned int cpu)
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 	zap_low_mappings();
+#ifdef CONFIG_NUMA
+	pooldata_lock();
+	bld_pools();
+	pooldata_unlock();
+#endif

All callers of bld_pools() need the pooldata lock - taking
it inside that function makes the code a little more readable..
Also I'd suggest to rename bld_pools() to build_pools() ;)

-	cache_decay_ticks = 10;	/* XXX base this on PAL info and cache-bandwidth estimate */
+	cache_decay_ticks = 8;	/* XXX base this on PAL info and cache-bandwidth estimate */

Could you explain this change?  And it's affect on non-NUMA IA64
machines?

 /**
+ * atomic_inc_return - increment atomic variable and return new value
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1 and return it's new value.  Note that
+ * the guaranteed useful range of an atomic_t is only 24 bits.
+ */
+static inline int atomic_inc_return(atomic_t *v){
+	atomic_inc(v);
+	return v->counter;
+}

Who do you guarantee this is atomic?  Please make it fit
Documentation/CodyingStyle, btw..

+int numpools, pool_ptr[MAX_NUMNODES+1], pool_cpus[NR_CPUS], pool_nr_cpus[MAX_NUMNODES];
+unsigned long pool_mask[MAX_NUMNODES];

Hmm, shouldn't those [MAX_NUMNODES] arrays be in some per-node array
to avoid cacheline-bouncing?

+void pooldata_lock(void)
+{
+	int i;
+ retry:
+	while (atomic_read(&pool_lock));
+	if (atomic_inc_return(&pool_lock) > 1) {
+		atomic_dec(&pool_lock);
+		goto retry;
+	}

Why not a simple spin_lock()?

+	/* 
+	 * Wait a while, any loops using pool data should finish
+	 * in between. This is VERY ugly and should be replaced
+	 * by some real RCU stuff. [EF]
+	 */
+	for (i=0; i<100; i++)
+		udelay(1000);

Urgg.  I'd suggest you switch to RCU now and make your patch apply
ontop of it - another reason to apply the RCU core patch..

+void pooldata_unlock(void)
+{
+	atomic_dec(&pool_lock);
+}

Dito for spin_unlock.

+	/* avoid deadlock by timer interrupt on own cpu */
+	if (atomic_read(&pool_lock)) return;

spin_trylock..

All in all your code doesn't seem to be very cachelign-friendly,
lots of global bouncing.  Do you have any numbers on what your
patch changes for normal SMP configurations?
