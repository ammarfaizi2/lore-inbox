Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSDQQyU>; Wed, 17 Apr 2002 12:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310214AbSDQQyT>; Wed, 17 Apr 2002 12:54:19 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14926 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S310190AbSDQQyP>; Wed, 17 Apr 2002 12:54:15 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: x86 Boot enhancements, boot parameters 1/11
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Apr 2002 10:46:57 -0600
Message-ID: <m1ads2i872.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus please apply, 

This is the first in a series of mostly independent patches to enhance and cleanup
the x86 boot code.

Major features:
- 32bit entry point, bypassing all of the 16bit BIOS calls.
     This is useful for booting from LinuxBIOS (where there is no
     16bit BIOS).
     This is useful for Linux booting Linux when you aren't certain
     the 16bit BIOS hasn't been stomped.
     This is convenient for bootloaders that are already running in
     protected mode, allowing them to skip the hassle of switching
     back to real mode, (the kernel will do that later).

- Boot image bean counting.  
     This is a listing of what memory the kernel actually uses while
     bootstrapping.  
     This is useful for converting bzImages, into ELF bootable images,
     and for allowing static placement of ramdisks.  If you know where
     the kernel will sit it is easy to avoid it.

- Compiled in command line.
     For the static case where you have a stupid bootloader a compiled
     in command line allows continued access to advanced kernel
     features.

- Boot footprint reduction.
     Currently the kernel decompresser asks bootloaders to make a
     choice between the amount of memory used, and reliability.  The
     higher in real mode memory the kernel places the real mode code,
     the less total memory the decompresser uses but you are also
     much more likely to run into large EBDA's, and fail to boot
     entirely.

- Boot code cleanup  
     Both the work done for bean counting and some other patches
     clean up the boot process making it easier to understand and
     enhance.

- LinuxBIOS support.  
     My real motive.  Enhance the boot process enough so it is
     easy to handle LinuxBIOS.

The patches are archived at:
ftp://download.lnxi.com/pub/src/linux-kernel-patches/boot/linux-2.5.8.boot.*.diff
A patch containing all of the work is:
ftp://download.lnxi.com/pub/src/linux-kernel-patches/boot/linux-2.5.8.boot.diff

This first patch introduces a structure of boot parameters placed
in asm-i386/boot_param.h and implemented in misc.c and setup.c. 

This removes a lot of magic macros and by keeping all of the
boot parameters in a structure it becomes much easier to track
which boot_paramters we have and where they live.  Additionally
this keeps the names more uniform making grepping easier.

Eric


diff -uNr linux-2.5.8/Documentation/i386/zero-page.txt linux-2.5.8.boot.boot_params/Documentation/i386/zero-page.txt
--- linux-2.5.8/Documentation/i386/zero-page.txt	Mon Aug 30 11:47:02 1999
+++ linux-2.5.8.boot.boot_params/Documentation/i386/zero-page.txt	Tue Apr 16 11:18:10 2002
@@ -9,7 +9,11 @@
   arch/i386/boot/video.S
   arch/i386/kernel/head.S
   arch/i386/kernel/setup.c
- 
+
+See include/asm-i386/boot_param.h a structure is kept there with
+uptodate information.  The kernel no longer copies this information
+into the empty zero page, but instead uses it directly.
+
 
 Offset	Type		Description
 ------  ----		-----------
@@ -65,7 +69,7 @@
 0x21c	unsigned long	INITRD_SIZE, size in bytes of ramdisk image
 0x220	4 bytes		(setup.S)
 0x224	unsigned short	setup.S heap end pointer
-0x2d0 - 0x600		E820MAP
+0x2d0 - 0x550		E820MAP
 
 0x800	string, 2K max	COMMAND_LINE, the kernel commandline as
 			copied using CL_OFFSET.
diff -uNr linux-2.5.8/arch/i386/boot/compressed/misc.c linux-2.5.8.boot.boot_params/arch/i386/boot/compressed/misc.c
--- linux-2.5.8/arch/i386/boot/compressed/misc.c	Mon Nov 12 10:59:43 2001
+++ linux-2.5.8.boot.boot_params/arch/i386/boot/compressed/misc.c	Tue Apr 16 11:14:30 2002
@@ -13,6 +13,9 @@
 #include <linux/vmalloc.h>
 #include <linux/tty.h>
 #include <asm/io.h>
+#include <linux/apm_bios.h>
+#include <asm/e820.h>
+#include <asm/boot_param.h>
 
 /*
  * gzip declarations
@@ -84,13 +87,9 @@
 /*
  * This is set up by the setup-routine at boot-time
  */
