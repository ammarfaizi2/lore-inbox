Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbWCMSDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWCMSDd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWCMSDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:03:32 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:45067 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751443AbWCMSDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:03:31 -0500
Date: Mon, 13 Mar 2006 10:00:27 -0800
Message-Id: <200603131800.k2DI0RfN005633@zach-dev.vmware.com>
Subject: [RFC, PATCH 2/24] i386 Vmi config
From: Zachary Amsden <zach@vmware.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       Dan Hecht <dhecht@vmware.com>, Dan Arai <arai@vmware.com>,
       Anne Holler <anne@vmware.com>, Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 13 Mar 2006 18:00:28.0049 (UTC) FILETIME=[02C4C010:01C646C8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the basic VMI sub-arch configuration dependencies.  VMI kernels only
are designed to run on modern hardware platforms.  As such, they require a
working APIC, and do not support some legacy functionality, including APM BIOS,
ISA and MCA bus systems, PCI BIOS interfaces, or PnP BIOS (by implication of
dropping ISA support).  They also require a P6 series CPU.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.16-rc5/arch/i386/Kconfig
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/Kconfig	2006-03-06 11:25:08.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/Kconfig	2006-03-06 16:41:25.000000000 -0800
@@ -133,8 +133,33 @@ config X86_ES7000
 	  Only choose this option if you have such a system, otherwise you
 	  should say N here.
 
+config X86_VMI
+	bool "VMI architecture support"
+	help
+	   This option builds a kernel designed to run on top of a virtual
+	   machine interface layer (VMI).  Say 'N' here unless you are
+	   building a kernel to run inside a virtual machine.
+
 endchoice
 
+menu "VMI configurable support"
+	depends on X86_VMI
+
+config VMI_REQUIRE_HYPERVISOR
+        bool "Require hypervisor"
+        default n
+        help
+          This option forces the kernel to run with a hypervisor present.
+          The kernel will panic if booted on native hardware.
+
+config VMI_DEBUG
+	bool "VMI debugging"
+	default n
+	help
+	  Provides extra debugging output and testing of VMI interfaces.
+
+endmenu
+
 config ACPI_SRAT
 	bool
 	default y
@@ -270,7 +295,7 @@ config X86_VISWS_APIC
 
 config X86_MCE
 	bool "Machine Check Exception"
-	depends on !X86_VOYAGER
+	depends on !(X86_VOYAGER)
 	---help---
 	  Machine Check Exception support allows the processor to notify the
 	  kernel if it detects a problem (e.g. overheating, component failure).
@@ -307,6 +332,7 @@ config X86_MCE_P4THERMAL
 
 config TOSHIBA
 	tristate "Toshiba Laptop support"
+	depends on !X86_VMI
 	---help---
 	  This adds a driver to safely access the System Management Mode of
 	  the CPU on Toshiba portables with a genuine Toshiba BIOS. It does
@@ -322,6 +348,7 @@ config TOSHIBA
 
 config I8K
 	tristate "Dell laptop support"
+	depends on !X86_VMI
 	---help---
 	  This adds a driver to safely access the System Management Mode
 	  of the CPU on the Dell Inspiron 8000. The System Management Mode
@@ -569,6 +596,7 @@ config HIGHPTE
 
 config MATH_EMULATION
 	bool "Math emulation"
+	depends on !X86_VMI
 	---help---
 	  Linux can emulate a math coprocessor (used for floating point
 	  operations) if you don't have one. 486DX and Pentium processors have
@@ -760,7 +788,7 @@ source kernel/power/Kconfig
 source "drivers/acpi/Kconfig"
 
 menu "APM (Advanced Power Management) BIOS Support"
-depends on PM && !X86_VISWS
+depends on PM && !(X86_VISWS || X86_VMI)
 
 config APM
 	tristate "APM (Advanced Power Management) BIOS support"
@@ -930,8 +958,9 @@ config PCI
 
 choice
 	prompt "PCI access mode"
-	depends on PCI && !X86_VISWS
+	depends on PCI && !(X86_VISWS || X86_VMI)
 	default PCI_GOANY
+
 	---help---
 	  On PCI systems, the BIOS can be used to detect the PCI devices and
 	  determine their configuration. However, some old PCI motherboards
@@ -963,12 +992,12 @@ endchoice
 
 config PCI_BIOS
 	bool
-	depends on !X86_VISWS && PCI && (PCI_GOBIOS || PCI_GOANY)
+	depends on !(X86_VISWS && X86_VMI) && PCI && (PCI_GOBIOS || PCI_GOANY)
 	default y
 
 config PCI_DIRECT
 	bool
- 	depends on PCI && ((PCI_GODIRECT || PCI_GOANY) || X86_VISWS)
+ 	depends on PCI && ((PCI_GODIRECT || PCI_GOANY) || X86_VISWS || X86_VMI)
 	default y
 
 config PCI_MMCONFIG
@@ -986,7 +1015,7 @@ config ISA_DMA_API
 
 config ISA
 	bool "ISA support"
-	depends on !(X86_VOYAGER || X86_VISWS)
+	depends on !(X86_VOYAGER || X86_VISWS || X86_VMI)
 	help
 	  Find out whether you have ISA slots on your motherboard.  ISA is the
 	  name of a bus system, i.e. the way the CPU talks to the other stuff
@@ -1013,7 +1042,7 @@ config EISA
 source "drivers/eisa/Kconfig"
 
 config MCA
-	bool "MCA support" if !(X86_VISWS || X86_VOYAGER)
+	bool "MCA support" if !(X86_VISWS || X86_VOYAGER || X86_VMI)
 	default y if X86_VOYAGER
 	help
 	  MicroChannel Architecture is found in some IBM PS/2 machines and
Index: linux-2.6.16-rc5/arch/i386/Kconfig.cpu
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/Kconfig.cpu	2006-03-06 11:25:08.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/Kconfig.cpu	2006-03-06 16:01:41.000000000 -0800
@@ -7,6 +7,7 @@ choice
 
 config M386
 	bool "386"
+	depends on !X86_VMI
 	---help---
 	  This is the processor type of your CPU. This information is used for
 	  optimizing purposes. In order to compile a kernel that can run on
@@ -47,6 +48,7 @@ config M386
 
 config M486
 	bool "486"
+	depends on !X86_VMI
 	help
 	  Select this for a 486 series processor, either Intel or one of the
 	  compatible processors from AMD, Cyrix, IBM, or Intel.  Includes DX,
@@ -55,6 +57,7 @@ config M486
 
 config M586
 	bool "586/K5/5x86/6x86/6x86MX"
+	depends on !X86_VMI
 	help
 	  Select this for an 586 or 686 series processor such as the AMD K5,
 	  the Cyrix 5x86, 6x86 and 6x86MX.  This choice does not
@@ -62,12 +65,14 @@ config M586
 
 config M586TSC
 	bool "Pentium-Classic"
+	depends on !X86_VMI
 	help
 	  Select this for a Pentium Classic processor with the RDTSC (Read
 	  Time Stamp Counter) instruction for benchmarking.
 
 config M586MMX
 	bool "Pentium-MMX"
+	depends on !X86_VMI
 	help
 	  Select this for a Pentium with the MMX graphics/multimedia
 	  extended instructions.
