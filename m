Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268589AbUHaOLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268589AbUHaOLk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 10:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268591AbUHaOLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 10:11:40 -0400
Received: from frog.mt.lv ([159.148.172.197]:25558 "EHLO frog.mt.lv")
	by vger.kernel.org with ESMTP id S268589AbUHaOKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 10:10:48 -0400
From: Dmitry Golubev <dmitry@mikrotik.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] embedding 2.6 or more findings on kernel size
Date: Tue, 31 Aug 2004 17:10:01 +0300
User-Agent: KMail/1.6.2
References: <200408302307.35052.dmitry@mikrotik.com>
In-Reply-To: <200408302307.35052.dmitry@mikrotik.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5aINBTKNKF+/s9u"
Message-Id: <200408311710.01601.dmitry@mikrotik.com>
X-mikrotik.com-Virus_kerajs: Not scanned.
X-mikrotik.com-Virus_un_spam-kerajs: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_5aINBTKNKF+/s9u
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here is the patch for the reported problems. Additional research may follow...

Dmitry

On Monday 30 August 2004 23:07, Dmitry Golubev <dmitry@mikrotik.com> wrote:
> Hello,
>
> Compiling the 2.6.8.1 kernel, I found three interesting places (looking
> very quickly, perhaps would find more) when the kernel was compiled with
> unused parts:
>
> 1. it compiles everything inside /arch/i386/kernel/cpu/ . From my point of
> view, that is incorrect, especially when choosing processor like Cyrix/VIA
> C3 (which is a cyrix, not a transmeta, nexgen or something else) and
> explicitly specifying not to make generic x86 code. Perhaps, choice should
> be given. About 15KB of memory wasted on this...
>
> 2. then I found it to compile a synaptics touchpad support - also must be
> optional. Another something like 8KB
>
> 3. and the third thing I found is that scsi_ioctl is compiled even if SCSI
> support is taken out... very interesting behaviour... another like 8KB
> wasted... I have no SCSI, no USB MassStorage, no CD-RW, no nothing could
> possibly use SCSI...
>
>
> Many things could be put on about 100-200KB spared if not migrating to
> 2.6... Perhaps, more controls should be available to configure - new
> kernels should be smaller and faster, not larger, shouldn't they?
>
> Thanks,
> Dmitry

--Boundary-00=_5aINBTKNKF+/s9u
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -Naur -X ./patt ./linux-2.6.8.1/arch/i386/Kconfig ./linux-2.6.8.1_new/arch/i386/Kconfig
--- ./linux-2.6.8.1/arch/i386/Kconfig	2004-08-14 13:54:50.000000000 +0300
+++ ./linux-2.6.8.1_new/arch/i386/Kconfig	2004-08-31 15:19:02.000000000 +0300
@@ -321,6 +321,46 @@
 
 endchoice
 
+menu "Specific x86 vendor support"
+	depends on X86
+	
+config X86_CPU_VENDOR_AMD
+	bool "Advanced Micro Devices"
+	default y
+
+config X86_CPU_VENDOR_CYRIX
+	bool "Cyrix | VIA | National Semiconductor"
+	default y
+
+config X86_CPU_VENDOR_CENTAUR
+	bool "Centaur Technology"
+	default y
+	help
+	  This option enables support for Centaur C6 (IDT WinChip) 
+	  processor family.
+
+config X86_CPU_VENDOR_TRANSMETA
+	bool "Transmeta Crusoe"
+	default y
+
+config X86_CPU_VENDOR_INTEL
+	bool "Intel"
+	default y
+
+config X86_CPU_VENDOR_RISE
+	bool "Rise Technology"
+	default y
+
+config X86_CPU_VENDOR_NEXGEN
+	bool "NexGen"
+	default y
+
+config X86_CPU_VENDOR_UMC
+	bool "UMC Green CPUs"
+	default y
+
+endmenu
+
 config X86_GENERIC
        bool "Generic x86 support" 
        help
@@ -492,6 +532,15 @@
 	  cost of slightly increased overhead in some places. If unsure say
 	  N here.
 
