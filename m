Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130139AbRBZEF7>; Sun, 25 Feb 2001 23:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130140AbRBZEFs>; Sun, 25 Feb 2001 23:05:48 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:23855 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S130139AbRBZEFd>; Sun, 25 Feb 2001 23:05:33 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.2 softirq cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 26 Feb 2001 15:05:28 +1100
Message-ID: <15178.983160328@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch hits all architectures, please trim replies.

Patch against 2.4.2 to remove cpu_bh_enable/disable, now it is only
called from the same include file.

Define *_current versions of softirq_active, softirq_mask,
local_irq_count, local_bh_count, syscall_count, nmi_count.  Some
architectures can access the current cpu's data without doing an array
lookup, they will be able to use the *_current form for speed after
this patch is in.

diff -ur 2.4.2-pristine/include/asm-alpha/softirq.h 2.4.2-softirq/include/asm-alpha/softirq.h
--- 2.4.2-pristine/include/asm-alpha/softirq.h	Mon Aug  7 05:42:21 2000
+++ 2.4.2-softirq/include/asm-alpha/softirq.h	Mon Feb 26 14:37:46 2001
@@ -5,21 +5,7 @@
 #include <asm/atomic.h>
 #include <asm/hardirq.h>
 
-extern inline void cpu_bh_disable(int cpu)
-{
-	local_bh_count(cpu)++;
-	mb();
-}
-
-extern inline void cpu_bh_enable(int cpu)
-{
-	mb();
-	local_bh_count(cpu)--;
-}
-
-#define local_bh_enable()	cpu_bh_enable(smp_processor_id())
-#define local_bh_disable()	cpu_bh_disable(smp_processor_id())
-
-#define in_softirq() (local_bh_count(smp_processor_id()) != 0)
+#define local_bh_enable()	{ local_bh_count_current()++; mb(); }
+#define local_bh_disable()	{ mb(); local_bh_count_current()--; }
 
 #endif /* _ALPHA_SOFTIRQ_H */
diff -ur 2.4.2-pristine/include/asm-arm/softirq.h 2.4.2-softirq/include/asm-arm/softirq.h
--- 2.4.2-pristine/include/asm-arm/softirq.h	Tue May 16 05:00:34 2000
+++ 2.4.2-softirq/include/asm-arm/softirq.h	Mon Feb 26 14:37:46 2001
@@ -4,12 +4,7 @@
 #include <asm/atomic.h>
 #include <asm/hardirq.h>
 
-#define cpu_bh_disable(cpu)	do { local_bh_count(cpu)++; barrier(); } while (0)
-#define cpu_bh_enable(cpu)	do { barrier(); local_bh_count(cpu)--; } while (0)
-
-#define local_bh_disable()	cpu_bh_disable(smp_processor_id())
-#define local_bh_enable()	cpu_bh_enable(smp_processor_id())
-
-#define in_softirq()		(local_bh_count(smp_processor_id()) != 0)
+#define local_bh_disable()	do { local_bh_count_current()++; barrier(); } while (0)
+#define local_bh_enable()	do { barrier(); local_bh_count_current()--; } while (0)
 
 #endif	/* __ASM_SOFTIRQ_H */
diff -ur 2.4.2-pristine/include/asm-cris/softirq.h 2.4.2-softirq/include/asm-cris/softirq.h
--- 2.4.2-pristine/include/asm-cris/softirq.h	Thu Feb 22 15:20:47 2001
+++ 2.4.2-softirq/include/asm-cris/softirq.h	Mon Feb 26 14:37:46 2001
@@ -4,9 +4,7 @@
 #include <asm/atomic.h>
 #include <asm/hardirq.h>
 
-#define local_bh_disable()      (local_bh_count(smp_processor_id())++)
-#define local_bh_enable()       (local_bh_count(smp_processor_id())--)
-
-#define in_softirq() (local_bh_count(smp_processor_id()) != 0)
+#define local_bh_disable()      (local_bh_count_current()++)
+#define local_bh_enable()       (local_bh_count_current()--)
 
 #endif	/* __ASM_SOFTIRQ_H */
