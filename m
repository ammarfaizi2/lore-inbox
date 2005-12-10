Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932785AbVLJMDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932785AbVLJMDa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 07:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932788AbVLJMDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 07:03:30 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:8606 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932785AbVLJMD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 07:03:29 -0500
Date: Sat, 10 Dec 2005 13:02:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: hawkes@sgi.com
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Dinakar Guniguntala <dino@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Jack Steiner <steiner@sgi.com>,
       Paul Jackson <pj@sgi.com>
Subject: [patch -mm] scheduler cache hot autodetect, print less
Message-ID: <20051210120232.GA25065@elte.hu>
References: <20051209205454.18325.46768.sendpatchset@tomahawk.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051209205454.18325.46768.sendpatchset@tomahawk.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* hawkes@sgi.com <hawkes@sgi.com> wrote:

> The essence of the bug is that the code and data in the CPU Scheduler 
> that perform the cost calculation are declared as "__initdata" or 
> "__init" or "__devinit", even though a runtime declaration of a 
> cpu-exclusive cpuset will invoke build_sched_domains() to rebuilt the 
> sched domains, and that calls the now-released 
> calibrate_migration_costs(), et al.  The attached patch changes the 
> declarations of the code and data to make them persistent.

ok.

Acked-by: Ingo Molnar <mingo@elte.hu>

> (1) calibrate_migration_costs() printk's the matrix at boot time, and
>     for large NR_CPUS values this can be voluminous.  We might consider
>     changing the naked printk()'s into printk(KERN_DEBUG ...) to hide
>     them to everyone but a sysadmin or developer who has a need to
>     view the values.

yeah, agreed.

> (2) calibrate_migration_costs() printk's the matrix for every call to
>     build_sched_domains(), which is called twice for each declaration
>     of a cpu-exclusive cpuset.  The syslog output is voluminous for
>     large NR_CPUS values.  It is unclear to me how interesting this
>     output is after the initial display at boot time.  Various Job
>     Manager software will actively create and destroy cpu-exclusive
>     cpusets, and that will flood the syslog with matrix output.

ok. I've changed the code to be less verbose: only the distance function 
is printed, not the full matrix. I have also made some other printks 
dependent on migration_debug (which is off by default). The boot-time 
output is now a minimalistic:

migration_cost=269,777

which can also be pasted into the kernel's boot command line to turn off 
calibration on the next bootup. Patch attached below, goes to the tail 
of the current scheduler queue in -mm.

[i'll reply to your other points in the next mail.]

	Ingo

----
be less verbose in the migration-cost printout.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 kernel/sched.c |   52 +++++++++++++---------------------------------------
 1 files changed, 13 insertions(+), 39 deletions(-)

Index: linux-mm.q/kernel/sched.c
===================================================================
--- linux-mm.q.orig/kernel/sched.c
+++ linux-mm.q/kernel/sched.c
@@ -5485,10 +5485,8 @@ static unsigned long long measure_migrat
 void calibrate_migration_costs(void)
 {
 	int cpu1 = -1, cpu2 = -1, cpu, orig_cpu = raw_smp_processor_id();
+	unsigned long j0, j1, distance, max_distance = 0;
 	struct sched_domain *sd;
-	unsigned long distance, max_distance = 0;
-	unsigned long long cost;
-	unsigned long j0, j1;
 
 	j0 = jiffies;
 
@@ -5502,14 +5500,11 @@ void calibrate_migration_costs(void)
 			distance = domain_distance(cpu1, cpu2);
 			max_distance = max(max_distance, distance);
 			/*
-			 * Do we have the result cached already?
+			 * No result cached yet?
 			 */
-			if (migration_cost[distance] != -1LL)
-				cost = migration_cost[distance];
-			else {
-				cost = measure_migration_cost(cpu1, cpu2);
-				migration_cost[distance] = cost;
-			}
+			if (migration_cost[distance] == -1LL)
+				migration_cost[distance] =
+					measure_migration_cost(cpu1, cpu2);
 		}
 	}
 	/*
@@ -5526,8 +5521,8 @@ void calibrate_migration_costs(void)
 	/*
 	 * Print the matrix:
 	 */
-	printk("---------------------\n");
-	printk("| migration cost matrix (max_cache_size: %d, cpu: %d MHz):\n",
+	if (migration_debug)
+		printk("migration: max_cache_size: %d, cpu: %d MHz:\n",
 			max_cache_size,
 #ifdef CONFIG_X86
 			cpu_khz/1000
@@ -5535,37 +5530,16 @@ void calibrate_migration_costs(void)
 			-1
 #endif
 		);
-	printk("---------------------\n");
-	printk("      ");
-	for_each_online_cpu(cpu1)
-		printk("    [%02d]", cpu1);
-	printk("\n");
-	for_each_online_cpu(cpu1) {
-		printk("[%02d]: ", cpu1);
-		for_each_online_cpu(cpu2) {
-			if (cpu1 == cpu2) {
-				printk("    -   ");
-				continue;
-			}
-			distance = domain_distance(cpu1, cpu2);
-			max_distance = max(max_distance, distance);
-			cost = migration_cost[distance];
-			printk(" %2ld.%ld(%ld)", (long)cost / 1000000,
-				((long)cost / 100000) % 10, distance);
-		}
-		printk("\n");
-	}
-	printk("--------------------------------\n");
-	printk("| cacheflush times [%ld]:", max_distance+1);
+	printk("migration_cost=");
 	for (distance = 0; distance <= max_distance; distance++) {
-		cost = migration_cost[distance];
-		printk(" %ld.%ld (%Ld)", (long)cost / 1000000,
-			((long)cost / 100000) % 10, cost);
+		if (distance)
+			printk(",");
+		printk("%ld", (long)migration_cost[distance] / 1000);
 	}
 	printk("\n");
 	j1 = jiffies;
-	printk("| calibration delay: %ld seconds\n", (j1-j0)/HZ);
-	printk("--------------------------------\n");
+	if (migration_debug)
+		printk("migration: %ld seconds\n", (j1-j0)/HZ);
 
 	/*
 	 * Move back to the original CPU. NUMA-Q gets confused