+config PPRO_RAM_BUG
+	bool "Pentium PRO memory bug workaround"
+	depends on X86_CRU_VENDOR_INTEL
+	default n
+	help
+	  This option enables early probe support logic for Intel Pentium PRO
+	  memory erratum #50. If you do not have Pentium PRO processor, it is 
+	  safe to say N here. 
+
 config PREEMPT
 	bool "Preemptible Kernel"
 	help
@@ -813,6 +862,22 @@
 
 	  See <file:Documentation/mtrr.txt> for more information.
 
+# Configure MTRR options implied by vendor
+config MTRR_AMD
+	bool
+	depends on X86_CPU_VENDOR_AMD && MTRR
+	default y 
+
+config MTRR_CYRIX
+	bool
+	depends on X86_CPU_VENDOR_CYRIX && MTRR
+	default y
+
+config MTRR_CENTAUR
+	bool
+	depends on X86_CPU_VENDOR_CENTAUR && MTRR
+	default y
+	
 config EFI
 	bool "Boot from EFI support (EXPERIMENTAL)"
 	depends on ACPI
diff -Naur -X ./patt ./linux-2.6.8.1/arch/i386/kernel/cpu/Makefile ./linux-2.6.8.1_new/arch/i386/kernel/cpu/Makefile
--- ./linux-2.6.8.1/arch/i386/kernel/cpu/Makefile	2004-08-14 13:55:33.000000000 +0300
+++ ./linux-2.6.8.1_new/arch/i386/kernel/cpu/Makefile	2004-08-31 14:36:59.000000000 +0300
@@ -4,14 +4,14 @@
 
 obj-y	:=	common.o proc.o
 
-obj-y	+=	amd.o
-obj-y	+=	cyrix.o
-obj-y	+=	centaur.o
-obj-y	+=	transmeta.o
-obj-y	+=	intel.o
-obj-y	+=	rise.o
-obj-y	+=	nexgen.o
-obj-y	+=	umc.o
+obj-$(CONFIG_X86_CPU_VENDOR_AMD)	+=	amd.o
+obj-$(CONFIG_X86_CPU_VENDOR_CYRIX)	+=	cyrix.o
+obj-$(CONFIG_X86_CPU_VENDOR_CENTAUR)	+=	centaur.o
+obj-$(CONFIG_X86_CPU_VENDOR_TRANSMETA)	+=	transmeta.o
+obj-$(CONFIG_X86_CPU_VENDOR_INTEL)	+=	intel.o
+obj-$(CONFIG_X86_CPU_VENDOR_RISE)	+=	rise.o
+obj-$(CONFIG_X86_CPU_VENDOR_NEXGEN)	+=	nexgen.o
+obj-$(CONFIG_X86_CPU_VENDOR_UMC)	+=	umc.o
 
 obj-$(CONFIG_X86_MCE)	+=	mcheck/
 
diff -Naur -X ./patt ./linux-2.6.8.1/arch/i386/kernel/cpu/common.c ./linux-2.6.8.1_new/arch/i386/kernel/cpu/common.c
--- ./linux-2.6.8.1/arch/i386/kernel/cpu/common.c	2004-08-14 13:54:48.000000000 +0300
+++ ./linux-2.6.8.1_new/arch/i386/kernel/cpu/common.c	2004-08-31 14:51:58.000000000 +0300
@@ -228,8 +228,9 @@
 		if (cap0 & (1<<19))
 			c->x86_cache_alignment = ((misc >> 8) & 0xff) * 8;
 	}
-
+#ifdef CONFIG_X86_CPU_VENDOR_INTEL
 	early_intel_workaround(c);
+#endif	
 }
 
 void __init generic_identify(struct cpuinfo_x86 * c)
@@ -460,28 +461,84 @@
  * Then, when cpu_init() is called, we can just iterate over that array.
  */
 
+#ifdef CONFIG_X86_CPU_VENDOR_INTEL
+
 extern int intel_cpu_init(void);
