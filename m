Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314073AbSEAW0B>; Wed, 1 May 2002 18:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314075AbSEAW0A>; Wed, 1 May 2002 18:26:00 -0400
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:44695 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S314073AbSEAWZ5>; Wed, 1 May 2002 18:25:57 -0400
Message-ID: <3CD06ACE.1090402@didntduck.org>
Date: Wed, 01 May 2002 18:23:10 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Dave Jones <davej@suse.de>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] percpu updates
Content-Type: multipart/mixed;
 boundary="------------010703050401080200060408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010703050401080200060408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

These patches convert some of the existing arrays based on NR_CPUS to 
use the new per cpu code.

-- 

						Brian Gerst

--------------010703050401080200060408
Content-Type: text/plain;
 name="percpu-page_states"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="percpu-page_states"

diff -urN linux-2.5.12/include/linux/page-flags.h linux/include/linux/page-flags.h
--- linux-2.5.12/include/linux/page-flags.h	Wed May  1 08:40:14 2002
+++ linux/include/linux/page-flags.h	Wed May  1 11:51:43 2002
@@ -42,6 +42,8 @@
  * address space...
  */
 
+#include <linux/percpu.h>
+
 /*
  * Don't use the *_dontuse flags.  Use the macros.  Otherwise you'll break
  * locked- and dirty-page accounting.  The top eight bits of page->flags are
@@ -69,18 +71,20 @@
 /*
  * Global page accounting.  One instance per CPU.
  */
-extern struct page_state {
+struct page_state {
 	unsigned long nr_dirty;
 	unsigned long nr_locked;
 	unsigned long nr_pagecache;
-} ____cacheline_aligned_in_smp page_states[NR_CPUS];
+};
+
+extern struct page_state __per_cpu_data page_states;
 
 extern void get_page_state(struct page_state *ret);
 
 #define mod_page_state(member, delta)					\
 	do {								\
 		preempt_disable();					\
-		page_states[smp_processor_id()].member += (delta);	\
+		this_cpu(page_states).member += (delta);		\
 		preempt_enable();					\
 	} while (0)
 
diff -urN linux-2.5.12/mm/page_alloc.c linux/mm/page_alloc.c
--- linux-2.5.12/mm/page_alloc.c	Wed May  1 08:40:14 2002
+++ linux/mm/page_alloc.c	Wed May  1 11:51:05 2002
@@ -576,7 +576,7 @@
  * The result is unavoidably approximate - it can change
  * during and after execution of this function.
  */
-struct page_state page_states[NR_CPUS] __cacheline_aligned;
+struct page_state __per_cpu_data page_states;
 EXPORT_SYMBOL(page_states);
 
 void get_page_state(struct page_state *ret)
