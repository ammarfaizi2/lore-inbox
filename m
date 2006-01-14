Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbWANW4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWANW4n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 17:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWANW4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 17:56:43 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:6537 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1751470AbWANW4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 17:56:41 -0500
Date: Sun, 15 Jan 2006 00:56:39 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] sh: Move CPU subtype configuration to its own Kconfig.
Message-ID: <20060114225639.GJ4045@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060114225018.GB4045@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060114225018.GB4045@linux-sh.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the CPU subtype options are cluttering up arch/sh/Kconfig
somewhat. Given that, this moves all of that in to its own
arch/sh/mm/Kconfig. Things like cache configuration are also moved to
this new location.

This also adds support for strict CPU tuning on newer cores, which
requires the addition of as-option.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 Makefile              |    7 
 arch/sh/Kconfig       |  541 +++++++++++++++++++-------------------------------
 arch/sh/Kconfig.debug |    2 
 arch/sh/Makefile      |   60 +++--
 arch/sh/mm/Kconfig    |  233 +++++++++++++++++++++
 5 files changed, 491 insertions(+), 352 deletions(-)

diff -urN -X exclude linux-2.6.15/Makefile sh-2.6.15/Makefile
--- linux-2.6.15/Makefile	2006-01-04 14:19:56.000000000 +0200
+++ sh-2.6.15/Makefile	2006-01-04 14:25:43.000000000 +0200
@@ -280,6 +280,13 @@
 # cc support functions to be used (only) in arch/$(ARCH)/Makefile
 # See documentation in Documentation/kbuild/makefiles.txt
 
+# as-option
+# Usage: cflags-y += $(call as-option, -Wa$(comma)-isa=foo,)
+
+as-option = $(shell if $(CC) $(CFLAGS) $(1) -Wa,-Z -c -o /dev/null \
+	     -xassembler /dev/null > /dev/null 2>&1; then echo "$(1)"; \
+	     else echo "$(2)"; fi ;)
+
 # cc-option
 # Usage: cflags-y += $(call cc-option, -march=winchip-c6, -march=i586)
 
diff -urN -X exclude linux-2.6.15/arch/sh/Kconfig sh-2.6.15/arch/sh/Kconfig
--- linux-2.6.15/arch/sh/Kconfig	2006-01-04 14:19:57.000000000 +0200
+++ sh-2.6.15/arch/sh/Kconfig	2006-01-07 22:20:41.249427831 +0200
@@ -37,9 +37,11 @@
 	bool
 	default y
 
+config GENERIC_IOMAP
+	bool
+
 config ARCH_MAY_HAVE_PC_FDC
 	bool
-	default y
 
 source "init/Kconfig"
 
@@ -57,24 +59,28 @@
 
 config SH_7751_SOLUTION_ENGINE
 	bool "SolutionEngine7751"
+	select CPU_SUBTYPE_SH7751
 	help
 	  Select 7751 SolutionEngine if configuring for a Hitachi SH7751
 	  evaluation board.
 
 config SH_7300_SOLUTION_ENGINE
 	bool "SolutionEngine7300"
+	select CPU_SUBTYPE_SH7300
 	help
 	  Select 7300 SolutionEngine if configuring for a Hitachi SH7300(SH-Mobile V)
 	  evaluation board.
 
 config SH_73180_SOLUTION_ENGINE
        bool "SolutionEngine73180"
+       select CPU_SUBTYPE_SH73180
        help
          Select 73180 SolutionEngine if configuring for a Hitachi SH73180(SH-Mobile 3)
          evaluation board.
 
 config SH_7751_SYSTEMH
 	bool "SystemH7751R"
+	select CPU_SUBTYPE_SH7751R
 	help
 	  Select SystemH if you are configuring for a Renesas SystemH
 	  7751R evaluation board.
@@ -85,27 +91,13 @@
 config SH_STB1_OVERDRIVE
 	bool "STB1_Overdrive"
 
-config SH_HP620
-	bool "HP620"
+config SH_HP6XX
+	bool "HP6XX"
 	help
-	  Select HP620 if configuring for a HP jornada HP620.
+	  Select HP6XX if configuring for a HP jornada HP6xx.
 	  More information (hardware only) at
 	  <http://www.hp.com/jornada/>.
 
-config SH_HP680
-	bool "HP680"
-	help
-	  Select HP680 if configuring for a HP Jornada HP680.
-	  More information (hardware only) at
-	  <http://www.hp.com/jornada/products/680/>.
-
-config SH_HP690
-	bool "HP690"
-	help
-	  Select HP690 if configuring for a HP Jornada HP690.
-	  More information (hardware only)
-	  at <http://www.hp.com/jornada/products/680/>.
-
 config SH_CQREEK
 	bool "CqREEK"
 	help
@@ -127,11 +119,13 @@
 
 config SH_SATURN
 	bool "Saturn"
+	select CPU_SUBTYPE_SH7604
 	help
 	  Select Saturn if configuring for a SEGA Saturn.
 
 config SH_DREAMCAST
 	bool "Dreamcast"
+	select CPU_SUBTYPE_SH7091
 	help
 	  Select Dreamcast if configuring for a SEGA Dreamcast.
 	  More information at
@@ -146,6 +140,7 @@
 
 config SH_SH2000
 	bool "SH2000"
+	select CPU_SUBTYPE_SH7709
 	help
 	  SH-2000 is a single-board computer based around SH7709A chip
 	  intended for embedded applications.
@@ -157,20 +152,22 @@
 	bool "ADX"
 
 config SH_MPC1211
