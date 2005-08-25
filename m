Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbVHYXHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbVHYXHy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 19:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbVHYXHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 19:07:54 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:32445 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S964978AbVHYXHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 19:07:53 -0400
Subject: Re: Need better is_better_time_interpolator() algorithm
From: Alex Williamson <alex.williamson@hp.com>
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050825214029.21209.qmail@science.horizon.com>
References: <20050825214029.21209.qmail@science.horizon.com>
Content-Type: text/plain
Organization: LOSL
Date: Thu, 25 Aug 2005 17:07:50 -0600
Message-Id: <1125011270.5331.122.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 17:40 -0400, linux@horizon.com wrote:
> > (frequency) * (1/drift) * (1/latency) * (1/(jitter_factor * cpus))
> 
> (Note that 1/cpus, being a constant for all evaluations of this
> expression, has no effect on the final ranking.)

   I was sloppy expressing how the jitter factors in, but I've got code
below that should make it more clear.

> The usual way it's done is with some fiddle factors:
> 
> quality_a^a * quality_b^b * quality_c^c
> 
> Or, equivalently:
> 
> a * log(quality_a) + b * log(quality_b) + c * log(quality_c)
> 
> Then you use the a, b and c factors to weight the relative importance
> of them.  Your suggestion is equivalent to setting all the exponents to 1.
> 
> But you can also say that "a is twice as important as b" in a
> consistent manner.

   Right.  It's the weighting factors themselves that I'm clueless
about.  I'm hoping someone will chime in to help us prioritize and
weight clock attributes appropriately.  The code I've been poking at is
below (by no means ready for inclusion).  I think this brings the
components I'm aware of together, and makes an attempt to do something
meaningful with them.

   On my system, I have 2 NUMA nodes, each with 4 processors.  The cycle
counter runs at 1.5GHz with a 750ppm drift.  The latency of this timer
comes out to ~30ns.  The cycle counter is subject to drift, so I divide
by the square of the cpus and arrive at a "goodness" factor of around
950.

  I also have 2 HPETs on the system, one on each node.  These run at
250MHz with an assumed drift of 500ppm (although the current hpet code
makes the drift much higher).  I measure the access latency of these to
be around 200ns.  Because the HPETs have different access latency
depending on the node, I use the NUMA info to get a average access
latency of ~300ns.  These timers are not subject to jitter, eliminating
that factor.  This results in a "goodness" factor of ~1450.

   I don't really know if this makes sense, but it seems to do what I
think it should.  If I where to add another node to the system, I would
more strongly favor the HPETs time, if I removed a node I would revert
to the cycle counter.  Anyway, I think it might be a good starting point
for further experimentation.  Patch below.

	Alex
-- 
Alex Williamson                             HP Linux & Open Source Lab


 arch/ia64/kernel/cyclone.c      |    3 -
 arch/ia64/kernel/time.c         |    3 -
 arch/ia64/sn/kernel/sn2/timer.c |    3 -
 arch/sparc64/kernel/time.c      |    3 -
 drivers/char/hpet.c             |   12 +++-
 include/linux/hpet.h            |    1 
 include/linux/timex.h           |    2 
 kernel/timer.c                  |  113 +++++++++++++++++++++++++++++++++++++++-
 8 files changed, 133 insertions(+), 7 deletions(-)

diff -r b40794c1ac45 arch/ia64/kernel/cyclone.c
--- a/arch/ia64/kernel/cyclone.c	Wed Aug 24 12:00:22 2005
+++ b/arch/ia64/kernel/cyclone.c	Thu Aug 25 16:29:22 2005
@@ -23,7 +23,8 @@
 	.shift =	16,
 	.frequency =	CYCLONE_TIMER_FREQ,
 	.drift =	-100,
-	.mask =		(1LL << 40) - 1
+	.mask =		(1LL << 40) - 1,
+	.node =		-1
 };
 
 int __init init_cyclone_clock(void)
diff -r b40794c1ac45 arch/ia64/kernel/time.c
--- a/arch/ia64/kernel/time.c	Wed Aug 24 12:00:22 2005
+++ b/arch/ia64/kernel/time.c	Thu Aug 25 16:29:22 2005
@@ -48,7 +48,8 @@
 static struct time_interpolator itc_interpolator = {
 	.shift = 16,
 	.mask = 0xffffffffffffffffLL,
-	.source = TIME_SOURCE_CPU
+	.source = TIME_SOURCE_CPU,
+	.node = -1
 };
 
 static irqreturn_t
