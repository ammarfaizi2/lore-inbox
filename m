Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVCYWAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVCYWAA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbVCYV7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 16:59:39 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:7321 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261830AbVCYVyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 16:54:49 -0500
Subject: [RFC][PATCH 2/4] make each arch use mm/Kconfig
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <haveblue@us.ibm.com>, apw@shadowen.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 25 Mar 2005 13:54:46 -0800
Message-Id: <E1DEwlT-0006K4-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With sparsemem being introduced, we need a central place for new
memory-related .config options: mm/Kconfig.

For all architectures, this just means that you'll see a
"Memory Model" choice in your architecture menu. For those that
implement DISCONTIGMEM, you may eventually want to make your
ARCH_DISCONTIGMEM_ENABLE a "def_bool y" and make your users
select DISCONTIGMEM right out of the new choice menu.  The only
disadvantage might be if you have some specific things that you
need in your help option for DISCONTIGMEM.  

The new option, CONFIG_FLATMEM, is there to enable us to detangle
NUMA and DISCONTIGMEM.  This is a requirement for sparsemem
because sparsemem uses the NUMA code without the presence of
DISCONTIGMEM. The sparsemem patches use CONFIG_FLATMEM in generic
code, so this patch is a requirement before applying them.

Almost all places that used to do '#ifndef CONFIG_DISCONTIGMEM'
should use '#ifdef CONFIG_FLATMEM' instead.
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/arch/alpha/Kconfig     |    4 +++-
 memhotplug-dave/arch/arm/Kconfig       |    4 +++-
 memhotplug-dave/arch/arm26/Kconfig     |    2 ++
 memhotplug-dave/arch/cris/Kconfig      |    2 ++
 memhotplug-dave/arch/frv/Kconfig       |    2 ++
 memhotplug-dave/arch/h8300/Kconfig.cpu |    3 +++
 memhotplug-dave/arch/i386/Kconfig      |    4 +++-
 memhotplug-dave/arch/ia64/Kconfig      |    4 +++-
 memhotplug-dave/arch/m32r/Kconfig      |    4 +++-
 memhotplug-dave/arch/m68k/Kconfig      |    2 ++
 memhotplug-dave/arch/m68knommu/Kconfig |    2 ++
 memhotplug-dave/arch/mips/Kconfig      |    6 +++++-
 memhotplug-dave/arch/parisc/Kconfig    |    8 +++++++-
 memhotplug-dave/arch/ppc/Kconfig       |    2 ++
 memhotplug-dave/arch/ppc64/Kconfig     |    4 +++-
 memhotplug-dave/arch/s390/Kconfig      |    2 ++
 memhotplug-dave/arch/sh/Kconfig        |    8 +++++++-
 memhotplug-dave/arch/sh64/Kconfig      |    2 ++
 memhotplug-dave/arch/sparc/Kconfig     |    2 ++
 memhotplug-dave/arch/sparc64/Kconfig   |    2 ++
 memhotplug-dave/arch/um/Kconfig        |    1 +
 memhotplug-dave/arch/v850/Kconfig      |    2 ++
 memhotplug-dave/arch/x86_64/Kconfig    |    4 +++-
 23 files changed, 66 insertions(+), 10 deletions(-)

diff -puN arch/alpha/Kconfig~A7-make-each-arch-use-mm-Kconfig arch/alpha/Kconfig
--- memhotplug/arch/alpha/Kconfig~A7-make-each-arch-use-mm-Kconfig	2005-03-25 08:08:22.000000000 -0800
+++ memhotplug-dave/arch/alpha/Kconfig	2005-03-25 08:08:22.000000000 -0800
@@ -505,7 +505,7 @@ config NR_CPUS
 	depends on SMP
 	default "64"
 
-config DISCONTIGMEM
+config ARCH_DISCONTIGMEM_ENABLE
 	bool "Discontiguous Memory Support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
 	help
@@ -514,6 +514,8 @@ config DISCONTIGMEM
 	  or have huge holes in the physical address space for other reasons.
 	  See <file:Documentation/vm/numa> for more.
 
+source "mm/Kconfig"
+
 config NUMA
 	bool "NUMA Support (EXPERIMENTAL)"
 	depends on DISCONTIGMEM
diff -puN arch/arm/Kconfig~A7-make-each-arch-use-mm-Kconfig arch/arm/Kconfig
--- memhotplug/arch/arm/Kconfig~A7-make-each-arch-use-mm-Kconfig	2005-03-25 08:08:22.000000000 -0800
+++ memhotplug-dave/arch/arm/Kconfig	2005-03-25 08:08:22.000000000 -0800
@@ -289,7 +289,7 @@ config NR_CPUS
 	depends on SMP
 	default "4"
 
