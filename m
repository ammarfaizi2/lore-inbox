Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751519AbWEIIs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbWEIIs4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWEIIsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:48:42 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:44163 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751480AbWEIIsh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:48:37 -0400
Message-Id: <20060509085145.790527000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
Date: Tue, 09 May 2006 00:00:01 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 01/35] Add XEN config options and disable unsupported config options.
Content-Disposition: inline; filename=config-xen
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The XEN config option is selected from the i386 subarch menu by
choosing the X86_XEN "Xen-compatible" subarch.

The XEN_SHADOW_MODE option defines the memory virtualization mode for
the kernel -- with it enabled, the kernel expects the hypervisor to
perform translation between pseudo-physical and machine addresses on
its behalf.

The disabled config options are:
- DOUBLEFAULT: are trapped by Xen and not virtualized
- HZ: defaults to 100 in Xen VMs
- Power management: not supported in unprivileged VMs
- SMP: not supported in this set of patches
- X86_{UP,LOCAL,IO}_APIC: not supported in unprivileged VMs

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/Kconfig       |   18 ++++++++++++++----
 arch/i386/Kconfig.debug |    1 +
 drivers/xen/Kconfig     |   21 +++++++++++++++++++++
 kernel/Kconfig.hz       |    4 ++--
 kernel/Kconfig.preempt  |    1 +
 5 files changed, 39 insertions(+), 6 deletions(-)

--- linus-2.6.orig/arch/i386/Kconfig
+++ linus-2.6/arch/i386/Kconfig
@@ -55,6 +55,7 @@ menu "Processor type and features"
 
 config SMP
 	bool "Symmetric multi-processing support"
+	depends on !X86_XEN
 	---help---
 	  This enables support for systems with more than one CPU. If you have
 	  a system with only one CPU, like most personal computers, say N. If
@@ -91,6 +92,12 @@ config X86_PC
 	help
 	  Choose this option if your computer is a standard PC or compatible.
 
+config X86_XEN
+	bool "Xen-compatible"
+	help
+	  Choose this option if you plan to run this kernel on top of the
+	  Xen Hypervisor.
+
 config X86_ELAN
 	bool "AMD Elan"
 	help
@@ -193,6 +200,7 @@ source "arch/i386/Kconfig.cpu"
 
 config HPET_TIMER
 	bool "HPET Timer Support"
+	depends on !X86_XEN
 	help
 	  This enables the use of the HPET for the kernel's internal timer.
 	  HPET is the next generation timer replacing legacy 8254s.
@@ -244,7 +252,7 @@ source "kernel/Kconfig.preempt"
 
 config X86_UP_APIC
 	bool "Local APIC support on uniprocessors"
-	depends on !SMP && !(X86_VISWS || X86_VOYAGER)
+	depends on !SMP && !(X86_VISWS || X86_VOYAGER || X86_XEN)
 	help
 	  A local APIC (Advanced Programmable Interrupt Controller) is an
 	  integrated interrupt controller in the CPU. If you have a single-CPU
@@ -269,12 +277,12 @@ config X86_UP_IOAPIC
 
 config X86_LOCAL_APIC
 	bool
-	depends on X86_UP_APIC || ((X86_VISWS || SMP) && !X86_VOYAGER)
+	depends on X86_UP_APIC || ((X86_VISWS || SMP) && !(X86_VOYAGER || X86_XEN))
 	default y
 
 config X86_IO_APIC
 	bool
-	depends on X86_UP_IOAPIC || (SMP && !(X86_VISWS || X86_VOYAGER))
+	depends on X86_UP_IOAPIC || (SMP && !(X86_VISWS || X86_VOYAGER || X86_XEN))
 	default y
 
 config X86_VISWS_APIC
@@ -767,7 +775,7 @@ endmenu
 
 
 menu "Power management options (ACPI, APM)"
-	depends on !X86_VOYAGER
+	depends on !(X86_VOYAGER || X86_XEN)
 
 source kernel/power/Kconfig
 
@@ -1089,6 +1097,8 @@ source "security/Kconfig"
 
 source "crypto/Kconfig"
 
+source "drivers/xen/Kconfig"
+
 source "lib/Kconfig"
 
 #
--- linus-2.6.orig/arch/i386/Kconfig.debug
+++ linus-2.6/arch/i386/Kconfig.debug
@@ -84,6 +84,7 @@ config X86_MPPARSE
 config DOUBLEFAULT
 	default y
 	bool "Enable doublefault exception handler" if EMBEDDED
+	depends on !X86_XEN
 	help
           This option allows trapping of rare doublefault exceptions that
           would otherwise cause a system to silently reboot. Disabling this
--- linus-2.6.orig/kernel/Kconfig.hz
+++ linus-2.6/kernel/Kconfig.hz
@@ -3,7 +3,7 @@
 #
 
 choice
-	prompt "Timer frequency"
+	prompt "Timer frequency" if !XEN
 	default HZ_250
 	help
 	 Allows the configuration of the timer frequency. It is customary
@@ -40,7 +40,7 @@ endchoice
 
 config HZ
 	int
-	default 100 if HZ_100
+	default 100 if HZ_100 || XEN
 	default 250 if HZ_250
 	default 1000 if HZ_1000
 
--- linus-2.6.orig/kernel/Kconfig.preempt
+++ linus-2.6/kernel/Kconfig.preempt
@@ -35,6 +35,7 @@ config PREEMPT_VOLUNTARY
 
 config PREEMPT
 	bool "Preemptible Kernel (Low-Latency Desktop)"
+	depends on !XEN
 	help
 	  This option reduces the latency of the kernel by making
 	  all kernel code (that is not executing in a critical section)
--- /dev/null
+++ linus-2.6/drivers/xen/Kconfig
@@ -0,0 +1,21 @@
+#
+# This Kconfig describe xen options
+#
+
+mainmenu "Xen Configuration"
+
+config XEN
+	bool
+	default y if X86_XEN
+	help
+	  This is the Linux Xen port.
+
+if XEN
+
+config XEN_SHADOW_MODE
+	bool
+	default y
+	help
+	  Fakes out a shadow mode kernel
+
+endif

--