diff -r b40794c1ac45 arch/ia64/sn/kernel/sn2/timer.c
--- a/arch/ia64/sn/kernel/sn2/timer.c	Wed Aug 24 12:00:22 2005
+++ b/arch/ia64/sn/kernel/sn2/timer.c	Thu Aug 25 16:29:22 2005
@@ -25,7 +25,8 @@
 	.drift = -1,
 	.shift = 10,
 	.mask = (1LL << 55) - 1,
-	.source = TIME_SOURCE_MMIO64
+	.source = TIME_SOURCE_MMIO64,
+	.node = -1
 };
 
 void __init sn_timer_init(void)
diff -r b40794c1ac45 arch/sparc64/kernel/time.c
--- a/arch/sparc64/kernel/time.c	Wed Aug 24 12:00:22 2005
+++ b/arch/sparc64/kernel/time.c	Thu Aug 25 16:29:22 2005
@@ -1048,7 +1048,8 @@
 static struct time_interpolator sparc64_cpu_interpolator = {
 	.source		=	TIME_SOURCE_CPU,
 	.shift		=	16,
-	.mask		=	0xffffffffffffffffLL
+	.mask		=	0xffffffffffffffffLL,
+	.node		=	-1
 };
 
 /* The quotient formula is taken from the IA64 port. */
diff -r b40794c1ac45 drivers/char/hpet.c
--- a/drivers/char/hpet.c	Wed Aug 24 12:00:22 2005
+++ b/drivers/char/hpet.c	Thu Aug 25 16:29:22 2005
@@ -82,6 +82,7 @@
 	unsigned long hp_delta;
 	unsigned int hp_ntimer;
 	unsigned int hp_which;
+	acpi_handle handle;
 	struct hpet_dev hp_dev[1];
 };
 
@@ -702,6 +703,7 @@
 {
 #ifdef	CONFIG_TIME_INTERPOLATION
 	struct time_interpolator *ti;
+	int pxm;
 
 	ti = kmalloc(sizeof(*ti), GFP_KERNEL);
 	if (!ti)
@@ -714,7 +716,12 @@
 	ti->frequency = hpet_time_div(hpets->hp_period);
 	ti->drift = ti->frequency * HPET_DRIFT / 1000000;
 	ti->mask = -1;
-
+	ti->node = -1;
+	pxm = acpi_get_pxm(hpetp->handle);
+#ifdef CONFIG_NUMA
+	if (pxm >= 0) 
+		ti->node = pxm_to_nid_map[pxm];
+#endif
 	hpetp->hp_interpolator = ti;
 	register_time_interpolator(ti);
 #endif
@@ -871,6 +878,7 @@
 	}
 
 	hpetp->hp_delta = hpet_calibrate(hpetp);
+	hpetp->handle = hdp->handle;
 	hpet_register_interpolator(hpetp);
 
 	return 0;
@@ -923,6 +931,8 @@
 	struct hpet_data data;
 
 	memset(&data, 0, sizeof(data));
+
+	data.handle = device->handle;
 
 	result =
 	    acpi_walk_resources(device->handle, METHOD_NAME__CRS,
diff -r b40794c1ac45 include/linux/hpet.h
--- a/include/linux/hpet.h	Wed Aug 24 12:00:22 2005
+++ b/include/linux/hpet.h	Thu Aug 25 16:29:22 2005
@@ -118,6 +118,7 @@
 	unsigned short hd_flags;
 	unsigned int hd_state;	/* timer allocated */
 	unsigned int hd_irq[HPET_MAX_TIMERS];
+	acpi_handle handle;
 };
 
 #define	HPET_DATA_PLATFORM	0x0001	/* platform call to hpet_alloc */
diff -r b40794c1ac45 include/linux/timex.h
--- a/include/linux/timex.h	Wed Aug 24 12:00:22 2005
+++ b/include/linux/timex.h	Thu Aug 25 16:29:22 2005
@@ -298,6 +298,8 @@
 	long drift;			/* drift in parts-per-million (or -1) */
 	unsigned long skips;		/* skips forward */
 	unsigned long ns_skipped;	/* nanoseconds skipped */
+	unsigned long latency;		/* access latency, set by register_time_interpolator() */
+	long node;			/* NUMA node where the device lives, or -1 */
 	struct time_interpolator *next;
 };
 
diff -r b40794c1ac45 kernel/timer.c
--- a/kernel/timer.c	Wed Aug 24 12:00:22 2005
+++ b/kernel/timer.c	Thu Aug 25 16:29:22 2005
@@ -39,6 +39,8 @@
 #include <asm/div64.h>
 #include <asm/timex.h>
 #include <asm/io.h>
