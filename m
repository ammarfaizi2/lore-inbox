Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbTKHC6s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 21:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbTKHC6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 21:58:48 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:13842 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S261552AbTKHC6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 21:58:45 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: steiner@sgi.com (Jack Steiner), davem@redhat.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] - Incorrect cpumask definition in net/core/flow.c
Organization: Core
In-Reply-To: <20031107210848.GA10774@sgi.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.2-20031002 ("Berneray") (UNIX) (Linux/2.4.22-1-686-smp (i686))
Message-Id: <E1AIJIT-0002q9-00@gondolin.me.apana.org.au>
Date: Sat, 08 Nov 2003 13:57:57 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack Steiner <steiner@sgi.com> wrote:
> This fixes a problem in net/core/flow.c. 
> 
> The field "cpumap" is defined as a "unsigned long". It 
> should be a "cpumask_t".

Thanks.  Here is a patch that changes the operations on the maps as well
for consistency.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
Index: kernel-source-2.5/net/core/flow.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/net/core/flow.c,v
retrieving revision 1.8
diff -u -r1.8 flow.c
--- kernel-source-2.5/net/core/flow.c	11 Oct 2003 06:29:28 -0000	1.8
+++ kernel-source-2.5/net/core/flow.c	8 Nov 2003 02:54:01 -0000
@@ -19,6 +19,7 @@
 #include <linux/bitops.h>
 #include <linux/notifier.h>
 #include <linux/cpu.h>
+#include <linux/cpumask.h>
 #include <net/flow.h>
 #include <asm/atomic.h>
 #include <asm/semaphore.h>
@@ -65,7 +66,7 @@
 
 struct flow_flush_info {
 	atomic_t cpuleft;
-	unsigned long cpumap;
+	cpumask_t cpumap;
 	struct completion completion;
 };
 static DEFINE_PER_CPU(struct tasklet_struct, flow_flush_tasklets) = { NULL };
@@ -73,7 +74,7 @@
 #define flow_flush_tasklet(cpu) (&per_cpu(flow_flush_tasklets, cpu))
 
 static DECLARE_MUTEX(flow_cache_cpu_sem);
-static unsigned long flow_cache_cpu_map;
+static cpumask_t flow_cache_cpu_map;
 static unsigned int flow_cache_cpu_count;
 
 static void flow_cache_new_hashrnd(unsigned long arg)
@@ -81,7 +82,7 @@
 	int i;
 
 	for (i = 0; i < NR_CPUS; i++)
-		if (test_bit(i, &flow_cache_cpu_map))
+		if (cpu_isset(i, flow_cache_cpu_map))
 			flow_hash_rnd_recalc(i) = 1;
 
 	flow_hash_rnd_timer.expires = jiffies + FLOW_HASH_RND_PERIOD;
@@ -178,7 +179,7 @@
 	cpu = smp_processor_id();
 
 	fle = NULL;
-	if (!test_bit(cpu, &flow_cache_cpu_map))
+	if (!cpu_isset(cpu, flow_cache_cpu_map))
 		goto nocache;
 
 	if (flow_hash_rnd_recalc(cpu))
@@ -277,7 +278,7 @@
 	struct tasklet_struct *tasklet;
 
 	cpu = smp_processor_id();
-	if (!test_bit(cpu, &info->cpumap))
+	if (!cpu_isset(cpu, info->cpumap))
 		return;
 
 	tasklet = flow_flush_tasklet(cpu);
@@ -301,7 +302,7 @@
 
 	local_bh_disable();
 	smp_call_function(flow_cache_flush_per_cpu, &info, 1, 0);
-	if (test_bit(smp_processor_id(), &info.cpumap))
+	if (cpu_isset(smp_processor_id(), info.cpumap))
 		flow_cache_flush_tasklet((unsigned long)&info);
 	local_bh_enable();
 
@@ -341,7 +342,7 @@
 static int __devinit flow_cache_cpu_online(int cpu)
 {
 	down(&flow_cache_cpu_sem);
-	set_bit(cpu, &flow_cache_cpu_map);
+	cpu_set(cpu, flow_cache_cpu_map);
 	flow_cache_cpu_count++;
 	up(&flow_cache_cpu_sem);
 