-config DISCONTIGMEM
+config ARCH_DISCONTIGMEM_ENABLE
 	bool
 	depends on ARCH_EDB7211 || ARCH_SA1100 || (ARCH_LH7A40X && !LH7A40X_CONTIGMEM)
 	default y
@@ -299,6 +299,8 @@ config DISCONTIGMEM
 	  or have huge holes in the physical address space for other reasons.
 	  See <file:Documentation/vm/numa> for more.
 
+source "mm/Kconfig"
+
 # Now handle the bus types
 config PCI
 	bool "PCI support" if ARCH_INTEGRATOR_AP
diff -puN arch/arm26/Kconfig~A7-make-each-arch-use-mm-Kconfig arch/arm26/Kconfig
--- memhotplug/arch/arm26/Kconfig~A7-make-each-arch-use-mm-Kconfig	2005-03-25 08:08:22.000000000 -0800
+++ memhotplug-dave/arch/arm26/Kconfig	2005-03-25 08:08:22.000000000 -0800
@@ -175,6 +175,8 @@ config CMDLINE
 	  time by entering them here. As a minimum, you should specify the
 	  memory size and the root device (e.g., mem=64M root=/dev/nfs).
 
+source "mm/Kconfig"
+
 endmenu
 
 source "drivers/base/Kconfig"
diff -puN arch/cris/Kconfig~A7-make-each-arch-use-mm-Kconfig arch/cris/Kconfig
--- memhotplug/arch/cris/Kconfig~A7-make-each-arch-use-mm-Kconfig	2005-03-25 08:08:22.000000000 -0800
+++ memhotplug-dave/arch/cris/Kconfig	2005-03-25 08:08:22.000000000 -0800
@@ -74,6 +74,8 @@ config PREEMPT
 	  Say Y here if you are building a kernel for a desktop, embedded
 	  or real-time system.  Say N if you are unsure.
 
+source mm/Kconfig
+
 endmenu
 
 menu "Hardware setup"
diff -puN arch/frv/Kconfig~A7-make-each-arch-use-mm-Kconfig arch/frv/Kconfig
--- memhotplug/arch/frv/Kconfig~A7-make-each-arch-use-mm-Kconfig	2005-03-25 08:08:22.000000000 -0800
+++ memhotplug-dave/arch/frv/Kconfig	2005-03-25 08:08:22.000000000 -0800
@@ -74,6 +74,8 @@ config HIGHPTE
 	  with a lot of RAM, this can be wasteful of precious low memory.
 	  Setting this option will put user-space page tables in high memory.
 
+source "mm/Kconfig"
+
 choice
 	prompt "uClinux kernel load address"
 	depends on !MMU
diff -puN arch/h8300/Kconfig.cpu~A7-make-each-arch-use-mm-Kconfig arch/h8300/Kconfig.cpu
--- memhotplug/arch/h8300/Kconfig.cpu~A7-make-each-arch-use-mm-Kconfig	2005-03-25 08:08:22.000000000 -0800
+++ memhotplug-dave/arch/h8300/Kconfig.cpu	2005-03-25 08:08:22.000000000 -0800
@@ -180,4 +180,7 @@ config CPU_H8S
 config PREEMPT
 	bool "Preemptible Kernel"
 	default n
+
+source "mm/Kconfig'
+
 endmenu
diff -puN arch/i386/Kconfig~A7-make-each-arch-use-mm-Kconfig arch/i386/Kconfig
--- memhotplug/arch/i386/Kconfig~A7-make-each-arch-use-mm-Kconfig	2005-03-25 08:08:22.000000000 -0800
+++ memhotplug-dave/arch/i386/Kconfig	2005-03-25 08:08:22.000000000 -0800
@@ -767,7 +767,7 @@ comment "NUMA (NUMA-Q) requires SMP, 64G
 comment "NUMA (Summit) requires SMP, 64GB highmem support, ACPI"
 	depends on X86_SUMMIT && (!HIGHMEM64G || !ACPI)
 
-config DISCONTIGMEM
+config ARCH_DISCONTIGMEM_ENABLE
 	bool
 	depends on NUMA
 	default y
@@ -792,6 +792,8 @@ config HAVE_ARCH_ALLOC_REMAP
 	depends on NUMA
 	default y
 
+source "mm/Kconfig"
+
 config HIGHPTE
 	bool "Allocate 3rd-level pagetables from highmem"
 	depends on HIGHMEM4G || HIGHMEM64G