diff -ur 2.4.2-pristine/include/asm-i386/softirq.h 2.4.2-softirq/include/asm-i386/softirq.h
--- 2.4.2-pristine/include/asm-i386/softirq.h	Fri Jan  5 09:50:47 2001
+++ 2.4.2-softirq/include/asm-i386/softirq.h	Mon Feb 26 14:37:46 2001
@@ -4,12 +4,7 @@
 #include <asm/atomic.h>
 #include <asm/hardirq.h>
 
-#define cpu_bh_disable(cpu)	do { local_bh_count(cpu)++; barrier(); } while (0)
-#define cpu_bh_enable(cpu)	do { barrier(); local_bh_count(cpu)--; } while (0)
-
-#define local_bh_disable()	cpu_bh_disable(smp_processor_id())
-#define local_bh_enable()	cpu_bh_enable(smp_processor_id())
-
-#define in_softirq() (local_bh_count(smp_processor_id()) != 0)
+#define local_bh_disable()	do { local_bh_count_current()++; barrier(); } while (0)
+#define local_bh_enable()	do { barrier(); local_bh_count_current()--; } while (0)
 
 #endif	/* __ASM_SOFTIRQ_H */
diff -ur 2.4.2-pristine/include/asm-ia64/softirq.h 2.4.2-softirq/include/asm-ia64/softirq.h
--- 2.4.2-pristine/include/asm-ia64/softirq.h	Sat Mar 11 10:24:02 2000
+++ 2.4.2-softirq/include/asm-ia64/softirq.h	Mon Feb 26 14:37:46 2001
@@ -7,12 +7,7 @@
  */
 #include <asm/hardirq.h>
 
-#define cpu_bh_disable(cpu)	do { local_bh_count(cpu)++; barrier(); } while (0)
-#define cpu_bh_enable(cpu)	do { barrier(); local_bh_count(cpu)--; } while (0)
-
-#define local_bh_disable()	cpu_bh_disable(smp_processor_id())
-#define local_bh_enable()	cpu_bh_enable(smp_processor_id())
-
-#define in_softirq()		(local_bh_count(smp_processor_id()) != 0)
+#define local_bh_disable()	do { local_bh_count_current()++; barrier(); } while (0)
+#define local_bh_enable()	do { barrier(); local_bh_count_current()--; } while (0)
 
 #endif /* _ASM_IA64_SOFTIRQ_H */
diff -ur 2.4.2-pristine/include/asm-m68k/softirq.h 2.4.2-softirq/include/asm-m68k/softirq.h
--- 2.4.2-pristine/include/asm-m68k/softirq.h	Tue Nov 28 13:00:49 2000
+++ 2.4.2-softirq/include/asm-m68k/softirq.h	Mon Feb 26 14:37:46 2001
@@ -7,12 +7,7 @@
 
 #include <asm/atomic.h>
 
-#define cpu_bh_disable(cpu)	do { local_bh_count(cpu)++; barrier(); } while (0)
-#define cpu_bh_enable(cpu)	do { barrier(); local_bh_count(cpu)--; } while (0)
-
-#define local_bh_disable()	cpu_bh_disable(smp_processor_id())
-#define local_bh_enable()	cpu_bh_enable(smp_processor_id())
-
-#define in_softirq() (local_bh_count(smp_processor_id()) != 0)
+#define local_bh_disable()	do { local_bh_count_current()++; barrier(); } while (0)
+#define local_bh_enable()	do { barrier(); local_bh_count_current()--; } while (0)
 
 #endif
diff -ur 2.4.2-pristine/include/asm-mips/softirq.h 2.4.2-softirq/include/asm-mips/softirq.h
--- 2.4.2-pristine/include/asm-mips/softirq.h	Sun May 14 01:31:25 2000
+++ 2.4.2-softirq/include/asm-mips/softirq.h	Mon Feb 26 14:37:46 2001
@@ -13,12 +13,7 @@
 #include <asm/atomic.h>
 #include <asm/hardirq.h>
 
