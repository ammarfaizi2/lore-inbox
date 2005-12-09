Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbVLIUzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbVLIUzR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 15:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbVLIUzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 15:55:17 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:19618 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932413AbVLIUzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 15:55:15 -0500
Date: Fri, 9 Dec 2005 12:54:54 -0800 (PST)
From: hawkes@sgi.com
To: Nick Piggin <nickpiggin@yahoo.com.au>,
       Dinakar Guniguntala <dino@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Cc: Jack Steiner <steiner@sgi.com>, hawkes@sgi.com, Paul Jackson <pj@sgi.com>
Message-Id: <20051209205454.18325.46768.sendpatchset@tomahawk.engr.sgi.com>
Subject: [PATCH] -mm tree: broken "dynamic sched domains" and "migration cost"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As recently as 2.6.15-rc5-mm1 the combination of "migration cost matrix"
calculations and "dynamic sched domains" is broken.  This patch fixes
the basic bug, even though I still have larger problems with the
"migration cost matrix" concept as implemented.

The essence of the bug is that the code and data in the CPU Scheduler
that perform the cost calculation are declared as "__initdata" or
"__init" or "__devinit", even though a runtime declaration of a
cpu-exclusive cpuset will invoke build_sched_domains() to rebuilt
the sched domains, and that calls the now-released
calibrate_migration_costs(), et al.  The attached patch changes the
declarations of the code and data to make them persistent.

To review, to create a cpu-exclusive cpuset, do something like this:
   cd /dev/cpuset
   mkdir cpu0
   echo 0 > cpu0/cpus
   echo 0 > cpu0/mems
   echo 1 > cpu0/cpu_exclusive

Various other problems with "migration cost matrix" are not addressed
by this patch.  They are:

(1) calibrate_migration_costs() printk's the matrix at boot time, and
    for large NR_CPUS values this can be voluminous.  We might consider
    changing the naked printk()'s into printk(KERN_DEBUG ...) to hide
    them to everyone but a sysadmin or developer who has a need to
    view the values.

(2) calibrate_migration_costs() printk's the matrix for every call to
    build_sched_domains(), which is called twice for each declaration
    of a cpu-exclusive cpuset.  The syslog output is voluminous for
    large NR_CPUS values.  It is unclear to me how interesting this
    output is after the initial display at boot time.  Various Job
    Manager software will actively create and destroy cpu-exclusive
    cpusets, and that will flood the syslog with matrix output.

(3) For a cpu-exclusive cpuset cpu, the domain_distance() calculation 
    produces a legal value, but not a useful value.  That is to say,
    if cpu0 is isolated into a cpu-exclusive cpuset, then the semantic
    meaning of "domain distance" between cpu0 and another CPU outside of
    this cpu-exclusive is essentially undefined.  No load-balancing
    will occur in or out of this cpu-exclusive cpuset.  There is no
    need to measure_migration_cost() of any migrations in or out of
    a cpu-exclusive cpuset.

    The reason why this is significant is that measure_migration_cost()
    is expensive, and the creation of that cpu0 cpu-exclusive cpuset
    stalls the
        echo 1 > cpu0/cpu_exclusive
    about six seconds on a 64p ia64/sn2 platform, all to calculate
    a cost value that is never used.

(4) The expense of the migration_cost() calculation can be sizeable.
    It can be reduced somewhat by changing the 5% increments into 10%
    or even higher.  That reduces the boot-time "calibration delay"
    from 50 seconds down to 20 seconds (for the 64p ia64/sn2) for
    three levels of sched domains, and the declaration of a single
    cpu0 cpu-exclusive dynamic sched domain from 6 seconds down to 5
    (all to calculate that unnecessary new domain_distance).

