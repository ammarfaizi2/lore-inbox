Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932736AbWCQP0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932736AbWCQP0U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 10:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932737AbWCQP0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 10:26:20 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:32386 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932736AbWCQP0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 10:26:19 -0500
Date: Fri, 17 Mar 2006 09:26:11 -0600
From: Jack Steiner <steiner@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - Reduce overhead of calc_load
Message-ID: <20060317152611.GA4449@sgi.com>
References: <20060317145709.GA4296@sgi.com> <20060317145912.GA13207@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060317145912.GA13207@elte.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, count_active_tasks() calls both nr_running() & nr_interruptible().
Each of these functions does a "for_each_cpu" & reads values from the
runqueue of each cpu. Although this is not a lot of instructions, each
runqueue may be located on different node. Depending on the architecture,
a unique TLB entry may be required to access each runqueue. 

Since there may be more runqueues than cpu TLB entries, a scan of all runqueues 
can trash the TLB. Each memory reference incurs a TLB miss & refill.

In addition, the runqueue cacheline that contains nr_running & 
nr_uninterruptible may be evicted from the cache between the two passes.
This causes unnecessary cache misses.

Combining nr_running() & nr_interruptible() into a single function
substantially reduces the TLB & cache misses on large systems. This should 
have no measureable effect on smaller systems.

On a 128p IA64 system running a memory stress workload, the new function reduced
the overhead of calc_load() from 605 usec/call to 324 usec/call. 

(Same as previous patch except reorder extern as requested by Ingo)


	Signed-off-by: Jack Steiner <steiner@sgi.com>
	Acked-by: Ingo Molnar <mingo@elte.hu>

 include/linux/sched.h |    1 +
 kernel/sched.c        |   16 ++++++++++++++++
 kernel/timer.c        |    8 +++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)



Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h	2006-03-16 16:17:55.982340489 -0600
+++ linux/include/linux/sched.h	2006-03-17 09:23:44.847612520 -0600
@@ -99,6 +99,7 @@ DECLARE_PER_CPU(unsigned long, process_c
 extern int nr_processes(void);
 extern unsigned long nr_running(void);
 extern unsigned long nr_uninterruptible(void);
+extern unsigned long nr_active(void);
 extern unsigned long nr_iowait(void);
 
 #include <linux/time.h>
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c	2006-03-16 16:17:56.376832371 -0600
+++ linux/kernel/sched.c	2006-03-16 16:26:01.141002841 -0600
@@ -1655,6 +1655,22 @@ unsigned long nr_iowait(void)
 	return sum;
 }
 
+unsigned long nr_active(void)
+{
+	unsigned long i, running = 0, uninterruptible = 0;
+
+	for_each_online_cpu(i) {
+		running += cpu_rq(i)->nr_running;
+		uninterruptible += cpu_rq(i)->nr_uninterruptible;
+	}
+
+	if (unlikely((long)uninterruptible < 0))
+		uninterruptible = 0;
+
+	return running + uninterruptible;
+}
+
+
 #ifdef CONFIG_SMP
 
 /*
Index: linux/kernel/timer.c
===================================================================
--- linux.orig/kernel/timer.c	2006-03-16 16:17:56.385620556 -0600
+++ linux/kernel/timer.c	2006-03-16 16:26:01.141979306 -0600
@@ -849,7 +849,7 @@ void update_process_times(int user_tick)
  */
 static unsigned long count_active_tasks(void)
 {
-	return (nr_running() + nr_uninterruptible()) * FIXED_1;
+	return nr_active() * FIXED_1;
 }
 
 /*
