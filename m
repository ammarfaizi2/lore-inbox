Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269186AbUINGqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269186AbUINGqm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 02:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269182AbUINGqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 02:46:11 -0400
Received: from holomorphy.com ([207.189.100.168]:30353 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269166AbUINGnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 02:43:39 -0400
Date: Mon, 13 Sep 2004 23:43:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: raybry@sgi.com, jbarnes@engr.sgi.com, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [profile] amortize atomic hit count increments
Message-ID: <20040914064325.GG9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org> <20040914044748.GZ9106@holomorphy.com> <20040913220521.03d0e539.akpm@osdl.org> <20040914052118.GA9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914052118.GA9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 10:05:21PM -0700, Andrew Morton wrote:
>> That's a bit of a problem, isn't it?  As we can accumulate an arbitrarily
>> large number of hits within the hash table is it not possible that the
>> /proc/profile results could be grossly inaccurate?
>> If you had two front-ends per cpu to the profiling buffer then the CPU
>> which is running the /proc/profile read could tell all the other CPUs to
>> flip to their alternate buffer and can then perform accumulation at its
>> leisure.

On Mon, Sep 13, 2004 at 10:21:18PM -0700, William Lee Irwin III wrote:
> This is superior to no flushing; I'll implement that and send out an
> incremental update (or if preferred, an update of this patch).

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

I would be much obliged if the reporters of this issue could verify
whether this resolves their livelock. Untested, as I was hoping the
bugreporters could do that bit for me.

Index: mm5-2.6.9-rc1/kernel/profile.c
===================================================================
--- mm5-2.6.9-rc1.orig/kernel/profile.c	2004-09-13 16:27:36.639247200 -0700
+++ mm5-2.6.9-rc1/kernel/profile.c	2004-09-13 23:12:27.574463744 -0700
@@ -11,11 +11,21 @@
 #include <linux/cpumask.h>
 #include <linux/profile.h>
 #include <asm/sections.h>
+#include <asm/semaphore.h>
+
+struct profile_hit {
+	unsigned long pc, hits;
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
@@ -181,6 +191,74 @@
 EXPORT_SYMBOL_GPL(profile_event_register);
 EXPORT_SYMBOL_GPL(profile_event_unregister);
 
+#ifdef CONFIG_SMP
+static void __profile_flip_buffers(void *unused)
+{
+	int cpu = get_cpu();
+	unsigned long flags;
+
+	local_irq_save(flags);
+	per_cpu(cpu_profile_flip, cpu) = !per_cpu(cpu_profile_flip, cpu);
+	local_irq_restore(flags);
+	put_cpu();
+}
+
+static void profile_flip_buffers(void)
+{
+	static DECLARE_MUTEX(profile_flip_mutex);
+	int i, j, cpu;
+
+	down(&profile_flip_mutex);
+	j = per_cpu(cpu_profile_flip, smp_processor_id());
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
+	cpu = get_cpu();
+	i = primary = pc & (NR_PROFILE_HIT - 1);
+	secondary = ((~pc << 1) | 1) & (NR_PROFILE_HIT - 1);
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
@@ -190,6 +268,7 @@
 	pc = ((unsigned long)__pc - (unsigned long)_stext) >> prof_shift;
 	atomic_inc(&prof_buffer[min(pc, prof_len - 1)]);
 }
+#endif /* !CONFIG_SMP */
 
 void profile_tick(int type, struct pt_regs *regs)
 {
@@ -256,6 +335,7 @@
 	char * pnt;
 	unsigned int sample_step = 1 << prof_shift;
 
+	profile_flip_buffers();
 	if (p >= (prof_len+1)*sizeof(unsigned int))
 		return 0;
 	if (count > (prof_len+1)*sizeof(unsigned int) - p)
