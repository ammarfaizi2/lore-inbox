Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWGRJYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWGRJYA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 05:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWGRJVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 05:21:39 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:32898 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932138AbWGRJVQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 05:21:16 -0400
Message-Id: <20060718091949.565211000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 18 Jul 2006 00:00:04 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Zachary Amsden <zach@vmware.com>, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 04/33] Add XEN config options and disable unsupported config options.
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

diff -r 5851dd4e1b8f arch/i386/Kconfig
--- a/arch/i386/Kconfig	Mon Jul 17 23:10:01 2006 -0400
+++ b/arch/i386/Kconfig	Mon Jul 17 23:11:45 2006 -0400
@@ -67,6 +67,7 @@ menu "Processor type and features"
 
 config SMP
 	bool "Symmetric multi-processing support"
+	depends on !X86_XEN
 	---help---
 	  This enables support for systems with more than one CPU. If you have
 	  a system with only one CPU, like most personal computers, say N. If
@@ -102,6 +103,12 @@ config X86_PC
 	bool "PC-compatible"
 	help
 	  Choose this option if your computer is a standard PC or compatible.
+
+config X86_XEN
+	bool "Xen-compatible"
+	help
+	  Choose this option if you plan to run this kernel on top of the
+	  Xen Hypervisor.
 
 config X86_ELAN
 	bool "AMD Elan"
@@ -211,6 +218,7 @@ source "arch/i386/Kconfig.cpu"
 
 config HPET_TIMER
 	bool "HPET Timer Support"
+	depends on !X86_XEN
 	help
 	  This enables the use of the HPET for the kernel's internal timer.
 	  HPET is the next generation timer replacing legacy 8254s.
@@ -261,7 +269,7 @@ source "kernel/Kconfig.preempt"
 
 config X86_UP_APIC
 	bool "Local APIC support on uniprocessors"
-	depends on !SMP && !(X86_VISWS || X86_VOYAGER)
+	depends on !SMP && !(X86_VISWS || X86_VOYAGER || X86_XEN)
 	help
 	  A local APIC (Advanced Programmable Interrupt Controller) is an
 	  integrated interrupt controller in the CPU. If you have a single-CPU
@@ -286,12 +294,12 @@ config X86_UP_IOAPIC
 
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
@@ -739,7 +747,7 @@ source kernel/Kconfig.hz
 
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on EXPERIMENTAL && !X86_XEN
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
@@ -808,7 +816,7 @@ config ARCH_ENABLE_MEMORY_HOTPLUG
 	depends on HIGHMEM
 
 menu "Power management options (ACPI, APM)"
-	depends on !X86_VOYAGER
+	depends on !(X86_VOYAGER || X86_XEN)
 
 source kernel/power/Kconfig
 
@@ -1144,6 +1152,8 @@ source "security/Kconfig"
 
 source "crypto/Kconfig"
 
+source "drivers/xen/Kconfig"
+
 source "lib/Kconfig"
 
 #
diff -r 5851dd4e1b8f arch/i386/Kconfig.cpu
--- a/arch/i386/Kconfig.cpu	Mon Jul 17 23:10:01 2006 -0400
+++ b/arch/i386/Kconfig.cpu	Mon Jul 17 23:11:45 2006 -0400
@@ -251,7 +251,7 @@ config X86_PPRO_FENCE
 
 config X86_F00F_BUG
 	bool
-	depends on M586MMX || M586TSC || M586 || M486 || M386
+	depends on (M586MMX || M586TSC || M586 || M486 || M386) && !XEN
 	default y
 
 config X86_WP_WORKS_OK
diff -r 5851dd4e1b8f arch/i386/Kconfig.debug
--- a/arch/i386/Kconfig.debug	Mon Jul 17 23:10:01 2006 -0400
+++ b/arch/i386/Kconfig.debug	Mon Jul 17 23:11:45 2006 -0400
@@ -79,6 +79,7 @@ config DOUBLEFAULT
 config DOUBLEFAULT
 	default y
 	bool "Enable doublefault exception handler" if EMBEDDED
+	depends on !X86_XEN
 	help
           This option allows trapping of rare doublefault exceptions that
           would otherwise cause a system to silently reboot. Disabling this
diff -r 5851dd4e1b8f kernel/Kconfig.hz
--- a/kernel/Kconfig.hz	Mon Jul 17 23:10:01 2006 -0400
+++ b/kernel/Kconfig.hz	Mon Jul 17 23:11:45 2006 -0400
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
 
diff -r 5851dd4e1b8f kernel/Kconfig.preempt
--- a/kernel/Kconfig.preempt	Mon Jul 17 23:10:01 2006 -0400
+++ b/kernel/Kconfig.preempt	Mon Jul 17 23:11:45 2006 -0400
@@ -35,6 +35,7 @@ config PREEMPT_VOLUNTARY
 
 config PREEMPT
 	bool "Preemptible Kernel (Low-Latency Desktop)"
+	depends on !XEN
 	help
 	  This option reduces the latency of the kernel by making
 	  all kernel code (that is not executing in a critical section)
diff -r 5851dd4e1b8f drivers/xen/Kconfig
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/drivers/xen/Kconfig	Mon Jul 17 23:11:45 2006 -0400
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