(5) Besides, the migration cost between any two CPUs is something
    that can be calculated once at boot time and remembered
    thereafter.  I suspect the reason why the algorithm doesn't do
    this is that an exhaustive NxN calculation will be very slow for
    large NR_CPUS counts, which explains why the calculations are
    now done in the context of sched domains.

    However, simply calculating the migration cost for each "domain
    distance" presupposes that the sched domain groupings accurately
    reflect true migration costs.  For platforms like the ia64/sn2
    this is not true.  For example, a 64p ia64/sn2 will have three
    sched domain levels:  level zero is each 2-CPU pair within a
    node; level one is an SD_NODES_PER_DOMAIN-size arbitrary clump
    of 32 CPUs; level two is all 64 CPUs.  Looking at that middle
    level, if I understand the algorithm, there is one and only one
    migration_cost[1] calculation made for an arbitrary choice of one
    CPU in a 32-CPU clump and another CPU in that clump.  Reality is
    that there are various migration costs for different pairs of CPUs
    in that set of 32.  This is yet another reason why I believe we
    don't need to do those 5% size increments to get really accurate
    timings.

For now, here is the patch to avoid the basic bug:


Signed-off-by: John Hawkes <hawkes@sgi.com>

Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c	2005-12-09 09:26:04.000000000 -0800
+++ linux/kernel/sched.c	2005-12-09 10:53:28.000000000 -0800
@@ -5295,7 +5295,7 @@
 
 #define MIGRATION_FACTOR_SCALE 128
 
-static __initdata unsigned int migration_factor = MIGRATION_FACTOR_SCALE;
+static unsigned int migration_factor = MIGRATION_FACTOR_SCALE;
 
 static int __init setup_migration_factor(char *str)
 {
@@ -5310,7 +5310,7 @@
  * Estimated distance of two CPUs, measured via the number of domains
  * we have to pass for the two CPUs to be in the same span:
  */
-__devinit static unsigned long domain_distance(int cpu1, int cpu2)
+static unsigned long domain_distance(int cpu1, int cpu2)
 {
 	unsigned long distance = 0;
 	struct sched_domain *sd;
@@ -5329,7 +5329,7 @@
 	return distance;
 }
 
-static __initdata unsigned int migration_debug;
+static unsigned int migration_debug;
 
 static int __init setup_migration_debug(char *str)
 {
@@ -5345,7 +5345,7 @@
  * bootup. Gets used in the domain-setup code (i.e. during SMP
  * bootup).
  */
-__initdata unsigned int max_cache_size;
+unsigned int max_cache_size;
 
 static int __init setup_max_cache_size(char *str)
 {
@@ -5360,7 +5360,7 @@
  * is the operation that is timed, so we try to generate unpredictable
  * cachemisses that still end up filling the L2 cache:
  */
-__init static void touch_cache(void *__cache, unsigned long __size)
+static void touch_cache(void *__cache, unsigned long __size)
 {
 	unsigned long size = __size/sizeof(long), chunk1 = size/3,
 			chunk2 = 2*size/3;
@@ -5382,8 +5382,8 @@
 /*
  * Measure the cache-cost of one task migration. Returns in units of nsec.
  */
-__init static unsigned long long measure_one(void *cache, unsigned long size,
-					     int source, int target)
+static unsigned long long measure_one(void *cache, unsigned long size,
+				      int source, int target)
 {
 	cpumask_t mask, saved_mask;
 	unsigned long long t0, t1, t2, t3, cost;
@@ -5449,7 +5449,7 @@
  * Architectures can prime the upper limit of the search range via
  * max_cache_size, otherwise the search range defaults to 20MB...64K.
  */
-__init static unsigned long long
+static unsigned long long
 measure_cost(int cpu1, int cpu2, void *cache, unsigned int size)
 {
 	unsigned long long cost1, cost2;
@@ -5501,7 +5501,7 @@
 	return cost1 - cost2;
 }
 
-__devinit static unsigned long long measure_migration_cost(int cpu1, int cpu2)
+static unsigned long long measure_migration_cost(int cpu1, int cpu2)
 {
 	unsigned long long max_cost = 0, fluct = 0, avg_fluct = 0;
 	unsigned int max_size, size, size_found = 0;
@@ -5606,7 +5606,7 @@
 	return 2 * max_cost * migration_factor / MIGRATION_FACTOR_SCALE;
 }
 
-void __devinit calibrate_migration_costs(void)
+void calibrate_migration_costs(void)
 {
 	int cpu1 = -1, cpu2 = -1, cpu, orig_cpu = raw_smp_processor_id();
 	struct sched_domain *sd;