-	bool "MPC1211"
+	bool "Interface MPC1211"
+	help
+	  CTP/PCI-SH02 is a CPU module computer that is produced
+	  by Interface Corporation.
+	  More information at <http://www.interface.co.jp>
 
 config SH_SH03
-	bool "SH03"
+	bool "Interface CTP/PCI-SH03"
 	help
-	  CTP/PCI-SH03 is a CPU module computer that produced
+	  CTP/PCI-SH03 is a CPU module computer that is produced
 	  by Interface Corporation.
-	  It is compact and excellent in durability.
-	  It will play an active part in your factory or laboratory
-	  as a FA computer.
 	  More information at <http://www.interface.co.jp>
 
 config SH_SECUREEDGE5410
 	bool "SecureEdge5410"
+	select CPU_SUBTYPE_SH7751R
 	help
 	  Select SecureEdge5410 if configuring for a SnapGear SH board.
 	  This includes both the OEM SecureEdge products as well as the
@@ -178,25 +175,49 @@
 
 config SH_HS7751RVOIP
 	bool "HS7751RVOIP"
+	select CPU_SUBTYPE_SH7751R
 	help
 	  Select HS7751RVOIP if configuring for a Renesas Technology
 	  Sales VoIP board.
 
 config SH_RTS7751R2D
 	bool "RTS7751R2D"
+	select CPU_SUBTYPE_SH7751R
 	help
 	  Select RTS7751R2D if configuring for a Renesas Technology
 	  Sales SH-Graphics board.
 
+config SH_R7780RP
+	bool "R7780RP-1"
+	select CPU_SUBTYPE_SH7780
+	help
+	  Select R7780RP-1 if configuring for a Renesas Solutions
+	  HIGHLANDER board.
+
 config SH_EDOSK7705
 	bool "EDOSK7705"
+	select CPU_SUBTYPE_SH7705
 
 config SH_SH4202_MICRODEV
 	bool "SH4-202 MicroDev"
+	select CPU_SUBTYPE_SH4_202
 	help
 	  Select SH4-202 MicroDev if configuring for a SuperH MicroDev board
 	  with an SH4-202 CPU.
 
+config SH_LANDISK
+	bool "LANDISK"
+	select CPU_SUBTYPE_SH7751R
+	help
+	  I-O DATA DEVICE, INC. "LANDISK Series" support.
+
+config SH_TITAN
+	bool "TITAN"
+	select CPU_SUBTYPE_SH7751R
+	help
+	  Select Titan if you are configuring for a Nimble Microsystems
+	  NetEngine NP51R.
+
 config SH_UNKNOWN
 	bool "BareCPU"
 	help
@@ -211,168 +232,27 @@
 
 endchoice
 
-choice
-	prompt "Processor family"
-	default CPU_SH4
-	help
-	  This option determines the CPU family to compile for. Supported
-	  targets are SH-2, SH-3, and SH-4. These options are independent of
-	  CPU functionality. As such, SH-DSP users will still want to select
-	  their respective processor family in addition to the DSP support
-	  option.
-
-config CPU_SH2
-	bool "SH-2"
-	select SH_WRITETHROUGH
-
-config CPU_SH3
-	bool "SH-3"
-
-config CPU_SH4
-	bool "SH-4"
-
-endchoice
-
-choice
-	prompt "Processor subtype"
-
-config CPU_SUBTYPE_SH7604
-	bool "SH7604"
-	depends on CPU_SH2
-	help
-	  Select SH7604 if you have SH7604
-
-config CPU_SUBTYPE_SH7300
-	bool "SH7300"
-	depends on CPU_SH3
-
-config CPU_SUBTYPE_SH7705
-	bool "SH7705"
-	depends on CPU_SH3
-
-config CPU_SUBTYPE_SH7707
-	bool "SH7707"
-	depends on CPU_SH3
-	help
-	  Select SH7707 if you have a  60 Mhz SH-3 HD6417707 CPU.
-
-config CPU_SUBTYPE_SH7708
-	bool "SH7708"
-	depends on CPU_SH3
-	help
-	  Select SH7708 if you have a  60 Mhz SH-3 HD6417708S or
-	  if you have a 100 Mhz SH-3 HD6417708R CPU.
-
-config CPU_SUBTYPE_SH7709
-	bool "SH7709"
-	depends on CPU_SH3
-	help
-	  Select SH7709 if you have a  80 Mhz SH-3 HD6417709 CPU.
-
-config CPU_SUBTYPE_SH7750
-	bool "SH7750"
-	depends on CPU_SH4
-	help
-	  Select SH7750 if you have a 200 Mhz SH-4 HD6417750 CPU.
-
-config CPU_SUBTYPE_SH7751
-	bool "SH7751/SH7751R"
-	depends on CPU_SH4
-	help
-	  Select SH7751 if you have a 166 Mhz SH-4 HD6417751 CPU,
-	  or if you have a HD6417751R CPU.
-
-config CPU_SUBTYPE_SH7760
-	bool "SH7760"
-	depends on CPU_SH4
-
-config CPU_SUBTYPE_SH73180
-       bool "SH73180"
-       depends on CPU_SH4
-
-config CPU_SUBTYPE_ST40STB1
-       bool "ST40STB1 / ST40RA"
-       depends on CPU_SH4
-       help
-         Select ST40STB1 if you have a ST40RA CPU.
-         This was previously called the ST40STB1, hence the option name.
-
-config CPU_SUBTYPE_ST40GX1
-       bool "ST40GX1"
-       depends on CPU_SH4
-       help
-         Select ST40GX1 if you have a ST40GX1 CPU.
-
-config CPU_SUBTYPE_SH4_202
-	bool "SH4-202"
-	depends on CPU_SH4
-
-endchoice
-
-config SH7705_CACHE_32KB
-    bool "Enable 32KB cache size for SH7705"
-    depends on CPU_SUBTYPE_SH7705
-    default y
-
-config MMU
-        bool "Support for memory management hardware"
-	depends on !CPU_SH2
-	default y
-	help
-	  Early SH processors (such as the SH7604) lack an MMU. In order to
-	  boot on these systems, this option must not be set.
-
-	  On other systems (such as the SH-3 and 4) where an MMU exists,
-	  turning this off will boot the kernel on these machines with the
-	  MMU implicitly switched off.
-
-choice
-	prompt "HugeTLB page size"
-	depends on HUGETLB_PAGE && CPU_SH4 && MMU
-	default HUGETLB_PAGE_SIZE_64K
-
-config HUGETLB_PAGE_SIZE_64K
-	bool "64K"
-
-config HUGETLB_PAGE_SIZE_1MB
-	bool "1MB"
+source "arch/sh/mm/Kconfig"
 
