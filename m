Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262723AbVCKELc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbVCKELc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 23:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVCKEK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 23:10:58 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:47759 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S263193AbVCKEAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 23:00:18 -0500
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Date: Fri, 11 Mar 2005 15:00:11 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16945.6091.581225.377464@berry.gelato.unsw.EDU.AU>
Subject: Microstate Accounting for 2.6.11, patch 3/6
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Microstate accounting:  

Provide I386-dependent MSA clocks, and Kconfig options.

 arch/i386/Kconfig      |   39 ++++++++++++++++++++++++++++++++++++++-
 include/asm-i386/msa.h |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 1 deletion(-)

Signed-off-by: Peter Chubb <peterc@gelato.unsw.edu.au>

Index: linux-2.6-ustate/arch/i386/Kconfig
===================================================================
--- linux-2.6-ustate.orig/arch/i386/Kconfig	2005-03-11 09:59:38.773632446 +1100
+++ linux-2.6-ustate/arch/i386/Kconfig	2005-03-11 09:59:38.777538666 +1100
@@ -923,8 +923,45 @@
 
 	  If unsure, say Y. Only embedded should say N here.
 
-endmenu
+config MICROSTATE
+       bool "Microstate accounting"
+       help
+         This option causes the kernel to keep very accurate track of
+	 how long your threads spend on the runqueues, running, or asleep or
+	 stopped.  It will slow down your kernel.
+	 Times are reported in /proc/pid/msa and through a new msa()
+	 system call.
+
+choice 
+       depends on MICROSTATE
+       prompt "Microstate timing source"
+       default MICROSTATE_TSC
+
+config MICROSTATE_PM
+       bool "Use Power-Management timer for microstate timings"
+       depends on X86_PM_TIMER
+       help
+	 If your machine is ACPI enabled and uses power-management, then the 
+	 TSC runs at a variable rate, which will distort the 
+	 microstate measurements.  This timer, although having
+	 slightly more overhead, and a lower resolution (279
+	 nanoseconds or so) will always run at a constant rate.
+
+config MICROSTATE_TSC
+       bool "Use on-chip TSC for microstate timings"
+       depends on X86_TSC
+       help
+         If your machine's clock runs at constant rate, then this timer 
+	 gives you cycle precision in measureing times spent in microstates.
+
+config MICROSTATE_TOD
+       bool "Use time-of-day clock for microstate timings"
+       help
+         If none of the other timers are any good for you, this timer 
+	 will give you micro-second precision.
+endchoice
 
+endmenu
 
 menu "Power management options (ACPI, APM)"
 	depends on !X86_VOYAGER
Index: linux-2.6-ustate/include/asm-i386/msa.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-ustate/include/asm-i386/msa.h	2005-03-11 09:59:38.779491777 +1100
@@ -0,0 +1,49 @@
+/************************************************************************
+ * asm-i386/msa.h
+ *
+ * Provide an architecture-specific clock.
+ */
+
+#ifndef _ASM_I386_MSA_H
+# define _ASM_I386_MSA_H
+
+# include <linux/config.h>
+
+
+# if defined(CONFIG_MICROSTATE_TSC)
+/*
+ * Use the processor's time-stamp counter as a timesource
+ */
+#  include <asm/msr.h>
+#  include <asm/div64.h>
+
+#  define MSA_NOW(now)  rdtscll(now)
+
+extern unsigned long cpu_khz;
+#  define MSA_TO_NSEC(clk) ({ clk_t _x = ((clk) * 1000000ULL); do_div(_x, cpu_khz); _x; })
+
+# elif defined(CONFIG_MICROSTATE_PM)
+/*
+ * Use the system's monotonic clock as a timesource.
+ * This will only be enabled if the Power Management Timer is enabled.
+ */
+unsigned long long monotonic_clock(void);
+#  define MSA_NOW(now) do { now = monotonic_clock(); } while (0)
+#  define MSA_TO_NSEC(clk) (clk)
+
+# elif defined(CONFIG_MICROSTATE_TOD)
+/*
+ * Fall back to gettimeofday.
+ * This one is incompatible with interrupt-time measurement on some processors.
+ */
+static inline void msa_now(clk_t *nsp) {
+	struct timeval tv;
+	do_gettimeofday(&tv);
+	*nsp = tv.tv_sec * 1000000 + tv.tv_usec;
+}
+#   define MSA_NOW(x) msa_now(&x)
+#   define MSA_TO_NSEC(clk) ((clk) * 1000)
+# endif
+
+
+#endif /* _ASM_I386_MSA_H */
I386