+
+#endif
+
+#ifdef CONFIG_X86_CPU_VENDOR_CYRIX
+
 extern int cyrix_init_cpu(void);
 extern int nsc_init_cpu(void);
+
+#endif
+
+#ifdef CONFIG_X86_CPU_VENDOR_AMD
+
 extern int amd_init_cpu(void);
+
+#endif
+
+#ifdef CONFIG_X86_CPU_VENDOR_CENTAUR
+
 extern int centaur_init_cpu(void);
+
+#endif
+
+#ifdef CONFIG_X86_CPU_VENDOR_TRANSMETA
+
 extern int transmeta_init_cpu(void);
+
+#endif
+
+#ifdef CONFIG_X86_CPU_VENDOR_RISE
+
 extern int rise_init_cpu(void);
+
+#endif
+
+#ifdef CONFIG_X86_CPU_VENDOR_NEXGEN
+
 extern int nexgen_init_cpu(void);
+
+#endif
+
+#ifdef CONFIG_X86_CPU_VENDOR_UMC
+
 extern int umc_init_cpu(void);
+
+#endif
+
 void early_cpu_detect(void);
 
 void __init early_cpu_init(void)
 {
+#ifdef CONFIG_X86_CPU_VENDOR_INTEL
 	intel_cpu_init();
+#endif
+#ifdef CONFIG_X86_CPU_VENDOR_CYRIX
 	cyrix_init_cpu();
 	nsc_init_cpu();
+#endif
+#ifdef CONFIG_X86_CPU_VENDOR_AMD
 	amd_init_cpu();
+#endif
+#ifdef CONFIG_X86_CPU_VENDOR_CENTAUR
 	centaur_init_cpu();
+#endif
+#ifdef CONFIG_X86_CPU_VENDOR_TRANSMETA
 	transmeta_init_cpu();
+#endif
+#ifdef CONFIG_X86_CPU_VENDOR_RISE
 	rise_init_cpu();
+#endif
+#ifdef CONFIG_X86_CPU_VENDOR_NEXGEN
 	nexgen_init_cpu();
+#endif
+#ifdef CONFIG_X86_CPU_VENDOR_UMC
 	umc_init_cpu();
+#endif
 	early_cpu_detect();
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
diff -Naur -X ./patt ./linux-2.6.8.1/arch/i386/kernel/cpu/intel.c ./linux-2.6.8.1_new/arch/i386/kernel/cpu/intel.c
--- ./linux-2.6.8.1/arch/i386/kernel/cpu/intel.c	2004-08-14 13:55:09.000000000 +0300
+++ ./linux-2.6.8.1_new/arch/i386/kernel/cpu/intel.c	2004-08-31 13:50:49.000000000 +0300
@@ -43,6 +43,8 @@
  *	This is called before we do cpu ident work
  */
  
+#ifdef CONFIG_PPRO_RAM_BUG 
+
 int __init ppro_with_ram_bug(void)
 {
 	/* Uses data from early_cpu_detect now */
@@ -55,6 +57,8 @@
 	}
 	return 0;
 }
+#endif
+
 	
 #define LVL_1_INST	1
 #define LVL_1_DATA	2
diff -Naur -X ./patt ./linux-2.6.8.1/arch/i386/kernel/cpu/mtrr/Makefile ./linux-2.6.8.1_new/arch/i386/kernel/cpu/mtrr/Makefile
--- ./linux-2.6.8.1/arch/i386/kernel/cpu/mtrr/Makefile	2004-08-14 13:54:47.000000000 +0300
+++ ./linux-2.6.8.1_new/arch/i386/kernel/cpu/mtrr/Makefile	2004-08-31 14:00:20.000000000 +0300
@@ -1,5 +1,4 @@
 obj-y		:= main.o if.o generic.o state.o
