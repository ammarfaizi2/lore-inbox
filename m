Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268518AbTCAH0x>; Sat, 1 Mar 2003 02:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268520AbTCAH0x>; Sat, 1 Mar 2003 02:26:53 -0500
Received: from holomorphy.com ([66.224.33.161]:29833 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268518AbTCAH0w>;
	Sat, 1 Mar 2003 02:26:52 -0500
Date: Fri, 28 Feb 2003 23:36:55 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: percpu-2.5.63-bkcurr
Message-ID: <20030301073655.GA1195@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20030301055922.GB1399@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030301055922.GB1399@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 09:59:22PM -0800, William Lee Irwin III wrote:
> Shove per-cpu areas into node-local memory for i386 discontigmem,
> or at least NUMA-Q. You'll have to plop down early_cpu_to_node()
> and early_node_to_cpumask() stubs to use it on, say Summit.

Tentative followup #1 (thanks Zwane!)

Use per-cpu rq's in the sched.c to avoid remote cache misses there.
It actually means something now.


Index: linux-2.5.59/kernel/sched.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/kernel/sched.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 sched.c
--- linux-2.5.59/kernel/sched.c	17 Jan 2003 02:46:29 -0000	1.1.1.1
+++ linux-2.5.59/kernel/sched.c	17 Jan 2003 10:03:31 -0000
@@ -160,9 +160,9 @@
 	atomic_t nr_iowait;
 } ____cacheline_aligned;
 
-static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
+static DEFINE_PER_CPU(struct runqueue, runqueues) = {{ 0 }};
 
-#define cpu_rq(cpu)		(runqueues + (cpu))
+#define cpu_rq(cpu)		(&per_cpu(runqueues, cpu))
 #define this_rq()		cpu_rq(smp_processor_id())
 #define task_rq(p)		cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)

-- 
function.linuxpower.ca
