Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264851AbUF1HVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264851AbUF1HVY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 03:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264855AbUF1HVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 03:21:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:10437 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264851AbUF1HUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 03:20:39 -0400
Date: Mon, 28 Jun 2004 00:19:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm3 [broken serial console and Kernel BUG on dual
 Opteron]
Message-Id: <20040628001935.37b19aa2.akpm@osdl.org>
In-Reply-To: <200406271338.30803.rjwysocki@sisk.pl>
References: <20040626233105.0c1375b2.akpm@osdl.org>
	<200406271338.30803.rjwysocki@sisk.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"R. J. Wysocki" <rjwysocki@sisk.pl> wrote:
>
>  On Sunday 27 of June 2004 08:31, Andrew Morton wrote:
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-m
>  >m3/
> 
>  I see the following: (in the order of importance - to me ;-)):
> 
>  1) Serial console does not work (at all), but earlyprintk _does_ (output goes 
>  to tty0 after earlyprintk has finished).
> 
>  Please, fix the serial console ASAP.  It's a pain to hand-rewrite call traces 

erk, sorry, I thought the x86_64 console= parsing breakage had been fixed.

The below should get you going again while we remember what the problem was.


diff -puN arch/alpha/kernel/setup.c~a arch/alpha/kernel/setup.c
--- 25/arch/alpha/kernel/setup.c~a	2004-06-28 00:08:52.025672160 -0700
+++ 25-akpm/arch/alpha/kernel/setup.c	2004-06-28 00:08:58.851634456 -0700
@@ -123,6 +123,7 @@ static void get_sysnames(unsigned long, 
 static void determine_cpu_caches (unsigned int);
 
 static char command_line[COMMAND_LINE_SIZE];
+char saved_command_line[COMMAND_LINE_SIZE];
 
 /*
  * The format of "screen_info" is strange, and due to early
diff -puN arch/arm26/kernel/setup.c~a arch/arm26/kernel/setup.c
--- 25/arch/arm26/kernel/setup.c~a	2004-06-28 00:08:52.082663496 -0700
+++ 25-akpm/arch/arm26/kernel/setup.c	2004-06-28 00:08:58.858633392 -0700
@@ -76,6 +76,7 @@ struct processor processor;
 
 unsigned char aux_device_present;
 char elf_platform[ELF_PLATFORM_SIZE];
+char saved_command_line[COMMAND_LINE_SIZE];
 
 unsigned long phys_initrd_start __initdata = 0;
 unsigned long phys_initrd_size __initdata = 0;
diff -puN arch/arm/kernel/setup.c~a arch/arm/kernel/setup.c
--- 25/arch/arm/kernel/setup.c~a	2004-06-28 00:08:52.114658632 -0700
+++ 25-akpm/arch/arm/kernel/setup.c	2004-06-28 00:08:58.859633240 -0700
@@ -97,6 +97,7 @@ unsigned char aux_device_present;
 char elf_platform[ELF_PLATFORM_SIZE];
 EXPORT_SYMBOL(elf_platform);
 
+char saved_command_line[COMMAND_LINE_SIZE];
 unsigned long phys_initrd_start __initdata = 0;
 unsigned long phys_initrd_size __initdata = 0;
 
diff -puN arch/cris/kernel/setup.c~a arch/cris/kernel/setup.c
--- 25/arch/cris/kernel/setup.c~a	2004-06-28 00:08:52.145653920 -0700
+++ 25-akpm/arch/cris/kernel/setup.c	2004-06-28 00:08:58.859633240 -0700
@@ -31,7 +31,10 @@ unsigned char aux_device_present;
 extern int root_mountflags;
 extern char _etext, _edata, _end;
 
+#define COMMAND_LINE_SIZE 256
+
 static char command_line[COMMAND_LINE_SIZE] = { 0, };
+       char saved_command_line[COMMAND_LINE_SIZE];
 
 extern const unsigned long text_start, edata; /* set by the linker script */
 extern unsigned long dram_start, dram_end;
diff -puN arch/h8300/kernel/setup.c~a arch/h8300/kernel/setup.c
--- 25/arch/h8300/kernel/setup.c~a	2004-06-28 00:08:52.176649208 -0700
+++ 25-akpm/arch/h8300/kernel/setup.c	2004-06-28 00:08:58.860633088 -0700
@@ -30,7 +30,6 @@
 #include <linux/major.h>
 #include <linux/bootmem.h>
 #include <linux/seq_file.h>
-#include <linux/init.h>
 
 #include <asm/setup.h>
 #include <asm/irq.h>
@@ -55,7 +54,8 @@ unsigned long rom_length;
 unsigned long memory_start;
 unsigned long memory_end;
 
-char command_line[COMMAND_LINE_SIZE];
+char command_line[512];
+char saved_command_line[512];
 
 extern int _stext, _etext, _sdata, _edata, _sbss, _ebss, _end;
 extern int _ramstart, _ramend;
diff -puN arch/i386/boot/compressed/misc.c~a arch/i386/boot/compressed/misc.c
--- 25/arch/i386/boot/compressed/misc.c~a	2004-06-28 00:08:52.210644040 -0700
+++ 25-akpm/arch/i386/boot/compressed/misc.c	2004-06-28 00:08:58.861632936 -0700
@@ -87,11 +87,12 @@ static void gzip_release(void **);
  */
 static unsigned char *real_mode; /* Pointer to real-mode data */
 
-#define RM_EXT_MEM_K   (*(unsigned short *)(real_mode + 0x2))
+#define EXT_MEM_K   (*(unsigned short *)(real_mode + 0x2))
 #ifndef STANDARD_MEMORY_BIOS_CALL
-#define RM_ALT_MEM_K   (*(unsigned long *)(real_mode + 0x1e0))
+#define ALT_MEM_K   (*(unsigned long *)(real_mode + 0x1e0))
 #endif
-#define RM_SCREEN_INFO (*(struct screen_info *)(real_mode+0))
+#define SCREEN_INFO (*(struct screen_info *)(real_mode+0))
+#define EDID_INFO   (*(struct edid_info *)(real_mode+0x440))
 
 extern char input_data[];
 extern int input_len;
@@ -173,8 +174,8 @@ static void putstr(const char *s)
 	int x,y,pos;
 	char c;
 
-	x = RM_SCREEN_INFO.orig_x;
-	y = RM_SCREEN_INFO.orig_y;
+	x = SCREEN_INFO.orig_x;
+	y = SCREEN_INFO.orig_y;
 
 	while ( ( c = *s++ ) != '\0' ) {
 		if ( c == '\n' ) {
@@ -195,8 +196,8 @@ static void putstr(const char *s)
 		}
 	}
 
-	RM_SCREEN_INFO.orig_x = x;
-	RM_SCREEN_INFO.orig_y = y;
+	SCREEN_INFO.orig_x = x;
+	SCREEN_INFO.orig_y = y;
 
 	pos = (x + cols * y) * 2;	/* Update cursor position */
 	outb_p(14, vidport);
@@ -305,9 +306,9 @@ struct {
 static void setup_normal_output_buffer(void)
 {
 #ifdef STANDARD_MEMORY_BIOS_CALL
-	if (RM_EXT_MEM_K < 1024) error("Less than 2MB of memory");
+	if (EXT_MEM_K < 1024) error("Less than 2MB of memory");
 #else
-	if ((RM_ALT_MEM_K > RM_EXT_MEM_K ? RM_ALT_MEM_K : RM_EXT_MEM_K) < 1024) error("Less than 2MB of memory");
+	if ((ALT_MEM_K > EXT_MEM_K ? ALT_MEM_K : EXT_MEM_K) < 1024) error("Less than 2MB of memory");
 #endif
 	output_data = (char *)0x100000; /* Points to 1M */
 	free_mem_end_ptr = (long)real_mode;
@@ -322,11 +323,9 @@ static void setup_output_buffer_if_we_ru
 {
 	high_buffer_start = (uch *)(((ulg)&end) + HEAP_SIZE);
 #ifdef STANDARD_MEMORY_BIOS_CALL
-	if (RM_EXT_MEM_K < (3*1024)) error("Less than 4MB of memory");
+	if (EXT_MEM_K < (3*1024)) error("Less than 4MB of memory");
 #else
-	if ((RM_ALT_MEM_K > RM_EXT_MEM_K ? RM_ALT_MEM_K : RM_EXT_MEM_K) <
-			(3*1024))
-		error("Less than 4MB of memory");
+	if ((ALT_MEM_K > EXT_MEM_K ? ALT_MEM_K : EXT_MEM_K) < (3*1024)) error("Less than 4MB of memory");
 #endif	
 	mv->low_buffer_start = output_data = (char *)LOW_BUFFER_START;
 	low_buffer_end = ((unsigned int)real_mode > LOW_BUFFER_MAX
@@ -359,7 +358,7 @@ asmlinkage int decompress_kernel(struct 
 {
 	real_mode = rmode;
 
-	if (RM_SCREEN_INFO.orig_video_mode == 7) {
+	if (SCREEN_INFO.orig_video_mode == 7) {
 		vidmem = (char *) 0xb0000;
 		vidport = 0x3b4;
 	} else {
@@ -367,8 +366,8 @@ asmlinkage int decompress_kernel(struct 
 		vidport = 0x3d4;
 	}
 
-	lines = RM_SCREEN_INFO.orig_video_lines;
-	cols = RM_SCREEN_INFO.orig_video_cols;
+	lines = SCREEN_INFO.orig_video_lines;
+	cols = SCREEN_INFO.orig_video_cols;
 
 	if (free_mem_ptr < 0x100000) setup_normal_output_buffer();
 	else setup_output_buffer_if_we_run_high(mv);
diff -puN arch/i386/kernel/setup.c~a arch/i386/kernel/setup.c
--- 25/arch/i386/kernel/setup.c~a	2004-06-28 00:08:52.242639176 -0700
+++ 25-akpm/arch/i386/kernel/setup.c	2004-06-28 00:08:58.862632784 -0700
@@ -127,6 +127,7 @@ unsigned long saved_videomode;
 #define RAMDISK_LOAD_FLAG		0x4000	
 
 static char command_line[COMMAND_LINE_SIZE];
+       char saved_command_line[COMMAND_LINE_SIZE];
 
 unsigned char __initdata boot_params[PARAM_SIZE];
 
diff -puN arch/ia64/kernel/setup.c~a arch/ia64/kernel/setup.c
--- 25/arch/ia64/kernel/setup.c~a	2004-06-28 00:08:52.275634160 -0700
+++ 25-akpm/arch/ia64/kernel/setup.c	2004-06-28 00:08:58.863632632 -0700
@@ -90,6 +90,10 @@ unsigned char aux_device_present = 0xaa;
 unsigned long ia64_max_iommu_merge_mask = ~0UL;
 EXPORT_SYMBOL(ia64_max_iommu_merge_mask);
 
+#define COMMAND_LINE_SIZE	512
+
+char saved_command_line[COMMAND_LINE_SIZE]; /* used in proc filesystem */
+
 /*
  * We use a special marker for the end of memory and it uses the extra (+1) slot
  */
diff -puN arch/m68k/kernel/setup.c~a arch/m68k/kernel/setup.c
--- 25/arch/m68k/kernel/setup.c~a	2004-06-28 00:08:52.310628840 -0700
+++ 25-akpm/arch/m68k/kernel/setup.c	2004-06-28 00:08:58.864632480 -0700
@@ -62,6 +62,7 @@ struct mem_info m68k_memory[NUM_MEMINFO]
 static struct mem_info m68k_ramdisk;
 
 static char m68k_command_line[CL_SIZE];
+char saved_command_line[CL_SIZE];
 
 char m68k_debug_device[6] = "";
 
diff -puN arch/m68knommu/kernel/setup.c~a arch/m68knommu/kernel/setup.c
--- 25/arch/m68knommu/kernel/setup.c~a	2004-06-28 00:08:52.352622456 -0700
+++ 25-akpm/arch/m68knommu/kernel/setup.c	2004-06-28 00:08:58.865632328 -0700
@@ -31,7 +31,6 @@
 #include <linux/bootmem.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
-#include <linux/init.h>
 
 #include <asm/setup.h>
 #include <asm/irq.h>
@@ -45,7 +44,8 @@ unsigned long rom_length;
 unsigned long memory_start;
 unsigned long memory_end;
 
-char command_line[COMMAND_LINE_SIZE];
+char command_line[512];
+char saved_command_line[512];
 
 /* setup some dummy routines */
 static void dummy_waitbut(void)
diff -puN arch/m68k/q40/config.c~a arch/m68k/q40/config.c
--- 25/arch/m68k/q40/config.c~a	2004-06-28 00:08:52.379618352 -0700
+++ 25-akpm/arch/m68k/q40/config.c	2004-06-28 00:08:58.865632328 -0700
@@ -64,6 +64,7 @@ void q40_set_vectors (void);
 
 extern void q40_mksound(unsigned int /*freq*/, unsigned int /*ticks*/ );
 
+extern char *saved_command_line;
 extern char m68k_debug_device[];
 static void q40_mem_console_write(struct console *co, const char *b,
 				    unsigned int count);
diff -puN arch/mips/kernel/setup.c~a arch/mips/kernel/setup.c
--- 25/arch/mips/kernel/setup.c~a	2004-06-28 00:08:52.408613944 -0700
+++ 25-akpm/arch/mips/kernel/setup.c	2004-06-28 00:08:58.866632176 -0700
@@ -72,6 +72,7 @@ EXPORT_SYMBOL(mips_machgroup);
 struct boot_mem_map boot_mem_map;
 
 static char command_line[CL_SIZE];
+       char saved_command_line[CL_SIZE];
        char arcs_cmdline[CL_SIZE]=CONFIG_CMDLINE;
 
 /*
diff -puN arch/parisc/kernel/setup.c~a arch/parisc/kernel/setup.c
--- 25/arch/parisc/kernel/setup.c~a	2004-06-28 00:08:52.440609080 -0700
+++ 25-akpm/arch/parisc/kernel/setup.c	2004-06-28 00:08:58.871631416 -0700
@@ -46,6 +46,8 @@
 #include <asm/io.h>
 #include <asm/setup.h>
 
+#define COMMAND_LINE_SIZE 1024
+char	saved_command_line[COMMAND_LINE_SIZE];
 char	command_line[COMMAND_LINE_SIZE];
 
 /* Intended for ccio/sba/cpu statistics under /proc/bus/{runway|gsc} */
diff -puN arch/ppc64/kernel/head.S~a arch/ppc64/kernel/head.S
--- 25/arch/ppc64/kernel/head.S~a	2004-06-28 00:08:52.471604368 -0700
+++ 25-akpm/arch/ppc64/kernel/head.S	2004-06-28 00:08:58.872631264 -0700
@@ -35,7 +35,6 @@
 #include <asm/offsets.h>
 #include <asm/bug.h>
 #include <asm/cputable.h>
-#include <asm/setup.h>
 
 #ifdef CONFIG_PPC_ISERIES
 #define DO_SOFT_DISABLE
@@ -2224,4 +2223,4 @@ stab_array:
  */
 	.globl	cmd_line
 cmd_line:
-	.space	COMMAND_LINE_SIZE
+	.space	512	/* COMMAND_LINE_SIZE */
diff -puN arch/ppc64/kernel/setup.c~a arch/ppc64/kernel/setup.c
--- 25/arch/ppc64/kernel/setup.c~a	2004-06-28 00:08:52.499600112 -0700
+++ 25-akpm/arch/ppc64/kernel/setup.c	2004-06-28 00:08:58.873631112 -0700
@@ -83,6 +83,7 @@ unsigned long decr_overclock_proc0_set =
 
 int powersave_nap;
 
+char saved_command_line[COMMAND_LINE_SIZE];
 unsigned char aux_device_present;
 
 void parse_cmd_line(unsigned long r3, unsigned long r4, unsigned long r5,
diff -puN arch/ppc/kernel/setup.c~a arch/ppc/kernel/setup.c
--- 25/arch/ppc/kernel/setup.c~a	2004-06-28 00:08:52.534594792 -0700
+++ 25-akpm/arch/ppc/kernel/setup.c	2004-06-28 00:08:58.874630960 -0700
@@ -54,6 +54,7 @@ extern void ppc6xx_idle(void);
 extern void power4_idle(void);
 
 extern boot_infos_t *boot_infos;
+char saved_command_line[COMMAND_LINE_SIZE];
 unsigned char aux_device_present;
 struct ide_machdep_calls ppc_ide_md;
 char *sysmap;
diff -puN arch/ppc/platforms/lopec_setup.c~a arch/ppc/platforms/lopec_setup.c
--- 25/arch/ppc/platforms/lopec_setup.c~a	2004-06-28 00:08:52.567589776 -0700
+++ 25-akpm/arch/ppc/platforms/lopec_setup.c	2004-06-28 00:08:58.875630808 -0700
@@ -33,6 +33,7 @@
 #include <asm/hw_irq.h>
 #include <asm/prep_nvram.h>
 
+extern char saved_command_line[];
 extern void lopec_find_bridges(void);
 
 /*
diff -puN arch/ppc/platforms/pmac_setup.c~a arch/ppc/platforms/pmac_setup.c
--- 25/arch/ppc/platforms/pmac_setup.c~a	2004-06-28 00:08:52.595585520 -0700
+++ 25-akpm/arch/ppc/platforms/pmac_setup.c	2004-06-28 00:08:58.876630656 -0700
@@ -103,6 +103,8 @@ int has_l2cache = 0;
 
 static int current_root_goodness = -1;
 
+extern char saved_command_line[];
+
 extern int pmac_newworld;
 
 #define DEFAULT_ROOT_DEVICE Root_SDA1	/* sda1 - slightly silly choice */
diff -puN arch/ppc/platforms/pplus.c~a arch/ppc/platforms/pplus.c
--- 25/arch/ppc/platforms/pplus.c~a	2004-06-28 00:08:52.623581264 -0700
+++ 25-akpm/arch/ppc/platforms/pplus.c	2004-06-28 00:08:58.877630504 -0700
@@ -48,6 +48,8 @@
 
 TODC_ALLOC();
 
+extern char saved_command_line[];
+
 extern void pplus_setup_hose(void);
 extern void pplus_set_VIA_IDE_native(void);
 
diff -puN arch/ppc/platforms/prep_setup.c~a arch/ppc/platforms/prep_setup.c
--- 25/arch/ppc/platforms/prep_setup.c~a	2004-06-28 00:08:52.651577008 -0700
+++ 25-akpm/arch/ppc/platforms/prep_setup.c	2004-06-28 00:08:58.878630352 -0700
@@ -76,6 +76,7 @@ extern void rs_nvram_write_val(int addr,
 extern void ibm_prep_init(void);
 
 extern void prep_find_bridges(void);
+extern char saved_command_line[];
 
 int _prep_type;
 
diff -puN arch/s390/kernel/setup.c~a arch/s390/kernel/setup.c
--- 25/arch/s390/kernel/setup.c~a	2004-06-28 00:08:52.682572296 -0700
+++ 25-akpm/arch/s390/kernel/setup.c	2004-06-28 00:08:58.879630200 -0700
@@ -76,6 +76,7 @@ extern int _text,_etext, _edata, _end;
 #include <asm/setup.h>
 
 static char command_line[COMMAND_LINE_SIZE] = { 0, };
+       char saved_command_line[COMMAND_LINE_SIZE];
 
 static struct resource code_resource = { "Kernel code", 0x100000, 0 };
 static struct resource data_resource = { "Kernel data", 0, 0 };
diff -puN arch/sh/kernel/setup.c~a arch/sh/kernel/setup.c
--- 25/arch/sh/kernel/setup.c~a	2004-06-28 00:08:52.712567736 -0700
+++ 25-akpm/arch/sh/kernel/setup.c	2004-06-28 00:08:58.879630200 -0700
@@ -83,12 +83,14 @@ static struct sh_machine_vector* __init 
 #define INITRD_SIZE (*(unsigned long *) (PARAM+0x014))
 /* ... */
 #define COMMAND_LINE ((char *) (PARAM+0x100))
+#define COMMAND_LINE_SIZE 256
 
 #define RAMDISK_IMAGE_START_MASK  	0x07FF
 #define RAMDISK_PROMPT_FLAG		0x8000
 #define RAMDISK_LOAD_FLAG		0x4000	
 
 static char command_line[COMMAND_LINE_SIZE] = { 0, };
+       char saved_command_line[COMMAND_LINE_SIZE];
 
 struct resource standard_io_resources[] = {
 	{ "dma1", 0x00, 0x1f },
diff -puN arch/sparc64/kernel/setup.c~a arch/sparc64/kernel/setup.c
--- 25/arch/sparc64/kernel/setup.c~a	2004-06-28 00:08:52.743563024 -0700
+++ 25-akpm/arch/sparc64/kernel/setup.c	2004-06-28 00:08:58.880630048 -0700
@@ -452,7 +452,8 @@ extern unsigned short ram_flags;
 
 extern int root_mountflags;
 
-char reboot_command[COMMAND_LINE_SIZE];
+char saved_command_line[256];
+char reboot_command[256];
 
 static struct pt_regs fake_swapper_regs = { { 0, }, 0, 0, 0, 0 };
 
diff -puN arch/sparc64/kernel/sparc64_ksyms.c~a arch/sparc64/kernel/sparc64_ksyms.c
--- 25/arch/sparc64/kernel/sparc64_ksyms.c~a	2004-06-28 00:08:52.772558616 -0700
+++ 25-akpm/arch/sparc64/kernel/sparc64_ksyms.c	2004-06-28 00:08:58.881629896 -0700
@@ -24,7 +24,6 @@
 #include <linux/socket.h>
 #include <linux/syscalls.h>
 #include <linux/percpu.h>
-#include <linux/init.h>
 #include <net/compat.h>
 
 #include <asm/oplib.h>
@@ -77,6 +76,7 @@ extern int __memcmp(const void *, const 
 extern int __strncmp(const char *, const char *, __kernel_size_t);
 extern __kernel_size_t __strlen(const char *);
 extern __kernel_size_t strlen(const char *);
+extern char saved_command_line[];
 extern void linux_sparc_syscall(void);
 extern void rtrap(void);
 extern void show_regs(struct pt_regs *);
diff -puN arch/sparc/kernel/setup.c~a arch/sparc/kernel/setup.c
--- 25/arch/sparc/kernel/setup.c~a	2004-06-28 00:08:52.802554056 -0700
+++ 25-akpm/arch/sparc/kernel/setup.c	2004-06-28 00:08:58.882629744 -0700
@@ -245,7 +245,8 @@ extern unsigned short ram_flags;
 
 extern int root_mountflags;
 
-char reboot_command[COMMAND_LINE_SIZE];
+char saved_command_line[256];
+char reboot_command[256];
 enum sparc_cpu sparc_cpu_model;
 
 struct tt_entry *sparc_ttable;
diff -puN arch/sparc/kernel/sparc_ksyms.c~a arch/sparc/kernel/sparc_ksyms.c
--- 25/arch/sparc/kernel/sparc_ksyms.c~a	2004-06-28 00:08:52.830549800 -0700
+++ 25-akpm/arch/sparc/kernel/sparc_ksyms.c	2004-06-28 00:08:58.883629592 -0700
@@ -11,7 +11,6 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
-#include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/types.h>
 #include <linux/string.h>
@@ -75,6 +74,7 @@ extern void *__memscan_zero(void *, size
 extern void *__memscan_generic(void *, int, size_t);
 extern int __memcmp(const void *, const void *, __kernel_size_t);
 extern int __strncmp(const char *, const char *, __kernel_size_t);
+extern char saved_command_line[];
 
 extern void bcopy (const char *, char *, int);
 extern int __ashrdi3(int, int);
diff -puN arch/um/kernel/user_util.c~a arch/um/kernel/user_util.c
--- 25/arch/um/kernel/user_util.c~a	2004-06-28 00:08:52.858545544 -0700
+++ 25-akpm/arch/um/kernel/user_util.c	2004-06-28 00:08:58.884629440 -0700
@@ -34,6 +34,7 @@
 #define COMMAND_LINE_SIZE _POSIX_ARG_MAX
 
 /* Changed in linux_main and setup_arch, which run before SMP is started */
+char saved_command_line[COMMAND_LINE_SIZE] = { 0 };
 char command_line[COMMAND_LINE_SIZE] = { 0 };
 
 void add_arg(char *cmd_line, char *arg)
diff -puN arch/v850/kernel/setup.c~a arch/v850/kernel/setup.c
--- 25/arch/v850/kernel/setup.c~a	2004-06-28 00:08:52.894540072 -0700
+++ 25-akpm/arch/v850/kernel/setup.c	2004-06-28 00:08:58.884629440 -0700
@@ -20,7 +20,6 @@
 #include <linux/major.h>
 #include <linux/root_dev.h>
 #include <linux/mtd/mtd.h>
-#include <linux/init.h>
 
 #include <asm/irq.h>
 #include <asm/setup.h>
@@ -42,7 +41,8 @@ extern char _root_fs_image_start __attri
 extern char _root_fs_image_end __attribute__ ((__weak__));
 
 
-char command_line[COMMAND_LINE_SIZE];
+char command_line[512];
+char saved_command_line[512];
 
 /* Memory not used by the kernel.  */
 static unsigned long total_ram_pages;
diff -puN arch/x86_64/kernel/setup.c~a arch/x86_64/kernel/setup.c
--- 25/arch/x86_64/kernel/setup.c~a	2004-06-28 00:08:52.927535056 -0700
+++ 25-akpm/arch/x86_64/kernel/setup.c	2004-06-28 00:08:58.885629288 -0700
@@ -101,6 +101,7 @@ extern int root_mountflags;
 extern char _text, _etext, _edata, _end;
 
 char command_line[COMMAND_LINE_SIZE];
+char saved_command_line[COMMAND_LINE_SIZE];
 
 struct resource standard_io_resources[] = {
 	{ "dma1", 0x00, 0x1f, IORESOURCE_BUSY | IORESOURCE_IO },
diff -puN drivers/sbus/char/openprom.c~a drivers/sbus/char/openprom.c
--- 25/drivers/sbus/char/openprom.c~a	2004-06-28 00:08:52.960530040 -0700
+++ 25-akpm/drivers/sbus/char/openprom.c	2004-06-28 00:08:58.898627312 -0700
@@ -149,6 +149,7 @@ static int openprom_sunos_ioctl(struct i
 	char buffer[OPROMMAXPARAM+1], *buf;
 	struct openpromio *opp;
 	int bufsize, len, error = 0;
+	extern char saved_command_line[];
 	static int cnt;
 
 	if (cmd == OPROMSETOPT)
diff -puN fs/proc/kcore.c~a fs/proc/kcore.c
--- 25/fs/proc/kcore.c~a	2004-06-28 00:08:53.002523656 -0700
+++ 25-akpm/fs/proc/kcore.c	2004-06-28 00:08:58.899627160 -0700
@@ -18,7 +18,6 @@
 #include <linux/elfcore.h>
 #include <linux/vmalloc.h>
 #include <linux/highmem.h>
-#include <linux/init.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
@@ -85,6 +84,8 @@ kclist_del(void *addr)
 	return 0;
 }
 
+extern char saved_command_line[];
+
 static size_t get_kcore_size(int *nphdr, size_t *elf_buflen)
 {
 	size_t try, size;
diff -puN fs/proc/proc_misc.c~a fs/proc/proc_misc.c
--- 25/fs/proc/proc_misc.c~a	2004-06-28 00:08:53.030519400 -0700
+++ 25-akpm/fs/proc/proc_misc.c	2004-06-28 00:08:58.899627160 -0700
@@ -518,6 +518,7 @@ static int filesystems_read_proc(char *p
 static int cmdline_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
+	extern char saved_command_line[];
 	int len;
 
 	len = sprintf(page, "%s\n", saved_command_line);
diff -L include/asm-alpha/setup.h -puN include/asm-alpha/setup.h~a /dev/null
--- 25/include/asm-alpha/setup.h
+++ /dev/null	2004-04-06 10:56:48.000000000 -0700
@@ -1,6 +0,0 @@
-#ifndef __ALPHA_SETUP_H
-#define __ALPHA_SETUP_H
-
-#define COMMAND_LINE_SIZE	256
-
-#endif
diff -puN include/asm-alpha/system.h~a include/asm-alpha/system.h
--- 25/include/asm-alpha/system.h~a	2004-06-28 00:08:53.099508912 -0700
+++ 25-akpm/include/asm-alpha/system.h	2004-06-28 00:08:58.901626856 -0700
@@ -43,6 +43,7 @@
  */
 #define PARAM			ZERO_PGE
 #define COMMAND_LINE		((char*)(PARAM + 0x0000))
+#define COMMAND_LINE_SIZE	256
 #define INITRD_START		(*(unsigned long *) (PARAM+0x100))
 #define INITRD_SIZE		(*(unsigned long *) (PARAM+0x108))
 
diff -puN include/asm-cris/setup.h~a include/asm-cris/setup.h
--- 25/include/asm-cris/setup.h~a	2004-06-28 00:08:53.138502984 -0700
+++ 25-akpm/include/asm-cris/setup.h	2004-06-28 00:08:58.901626856 -0700
@@ -1,6 +1,3 @@
 #ifndef _CRIS_SETUP_H
 #define _CRIS_SETUP_H
-
-#define COMMAND_LINE_SIZE	256
-
 #endif
diff -puN include/asm-h8300/setup.h~a include/asm-h8300/setup.h
--- 25/include/asm-h8300/setup.h~a	2004-06-28 00:08:53.181496448 -0700
+++ 25-akpm/include/asm-h8300/setup.h	2004-06-28 00:08:58.902626704 -0700
@@ -1,6 +1 @@
-#ifndef __H8300_SETUP_H
-#define __H8300_SETUP_H
-
-#define COMMAND_LINE_SIZE	512
-
-#endif
+/* Nothing do */
diff -puN include/asm-i386/param.h~a include/asm-i386/param.h
--- 25/include/asm-i386/param.h~a	2004-06-28 00:08:53.215491280 -0700
+++ 25-akpm/include/asm-i386/param.h	2004-06-28 00:08:58.904626400 -0700
@@ -18,6 +18,5 @@
 #endif
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
-#define COMMAND_LINE_SIZE 256
 
 #endif
diff -L include/asm-ia64/setup.h -puN include/asm-ia64/setup.h~a /dev/null
--- 25/include/asm-ia64/setup.h
+++ /dev/null	2004-04-06 10:56:48.000000000 -0700
@@ -1,6 +0,0 @@
-#ifndef __IA64_SETUP_H
-#define __IA64_SETUP_H
-
-#define COMMAND_LINE_SIZE	512
-
-#endif
diff -puN include/asm-m68knommu/setup.h~a include/asm-m68knommu/setup.h
--- 25/include/asm-m68knommu/setup.h~a	2004-06-28 00:08:53.293479424 -0700
+++ 25-akpm/include/asm-m68knommu/setup.h	2004-06-28 00:08:58.905626248 -0700
@@ -1,5 +1 @@
 #include <asm-m68k/setup.h>
-
-/* We have a bigger command line buffer. */
-#undef COMMAND_LINE_SIZE
-#define COMMAND_LINE_SIZE	512
diff -puN include/asm-m68k/setup.h~a include/asm-m68k/setup.h
--- 25/include/asm-m68k/setup.h~a	2004-06-28 00:08:53.329473952 -0700
+++ 25-akpm/include/asm-m68k/setup.h	2004-06-28 00:08:58.906626096 -0700
@@ -357,7 +357,6 @@ extern int m68k_is040or060;
 
 #define NUM_MEMINFO	4
 #define CL_SIZE		256
-#define COMMAND_LINE_SIZE	CL_SIZE
 
 #ifndef __ASSEMBLY__
 extern int m68k_num_memory;		/* # of memory blocks found (and used) */
diff -puN include/asm-mips/bootinfo.h~a include/asm-mips/bootinfo.h
--- 25/include/asm-mips/bootinfo.h~a	2004-06-28 00:08:53.368468024 -0700
+++ 25-akpm/include/asm-mips/bootinfo.h	2004-06-28 00:08:58.906626096 -0700
@@ -12,7 +12,6 @@
 #define _ASM_BOOTINFO_H
 
 #include <linux/types.h>
-#include <asm/setup.h>
 
 /*
  * The MACH_GROUP_ IDs are the equivalent to PCI vendor IDs; the remaining
@@ -210,7 +209,7 @@
 #define MACH_GROUP_TITAN       22	/* PMC-Sierra Titan		*/
 #define  MACH_TITAN_YOSEMITE	1	/* PMC-Sierra Yosemite		*/
 
-#define CL_SIZE			COMMAND_LINE_SIZE
+#define CL_SIZE			(256)
 
 const char *get_system_type(void);
 
diff -L include/asm-mips/setup.h -puN include/asm-mips/setup.h~a /dev/null
--- 25/include/asm-mips/setup.h
+++ /dev/null	2004-04-06 10:56:48.000000000 -0700
@@ -1,8 +0,0 @@
-#ifdef __KERNEL__
-#ifndef _MIPS_SETUP_H
-#define _MIPS_SETUP_H
-
-#define COMMAND_LINE_SIZE	256
-
-#endif /* __SETUP_H */
-#endif /* __KERNEL__ */
diff -puN include/asm-parisc/setup.h~a include/asm-parisc/setup.h
--- 25/include/asm-parisc/setup.h~a	2004-06-28 00:08:53.433458144 -0700
+++ 25-akpm/include/asm-parisc/setup.h	2004-06-28 00:08:58.908625792 -0700
@@ -1,6 +1,10 @@
-#ifndef _PARISC_SETUP_H
-#define _PARISC_SETUP_H
+/*
+ *	Just a place holder. We don't want to have to test x86 before
+ *	we include stuff
+ */
 
-#define COMMAND_LINE_SIZE	1024
+#ifndef _i386_SETUP_H
+#define _i386_SETUP_H
 
-#endif /* _PARISC_SETUP_H */
+
+#endif /* _i386_SETUP_H */
diff -puN include/asm-ppc64/machdep.h~a include/asm-ppc64/machdep.h
--- 25/include/asm-ppc64/machdep.h~a	2004-06-28 00:08:53.467452976 -0700
+++ 25-akpm/include/asm-ppc64/machdep.h	2004-06-28 00:08:58.908625792 -0700
@@ -11,7 +11,6 @@
 
 #include <linux/config.h>
 #include <linux/seq_file.h>
-#include <linux/init.h>
 #include <linux/dma-mapping.h>
 
 #include <asm/setup.h>
@@ -115,7 +114,9 @@ struct machdep_calls {
 };
 
 extern struct machdep_calls ppc_md;
+#define COMMAND_LINE_SIZE 512
 extern char cmd_line[COMMAND_LINE_SIZE];
+extern char saved_command_line[COMMAND_LINE_SIZE];
 
 /* Functions to produce codes on the leds.
  * The SRC code should be unique for the message category and should
diff -puN include/asm-ppc64/setup.h~a include/asm-ppc64/setup.h
--- 25/include/asm-ppc64/setup.h~a	2004-06-28 00:08:53.495448720 -0700
+++ 25-akpm/include/asm-ppc64/setup.h	2004-06-28 00:08:58.909625640 -0700
@@ -1,6 +1,6 @@
 #ifndef _PPC_SETUP_H
 #define _PPC_SETUP_H
 
-#define COMMAND_LINE_SIZE 512
+/* This is a place holder include */
 
 #endif /* _PPC_SETUP_H */
diff -puN include/asm-ppc/machdep.h~a include/asm-ppc/machdep.h
--- 25/include/asm-ppc/machdep.h~a	2004-06-28 00:08:53.529443552 -0700
+++ 25-akpm/include/asm-ppc/machdep.h	2004-06-28 00:08:58.910625488 -0700
@@ -108,6 +108,7 @@ struct machdep_calls {
 };
 
 extern struct machdep_calls ppc_md;
+#define COMMAND_LINE_SIZE 512
 extern char cmd_line[COMMAND_LINE_SIZE];
 
 extern void setup_pci_ptrs(void);
diff -puN include/asm-ppc/setup.h~a include/asm-ppc/setup.h
--- 25/include/asm-ppc/setup.h~a	2004-06-28 00:08:53.557439296 -0700
+++ 25-akpm/include/asm-ppc/setup.h	2004-06-28 00:08:58.911625336 -0700
@@ -6,9 +6,6 @@
 #define m68k_memory memory
 
 #include <asm-m68k/setup.h>
-/* We have a bigger command line buffer. */
-#undef COMMAND_LINE_SIZE
-#define COMMAND_LINE_SIZE	512
 
 #endif /* _PPC_SETUP_H */
 #endif /* __KERNEL__ */
diff -L include/asm-sh/setup.h -puN include/asm-sh/setup.h~a /dev/null
--- 25/include/asm-sh/setup.h
+++ /dev/null	2004-04-06 10:56:48.000000000 -0700
@@ -1,8 +0,0 @@
-#ifdef __KERNEL__
-#ifndef _SH_SETUP_H
-#define _SH_SETUP_H
-
-#define COMMAND_LINE_SIZE 256
-
-#endif /* _SH_SETUP_H */
-#endif /* __KERNEL__ */
diff -puN include/asm-sparc64/setup.h~a include/asm-sparc64/setup.h
--- 25/include/asm-sparc64/setup.h~a	2004-06-28 00:08:53.634427592 -0700
+++ 25-akpm/include/asm-sparc64/setup.h	2004-06-28 00:08:58.912625184 -0700
@@ -5,6 +5,5 @@
 #ifndef _SPARC64_SETUP_H
 #define _SPARC64_SETUP_H
 
-#define COMMAND_LINE_SIZE	256
 
 #endif /* _SPARC64_SETUP_H */
diff -puN include/asm-sparc/setup.h~a include/asm-sparc/setup.h
--- 25/include/asm-sparc/setup.h~a	2004-06-28 00:08:53.669422272 -0700
+++ 25-akpm/include/asm-sparc/setup.h	2004-06-28 00:08:58.913625032 -0700
@@ -5,6 +5,5 @@
 #ifndef _SPARC_SETUP_H
 #define _SPARC_SETUP_H
 
-#define COMMAND_LINE_SIZE	256
 
 #endif /* _SPARC_SETUP_H */
diff -L include/asm-um/setup.h -puN include/asm-um/setup.h~a /dev/null
--- 25/include/asm-um/setup.h
+++ /dev/null	2004-04-06 10:56:48.000000000 -0700
@@ -1,6 +0,0 @@
-#ifndef SETUP_H_INCLUDED
-#define SETUP_H_INCLUDED
-
-#define COMMAND_LINE_SIZE 512
-
-#endif		/* SETUP_H_INCLUDED */
diff -L include/asm-v850/setup.h -puN include/asm-v850/setup.h~a /dev/null
--- 25/include/asm-v850/setup.h
+++ /dev/null	2004-04-06 10:56:48.000000000 -0700
@@ -1,6 +0,0 @@
-#ifndef _V850_SETUP_H
-#define _V850_SETUP_H
-
-#define COMMAND_LINE_SIZE	512
-
-#endif /* __SETUP_H */
diff -puN include/asm-x86_64/bootsetup.h~a include/asm-x86_64/bootsetup.h
--- 25/include/asm-x86_64/bootsetup.h~a	2004-06-28 00:08:53.768407224 -0700
+++ 25-akpm/include/asm-x86_64/bootsetup.h	2004-06-28 00:08:58.914624880 -0700
@@ -30,6 +30,7 @@ extern char x86_boot_params[2048];
 #define EDD_NR     (*(unsigned char *) (PARAM+EDDNR))
 #define EDD_BUF     ((struct edd_info *) (PARAM+EDDBUF))
 #define COMMAND_LINE saved_command_line
+#define COMMAND_LINE_SIZE 256
 
 #define RAMDISK_IMAGE_START_MASK  	0x07FF
 #define RAMDISK_PROMPT_FLAG		0x8000
diff -puN include/asm-x86_64/setup.h~a include/asm-x86_64/setup.h
--- 25/include/asm-x86_64/setup.h~a	2004-06-28 00:08:53.796402968 -0700
+++ 25-akpm/include/asm-x86_64/setup.h	2004-06-28 00:08:58.915624728 -0700
@@ -1,6 +1,10 @@
+/*
+ *	Just a place holder. We don't want to have to test x86 before
+ *	we include stuff
+ */
+
 #ifndef _x8664_SETUP_H
 #define _x8664_SETUP_H
 
-#define COMMAND_LINE_SIZE	256
 
 #endif
diff -puN include/linux/init.h~a include/linux/init.h
--- 25/include/linux/init.h~a	2004-06-28 00:08:53.837396736 -0700
+++ 25-akpm/include/linux/init.h	2004-06-28 00:09:01.336256736 -0700
@@ -110,33 +110,25 @@ extern char saved_command_line[];
 struct obs_kernel_param {
 	const char *str;
 	int (*setup_func)(char *);
-	int early;
 };
 
-/* Only for really core code.  See moduleparam.h for the normal way. */
-#define __setup_param(str, unique_id, fn, early)			\
+/* OBSOLETE: see moduleparam.h for the right way. */
+#define __setup_param(str, unique_id, fn)			\
 	static char __setup_str_##unique_id[] __initdata = str;	\
 	static struct obs_kernel_param __setup_##unique_id	\
 		 __attribute_used__				\
 		 __attribute__((__section__(".init.setup")))	\
-		= { __setup_str_##unique_id, fn, early }
+		= { __setup_str_##unique_id, fn }
 
 #define __setup_null_param(str, unique_id)			\
-	__setup_param(str, unique_id, NULL, 0)
+	__setup_param(str, unique_id, NULL)
 
 #define __setup(str, fn)					\
-	__setup_param(str, fn, fn, 0)
+	__setup_param(str, fn, fn)
 
 #define __obsolete_setup(str)					\
 	__setup_null_param(str, __LINE__)
 
-/* NOTE: fn is as per module_param, not __setup!  Emits warning if fn
- * returns non-zero. */
-#define early_param(str, fn)					\
-	__setup_param(str, fn, fn, 1)
-
-/* Relies on saved_command_line being set */
-void __init parse_early_param(void);
 #endif /* __ASSEMBLY__ */
 
 /**
diff -puN init/main.c~a init/main.c
--- 25/init/main.c~a	2004-06-28 00:08:53.881390048 -0700
+++ 25-akpm/init/main.c	2004-06-28 00:09:01.351254456 -0700
@@ -112,9 +112,6 @@ extern void time_init(void);
 void (*late_time_init)(void);
 extern void softirq_init(void);
 
-/* Untouched command line (eg. for /proc) saved by arch-specific code. */
-char saved_command_line[COMMAND_LINE_SIZE];
-
 static char *execute_command;
 
 /* Setup configured maximum number of CPUs to activate */
@@ -161,14 +158,8 @@ static int __init obsolete_checksetup(ch
 	do {
 		int n = strlen(p->str);
 		if (!strncmp(line, p->str, n)) {
-			if (p->early) {
-				/* Already done in parse_early_param?  (Needs
-				 * exact match on param part) */
-				if (line[n] == '\0' || line[n] == '=')
-					return 1;
-			} else if (!p->setup_func) {
-				printk(KERN_WARNING "Parameter %s is obsolete,"
-				       " ignored\n", p->str);
+			if (!p->setup_func) {
+				printk(KERN_WARNING "Parameter %s is obsolete, ignored\n", p->str);
 				return 1;
 			} else if (p->setup_func(line + n))
 				return 1;
@@ -403,38 +394,6 @@ static void noinline rest_init(void)
  	cpu_idle();
 } 
 
-/* Check for early params. */
-static int __init do_early_param(char *param, char *val)
-{
-	struct obs_kernel_param *p;
-	extern struct obs_kernel_param __setup_start, __setup_end;
-
-	for (p = &__setup_start; p < &__setup_end; p++) {
-		if (p->early && strcmp(param, p->str) == 0) {
-			if (p->setup_func(val) != 0)
-				printk(KERN_WARNING
-				       "Malformed early option '%s'\n", param);
-		}
-	}
-	/* We accept everything at this stage. */
-	return 0;
-}
-
-/* Arch code calls this early on, or if not, just before other parsing. */
-void __init parse_early_param(void)
-{
-	static __initdata int done = 0;
-	static __initdata char tmp_cmdline[COMMAND_LINE_SIZE];
-
-	if (done)
-		return;
-
-	/* All fall through to do_early_param. */
-	strlcpy(tmp_cmdline, saved_command_line, COMMAND_LINE_SIZE);
-	parse_args("early options", tmp_cmdline, NULL, 0, do_early_param);
-	done = 1;
-}
-
 /*
  *	Activate the first processor.
  */
@@ -442,6 +401,7 @@ void __init parse_early_param(void)
 asmlinkage void __init start_kernel(void)
 {
 	char * command_line;
+	extern char saved_command_line[];
 	extern struct kernel_param __start___param[], __stop___param[];
 /*
  * Interrupts are still disabled. Do necessary setups, then
@@ -478,7 +438,6 @@ asmlinkage void __init start_kernel(void
 	page_alloc_init();
 	trap_init();
 	printk("Kernel command line: %s\n", saved_command_line);
-	parse_early_param();
 	parse_args("Booting kernel", command_line, __start___param,
 		   __stop___param - __start___param,
 		   &unknown_bootoption);
@@ -719,16 +678,3 @@ static int init(void * unused)
 
 	panic("No init found.  Try passing init= option to kernel.");
 }
-
-static int early_param_test(char *rest)
-{
-	printk("early_parm_test: %s\n", rest ?: "(null)");
-	return rest ? 0 : -EINVAL;
-}
-early_param("testsetup", early_param_test);
-static int early_setup_test(char *rest)
-{
-	printk("early_setup_test: %s\n", rest ?: "(null)");
-	return 0;
-}
-__setup("testsetup_long", early_setup_test);

_