-obj-y		+= amd.o
-obj-y		+= cyrix.o
-obj-y		+= centaur.o
-
+obj-$(CONFIG_MTRR_AMD)		+= amd.o
+obj-$(CONFIG_MTRR_CYRIX)	+= cyrix.o
+obj-$(CONFIG_MTRR_CENTAUR)	+= centaur.o
diff -Naur -X ./patt ./linux-2.6.8.1/arch/i386/kernel/cpu/mtrr/main.c ./linux-2.6.8.1_new/arch/i386/kernel/cpu/mtrr/main.c
--- ./linux-2.6.8.1/arch/i386/kernel/cpu/mtrr/main.c	2004-08-14 13:54:48.000000000 +0300
+++ ./linux-2.6.8.1_new/arch/i386/kernel/cpu/mtrr/main.c	2004-08-31 16:05:13.000000000 +0300
@@ -536,9 +536,15 @@
 
 static void __init init_ifs(void)
 {
+#ifdef CONFIG_MTRR_AMD
 	amd_init_mtrr();
+#endif
+#ifdef CONFIG_MTRR_CYRIX
 	cyrix_init_mtrr();
+#endif
+#ifdef CONFIG_MTRR_CENTAUR
 	centaur_init_mtrr();
+#endif
 }
 
 static void __init init_other_cpus(void)
