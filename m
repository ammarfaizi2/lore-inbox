Return-Path: <linux-kernel-owner+w=401wt.eu-S1752426AbWLSEM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbWLSEM7 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 23:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752416AbWLSEM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 23:12:59 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4458 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752426AbWLSEMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 23:12:55 -0500
Date: Tue, 19 Dec 2006 05:12:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: paulus@samba.org, Kumar Gala <galak@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] powerpc: remove the broken Gemini support
Message-ID: <20061219041254.GB6993@stusta.de>
References: <20061124234935.GJ28363@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061124234935.GJ28363@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2006 at 12:49:35AM +0100, Adrian Bunk wrote:
> I just saw the commit message below.
> 
> There seems to have been some although unmerged work on APUS support by 
> Roman, but I didn't find any recent work on bringing the GEMINI support 
> back into life.
> 
> Is this a wrong impression, or would a patch to remove it be OK?
>...

Zero feedback, patch to remove it below.

cu
Adrian


<--  snip  -->


This patch removes the broken Gemini support.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/powerpc/kernel/head_32.S              |    5 
 arch/powerpc/platforms/embedded6xx/Kconfig |    9 
 arch/ppc/Kconfig                           |    9 
 arch/ppc/boot/simple/Makefile              |    4 
 arch/ppc/boot/simple/misc.c                |   15 
 arch/ppc/configs/gemini_defconfig          |  618 ---------------------
 arch/ppc/kernel/head.S                     |   18 
 arch/ppc/platforms/Makefile                |    1 
 arch/ppc/platforms/gemini.h                |  165 -----
 arch/ppc/platforms/gemini_pci.c            |   41 -
 arch/ppc/platforms/gemini_prom.S           |   90 ---
 arch/ppc/platforms/gemini_serial.h         |   40 -
 arch/ppc/platforms/gemini_setup.c          |  577 -------------------
 arch/ppc/syslib/Makefile                   |    1 
 arch/ppc/xmon/start.c                      |    5 
 include/asm-ppc/serial.h                   |    2 
 16 files changed, 2 insertions(+), 1598 deletions(-)

--- linux-2.6.20-rc1-mm1/arch/powerpc/kernel/head_32.S.old	2006-12-19 03:57:49.000000000 +0100
+++ linux-2.6.20-rc1-mm1/arch/powerpc/kernel/head_32.S	2006-12-19 03:58:30.000000000 +0100
@@ -344,12 +344,7 @@
 /* System reset */
 /* core99 pmac starts the seconary here by changing the vector, and
    putting it back to what it was (unknown_exception) when done.  */
-#if defined(CONFIG_GEMINI) && defined(CONFIG_SMP)
-	. = 0x100
-	b	__secondary_start_gemini
-#else
 	EXCEPTION(0x100, Reset, unknown_exception, EXC_XFER_STD)
-#endif
 
 /* Machine check */
 /*
--- linux-2.6.20-rc1-mm1/arch/powerpc/platforms/embedded6xx/Kconfig.old	2006-12-19 03:59:10.000000000 +0100
+++ linux-2.6.20-rc1-mm1/arch/powerpc/platforms/embedded6xx/Kconfig	2006-12-19 03:59:26.000000000 +0100
@@ -104,15 +104,6 @@
 config PAL4
 	bool "SBS-Palomar4"
 
-config GEMINI
-	bool "Synergy-Gemini"
-	select PPC_INDIRECT_PCI
-	depends on BROKEN
-	help
-	  Select Gemini if configuring for a Synergy Microsystems' Gemini
-	  series Single Board Computer.  More information is available at:
-	  <http://www.synergymicro.com/PressRel/97_10_15.html>.
-
 config EST8260
 	bool "EST8260"
 	---help---
--- linux-2.6.20-rc1-mm1/arch/ppc/Kconfig.old	2006-12-19 03:59:37.000000000 +0100
+++ linux-2.6.20-rc1-mm1/arch/ppc/Kconfig	2006-12-19 03:59:48.000000000 +0100
@@ -670,15 +670,6 @@
 config PAL4
 	bool "SBS-Palomar4"
 
-config GEMINI
-	bool "Synergy-Gemini"
-	depends on BROKEN
-	select PPC_INDIRECT_PCI
-	help
-	  Select Gemini if configuring for a Synergy Microsystems' Gemini
-	  series Single Board Computer.  More information is available at:
-	  <http://www.synergymicro.com/PressRel/97_10_15.html>.
-
 config EST8260
 	bool "EST8260"
 	---help---
--- linux-2.6.20-rc1-mm1/arch/ppc/boot/simple/Makefile.old	2006-12-19 03:59:58.000000000 +0100
+++ linux-2.6.20-rc1-mm1/arch/ppc/boot/simple/Makefile	2006-12-19 04:00:20.000000000 +0100
@@ -116,10 +116,6 @@
      extra.o-$(CONFIG_CHESTNUT)		:= misc-chestnut.o
          end-$(CONFIG_CHESTNUT)		:= chestnut
 
-      zimage-$(CONFIG_GEMINI)		:= zImage-STRIPELF
-zimageinitrd-$(CONFIG_GEMINI)		:= zImage.initrd-STRIPELF
-         end-$(CONFIG_GEMINI)		:= gemini
-
      extra.o-$(CONFIG_KATANA)		:= misc-katana.o
          end-$(CONFIG_KATANA)		:= katana
    cacheflag-$(CONFIG_KATANA)		:= -include $(clear_L2_L3)
--- linux-2.6.20-rc1-mm1/arch/ppc/boot/simple/misc.c.old	2006-12-19 04:00:33.000000000 +0100
+++ linux-2.6.20-rc1-mm1/arch/ppc/boot/simple/misc.c	2006-12-19 04:01:18.000000000 +0100
@@ -42,14 +42,11 @@
 #endif
 
 /* Will / Can the user give input?
- * Val Henson has requested that Gemini doesn't wait for the
- * user to edit the cmdline or not.
  */
 #if (defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_VGA_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)) \
-	&& !defined(CONFIG_GEMINI)
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE))
 #define INTERACTIVE_CONSOLE	1
 #endif
 
@@ -178,16 +175,6 @@
 
 	if (keyb_present)
 		CRT_tstc();  /* Forces keyboard to be initialized */
-#ifdef CONFIG_GEMINI
-	/*
-	 * If cmd_line is empty and cmd_preset is not, copy cmd_preset
-	 * to cmd_line.  This way we can override cmd_preset with the
-	 * command line from Smon.
-	 */
-
-	if ( (cmd_line[0] == '\0') && (cmd_preset[0] != '\0'))
-		memcpy (cmd_line, cmd_preset, sizeof(cmd_preset));
-#endif
 
 	/* Display standard Linux/PPC boot prompt for kernel args */
 	puts("\nLinux/PPC load: ");
--- linux-2.6.20-rc1-mm1/arch/ppc/kernel/head.S.old	2006-12-19 04:01:36.000000000 +0100
+++ linux-2.6.20-rc1-mm1/arch/ppc/kernel/head.S	2006-12-19 04:01:56.000000000 +0100
@@ -310,12 +310,7 @@
 /* System reset */
 /* core99 pmac starts the seconary here by changing the vector, and
    putting it back to what it was (unknown_exception) when done.  */
-#if defined(CONFIG_GEMINI) && defined(CONFIG_SMP)
-	. = 0x100
-	b	__secondary_start_gemini
-#else
 	EXCEPTION(0x100, Reset, unknown_exception, EXC_XFER_STD)
-#endif
 
 /* Machine check */
 	. = 0x200
@@ -897,19 +892,6 @@
 #endif /* CONFIG_APUS */
 
 #ifdef CONFIG_SMP
-#ifdef CONFIG_GEMINI
-	.globl	__secondary_start_gemini
-__secondary_start_gemini:
-        mfspr   r4,SPRN_HID0
-        ori     r4,r4,HID0_ICFI
-        li      r3,0
-        ori     r3,r3,HID0_ICE
-        andc    r4,r4,r3
-        mtspr   SPRN_HID0,r4
-        sync
-        b       __secondary_start
-#endif /* CONFIG_GEMINI */
-
 	.globl	__secondary_start_pmac_0
 __secondary_start_pmac_0:
 	/* NB the entries for cpus 0, 1, 2 must each occupy 8 bytes. */