-endchoice
-
-config CMDLINE_BOOL
-	bool "Default bootloader kernel arguments"
-
-config CMDLINE
-	string "Initial kernel command string"
-	depends on CMDLINE_BOOL
-	default "console=ttySC1,115200"
-
-# Platform-specific memory start and size definitions
 config MEMORY_START
-	hex "Physical memory start address" if !MEMORY_SET || MEMORY_OVERRIDE
-	default "0x08000000" if !MEMORY_SET || MEMORY_OVERRIDE || !MEMORY_OVERRIDE && SH_ADX || SH_MPC1211 || SH_SH03 || SH_SECUREEDGE5410 || SH_SH4202_MICRODEV
-	default "0x0c000000" if !MEMORY_OVERRIDE && (SH_DREAMCAST || SH_HP600 || SH_BIGSUR || SH_SH2000 || SH_73180_SOLUTION_ENGINE || SH_7300_SOLUTION_ENGINE || SH_7751_SOLUTION_ENGINE || SH_SOLUTION_ENGINE || SH_HS7751RVOIP || SH_RTS7751R2D || SH_EDOSK7705)
+	hex "Physical memory start address"
+	default "0x08000000"
 	---help---
 	  Computers built with Hitachi SuperH processors always
 	  map the ROM starting at address zero.  But the processor
 	  does not specify the range that RAM takes.
 
 	  The physical memory (RAM) start address will be automatically
-	  set to 08000000, unless you selected one of the following
-	  processor types: SolutionEngine, Overdrive, HP620, HP680, HP690,
-	  in which case the start address will be set to 0c000000.
+	  set to 08000000. Other platforms, such as the Solution Engine
+	  boards typically map RAM at 0C000000.
 
-	  Tweak this only when porting to a new machine which is not already
-	  known by the config system.  Changing it from the known correct
+	  Tweak this only when porting to a new machine which does not
+	  already have a defconfig. Changing it from the known correct
 	  value on any of the known systems will only lead to disaster.
 
 config MEMORY_SIZE
-	hex "Physical memory size" if !MEMORY_SET || MEMORY_OVERRIDE
-	default "0x00400000" if !MEMORY_SET || MEMORY_OVERRIDE || !MEMORY_OVERRIDE && SH_ADX || !MEMORY_OVERRIDE && (SH_HP600 || SH_BIGSUR || SH_SH2000)
-	default "0x01000000" if !MEMORY_OVERRIDE && SH_DREAMCAST || SH_SECUREEDGE5410 || SH_EDOSK7705
-        default "0x02000000" if !MEMORY_OVERRIDE && (SH_73180_SOLUTION_ENGINE || SH_SOLUTION_ENGINE)
-        default "0x04000000" if !MEMORY_OVERRIDE && (SH_7300_SOLUTION_ENGINE || SH_7751_SOLUTION_ENGINE || SH_HS7751RVOIP || SH_RTS7751R2D || SH_SH4202_MICRODEV)
-	default "0x08000000" if SH_MPC1211 || SH_SH03
+	hex "Physical memory size"
+	default "0x00400000"
 	help
 	  This sets the default memory size assumed by your SH kernel. It can
 	  be overridden as normal by the 'mem=' argument on the kernel command
@@ -380,21 +260,6 @@
 	  as 0x00400000 which was the default value before this became
 	  configurable.
 
-config MEMORY_SET
-	bool
-	depends on !MEMORY_OVERRIDE && (SH_MPC1211 || SH_SH03 || SH_ADX || SH_DREAMCAST || SH_HP600 || SH_BIGSUR || SH_SH2000 || SH_7751_SOLUTION_ENGINE || SH_SOLUTION_ENGINE || SH_SECUREEDGE5410 || SH_HS7751RVOIP || SH_RTS7751R2D || SH_SH4202_MICRODEV || SH_EDOSK7705)
-	default y
-	help
-	  This is an option about which you will never be asked a question.
-	  Therefore, I conclude that you do not exist - go away.
-
-	  There is a grue here.
-
-# If none of the above have set memory start/size, ask the user.
-config MEMORY_OVERRIDE
-	bool "Override default load address and memory size"
-
-# XXX: break these out into the board-specific configs below
 config CF_ENABLER
 	bool "Compact Flash Enabler support"
 	depends on SH_ADX || SH_SOLUTION_ENGINE || SH_UNKNOWN || SH_CAT68701 || SH_SH03
@@ -438,10 +303,21 @@
 	default "0xb8000000" if CF_AREA6
 	default "0xb4000000" if CF_AREA5
 