-static unsigned char *real_mode; /* Pointer to real-mode data */
-
-#define EXT_MEM_K   (*(unsigned short *)(real_mode + 0x2))
-#ifndef STANDARD_MEMORY_BIOS_CALL
-#define ALT_MEM_K   (*(unsigned long *)(real_mode + 0x1e0))
-#endif
-#define SCREEN_INFO (*(struct screen_info *)(real_mode+0))
+static struct boot_params *real_mode; /* Pointer to real-mode data */
+/* Amount of memory in kilobytes, if it isn't set assume enough */
+static unsigned long mem_k = 0xFFFFFFFF;
 
 extern char input_data[];
 extern int input_len;
@@ -176,8 +175,8 @@
 	int x,y,pos;
 	char c;
 
-	x = SCREEN_INFO.orig_x;
-	y = SCREEN_INFO.orig_y;
+	x = real_mode->screen.info.orig_x;
+	y = real_mode->screen.info.orig_y;
 
 	while ( ( c = *s++ ) != '\0' ) {
 		if ( c == '\n' ) {
@@ -198,8 +197,8 @@
 		}
 	}
 
-	SCREEN_INFO.orig_x = x;
-	SCREEN_INFO.orig_y = y;
+	real_mode->screen.info.orig_x = x;
+	real_mode->screen.info.orig_y = y;
 
 	pos = (x + cols * y) * 2;	/* Update cursor position */
 	outb_p(14, vidport);
@@ -208,6 +207,20 @@
 	outb_p(0xff & (pos >> 1), vidport+1);
 }
 
