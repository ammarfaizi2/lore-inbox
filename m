Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbUKHQgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbUKHQgE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 11:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbUKHQgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 11:36:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28866 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261861AbUKHOeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:34:36 -0500
Date: Mon, 8 Nov 2004 14:34:17 GMT
Message-Id: <200411081434.iA8EYHai023500@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 3/20] FRV: Fujitsu FR-V CPU arch implementation part 1
In-Reply-To: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
References: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patches provides part 1 of an architecture implementation
for the Fujitsu FR-V CPU series, configurably as Linux or uClinux.

Signed-Off-By: dhowells@redhat.com
---
diffstat frv-arch_1-2610rc1mm3.diff
 Kconfig              |  496 +++++++++++++++++++++++++++++++++++++++++++++++++++
 Makefile             |  118 ++++++++++++
 boot/Makefile        |   73 +++++++
 kernel/vmlinux.lds.S |  187 +++++++++++++++++++
 4 files changed, 874 insertions(+)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/Makefile linux-2.6.10-rc1-mm3-frv/arch/frv/Makefile
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/Makefile	2004-11-05 14:13:03.323544758 +0000
@@ -0,0 +1,118 @@
+#
+# frv/Makefile
+#
+# This file is included by the global makefile so that you can add your own
+# architecture-specific flags and dependencies. Remember to do have actions
+# for "archclean" and "archdep" for cleaning up and making dependencies for
+# this architecture
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright (c) 2003, 2004 Red Hat Inc.
+# - Written by David Howells <dhowells@redhat.com>
+# - Derived from arch/m68knommu/Makefile,
+#	Copyright (c) 1999,2001  D. Jeff Dionne <jeff@lineo.ca>,
+#	Rt-Control Inc. / Lineo, Inc.
+#
+# Copyright (C) 1998,1999  D. Jeff Dionne <jeff@uclinux.org>,
+#                          Kenneth Albanowski <kjahds@kjahds.com>,
+#
+# Based on arch/m68k/Makefile:
+# Copyright (C) 1994 by Hamish Macdonald
+#
+
+CCSPECS	:= $(shell $(CC) -v 2>&1 | grep "^Reading specs from " | head -1 | cut -c20-)
+CCDIR	:= $(strip $(patsubst %/specs,%,$(CCSPECS)))
+CPUCLASS := fr400
+
+# test for cross compiling
+COMPILE_ARCH = $(shell uname -m)
+
+ifdef CONFIG_MMU
+UTS_SYSNAME = -DUTS_SYSNAME=\"Linux\"
+else
+UTS_SYSNAME = -DUTS_SYSNAME=\"uClinux\"
+endif
+
+ARCHMODFLAGS	+= -G0 -mlong-calls
+
+ifdef CONFIG_GPREL_DATA_8
+CFLAGS		+= -G8
+else
+ifdef CONFIG_GPREL_DATA_4
+CFLAGS		+= -G4
+else
+ifdef CONFIG_GPREL_DATA_NONE
+CFLAGS		+= -G0
+endif
+endif
+endif
+
+#LDFLAGS_vmlinux	:= -Map linkmap.txt
+
+ifdef CONFIG_GC_SECTIONS
+CFLAGS		+= -ffunction-sections -fdata-sections
+LINKFLAGS	+= --gc-sections
+endif
+
+ifndef CONFIG_FRAME_POINTER
+CFLAGS		+= -mno-linked-fp
+endif
+
+ifdef CONFIG_CPU_FR451_COMPILE
+CFLAGS		+= -mcpu=fr450
+AFLAGS		+= -mcpu=fr450
+ASFLAGS		+= -mcpu=fr450
+else
+ifdef CONFIG_CPU_FR551_COMPILE
+CFLAGS		+= -mcpu=fr550
+AFLAGS		+= -mcpu=fr550
+ASFLAGS		+= -mcpu=fr550
+else
+CFLAGS		+= -mcpu=fr400
+AFLAGS		+= -mcpu=fr400
+ASFLAGS		+= -mcpu=fr400
+endif
+endif
+
+# pretend the kernel is going to run on an FR400 with no media-fp unit
+# - reserve CC3 for use with atomic ops
+# - all the extra registers are dealt with only at context switch time
+CFLAGS		+= -mno-fdpic -mgpr-32 -msoft-float -mno-media
+CFLAGS		+= -ffixed-fcc3 -ffixed-cc3 -ffixed-gr15
+AFLAGS		+= -mno-fdpic
+ASFLAGS		+= -mno-fdpic
+
+# make sure the .S files get compiled with debug info
+# and disable optimisations that are unhelpful whilst debugging
+ifdef CONFIG_DEBUG_INFO
+CFLAGS		+= -O1
+AFLAGS		+= -Wa,--gdwarf2
+ASFLAGS		+= -Wa,--gdwarf2
+endif
+
+head-y		:= arch/frv/kernel/head.o arch/frv/kernel/init_task.o
+
+core-y		+= arch/frv/kernel/ arch/frv/mm/
+libs-y		+= arch/frv/lib/
+
+core-$(CONFIG_MB93090_MB00)	+= arch/frv/mb93090-mb00/
+
+all: Image
+
+Image: vmlinux
+	$(Q)$(MAKE) $(build)=arch/frv/boot $@
+
+bootstrap:
+	$(Q)$(MAKEBOOT) bootstrap
+
+archmrproper:
+	$(Q)$(MAKE) -C arch/frv/boot mrproper
+
+archclean:
+	$(Q)$(MAKE) -C arch/frv/boot clean
+
+archdep: scripts/mkdep symlinks
+	$(Q)$(MAKE) -C arch/frv/boot dep
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/boot/Makefile linux-2.6.10-rc1-mm3-frv/arch/frv/boot/Makefile
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/boot/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/boot/Makefile	2004-11-05 14:13:03.064566632 +0000
@@ -0,0 +1,73 @@
+#
+# arch/arm/boot/Makefile
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright (C) 1995-2000 Russell King
+#
+
+SYSTEM	=$(TOPDIR)/$(LINUX)
+
+ZTEXTADDR	 = 0x02080000
+PARAMS_PHYS	 = 0x0207c000
+INITRD_PHYS	 = 0x02180000
+INITRD_VIRT	 = 0x02180000
+
+#
+# If you don't define ZRELADDR above,
+# then it defaults to ZTEXTADDR
+#
+ifeq ($(ZRELADDR),)
+ZRELADDR	= $(ZTEXTADDR)
+endif
+
+export	SYSTEM ZTEXTADDR ZBSSADDR ZRELADDR INITRD_PHYS INITRD_VIRT PARAMS_PHYS
+
+Image: $(obj)/Image
+
+targets: $(obj)/Image
+
+$(obj)/Image: vmlinux FORCE
+	$(OBJCOPY) -O binary -R .note -R .comment -S vmlinux $@
+
+#$(obj)/Image:	$(CONFIGURE) $(SYSTEM)
+#	$(OBJCOPY) -O binary -R .note -R .comment -g -S $(SYSTEM) $@
+
+bzImage: zImage
+
+zImage:	$(CONFIGURE) compressed/$(LINUX)
+	$(OBJCOPY) -O binary -R .note -R .comment -S compressed/$(LINUX) $@
+
+bootpImage: bootp/bootp
+	$(OBJCOPY) -O binary -R .note -R .comment -S bootp/bootp $@
+
+compressed/$(LINUX): $(TOPDIR)/$(LINUX) dep
+	@$(MAKE) -C compressed $(LINUX)
+
+bootp/bootp: zImage initrd
+	@$(MAKE) -C bootp bootp
+
+initrd:
+	@test "$(INITRD_VIRT)" != "" || (echo This architecture does not support INITRD; exit -1)
+	@test "$(INITRD)" != "" || (echo You must specify INITRD; exit -1)
+
+#
+# installation
+#
+install: $(CONFIGURE) Image
+	sh ./install.sh $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION) Image $(TOPDIR)/System.map "$(INSTALL_PATH)"
+
+zinstall: $(CONFIGURE) zImage
+	sh ./install.sh $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION) zImage $(TOPDIR)/System.map "$(INSTALL_PATH)"
+
+#
+# miscellany
+#
+mrproper clean:
+	$(RM) Image zImage bootpImage
+#	@$(MAKE) -C compressed clean
+#	@$(MAKE) -C bootp clean
+
+dep:
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/Kconfig linux-2.6.10-rc1-mm3-frv/arch/frv/Kconfig
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/Kconfig	2004-11-05 14:13:03.065566547 +0000
@@ -0,0 +1,496 @@
+#
+# For a description of the syntax of this configuration file,
+# see Documentation/kbuild/kconfig-language.txt.
+#
+config FRV
+	bool
+	default y
+
+config UID16
+	bool
+	default y
+
+config RWSEM_GENERIC_SPINLOCK
+	bool
+	default y
+
+config RWSEM_XCHGADD_ALGORITHM
+	bool
+
+config GENERIC_FIND_NEXT_BIT
+	bool
+	default y
+
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default n
+
+config GENERIC_HARDIRQS
+	bool
+	default n
+
+mainmenu "Fujitsu FR-V Kernel Configuration"
+
+source "init/Kconfig"
+
+
+menu "Fujitsu FR-V system setup"
+
+config MMU
+	bool "MMU support"
+	help
+	  This options switches on and off support for the FR-V MMU
+	  (effectively switching between vmlinux and uClinux). Not all FR-V
+	  CPUs support this. Currently only the FR451 has a sufficiently
+	  featured MMU.
+
+config FRV_OUTOFLINE_ATOMIC_OPS
+	bool "Out-of-line the FRV atomic operations"
+	default n
+	help
+	  Setting this option causes the FR-V atomic operations to be mostly
+	  implemented out-of-line.
+
+	  See Documentation/fujitsu/frv/atomic-ops.txt for more information.
+
+config HIGHMEM
+	bool "High memory support"
+	depends on MMU
+	default y
+	help
+	  If you wish to use more than 256MB of memory with your MMU based
+	  system, you will need to select this option. The kernel can only see
+	  the memory between 0xC0000000 and 0xD0000000 directly... everything
+	  else must be kmapped.
+
+	  The arch is, however, capable of supporting up to 3GB of SDRAM.
+
+config HIGHPTE
+	bool "Allocate page tables in highmem"
+	depends on HIGHMEM
+	default y
+	help
+	  The VM uses one page of memory for each page table.  For systems
+	  with a lot of RAM, this can be wasteful of precious low memory.
+	  Setting this option will put user-space page tables in high memory.
+
+choice
+	prompt "uClinux kernel load address"
+	depends on !MMU
+	default UCPAGE_OFFSET_C0000000
+	help
+	  This option sets the base address for the uClinux kernel. The kernel
+	  will rearrange the SDRAM layout to start at this address, and move
+	  itself to start there. It must be greater than 0, and it must be
+	  sufficiently less than 0xE0000000 that the SDRAM does not intersect
+	  the I/O region.
+
+	  The base address must also be aligned such that the SDRAM controller
+	  can decode it. For instance, a 512MB SDRAM bank must be 512MB aligned.
+
+config UCPAGE_OFFSET_20000000
+       bool "0x20000000"
+
+config UCPAGE_OFFSET_40000000
+       bool "0x40000000"
+
+config UCPAGE_OFFSET_60000000
+       bool "0x60000000"
+
+config UCPAGE_OFFSET_80000000
+       bool "0x80000000"
+
+config UCPAGE_OFFSET_A0000000
+       bool "0xA0000000"
+
+config UCPAGE_OFFSET_C0000000
+       bool "0xC0000000 (Recommended)"
+
+endchoice
+
+config PROTECT_KERNEL
+	bool "Protect core kernel against userspace"
+	depends on !MMU
+	default y
+	help
+	  Selecting this option causes the uClinux kernel to change the
+	  permittivity of DAMPR register covering the core kernel image to
+	  prevent userspace accessing the underlying memory directly.
+
+choice
+	prompt "CPU Caching mode"
+	default FRV_DEFL_CACHE_WBACK
+	help
+	  This option determines the default caching mode for the kernel.
+
+	  Write-Back caching mode involves the all reads and writes causing
+	  the affected cacheline to be read into the cache first before being
+	  operated upon. Memory is not then updated by a write until the cache
+	  is filled and a cacheline needs to be displaced from the cache to
+	  make room. Only at that point is it written back.
+
+	  Write-Behind caching is similar to Write-Back caching, except that a
+	  write won't fetch a cacheline into the cache if there isn't already
+	  one there; it will write directly to memory instead.
+
+	  Write-Through caching only fetches cachelines from memory on a
+	  read. Writes always get written directly to memory. If the affected
+	  cacheline is also in cache, it will be updated too.
+
+	  The final option is to turn of caching entirely.
+
+	  Note that not all CPUs support Write-Behind caching. If the CPU on
+	  which the kernel is running doesn't, it'll fall back to Write-Back
+	  caching.
+
+config FRV_DEFL_CACHE_WBACK
+	bool "Write-Back"
+
+config FRV_DEFL_CACHE_WBEHIND
+	bool "Write-Behind"
+
+config FRV_DEFL_CACHE_WTHRU
+	bool "Write-Through"
+
+config FRV_DEFL_CACHE_DISABLED
+	bool "Disabled"
+
+endchoice
+
+menu "CPU core support"
+
+config CPU_FR401
+	bool "Include FR401 core support"
+	depends on !MMU
+	default y
+	help
+	  This enables support for the FR401, FR401A and FR403 CPUs
+
+config CPU_FR405
+	bool "Include FR405 core support"
+	depends on !MMU
+	default y
+	help
+	  This enables support for the FR405 CPU
+
+config CPU_FR451
+	bool "Include FR451 core support"
+	default y
+	help
+	  This enables support for the FR451 CPU
+
+config CPU_FR451_COMPILE
+	bool "Specifically compile for FR451 core"
+	depends on CPU_FR451 && !CPU_FR401 && !CPU_FR405 && !CPU_FR551
+	default y
+	help
+	  This causes appropriate flags to be passed to the compiler to
+	  optimise for the FR451 CPU
+
+config CPU_FR551
+	bool "Include FR551 core support"
+	depends on !MMU
+	default y
+	help
+	  This enables support for the FR555 CPU
+
+config CPU_FR551_COMPILE
+	bool "Specifically compile for FR551 core"
+	depends on CPU_FR551 && !CPU_FR401 && !CPU_FR405 && !CPU_FR451
+	default y
+	help
+	  This causes appropriate flags to be passed to the compiler to
+	  optimise for the FR555 CPU
+
+endmenu
+
+choice
+	prompt "System support"
+	default MB93091_VDK
+
+config MB93091_VDK
+	bool "MB93091 CPU board with or without motherboard"
+
+config MB93093_PDK
+	bool "MB93093 PDK unit"
+
+endchoice
+
+if MB93091_VDK
+choice
+	prompt "Motherboard support"
+	default MB93090_MB00
+
+config MB93090_MB00
+	bool "Use the MB93090-MB00 motherboard"
+	help
+	  Select this option if the MB93091 CPU board is going to be used with
+	  a MB93090-MB00 VDK motherboard
+
+config MB93091_NO_MB
+	bool "Use standalone"
+	help
+	  Select this option if the MB93091 CPU board is going to be used
+	  without a motherboard
+
+endchoice
+endif
+
+choice
+	prompt "GP-Relative data support"
+	default GPREL_DATA_8
+	help
+	  This option controls what data, if any, should be placed in the GP
+	  relative data sections. Using this means that the compiler can
+	  generate accesses to the data using GR16-relative addressing which
+	  is faster than absolute instructions and saves space (2 instructions
+	  per access).
+
+	  However, the GPREL region is limited in size because the immediate
+	  value used in the load and store instructions is limited to a 12-bit
+	  signed number.
+
+	  So if the linker starts complaining that accesses to GPREL data are
+	  out of range, try changing this option from the default.
+
+	  Note that modules will always be compiled with this feature disabled
+	  as the module data will not be in range of the GP base address.
+
+config GPREL_DATA_8
+	bool "Put data objects of up to 8 bytes into GP-REL"
+
+config GPREL_DATA_4
+	bool "Put data objects of up to 4 bytes into GP-REL"
+
+config GPREL_DATA_NONE
+	bool "Don't use GP-REL"
+
+endchoice
+
+config PCI
+	bool "Use PCI"
+	depends on MB93090_MB00
+	default y
+	help
+	  Some FR-V systems (such as the MB93090-MB00 VDK) have PCI
+	  onboard. If you have one of these boards and you wish to use the PCI
+	  facilities, say Y here.
+
+	  The PCI-HOWTO, available from
+	  <http://www.tldp.org/docs.html#howto>, contains valuable
+	  information about which PCI hardware does work under Linux and which
+	  doesn't.
+
+config RESERVE_DMA_COHERENT
+	bool "Reserve DMA coherent memory"
+	depends on PCI && !MMU
+	default y
+	help
+	  Many PCI drivers require access to uncached memory for DMA device
+	  communications (such as is done with some Ethernet buffer rings). If
+	  a fully featured MMU is available, this can be done through page
+	  table settings, but if not, a region has to be set aside and marked
+	  with a special DAMPR register.
+
+	  Setting this option causes uClinux to set aside a portion of the
+	  available memory for use in this manner. The memory will then be
+	  unavailable for normal kernel use.
+
+source "drivers/pci/Kconfig"
+
+config PCMCIA
+	tristate "Use PCMCIA"
+	help
+	  Say Y here if you want to attach PCMCIA- or PC-cards to your FR-V
+	  board.  These are credit-card size devices such as network cards,
+	  modems or hard drives often used with laptops computers.  There are
+	  actually two varieties of these cards: the older 16 bit PCMCIA cards
+	  and the newer 32 bit CardBus cards.  If you want to use CardBus
+	  cards, you need to say Y here and also to "CardBus support" below.
+
+	  To use your PC-cards, you will need supporting software from David
+	  Hinds pcmcia-cs package (see the file <file:Documentation/Changes>
+	  for location).  Please also read the PCMCIA-HOWTO, available from
+	  <http://www.tldp.org/docs.html#howto>.
+
+	  To compile this driver as modules, choose M here: the
+	  modules will be called pcmcia_core and ds.
+
+#config MATH_EMULATION
+#	bool "Math emulation support (EXPERIMENTAL)"
+#	depends on EXPERIMENTAL
+#	help
+#	  At some point in the future, this will cause floating-point math
+#	  instructions to be emulated by the kernel on machines that lack a
+#	  floating-point math coprocessor.  Thrill-seekers and chronically
+#	  sleep-deprived psychotic hacker types can say Y now, everyone else
+#	  should probably wait a while.
+
+menu "Power management options"
+source kernel/power/Kconfig
+endmenu
+
+endmenu
+
+
+menu "Executable formats"
+
+source "fs/Kconfig.binfmt"
+
+endmenu
+
+source "drivers/Kconfig"
+
+source "fs/Kconfig"
+
+menu "Kernel hacking"
+
+config DEBUG_KERNEL
+	bool "Kernel debugging"
+	help
+	  Say Y here if you are developing drivers or trying to debug and
+	  identify kernel problems.
+
+config EARLY_PRINTK
+	bool "Early printk"
+	depends on EMBEDDED && DEBUG_KERNEL
+	default n
+	help
+	  Write kernel log output directly into the VGA buffer or to a serial
+	  port.
+
+	  This is useful for kernel debugging when your machine crashes very
+	  early before the console code is initialized. For normal operation
+	  it is not recommended because it looks ugly and doesn't cooperate
+	  with klogd/syslogd or the X server. You should normally N here,
+	  unless you want to debug such a crash.
+
+config DEBUG_STACKOVERFLOW
+	bool "Check for stack overflows"
+	depends on DEBUG_KERNEL
+
+config DEBUG_SLAB
+	bool "Debug memory allocations"
+	depends on DEBUG_KERNEL
+	help
+	  Say Y here to have the kernel do limited verification on memory
+	  allocation as well as poisoning memory on free to catch use of freed
+	  memory.
+
+config MAGIC_SYSRQ
+	bool "Magic SysRq key"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, you will have some control over the system even
+	  if the system crashes for example during kernel debugging (e.g., you
+	  will be able to flush the buffer cache to disk, reboot the system
+	  immediately or dump some status information). This is accomplished
+	  by pressing various keys while holding SysRq (Alt+PrintScreen). It
+	  also works on a serial console (on PC hardware at least), if you
+	  send a BREAK and then within 5 seconds a command keypress. The
+	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
+	  unless you really know what this hack does.
+
+config DEBUG_SPINLOCK
+	bool "Spinlock debugging"
+	depends on DEBUG_KERNEL
+	help
+	  Say Y here and build SMP to catch missing spinlock initialization
+	  and certain other kinds of spinlock errors commonly made.  This is
+	  best used in conjunction with the NMI watchdog so that spinlock
+	  deadlocks are also debuggable.
+	  
+config DEBUG_SPINLOCK_SLEEP
+	bool "Sleep-inside-spinlock checking"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, various routines which may sleep will become very
+	  noisy if they are called with a spinlock held.	
+
+config DEBUG_PAGEALLOC
+	bool "Page alloc debugging"
+	depends on DEBUG_KERNEL
+	help
+	  Unmap pages from the kernel linear mapping after free_pages().
+	  This results in a large slowdown, but helps to find certain types
+	  of memory corruptions.
+
+config DEBUG_HIGHMEM
+	bool "Highmem debugging"
+	depends on DEBUG_KERNEL && HIGHMEM
+	help
+	  This options enables addition error checking for high memory systems.
+	  Disable for production systems.
+
+config DEBUG_INFO
+	bool "Compile the kernel with debug info"
+	depends on DEBUG_KERNEL
+	help
+          If you say Y here the resulting kernel image will include
+	  debugging info resulting in a larger kernel image.
+	  Say Y here only if you plan to use gdb to debug the kernel.
+	  If you don't debug the kernel, you can say N.
+
+config DEBUG_BUGVERBOSE
+	bool "Verbose BUG() reporting"
+	depends on DEBUG_KERNEL
+
+config FRAME_POINTER
+	bool "Compile the kernel with frame pointers"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here the resulting kernel image will be slightly larger
+	  and slower, but it will give very useful debugging information.
+	  If you don't debug the kernel, you can say N, but we may not be able
+	  to solve problems without frame pointers.
+
+config GDBSTUB
+	bool "Remote GDB kernel debugging"
+	depends on DEBUG_KERNEL
+	select DEBUG_INFO
+	select FRAME_POINTER
+	help
+	  If you say Y here, it will be possible to remotely debug the kernel
+	  using gdb. This enlarges your kernel ELF image disk size by several
+	  megabytes and requires a machine with more than 16 MB, better 32 MB
+	  RAM to avoid excessive linking time. This is only useful for kernel
+	  hackers. If unsure, say N.
+
+choice
+	prompt "GDB stub port"
+	default GDBSTUB_UART1
+	depends on GDBSTUB
+	help
+	  Select the on-CPU port used for GDB-stub
+
+config GDBSTUB_UART0
+	bool "/dev/ttyS0"
+
+config GDBSTUB_UART1
+	bool "/dev/ttyS1"
+
+endchoice
+
+config GDBSTUB_IMMEDIATE
+	bool "Break into GDB stub immediately"
+	depends on GDBSTUB
+	help
+	  If you say Y here, GDB stub will break into the program as soon as
+	  possible, leaving the program counter at the beginning of
+	  start_kernel() in init/main.c.
+
+config GDB_CONSOLE
+	bool "Console output to GDB"
+	depends on KGDB
+	help
+	  If you are using GDB for remote debugging over a serial port and
+	  would like kernel messages to be formatted into GDB $O packets so
+	  that GDB prints them as program output, say 'Y'.
+
+endmenu
+
+source "security/Kconfig"
+
+source "crypto/Kconfig"
+
+source "lib/Kconfig"
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/vmlinux.lds.S linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/vmlinux.lds.S
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/vmlinux.lds.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/vmlinux.lds.S	2004-11-05 14:13:03.258550247 +0000
@@ -0,0 +1,187 @@
+/* ld script to make FRV Linux kernel -*- c -*-
+ * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
+ */
+OUTPUT_FORMAT("elf32-frv", "elf32-frv", "elf32-frv")
+OUTPUT_ARCH(frv)
+ENTRY(_start)
+
+#include <asm-generic/vmlinux.lds.h>
+#include <asm/processor.h>
+#include <asm/page.h>
+#include <asm/cache.h>
+#include <asm/thread_info.h>
+
+jiffies = jiffies_64 + 4;
+
+__page_offset = 0xc0000000;		/* start of area covered by struct pages */
+__kernel_image_start = __page_offset;	/* address at which kernel image resides */
+
+SECTIONS
+{
+  . = __kernel_image_start;
+
+  /* discardable initialisation code and data */
+  . = ALIGN(PAGE_SIZE);			/* Init code and data */
+  __init_begin = .;
+
+  _sinittext = .;
+  .init.text : {
+	*(.text.head)
+#ifndef CONFIG_DEBUG_INFO
+	*(.init.text)
+	*(.exit.text)
+	*(.exit.data)
+	*(.exitcall.exit)
+#endif
+  }
+  _einittext = .;
+  .init.data : { *(.init.data) }
+
+  . = ALIGN(8);
+  __setup_start = .;
+  .setup.init : { KEEP(*(.init.setup)) }
+  __setup_end = .;
+
+  __initcall_start = .;
+  .initcall.init : {
+	*(.initcall1.init) 
+	*(.initcall2.init) 
+	*(.initcall3.init) 
+	*(.initcall4.init) 
+	*(.initcall5.init) 
+	*(.initcall6.init) 
+	*(.initcall7.init)
+  }
+  __initcall_end = .;
+  __con_initcall_start = .;
+  .con_initcall.init : { *(.con_initcall.init) }
+  __con_initcall_end = .;
+  SECURITY_INIT
+  . = ALIGN(4);
+  __alt_instructions = .;
+  .altinstructions : { *(.altinstructions) } 
+  __alt_instructions_end = .; 
+ .altinstr_replacement : { *(.altinstr_replacement) } 
+
+  __per_cpu_start = .;
+  .data.percpu  : { *(.data.percpu) }
+  __per_cpu_end = .;
+
+  . = ALIGN(4096);
+  __initramfs_start = .;
+  .init.ramfs : { *(.init.ramfs) }
+  __initramfs_end = .;
+
+  . = ALIGN(THREAD_SIZE);
+  __init_end = .;
+
+  /* put sections together that have massive alignment issues */
+  . = ALIGN(THREAD_SIZE);
+  .data.init_task : {
+	  /* init task record & stack */
+	  *(.data.init_task)
+  }
+
+  .trap : {
+	/* trap table management - read entry-table.S before modifying */
+	. = ALIGN(8192);
+	__trap_tables = .;
+	*(.trap.user)	
+	*(.trap.kernel)	
+	. = ALIGN(4096);
+	*(.trap.break)	
+  }
+
+  . = ALIGN(4096);
+  .data.page_aligned : { *(.data.idt) }
+
+  . = ALIGN(L1_CACHE_BYTES);
+  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+
+  /* Text and read-only data */
+  . = ALIGN(4);
+  _text = .;
+  _stext = .;
+  .text : {
+	*(
+		.text.start .text .text.*
+#ifdef CONFIG_DEBUG_INFO
+	.init.text
+	.exit.text
+	.exitcall.exit
+#endif
+	)
+	SCHED_TEXT
+	*(.fixup)
+	*(.gnu.warning)
+	*(.exitcall.exit)
+	} = 0x9090
+
+  _etext = .;			/* End of text section */
+
+  RODATA
+
+  .rodata : {
+	*(.trap.vector)
+
+	/* this clause must not be modified - the ordering and adjacency are imperative */
+	__trap_fixup_tables = .;
+	*(.trap.fixup.user .trap.fixup.kernel)
+
+	}
+
+  . = ALIGN(8);		/* Exception table */
+  __start___ex_table = .;
+  __ex_table : { KEEP(*(__ex_table)) }
+  __stop___ex_table = .;
+
+  _sdata = .;
+  .data : {			/* Data */
+	*(.data .data.*)
+	*(.exit.data)
+	CONSTRUCTORS
+	}
+
+  _edata = .;			/* End of data section */
+
+  /* GP section */
+  . = ALIGN(L1_CACHE_BYTES);
+  _gp = . + 2048;
+  PROVIDE (gp = _gp);
+
+  .sdata : { *(.sdata .sdata.*) }
+
+  /* BSS */
+  . = ALIGN(L1_CACHE_BYTES);
+  __bss_start = .;
+
+  .sbss		: { *(.sbss .sbss.*) }
+  .bss		: { *(.bss .bss.*) }
+  .bss.stack	: { *(.bss) }
+
+  __bss_stop = .; 
+  _end = . ;
+  . = ALIGN(PAGE_SIZE);
+  __kernel_image_end = .;
+
+  /* Stabs debugging sections.  */
+  .stab 0 : { *(.stab) }
+  .stabstr 0 : { *(.stabstr) }
+  .stab.excl 0 : { *(.stab.excl) }
+  .stab.exclstr 0 : { *(.stab.exclstr) }
+  .stab.index 0 : { *(.stab.index) }
+  .stab.indexstr 0 : { *(.stab.indexstr) }
+
+  .debug_line		0 : { *(.debug_line) }
+  .debug_info		0 : { *(.debug_info) }
+  .debug_abbrev		0 : { *(.debug_abbrev) }
+  .debug_aranges	0 : { *(.debug_aranges) }
+  .debug_frame		0 : { *(.debug_frame) }
+  .debug_pubnames	0 : { *(.debug_pubnames) }
+  .debug_str		0 : { *(.debug_str) }
+  .debug_ranges		0 : { *(.debug_ranges) }
+
+  .comment 0 : { *(.comment) }
+}
+
+__kernel_image_size_no_bss = __bss_start - __kernel_image_start;