+menu "Processor features"
+
+config CPU_LITTLE_ENDIAN
+	bool "Little Endian"
+	help
+	  Some SuperH machines can be configured for either little or big
+	  endian byte order. These modes require different kernels. Say Y if
+	  your machine is little endian, N if it's a big endian machine.
+
 # The SH7750 RTC module is disabled in the Dreamcast
 config SH_RTC
 	bool
-	depends on !SH_DREAMCAST && !SH_SATURN && !SH_7300_SOLUTION_ENGINE && !SH_73180_SOLUTION_ENGINE
+	depends on !SH_DREAMCAST && !SH_SATURN && !SH_7300_SOLUTION_ENGINE && \
+		   !SH_73180_SOLUTION_ENGINE && !SH_LANDISK && \
+		   !SH_R7780RP
 	default y
 	help
 	  Selecting this option will allow the Linux kernel to emulate
@@ -455,7 +331,7 @@
 	default y
 	help
 	  Selecting this option will enable support for SH processors that
-	  have FPU units (ie, SH77xx).
+	  have FPU units (ie, SH77xx).
 
 	  This option must be set in order to enable the FPU.
 
@@ -480,104 +356,131 @@
 
 	  If unsure, say N.
 
-config SH_HP600
+config SH_STORE_QUEUES
+	bool "Support for Store Queues"
+	depends on CPU_SH4
+	help
+	  Selecting this option will enable an in-kernel API for manipulating
+	  the store queues integrated in the SH-4 processors.
+
+config CPU_HAS_INTEVT
 	bool
-	depends on SH_HP620 || SH_HP680 || SH_HP690
-	default y
 
-config CPU_SUBTYPE_ST40
-       bool
-       depends on CPU_SUBTYPE_ST40STB1 || CPU_SUBTYPE_ST40GX1
-       default y
+config CPU_HAS_PINT_IRQ
+	bool
 
-source "mm/Kconfig"
+config CPU_HAS_INTC2_IRQ
+	bool
 
-config ZERO_PAGE_OFFSET
-	hex "Zero page offset"
-	default "0x00001000" if !(SH_MPC1211 || SH_SH03)
-	default "0x00004000" if SH_MPC1211 || SH_SH03
+config CPU_HAS_SR_RB
+	bool "CPU has SR.RB"
+	depends on CPU_SH3 || CPU_SH4
+	default y
 	help
-	  This sets the default offset of zero page.
+	  This will enable the use of SR.RB register bank usage. Processors
+	  that are lacking this bit must have another method in place for
+	  accomplishing what is taken care of by the banked registers.
 
-# XXX: needs to lose subtype for system type
-config ST40_LMI_MEMORY
-	bool "Memory on LMI"
-	depends on CPU_SUBTYPE_ST40STB1
+	  See <file:Documentation/sh/register-banks.txt> for further
+	  information on SR.RB and register banking in the kernel in general.
 
-config MEMORY_START
-	hex
-	depends on CPU_SUBTYPE_ST40STB1 && ST40_LMI_MEMORY
-	default "0x08000000"
+endmenu
 
-config MEMORY_SIZE
-	hex
-	depends on CPU_SUBTYPE_ST40STB1 && ST40_LMI_MEMORY
-	default "0x00400000"
+menu "Timer support"
 
-config MEMORY_SET
-	bool
-	depends on CPU_SUBTYPE_ST40STB1 && ST40_LMI_MEMORY
+config SH_TMU
+	bool "TMU timer support"
 	default y
-
-config BOOT_LINK_OFFSET
-	hex "Link address offset for booting"
-	default "0x00800000"
 	help
-	  This option allows you to set the link address offset of the zImage.
-	  This can be useful if you are on a board which has a small amount of
-	  memory.
+	  This enables the use of the TMU as the system timer.
 
-config CPU_LITTLE_ENDIAN
-	bool "Little Endian"
+endmenu
+
+source "arch/sh/boards/renesas/hs7751rvoip/Kconfig"
+
+source "arch/sh/boards/renesas/rts7751r2d/Kconfig"
+
+config SH_PCLK_FREQ_BOOL
+	bool "Set default pclk frequency"
+	default y if !SH_RTC
+	default n
+
+config SH_PCLK_FREQ
+	int "Peripheral clock frequency (in Hz)"
+	depends on SH_PCLK_FREQ_BOOL
+	default "50000000" if CPU_SUBTYPE_SH7750 || CPU_SUBTYPE_SH7780
+	default "60000000" if CPU_SUBTYPE_SH7751
+	default "33333333" if CPU_SUBTYPE_SH7300 || CPU_SUBTYPE_SH7770 || CPU_SUBTYPE_SH7760
+	default "27000000" if CPU_SUBTYPE_SH73180
+	default "66000000" if CPU_SUBTYPE_SH4_202
 	help
-	  Some SuperH machines can be configured for either little or big
-	  endian byte order. These modes require different kernels. Say Y if
-	  your machine is little endian, N if it's a big endian machine.
+	  This option is used to specify the peripheral clock frequency.
+	  This is necessary for determining the reference clock value on
+	  platforms lacking an RTC.
 
-config PREEMPT
-	bool "Preemptible Kernel (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+menu "CPU Frequency scaling"
 
-config UBC_WAKEUP
-	bool "Wakeup UBC on startup"
+source "drivers/cpufreq/Kconfig"
+
+config SH_CPU_FREQ
+	tristate "SuperH CPU Frequency driver"
+	depends on CPU_FREQ
+	select CPU_FREQ_TABLE
 	help
-	  Selecting this option will wakeup the User Break Controller (UBC) on
-	  startup. Although the UBC is left in an awake state when the processor
-	  comes up, some boot loaders misbehave by putting the UBC to sleep in a
-	  power saving state, which causes issues with things like ptrace().
+	  This adds the cpufreq driver for SuperH. At present, only
+	  the SH-4 is supported.
+
+	  For details, take a look at <file:Documentation/cpu-freq>.
 
 	  If unsure, say N.
 
