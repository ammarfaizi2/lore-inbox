Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318229AbSHZUBk>; Mon, 26 Aug 2002 16:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318242AbSHZUBk>; Mon, 26 Aug 2002 16:01:40 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:8197
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S318229AbSHZUBU>; Mon, 26 Aug 2002 16:01:20 -0400
Subject: [PATCH] hyperthreading scheduler improvement
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 26 Aug 2002 16:05:36 -0400
Message-Id: <1030392337.15007.413.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch implements a per-arch load balancing scheme for P4s to better
balance across the virtual CPUs (e.g. prefer fully unused CPUs to a
single available HT unit).  This is the same logic in 2.4-ac, 2.4-aa,
etc.

This patch uses the previously posted per-arch load balancing
infrastructure.

The new logic is keyed off of a new CONFIG_X86_HYPERTHREADING value
which is currently set off of CONFIG_MPENTIUM4.  Thus, only kernels
compiled for P4s will receive the new logic.  It is safe to make the
code available to all x86s, however.

As I am not fortunate enough to have dual Xeons at my disposal, this
patch is largely untested for performance, although it is present in -aa
and -ac.  I suspect this could show very acceptable performance gains.

	Robert Love

diff -urN linux-2.5.31/arch/i386/config.in linux/arch/i386/config.in
--- linux-2.5.31/arch/i386/config.in	Sat Aug 10 21:41:25 2002
+++ linux/arch/i386/config.in	Sat Aug 24 22:07:10 2002
@@ -103,6 +103,7 @@
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_HYPERTHREADING y
 fi
 if [ "$CONFIG_MK6" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
diff -urN linux-2.5.31/include/asm-i386/processor.h linux/include/asm-i386/processor.h
--- linux-2.5.31/include/asm-i386/processor.h	Sat Aug 10 21:41:18 2002
+++ linux/include/asm-i386/processor.h	Sat Aug 24 22:07:10 2002
@@ -488,4 +488,6 @@
 
 #endif
 
+#define ARCH_HAS_SMP_BALANCE
+
 #endif /* __ASM_I386_PROCESSOR_H */
diff -urN linux-2.5.31/include/asm-i386/smp_balance.h linux/include/asm-i386/smp_balance.h
--- linux-2.5.31/include/asm-i386/smp_balance.h	Wed Dec 31 19:00:00 1969
+++ linux/include/asm-i386/smp_balance.h	Sat Aug 24 22:26:15 2002
@@ -0,0 +1,55 @@
+#ifndef _ASM_SMP_BALANCE_H
+#define _ASM_SMP_BALANCE_H
+
+/*
+ * We have an architecture-specific SMP load balancer to improve
+ * scheduling behavior on hyperthreaded CPUs.  Since only P4s have
+ * HT, we only use the code if CONFIG_MPENTIUM4 is set.
+ *
+ * Distributions may want to make this unconditional to support all
+ * x86 machines on one kernel.  The overhead in the non-P4 case is
+ * minimal while the benefit to SMP P4s is probably decent.
+ */
+#if defined(CONFIG_X86_HYPERTHREADING)
+
+/*
+ * Find any idle processor package (i.e. both virtual processors are idle)
+ */
+static inline int find_idle_package(int this_cpu)
+{
+	int i;
+
+	i = this_cpu;
+
+	for (i = (this_cpu + 1) % NR_CPUS;
+	     i != this_cpu;
+	     i = (i + 1) % NR_CPUS) {
+		int sibling = cpu_sibling_map[i];
+
+		if (idle_cpu(i) && idle_cpu(sibling))
+			return i;
+	}
+	return -1;	/* not found */
+}
+
+static inline int arch_load_balance(int this_cpu, int idle)
+{
+	/* Special hack for hyperthreading */
+       if (unlikely(smp_num_siblings > 1 && idle && !idle_cpu(cpu_sibling_map[this_cpu]))) {
+               int found;
+               struct runqueue *rq_target;
+
+               if ((found = find_idle_package(this_cpu)) >= 0 ) {
+                       rq_target = cpu_rq(found);
+                       resched_task(rq_target->idle);
+                       return 1;
+               }
+       }
+       return 0;
+}
+
+#else
+#define arch_load_balance(x, y)		(0)
+#endif
+
+#endif /* _ASM_SMP_BALANCE_H */