@@ -590,7 +590,7 @@
 	for (pcpu = 0; pcpu < smp_num_cpus; pcpu++) {
 		struct page_state *ps;
 
-		ps = &page_states[cpu_logical_map(pcpu)];
+		ps = &per_cpu(page_states,cpu_logical_map(pcpu));
 		ret->nr_dirty += ps->nr_dirty;
 		ret->nr_locked += ps->nr_locked;
 		ret->nr_pagecache += ps->nr_pagecache;

--------------010703050401080200060408
Content-Type: text/plain;
 name="percpu-ratelimits"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="percpu-ratelimits"

diff -urN linux-2.5.12/mm/page-writeback.c linux/mm/page-writeback.c
--- linux-2.5.12/mm/page-writeback.c	Wed May  1 08:40:14 2002
+++ linux/mm/page-writeback.c	Wed May  1 10:56:24 2002
@@ -20,6 +20,7 @@
 #include <linux/writeback.h>
 #include <linux/init.h>
 #include <linux/sysrq.h>
+#include <linux/percpu.h>
 
 /*
  * Memory thresholds, in percentages
@@ -102,15 +103,11 @@
  */
 void balance_dirty_pages_ratelimited(struct address_space *mapping)
 {
-	static struct rate_limit_struct {
-		int count;
-	} ____cacheline_aligned ratelimits[NR_CPUS];
-	int cpu;
+	static int __per_cpu_data ratelimits;
 
 	preempt_disable();
-	cpu = smp_processor_id();
-	if (ratelimits[cpu].count++ >= 32) {
-		ratelimits[cpu].count = 0;
+	if (this_cpu(ratelimits)++ >= 32) {
+		this_cpu(ratelimits) = 0;
 		preempt_enable();
 		balance_dirty_pages(mapping);
 		return;

--------------010703050401080200060408
Content-Type: text/plain;
 name="percpu-runqueue"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="percpu-runqueue"

diff -urN linux-2.5.12/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.12/kernel/sched.c	Wed May  1 08:40:14 2002
+++ linux/kernel/sched.c	Wed May  1 11:53:07 2002
@@ -22,6 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/completion.h>
 #include <linux/kernel_stat.h>
+#include <linux/percpu.h>
 
 /*
  * Priority of a process goes from 0 to 139. The 0-99
@@ -154,10 +155,18 @@
 	list_t migration_queue;
 } ____cacheline_aligned;
 
-static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
+static struct runqueue __per_cpu_data runqueues;
+
+static inline struct runqueue *cpu_rq(int cpu)
+{
+	return &per_cpu(runqueues, cpu);
+}
+
+static inline struct runqueue *this_rq(void)
+{
+	return &this_cpu(runqueues);
+}
 
-#define cpu_rq(cpu)		(runqueues + (cpu))
-#define this_rq()		cpu_rq(smp_processor_id())
 #define task_rq(p)		cpu_rq((p)->thread_info->cpu)
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)

--------------010703050401080200060408
Content-Type: text/plain;
 name="percpu-sockets"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="percpu-sockets"

diff -urN linux-2.5.12-percpu/net/socket.c linux/net/socket.c
--- linux-2.5.12-percpu/net/socket.c	Wed Apr 10 19:59:40 2002
+++ linux/net/socket.c	Wed May  1 11:59:25 2002
@@ -74,6 +74,7 @@
 #include <linux/cache.h>
 #include <linux/module.h>
 #include <linux/highmem.h>
+#include <linux/percpu.h>
 
 #if defined(CONFIG_KMOD) && defined(CONFIG_NET)
 #include <linux/kmod.h>
@@ -181,10 +182,7 @@
  *	Statistics counters of the socket lists
  */
 
-static union {
-	int	counter;
-	char	__pad[SMP_CACHE_BYTES];
-} sockets_in_use[NR_CPUS] __cacheline_aligned = {{0}};
+static int __per_cpu_data sockets_in_use;
 
 /*
  *	Support routines. Move socket addresses back and forth across the kernel/user
@@ -498,7 +496,7 @@
 	inode->i_uid = current->fsuid;
 	inode->i_gid = current->fsgid;
 
-	sockets_in_use[smp_processor_id()].counter++;
+	this_cpu(sockets_in_use)++;
 	return sock;
 }
 
@@ -530,7 +528,7 @@
 	if (sock->fasync_list)
 		printk(KERN_ERR "sock_release: fasync list not empty!\n");
 
-	sockets_in_use[smp_processor_id()].counter--;
+	this_cpu(sockets_in_use)--;
 	if (!sock->file) {
 		iput(SOCK_INODE(sock));
 		return;
@@ -1774,7 +1772,7 @@
 	int counter = 0;
 
 	for (cpu=0; cpu<smp_num_cpus; cpu++)
-		counter += sockets_in_use[cpu_logical_map(cpu)].counter;
+		counter += per_cpu(sockets_in_use,cpu_logical_map(cpu));
 
 	/* It can be negative, by the way. 8) */
 	if (counter < 0)

--------------010703050401080200060408--