-config SH_WRITETHROUGH
-	bool "Use write-through caching"
-	default y if CPU_SH2
-	help
-	  Selecting this option will configure the caches in write-through
-	  mode, as opposed to the default write-back configuration.
-
-	  Since there's sill some aliasing issues on SH-4, this option will
-	  unfortunately still require the majority of flushing functions to
-	  be implemented to deal with aliasing.
+endmenu
 
-	  If unsure, say N.
+source "arch/sh/drivers/dma/Kconfig"
+
+source "arch/sh/cchips/Kconfig"
 
-config SH_OCRAM
-	bool "Operand Cache RAM (OCRAM) support"
+config HEARTBEAT
+	bool "Heartbeat LED"
+	depends on SH_MPC1211 || SH_SH03 || SH_CAT68701 || \
+		   SH_STB1_HARP || SH_STB1_OVERDRIVE || SH_BIGSUR || \
+		   SH_7751_SOLUTION_ENGINE || SH_7300_SOLUTION_ENGINE || \
+		   SH_73180_SOLUTION_ENGINE || SH_SOLUTION_ENGINE || \
+		   SH_RTS7751R2D || SH_SH4202_MICRODEV || SH_LANDISK
 	help
-	  Selecting this option will automatically tear down the number of
-	  sets in the dcache by half, which in turn exposes a memory range.
+	  Use the power-on LED on your machine as a load meter.  The exact
+	  behavior is platform-dependent, but normally the flash frequency is
+	  a hyperbolic function of the 5-minute load average.
 
-	  The addresses for the OC RAM base will vary according to the
-	  processor version. Consult vendor documentation for specifics.
+endmenu
 
-	  If unsure, say N.
+config ISA_DMA_API
+	bool
+	depends on MPC1211
+	default y
 
-config SH_STORE_QUEUES
-	bool "Support for Store Queues"
-	depends on CPU_SH4
+menu "Kernel features"
+
+config KEXEC
+	bool "kexec system call (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
 	help
-	  Selecting this option will enable an in-kernel API for manipulating
-	  the store queues integrated in the SH-4 processors.
+	  kexec is a system call that implements the ability to shutdown your
+	  current kernel, and to start another kernel.  It is like a reboot
+	  but it is indepedent of the system firmware.  And like a reboot
+	  you can start any kernel with it, not just Linux.
+
+	  The name comes from the similiarity to the exec system call.
+
+	  It is an ongoing process to be certain the hardware in a machine
+	  is properly shutdown, so do not be surprised if this code does not
+	  initially work for you.  It may help to enable device hotplugging
+	  support.  As of this writing the exact hardware interface is
+	  strongly in flux, so no good recommendation can be made.
+
+config PREEMPT
+	bool "Preemptible Kernel (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
 
 config SMP
 	bool "Symmetric multi-processing support"
@@ -614,87 +517,58 @@
 	  This is purely to save memory - each supported CPU adds
 	  approximately eight kilobytes to the kernel image.
 
-config HS7751RVOIP_CODEC
-	bool "Support VoIP Codec section"
-	depends on SH_HS7751RVOIP
-	help
-	  Selecting this option will support CODEC section.
-
-config RTS7751R2D_REV11
-	bool "RTS7751R2D Rev. 1.1 board support"
-	depends on SH_RTS7751R2D
-	help
-	  Selecting this option will support version rev. 1.1.
-
-config SH_PCLK_CALC
-	bool
-	default n if CPU_SUBTYPE_SH7300 || CPU_SUBTYPE_SH73180
+config CPU_HAS_SR_RB
+	bool "CPU has SR.RB"
+	depends on CPU_SH3 || CPU_SH4
 	default y
 	help
-	  This option will cause the PCLK value to be probed at run-time. It
-	  will display a notification if the probed value has greater than a
-	  1% variance of the hardcoded CONFIG_SH_PCLK_FREQ.
+	  This will enable the use of SR.RB register bank usage. Processors
+	  that are lacking this bit must have another method in place for
+	  accomplishing what is taken care of by the banked registers.
 
-config SH_PCLK_FREQ
-	int "Peripheral clock frequency (in Hz)"
-	default "50000000" if CPU_SUBTYPE_SH7750
-	default "60000000" if CPU_SUBTYPE_SH7751
-	default "33333333" if CPU_SUBTYPE_SH7300
-	default "27000000" if CPU_SUBTYPE_SH73180
-	default "66000000" if CPU_SUBTYPE_SH4_202
-	default "1193182"
-	help
-	  This option is used to specify the peripheral clock frequency. This
-	  option must be set for each processor in order for the kernel to
-	  function reliably. If no sane default exists, we use a default from
-	  the legacy i8254. Any discrepancies will be reported on boot time
-	  with an auto-probed frequency which should be considered the proper
-	  value for your hardware.
+	  See <file:Documentation/sh/register-banks.txt> for further
+	  information on SR.RB and register banking in the kernel in general.
 
-menu "CPU Frequency scaling"
+endmenu
 
-source "drivers/cpufreq/Kconfig"
+menu "Boot options"
 
-config SH_CPU_FREQ
-	tristate "SuperH CPU Frequency driver"
-	depends on CPU_FREQ
-	select CPU_FREQ_TABLE
+config ZERO_PAGE_OFFSET
+	hex "Zero page offset"
+	default "0x00004000" if SH_MPC1211 || SH_SH03
+	default "0x00001000"
 	help