+#include <asm/smp.h>
+#include <asm/topology.h>
 
 #ifdef CONFIG_TIME_INTERPOLATION
 static void time_interpolator_update(long delta_nsec);
@@ -1408,6 +1410,26 @@
 static struct time_interpolator *time_interpolator_list;
 static DEFINE_SPINLOCK(time_interpolator_lock);
 
+static u64 time_interpolator_read(struct time_interpolator *ti)
+{
+	unsigned long (*x)(void);
+
+	switch (ti->source)
+	{
+		case TIME_SOURCE_FUNCTION:
+			x = ti->addr;
+			return x();
+
+		case TIME_SOURCE_MMIO64	:
+			return readq((void __iomem *) ti->addr);
+
+		case TIME_SOURCE_MMIO32	:
+			return readl((void __iomem *) ti->addr);
+
+		default: return get_cycles();
+	}
+}
+
 static inline u64 time_interpolator_get_cycles(unsigned int src)
 {
 	unsigned long (*x)(void);
@@ -1517,13 +1539,99 @@
 	}
 }
 
+#ifdef CONFIG_NUMA
+static long
+time_interpolator_latency_scale(struct time_interpolator *ti)
+{
+	int cpu;
+	long scale = 0;
+
+	if (ti->node == -1)
+		return 10;
+
+	for_each_online_cpu(cpu)
+		scale += node_distance(cpu_to_node(cpu), ti->node);
+
+	/* 
+	 * Penalize timers not on the timekeeper node.
+	 * FIXME: This isn't a good check for the timekeeper
+	 */
+	if (ti->node != 0)
+		scale += node_distance(cpu_to_node(0), ti->node);
+
+	return scale / num_online_cpus();
+}
+#else
+#define time_interpolator_latency_scale(x) (10)
+#endif
+
+static unsigned long
+get_time_interpolator_priority(struct time_interpolator *ti)
+{
+	unsigned long pri;
+
+	/*
+	 * -1 drift seems to indicate that someone really wants us to use
+	 *  their timer.
+	 */
+	if (ti->drift == -1)
+		return ~0UL;
+
+	pri = ti->frequency/ti->drift;
+	pri /= ti->latency * time_interpolator_latency_scale(ti) / 10;
+	if (ti->jitter)
+		pri /= num_online_cpus() * num_online_cpus();
+
+	return pri;
+}
+
 static inline int
 is_better_time_interpolator(struct time_interpolator *new)
 {
 	if (!time_interpolator)
 		return 1;
-	return new->frequency > 2*time_interpolator->frequency ||
-	    (unsigned long)new->drift < (unsigned long)time_interpolator->drift;
+
+	if (new == time_interpolator)
+		return 0;
+
+	return get_time_interpolator_priority(new) >
+	       get_time_interpolator_priority(time_interpolator);
+}
+
+static unsigned long
+time_interpolator_latency(struct time_interpolator *ti)
+{
+	volatile u64 start, end;
+	unsigned long latency;
+	int i, scale;
+
+	start = time_interpolator_read(ti);
+	for (i = 0; i < 100 ; i++)
+		end = time_interpolator_read(ti);
+	latency = ((end - start) * (1000000000UL/i))/ti->frequency;
+
+#ifdef CONFIG_NUMA
+	/*
+	 * On big boxes, an MMIO timer source may have different access times
+	 * from different nodes.  It's impractical to measure the latency from
+	 * each node, so we trust node distance to scale the latency to
+	 * the local acess time.
+	 */
+	switch (ti->source) {
+		case TIME_SOURCE_MMIO64:
+		case TIME_SOURCE_MMIO32:
+			if (ti->node == -1)
+				scale = 10;
+			else
+				scale = node_distance(cpu_to_node(
+				                smp_processor_id()), ti->node);
+			break;
+		default:
+			scale = 10;
+	}
+	latency = (latency * 10)/scale; /* SMP locality = 10 */
+#endif
+	return latency > 0 ? latency : 1UL;
 }
 
 void
@@ -1536,6 +1644,7 @@
 		BUG();
 
 	ti->nsec_per_cyc = ((u64)NSEC_PER_SEC << ti->shift) / ti->frequency;
+	ti->latency = time_interpolator_latency(ti);
 	spin_lock(&time_interpolator_lock);
 	write_seqlock_irqsave(&xtime_lock, flags);
 	if (is_better_time_interpolator(ti)) {


