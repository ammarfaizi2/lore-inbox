Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267345AbUITVas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267345AbUITVas (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 17:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267363AbUITVas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 17:30:48 -0400
Received: from holomorphy.com ([207.189.100.168]:39873 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267345AbUITVa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 17:30:29 -0400
Date: Mon, 20 Sep 2004 14:30:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: John Hawkes <hawkes@sgi.com>, Ray Bryant <raybry@sgi.com>,
       Jesse Barnes <jbarnes@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: [profile] fix timer interrupt livelock on 512x Altix
Message-ID: <20040920213020.GX9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been informed that /proc/profile livelocks some systems in the
timer interrupt, usually at boot. The following patch attempts to 
amortize the atomic operations done on the profile buffer to address 
this stability concern. This patch has nothing to do with performance;
kernels using periodic timer interrupts are under realtime constraints
to complete whatever work they perform within timer interrupts before
the next timer interrupt arrives lest they livelock, performing no work
whatsoever apart from servicing timer interrupts. The latency of the
cacheline bounce for prof_buffer contributes to the time spent in the
timer interrupt, hence it must be amortized when remote access latencies
or deviations from fair exclusive cacheline acquisition may cause
cacheline bounces to take longer than the interval between timer ticks.

What this patch does is to create a pair of per-cpu open-addressed
hashtables indexed by profile buffer slot holding values representing
the number of pending profile buffer hits for the profile buffer slot.
When this hashtable overflows, one iterates over the hashtable
accounting each of the pairs of profile buffer slots and hit counts to
the global profile buffer. Zero is a legitimate profile buffer slot, so
zero hit counts represent unused hashtable entries. The hashtable is
furthermore protected from flush IPI's by interrupt disablement.

In order to flush the pending profile hits for read_profile(), this
patch flips betweeen the pairs of per-cpu profile buffer by signalling
all cpus to flip via IPI at the time of read_profile(), followed by
doing all the work to flush the profile hits from the older per-cpu
buffers in the context of the caller of read_profile(), with exclusion
provided by a semaphore ensuring that only one caller of
profile_flip_buffers() may execute at a time, and using interrupt
disablement to prevent buffer flip IPI's from altering the hashtables
or flip state while an update is in progress. The flip state is per-cpu
so that remote cpus need only disable interrupts locally for
synchronization, which is both simple and busywait-free for remote
cpus. The flip states all change in tandem when some cpu requests the
hashtables be flipped, and the requester waits for the completion of
smp_call_function() for notification that all cpus have finished
flipping between their hashtables. The IPI handler merely toggles the
flip state (which is an array index) between 0 and 1.

This is expected to be a much stronger amortization than merely reducing
the frequency of profile buffer access by a factor of the size of the
hashtable because numerous hits may be held for each of its entries.
This reduces what was before the patch a number of atomic increments
equal to what after the patch becomes the sum of the hits held for each
entry in the hashtable, to a number of atomic_add()'s equal to the
number of entries in the per_cpu hashtable. This is nondeterministic,
but as the profile hits tend to be concentrated in a very small number
of profile buffer slots during any given timing interval, is likely to
represent a very large number of atomic increments. This amortization
of atomic increments does not depend on the hash function, only the
sharp peakedness of the  distribution of profile buffer hits.

This algorithm has two advantages over full-size per-cpu profile
buffers. The first is that the space footprint is much smaller. Per-cpu
profile buffers would increase the space requirements by a factor of
num_online_cpus(), where this algorithm only requires one page per
cpu. The second is that reading the profile state is much faster,
because the state that must be traversed is exactly the above space
consumers, and the relative reduction in size concomitantly reduces
the time required for a read operation.

I also took the liberty of adding some commentary to the comments at
the beginning of the file reflecting the major work done on profile.c
in recent months and describing what the file implements.

The reporters of this issue have verified that this resolves their
timer interrupt livelock on 512x Altixen. In my own testing on 4x
logical x86-64, this patch saw a rate of about 18 flushes per minute
under load, or about one flush every 3 seconds, for about 38.4 atomic
accesses to the profile buffer per second per cpu in one of the
algorithm's worst cases, about 3.84% of the number of atomic profile
buffer accesses per second per cpu as a normal kernel would commit.
This represents a twenty-six-fold increase in the scalability on SMP
systems with 4KB PAGE_SIZE, i.e. with a 4KB PAGE_SIZE, the number of
atomic profile buffer accesses per second per cpu is reduced by a
factor of 26, thereby increasing the number of cpus a system must have
before it would experience a timer interrupt livelock by a factor of 26,
with the proviso that cacheline bounces must take the same amount of
time to service. This increase in the scalability of the kernel is
expected to be much larger for ia64, which has a large PAGE_SIZE,
because the distribution of profile buffer hits is so sharply peaked
that doubling the hashtable size will much more than double the
amortization factor. In fact, only 19 flushes were observed on a 64x
Altix over an approximately 10 minute AIM7 run, and 1 flush on a 512x
Altix over the course of an entire AIM7 run, for truly vast effective
amortization factors.


Index: mm1-2.6.9-rc2/kernel/profile.c
===================================================================
--- mm1-2.6.9-rc2.orig/kernel/profile.c	2004-09-12 22:33:37.000000000 -0700
+++ mm1-2.6.9-rc2/kernel/profile.c	2004-09-19 13:36:11.389310256 -0700
@@ -1,5 +1,16 @@
 /*
  *  linux/kernel/profile.c
+ *  Simple profiling. Manages a direct-mapped profile hit count buffer,
+ *  with configurable resolution, support for restricting the cpus on
+ *  which profiling is done, and switching between cpu time and
+ *  schedule() calls via kernel command line parameters passed at boot.
+ *
+ *  Scheduler profiling support, Arjan van de Ven and Ingo Molnar,
+ *	Red Hat, July 2004
+ *  Consolidation of architecture support code for profiling,
+ *	William Irwin, Oracle, July 2004
+ *  Amortized hit count accounting via per-cpu open-addressed hashtables
+ *	to resolve timer interrupt livelocks, William Irwin, Oracle, 2004
  */
 
 #include <linux/config.h>
@@ -9,13 +20,28 @@
 #include <linux/notifier.h>
 #include <linux/mm.h>
 #include <linux/cpumask.h>
+#include <linux/cpu.h>
 #include <linux/profile.h>
 #include <asm/sections.h>
+#include <asm/semaphore.h>
+
+struct profile_hit {
+	u32 pc, hits;
+};
+#define PROFILE_GRPSHIFT	3
+#define PROFILE_GRPSZ		(1 << PROFILE_GRPSHIFT)
+#define NR_PROFILE_HIT		(PAGE_SIZE/sizeof(struct profile_hit))
+#define NR_PROFILE_GRP		(NR_PROFILE_HIT/PROFILE_GRPSZ)
 
 static atomic_t *prof_buffer;
 static unsigned long prof_len, prof_shift;
 static int prof_on;
 static cpumask_t prof_cpu_mask = CPU_MASK_ALL;
+#ifdef CONFIG_SMP
+static DEFINE_PER_CPU(struct profile_hit *[2], cpu_profile_hits);
+static DEFINE_PER_CPU(int, cpu_profile_flip);
+static DECLARE_MUTEX(profile_flip_mutex);
+#endif /* CONFIG_SMP */
 
 static int __init profile_setup(char * str)
 {
@@ -181,6 +207,179 @@
 EXPORT_SYMBOL_GPL(profile_event_register);
 EXPORT_SYMBOL_GPL(profile_event_unregister);
 
+#ifdef CONFIG_SMP
+/*
+ * Each cpu has a pair of open-addressed hashtables for pending
+ * profile hits. read_profile() IPI's all cpus to request them
+ * to flip buffers and flushes their contents to prof_buffer itself.
+ * Flip requests are serialized by the profile_flip_mutex. The sole
+ * use of having a second hashtable is for avoiding cacheline
+ * contention that would otherwise happen during flushes of pending
+ * profile hits required for the accuracy of reported profile hits
+ * and so resurrect the interrupt livelock issue.
+ *
+ * The open-addressed hashtables are indexed by profile buffer slot
+ * and hold the number of pending hits to that profile buffer slot on
+ * a cpu in an entry. When the hashtable overflows, all pending hits
+ * are accounted to their corresponding profile buffer slots with
+ * atomic_add() and the hashtable emptied. As numerous pending hits
+ * may be accounted to a profile buffer slot in a hashtable entry,
+ * this amortizes a number of atomic profile buffer increments likely
+ * to be far larger than the number of entries in the hashtable,
+ * particularly given that the number of distinct profile buffer
+ * positions to which hits are accounted during short intervals (e.g.
+ * several seconds) is usually very small. Exclusion from buffer
+ * flipping is provided by interrupt disablement (note that for
+ * SCHED_PROFILING profile_hit() may be called from process context).
+ * The hash function is meant to be lightweight as opposed to strong,
+ * and was vaguely inspired by ppc64 firmware-supported inverted
+ * pagetable hash functions, but uses a full hashtable full of finite
+ * collision chains, not just pairs of them.
+ *
+ * -- wli
+ */
+static void __profile_flip_buffers(void *unused)
+{
+	int cpu = smp_processor_id();
+
+	per_cpu(cpu_profile_flip, cpu) = !per_cpu(cpu_profile_flip, cpu);
+}
+
+static void profile_flip_buffers(void)
+{
+	int i, j, cpu;
+
+	down(&profile_flip_mutex);
+	j = per_cpu(cpu_profile_flip, get_cpu());
+	put_cpu();
+	on_each_cpu(__profile_flip_buffers, NULL, 0, 1);
+	for_each_online_cpu(cpu) {
+		struct profile_hit *hits = per_cpu(cpu_profile_hits, cpu)[j];
+		for (i = 0; i < NR_PROFILE_HIT; ++i) {
+			if (!hits[i].hits) {
+				if (hits[i].pc)
+					hits[i].pc = 0;
+				continue;
+			}
+			atomic_add(hits[i].hits, &prof_buffer[hits[i].pc]);
+			hits[i].hits = hits[i].pc = 0;
+		}
+	}
+	up(&profile_flip_mutex);
+}
+
+static void profile_discard_flip_buffers(void)
+{
+	int i, cpu;
+
+	down(&profile_flip_mutex);
+	i = per_cpu(cpu_profile_flip, get_cpu());
+	put_cpu();
+	on_each_cpu(__profile_flip_buffers, NULL, 0, 1);
+	for_each_online_cpu(cpu) {
+		struct profile_hit *hits = per_cpu(cpu_profile_hits, cpu)[i];
+		memset(hits, 0, NR_PROFILE_HIT*sizeof(struct profile_hit));
+	}
+	up(&profile_flip_mutex);
+}
+
+void profile_hit(int type, void *__pc)
+{
+	unsigned long primary, secondary, flags, pc = (unsigned long)__pc;
+	int i, j, cpu;
+	struct profile_hit *hits;
+
+	if (prof_on != type || !prof_buffer)
+		return;
+	pc = min((pc - (unsigned long)_stext) >> prof_shift, prof_len - 1);
+	i = primary = (pc & (NR_PROFILE_GRP - 1)) << PROFILE_GRPSHIFT;
+	secondary = (~(pc << 1) & (NR_PROFILE_GRP - 1)) << PROFILE_GRPSHIFT;
+	cpu = get_cpu();
+	hits = per_cpu(cpu_profile_hits, cpu)[per_cpu(cpu_profile_flip, cpu)];
+	if (!hits) {
+		put_cpu();
+		return;
+	}
+	local_irq_save(flags);
+	do {
+		for (j = 0; j < PROFILE_GRPSZ; ++j) {
+			if (hits[i + j].pc == pc) {
+				hits[i + j].hits++;
+				goto out;
+			} else if (!hits[i + j].hits) {
+				hits[i + j].pc = pc;
+				hits[i + j].hits = 1;
+				goto out;
+			}
+		}
+		i = (i + secondary) & (NR_PROFILE_HIT - 1);
+	} while (i != primary);
+	atomic_inc(&prof_buffer[pc]);
+	for (i = 0; i < NR_PROFILE_HIT; ++i) {
+		atomic_add(hits[i].hits, &prof_buffer[hits[i].pc]);
+		hits[i].pc = hits[i].hits = 0;
+	}
+out:
+	local_irq_restore(flags);
+	put_cpu();
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+static int __devinit profile_cpu_callback(struct notifier_block *info,
+					unsigned long action, void *__cpu)
+{
+	int node, cpu = (unsigned long)__cpu;
+	struct page *page;
+
+	switch (action) {
+	case CPU_UP_PREPARE:
+		node = cpu_to_node(cpu);
+		per_cpu(cpu_profile_flip, cpu) = 0;
+		if (!per_cpu(cpu_profile_hits, cpu)[1]) {
+			page = alloc_pages_node(node, GFP_KERNEL, 0);
+			if (!page)
+				return NOTIFY_BAD;
+			clear_highpage(page);
+			per_cpu(cpu_profile_hits, cpu)[1] = page_address(page);
+		}
+		if (!per_cpu(cpu_profile_hits, cpu)[0]) {
+			page = alloc_pages_node(node, GFP_KERNEL, 0);
+			if (!page)
+				goto out_free;
+			clear_highpage(page);
+			per_cpu(cpu_profile_hits, cpu)[0] = page_address(page);
+		}
+		break;
+	out_free:
+		page = virt_to_page(per_cpu(cpu_profile_hits, cpu)[1]);
+		per_cpu(cpu_profile_hits, cpu)[1] = NULL;
+		__free_page(page);
+		return NOTIFY_BAD;
+	case CPU_ONLINE:
+		cpu_set(cpu, prof_cpu_mask);
+		break;
+	case CPU_UP_CANCELED:
+	case CPU_DEAD:
+		cpu_clear(cpu, prof_cpu_mask);
+		if (per_cpu(cpu_profile_hits, cpu)[0]) {
+			page = virt_to_page(per_cpu(cpu_profile_hits, cpu)[0]);
+			per_cpu(cpu_profile_hits, cpu)[0] = NULL;
+			__free_page(page);
+		}
+		if (per_cpu(cpu_profile_hits, cpu)[1]) {
+			page = virt_to_page(per_cpu(cpu_profile_hits, cpu)[1]);
+			per_cpu(cpu_profile_hits, cpu)[1] = NULL;
+			__free_page(page);
+		}
+		break;
+	}
+	return NOTIFY_OK;
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+#else /* !CONFIG_SMP */
+#define profile_flip_buffers()		do { } while (0)
+#define profile_discard_flip_buffers()	do { } while (0)
+
 void profile_hit(int type, void *__pc)
 {
 	unsigned long pc;
@@ -190,6 +389,7 @@
 	pc = ((unsigned long)__pc - (unsigned long)_stext) >> prof_shift;
 	atomic_inc(&prof_buffer[min(pc, prof_len - 1)]);
 }
+#endif /* !CONFIG_SMP */
 
 void profile_tick(int type, struct pt_regs *regs)
 {
@@ -256,6 +456,7 @@
 	char * pnt;
 	unsigned int sample_step = 1 << prof_shift;
 
+	profile_flip_buffers();
 	if (p >= (prof_len+1)*sizeof(unsigned int))
 		return 0;
 	if (count > (prof_len+1)*sizeof(unsigned int) - p)
@@ -296,7 +497,7 @@
 			return -EINVAL;
 	}
 #endif
-
+	profile_discard_flip_buffers();
 	memset(prof_buffer, 0, prof_len * sizeof(atomic_t));
 	return count;
 }
@@ -306,17 +507,64 @@
 	.write		= write_profile,
 };
 
+#ifdef CONFIG_SMP
+static void __init profile_nop(void *unused)
+{
+}
+#endif
+
 static int __init create_proc_profile(void)
 {
 	struct proc_dir_entry *entry;
+	int cpu;
 
+	(void)cpu;
 	if (!prof_on)
 		return 0;
+#ifdef CONFIG_SMP
+	for_each_online_cpu(cpu) {
+		int node = cpu_to_node(cpu);
+		struct page *page;
+
+		page = alloc_pages_node(node, GFP_KERNEL, 0);
+		if (!page)
+			goto out_cleanup;
+		per_cpu(cpu_profile_hits, cpu)[1]
+				= (struct profile_hit *)page_address(page);
+		page = alloc_pages_node(node, GFP_KERNEL, 0);
+		if (!page)
+			goto out_cleanup;
+		per_cpu(cpu_profile_hits, cpu)[0]
+				= (struct profile_hit *)page_address(page);
+	}
+#endif /* CONFIG_SMP */
 	if (!(entry = create_proc_entry("profile", S_IWUSR | S_IRUGO, NULL)))
 		return 0;
 	entry->proc_fops = &proc_profile_operations;
 	entry->size = (1+prof_len) * sizeof(atomic_t);
+	hotcpu_notifier(profile_cpu_callback, 0);
 	return 0;
+#ifdef CONFIG_SMP
+out_cleanup:
+	prof_on = 0;
+	mb();
+	on_each_cpu(profile_nop, NULL, 0, 1);
+	for_each_online_cpu(cpu) {
+		struct page *page;
+
+		if (per_cpu(cpu_profile_hits, cpu)[0]) {
+			page = virt_to_page(per_cpu(cpu_profile_hits, cpu)[0]);
+			per_cpu(cpu_profile_hits, cpu)[0] = NULL;
+			__free_page(page);
+		}
+		if (per_cpu(cpu_profile_hits, cpu)[1]) {
+			page = virt_to_page(per_cpu(cpu_profile_hits, cpu)[1]);
+			per_cpu(cpu_profile_hits, cpu)[1] = NULL;
+			__free_page(page);
+		}
+	}
+	return -1;
+#endif /* CONFIG_SMP */
 }
 module_init(create_proc_profile);
 #endif /* CONFIG_PROC_FS */