diff -puN arch/ia64/Kconfig~A7-make-each-arch-use-mm-Kconfig arch/ia64/Kconfig
--- memhotplug/arch/ia64/Kconfig~A7-make-each-arch-use-mm-Kconfig	2005-03-25 08:08:22.000000000 -0800
+++ memhotplug-dave/arch/ia64/Kconfig	2005-03-25 08:08:22.000000000 -0800
@@ -188,7 +188,7 @@ config HOLES_IN_ZONE
 	bool
 	default y if VIRTUAL_MEM_MAP
 
-config DISCONTIGMEM
+config ARCH_DISCONTIGMEM_ENABLE
 	bool "Discontiguous memory support"
 	depends on (IA64_DIG || IA64_SGI_SN2 || IA64_GENERIC || IA64_HP_ZX1 || IA64_HP_ZX1_SWIOTLB) && NUMA && VIRTUAL_MEM_MAP
 	default y if (IA64_SGI_SN2 || IA64_GENERIC) && NUMA
@@ -272,6 +272,8 @@ config PREEMPT
           Say Y here if you are building a kernel for a desktop, embedded
           or real-time system.  Say N if you are unsure.
 
+source "mm/Kconfig"
+
 config HAVE_DEC_LOCK
 	bool
 	depends on (SMP || PREEMPT)
diff -puN arch/m32r/Kconfig~A7-make-each-arch-use-mm-Kconfig arch/m32r/Kconfig
--- memhotplug/arch/m32r/Kconfig~A7-make-each-arch-use-mm-Kconfig	2005-03-25 08:08:22.000000000 -0800
+++ memhotplug-dave/arch/m32r/Kconfig	2005-03-25 08:08:22.000000000 -0800
@@ -167,11 +167,13 @@ config NOHIGHMEM
 	bool
 	default y
 
-config DISCONTIGMEM
+config ARCH_DISCONTIGMEM_ENABLE
 	bool "Internal RAM Support"
 	depends on CHIP_M32700 || CHIP_M32102 || CHIP_VDEC2 || CHIP_OPSP
 	default y
 
+source "mm/Kconfig"
+
 config IRAM_START
 	hex "Internal memory start address (hex)"
 	default "00f00000"
diff -puN arch/m68k/Kconfig~A7-make-each-arch-use-mm-Kconfig arch/m68k/Kconfig
--- memhotplug/arch/m68k/Kconfig~A7-make-each-arch-use-mm-Kconfig	2005-03-25 08:08:22.000000000 -0800
+++ memhotplug-dave/arch/m68k/Kconfig	2005-03-25 08:08:22.000000000 -0800
@@ -357,6 +357,8 @@ config 060_WRITETHROUGH
 	  is hardwired on.  The 53c710 SCSI driver is known to suffer from
 	  this problem.
 
+source "mm/Kconfig"
+
 endmenu
 
 menu "General setup"
diff -puN arch/m68knommu/Kconfig~A7-make-each-arch-use-mm-Kconfig arch/m68knommu/Kconfig
--- memhotplug/arch/m68knommu/Kconfig~A7-make-each-arch-use-mm-Kconfig	2005-03-25 08:08:22.000000000 -0800
+++ memhotplug-dave/arch/m68knommu/Kconfig	2005-03-25 08:08:22.000000000 -0800
@@ -532,6 +532,8 @@ config ROMKERNEL
 
 endchoice
 
+source "mm/Kconfig"
+
 endmenu
 
 menu "Bus options (PCI, PCMCIA, EISA, MCA, ISA)"
diff -puN arch/mips/Kconfig~A7-make-each-arch-use-mm-Kconfig arch/mips/Kconfig
--- memhotplug/arch/mips/Kconfig~A7-make-each-arch-use-mm-Kconfig	2005-03-25 08:08:22.000000000 -0800
+++ memhotplug-dave/arch/mips/Kconfig	2005-03-25 08:08:23.000000000 -0800
@@ -492,7 +492,7 @@ config SGI_SN0_N_MODE
 	  which allows for more memory.  Your system is most probably
 	  running in M-Mode, so you should say N here.
 
-config DISCONTIGMEM
+config ARCH_DISCONTIGMEM_ENABLE
 	bool
 	default y if SGI_IP27
 	help
@@ -501,6 +501,10 @@ config DISCONTIGMEM
 	  or have huge holes in the physical address space for other reasons.
 	  See <file:Documentation/vm/numa> for more.
 