-#define cpu_bh_disable(cpu)	do { local_bh_count(cpu)++; barrier(); } while (0)
-#define cpu_bh_enable(cpu)	do { barrier(); local_bh_count(cpu)--; } while (0)
-
-#define local_bh_disable()	cpu_bh_disable(smp_processor_id())
-#define local_bh_enable()	cpu_bh_enable(smp_processor_id())
-
-#define in_softirq() (local_bh_count(smp_processor_id()) != 0)
+#define local_bh_disable()	do { local_bh_count_current()++; barrier(); } while (0)
+#define local_bh_enable()	do { barrier(); local_bh_count_current()--; } while (0)
 
 #endif /* _ASM_SOFTIRQ_H */
diff -ur 2.4.2-pristine/include/asm-mips64/softirq.h 2.4.2-softirq/include/asm-mips64/softirq.h
--- 2.4.2-pristine/include/asm-mips64/softirq.h	Sun May 14 01:31:25 2000
+++ 2.4.2-softirq/include/asm-mips64/softirq.h	Mon Feb 26 14:37:46 2001
@@ -13,12 +13,7 @@
 #include <asm/atomic.h>
 #include <asm/hardirq.h>
 
-#define cpu_bh_disable(cpu)	do { local_bh_count(cpu)++; barrier(); } while (0)
-#define cpu_bh_enable(cpu)	do { barrier(); local_bh_count(cpu)--; } while (0)
-
-#define local_bh_disable()	cpu_bh_disable(smp_processor_id())
-#define local_bh_enable()	cpu_bh_enable(smp_processor_id())
-
-#define in_softirq() (local_bh_count(smp_processor_id()) != 0)
+#define local_bh_disable()	do { local_bh_count_current()++; barrier(); } while (0)
+#define local_bh_enable()	do { barrier(); local_bh_count_current()--; } while (0)
 
 #endif /* _ASM_SOFTIRQ_H */
diff -ur 2.4.2-pristine/include/asm-parisc/softirq.h 2.4.2-softirq/include/asm-parisc/softirq.h
--- 2.4.2-pristine/include/asm-parisc/softirq.h	Wed Dec  6 07:29:39 2000
+++ 2.4.2-softirq/include/asm-parisc/softirq.h	Mon Feb 26 14:37:46 2001
@@ -4,12 +4,7 @@
 #include <asm/atomic.h>
 #include <asm/hardirq.h>
 
-#define cpu_bh_disable(cpu)	do { local_bh_count(cpu)++; barrier(); } while (0)
-#define cpu_bh_enable(cpu)	do { barrier(); local_bh_count(cpu)--; } while (0)
-
-#define local_bh_disable()	cpu_bh_disable(smp_processor_id())
-#define local_bh_enable()	cpu_bh_enable(smp_processor_id())
-
-#define in_softirq() (local_bh_count(smp_processor_id()) != 0)
+#define local_bh_disable()	do { local_bh_count_current()++; barrier(); } while (0)
+#define local_bh_enable()	do { barrier(); local_bh_count_current()--; } while (0)
 
 #endif	/* __ASM_SOFTIRQ_H */
diff -ur 2.4.2-pristine/include/asm-ppc/softirq.h 2.4.2-softirq/include/asm-ppc/softirq.h
--- 2.4.2-pristine/include/asm-ppc/softirq.h	Sun Nov 12 13:23:11 2000
+++ 2.4.2-softirq/include/asm-ppc/softirq.h	Mon Feb 26 14:37:46 2001
@@ -5,10 +5,8 @@
 #include <asm/atomic.h>
 #include <asm/hardirq.h>
 
-#define local_bh_disable()	do { local_bh_count(smp_processor_id())++; barrier(); } while (0)
-#define local_bh_enable()	do { barrier(); local_bh_count(smp_processor_id())--; } while (0)
-
-#define in_softirq() (local_bh_count(smp_processor_id()) != 0)
+#define local_bh_disable()	do { local_bh_count_current()++; barrier(); } while (0)
+#define local_bh_enable()	do { barrier(); local_bh_count_current()--; } while (0)
 
 #endif	/* __ASM_SOFTIRQ_H */
 #endif /* __KERNEL__ */
diff -ur 2.4.2-pristine/include/asm-s390/softirq.h 2.4.2-softirq/include/asm-s390/softirq.h
--- 2.4.2-pristine/include/asm-s390/softirq.h	Sat Aug  5 09:15:37 2000
+++ 2.4.2-softirq/include/asm-s390/softirq.h	Mon Feb 26 14:37:46 2001
@@ -17,13 +17,11 @@
 #include <asm/hardirq.h>
 #include <asm/lowcore.h>
 
