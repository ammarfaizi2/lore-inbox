Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315821AbSEEEGh>; Sun, 5 May 2002 00:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315822AbSEEEGg>; Sun, 5 May 2002 00:06:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14099 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315821AbSEEEGe>;
	Sun, 5 May 2002 00:06:34 -0400
Message-ID: <3CD4B042.A4355FD3@zip.com.au>
Date: Sat, 04 May 2002 21:08:34 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] percpu updates
In-Reply-To: <3CD06ACE.1090402@didntduck.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> 
> These patches convert some of the existing arrays based on NR_CPUS to
> use the new per cpu code.
> 

Brian, I tested this patch (rediffed against 2.5.13, below)
on the quad Xeon and it failed.

The machine died when bringing up the secondary CPUs
("CPU#3 already started!" and "Unable to handle kernel...")

I backed out the sched.c part and the machine booted.  So
I guess the secondary CPU bringup code uses the scheduler
somehow.

And again, the numbers in /proc/meminfo are whacko:

LowFree:         94724 kB
SwapTotal:     4000040 kB
SwapFree:      3999700 kB
Dirty:            7232 kB
Writeback:    4294967264 kB

Which never happens with the open-coded per-cpu accumulators.
After a normal boot I see:

LowFree:         95804 kB
SwapTotal:     4000040 kB
SwapFree:      3999940 kB
Dirty:            1356 kB
Writeback:           0 kB


Now, it may be that some pages are being marked dirty before
the per-cpu areas are set up, but there's no way in which
any pages will have been marked for writeback by that time, so
that "-32" value is definitely wrong.

'fraid I have to do a whine-and-run on this problem, but
it does still appear that there is something fishy with
the percpu infrastructure.


--- 2.5.13/include/linux/page-flags.h~bgerst-pcpu	Thu May  2 19:21:12 2002
+++ 2.5.13-akpm/include/linux/page-flags.h	Thu May  2 19:23:11 2002
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
 	unsigned long nr_writeback;
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
++ 		this_cpu(page_states).member += (delta);		\
 		preempt_enable();					\
 	} while (0)
 
--- 2.5.13/kernel/sched.c~bgerst-pcpu	Thu May  2 19:21:12 2002
+++ 2.5.13-akpm/kernel/sched.c	Thu May  2 19:21:12 2002
@@ -22,6 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/completion.h>
 #include <linux/kernel_stat.h>
+#include <linux/percpu.h>
 
 /*
  * Priority of a process goes from 0 to 139. The 0-99
@@ -154,10 +155,18 @@ struct runqueue {
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
--- 2.5.13/mm/page_alloc.c~bgerst-pcpu	Thu May  2 19:21:12 2002
+++ 2.5.13-akpm/mm/page_alloc.c	Thu May  2 19:21:12 2002
@@ -576,7 +576,7 @@ unsigned long nr_buffermem_pages(void)
  * The result is unavoidably approximate - it can change
  * during and after execution of this function.
  */
-struct page_state page_states[NR_CPUS] __cacheline_aligned;
+struct page_state __per_cpu_data page_states;
 EXPORT_SYMBOL(page_states);
 
 void get_page_state(struct page_state *ret)
@@ -590,7 +590,7 @@ void get_page_state(struct page_state *r
 	for (pcpu = 0; pcpu < smp_num_cpus; pcpu++) {
 		struct page_state *ps;
 
-		ps = &page_states[cpu_logical_map(pcpu)];
+		ps = &per_cpu(page_states,cpu_logical_map(pcpu));
 		ret->nr_dirty += ps->nr_dirty;
 		ret->nr_writeback += ps->nr_writeback;
 		ret->nr_pagecache += ps->nr_pagecache;
--- 2.5.13/mm/page-writeback.c~bgerst-pcpu	Thu May  2 19:21:12 2002
+++ 2.5.13-akpm/mm/page-writeback.c	Thu May  2 19:22:25 2002
@@ -20,6 +20,7 @@
 #include <linux/writeback.h>
 #include <linux/init.h>
 #include <linux/sysrq.h>
+#include <linux/percpu.h>
 
 /*
  * Memory thresholds, in percentages
@@ -103,15 +104,12 @@ void balance_dirty_pages(struct address_
  */
 void balance_dirty_pages_ratelimited(struct address_space *mapping)
 {
-	static struct rate_limit_struct {
-		int count;
-	} ____cacheline_aligned ratelimits[NR_CPUS];
-	int cpu;
+	static int __per_cpu_data ratelimits;
 
 	preempt_disable();
 	cpu = smp_processor_id();
-	if (ratelimits[cpu].count++ >= 1000) {
-		ratelimits[cpu].count = 0;
+	if (this_cpu(ratelimits)++ >= 1000) {
+		this_cpu(ratelimits) = 0;
 		preempt_enable();
 		balance_dirty_pages(mapping);
 		return;
--- 2.5.13/net/socket.c~bgerst-pcpu	Thu May  2 19:21:12 2002
+++ 2.5.13-akpm/net/socket.c	Thu May  2 19:21:12 2002
@@ -74,6 +74,7 @@
 #include <linux/cache.h>
 #include <linux/module.h>
 #include <linux/highmem.h>
+#include <linux/percpu.h>
 
 #if defined(CONFIG_KMOD) && defined(CONFIG_NET)
 #include <linux/kmod.h>
@@ -181,10 +182,7 @@ static __inline__ void net_family_read_u
  *	Statistics counters of the socket lists
  */
 
-static union {
-	int	counter;
-	char	__pad[SMP_CACHE_BYTES];
-} sockets_in_use[NR_CPUS] __cacheline_aligned = {{0}};
+static int __per_cpu_data sockets_in_use;
 
 /*
  *	Support routines. Move socket addresses back and forth across the kernel/user
@@ -498,7 +496,7 @@ struct socket *sock_alloc(void)
 	inode->i_uid = current->fsuid;
 	inode->i_gid = current->fsgid;
 
-	sockets_in_use[smp_processor_id()].counter++;
+	this_cpu(sockets_in_use)++;
 	return sock;
 }
 
@@ -530,7 +528,7 @@ void sock_release(struct socket *sock)
 	if (sock->fasync_list)
 		printk(KERN_ERR "sock_release: fasync list not empty!\n");
 
-	sockets_in_use[smp_processor_id()].counter--;
+	this_cpu(sockets_in_use)--;
 	if (!sock->file) {
 		iput(SOCK_INODE(sock));
 		return;
@@ -1774,7 +1772,7 @@ int socket_get_info(char *buffer, char *
 	int counter = 0;
 
 	for (cpu=0; cpu<smp_num_cpus; cpu++)
-		counter += sockets_in_use[cpu_logical_map(cpu)].counter;
+		counter += per_cpu(sockets_in_use,cpu_logical_map(cpu));
 
 	/* It can be negative, by the way. 8) */
 	if (counter < 0)