+config ARCH_FLATMEM_DISABLE
+	def_bool y
+	depends on ARCH_DISCONTIGMEM_ENABLE
+
 config NUMA
 	bool "NUMA Support"
 	depends on SGI_IP27
diff -puN arch/parisc/Kconfig~A7-make-each-arch-use-mm-Kconfig arch/parisc/Kconfig
--- memhotplug/arch/parisc/Kconfig~A7-make-each-arch-use-mm-Kconfig	2005-03-25 08:08:22.000000000 -0800
+++ memhotplug-dave/arch/parisc/Kconfig	2005-03-25 08:08:23.000000000 -0800
@@ -144,7 +144,7 @@ config HOTPLUG_CPU
 	default y if SMP
 	select HOTPLUG
 
-config DISCONTIGMEM
+config ARCH_DISCONTIGMEM_ENABLE
 	bool "Discontiguous memory support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
 	help
@@ -153,6 +153,12 @@ config DISCONTIGMEM
 	  or have huge holes in the physical address space for other reasons.
 	  See <file:Documentation/vm/numa> for more.
 
+config ARCH_FLATMEM_DISABLE
+	def_bool y
+	depends on ARCH_DISCONTIGMEM_ENABLE
+
+source "mm/Kconfig"
+
 config PREEMPT
 	bool
 #	bool "Preemptible Kernel"
diff -puN arch/ppc/Kconfig~A7-make-each-arch-use-mm-Kconfig arch/ppc/Kconfig
--- memhotplug/arch/ppc/Kconfig~A7-make-each-arch-use-mm-Kconfig	2005-03-25 08:08:22.000000000 -0800
+++ memhotplug-dave/arch/ppc/Kconfig	2005-03-25 08:08:23.000000000 -0800
@@ -893,6 +893,8 @@ config PREEMPT
 config HIGHMEM
 	bool "High memory support"
 
+source "mm/Kconfig"
+
 source "fs/Kconfig.binfmt"
 
 config PROC_DEVICETREE
diff -puN arch/ppc64/Kconfig~A7-make-each-arch-use-mm-Kconfig arch/ppc64/Kconfig
--- memhotplug/arch/ppc64/Kconfig~A7-make-each-arch-use-mm-Kconfig	2005-03-25 08:08:22.000000000 -0800
+++ memhotplug-dave/arch/ppc64/Kconfig	2005-03-25 08:08:23.000000000 -0800
@@ -198,10 +198,12 @@ config HMT
 	  This option enables hardware multithreading on RS64 cpus.
 	  pSeries systems p620 and p660 have such a cpu type.
 
-config DISCONTIGMEM
+config ARCH_DISCONTIGMEM_ENABLE
 	bool "Discontiguous Memory Support"
 	depends on SMP && PPC_PSERIES
 
+source "mm/Kconfig"
+
 config NUMA
 	bool "NUMA support"
 	depends on DISCONTIGMEM
diff -puN arch/s390/Kconfig~A7-make-each-arch-use-mm-Kconfig arch/s390/Kconfig
--- memhotplug/arch/s390/Kconfig~A7-make-each-arch-use-mm-Kconfig	2005-03-25 08:08:22.000000000 -0800
+++ memhotplug-dave/arch/s390/Kconfig	2005-03-25 08:08:23.000000000 -0800
@@ -226,6 +226,8 @@ config WARN_STACK_SIZE
 	  This allows you to specify the maximum frame size a function may
 	  have without the compiler complaining about it.
 
+source "mm/Kconfig"
+
 comment "I/O subsystem configuration"
 
 config MACHCHK_WARNING
diff -puN arch/sh/Kconfig~A7-make-each-arch-use-mm-Kconfig arch/sh/Kconfig
--- memhotplug/arch/sh/Kconfig~A7-make-each-arch-use-mm-Kconfig	2005-03-25 08:08:22.000000000 -0800
+++ memhotplug-dave/arch/sh/Kconfig	2005-03-25 08:08:23.000000000 -0800
@@ -486,7 +486,7 @@ config CPU_SUBTYPE_ST40
        depends on CPU_SUBTYPE_ST40STB1 || CPU_SUBTYPE_ST40GX1
        default y
 
-config DISCONTIGMEM
+config ARCH_DISCONTIGMEM_ENABLE
 	bool
 	depends on SH_HP690
 	default y
@@ -496,6 +496,12 @@ config DISCONTIGMEM
 	  or have huge holes in the physical address space for other reasons.
 	  See <file:Documentation/vm/numa> for more.
 
