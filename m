Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbVLJM0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbVLJM0n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 07:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932788AbVLJM0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 07:26:43 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:32712 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932391AbVLJM0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 07:26:43 -0500
Date: Sat, 10 Dec 2005 13:25:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: hawkes@sgi.com
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Dinakar Guniguntala <dino@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Jack Steiner <steiner@sgi.com>,
       Paul Jackson <pj@sgi.com>
Subject: [patch -mm] scheduler cache hot autodetect, isolcpus fix
Message-ID: <20051210122548.GB25065@elte.hu>
References: <20051209205454.18325.46768.sendpatchset@tomahawk.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051209205454.18325.46768.sendpatchset@tomahawk.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.6 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* hawkes@sgi.com <hawkes@sgi.com> wrote:

> (3) For a cpu-exclusive cpuset cpu, the domain_distance() calculation 
>     produces a legal value, but not a useful value.  That is to say,
>     if cpu0 is isolated into a cpu-exclusive cpuset, then the semantic
>     meaning of "domain distance" between cpu0 and another CPU outside of
>     this cpu-exclusive is essentially undefined.  No load-balancing
>     will occur in or out of this cpu-exclusive cpuset.  There is no
>     need to measure_migration_cost() of any migrations in or out of
>     a cpu-exclusive cpuset.

this is a bug in calibrate_migration_costs() - it should only consider 
the cpu_map for which the domains are being built. Does the patch below 
fix things for you?

we _may_ want to do calibration for isolated domain trees too: if the 
new domain tree exposes a domain-depth that was not covered yet. But in 
any case, caching should work most of the time.

in any case, i'm curious why none of the WARN_ON()s in domain_distance() 
triggered: trying to measure the distance between two CPUs which have no 
common span should have triggered the first WARN_ON() in 
domain_distance().

> (4) The expense of the migration_cost() calculation can be sizeable.
>     It can be reduced somewhat by changing the 5% increments into 10%
>     or even higher.  That reduces the boot-time "calibration delay"
>     from 50 seconds down to 20 seconds (for the 64p ia64/sn2) for
>     three levels of sched domains, and the declaration of a single
>     cpu0 cpu-exclusive dynamic sched domain from 6 seconds down to 5
>     (all to calculate that unnecessary new domain_distance).

an architecture can reduce the calibration costs by tuning the 
max_cache_size variable down from the default 64MB. You can also do this 
from the command-line, via: max_cache_size=33000000.

but otherwise, the calibration measurement is already a bit noisy, so 
i'd not want to make it even more imprecise, at least for now.

> (5) Besides, the migration cost between any two CPUs is something
>     that can be calculated once at boot time and remembered
>     thereafter.  I suspect the reason why the algorithm doesn't do
>     this is that an exhaustive NxN calculation will be very slow for
>     large NR_CPUS counts, which explains why the calculations are
>     now done in the context of sched domains.

we do cache migration costs. This code in calibrate_migration_costs() 
does it:

                        /*
                         * No result cached yet?
                         */
                        if (migration_cost[distance] == -1LL)
                                migration_cost[distance] =
                                        measure_migration_cost(cpu1, cpu2);

i changed it from a NxN calculation to the domain-distance and added 
caching, primarily because Altix guys complained about the excessive 
output and excessive boot-time :-)

>     However, simply calculating the migration cost for each "domain
>     distance" presupposes that the sched domain groupings accurately
>     reflect true migration costs. [...]

yes, that is true. But obviously the migration costs are attached to the 
domain structure, so going beyond that in calibration makes no sense - 
we couldnt use the information. OTOH the domain tree on the overwhelming 
majority of platforms depicts the true cache-hierarchy of the hardware.

>     [...] For platforms like the ia64/sn2 this is not true.  For 
>     example, a 64p ia64/sn2 will have three sched domain levels:  
>     level zero is each 2-CPU pair within a node; level one is an 
>     SD_NODES_PER_DOMAIN-size arbitrary clump of 32 CPUs; level two is 
>     all 64 CPUs.  Looking at that middle level, if I understand the 
>     algorithm, there is one and only one migration_cost[1] calculation 
>     made for an arbitrary choice of one CPU in a 32-CPU clump and 
>     another CPU in that clump.  Reality is that there are various 
>     migration costs for different pairs of CPUs in that set of 32.  
>     This is yet another reason why I believe we don't need to do those 
>     5% size increments to get really accurate timings.

the domain tree should match the true cache hierarchy as closely as 
possible, to get optimal task migration _anyway_. It's not just about 
cache-hot autodetection, this is a generic thing for other types of 
migrations too.

one artificial simplification in the domain_distance() approach is the 
assumption that the domain tree is fundamentally 'symmetric', i.e. a 
domain 2 steps away from the bottom of the tree describes the same type 
of cache, no matter from which CPU we do this. The moment someone adds 
fundamental assymetry to the hardware, this approach has to be changed.

in the SN2 case i'm not sure there's any true assymetry on the hardware 
side, is there? Couldnt the domain tree be changed to match the hardware 
more - if yes, would there be any disadvantages?

	Ingo

-----
limit scheduler migration calibration to the affected CPU map.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/sched.h |    2 --
 kernel/sched.c        |   10 +++++-----
 2 files changed, 5 insertions(+), 7 deletions(-)

Index: linux-mm.q/include/linux/sched.h
===================================================================
--- linux-mm.q.orig/include/linux/sched.h
+++ linux-mm.q/include/linux/sched.h
@@ -650,8 +650,6 @@ extern void partition_sched_domains(cpum
  */
 extern unsigned int max_cache_size;
 
-extern void calibrate_migration_costs(void);
-
 #endif	/* CONFIG_SMP */
 
 
Index: linux-mm.q/kernel/sched.c
===================================================================
--- linux-mm.q.orig/kernel/sched.c
+++ linux-mm.q/kernel/sched.c
@@ -5482,7 +5482,7 @@ static unsigned long long measure_migrat
 	return 2 * max_cost * migration_factor / MIGRATION_FACTOR_SCALE;
 }
 
-void calibrate_migration_costs(void)
+static void calibrate_migration_costs(const cpumask_t *cpu_map)
 {
 	int cpu1 = -1, cpu2 = -1, cpu, orig_cpu = raw_smp_processor_id();
 	unsigned long j0, j1, distance, max_distance = 0;
@@ -5493,8 +5493,8 @@ void calibrate_migration_costs(void)
 	/*
 	 * First pass - calculate the cacheflush times:
 	 */
-	for_each_online_cpu(cpu1) {
-		for_each_online_cpu(cpu2) {
+	for_each_cpu_mask(cpu1, *cpu_map) {
+		for_each_cpu_mask(cpu2, *cpu_map) {
 			if (cpu1 == cpu2)
 				continue;
 			distance = domain_distance(cpu1, cpu2);
@@ -5511,7 +5511,7 @@ void calibrate_migration_costs(void)
 	 * Second pass - update the sched domain hierarchy with
 	 * the new cache-hot-time estimations:
 	 */
-	for_each_online_cpu(cpu) {
+	for_each_cpu_mask(cpu, *cpu_map) {
 		distance = 0;
 		for_each_domain(cpu, sd) {
 			sd->cache_hot_time = migration_cost[distance];
@@ -5924,7 +5924,7 @@ next_sg:
 	/*
 	 * Tune cache-hot values:
 	 */
-	calibrate_migration_costs();
+	calibrate_migration_costs(cpu_map);
 }
 /*
  * Set up scheduler domains and groups.  Callers must hold the hotplug lock.