diff -Naur -X ./patt ./linux-2.6.8.1/arch/i386/mm/init.c ./linux-2.6.8.1_new/arch/i386/mm/init.c
--- ./linux-2.6.8.1/arch/i386/mm/init.c	2004-08-14 13:55:48.000000000 +0300
+++ ./linux-2.6.8.1_new/arch/i386/mm/init.c	2004-08-31 14:53:49.000000000 +0300
@@ -563,7 +563,12 @@
 
 void __init mem_init(void)
 {
+#ifdef CONFIG_PPRO_RAM_BUG 
+
 	extern int ppro_with_ram_bug(void);
+
+#endif
+
 	int codesize, reservedpages, datasize, initsize;
 	int tmp;
 	int bad_ppro;
@@ -572,9 +577,17 @@
 	if (!mem_map)
 		BUG();
 #endif
+
+#ifdef CONFIG_PPRO_RAM_BUG 
 	
 	bad_ppro = ppro_with_ram_bug();
 
+#else
+
+	bad_ppro=0;
+
+#endif
+
 #ifdef CONFIG_HIGHMEM
 	/* check that fixmap and pkmap do not overlap */
 	if (PKMAP_BASE+LAST_PKMAP*PAGE_SIZE >= FIXADDR_START) {
diff -Naur -X ./patt ./linux-2.6.8.1/drivers/block/Makefile ./linux-2.6.8.1_new/drivers/block/Makefile
--- ./linux-2.6.8.1/drivers/block/Makefile	2004-08-14 13:55:59.000000000 +0300
+++ ./linux-2.6.8.1_new/drivers/block/Makefile	2004-08-31 16:19:47.000000000 +0300
@@ -13,7 +13,9 @@
 # kblockd threads
 #
 
-obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o
+obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o
+
+obj-$(CONFIG_SCSI_IOCTL) += scsi_ioctl.o
 
 obj-$(CONFIG_IOSCHED_NOOP)	+= noop-iosched.o
 obj-$(CONFIG_IOSCHED_AS)	+= as-iosched.o
diff -Naur -X ./patt ./linux-2.6.8.1/drivers/input/mouse/Kconfig ./linux-2.6.8.1_new/drivers/input/mouse/Kconfig
--- ./linux-2.6.8.1/drivers/input/mouse/Kconfig	2004-08-14 13:56:00.000000000 +0300
+++ ./linux-2.6.8.1_new/drivers/input/mouse/Kconfig	2004-08-31 16:41:21.000000000 +0300
@@ -124,9 +124,16 @@
 	select SERIO
 	help
 	  Say Y (or M) if you want to use a DEC VSXXX-AA (hockey
-	  puck) or a VSXXX-GA (rectangular) mouse. Theses mice are
+	  puck) or a VSXXX-GA (rectangular) mouse. These mice are
 	  typically used on DECstations or VAXstations, but can also
 	  be used on any box capable of RS232 (with some adaptor
 	  described in the source file). This driver should, in theory,
 	  also work with the digitizer DEC produced, but it isn't tested
 	  with that (I don't have the hardware yet).
+
+config MOUSE_SYNAPTICS
+	bool "Synaptics TouchPad support"
+	depends on INPUT && INPUT_MOUSE
+	help
+	  Say Y if you want Synaptics TouchPad support compiled in your
+	  kernel. This will increase the kernel size by approximately 8KB.
\ No newline at end of file
diff -Naur -X ./patt ./linux-2.6.8.1/drivers/input/mouse/Makefile ./linux-2.6.8.1_new/drivers/input/mouse/Makefile
--- ./linux-2.6.8.1/drivers/input/mouse/Makefile	2004-08-14 13:54:51.000000000 +0300
+++ ./linux-2.6.8.1_new/drivers/input/mouse/Makefile	2004-08-31 16:42:14.000000000 +0300
@@ -14,4 +14,6 @@
 obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
 obj-$(CONFIG_MOUSE_VSXXXAA)	+= vsxxxaa.o
 
-psmouse-objs  := psmouse-base.o logips2pp.o synaptics.o
+psmouse-objs  := psmouse-base.o logips2pp.o
+
+obj-$(CONFIG_MOUSE_SYNAPTICS)	+= synaptics.o
diff -Naur -X ./patt ./linux-2.6.8.1/drivers/input/mouse/psmouse-base.c ./linux-2.6.8.1_new/drivers/input/mouse/psmouse-base.c
--- ./linux-2.6.8.1/drivers/input/mouse/psmouse-base.c	2004-08-14 13:54:51.000000000 +0300
+++ ./linux-2.6.8.1_new/drivers/input/mouse/psmouse-base.c	2004-08-31 16:46:23.000000000 +0300
@@ -413,6 +413,9 @@
 static int psmouse_extensions(struct psmouse *psmouse,
 			      unsigned int max_proto, int set_properties)
 {
+
+#ifdef CONFIG_MOUSE_SYNAPTICS
+
 	int synaptics_hardware = 0;
 
 /*
@@ -442,6 +445,8 @@
 		synaptics_reset(psmouse);
 	}
 
+#endif
+
 	if (max_proto > PSMOUSE_IMEX && genius_detect(psmouse)) {
 
 		if (set_properties) {
@@ -489,6 +494,9 @@
  * Okay, all failed, we have a standard mouse here. The number of the buttons
  * is still a question, though. We assume 3.
  */
+
+#ifdef CONFIG_MOUSE_SYNAPTICS
+
 	if (synaptics_hardware) {
 /*
  * We detected Synaptics hardware but it did not respond to IMPS/2 probes.
@@ -500,6 +508,8 @@
 		psmouse_command(psmouse, NULL, PSMOUSE_CMD_RESET_DIS);
 	}
 
+#endif
+
 	return PSMOUSE_PS2;
 }
 
diff -Naur -X ./patt ./linux-2.6.8.1/drivers/scsi/Kconfig ./linux-2.6.8.1_new/drivers/scsi/Kconfig
--- ./linux-2.6.8.1/drivers/scsi/Kconfig	2004-08-14 13:56:14.000000000 +0300
+++ ./linux-2.6.8.1_new/drivers/scsi/Kconfig	2004-08-31 16:35:10.000000000 +0300
@@ -21,6 +21,13 @@
 	  However, do not compile this as a module if your root file system
 	  (the one containing the directory /) is located on a SCSI device.
 
+config SCSI_IOCTL
+	bool "SCSI IOCTL infrastructure support (READ HELP)"
+	default y
+	help
+	  This option enables SCSI IOCTL infrastructure support needed even
+	  for some non-SCSI devices. Normally you should say Y.
+
 config SCSI_PROC_FS
 	bool "legacy /proc/scsi/ support"
 	depends on SCSI && PROC_FS

--Boundary-00=_5aINBTKNKF+/s9u--