+config ARCH_FLATMEM_DISABLE
+	def_bool y
+	depends on ARCH_DISCONTIGMEM_ENABLE
+
+source "mm/Kconfig"
+
 config ZERO_PAGE_OFFSET
 	hex "Zero page offset"
 	default "0x00001000" if !(SH_MPC1211 || SH_SH03)
diff -puN arch/sh64/Kconfig~A7-make-each-arch-use-mm-Kconfig arch/sh64/Kconfig
--- memhotplug/arch/sh64/Kconfig~A7-make-each-arch-use-mm-Kconfig	2005-03-25 08:08:22.000000000 -0800
+++ memhotplug-dave/arch/sh64/Kconfig	2005-03-25 08:08:23.000000000 -0800
@@ -217,6 +217,8 @@ config PREEMPT
 	bool "Preemptible Kernel (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
 
+source "mm/Kconfig"
+
 endmenu
 
 menu "Bus options (PCI, PCMCIA, EISA, MCA, ISA)"
diff -puN arch/sparc/Kconfig~A7-make-each-arch-use-mm-Kconfig arch/sparc/Kconfig
--- memhotplug/arch/sparc/Kconfig~A7-make-each-arch-use-mm-Kconfig	2005-03-25 08:08:22.000000000 -0800
+++ memhotplug-dave/arch/sparc/Kconfig	2005-03-25 08:08:23.000000000 -0800
@@ -291,6 +291,8 @@ config PRINTER
 	  If you have more than 8 printers, you need to increase the LP_NO
 	  macro in lp.c and the PARPORT_MAX macro in parport.h.
 
+source "mm/Kconfig"
+
 endmenu
 
 source "drivers/base/Kconfig"
diff -puN arch/sparc64/Kconfig~A7-make-each-arch-use-mm-Kconfig arch/sparc64/Kconfig
--- memhotplug/arch/sparc64/Kconfig~A7-make-each-arch-use-mm-Kconfig	2005-03-25 08:08:22.000000000 -0800
+++ memhotplug-dave/arch/sparc64/Kconfig	2005-03-25 08:08:23.000000000 -0800
@@ -462,6 +462,8 @@ config CMDLINE
 
 	  NOTE: This option WILL override the PROM bootargs setting!
 
+source "mm/Kconfig"
+
 endmenu
 
 source "drivers/base/Kconfig"
diff -puN arch/um/Kconfig~A7-make-each-arch-use-mm-Kconfig arch/um/Kconfig
--- memhotplug/arch/um/Kconfig~A7-make-each-arch-use-mm-Kconfig	2005-03-25 08:08:22.000000000 -0800
+++ memhotplug-dave/arch/um/Kconfig	2005-03-25 08:08:23.000000000 -0800
@@ -69,6 +69,7 @@ config MODE_SKAS
 	option will shrink the UML binary slightly.
 
 source "arch/um/Kconfig_arch"
+source "mm/Kconfig"
 
 config LD_SCRIPT_STATIC
 	bool
diff -puN arch/v850/Kconfig~A7-make-each-arch-use-mm-Kconfig arch/v850/Kconfig
--- memhotplug/arch/v850/Kconfig~A7-make-each-arch-use-mm-Kconfig	2005-03-25 08:08:22.000000000 -0800
+++ memhotplug-dave/arch/v850/Kconfig	2005-03-25 08:08:23.000000000 -0800
@@ -218,6 +218,8 @@ menu "Processor type and features"
 	     a lot of RAM, and you need to able to allocate very large
 	     contiguous chunks. If unsure, say N.
 
+source "mm/Kconfig"
+
 endmenu
 
 
diff -puN arch/x86_64/Kconfig~A7-make-each-arch-use-mm-Kconfig arch/x86_64/Kconfig
--- memhotplug/arch/x86_64/Kconfig~A7-make-each-arch-use-mm-Kconfig	2005-03-25 08:08:22.000000000 -0800
+++ memhotplug-dave/arch/x86_64/Kconfig	2005-03-25 08:08:23.000000000 -0800
@@ -282,7 +282,7 @@ config NUMA_EMU
 	  into virtual nodes when booted with "numa=fake=N", where N is the
 	  number of nodes. This is only useful for debugging.
 
-config DISCONTIGMEM
+config ARCH_DISCONTIGMEM_ENABLE
        bool
        depends on NUMA
        default y
@@ -291,6 +291,8 @@ config NUMA
        bool
        default n
 
+source "mm/Kconfig"
+
 config HAVE_DEC_LOCK
 	bool
 	depends on SMP
_