--- linux-2.6.20-rc1-mm1/arch/ppc/platforms/Makefile.old	2006-12-19 04:02:16.000000000 +0100
+++ linux-2.6.20-rc1-mm1/arch/ppc/platforms/Makefile	2006-12-19 04:02:25.000000000 +0100
@@ -13,7 +13,6 @@
 obj-$(CONFIG_CPCI690)		+= cpci690.o
 obj-$(CONFIG_EV64260)		+= ev64260.o
 obj-$(CONFIG_CHESTNUT)		+= chestnut.o
-obj-$(CONFIG_GEMINI)		+= gemini_pci.o gemini_setup.o gemini_prom.o
 obj-$(CONFIG_LOPEC)		+= lopec.o
 obj-$(CONFIG_KATANA)		+= katana.o
 obj-$(CONFIG_HDPU)		+= hdpu.o
--- linux-2.6.20-rc1-mm1/arch/ppc/syslib/Makefile.old	2006-12-19 04:05:24.000000000 +0100
+++ linux-2.6.20-rc1-mm1/arch/ppc/syslib/Makefile	2006-12-19 04:05:37.000000000 +0100
@@ -45,7 +45,6 @@
 obj-$(CONFIG_EV64260)		+= todc_time.o pci_auto.o
 obj-$(CONFIG_EV64360)		+= todc_time.o
 obj-$(CONFIG_CHESTNUT)		+= mv64360_pic.o pci_auto.o
-obj-$(CONFIG_GEMINI)		+= open_pic.o
 obj-$(CONFIG_GT64260)		+= gt64260_pic.o
 obj-$(CONFIG_LOPEC)		+= pci_auto.o todc_time.o
 obj-$(CONFIG_HDPU)		+= pci_auto.o
