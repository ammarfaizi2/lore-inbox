Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316821AbSFQHBe>; Mon, 17 Jun 2002 03:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316827AbSFQHAs>; Mon, 17 Jun 2002 03:00:48 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:1674 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316778AbSFQG7P>;
	Mon, 17 Jun 2002 02:59:15 -0400
Date: Mon, 17 Jun 2002 12:31:47 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: kernprof <kernprof@oss.sgi.com>
Cc: lse <lse-tech@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: [RFC - Patch] Kernprof kernel profiling in NMI mode
Message-ID: <20020617123147.F1319@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch to enable SGI kernprof kernel profiling in NMI mode 
(x86 only).  This patch sets the PMC overflow apic interrupt 
delivery mode to NMI, and gathers profile data in the NMI handler. This
will enable PMC domain profiling to happen in NMI mode. NMI mode equivalent 
of time domain profiling can be carried out by doing a PMC domain 
profiling with CPU_CLKS_UNHALTED event (P6 family).

With this patch kernprof can:
* Profile routines/code paths  which run with on-chip interrupts disabled
* Give accurate and indicative 'verbose' output - in the sense
  events/ticks in interrput disabled code-paths show up at the actual
  event generating locations (unlike, say all L2 misses/profile ticks
  showing up after sti)

This patch adds an extra call to the profiling path (That can be made inline
on the next patch release).  Also, a config option is provided to enable
NMI based profiling.

This patch applies neatly on top of SGI kernprof version 0.12, patch for 2.5.8
profile-0.12.1-2.5.8.patch, and requires no changes to the user level kernprof
command tool. Patch has been tested on a 4way PIII Xeon box.

Request comments on usefulness, improvements, potential breakages :).....

Kiran


diff -ruN -X dontdiff linux-2.5.8/arch/i386/Config.help nmi-kern/arch/i386/Config.help
--- linux-2.5.8/arch/i386/Config.help	Thu Jun 13 18:23:22 2002
+++ nmi-kern/arch/i386/Config.help	Thu Jun 13 19:22:47 2002
@@ -946,6 +946,12 @@
   The module will be called profile.o. If you want to compile it as a
   module, say M here and read Documentation/modules.txt.
 
+CONFIG_NMI_PROFILING
+  Saying Y here will set the interrupt delivery mode for PMC domain
+  profiling to NMI. This is useful if you want to profile kernel code
+  paths which mask interrputs (eg. code between spin_lock_irq and
+  spin_unlock_irq).
+
 CONFIG_MCOUNT
   This will instrument the kernel with calls to mcount(), which enables 
   call-graph and call-count profiling.  Because mcount() is called at 
diff -ruN -X dontdiff linux-2.5.8/arch/i386/config.in nmi-kern/arch/i386/config.in
--- linux-2.5.8/arch/i386/config.in	Thu Jun 13 18:23:22 2002
+++ nmi-kern/arch/i386/config.in	Thu Jun 13 19:12:22 2002
@@ -423,6 +423,7 @@
 tristate 'Kernel Profiling Support' CONFIG_PROFILING
 if [ "$CONFIG_PROFILING" != "n" ]; then
    define_bool CONFIG_FRAME_POINTER y
+   bool '  Use NMI delivery for PMC events profiling' CONFIG_NMI_PROFILING
 fi
 bool 'Instrument kernel at entry to all C functions' CONFIG_MCOUNT
 if [ "$CONFIG_MCOUNT" = "y" ]; then
diff -ruN -X dontdiff linux-2.5.8/arch/i386/kernel/apic.c nmi-kern/arch/i386/kernel/apic.c
--- linux-2.5.8/arch/i386/kernel/apic.c	Thu Jun 13 18:23:22 2002
+++ nmi-kern/arch/i386/kernel/apic.c	Thu Jun 13 19:48:04 2002
@@ -30,6 +30,7 @@
 #include <asm/mtrr.h>
 #include <asm/mpspec.h>
 #include <asm/pgalloc.h>
+#include <asm/profile.h>
 
 /* Using APIC to generate smp_local_timer_interrupt? */
 int using_apic_timer = 0;
@@ -971,7 +972,7 @@
 void __init setup_APIC_perfctr_vector(void *unused)
 {
 	(void) apic_read(APIC_LVTPC);
-	apic_write(APIC_LVTPC, PERFCTR_OVFL_VECTOR);
+	apic_write(APIC_LVTPC, PERFCTR_OVFL_VECTOR_MODE);
 }
  
 void __init setup_APIC_perfctr(void)
diff -ruN -X dontdiff linux-2.5.8/arch/i386/kernel/traps.c nmi-kern/arch/i386/kernel/traps.c
--- linux-2.5.8/arch/i386/kernel/traps.c	Mon Apr 15 00:48:46 2002
+++ nmi-kern/arch/i386/kernel/traps.c	Thu Jun 13 19:03:42 2002
@@ -491,6 +491,10 @@
 			return;
 		}
 #endif
+#if 	CONFIG_NMI_PROFILING
+		smp_apic_perfctr_overflow_interrupt(*regs);
+		return;
+#endif
 		unknown_nmi_error(reason, regs);
 		return;
 	}
diff -ruN -X dontdiff linux-2.5.8/include/asm-i386/profile.h nmi-kern/include/asm-i386/profile.h
--- linux-2.5.8/include/asm-i386/profile.h	Thu Jun 13 18:23:22 2002
+++ nmi-kern/include/asm-i386/profile.h	Thu Jun 13 20:18:15 2002
@@ -137,6 +137,12 @@
 	wrmsr(MSR_P6_EVNTSEL1, 0, 0);
 	wrmsr(MSR_P6_EVNTSEL0, EVENTSEL0_ENABLE_MASK | (evt), 0);
 }
+#ifdef CONFIG_NMI_PROFILING
+#define PERFCTR_OVFL_VECTOR_MODE                                        \
+        SET_APIC_DELIVERY_MODE(PERFCTR_OVFL_VECTOR, APIC_MODE_NMI)
+#else
+#define PERFCTR_OVFL_VECTOR_MODE        PERFCTR_OVFL_VECTOR
+#endif
 #else
 #define have_perfctr()		0
 #define valid_perfctr_event(e)	0
