Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318144AbSHZUtr>; Mon, 26 Aug 2002 16:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318148AbSHZUtr>; Mon, 26 Aug 2002 16:49:47 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:37383
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S318144AbSHZUtp>; Mon, 26 Aug 2002 16:49:45 -0400
Subject: Re: [PATCH] hyperthreading scheduler improvement
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1030392337.15007.413.camel@phantasy>
References: <1030392337.15007.413.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 26 Aug 2002 16:53:58 -0400
Message-Id: <1030395238.1184.449.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-26 at 16:05, Robert Love wrote:

Linus,

> This patch implements a per-arch load balancing scheme for P4s to better
> balance across the virtual CPUs (e.g. prefer fully unused CPUs to a
> single available HT unit).  This is the same logic in 2.4-ac, 2.4-aa,
> etc.
> 
> This patch uses the previously posted per-arch load balancing
> infrastructure.

This is an updated version, to use the new asm/sched.h infrastructure
hch suggested (see previous patch).

	Robert Love

diff -urN linux-dogmeat/arch/i386/config.in linux/arch/i386/config.in
--- linux-dogmeat/arch/i386/config.in	Mon Aug 26 16:30:53 2002
+++ linux/arch/i386/config.in	Mon Aug 26 16:45:57 2002
@@ -103,6 +103,7 @@
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_HYPERTHREADING y
 fi
 if [ "$CONFIG_MK6" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
diff -urN linux-dogmeat/include/asm-i386/sched.h linux/include/asm-i386/sched.h
--- linux-dogmeat/include/asm-i386/sched.h	Mon Aug 26 16:31:12 2002
+++ linux/include/asm-i386/sched.h	Mon Aug 26 16:46:37 2002
@@ -1,7 +1,55 @@
 #ifndef _I386_SCHED_H
 #define _I386_SCHED_H
 
-/* nothing to see here, move along */
-#include <asm-generic/sched.h>
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
 
 #endif /* _I386_SCHED_H */