--- linux-2.6.20-rc1-mm1/arch/ppc/xmon/start.c.old	2006-12-19 04:05:49.000000000 +0100
+++ linux-2.6.20-rc1-mm1/arch/ppc/xmon/start.c	2006-12-19 04:05:59.000000000 +0100
@@ -58,10 +58,7 @@
 void
 xmon_map_scc(void)
 {
-#if defined(CONFIG_GEMINI)
-	/* should already be mapped by the kernel boot */
-	sccd = (volatile unsigned char *) 0xffeffb08;
-#elif defined(CONFIG_405GP)
+#if defined(CONFIG_405GP)
 	sccd = (volatile unsigned char *)0xef600300;
 #elif defined(CONFIG_440EP)
 	sccd = (volatile unsigned char *) ioremap(PPC440EP_UART0_ADDR, 8);
--- linux-2.6.20-rc1-mm1/include/asm-ppc/serial.h.old	2006-12-19 04:06:20.000000000 +0100
+++ linux-2.6.20-rc1-mm1/include/asm-ppc/serial.h	2006-12-19 04:06:28.000000000 +0100
@@ -11,8 +11,6 @@
 #include <platforms/ev64260.h>
 #elif defined(CONFIG_CHESTNUT)
 #include <platforms/chestnut.h>
-#elif defined(CONFIG_GEMINI)
-#include <platforms/gemini_serial.h>
 #elif defined(CONFIG_POWERPMC250)
 #include <platforms/powerpmc250.h>
 #elif defined(CONFIG_LOPEC)
--- linux-2.6.20-rc1-mm1/arch/ppc/platforms/gemini.h	2006-11-29 22:57:37.000000000 +0100
+++ /dev/null	2006-09-19 00:45:31.000000000 +0200
@@ -1,165 +0,0 @@
-/*
- *  Onboard registers and descriptions for Synergy Microsystems'
- *  "Gemini" boards.
- *
- */
-#ifdef __KERNEL__
-#ifndef __PPC_GEMINI_H
-#define __PPC_GEMINI_H
-
-/*  Registers  */
-
-#define GEMINI_SERIAL_B     (0xffeffb00)
-#define GEMINI_SERIAL_A     (0xffeffb08)
-#define GEMINI_USWITCH      (0xffeffd00)
-#define GEMINI_BREV         (0xffeffe00)
-#define GEMINI_BECO         (0xffeffe08)
-#define GEMINI_FEAT         (0xffeffe10)
-#define GEMINI_BSTAT        (0xffeffe18)
-#define GEMINI_CPUSTAT      (0xffeffe20)
-#define GEMINI_L2CFG        (0xffeffe30)
-#define GEMINI_MEMCFG       (0xffeffe38)
-#define GEMINI_FLROM        (0xffeffe40)
-#define GEMINI_P0PCI        (0xffeffe48)
-#define GEMINI_FLWIN        (0xffeffe50)
-#define GEMINI_P0INTMASK    (0xffeffe60)
-#define GEMINI_P0INTAP      (0xffeffe68)
-#define GEMINI_PCIERR       (0xffeffe70)
-#define GEMINI_LEDBASE      (0xffeffe80)
-#define GEMINI_RTC          (0xffe9fff8)
-#define GEMINI_LEDS         8
-#define GEMINI_SWITCHES     8
-
-
-/* Flash ROM bit definitions */
-#define GEMINI_FLS_WEN      (1<<0)
-#define GEMINI_FLS_JMP      (1<<6)
-#define GEMINI_FLS_BOOT     (1<<7)
-
-/* Memory bit definitions */
-#define GEMINI_MEM_TYPE_MASK 0xc0
-#define GEMINI_MEM_SIZE_MASK 0x38
-#define GEMINI_MEM_BANK_MASK 0x07
-
-/* L2 cache bit definitions */
-#define GEMINI_L2_SIZE_MASK  0xc0
-#define GEMINI_L2_RATIO_MASK 0x03
-
-/* Timebase register bit definitons */
-#define GEMINI_TIMEB0_EN     (1<<0)
-#define GEMINI_TIMEB1_EN     (1<<1)
-#define GEMINI_TIMEB2_EN     (1<<2)
-#define GEMINI_TIMEB3_EN     (1<<3)
-
-/* CPU status bit definitions */
-#define GEMINI_CPU_ID_MASK   0x03
-#define GEMINI_CPU_COUNT_MASK 0x0c
-#define GEMINI_CPU0_HALTED   (1<<4)
-#define GEMINI_CPU1_HALTED   (1<<5)
-#define GEMINI_CPU2_HALTED   (1<<6)
-#define GEMINI_CPU3_HALTED   (1<<7)
-
-/* Board status bit definitions */
-#define GEMINI_BRD_FAIL      (1<<0)   /* FAIL led is lit */
-#define GEMINI_BRD_BUS_MASK  0x0c     /* PowerPC bus speed */
-
-/* Board family/feature bit descriptions */
-#define GEMINI_FEAT_HAS_FLASH (1<<0)
-#define GEMINI_FEAT_HAS_ETH   (1<<1)
-#define GEMINI_FEAT_HAS_SCSI  (1<<2)
-#define GEMINI_FEAT_HAS_P0    (1<<3)
-#define GEMINI_FEAT_FAM_MASK  0xf0
-
-/* Mod/ECO bit definitions */
-#define GEMINI_ECO_LEVEL_MASK 0x0f
-#define GEMINI_MOD_MASK       0xf0
-
-/* Type/revision bit definitions */
-#define GEMINI_REV_MASK       0x0f
-#define GEMINI_TYPE_MASK      0xf0
-
-/* User switch definitions */
-#define GEMINI_SWITCH_VERBOSE    1     /* adds "debug" to boot cmd line */
-#define GEMINI_SWITCH_SINGLE_USER 7    /* boots into "single-user" mode */
-
-#define SGS_RTC_CONTROL  0
-#define SGS_RTC_SECONDS  1
-#define SGS_RTC_MINUTES  2
-#define SGS_RTC_HOURS    3
-#define SGS_RTC_DAY      4
-#define SGS_RTC_DAY_OF_MONTH 5
-#define SGS_RTC_MONTH    6
-#define SGS_RTC_YEAR     7
-
-#define SGS_RTC_SET  0x80
-#define SGS_RTC_IS_STOPPED 0x80
-
-#define GRACKLE_CONFIG_ADDR_ADDR  (0xfec00000)
-#define GRACKLE_CONFIG_DATA_ADDR  (0xfee00000)
-
-#define GEMINI_BOOT_INIT  (0xfff00100)
-
-#ifndef __ASSEMBLY__
-
-static inline void grackle_write( unsigned long addr, unsigned long data )
-{
-  __asm__ __volatile__(
-  " stwbrx %1, 0, %0\n \
-    sync\n \
-    stwbrx %3, 0, %2\n \
-    sync "
-  : /* no output */
-  : "r" (GRACKLE_CONFIG_ADDR_ADDR), "r" (addr),
-    "r" (GRACKLE_CONFIG_DATA_ADDR), "r" (data));
-}
-
-static inline unsigned long grackle_read( unsigned long addr )
-{
-  unsigned long val;
-
-  __asm__ __volatile__(
-  " stwbrx %1, 0, %2\n \
-    sync\n \
-    lwbrx %0, 0, %3\n \
-    sync "
-  : "=r" (val)
-  : "r" (addr), "r" (GRACKLE_CONFIG_ADDR_ADDR),
-    "r" (GRACKLE_CONFIG_DATA_ADDR));
-
-  return val;
-}
-
-static inline void gemini_led_on( int led )
-{
-  if (led >= 0 && led < GEMINI_LEDS)
-    *(unsigned char *)(GEMINI_LEDBASE + (led<<3)) = 1;
-}
-
-static inline void gemini_led_off(int led)
-{
-  if (led >= 0 && led < GEMINI_LEDS)
-    *(unsigned char *)(GEMINI_LEDBASE + (led<<3)) = 0;
-}
-
-static inline int gemini_led_val(int led)
-{
-  int val = 0;
-  if (led >= 0 && led < GEMINI_LEDS)
-    val = *(unsigned char *)(GEMINI_LEDBASE + (led<<3));
-  return (val & 0x1);
-}
-
-/* returns processor id from the board */
-static inline int gemini_processor(void)
-{
-  unsigned char cpu = *(unsigned char *)(GEMINI_CPUSTAT);
-  return (int) ((cpu == 0) ? 4 : (cpu & GEMINI_CPU_ID_MASK));
-}
-
-
-extern void _gemini_reboot(void);
-extern void gemini_prom_init(void);
-extern void gemini_init_l2(void);
-#endif /* __ASSEMBLY__ */
-#endif
-#endif /* __KERNEL__ */
--- linux-2.6.20-rc1-mm1/arch/ppc/platforms/gemini_pci.c	2006-11-29 22:57:37.000000000 +0100
+++ /dev/null	2006-09-19 00:45:31.000000000 +0200
@@ -1,41 +0,0 @@
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/slab.h>
-
-#include <asm/machdep.h>
-#include <platforms/gemini.h>
-#include <asm/byteorder.h>
-#include <asm/io.h>
-#include <asm/uaccess.h>
-#include <asm/pci-bridge.h>
-
-void __init gemini_pcibios_fixup(void)
-{
-	int i;
-	struct pci_dev *dev = NULL;
-	
-	for_each_pci_dev(dev) {
-		for(i = 0; i < 6; i++) {
-			if (dev->resource[i].flags & IORESOURCE_IO) {
-				dev->resource[i].start |= (0xfe << 24);
-				dev->resource[i].end |= (0xfe << 24);
-			}
-		}
-	}
-}
-
-
-/* The "bootloader" for Synergy boards does none of this for us, so we need to
-   lay it all out ourselves... --Dan */
-void __init gemini_find_bridges(void)
-{
-	struct pci_controller* hose;
-	
-	ppc_md.pcibios_fixup = gemini_pcibios_fixup;
-
-	hose = pcibios_alloc_controller();
-	if (!hose)
-		return;
-	setup_indirect_pci(hose, 0xfec00000, 0xfee00000);
-}
--- linux-2.6.20-rc1-mm1/arch/ppc/platforms/gemini_prom.S	2006-11-29 22:57:37.000000000 +0100
+++ /dev/null	2006-09-19 00:45:31.000000000 +0200
@@ -1,90 +0,0 @@
-/*
- *  Not really prom support code (yet), but sort of anti-prom code.  The current
- *  bootloader does a number of things it shouldn't and doesn't do things that it
- *  should.  The stuff in here is mainly a hodge-podge collection of setup code
- *  to get the board up and running.
- *    ---Dan
- */
-
-#include <asm/reg.h>
-#include <asm/page.h>
-#include <platforms/gemini.h>
-#include <asm/ppc_asm.h>
-
-/*
- *  On 750's the MMU is on when Linux is booted, so we need to clear out the
- *  bootloader's BAT settings, make sure we're in supervisor state (gotcha!),
- *  and turn off the MMU.
- *
- */
-
-_GLOBAL(gemini_prom_init)
-#ifdef CONFIG_SMP
-	/* Since the MMU's on, get stuff in rom space that we'll need */
-	lis	r4,GEMINI_CPUSTAT@h
-	ori	r4,r4,GEMINI_CPUSTAT@l
-	lbz	r5,0(r4)
-	andi.	r5,r5,3
-	mr	r24,r5		/* cpu # used later on */
-#endif
-	mfmsr	r4
-	li	r3,MSR_PR	/* ensure supervisor! */
-	ori	r3,r3,MSR_IR|MSR_DR
-	andc	r4,r4,r3
-	mtmsr	r4
-	isync
-#if 0
-	/* zero out the bats now that the MMU is off */
-prom_no_mmu:	
-	li	r3,0
-        mtspr   SPRN_IBAT0U,r3
-        mtspr   SPRN_IBAT0L,r3
-        mtspr   SPRN_IBAT1U,r3
-        mtspr   SPRN_IBAT1L,r3
-        mtspr   SPRN_IBAT2U,r3
-        mtspr   SPRN_IBAT2L,r3
-        mtspr   SPRN_IBAT3U,r3
-        mtspr   SPRN_IBAT3L,r3
-
-        mtspr   SPRN_DBAT0U,r3
-        mtspr   SPRN_DBAT0L,r3
-        mtspr   SPRN_DBAT1U,r3
-        mtspr   SPRN_DBAT1L,r3
-        mtspr   SPRN_DBAT2U,r3
-	mtspr   SPRN_DBAT2L,r3
-        mtspr   SPRN_DBAT3U,r3
-        mtspr   SPRN_DBAT3L,r3
-#endif
-
-	/* the bootloader (as far as I'm currently aware) doesn't mess with page
-	   tables, but since we're already here, might as well zap these, too */
-	li	r4,0
-	mtspr	SPRN_SDR1,r4
-
-	li	r4,16
-	mtctr	r4
-	li	r3,0
-	li	r4,0
-3:	mtsrin	r3,r4
-	addi	r3,r3,1
-	bdnz	3b
-
-#ifdef CONFIG_SMP
-	/* The 750 book (and Mot/IBM support) says that this will "assist" snooping
-	   when in SMP.  Not sure yet whether this should stay or leave... */
-	mfspr	r4,SPRN_HID0
-	ori	r4,r4,HID0_ABE
-	mtspr	SPRN_HID0,r4
-	sync
-#endif /* CONFIG_SMP */
-	blr
-
-/*  apparently, SMon doesn't pay attention to HID0[SRST].  Disable the MMU and
-    branch to 0xfff00100 */
-_GLOBAL(_gemini_reboot)
-	lis	r5,GEMINI_BOOT_INIT@h
-	ori	r5,r5,GEMINI_BOOT_INIT@l
-	li	r6,MSR_IP
-	mtspr	SPRN_SRR0,r5
-	mtspr	SPRN_SRR1,r6
-	rfi
--- linux-2.6.20-rc1-mm1/arch/ppc/platforms/gemini_serial.h	2006-11-29 22:57:37.000000000 +0100
+++ /dev/null	2006-09-19 00:45:31.000000000 +0200
@@ -1,40 +0,0 @@
-#ifdef __KERNEL__
-#ifndef __ASMPPC_GEMINI_SERIAL_H
-#define __ASMPPC_GEMINI_SERIAL_H
-
-#include <platforms/gemini.h>
-
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define RS_TABLE_SIZE  64
-#else
-#define RS_TABLE_SIZE  4
-#endif
-
-/* Rate for the 24.576 Mhz clock for the onboard serial chip */
-#define BASE_BAUD  (24576000 / 16)
-
-#ifdef CONFIG_SERIAL_DETECT_IRQ
-#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF|ASYNC_SKIP_TEST|ASYNC_AUTO_IRQ)
-#define STD_COM4_FLAGS (ASYNC_BOOT_AUTOCONF|ASYNC_AUTO_IRQ)
-#else
-#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF|ASYNC_SKIP_TEST)
-#define STD_COM4_FLAGS (ASYNC_BOOT_AUTOCONF)
-#endif
-
-#define STD_SERIAL_PORT_DEFNS \
-        { 0, BASE_BAUD, GEMINI_SERIAL_A, 15, STD_COM_FLAGS }, /* ttyS0 */ \
-        { 0, BASE_BAUD, GEMINI_SERIAL_B, 14, STD_COM_FLAGS }, /* ttyS1 */ \
-
-#ifdef CONFIG_GEMINI_PU32
-#define PU32_SERIAL_PORT_DEFNS \
-        { 0, BASE_BAUD, NULL, 0, STD_COM_FLAGS },
-#else
-#define PU32_SERIAL_PORT_DEFNS
-#endif
-
-#define SERIAL_PORT_DFNS \
-        STD_SERIAL_PORT_DEFNS \
-        PU32_SERIAL_PORT_DEFNS
-
-#endif
-#endif /* __KERNEL__ */
--- linux-2.6.20-rc1-mm1/arch/ppc/platforms/gemini_setup.c	2006-11-29 22:57:37.000000000 +0100
+++ /dev/null	2006-09-19 00:45:31.000000000 +0200
@@ -1,577 +0,0 @@
-/*
- *  Copyright (C) 1995 Linus Torvalds
- *  Adapted from 'alpha' version by Gary Thomas
- *  Modified by Cort Dougan (cort@cs.nmt.edu)
- *  Synergy Microsystems board support by Dan Cox (dan@synergymicro.com)
- *
- */
-
-#include <linux/stddef.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/reboot.h>
-#include <linux/pci.h>
-#include <linux/time.h>
-#include <linux/kdev_t.h>
-#include <linux/types.h>
-#include <linux/major.h>
-#include <linux/initrd.h>
-#include <linux/console.h>
-#include <linux/seq_file.h>
-#include <linux/root_dev.h>
-#include <linux/bcd.h>
-
-#include <asm/system.h>
-#include <asm/pgtable.h>
-#include <asm/page.h>
-#include <asm/dma.h>
-#include <asm/io.h>
-#include <asm/m48t35.h>
-#include <platforms/gemini.h>
-#include <asm/time.h>
-#include <asm/open_pic.h>
-#include <asm/bootinfo.h>
-#include <asm/machdep.h>
-
-void gemini_find_bridges(void);
-static int gemini_get_clock_speed(void);
-extern void gemini_pcibios_fixup(void);
-
-static char *gemini_board_families[] = {
-  "VGM", "VSS", "KGM", "VGR", "VCM", "VCS", "KCM", "VCR"
-};
-static int gemini_board_count = sizeof(gemini_board_families) /
-                                 sizeof(gemini_board_families[0]);
-
-static unsigned int cpu_7xx[16] = {
-	0, 15, 14, 0, 0, 13, 5, 9, 6, 11, 8, 10, 16, 12, 7, 0
-};
-static unsigned int cpu_6xx[16] = {
-	0, 0, 14, 0, 0, 13, 5, 9, 6, 11, 8, 10, 0, 12, 7, 0
-};
-
-/*
- * prom_init is the Gemini version of prom.c:prom_init.  We only need
- * the BSS clearing code, so I copied that out of prom.c.  This is a
- * lot simpler than hacking prom.c so it will build with Gemini. -VAL
- */
-
-#define PTRRELOC(x)	((typeof(x))((unsigned long)(x) + offset))
-
-unsigned long
-prom_init(void)
-{
-	unsigned long offset = reloc_offset();
-	unsigned long phys;
-	extern char __bss_start, _end;
-
-	/* First zero the BSS -- use memset, some arches don't have
-	 * caches on yet */
-	memset_io(PTRRELOC(&__bss_start),0 , &_end - &__bss_start);
-
- 	/* Default */
- 	phys = offset + KERNELBASE;
-
-	gemini_prom_init();
-
-	return phys;
-}
-
-int
-gemini_show_cpuinfo(struct seq_file *m)
-{
-	unsigned char reg, rev;
-	char *family;
-	unsigned int type;
-
-	reg = readb(GEMINI_FEAT);
-	family = gemini_board_families[((reg>>4) & 0xf)];
-	if (((reg>>4) & 0xf) > gemini_board_count)
-		printk(KERN_ERR "cpuinfo(): unable to determine board family\n");
-
-	reg = readb(GEMINI_BREV);
-	type = (reg>>4) & 0xf;
-	rev = reg & 0xf;
-
-	reg = readb(GEMINI_BECO);
-
-	seq_printf(m, "machine\t\t: Gemini %s%d, rev %c, eco %d\n",
-		   family, type, (rev + 'A'), (reg & 0xf));
-
-	seq_printf(m, "board\t\t: Gemini %s", family);
-	if (type > 9)
-		seq_printf(m, "%c", (type - 10) + 'A');
-	else
-		seq_printf(m, "%d", type);
-
-	seq_printf(m, ", rev %c, eco %d\n", (rev + 'A'), (reg & 0xf));
-
-	seq_printf(m, "clock\t\t: %dMhz\n", gemini_get_clock_speed());
-
-	return 0;
-}
-
-static u_char gemini_openpic_initsenses[] = {
-	1,
-	1,
-	1,
-	1,
-	0,
-	0,
-	1, /* remainder are level-triggered */
-};
-
-#define GEMINI_MPIC_ADDR (0xfcfc0000)
-#define GEMINI_MPIC_PCI_CFG (0x80005800)
-
-void __init gemini_openpic_init(void)
-{
-
-	OpenPIC_Addr = (volatile struct OpenPIC *)
-		grackle_read(GEMINI_MPIC_PCI_CFG + 0x10);
-	OpenPIC_InitSenses = gemini_openpic_initsenses;
-	OpenPIC_NumInitSenses = sizeof( gemini_openpic_initsenses );
-
-	ioremap( GEMINI_MPIC_ADDR, OPENPIC_SIZE);
-}
-
-
-extern unsigned long loops_per_jiffy;
-extern int root_mountflags;
-extern char cmd_line[];
-
-void
-gemini_heartbeat(void)
-{
-	static unsigned long led = GEMINI_LEDBASE+(4*8);
-	static char direction = 8;
-
-
-	/* We only want to do this on 1 CPU */
-	if (smp_processor_id())
-		return;
-	*(char *)led = 0;
-	if ( (led + direction) > (GEMINI_LEDBASE+(7*8)) ||
-	     (led + direction) < (GEMINI_LEDBASE+(4*8)) )
-		direction *= -1;
-	led += direction;
-	*(char *)led = 0xff;
-	ppc_md.heartbeat_count = ppc_md.heartbeat_reset;
-}
-
-void __init gemini_setup_arch(void)
-{
-	extern char cmd_line[];
-
-
-	loops_per_jiffy = 50000000/HZ;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	/* bootable off CDROM */
-	if (initrd_start)
-		ROOT_DEV = Root_SR0;
-	else
-#endif
-		ROOT_DEV = Root_SDA1;
-
-	/* nothing but serial consoles... */
-	sprintf(cmd_line, "%s console=ttyS0", cmd_line);
-
-	printk("Boot arguments: %s\n", cmd_line);
-
-	ppc_md.heartbeat = gemini_heartbeat;
-	ppc_md.heartbeat_reset = HZ/8;
-	ppc_md.heartbeat_count = 1;
-
-	/* Lookup PCI hosts */
-	gemini_find_bridges();
-	/* take special pains to map the MPIC, since it isn't mapped yet */
-	gemini_openpic_init();
-	/* start the L2 */
-	gemini_init_l2();
-}
-
-
-int
-gemini_get_clock_speed(void)
-{
-	unsigned long hid1, pvr;
-	int clock;
-
-	pvr = mfspr(SPRN_PVR);
-	hid1 = (mfspr(SPRN_HID1) >> 28) & 0xf;
-	if (PVR_VER(pvr) == 8 ||
-	    PVR_VER(pvr) == 12)
-		hid1 = cpu_7xx[hid1];
-	else
-		hid1 = cpu_6xx[hid1];
-
-	switch((readb(GEMINI_BSTAT) & 0xc) >> 2) {
-
-	case 0:
-	default:
-		clock = (hid1*100)/3;
-		break;
-
-	case 1:
-		clock = (hid1*125)/3;
-		break;
-
-	case 2:
-		clock = (hid1*50);
-		break;
-	}
-
-	return clock;
-}
-
-void __init gemini_init_l2(void)
-{
-        unsigned char reg, brev, fam, creg;
-        unsigned long cache;
-        unsigned long pvr;
-
-        reg = readb(GEMINI_L2CFG);
-        brev = readb(GEMINI_BREV);
-        fam = readb(GEMINI_FEAT);
-        pvr = mfspr(SPRN_PVR);
-
-        switch(PVR_VER(pvr)) {
-
-        case 8:
-                if (reg & 0xc0)
-                        cache = (((reg >> 6) & 0x3) << 28);
-                else
-                        cache = 0x3 << 28;
-
-#ifdef CONFIG_SMP
-                /* Pre-3.0 processor revs had snooping errata.  Leave
-                   their L2's disabled with SMP. -- Dan */
-                if (PVR_CFG(pvr) < 3) {
-                        printk("Pre-3.0 750; L2 left disabled!\n");
-                        return;
-                }
-#endif /* CONFIG_SMP */
-
-                /* Special case: VGM5-B's came before L2 ratios were set on
-                   the board.  Processor speed shouldn't be too high, so
-                   set L2 ratio to 1:1.5.  */
-                if ((brev == 0x51) && ((fam & 0xa0) >> 4) == 0)
-                        reg |= 1;
-
-                /* determine best cache ratio based upon what the board
-                   tells us (which sometimes _may_ not be true) and
-                   the processor speed. */
-                else {
-                        if (gemini_get_clock_speed() > 250)
-                                reg = 2;
-                }
-                break;
-        case 12:
-	{
-		static unsigned long l2_size_val = 0;
-
-		if (!l2_size_val)
-			l2_size_val = _get_L2CR();
-		cache = l2_size_val;
-                break;
-	}
-        case 4:
-        case 9:
-                creg = readb(GEMINI_CPUSTAT);
-                if (((creg & 0xc) >> 2) != 1)
-                        printk("Dual-604 boards don't support the use of L2\n");
-                else
-                        writeb(1, GEMINI_L2CFG);
-                return;
-        default:
-                printk("Unknown processor; L2 left disabled\n");
-                return;
-        }
-
-        cache |= ((1<<reg) << 25);
-        cache |= (L2CR_L2RAM_MASK|L2CR_L2CTL|L2CR_L2DO);
-        _set_L2CR(0);
-        _set_L2CR(cache | L2CR_L2E);
-
-}
-
-void
-gemini_restart(char *cmd)
-{
-	local_irq_disable();
-	/* make a clean restart, not via the MPIC */
-	_gemini_reboot();
-	for(;;);
-}
-
-void
-gemini_power_off(void)
-{
-	for(;;);
-}
-
-void
-gemini_halt(void)
-{
-	gemini_restart(NULL);
-}
-
-void __init gemini_init_IRQ(void)
-{
-	/* gemini has no 8259 */
-	openpic_init(1, 0, 0, -1);
-}
-
-#define gemini_rtc_read(x)       (readb(GEMINI_RTC+(x)))
-#define gemini_rtc_write(val,x)  (writeb((val),(GEMINI_RTC+(x))))
-
-/* ensure that the RTC is up and running */
-long __init gemini_time_init(void)
-{
-	unsigned char reg;
-
-	reg = gemini_rtc_read(M48T35_RTC_CONTROL);
-
-	if ( reg & M48T35_RTC_STOPPED ) {
-		printk(KERN_INFO "M48T35 real-time-clock was stopped. Now starting...\n");
-		gemini_rtc_write((reg & ~(M48T35_RTC_STOPPED)), M48T35_RTC_CONTROL);
-		gemini_rtc_write((reg | M48T35_RTC_SET), M48T35_RTC_CONTROL);
-	}
-	return 0;
-}
-
-#undef DEBUG_RTC
-
-unsigned long
-gemini_get_rtc_time(void)
-{
-	unsigned int year, mon, day, hour, min, sec;
-	unsigned char reg;
-
-	reg = gemini_rtc_read(M48T35_RTC_CONTROL);
-	gemini_rtc_write((reg|M48T35_RTC_READ), M48T35_RTC_CONTROL);
-#ifdef DEBUG_RTC
-	printk("get rtc: reg = %x\n", reg);
-#endif
-
-	do {
-		sec = gemini_rtc_read(M48T35_RTC_SECONDS);
-		min = gemini_rtc_read(M48T35_RTC_MINUTES);
-		hour = gemini_rtc_read(M48T35_RTC_HOURS);
-		day = gemini_rtc_read(M48T35_RTC_DOM);
-		mon = gemini_rtc_read(M48T35_RTC_MONTH);
-		year = gemini_rtc_read(M48T35_RTC_YEAR);
-	} while( sec != gemini_rtc_read(M48T35_RTC_SECONDS));
-#ifdef DEBUG_RTC
-	printk("get rtc: sec=%x, min=%x, hour=%x, day=%x, mon=%x, year=%x\n",
-	       sec, min, hour, day, mon, year);
-#endif
-
-	gemini_rtc_write(reg, M48T35_RTC_CONTROL);
-
-	BCD_TO_BIN(sec);
-	BCD_TO_BIN(min);
-	BCD_TO_BIN(hour);
-	BCD_TO_BIN(day);
-	BCD_TO_BIN(mon);
-	BCD_TO_BIN(year);
-
-	if ((year += 1900) < 1970)
-		year += 100;
-#ifdef DEBUG_RTC
-	printk("get rtc: sec=%x, min=%x, hour=%x, day=%x, mon=%x, year=%x\n",
-	       sec, min, hour, day, mon, year);
-#endif
-
-	return mktime( year, mon, day, hour, min, sec );
-}
-
-
-int
-gemini_set_rtc_time( unsigned long now )
-{
-	unsigned char reg;
-	struct rtc_time tm;
-
-	to_tm( now, &tm );
-
-	reg = gemini_rtc_read(M48T35_RTC_CONTROL);
-#ifdef DEBUG_RTC
-	printk("set rtc: reg = %x\n", reg);
-#endif
-
-	gemini_rtc_write((reg|M48T35_RTC_SET), M48T35_RTC_CONTROL);
-#ifdef DEBUG_RTC
-	printk("set rtc: tm vals - sec=%x, min=%x, hour=%x, mon=%x, mday=%x, year=%x\n",
-	       tm.tm_sec, tm.tm_min, tm.tm_hour, tm.tm_mon, tm.tm_mday, tm.tm_year);
-#endif
-
-	tm.tm_year -= 1900;
-	BIN_TO_BCD(tm.tm_sec);
-	BIN_TO_BCD(tm.tm_min);
-	BIN_TO_BCD(tm.tm_hour);
-	BIN_TO_BCD(tm.tm_mon);
-	BIN_TO_BCD(tm.tm_mday);
-	BIN_TO_BCD(tm.tm_year);
-#ifdef DEBUG_RTC
-	printk("set rtc: tm vals - sec=%x, min=%x, hour=%x, mon=%x, mday=%x, year=%x\n",
-	       tm.tm_sec, tm.tm_min, tm.tm_hour, tm.tm_mon, tm.tm_mday, tm.tm_year);
-#endif
-
-	gemini_rtc_write(tm.tm_sec, M48T35_RTC_SECONDS);
-	gemini_rtc_write(tm.tm_min, M48T35_RTC_MINUTES);
-	gemini_rtc_write(tm.tm_hour, M48T35_RTC_HOURS);
-	gemini_rtc_write(tm.tm_mday, M48T35_RTC_DOM);
-	gemini_rtc_write(tm.tm_mon, M48T35_RTC_MONTH);
-	gemini_rtc_write(tm.tm_year, M48T35_RTC_YEAR);
-
-	/* done writing */
-	gemini_rtc_write(reg, M48T35_RTC_CONTROL);
-
-	return 0;
-}
-
-/*  use the RTC to determine the decrementer count */
-void __init gemini_calibrate_decr(void)
-{
-	int freq, divisor;
-	unsigned char reg;
-
-	/* determine processor bus speed */
-	reg = readb(GEMINI_BSTAT);
-
-	switch(((reg & 0x0c)>>2)&0x3) {
-	case 0:
-	default:
-		freq = 66667;
-		break;
-	case 1:
-		freq = 83000;
-		break;
-	case 2:
-		freq = 100000;
-		break;
-	}
-
-	freq *= 1000;
-	divisor = 4;
-	tb_ticks_per_jiffy = freq / HZ / divisor;
-	tb_to_us = mulhwu_scale_factor(freq/divisor, 1000000);
-}
-
-unsigned long __init gemini_find_end_of_memory(void)
-{
-	unsigned long total;
-	unsigned char reg;
-
-	reg = readb(GEMINI_MEMCFG);
-	total = ((1<<((reg & 0x7) - 1)) *
-		 (8<<((reg >> 3) & 0x7)));
-	total *= (1024*1024);
-	return total;
-}
-
-static void __init
-gemini_map_io(void)
-{
-	io_block_mapping(0xf0000000, 0xf0000000, 0x10000000, _PAGE_IO);
-	io_block_mapping(0x80000000, 0x80000000, 0x10000000, _PAGE_IO);
-}
-
-#ifdef CONFIG_SMP
-static int
-smp_gemini_probe(void)
-{
-	int i, nr;
-
-        nr = (readb(GEMINI_CPUSTAT) & GEMINI_CPU_COUNT_MASK) >> 2;
-	if (nr == 0)
-		nr = 4;
-
-	if (nr > 1) {
-		openpic_request_IPIs();
-		for (i = 1; i < nr; ++i)
-			smp_hw_index[i] = i;
-	}
-
-	return nr;
-}
-
-static void
-smp_gemini_kick_cpu(int nr)
-{
-	openpic_reset_processor_phys(1 << nr);
-	openpic_reset_processor_phys(0);
-}
-
-static void
-smp_gemini_setup_cpu(int cpu_nr)
-{
-	if (OpenPIC_Addr)
-		do_openpic_setup_cpu();
-	if (cpu_nr > 0)
-		gemini_init_l2();
-}
-
-static struct smp_ops_t gemini_smp_ops = {
-	smp_openpic_message_pass,
-	smp_gemini_probe,
-	smp_gemini_kick_cpu,
-	smp_gemini_setup_cpu,
-	.give_timebase = smp_generic_give_timebase,
-	.take_timebase = smp_generic_take_timebase,
-};
-#endif /* CONFIG_SMP */
-
-void __init platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
-			  unsigned long r6, unsigned long r7)
-{
-	int i;
-
-	/* Restore BATs for now */
-	mtspr(SPRN_DBAT3U, 0xf0001fff);
-	mtspr(SPRN_DBAT3L, 0xf000002a);
-
-	parse_bootinfo(find_bootinfo());
-
-	for(i = 0; i < GEMINI_LEDS; i++)
-		gemini_led_off(i);
-
-	ISA_DMA_THRESHOLD = 0;
-	DMA_MODE_READ = 0;
-	DMA_MODE_WRITE = 0;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	if ( r4 )
-	{
-		initrd_start = r4 + KERNELBASE;
-		initrd_end = r5 + KERNELBASE;
-	}
-#endif
-
-	ppc_md.setup_arch = gemini_setup_arch;
-	ppc_md.show_cpuinfo = gemini_show_cpuinfo;
-	ppc_md.init_IRQ = gemini_init_IRQ;
-	ppc_md.get_irq = openpic_get_irq;
-	ppc_md.init = NULL;
-
-	ppc_md.restart = gemini_restart;
-	ppc_md.power_off = gemini_power_off;
-	ppc_md.halt = gemini_halt;
-
-	ppc_md.time_init = gemini_time_init;
-	ppc_md.set_rtc_time = gemini_set_rtc_time;
-	ppc_md.get_rtc_time = gemini_get_rtc_time;
-	ppc_md.calibrate_decr = gemini_calibrate_decr;
-
-	ppc_md.find_end_of_memory = gemini_find_end_of_memory;
-	ppc_md.setup_io_mappings = gemini_map_io;
-
-	ppc_md.pcibios_fixup_bus = gemini_pcibios_fixup;
-
-#ifdef CONFIG_SMP
-	smp_ops = &gemini_smp_ops;
-#endif /* CONFIG_SMP */
-}
--- linux-2.6.20-rc1-mm1/arch/ppc/configs/gemini_defconfig	2006-11-29 22:57:37.000000000 +0100
+++ /dev/null	2006-09-19 00:45:31.000000000 +0200
@@ -1,618 +0,0 @@
-#
-# Automatically generated make config: don't edit
-#
-CONFIG_MMU=y
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
-CONFIG_HAVE_DEC_LOCK=y
-
-#
-# Code maturity level options
-#
-CONFIG_EXPERIMENTAL=y
-
-#
-# General setup
-#
-CONFIG_SWAP=y
-CONFIG_SYSVIPC=y
-# CONFIG_BSD_PROCESS_ACCT is not set
-CONFIG_SYSCTL=y
-CONFIG_LOG_BUF_SHIFT=14
-# CONFIG_EMBEDDED is not set
-CONFIG_FUTEX=y
-CONFIG_EPOLL=y
-
-#
-# Loadable module support
-#
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_MODULE_FORCE_UNLOAD is not set
-CONFIG_OBSOLETE_MODPARM=y
-# CONFIG_MODVERSIONS is not set
-CONFIG_KMOD=y
-
-#
-# Platform support
-#
-CONFIG_PPC=y
-CONFIG_PPC32=y
-CONFIG_6xx=y
-# CONFIG_40x is not set
-# CONFIG_POWER3 is not set
-# CONFIG_8xx is not set
-
-#
-# IBM 4xx options
-#
-# CONFIG_8260 is not set
-CONFIG_GENERIC_ISA_DMA=y
-CONFIG_PPC_STD_MMU=y
-# CONFIG_PPC_MULTIPLATFORM is not set
-# CONFIG_APUS is not set
-# CONFIG_WILLOW_2 is not set
-# CONFIG_PCORE is not set
-# CONFIG_POWERPMC250 is not set
-# CONFIG_EV64260 is not set
-# CONFIG_SPRUCE is not set
-# CONFIG_LOPEC is not set
-# CONFIG_MCPN765 is not set
-# CONFIG_MVME5100 is not set
-# CONFIG_PPLUS is not set
-# CONFIG_PRPMC750 is not set
-# CONFIG_PRPMC800 is not set
-# CONFIG_SANDPOINT is not set
-# CONFIG_ADIR is not set
-# CONFIG_K2 is not set
-# CONFIG_PAL4 is not set
-CONFIG_GEMINI=y
-# CONFIG_SMP is not set
-# CONFIG_PREEMPT is not set
-CONFIG_ALTIVEC=y
-CONFIG_TAU=y
-# CONFIG_TAU_INT is not set
-# CONFIG_TAU_AVERAGE is not set
-# CONFIG_CPU_FREQ is not set
-
-#
-# General setup
-#
-# CONFIG_HIGHMEM is not set
-CONFIG_PCI=y
-CONFIG_PCI_DOMAINS=y
-CONFIG_KCORE_ELF=y
-CONFIG_BINFMT_ELF=y
-CONFIG_KERNEL_ELF=y
-# CONFIG_BINFMT_MISC is not set
-CONFIG_PCI_LEGACY_PROC=y
-CONFIG_PCI_NAMES=y
-# CONFIG_HOTPLUG is not set
-
-#
-# Parallel port support
-#
-# CONFIG_PARPORT is not set
-# CONFIG_PPC601_SYNC_FIX is not set
-# CONFIG_CMDLINE_BOOL is not set
-
-#
-# Advanced setup
-#
-# CONFIG_ADVANCED_OPTIONS is not set
-
-#
-# Default settings for advanced configuration options are used
-#
-CONFIG_HIGHMEM_START=0xfe000000
-CONFIG_LOWMEM_SIZE=0x30000000
-CONFIG_KERNEL_START=0xc0000000
-CONFIG_TASK_SIZE=0x80000000
-CONFIG_BOOT_LOAD=0x00800000
-
-#
-# Memory Technology Devices (MTD)
-#
-# CONFIG_MTD is not set
-
-#
-# Plug and Play support
-#
-# CONFIG_PNP is not set
-
-#
-# Block devices
-#
-# CONFIG_BLK_DEV_FD is not set
-# CONFIG_BLK_CPQ_DA is not set
-# CONFIG_BLK_CPQ_CISS_DA is not set
-# CONFIG_BLK_DEV_DAC960 is not set
-# CONFIG_BLK_DEV_UMEM is not set
-# CONFIG_BLK_DEV_LOOP is not set
-# CONFIG_BLK_DEV_NBD is not set
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=4096
-CONFIG_BLK_DEV_INITRD=y
-
-#
-# Multi-device support (RAID and LVM)
-#
-# CONFIG_MD is not set
-
-#
-# ATA/IDE/MFM/RLL support
-#
-# CONFIG_IDE is not set
-
-#
-# SCSI support
-#
-CONFIG_SCSI=y
-
-#
-# SCSI support type (disk, tape, CD-ROM)
-#
-CONFIG_BLK_DEV_SD=y
-# CONFIG_CHR_DEV_ST is not set
-# CONFIG_CHR_DEV_OSST is not set
-CONFIG_BLK_DEV_SR=y
-CONFIG_BLK_DEV_SR_VENDOR=y
-CONFIG_CHR_DEV_SG=y
-
-#
-# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
-#
-# CONFIG_SCSI_MULTI_LUN is not set
-# CONFIG_SCSI_REPORT_LUNS is not set
-CONFIG_SCSI_CONSTANTS=y
-# CONFIG_SCSI_LOGGING is not set
-
-#
-# SCSI low-level drivers
-#
-# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
-# CONFIG_SCSI_ACARD is not set
-# CONFIG_SCSI_AACRAID is not set
-# CONFIG_SCSI_AIC7XXX is not set
-# CONFIG_SCSI_AIC7XXX_OLD is not set
-# CONFIG_SCSI_AIC79XX is not set
-# CONFIG_SCSI_DPT_I2O is not set
-# CONFIG_SCSI_ADVANSYS is not set
-# CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_AM53C974 is not set
-# CONFIG_SCSI_MEGARAID is not set
-# CONFIG_SCSI_BUSLOGIC is not set
-# CONFIG_SCSI_CPQFCTS is not set
-# CONFIG_SCSI_DMX3191D is not set
-# CONFIG_SCSI_EATA is not set
-# CONFIG_SCSI_EATA_PIO is not set
-# CONFIG_SCSI_FUTURE_DOMAIN is not set
-# CONFIG_SCSI_GDTH is not set
-# CONFIG_SCSI_GENERIC_NCR5380 is not set
-# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
-# CONFIG_SCSI_INITIO is not set
-# CONFIG_SCSI_INIA100 is not set
-# CONFIG_SCSI_NCR53C7xx is not set
-CONFIG_SCSI_SYM53C8XX_2=y
-CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
-CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
-CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
-# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
-# CONFIG_SCSI_PCI2000 is not set
-# CONFIG_SCSI_PCI2220I is not set
-# CONFIG_SCSI_QLOGIC_ISP is not set
-# CONFIG_SCSI_QLOGIC_FC is not set
-# CONFIG_SCSI_QLOGIC_1280 is not set
-# CONFIG_SCSI_DC395x is not set
-# CONFIG_SCSI_DC390T is not set
-# CONFIG_SCSI_U14_34F is not set
-# CONFIG_SCSI_NSP32 is not set
-# CONFIG_SCSI_DEBUG is not set
-
-#
-# Fusion MPT device support
-#
-# CONFIG_FUSION is not set
-
-#
-# IEEE 1394 (FireWire) support (EXPERIMENTAL)
-#
-# CONFIG_IEEE1394 is not set
-
-#
-# I2O device support
-#
-# CONFIG_I2O is not set
-
-#
-# Networking support
-#
-CONFIG_NET=y
-
-#
-# Networking options
-#
-CONFIG_PACKET=y
-# CONFIG_PACKET_MMAP is not set
-# CONFIG_NETLINK_DEV is not set
-CONFIG_NETFILTER=y
-# CONFIG_NETFILTER_DEBUG is not set
-CONFIG_UNIX=y
-# CONFIG_NET_KEY is not set
-CONFIG_INET=y
-# CONFIG_IP_MULTICAST is not set
-# CONFIG_IP_ADVANCED_ROUTER is not set
-# CONFIG_IP_PNP is not set
-# CONFIG_NET_IPIP is not set
-# CONFIG_NET_IPGRE is not set
-# CONFIG_ARPD is not set
-# CONFIG_INET_ECN is not set
-# CONFIG_SYN_COOKIES is not set
-# CONFIG_INET_AH is not set
-# CONFIG_INET_ESP is not set
-# CONFIG_INET_IPCOMP is not set
-
-#
-# IP: Netfilter Configuration
-#
-# CONFIG_IP_NF_CONNTRACK is not set
-# CONFIG_IP_NF_QUEUE is not set
-# CONFIG_IP_NF_IPTABLES is not set
-# CONFIG_IP_NF_ARPTABLES is not set
-# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
-# CONFIG_IP_NF_COMPAT_IPFWADM is not set
-# CONFIG_IPV6 is not set
-# CONFIG_XFRM_USER is not set
-
-#
-# SCTP Configuration (EXPERIMENTAL)
-#
-CONFIG_IPV6_SCTP__=y
-# CONFIG_IP_SCTP is not set
-# CONFIG_ATM is not set
-# CONFIG_VLAN_8021Q is not set
-# CONFIG_LLC is not set
-# CONFIG_DECNET is not set
-# CONFIG_BRIDGE is not set
-# CONFIG_X25 is not set
-# CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
-# CONFIG_ECONET is not set
-# CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
-
-#
-# QoS and/or fair queueing
-#
-# CONFIG_NET_SCHED is not set
-
-#
-# Network testing
-#
-# CONFIG_NET_PKTGEN is not set
-CONFIG_NETDEVICES=y
-
-#
-# ARCnet devices
-#
-# CONFIG_ARCNET is not set
-# CONFIG_DUMMY is not set
-# CONFIG_BONDING is not set
-# CONFIG_EQUALIZER is not set
-# CONFIG_TUN is not set
-# CONFIG_ETHERTAP is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
-CONFIG_NET_ETHERNET=y
-# CONFIG_MII is not set
-# CONFIG_OAKNET is not set
-# CONFIG_HAPPYMEAL is not set
-# CONFIG_SUNGEM is not set
-# CONFIG_NET_VENDOR_3COM is not set
-
-#
-# Tulip family network device support
-#
-# CONFIG_NET_TULIP is not set
-# CONFIG_HP100 is not set
-# CONFIG_NET_PCI is not set
-
-#
-# Ethernet (1000 Mbit)
-#
-# CONFIG_ACENIC is not set
-# CONFIG_DL2K is not set
-# CONFIG_E1000 is not set
-# CONFIG_NS83820 is not set
-# CONFIG_HAMACHI is not set
-# CONFIG_YELLOWFIN is not set
-# CONFIG_R8169 is not set
-# CONFIG_SK98LIN is not set
-# CONFIG_TIGON3 is not set
-
-#
-# Ethernet (10000 Mbit)
-#
-# CONFIG_IXGB is not set
-# CONFIG_FDDI is not set
-# CONFIG_HIPPI is not set
-# CONFIG_PPP is not set
-# CONFIG_SLIP is not set
-
-#
-# Wireless LAN (non-hamradio)
-#
-# CONFIG_NET_RADIO is not set
-
-#
-# Token Ring devices (depends on LLC=y)
-#
-# CONFIG_NET_FC is not set
-# CONFIG_RCPCI is not set
-# CONFIG_SHAPER is not set
-
-#
-# Wan interfaces
-#
-# CONFIG_WAN is not set
-
-#
-# Amateur Radio support
-#
-# CONFIG_HAMRADIO is not set
-
-#
-# IrDA (infrared) support
-#
-# CONFIG_IRDA is not set
-
-#
-# ISDN subsystem
-#
-# CONFIG_ISDN_BOOL is not set
-
-#
-# Graphics support
-#
-# CONFIG_FB is not set
-
-#
-# Old CD-ROM drivers (not SCSI, not IDE)
-#
-# CONFIG_CD_NO_IDESCSI is not set
-
-#
-# Input device support
-#
-# CONFIG_INPUT is not set
-
-#
-# Userland interfaces
-#
-
-#
-# Input I/O drivers
-#
-# CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
-# CONFIG_SERIO is not set
-
-#
-# Input Device Drivers
-#
-
-#
-# Macintosh device drivers
-#
-
-#
-# Character devices
-#
-# CONFIG_SERIAL_NONSTANDARD is not set
-
-#
-# Serial drivers
-#
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-# CONFIG_SERIAL_8250_EXTENDED is not set
-
-#
-# Non-8250 serial port support
-#
-CONFIG_SERIAL_CORE=y
-CONFIG_SERIAL_CORE_CONSOLE=y
-CONFIG_UNIX98_PTYS=y
-CONFIG_UNIX98_PTY_COUNT=256
-
-#
-# I2C support
-#
-# CONFIG_I2C is not set
-
-#
-# I2C Hardware Sensors Mainboard support
-#
-
-#
-# I2C Hardware Sensors Chip support
-#
-# CONFIG_I2C_SENSOR is not set
-
-#
-# Mice
-#
-# CONFIG_BUSMOUSE is not set
-# CONFIG_QIC02_TAPE is not set
-
-#
-# IPMI
-#
-# CONFIG_IPMI_HANDLER is not set
-
-#
-# Watchdog Cards
-#
-# CONFIG_WATCHDOG is not set
-# CONFIG_NVRAM is not set
-CONFIG_GEN_RTC=y
-# CONFIG_GEN_RTC_X is not set
-# CONFIG_DTLK is not set
-# CONFIG_R3964 is not set
-# CONFIG_APPLICOM is not set
-
-#
-# Ftape, the floppy tape device driver
-#
-# CONFIG_FTAPE is not set
-# CONFIG_AGP is not set
-# CONFIG_DRM is not set
-# CONFIG_RAW_DRIVER is not set
-# CONFIG_HANGCHECK_TIMER is not set
-
-#
-# Multimedia devices
-#
-# CONFIG_VIDEO_DEV is not set
-
-#
-# Digital Video Broadcasting Devices
-#
-# CONFIG_DVB is not set
-
-#
-# File systems
-#
-CONFIG_EXT2_FS=y
-# CONFIG_EXT2_FS_XATTR is not set
-# CONFIG_EXT3_FS is not set
-# CONFIG_JBD is not set
-# CONFIG_REISERFS_FS is not set
-# CONFIG_JFS_FS is not set
-# CONFIG_XFS_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_ROMFS_FS is not set
-# CONFIG_QUOTA is not set
-# CONFIG_AUTOFS_FS is not set
-# CONFIG_AUTOFS4_FS is not set
-
-#
-# CD-ROM/DVD Filesystems
-#
-CONFIG_ISO9660_FS=y
-# CONFIG_JOLIET is not set
-# CONFIG_ZISOFS is not set
-# CONFIG_UDF_FS is not set
-
-#
-# DOS/FAT/NT Filesystems
-#
-# CONFIG_FAT_FS is not set
-# CONFIG_NTFS_FS is not set
-
-#
-# Pseudo filesystems
-#
-CONFIG_PROC_FS=y
-CONFIG_DEVFS_FS=y
-# CONFIG_DEVFS_MOUNT is not set
-# CONFIG_DEVFS_DEBUG is not set
-CONFIG_DEVPTS_FS=y
-# CONFIG_DEVPTS_FS_XATTR is not set
-CONFIG_TMPFS=y
-CONFIG_RAMFS=y
-
-#
-# Miscellaneous filesystems
-#
-# CONFIG_ADFS_FS is not set
-# CONFIG_AFFS_FS is not set
-# CONFIG_HFS_FS is not set
-# CONFIG_BEFS_FS is not set
-# CONFIG_BFS_FS is not set
-# CONFIG_EFS_FS is not set
-# CONFIG_CRAMFS is not set
-# CONFIG_VXFS_FS is not set
-# CONFIG_HPFS_FS is not set
-# CONFIG_QNX4FS_FS is not set
-# CONFIG_SYSV_FS is not set
-# CONFIG_UFS_FS is not set
-
-#
-# Network File Systems
-#
-CONFIG_NFS_FS=y
-# CONFIG_NFS_V3 is not set
-# CONFIG_NFS_V4 is not set
-CONFIG_NFSD=y
-# CONFIG_NFSD_V3 is not set
-# CONFIG_NFSD_TCP is not set
-CONFIG_LOCKD=y
-CONFIG_EXPORTFS=y
-CONFIG_SUNRPC=y
-# CONFIG_SUNRPC_GSS is not set
-# CONFIG_SMB_FS is not set
-# CONFIG_CIFS is not set
-# CONFIG_NCP_FS is not set
-# CONFIG_CODA_FS is not set
-# CONFIG_INTERMEZZO_FS is not set
-# CONFIG_AFS_FS is not set
-
-#
-# Partition Types
-#
-CONFIG_PARTITION_ADVANCED=y
-# CONFIG_ACORN_PARTITION is not set
-# CONFIG_OSF_PARTITION is not set
-# CONFIG_AMIGA_PARTITION is not set
-# CONFIG_ATARI_PARTITION is not set
-# CONFIG_MAC_PARTITION is not set
-CONFIG_MSDOS_PARTITION=y
-# CONFIG_BSD_DISKLABEL is not set
-# CONFIG_MINIX_SUBPARTITION is not set
-CONFIG_SOLARIS_X86_PARTITION=y
-# CONFIG_UNIXWARE_DISKLABEL is not set
-# CONFIG_LDM_PARTITION is not set
-# CONFIG_NEC98_PARTITION is not set
-# CONFIG_SGI_PARTITION is not set
-# CONFIG_ULTRIX_PARTITION is not set
-# CONFIG_SUN_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
-
-#
-# Sound
-#
-# CONFIG_SOUND is not set
-
-#
-# USB support
-#
-# CONFIG_USB is not set
-# CONFIG_USB_GADGET is not set
-
-#
-# Bluetooth support
-#
-# CONFIG_BT is not set
-
-#
-# Library routines
-#
-# CONFIG_CRC32 is not set
-
-#
-# Kernel hacking
-#
-# CONFIG_DEBUG_KERNEL is not set
-# CONFIG_KALLSYMS is not set
-
-#
-# Security options
-#
-# CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
-# CONFIG_CRYPTO is not set