-	  This adds the cpufreq driver for SuperH. At present, only
-	  the SH-4 is supported.
-
-	  For details, take a look at <file:Documentation/cpu-freq>.
-
-	  If unsure, say N.
+	  This sets the default offset of zero page.
 
-endmenu
+config BOOT_LINK_OFFSET
+	hex "Link address offset for booting"
+	default "0x00800000"
+	help
+	  This option allows you to set the link address offset of the zImage.
+	  This can be useful if you are on a board which has a small amount of
+	  memory.
 
-source "arch/sh/drivers/dma/Kconfig"
+config UBC_WAKEUP
+	bool "Wakeup UBC on startup"
+	help
+	  Selecting this option will wakeup the User Break Controller (UBC) on
+	  startup. Although the UBC is left in an awake state when the processor
+	  comes up, some boot loaders misbehave by putting the UBC to sleep in a
+	  power saving state, which causes issues with things like ptrace().
 
-source "arch/sh/cchips/Kconfig"
+	  If unsure, say N.
 
-config HEARTBEAT
-	bool "Heartbeat LED"
-	depends on SH_MPC1211 || SH_SH03 || SH_CAT68701 || SH_STB1_HARP || SH_STB1_OVERDRIVE || SH_BIGSUR || SH_7751_SOLUTION_ENGINE || SH_7300_SOLUTION_ENGINE || SH_73180_SOLUTION_ENGINE || SH_SOLUTION_ENGINE || SH_RTS7751R2D || SH_SH4202_MICRODEV
-	help
-	  Use the power-on LED on your machine as a load meter.  The exact
-	  behavior is platform-dependent, but normally the flash frequency is
-	  a hyperbolic function of the 5-minute load average.
+config CMDLINE_BOOL
+	bool "Default bootloader kernel arguments"
 
-config RTC_9701JE
-	tristate "EPSON RTC-9701JE support"
-	depends on SH_RTS7751R2D
-	help
-	  Selecting this option will support EPSON RTC-9701JE.
+config CMDLINE
+	string "Initial kernel command string"
+	depends on CMDLINE_BOOL
+	default "console=ttySC1,115200"
 
 endmenu
 
-config ISA_DMA_API
-	bool
-	depends on MPC1211
-	default y
-
-menu "Bus options (PCI, PCMCIA, EISA, MCA, ISA)"
+menu "Bus options"
 
 # Even on SuperH devices which don't have an ISA bus,
 # this variable helps the PCMCIA modules handle
@@ -705,7 +579,7 @@
 # PCMCIA outright. -- PFM.
 config ISA
 	bool
-	default y if PCMCIA || SMC91X
+	default y if PCMCIA
 	help
 	  Find out whether you have ISA slots on your motherboard.  ISA is the
 	  name of a bus system, i.e. the way the CPU talks to the other stuff
@@ -739,10 +613,9 @@
 config SBUS
 	bool
 
-config MAPLE
-	tristate "Maple Bus support"
-	depends on SH_DREAMCAST
-	default y
+config SUPERHYWAY
+	tristate "SuperHyway Bus support"
+	depends on CPU_SUBTYPE_SH4_202
 
 source "arch/sh/drivers/pci/Kconfig"
 
diff -urN -X exclude linux-2.6.15/arch/sh/Kconfig.debug sh-2.6.15/arch/sh/Kconfig.debug
--- linux-2.6.15/arch/sh/Kconfig.debug	2004-10-25 13:03:28.000000000 +0300
+++ sh-2.6.15/arch/sh/Kconfig.debug	2006-01-04 00:15:28.000000000 +0200
@@ -17,7 +17,7 @@
 
 config EARLY_SCIF_CONSOLE
 	bool "Use early SCIF console"
-	depends on CPU_SH4
+	depends on CPU_SH4 || CPU_SH2A && !SH_STANDARD_BIOS
 
 config EARLY_PRINTK
 	bool "Early printk support"
diff -urN -X exclude linux-2.6.15/arch/sh/Makefile sh-2.6.15/arch/sh/Makefile
--- linux-2.6.15/arch/sh/Makefile	2006-01-04 14:19:57.000000000 +0200
+++ sh-2.6.15/arch/sh/Makefile	2006-01-07 23:51:00.506910848 +0200
@@ -17,10 +17,30 @@
 cflags-y				:= -mb
 cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	:= -ml
 
+isa-y					:= any
+isa-$(CONFIG_CPU_SH2)			:= sh2
+isa-$(CONFIG_CPU_SH3)			:= sh3
+isa-$(CONFIG_CPU_SH4)			:= sh4
+isa-$(CONFIG_CPU_SH4A)			:= sh4a
+isa-$(CONFIG_CPU_SH2A)			:= sh2a
+
+isa-$(CONFIG_SH_DSP)			:= $(isa-y)-dsp
+
+ifndef CONFIG_MMU
+isa-y			:= $(isa-y)-nommu
+endif
+
+ifndef CONFIG_SH_FPU
+isa-y			:= $(isa-y)-nofpu
+endif
+
+cflags-y	+= $(call as-option,-Wa$(comma)-isa=$(isa-y),)
+
 cflags-$(CONFIG_CPU_SH2)		+= -m2
 cflags-$(CONFIG_CPU_SH3)		+= -m3
 cflags-$(CONFIG_CPU_SH4)		+= -m4 \
 	$(call cc-option,-mno-implicit-fp,-m4-nofpu)
+cflags-$(CONFIG_CPU_SH4A)		+= $(call cc-option,-m4a-nofpu,)
 
 cflags-$(CONFIG_SH_DSP)			+= -Wa,-dsp
 cflags-$(CONFIG_SH_KGDB)		+= -g