-#define cpu_bh_disable(cpu)	do { local_bh_count(cpu)++; barrier(); } while (0)
-#define cpu_bh_enable(cpu)	do { barrier(); local_bh_count(cpu)--; } while (0)
+#undef  local_bh_count_current
+#define local_bh_count_current()	(S390_lowcore.__local_bh_count)
 
-#define local_bh_disable()	cpu_bh_disable(smp_processor_id())
-#define local_bh_enable()	cpu_bh_enable(smp_processor_id())
-
-#define in_softirq() (local_bh_count(smp_processor_id()) != 0)
+#define local_bh_disable()	do { local_bh_count_current()++; barrier(); } while (0)
+#define local_bh_enable()	do { barrier(); local_bh_count_current()--; } while (0)
 
 #endif	/* __ASM_SOFTIRQ_H */
 
diff -ur 2.4.2-pristine/include/asm-s390x/softirq.h 2.4.2-softirq/include/asm-s390x/softirq.h
--- 2.4.2-pristine/include/asm-s390x/softirq.h	Thu Feb 22 15:20:49 2001
+++ 2.4.2-softirq/include/asm-s390x/softirq.h	Mon Feb 26 14:37:46 2001
@@ -1,7 +1,7 @@
 /*
- *  include/asm-s390/softirq.h
+ *  include/asm-s390x/softirq.h
  *
- *  S390 version
+ *  S390x version
  *
  *  Derived from "include/asm-i386/softirq.h"
  */
@@ -17,13 +17,11 @@
 #include <asm/hardirq.h>
 #include <asm/lowcore.h>
 
-#define cpu_bh_disable(cpu)	do { local_bh_count(cpu)++; barrier(); } while (0)
-#define cpu_bh_enable(cpu)	do { barrier(); local_bh_count(cpu)--; } while (0)
+#undef  local_bh_count_current
+#define local_bh_count_current()	(S390_lowcore.__local_bh_count)
 
-#define local_bh_disable()	cpu_bh_disable(smp_processor_id())
-#define local_bh_enable()	cpu_bh_enable(smp_processor_id())
-
-#define in_softirq() (local_bh_count(smp_processor_id()) != 0)
+#define local_bh_disable()	do { local_bh_count_current()++; barrier(); } while (0)
+#define local_bh_enable()	do { barrier(); local_bh_count_current()--; } while (0)
 
 #endif	/* __ASM_SOFTIRQ_H */
 
diff -ur 2.4.2-pristine/include/asm-sh/softirq.h 2.4.2-softirq/include/asm-sh/softirq.h
--- 2.4.2-pristine/include/asm-sh/softirq.h	Sat Aug  5 09:15:37 2000
+++ 2.4.2-softirq/include/asm-sh/softirq.h	Mon Feb 26 14:37:46 2001
@@ -4,12 +4,7 @@
 #include <asm/atomic.h>
 #include <asm/hardirq.h>
 
-#define cpu_bh_disable(cpu)	do { local_bh_count(cpu)++; barrier(); } while (0)
-#define cpu_bh_enable(cpu)	do { barrier(); local_bh_count(cpu)--; } while (0)
-
-#define local_bh_disable()	cpu_bh_disable(smp_processor_id())
-#define local_bh_enable()	cpu_bh_enable(smp_processor_id())
-
-#define in_softirq() (local_bh_count(smp_processor_id()) != 0)
+#define local_bh_disable()	do { local_bh_count_current()++; barrier(); } while (0)
+#define local_bh_enable()	do { barrier(); local_bh_count_current()--; } while (0)
 
 #endif /* __ASM_SH_SOFTIRQ_H */
diff -ur 2.4.2-pristine/include/asm-sparc/softirq.h 2.4.2-softirq/include/asm-sparc/softirq.h
--- 2.4.2-pristine/include/asm-sparc/softirq.h	Mon Aug  7 05:42:21 2000
+++ 2.4.2-softirq/include/asm-sparc/softirq.h	Mon Feb 26 14:37:46 2001
@@ -13,9 +13,7 @@
 #include <asm/smp.h>
 #include <asm/hardirq.h>
 
