Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262471AbVG2I3C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbVG2I3C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 04:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbVG2I3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 04:29:02 -0400
Received: from mx2.elte.hu ([157.181.151.9]:10434 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262445AbVG2I3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 04:29:00 -0400
Date: Fri, 29 Jul 2005 10:28:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: Keith Owens <kaos@ocs.com.au>, David.Mosberger@acm.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Add prefetch switch stack hook in scheduler function
Message-ID: <20050729082826.GA6144@elte.hu>
References: <20050729070447.GA3032@elte.hu> <200507290722.j6T7Mig07477@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507290722.j6T7Mig07477@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:

> On ia64, we have two kernel stacks, one for outgoing task, and one for 
> incoming task.  for outgoing task, we haven't called switch_to() yet. 
> So the switch stack structure for 'current' will be allocated 
> immediately below current 'sp' pointer. For the incoming task, it was 
> fully ctx'ed out previously, so switch stack structure is immediate 
> above kernel_stack(next). It Would be beneficial to prefetch both 
> stacks.

ok, could you apply the two patches below? The first one implements 
prefetchw_range(), the second one makes use of it to prefetch the 
outgoing stack for writes. We can actually do the current task 
prefetching much earlier, because unlike the next task, we know its 
stack pointer right away, so this patch could have some additional 
benefits.

btw., i'm not totally convinced this is needed, because even in a 
context-switch-intense workload (as DB workloads are), i'd expect the 
outgoing task to still have a hot switch-stack, either due to having 
context-switched recently, or due to having done some deeper kernel 
function call recently. The next task will likely be cache-cold, but the 
current task is usually cache-hot. Maybe not cache-hot to a depth of 528 
bytes, but it needs to be measured: it would be nice to benchmark the 
effects of this particular patch in isolation as well, so that we know 
the breakdown.

	Ingo

----
introduce prefetchw_range(addr, len).

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/prefetch.h |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+)

Index: linux-prefetch-task/include/linux/prefetch.h
===================================================================
--- linux-prefetch-task.orig/include/linux/prefetch.h
+++ linux-prefetch-task/include/linux/prefetch.h
@@ -93,4 +93,43 @@ static inline void prefetch_range(void *
 #endif
 }
 
+static inline void prefetchw_range(void *addr, size_t len)
+{
+#ifdef ARCH_HAS_PREFETCH
+	char *cp = addr;
+	char *end = addr + len;
+
+	/*
+	 * Unroll agressively:
+	 */
+	if (len <= PREFETCH_STRIDE)
+		prefetchw(cp);
+	else if (len <= 2*PREFETCH_STRIDE) {
+		prefetchw(cp);
+		prefetchw(cp + PREFETCH_STRIDE);
+	}
+	else if (len <= 3*PREFETCH_STRIDE) {
+		prefetchw(cp);
+		prefetchw(cp + PREFETCH_STRIDE);
+		prefetchw(cp + 2*PREFETCH_STRIDE);
+	}
+	else if (len <= 4*PREFETCH_STRIDE) {
+		prefetchw(cp);
+		prefetchw(cp + PREFETCH_STRIDE);
+		prefetchw(cp + 2*PREFETCH_STRIDE);
+		prefetchw(cp + 3*PREFETCH_STRIDE);
+	}
+	else if (len <= 5*PREFETCH_STRIDE) {
+		prefetchw(cp);
+		prefetchw(cp + PREFETCH_STRIDE);
+		prefetchw(cp + 2*PREFETCH_STRIDE);
+		prefetchw(cp + 3*PREFETCH_STRIDE);
+		prefetchw(cp + 4*PREFETCH_STRIDE);
+	} else
+		for (; cp < end; cp += PREFETCH_STRIDE)
+			prefetchw(cp);
+#endif
+}
+
+
 #endif

-----

prefetch the current kernel stack for writing.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 kernel/sched.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

Index: linux-prefetch-task/kernel/sched.c
===================================================================
--- linux-prefetch-task.orig/kernel/sched.c
+++ linux-prefetch-task/kernel/sched.c
@@ -2754,6 +2754,12 @@ asmlinkage void __sched schedule(void)
 	int cpu, idx, new_prio;
 
 	/*
+	 * Prefetch the current stack for writing (we use switch_count's
+	 * address to get to the stack pointer):
+	 */
+	prefetchw_range((void *)&switch_count - MIN_KERNEL_STACK_FOOTPRINT,
+		       MIN_KERNEL_STACK_FOOTPRINT + L1_CACHE_BYTES);
+	/*
 	 * Test if we are atomic.  Since do_exit() needs to call into
 	 * schedule() atomically, we ignore that path for now.
 	 * Otherwise, whine if we are scheduling when we should not be.
@@ -2872,10 +2878,10 @@ go_idle:
 	/*
 	 * Prefetch (at least) a cacheline below the current
 	 * kernel stack (in expectation of any new task touching
-	 * the stack at least minimally), and a cacheline above
-	 * the stack:
+	 * the stack at least minimally), and at least a cacheline
+	 * above the stack:
 	 */
-	prefetch_range(kernel_stack(next) - MIN_KERNEL_STACK_FOOTPRINT,
+	prefetch_range(kernel_stack(next) - L1_CACHE_BYTES,
 		       MIN_KERNEL_STACK_FOOTPRINT + L1_CACHE_BYTES);
 	prefetch(next->mm);
 