@@ -67,9 +87,7 @@
 machdir-$(CONFIG_SH_73180_SOLUTION_ENGINE)	:= se/73180
 machdir-$(CONFIG_SH_STB1_HARP)			:= harp
 machdir-$(CONFIG_SH_STB1_OVERDRIVE)		:= overdrive
-machdir-$(CONFIG_SH_HP620)			:= hp6xx/hp620
-machdir-$(CONFIG_SH_HP680)			:= hp6xx/hp680
-machdir-$(CONFIG_SH_HP690)			:= hp6xx/hp690
+machdir-$(CONFIG_SH_HP6XX)			:= hp6xx
 machdir-$(CONFIG_SH_CQREEK)			:= cqreek
 machdir-$(CONFIG_SH_DMIDA)			:= dmida
 machdir-$(CONFIG_SH_EC3104)			:= ec3104
@@ -119,31 +135,39 @@
 
 CPPFLAGS_vmlinux.lds := -traditional
 
+ifneq ($(KBUILD_SRC),)
+incdir-prefix	:= $(srctree)/include/asm-sh/
+else
+incdir-prefix	:=
+endif
+
 #	Update machine arch and proc symlinks if something which affects
 #	them changed.  We use .arch and .mach to indicate when they were
 #	updated last, otherwise make uses the target directory mtime.
 
 include/asm-sh/.cpu: $(wildcard include/config/cpu/*.h) include/config/MARKER
 	@echo '  SYMLINK include/asm-sh/cpu -> include/asm-sh/$(cpuincdir-y)'
-ifneq ($(KBUILD_SRC),)
-	$(Q)mkdir -p include/asm-sh
-	$(Q)ln -fsn $(srctree)/include/asm-sh/$(cpuincdir-y) include/asm-sh/cpu
-else
-	$(Q)ln -fsn $(cpuincdir-y) include/asm-sh/cpu
-endif
+	$(Q)if [ ! -d include/asm-sh ]; then mkdir -p include/asm-sh; fi
+	$(Q)ln -fsn $(incdir-prefix)$(cpuincdir-y) include/asm-sh/cpu
 	@touch $@
 
+#	Most boards have their own mach directories.  For the ones that
+#	don't, just reference the parent directory so the semantics are
+#	kept roughly the same.
+
 include/asm-sh/.mach: $(wildcard include/config/sh/*.h) include/config/MARKER
-	@echo '  SYMLINK include/asm-sh/mach -> include/asm-sh/$(incdir-y)'
-ifneq ($(KBUILD_SRC),)
-	$(Q)mkdir -p include/asm-sh
-	$(Q)ln -fsn $(srctree)/include/asm-sh/$(incdir-y) include/asm-sh/mach
-else
-	$(Q)ln -fsn $(incdir-y) include/asm-sh/mach
-endif
+	@echo -n '  SYMLINK include/asm-sh/mach -> '
+	$(Q)if [ ! -d include/asm-sh ]; then mkdir -p include/asm-sh; fi
+	$(Q)if [ -d $(incdir-prefix)$(incdir-y) ]; then \
+		echo -e 'include/asm-sh/$(incdir-y)'; \
+		ln -fsn $(incdir-prefix)$(incdir-y) \
+			include/asm-sh/mach; \
+	else \
+		echo -e 'include/asm-sh'; \
+		ln -fsn $(incdir-prefix) include/asm-sh/mach; \
+	fi
 	@touch $@
 
-
 archprepare: maketools include/asm-sh/.cpu include/asm-sh/.mach
 
 .PHONY: maketools FORCE

diff -urN -X exclude linux-2.6.15/arch/sh/mm/Kconfig sh-2.6.15/arch/sh/mm/Kconfig
--- linux-2.6.15/arch/sh/mm/Kconfig	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/arch/sh/mm/Kconfig	2006-01-07 22:19:41.052260810 +0200
@@ -0,0 +1,233 @@
+menu "Processor selection"
+
+#
+# Processor families
+#
+config CPU_SH2
+	bool
+	select SH_WRITETHROUGH
+
+config CPU_SH3
+	bool
+	select CPU_HAS_INTEVT
+	select CPU_HAS_SR_RB
+
+config CPU_SH4
+	bool
+	select CPU_HAS_INTEVT
+	select CPU_HAS_SR_RB
+
+config CPU_SH4A
+	bool
+	select CPU_SH4
+	select CPU_HAS_INTC2_IRQ
+
+config CPU_SUBTYPE_ST40
+	bool
+	select CPU_SH4
+	select CPU_HAS_INTC2_IRQ
+
+#
+# Processor subtypes
+#
+
+comment "SH-2 Processor Support"
+
+config CPU_SUBTYPE_SH7604
+	bool "Support SH7604 processor"
+	select CPU_SH2
+
+comment "SH-3 Processor Support"
+
+config CPU_SUBTYPE_SH7300
+	bool "Support SH7300 processor"
+	select CPU_SH3
+
+config CPU_SUBTYPE_SH7705
+	bool "Support SH7705 processor"
+	select CPU_SH3
+	select CPU_HAS_PINT_IRQ
+
+config CPU_SUBTYPE_SH7707
+	bool "Support SH7707 processor"
+	select CPU_SH3
+	select CPU_HAS_PINT_IRQ
+	help
+	  Select SH7707 if you have a  60 Mhz SH-3 HD6417707 CPU.
+
+config CPU_SUBTYPE_SH7708
+	bool "Support SH7708 processor"
+	select CPU_SH3
+	help
+	  Select SH7708 if you have a  60 Mhz SH-3 HD6417708S or
+	  if you have a 100 Mhz SH-3 HD6417708R CPU.
+
+config CPU_SUBTYPE_SH7709
+	bool "Support SH7709 processor"
+	select CPU_SH3
+	select CPU_HAS_PINT_IRQ
+	help
+	  Select SH7709 if you have a  80 Mhz SH-3 HD6417709 CPU.
+
+comment "SH-4 Processor Support"
+
+config CPU_SUBTYPE_SH7750
+	bool "Support SH7750 processor"
+	select CPU_SH4
+	help
+	  Select SH7750 if you have a 200 Mhz SH-4 HD6417750 CPU.
+
+config CPU_SUBTYPE_SH7091
+	bool "Support SH7091 processor"
+	select CPU_SH4
+	select CPU_SUBTYPE_SH7750
+	help
+	  Select SH7091 if you have an SH-4 based Sega device (such as
+	  the Dreamcast, Naomi, and Naomi 2).
+
+config CPU_SUBTYPE_SH7750R
+	bool "Support SH7750R processor"
+	select CPU_SH4
+	select CPU_SUBTYPE_SH7750
+
+config CPU_SUBTYPE_SH7750S
+	bool "Support SH7750S processor"
+	select CPU_SH4
+	select CPU_SUBTYPE_SH7750
+
+config CPU_SUBTYPE_SH7751
+	bool "Support SH7751 processor"
+	select CPU_SH4
+	help
+	  Select SH7751 if you have a 166 Mhz SH-4 HD6417751 CPU,
+	  or if you have a HD6417751R CPU.
+
+config CPU_SUBTYPE_SH7751R
+	bool "Support SH7751R processor"
+	select CPU_SH4
+	select CPU_SUBTYPE_SH7751
+
+config CPU_SUBTYPE_SH7760
+	bool "Support SH7760 processor"
+	select CPU_SH4
+	select CPU_HAS_INTC2_IRQ
+
+config CPU_SUBTYPE_SH4_202
+	bool "Support SH4-202 processor"
+	select CPU_SH4
+
+comment "ST40 Processor Support"
+
+config CPU_SUBTYPE_ST40STB1
+	bool "Support ST40STB1/ST40RA processors"
+	select CPU_SUBTYPE_ST40
+	help
+	  Select ST40STB1 if you have a ST40RA CPU.
+	  This was previously called the ST40STB1, hence the option name.
+
+config CPU_SUBTYPE_ST40GX1
+	bool "Support ST40GX1 processor"
+	select CPU_SUBTYPE_ST40
+	help
+	  Select ST40GX1 if you have a ST40GX1 CPU.
+
+comment "SH-4A Processor Support"
+
+config CPU_SUBTYPE_SH73180
+	bool "Support SH73180 processor"
+	select CPU_SH4A
+
+config CPU_SUBTYPE_SH7770
+	bool "Support SH7770 processor"
+	select CPU_SH4A
+
+config CPU_SUBTYPE_SH7780
+	bool "Support SH7780 processor"
+	select CPU_SH4A
+
+endmenu
+
+menu "Memory management options"
+
+config MMU
+        bool "Support for memory management hardware"
+	depends on !CPU_SH2
+	default y
+	help
+	  Some SH processors (such as SH-2/SH-2A) lack an MMU. In order to
+	  boot on these systems, this option must not be set.
+
+	  On other systems (such as the SH-3 and 4) where an MMU exists,
+	  turning this off will boot the kernel on these machines with the
+	  MMU implicitly switched off.
+
+config 32BIT
+	bool "Support 32-bit physical addressing through PMB"
+	depends on CPU_SH4A
+	default y
+	help
+	  If you say Y here, physical addressing will be extended to
+	  32-bits through the SH-4A PMB. If this is not set, legacy
+	  29-bit physical addressing will be used.
+
+choice
+	prompt "HugeTLB page size"
+	depends on HUGETLB_PAGE && CPU_SH4 && MMU
+	default HUGETLB_PAGE_SIZE_64K
+
+config HUGETLB_PAGE_SIZE_64K
+	bool "64K"
+
+config HUGETLB_PAGE_SIZE_1MB
+	bool "1MB"
+
+endchoice
+
+source "mm/Kconfig"
+
+endmenu
+
+menu "Cache configuration"
+
+config SH7705_CACHE_32KB
+	bool "Enable 32KB cache size for SH7705"
+	depends on CPU_SUBTYPE_SH7705
+	default y
+
+config SH_DIRECT_MAPPED
+	bool "Use direct-mapped caching"
+	default n
+	help
+	  Selecting this option will configure the caches to be direct-mapped,
+	  even if the cache supports a 2 or 4-way mode. This is useful primarily
+	  for debugging on platforms with 2 and 4-way caches (SH7750R/SH7751R,
+	  SH4-202, SH4-501, etc.)
+
+	  Turn this option off for platforms that do not have a direct-mapped
+	  cache, and you have no need to run the caches in such a configuration.
+
+config SH_WRITETHROUGH
+	bool "Use write-through caching"
+	default y if CPU_SH2
+	help
+	  Selecting this option will configure the caches in write-through
+	  mode, as opposed to the default write-back configuration.
+
+	  Since there's sill some aliasing issues on SH-4, this option will
+	  unfortunately still require the majority of flushing functions to
+	  be implemented to deal with aliasing.
+
+	  If unsure, say N.
+
+config SH_OCRAM
+	bool "Operand Cache RAM (OCRAM) support"
+	help
+	  Selecting this option will automatically tear down the number of
+	  sets in the dcache by half, which in turn exposes a memory range.
+
+	  The addresses for the OC RAM base will vary according to the
+	  processor version. Consult vendor documentation for specifics.
+
+	  If unsure, say N.
+
+endmenu