+static void vid_puts_init(void)
+{
+	if (real_mode->screen.info.orig_video_mode == 7) {
+		vidmem = (char *) 0xb0000;
+		vidport = 0x3b4;
+	} else {
+		vidmem = (char *) 0xb8000;
+		vidport = 0x3d4;
+	}
+	
+	lines = real_mode->screen.info.orig_video_lines;
+	cols = real_mode->screen.info.orig_video_cols;
+}
+
 static void* memset(void* s, int c, size_t n)
 {
 	int i;
@@ -307,11 +320,7 @@
 
 static void setup_normal_output_buffer(void)
 {
-#ifdef STANDARD_MEMORY_BIOS_CALL
-	if (EXT_MEM_K < 1024) error("Less than 2MB of memory.\n");
-#else
-	if ((ALT_MEM_K > EXT_MEM_K ? ALT_MEM_K : EXT_MEM_K) < 1024) error("Less than 2MB of memory.\n");
-#endif
+	if (mem_k < 2048)  error("Less than 2MB of memory.\n");
 	output_data = (char *)0x100000; /* Points to 1M */
 	free_mem_end_ptr = (long)real_mode;
 }
@@ -324,11 +333,7 @@
 static void setup_output_buffer_if_we_run_high(struct moveparams *mv)
 {
 	high_buffer_start = (uch *)(((ulg)&end) + HEAP_SIZE);
-#ifdef STANDARD_MEMORY_BIOS_CALL
-	if (EXT_MEM_K < (3*1024)) error("Less than 4MB of memory.\n");
-#else
-	if ((ALT_MEM_K > EXT_MEM_K ? ALT_MEM_K : EXT_MEM_K) < (3*1024)) error("Less than 4MB of memory.\n");
-#endif	
+	if (mem_k < (4*1024))  error("Less than 4MB of memory.\n");
 	mv->low_buffer_start = output_data = (char *)LOW_BUFFER_START;
 	low_buffer_end = ((unsigned int)real_mode > LOW_BUFFER_MAX
 	  ? LOW_BUFFER_MAX : (unsigned int)real_mode) & ~0xfff;
@@ -360,16 +365,15 @@
 {
 	real_mode = rmode;
 
-	if (SCREEN_INFO.orig_video_mode == 7) {
-		vidmem = (char *) 0xb0000;
-		vidport = 0x3b4;
-	} else {
-		vidmem = (char *) 0xb8000;
-		vidport = 0x3d4;
-	}
+	vid_puts_init();
 
-	lines = SCREEN_INFO.orig_video_lines;
-	cols = SCREEN_INFO.orig_video_cols;
+	mem_k = real_mode->screen.overlap.ext_mem_k;
+#ifndef STANDARD_MEMORY_BIOS_CALL
+	if (real_mode->alt_mem_k > mem_k) {
+		mem_k = real_mode->alt_mem_k;
+	}
+#endif
+	mem_k += 1024;
 
 	if (free_mem_ptr < 0x100000) setup_normal_output_buffer();
 	else setup_output_buffer_if_we_run_high(mv);
diff -uNr linux-2.5.8/arch/i386/kernel/setup.c linux-2.5.8.boot.boot_params/arch/i386/kernel/setup.c
--- linux-2.5.8/arch/i386/kernel/setup.c	Tue Apr 16 11:10:43 2002
+++ linux-2.5.8.boot.boot_params/arch/i386/kernel/setup.c	Tue Apr 16 11:14:30 2002
@@ -116,6 +116,7 @@
 #include <asm/dma.h>
 #include <asm/mpspec.h>
 #include <asm/mmu_context.h>
+#include <asm/boot_param.h>
 
 /*
  * Machine setup..
@@ -146,14 +147,9 @@
 /*
  * Setup options
  */
-struct drive_info_struct { char dummy[32]; } drive_info;
+struct drive_info_struct drive_info;
 struct screen_info screen_info;
 struct apm_info apm_info;
-struct sys_desc_table_struct {
-	unsigned short length;
-	unsigned char table[0];
-};
-
 struct e820map e820;
 
 unsigned char aux_device_present;
@@ -168,34 +164,9 @@
 static int disable_x86_serial_nr __initdata = 1;
 static int disable_x86_fxsr __initdata = 0;
 
-/*
- * This is set up by the setup-routine at boot-time
- */
-#define PARAM	((unsigned char *)empty_zero_page)
-#define SCREEN_INFO (*(struct screen_info *) (PARAM+0))
-#define EXT_MEM_K (*(unsigned short *) (PARAM+2))
-#define ALT_MEM_K (*(unsigned long *) (PARAM+0x1e0))
-#define E820_MAP_NR (*(char*) (PARAM+E820NR))
-#define E820_MAP    ((struct e820entry *) (PARAM+E820MAP))
-#define APM_BIOS_INFO (*(struct apm_bios_info *) (PARAM+0x40))
-#define DRIVE_INFO (*(struct drive_info_struct *) (PARAM+0x80))
-#define SYS_DESC_TABLE (*(struct sys_desc_table_struct*)(PARAM+0xa0))
-#define MOUNT_ROOT_RDONLY (*(unsigned short *) (PARAM+0x1F2))
-#define RAMDISK_FLAGS (*(unsigned short *) (PARAM+0x1F8))
-#define ORIG_ROOT_DEV (*(unsigned short *) (PARAM+0x1FC))
-#define AUX_DEVICE_INFO (*(unsigned char *) (PARAM+0x1FF))
-#define LOADER_TYPE (*(unsigned char *) (PARAM+0x210))
-#define KERNEL_START (*(unsigned long *) (PARAM+0x214))
-#define INITRD_START (*(unsigned long *) (PARAM+0x218))
-#define INITRD_SIZE (*(unsigned long *) (PARAM+0x21c))
-#define COMMAND_LINE ((char *) (PARAM+2048))
+#define COMMAND_LINE (((char *)empty_zero_page)+2048)
 #define COMMAND_LINE_SIZE 256
 
-#define RAMDISK_IMAGE_START_MASK  	0x07FF
-#define RAMDISK_PROMPT_FLAG		0x8000
-#define RAMDISK_LOAD_FLAG		0x4000	
-
-
 static char command_line[COMMAND_LINE_SIZE];
        char saved_command_line[COMMAND_LINE_SIZE];
 
@@ -557,7 +528,7 @@
  */
 #define LOWMEMSIZE()	(0x9f000)
 
-static void __init setup_memory_region(void)
+static void __init setup_memory_region(struct boot_params *params)
 {
 	char *who = "BIOS-e820";
 
@@ -567,16 +538,16 @@
 	 * Otherwise fake a memory map; one section from 0k->640k,
 	 * the next section from 1mb->appropriate_mem_k
 	 */
-	sanitize_e820_map(E820_MAP, &E820_MAP_NR);
-	if (copy_e820_map(E820_MAP, E820_MAP_NR) < 0) {
+	sanitize_e820_map(params->e820_map, &params->e820_map_nr);
+	if (copy_e820_map(params->e820_map, params->e820_map_nr) < 0) {
 		unsigned long mem_size;
 
 		/* compare results from other methods and take the greater */
-		if (ALT_MEM_K < EXT_MEM_K) {
-			mem_size = EXT_MEM_K;
+		if (params->alt_mem_k < params->screen.overlap.ext_mem_k) {
+			mem_size = params->screen.overlap.ext_mem_k;
 			who = "BIOS-88";
 		} else {
-			mem_size = ALT_MEM_K;
+			mem_size = params->alt_mem_k;
 			who = "BIOS-e801";
 		}
 
@@ -672,31 +643,36 @@
 	unsigned long bootmap_size, low_mem_size;
 	unsigned long start_pfn, max_low_pfn;
 	int i;
+	struct boot_params *params;
 
 #ifdef CONFIG_VISWS
 	visws_get_board_type_and_rev();
 #endif
 
- 	ROOT_DEV = to_kdev_t(ORIG_ROOT_DEV);
- 	drive_info = DRIVE_INFO;
- 	screen_info = SCREEN_INFO;
-	apm_info.bios = APM_BIOS_INFO;
-	if( SYS_DESC_TABLE.length != 0 ) {
-		MCA_bus = SYS_DESC_TABLE.table[3] &0x2;
-		machine_id = SYS_DESC_TABLE.table[0];
-		machine_submodel_id = SYS_DESC_TABLE.table[1];
-		BIOS_revision = SYS_DESC_TABLE.table[2];
+	/*
+	 * This is set up by the setup-routine at boot-time
+	 */
+	params = (struct boot_params *)empty_zero_page;
+ 	ROOT_DEV = to_kdev_t(params->root_dev);
+ 	drive_info = params->drive_info;
+ 	screen_info = params->screen.info;
+	apm_info.bios = params->apm_bios_info;
+	if( params->sys_desc_table.length != 0 ) {
+		MCA_bus = params->sys_desc_table.table[3] &0x2;
+		machine_id = params->sys_desc_table.table[0];
+		machine_submodel_id = params->sys_desc_table.table[1];
+		BIOS_revision = params->sys_desc_table.table[2];
 	}
-	aux_device_present = AUX_DEVICE_INFO;
+	aux_device_present = params->aux_device_info;
 
 #ifdef CONFIG_BLK_DEV_RAM
-	rd_image_start = RAMDISK_FLAGS & RAMDISK_IMAGE_START_MASK;
-	rd_prompt = ((RAMDISK_FLAGS & RAMDISK_PROMPT_FLAG) != 0);
-	rd_doload = ((RAMDISK_FLAGS & RAMDISK_LOAD_FLAG) != 0);
+	rd_image_start = params->ramdisk_flags & RAMDISK_IMAGE_START_MASK;
+	rd_prompt = ((params->ramdisk_flags & RAMDISK_PROMPT_FLAG) != 0);
+	rd_doload = ((params->ramdisk_flags & RAMDISK_LOAD_FLAG) != 0);
 #endif
-	setup_memory_region();
+	setup_memory_region(params);
 
-	if (!MOUNT_ROOT_RDONLY)
+	if (!params->mount_root_rdonly)
 		root_mountflags &= ~MS_RDONLY;
 	init_mm.start_code = (unsigned long) &_text;
 	init_mm.end_code = (unsigned long) &_etext;
@@ -881,18 +857,21 @@
 	find_smp_config();
 #endif
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (LOADER_TYPE && INITRD_START) {
-		if (INITRD_START + INITRD_SIZE <= (max_low_pfn << PAGE_SHIFT)) {
-			reserve_bootmem(INITRD_START, INITRD_SIZE);
-			initrd_start =
-				INITRD_START ? INITRD_START + PAGE_OFFSET : 0;
-			initrd_end = initrd_start+INITRD_SIZE;
+	if (params->type_of_loader && params->initrd_start) {
+		initrd_start = params->initrd_start ?
+		     params->initrd_start + PAGE_OFFSET : 0;
+		initrd_end = initrd_start + params->initrd_size;
+	}
+	if (initrd_start) {
+		if ((initrd_end - PAGE_OFFSET) <= (max_low_pfn << PAGE_SHIFT)) {
+			reserve_bootmem(initrd_start - PAGE_OFFSET,
+				initrd_end - initrd_start);
 		}
 		else {
 			printk(KERN_ERR "initrd extends beyond end of memory "
-			    "(0x%08lx > 0x%08lx)\ndisabling initrd\n",
-			    INITRD_START + INITRD_SIZE,
-			    max_low_pfn << PAGE_SHIFT);
+				"(0x%08lx > 0x%08lx)\ndisabling initrd\n",
+				initrd_end - PAGE_OFFSET, 
+				max_low_pfn << PAGE_SHIFT);
 			initrd_start = 0;
 		}
 	}
diff -uNr linux-2.5.8/include/asm-i386/boot_param.h linux-2.5.8.boot.boot_params/include/asm-i386/boot_param.h
--- linux-2.5.8/include/asm-i386/boot_param.h	Wed Dec 31 17:00:00 1969
+++ linux-2.5.8.boot.boot_params/include/asm-i386/boot_param.h	Tue Apr 16 11:16:54 2002
@@ -0,0 +1,79 @@
+#ifndef __I386_BOOT_PARAM_H
+#define __I386_BOOT_PARAM_H
+
+struct drive_info_struct { __u8 dummy[32]; };
+struct sys_desc_table {
+	__u16 length;
+	__u8 table[318];
+};
+struct screen_info_overlap {
+	__u8  reserved1[2];		/* 0x00 */
+	__u16 ext_mem_k;		/* 0x02 */
+	__u8  reserved2[0x20 - 0x04];	/* 0x04 */
+	__u16 cl_magic;			/* 0x20 */
+#define CL_MAGIC_VALUE 0xA33F
+	__u16 cl_offset;		/* 0x22 */
+	__u8  reserved3[0x40 - 0x24];	/* 0x24 */
+};
+
+struct boot_params {
+	union {					/* 0x00 */
+		struct screen_info info;
+		struct screen_info_overlap overlap;
+	} screen;
+
+	struct apm_bios_info apm_bios_info;	/* 0x40 */
+	__u8 reserved4[0x80 - 0x54];		/* 0x54 */
+	struct drive_info_struct drive_info;	/* 0x80 */
+	struct sys_desc_table sys_desc_table;	/* 0xa0 */
+	__u32 alt_mem_k;			/* 0x1e0 */
+	__u8  reserved5[4];			/* 0x1e4 */
+	__u8  e820_map_nr;			/* 0x1e8 */
+	__u8  reserved6[8];			/* 0x1e9 */
+	__u8  setup_sects;			/* 0x1f1 */
+	__u16 mount_root_rdonly;		/* 0x1f2 */
+	__u16 syssize;				/* 0x1f4 */
+	__u16 swapdev;				/* 0x1f6 */
+	__u16 ramdisk_flags;			/* 0x1f8 */
+#define RAMDISK_IMAGE_START_MASK  	0x07FF
+#define RAMDISK_PROMPT_FLAG		0x8000
+#define RAMDISK_LOAD_FLAG		0x4000	
+	__u16 vid_mode;				/* 0x1fa */
+	__u16 root_dev;				/* 0x1fc */
+	__u8  reserved9[1];			/* 0x1fe */
+	__u8  aux_device_info;			/* 0x1ff */
+	/* 2.00+ */
+	__u8  jump[2];				/* 0x200 */
+	__u8  header_magic[4];			/* 0x202 */
+	__u16 version;				/* 0x206 */
+	__u16 realmode_swtch[2];		/* 0x208 */
+	__u16 start_sys_seg;			/* 0x20c */
+	__u16 kernel_version;			/* 0x20e */
+	__u8  type_of_loader;			/* 0x210 */
+#define LOADER_LILO            0x00
+#define LOADER_LOADLIN         0x10
+#define LOADER_BOOTSECT_LOADER 0x20
+#define LOADER_SYSLINUX        0x30
+#define LOADER_ETHERBOOT       0x40
+#define LOADER_UNKNOWN         0xFF
+	__u8  loadflags;			/* 0x211 */
+#define LOADFLAG_LOADED_HIGH  1
+#define LOADFLAG_STAY_PUT     0x40
+#define LOADFLAG_CAN_USE_HEAP 0x80
+	__u16 setup_move_size;			/* 0x212 */
+	__u32 code32_start;			/* 0x214 */
+	__u32 initrd_start;			/* 0x218 */
+	__u32 initrd_size;			/* 0x21c */
+	__u8  reserved13[4];			/* 0x220 */
+	/* 2.01+ */
+	__u16 heap_end_ptr;			/* 0x224 */
+	__u8  pad1[2];				/* 0x226 */
+	/* 2.02+ */
+	__u32 cmd_line_ptr;			/* 0x228 */
+	/* 2.03+ */
+	__u32 ramdisk_max;			/* 0x22c */
+	__u8  reserved15[0x2d0 - 0x230];	/* 0x230 */
+	struct e820entry e820_map[E820MAX];	/* 0x2d0 */
+						/* 0x550 */
+} __attribute__((packed));
+#endif /* __I386_BOOT_PARAM_H */