-#define local_bh_disable()	(local_bh_count(smp_processor_id())++)
-#define local_bh_enable()	(local_bh_count(smp_processor_id())--)
-
-#define in_softirq() (local_bh_count(smp_processor_id()) != 0)
+#define local_bh_disable()	(local_bh_count_current()++)
+#define local_bh_enable()	(local_bh_count_current()--)
 
 #endif	/* __SPARC_SOFTIRQ_H */
diff -ur 2.4.2-pristine/include/asm-sparc64/softirq.h 2.4.2-softirq/include/asm-sparc64/softirq.h
--- 2.4.2-pristine/include/asm-sparc64/softirq.h	Mon Aug  7 05:42:21 2000
+++ 2.4.2-softirq/include/asm-sparc64/softirq.h	Mon Feb 26 14:37:46 2001
@@ -10,9 +10,7 @@
 #include <asm/hardirq.h>
 #include <asm/system.h>		/* for membar() */
 
-#define local_bh_disable()	(local_bh_count(smp_processor_id())++)
-#define local_bh_enable()	(local_bh_count(smp_processor_id())--)
-
-#define in_softirq() (local_bh_count(smp_processor_id()) != 0)
+#define local_bh_disable()	(local_bh_count_current()++)
+#define local_bh_enable()	(local_bh_count_current()--)
 
 #endif /* !(__SPARC64_SOFTIRQ_H) */
diff -ur 2.4.2-pristine/include/linux/irq_cpustat.h 2.4.2-softirq/include/linux/irq_cpustat.h
--- 2.4.2-pristine/include/linux/irq_cpustat.h	Fri Jan  5 09:50:46 2001
+++ 2.4.2-softirq/include/linux/irq_cpustat.h	Mon Feb 26 14:37:46 2001
@@ -7,6 +7,11 @@
  * they define their own mappings for irq_stat.
  *
  * Keith Owens <kaos@ocs.com.au> July 2000.
+ *
+ * Added _current forms to allow architectures with per cpu pages to take
+ * advantage of the optimizations that allows.
+ *
+ * Keith Owens <kaos@ocs.com.au> February 2001.
  */
 
 #include <linux/config.h>
@@ -26,12 +31,21 @@
 #endif	
 
   /* arch independent irq_stat fields */
-#define softirq_active(cpu)	__IRQ_STAT((cpu), __softirq_active)
-#define softirq_mask(cpu)	__IRQ_STAT((cpu), __softirq_mask)
-#define local_irq_count(cpu)	__IRQ_STAT((cpu), __local_irq_count)
-#define local_bh_count(cpu)	__IRQ_STAT((cpu), __local_bh_count)
-#define syscall_count(cpu)	__IRQ_STAT((cpu), __syscall_count)
+#define softirq_active(cpu)		__IRQ_STAT((cpu), __softirq_active)
+#define softirq_active_current()	softirq_active(smp_processor_id())
+#define softirq_mask(cpu)		__IRQ_STAT((cpu), __softirq_mask)
+#define softirq_mask_current()		softirq_mask(smp_processor_id())
+#define local_irq_count(cpu)		__IRQ_STAT((cpu), __local_irq_count)
+#define local_irq_count_current()	local_irq_count(smp_processor_id())
+#define local_bh_count(cpu)		__IRQ_STAT((cpu), __local_bh_count)
+#define local_bh_count_current()	local_bh_count(smp_processor_id())
+#define syscall_count(cpu)		__IRQ_STAT((cpu), __syscall_count)
+#define syscall_count_current()		syscall_count(smp_processor_id())
   /* arch dependent irq_stat fields */
-#define nmi_count(cpu)		__IRQ_STAT((cpu), __nmi_count)		/* i386, ia64 */
+#define nmi_count(cpu)			__IRQ_STAT((cpu), __nmi_count)		/* i386, ia64 */
+#define nmi_count_current()		nmi_count(smp_processor_id())
+
+/* When this gets expanded, local_bh_count_current() may have been redefined */
+#define in_softirq()			(local_bh_count_current() != 0)
 
 #endif	/* __irq_cpustat_h */

