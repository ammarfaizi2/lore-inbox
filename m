Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269209AbUINIsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269209AbUINIsi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 04:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269211AbUINIsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 04:48:38 -0400
Received: from holomorphy.com ([207.189.100.168]:9106 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269209AbUINIsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 04:48:11 -0400
Date: Tue, 14 Sep 2004 01:48:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: raybry@sgi.com, jbarnes@engr.sgi.com, linux-kernel@vger.kernel.org,
       davem@davemloft.net
Subject: Re: [profile] amortize atomic hit count increments
Message-ID: <20040914084801.GK9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org> <20040914044748.GZ9106@holomorphy.com> <20040913220521.03d0e539.akpm@osdl.org> <20040914052118.GA9106@holomorphy.com> <20040914064325.GG9106@holomorphy.com> <20040913235225.0fb6039b.akpm@osdl.org> <20040914075544.GI9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914075544.GI9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 11:52:25PM -0700, Andrew Morton wrote:
>> A few comments which describe the design would be nice...

On Tue, Sep 14, 2004 at 12:55:44AM -0700, William Lee Irwin III wrote:
> Okay, I'll add a few in another update. I suppose what's going on may
> not be as obvious to everyone else even with the code in hand.

The comments and all other issues raised in your reply have been
addressed in the following updated patch, in which I also shrank the
hashtable entries' fields to u32 for 64-bit machines, on which the full
precision of an unsigned long is unnecessary, added some commentary to
the beginning of the file describing its contents and the recent major
work done on it, and simplified the secondary hash function. I also
presume silence to be assent regarding the hotplug (not preempt) fix.


-- wli

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

What this patch does is to create a per-cpu open-addressed hashtable
indexed by profile buffer slot holding values representing the number
of pending profile buffer hits. When this hashtable overflows, one
iterates over the hashtable accounting each of the pairs of profile
buffer slots and hit counts to the global profile buffer. Zero is a
legitimate profile buffer slot, so zero hit counts represent unused
hashtable entries. The hashtable is furthermore protected from reentry
into the timer interrupt by interrupt disablement. In order to "flush"
the pending profile hits for read_profile(), this patch actually
creates a pair of per-cpu profile buffer, and at the time of
read_profile() IPI's all cpus to get them to flip between their pairs
of profile buffers, doing all the work to flush the profile hits from
the older per-cpu buffers in the context of the caller of read_profile(),
with exclusion provided by a semaphore ensuring that only one caller of
profile_flip_buffers() may execute at a time and interrupt disablement
to prevent buffer flip IPI's from altering the hashtables or flip state
while an update is in progress. The flip state is per-cpu so that
remote cpus need only disable interrupts locally for synchronization,
which is both simple and busywait-free for remote cpus, and the flip
states all change in tandem with the cpu requesting the update waiting
for the completion of smp_call_function() for notification that all
cpus have finished flipping their buffers. The IPI handler merely
toggles the flip state (which is an array index) between 0 and 1.

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
(lack of) scattering of profile buffer hits.

I also took the liberty of adding some commentary to the comments at
the beginning of the file reflecting the major work done on profile.c
in recent months and describing what the file implements..

I would be much obliged if the reporters of this issue could verify
whether this resolves their livelock. Untested, as I was hoping the
bugreporters could do that bit for me.

Index: mm5-2.6.9-rc1/kernel/profile.c
===================================================================
--- mm5-2.6.9-rc1.orig/kernel/profile.c	2004-09-13 16:27:36.639247200 -0700
+++ mm5-2.6.9-rc1/kernel/profile.c	2004-09-14 01:27:49.675716672 -0700
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
@@ -11,11 +22,21 @@
 #include <linux/cpumask.h>
 #include <linux/profile.h>
 #include <asm/sections.h>
+#include <asm/semaphore.h>
+
+struct profile_hit {
+	u32 pc, hits;
+};
+#define NR_PROFILE_HIT		(PAGE_SIZE/sizeof(struct profile_hit))
 
 static atomic_t *prof_buffer;
 static unsigned long prof_len, prof_shift;
 static int prof_on;
 static cpumask_t prof_cpu_mask = CPU_MASK_ALL;
+#ifdef CONFIG_SMP
+static DEFINE_PER_CPU(struct profile_hit [2][NR_PROFILE_HIT], cpu_profile_hits);
+static DEFINE_PER_CPU(int, cpu_profile_flip);
+#endif /* CONFIG_SMP */
 
 static int __init profile_setup(char * str)
 {
@@ -181,6 +202,100 @@
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
+ * pagetable hash functions, but doesn't use finite collision chains.
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
+	static DECLARE_MUTEX(profile_flip_mutex);
+	int i, j, cpu;
+
+	down(&profile_flip_mutex);
+	j = per_cpu(cpu_profile_flip, get_cpu());
+	put_cpu();
+	on_each_cpu(__profile_flip_buffers, NULL, 0, 1);
+	for_each_online_cpu(cpu) {
+		struct profile_hit *hits = per_cpu(cpu_profile_hits, cpu)[j];
+		for (i = 0; i < NR_PROFILE_HIT; ++i) {
+			if (!hits[i].hits)
+				continue;
+			atomic_add(hits[i].hits, &prof_buffer[hits[i].pc]);
+		}
+		memset(hits, 0, NR_PROFILE_HIT*sizeof(struct profile_hit));
+	}
+	up(&profile_flip_mutex);
+}
+
+void profile_hit(int type, void *__pc)
+{
+	unsigned long primary, secondary, flags, pc = (unsigned long)__pc;
+	int i, cpu;
+	struct profile_hit *hits;
+
+	if (prof_on != type || !prof_buffer)
+		return;
+	pc = min((pc - (unsigned long)_stext) >> prof_shift, prof_len - 1);
+	i = primary = pc & (NR_PROFILE_HIT - 1);
+	secondary = ~(pc << 1) & (NR_PROFILE_HIT - 1);
+	cpu = get_cpu();
+	hits = per_cpu(cpu_profile_hits, cpu)[per_cpu(cpu_profile_flip, cpu)];
+	local_irq_save(flags);
+	do {
+		if (hits[i].pc == pc) {
+			hits[i].hits++;
+			goto out;
+		} else if (!hits[i].hits) {
+			hits[i].pc = pc;
+			hits[i].hits = 1;
+			goto out;
+		} else
+			i = (i + secondary) & (NR_PROFILE_HIT - 1);
+	} while (i != primary);
+	atomic_inc(&prof_buffer[pc]);
+	for (i = 0; i < NR_PROFILE_HIT; ++i)
+		atomic_add(hits[i].hits, &prof_buffer[hits[i].pc]);
+	memset(hits, 0, NR_PROFILE_HIT*sizeof(struct profile_hit));
+out:
+	local_irq_restore(flags);
+	put_cpu();
+}
+#else /* !CONFIG_SMP */
+#define profile_flip_buffers()		do { } while (0)
+
 void profile_hit(int type, void *__pc)
 {
 	unsigned long pc;
@@ -190,6 +305,7 @@
 	pc = ((unsigned long)__pc - (unsigned long)_stext) >> prof_shift;
 	atomic_inc(&prof_buffer[min(pc, prof_len - 1)]);
 }
+#endif /* !CONFIG_SMP */
 
 void profile_tick(int type, struct pt_regs *regs)
 {
@@ -256,6 +372,7 @@
 	char * pnt;
 	unsigned int sample_step = 1 << prof_shift;
 
+	profile_flip_buffers();
 	if (p >= (prof_len+1)*sizeof(unsigned int))
 		return 0;
 	if (count > (prof_len+1)*sizeof(unsigned int) - p)
