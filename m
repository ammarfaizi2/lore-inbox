Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbTBJG56>; Mon, 10 Feb 2003 01:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263491AbTBJG56>; Mon, 10 Feb 2003 01:57:58 -0500
Received: from holomorphy.com ([66.224.33.161]:18651 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263366AbTBJG5x>;
	Mon, 10 Feb 2003 01:57:53 -0500
Date: Sun, 9 Feb 2003 23:06:15 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rusty Russell <rusty@rustcorp.com.au>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       kai@chaos.physics.uiowa.edu
Subject: Re: [PATCH] cpumask_t
Message-ID: <20030210070615.GD29983@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	kai@chaos.physics.uiowa.edu
References: <20020808.073630.37512884.davem@redhat.com> <20020809080517.E4BE5443C@lists.samba.org> <20030119213524.GH780@holomorphy.com> <20030119221852.GC789@holomorphy.com> <20030119224329.GI780@holomorphy.com> <20030119225458.GD770@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030119225458.GD770@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2003 at 02:54:58PM -0800, William Lee Irwin III wrote:
> Thanks for spotting this, kai

Zwane spotted this one, do_irq_balance() is clearing a cpumask but used
the wrong bitmap size. This extends the API for extra safety with a
cpus_clear() and avoids the need to be aware of the size (NR_CPUS) of
cpumasks in calling code.

I might need a machine to test this on and/or testers eventually.


-- wli

Introduce cpus_clear() and convert open-coded bitmap_clear(., NR_CPUS)
to use it instead.

 arch/i386/kernel/apic.c    |    2 +-
 arch/i386/kernel/io_apic.c |    8 ++++----
 arch/i386/kernel/smpboot.c |    6 +++---
 include/linux/cpumask.h    |    1 +
 kernel/fork.c              |    2 +-
 5 files changed, 10 insertions(+), 9 deletions(-)

diff -urpN cpu-2.5.59-3/arch/i386/kernel/apic.c cpu-2.5.59-4/arch/i386/kernel/apic.c
--- cpu-2.5.59-3/arch/i386/kernel/apic.c	2003-01-19 12:45:40.000000000 -0800
+++ cpu-2.5.59-4/arch/i386/kernel/apic.c	2003-02-09 23:01:02.000000000 -0800
@@ -1138,7 +1138,7 @@ int __init APIC_init_uniprocessor (void)
 
 	connect_bsp_APIC();
 
-	bitmap_clear(phys_cpu_present_map.mask, NR_CPUS);
+	cpus_clear(phys_cpu_present_map);
 	cpu_set(0, phys_cpu_present_map);
 	apic_write_around(APIC_ID, boot_cpu_physical_apicid);
 
diff -urpN cpu-2.5.59-3/arch/i386/kernel/io_apic.c cpu-2.5.59-4/arch/i386/kernel/io_apic.c
--- cpu-2.5.59-3/arch/i386/kernel/io_apic.c	2003-01-19 13:01:29.000000000 -0800
+++ cpu-2.5.59-4/arch/i386/kernel/io_apic.c	2003-02-09 22:59:57.000000000 -0800
@@ -441,7 +441,7 @@ tryanotherirq:
 		min_loaded = cpu_sibling_map[min_loaded];
 
 	cpus_and(allowed_mask, cpu_online_map, irq_affinity[selected_irq]);
-	bitmap_clear(target_cpu_mask.mask, BITS_PER_LONG);
+	cpus_clear(target_cpu_mask);
 	cpu_set(min_loaded, target_cpu_mask);
 	cpus_and(tmp, target_cpu_mask, allowed_mask);
 
@@ -509,7 +509,7 @@ static inline void balance_irq (int cpu,
 	if (cpu != new_cpu) {
 		irq_desc_t *desc = irq_desc + irq;
 		spin_lock(&desc->lock);
-		bitmap_clear(irq_balance_mask[irq].mask, NR_CPUS);
+		cpus_clear(irq_balance_mask[irq]);
 		cpu_set(new_cpu, irq_balance_mask[irq]);
 		spin_unlock(&desc->lock);
 	}
@@ -526,7 +526,7 @@ int balanced_irq(void *unused)
 	
 	/* push everything to CPU 0 to give us a starting point.  */
 	for (i = 0 ; i < NR_IRQS ; i++) {
-		bitmap_clear(irq_balance_mask[i].mask, NR_CPUS);
+		cpus_clear(irq_balance_mask[i]);
 		cpu_set(0, irq_balance_mask[i]);
 	}
 	for (;;) {
@@ -598,7 +598,7 @@ static inline void move_irq(int irq)
 	/* note - we hold the desc->lock */
 	if (unlikely(any_online_cpu(irq_balance_mask[irq]) < NR_CPUS)) {
 		set_ioapic_affinity(irq, irq_balance_mask[irq]);
-		bitmap_clear(irq_balance_mask[irq].mask, NR_CPUS);
+		cpus_clear(irq_balance_mask[irq]);
 	}
 }
 
diff -urpN cpu-2.5.59-3/arch/i386/kernel/smpboot.c cpu-2.5.59-4/arch/i386/kernel/smpboot.c
--- cpu-2.5.59-3/arch/i386/kernel/smpboot.c	2003-01-19 13:07:06.000000000 -0800
+++ cpu-2.5.59-4/arch/i386/kernel/smpboot.c	2003-02-09 23:00:32.000000000 -0800
@@ -979,7 +979,7 @@ static void __init smp_boot_cpus(unsigne
 	if (!smp_found_config) {
 		printk(KERN_NOTICE "SMP motherboard not detected.\n");
 		smpboot_clear_io_apic_irqs();
-		bitmap_clear(phys_cpu_present_map.mask, NR_CPUS);
+		cpus_clear(phys_cpu_present_map);
 		cpu_set(1, phys_cpu_present_map);
 		if (APIC_init_uniprocessor())
 			printk(KERN_NOTICE "Local APIC not detected."
@@ -1006,7 +1006,7 @@ static void __init smp_boot_cpus(unsigne
 			boot_cpu_physical_apicid);
 		printk(KERN_ERR "... forcing use of dummy APIC emulation. (tell your hw vendor)\n");
 		smpboot_clear_io_apic_irqs();
-		bitmap_clear(phys_cpu_present_map.mask, NR_CPUS);
+		cpus_clear(phys_cpu_present_map);
 		cpu_set(1, phys_cpu_present_map);
 		return;
 	}
@@ -1020,7 +1020,7 @@ static void __init smp_boot_cpus(unsigne
 		smp_found_config = 0;
 		printk(KERN_INFO "SMP mode deactivated, forcing use of dummy APIC emulation.\n");
 		smpboot_clear_io_apic_irqs();
-		bitmap_clear(phys_cpu_present_map.mask, NR_CPUS);
+		cpus_clear(phys_cpu_present_map);
 		return;
 	}
 
diff -urpN cpu-2.5.59-3/include/linux/cpumask.h cpu-2.5.59-4/include/linux/cpumask.h
--- cpu-2.5.59-3/include/linux/cpumask.h	2003-01-19 14:40:49.000000000 -0800
+++ cpu-2.5.59-4/include/linux/cpumask.h	2003-02-09 22:58:35.000000000 -0800
@@ -25,6 +25,7 @@ extern cpumask_t cpu_online_map;
 
 #define cpus_and(dst,src1,src2)	bitmap_and((dst).mask,(src1).mask, (src2).mask, NR_CPUS)
 #define cpus_or(dst,src1,src2)	bitmap_or((dst).mask, (src1).mask, (src2).mask, NR_CPUS)
+#define cpus_clear(map)		bitmap_clear((map).mask, NR_CPUS)
 #define cpus_equal(map1, map2)	bitmap_equal((map1).mask, (map2).mask, NR_CPUS)
 #define first_cpu(map)		find_first_bit((map).mask, NR_CPUS)
 #define next_cpu(cpu, map)	find_next_bit((map).mask, NR_CPUS, cpu)
diff -urpN cpu-2.5.59-3/kernel/fork.c cpu-2.5.59-4/kernel/fork.c
--- cpu-2.5.59-3/kernel/fork.c	2003-01-19 12:30:54.000000000 -0800
+++ cpu-2.5.59-4/kernel/fork.c	2003-02-09 23:01:23.000000000 -0800
@@ -235,7 +235,7 @@ static inline int dup_mmap(struct mm_str
 	mm->free_area_cache = TASK_UNMAPPED_BASE;
 	mm->map_count = 0;
 	mm->rss = 0;
-	bitmap_clear(mm->cpu_vm_mask.mask, NR_CPUS);
+	cpus_clear(mm->cpu_vm_mask);
 	pprev = &mm->mmap;
 
 	/*
