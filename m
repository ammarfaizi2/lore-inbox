Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267708AbTASWeq>; Sun, 19 Jan 2003 17:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267709AbTASWeq>; Sun, 19 Jan 2003 17:34:46 -0500
Received: from holomorphy.com ([66.224.33.161]:12168 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267708AbTASWeo>;
	Sun, 19 Jan 2003 17:34:44 -0500
Date: Sun, 19 Jan 2003 14:43:29 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rusty Russell <rusty@rustcorp.com.au>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpumask_t
Message-ID: <20030119224329.GI780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <20020808.073630.37512884.davem@redhat.com> <20020809080517.E4BE5443C@lists.samba.org> <20030119213524.GH780@holomorphy.com> <20030119221852.GC789@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030119221852.GC789@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2003 at 02:18:52PM -0800, William Lee Irwin III wrote:
> This is just broken anyway. And fixing it isn't as obvious as just


Fix up several obvious stupidities. Atop the prior patch:

 arch/i386/kernel/irq.c  |    2 +-
 arch/i386/kernel/smp.c  |    7 +++++--
 include/linux/cpumask.h |    6 +++---
 3 files changed, 9 insertions(+), 6 deletions(-)


diff -urpN cpu-2.5.59-1/arch/i386/kernel/irq.c cpu-2.5.59-2/arch/i386/kernel/irq.c
--- cpu-2.5.59-1/arch/i386/kernel/irq.c	2003-01-19 13:27:24.000000000 -0800
+++ cpu-2.5.59-2/arch/i386/kernel/irq.c	2003-01-19 14:30:24.000000000 -0800
@@ -873,7 +873,7 @@ static int irq_affinity_write_proc (stru
 	 * one online CPU still has to be targeted.
 	 */
 	cpus_and(tmp, new_value, cpu_online_map);
-	if (!any_online_cpu(tmp))
+	if (!any_online_cpu(tmp) >= NR_CPUS)
 		return -EINVAL;
 
 	irq_affinity[irq] = new_value;
diff -urpN cpu-2.5.59-1/arch/i386/kernel/smp.c cpu-2.5.59-2/arch/i386/kernel/smp.c
--- cpu-2.5.59-1/arch/i386/kernel/smp.c	2003-01-19 12:23:52.000000000 -0800
+++ cpu-2.5.59-2/arch/i386/kernel/smp.c	2003-01-19 14:34:40.000000000 -0800
@@ -331,8 +331,9 @@ asmlinkage void smp_invalidate_interrupt
 			leave_mm(cpu);
 	}
 	ack_APIC_irq();
+	smp_mb__before_clear_bit();
 	cpu_clear(cpu, flush_cpumask);
-
+	smp_mb__after_clear_bit();
 out:
 	put_cpu_no_resched();
 }
@@ -370,6 +371,7 @@ static void flush_tlb_others(cpumask_t c
 	 * atomic_set_mask(cpumask, &flush_cpumask);
 	 */
 	flush_cpumask = cpumask;
+	mb();
 	/*
 	 * We have to send the IPI only to
 	 * CPUs affected.
@@ -377,7 +379,8 @@ static void flush_tlb_others(cpumask_t c
 	send_IPI_mask(cpumask, INVALIDATE_TLB_VECTOR);
 
 	while (any_online_cpu(flush_cpumask) < NR_CPUS)
-		/* nothing. lockup detection does not belong here */;
+		/* nothing. lockup detection does not belong here */
+		mb();
 
 	flush_mm = NULL;
 	flush_va = 0;
diff -urpN cpu-2.5.59-1/include/linux/cpumask.h cpu-2.5.59-2/include/linux/cpumask.h
--- cpu-2.5.59-1/include/linux/cpumask.h	2003-01-19 11:53:27.000000000 -0800
+++ cpu-2.5.59-2/include/linux/cpumask.h	2003-01-19 14:40:49.000000000 -0800
@@ -16,7 +16,7 @@ extern cpumask_t cpu_online_map;
 
 #define cpu_online(cpu)		test_bit(cpu, cpu_online_map.mask)
 #define num_online_cpus()	bitmap_weight(cpu_online_map.mask, NR_CPUS)
-#define any_online_cpu(map)	find_first_zero_bit((map).mask, NR_CPUS)
+#define any_online_cpu(map)	find_first_bit((map).mask, NR_CPUS)
 
 #define cpu_set(cpu, map)		set_bit(cpu, (map).mask)
 #define cpu_clear(cpu, map)		clear_bit(cpu, (map).mask)
@@ -26,8 +26,8 @@ extern cpumask_t cpu_online_map;
 #define cpus_and(dst,src1,src2)	bitmap_and((dst).mask,(src1).mask, (src2).mask, NR_CPUS)
 #define cpus_or(dst,src1,src2)	bitmap_or((dst).mask, (src1).mask, (src2).mask, NR_CPUS)
 #define cpus_equal(map1, map2)	bitmap_equal((map1).mask, (map2).mask, NR_CPUS)
-#define first_cpu(map)		find_first_zero_bit((map).mask, NR_CPUS)
-#define next_cpu(cpu, map)	find_next_zero_bit((map).mask, NR_CPUS, cpu)
+#define first_cpu(map)		find_first_bit((map).mask, NR_CPUS)
+#define next_cpu(cpu, map)	find_next_bit((map).mask, NR_CPUS, cpu)
 
 static inline int next_online_cpu(int cpu, cpumask_t map)
 {
