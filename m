Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268899AbUINEsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268899AbUINEsM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 00:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268904AbUINEsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 00:48:12 -0400
Received: from holomorphy.com ([207.189.100.168]:59536 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268899AbUINEsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 00:48:00 -0400
Date: Mon, 13 Sep 2004 21:47:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ray Bryant <raybry@sgi.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: [profile] amortize atomic hit count increments
Message-ID: <20040914044748.GZ9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913015003.5406abae.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 01:50:03AM -0700, Andrew Morton wrote:
> Due to master.kernel.org being on the blink, 2.6.9-rc1-mm5 Is currently at
>  http://www.zip.com.au/~akpm/linux/patches/2.6.9-rc1-mm5/
> and will later appear at
>  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm5/
> Please check kernel.org before using zip.com.au.
> - Added the `bk-scsi-target' tree to the -mm lineup.  It is managed by James
>   Bottomley 
> - Some enhancements to the ext3 block reservation code here.  Please cc
>   sct@redhat.com on oops reports ;)
> - There's a patch here which will cause warnings if a PCI device driver is
>   removed without having called pci_disable_device().  Please try to cc the
>   appropriate mailing list or maintainer when reporting any instances.

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
into the timer interrupt by interrupt disablement. read_proc_profile()
does not flush the per-cpu hashtables because flushing may cause
timeslice overrun on the systems where prof_buffer cacheline bounces
are so problematic as to livelock the timer interrupt.

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
+++ mm5-2.6.9-rc1/kernel/profile.c	2004-09-13 21:36:35.498912144 -0700
@@ -12,10 +12,18 @@
 #include <linux/profile.h>
 #include <asm/sections.h>
 
+struct profile_hit {
+	unsigned long pc, hits;
+};
+#define NR_PROFILE_HIT		(PAGE_SIZE/sizeof(struct profile_hit))
+
 static atomic_t *prof_buffer;
 static unsigned long prof_len, prof_shift;
 static int prof_on;
 static cpumask_t prof_cpu_mask = CPU_MASK_ALL;
+#ifdef CONFIG_SMP
+static DEFINE_PER_CPU(struct profile_hit [NR_PROFILE_HIT], cpu_profile_hits);
+#endif /* CONFIG_SMP */
 
 static int __init profile_setup(char * str)
 {
@@ -181,6 +189,41 @@
 EXPORT_SYMBOL_GPL(profile_event_register);
 EXPORT_SYMBOL_GPL(profile_event_unregister);
 
+#ifdef CONFIG_SMP
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
+	hits = per_cpu(cpu_profile_hits, cpu);
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
+#else
 void profile_hit(int type, void *__pc)
 {
 	unsigned long pc;
@@ -190,6 +233,7 @@
 	pc = ((unsigned long)__pc - (unsigned long)_stext) >> prof_shift;
 	atomic_inc(&prof_buffer[min(pc, prof_len - 1)]);
 }
+#endif
 
 void profile_tick(int type, struct pt_regs *regs)
 {
