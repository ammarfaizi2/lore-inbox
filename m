Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbVJaVCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbVJaVCY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbVJaVB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:01:59 -0500
Received: from waste.org ([216.27.176.166]:11416 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932542AbVJaVAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:00:39 -0500
Date: Mon, 31 Oct 2005 14:54:52 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-arch@vger.kernel.org
In-Reply-To: <19.196662837@selenic.com>
Message-Id: <20.196662837@selenic.com>
Subject: [PATCH 19/20] inflate: (arch) use proper linking
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inflate: remove include of lib/inflate.c and use proper linking

- make free_mem_ptr vars nonstatic
- make gunzip nonstatic
- add gunzip prototype to new inflate.h
- add per-arch Makefile bits
- change inflate.c includes to inflate.h includes
- change NO_INFLATE_MALLOC to CORE
- compile core kernel version of inflate with -DCORE

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14/arch/alpha/boot/misc.c
===================================================================
--- 2.6.14.orig/arch/alpha/boot/misc.c	2005-10-30 13:07:19.000000000 -0800
+++ 2.6.14/arch/alpha/boot/misc.c	2005-10-30 13:07:25.000000000 -0800
@@ -14,6 +14,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/inflate.h>
 #include <asm/uaccess.h>
 
 #define puts		srm_printk
@@ -27,11 +28,7 @@ static u8 *output_data;
 
 #define HEAP_SIZE 0x2000
 
-/* gzip delarations */
-static u32 free_mem_ptr;
-static u32 free_mem_ptr_end;
-
-#include "../../../lib/inflate.c"
+static u32 free_mem_ptr, free_mem_ptr_end; /* for gunzip */
 
 /* flush gunzip output window */
 static void flush_window(const u8 *buf, int len)
Index: 2.6.14/arch/arm/boot/compressed/Makefile
===================================================================
--- 2.6.14.orig/arch/arm/boot/compressed/Makefile	2005-10-30 13:07:19.000000000 -0800
+++ 2.6.14/arch/arm/boot/compressed/Makefile	2005-10-30 13:07:25.000000000 -0800
@@ -95,8 +95,11 @@ LDFLAGS_vmlinux += -p --no-undefined -X 
 # would otherwise mess up our GOT table
 CFLAGS_misc.o := -Dstatic=
 
+$(obj)/inflate.o: lib/inflate.c
+	$(call cmd,cc_o_c)
+
 $(obj)/vmlinux: $(obj)/vmlinux.lds $(obj)/$(HEAD) $(obj)/piggy.o \
-	 	$(addprefix $(obj)/, $(OBJS)) FORCE
+	 	$(addprefix $(obj)/, $(OBJS)) $(obj)/inflate.o FORCE
 	$(call if_changed,ld)
 	@:
 
Index: 2.6.14/arch/arm/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/arm/boot/compressed/misc.c	2005-10-30 13:07:19.000000000 -0800
+++ 2.6.14/arch/arm/boot/compressed/misc.c	2005-10-30 13:07:25.000000000 -0800
@@ -14,6 +14,7 @@
 unsigned int __machine_arch_type;
 
 #include <linux/string.h>
+#include <linux/inflate.h>
 #include <asm/arch/uncompress.h>
 
 #ifdef STANDALONE_DEBUG
@@ -36,31 +37,17 @@ icedcc_putstr(const char *ptr)
 
 #endif
 
-#define __ptr_t void *
-
-/*
- * gzip declarations
- */
-
 extern char input_data[];
 extern char input_data_end[];
+extern int end;
 
 static u8 *output_data;
-
 static void putstr(const char *);
 
-extern int end;
-static u32 free_mem_ptr;
-static u32 free_mem_ptr_end;
+u32 free_mem_ptr, free_mem_ptr_end; /* for gunzip */
 
 #define HEAP_SIZE 0x2000
 
-#include "../../../../lib/inflate.c"
-
-#ifdef STANDALONE_DEBUG
-#define NO_INFLATE_MALLOC
-#endif
-
 /* flush gunzip output window */
 static void flush_window(const u8 *buf, int len)
 {
Index: 2.6.14/arch/arm26/boot/compressed/Makefile
===================================================================
--- 2.6.14.orig/arch/arm26/boot/compressed/Makefile	2005-10-30 13:07:19.000000000 -0800
+++ 2.6.14/arch/arm26/boot/compressed/Makefile	2005-10-30 13:07:25.000000000 -0800
@@ -8,7 +8,7 @@
 #
 
 HEAD	= head.o
-OBJS	= misc.o
+OBJS	= misc.o inflate.o
 FONTC	= drivers/video/console/font_acorn_8x8.c
 
 OBJS		+= ll_char_wr.o font.o
@@ -40,11 +40,14 @@ LDFLAGS_piggy.o := -r -b binary
 $(obj)/piggy.o:  $(obj)/piggy.gz FORCE
 	$(call if_changed,ld)
 
+$(obj)/inflate.o: lib/inflate.c
+        $(call cmd,cc_o_c)
+
 $(obj)/font.o: $(FONTC)
 	$(CC) $(CFLAGS) -Dstatic= -c $(FONTC) -o $(obj)/font.o
 
 $(obj)/vmlinux.lds: $(obj)/vmlinux.lds.in Makefile arch/arm26/boot/Makefile .config
 	@sed "$(SEDFLAGS)" < $< > $@
 
-$(obj)/misc.o: $(obj)/misc.c $(obj)/uncompress.h lib/inflate.c
+$(obj)/misc.o: $(obj)/misc.c $(obj)/uncompress.h
 
Index: 2.6.14/arch/arm26/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/arm26/boot/compressed/misc.c	2005-10-30 13:07:19.000000000 -0800
+++ 2.6.14/arch/arm26/boot/compressed/misc.c	2005-10-30 13:07:25.000000000 -0800
@@ -14,6 +14,7 @@
 unsigned int __machine_arch_type;
 
 #include <linux/kernel.h>
+#include <linux/inflate.h>
 #include <asm/uaccess.h>
 #include "uncompress.h"
 
@@ -30,15 +31,7 @@ static void puts(const char *);
 
 #define HEAP_SIZE 0x2000
 
-/* gzip delarations */
-static u32 free_mem_ptr;
-static u32 free_mem_ptr_end;
-
-#include "../../../../lib/inflate.c"
-
-#ifdef STANDALONE_DEBUG
-#define NO_INFLATE_MALLOC
-#endif
+u32 free_mem_ptr, free_mem_ptr_end; /* for gunzip */
 
 /* flush the gunzip output window */
 static void flush_window(const u8 *buf, int len)
Index: 2.6.14/arch/cris/arch-v10/boot/compressed/Makefile
===================================================================
--- 2.6.14.orig/arch/cris/arch-v10/boot/compressed/Makefile	2005-10-30 13:07:19.000000000 -0800
+++ 2.6.14/arch/cris/arch-v10/boot/compressed/Makefile	2005-10-30 13:07:25.000000000 -0800
@@ -9,7 +9,7 @@ CFLAGS = -O2
 LD = ld-cris
 OBJCOPY = objcopy-cris
 OBJCOPYFLAGS = -O binary --remove-section=.bss
-OBJECTS = $(target)/head.o $(target)/misc.o
+OBJECTS = $(target)/head.o $(target)/misc.o $(target)/inflate.o
 
 # files to compress
 SYSTEM = $(objtree)/vmlinux.bin
@@ -29,6 +29,9 @@ $(target_compressed_dir)/vmlinuz: $(targ
 $(target)/head.o: $(src)/head.S
 	$(CC) -D__ASSEMBLY__ -traditional -c $< -o $@
 
+$(target)/inflate.o: lib/inflate.c
+	$(CC) -D__KERNEL__ -c $< -o $@
+
 $(target)/misc.o: $(src)/misc.c
 	$(CC) -D__KERNEL__ -c $< -o $@
 
Index: 2.6.14/arch/cris/arch-v10/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/cris/arch-v10/boot/compressed/misc.c	2005-10-30 13:07:19.000000000 -0800
+++ 2.6.14/arch/cris/arch-v10/boot/compressed/misc.c	2005-10-30 13:07:25.000000000 -0800
@@ -16,6 +16,7 @@
 
 #include <linux/config.h>
 #include <linux/types.h>
+#include <linux/inflate.h>
 #include <asm/arch/svinto.h>
 
 extern int end; /* the "heap" is put directly after the BSS ends, at end */
@@ -25,11 +26,8 @@ static u8 *output_data;
 
 static void puts(const char *);
 
-/* gzip declarations */
-static long free_mem_ptr = (long)&end;
-static long free_mem_end_ptr = 0xffffffff;
-
-#include "../../../../../lib/inflate.c"
+/* for gunzip */
+long free_mem_ptr = (long)&end, free_mem_end_ptr = 0xffffffff;
 
 /* decompressor info and error messages to serial console */
 
Index: 2.6.14/arch/cris/arch-v32/boot/compressed/Makefile
===================================================================
--- 2.6.14.orig/arch/cris/arch-v32/boot/compressed/Makefile	2005-10-30 13:07:19.000000000 -0800
+++ 2.6.14/arch/cris/arch-v32/boot/compressed/Makefile	2005-10-30 13:07:25.000000000 -0800
@@ -12,7 +12,7 @@ CFLAGS = -O2
 LD = gcc-cris -mlinux -march=v32 -nostdlib
 OBJCOPY = objcopy-cris
 OBJCOPYFLAGS = -O binary --remove-section=.bss
-OBJECTS = $(target)/head.o $(target)/misc.o
+OBJECTS = $(target)/head.o $(target)/misc.o $(target)/inflate.o
 
 # files to compress
 SYSTEM = $(objtree)/vmlinux.bin
@@ -28,6 +28,9 @@ $(objtree)/vmlinuz: $(target) piggy.img 
 	rm -f piggy.img
 	cp $(objtree)/vmlinuz $(src)
 
+$(target)/inflate.o: lib/inflate.c
+	$(call cmd,cc_o_c)
+
 $(target)/head.o: $(src)/head.S
 	$(CC) -D__ASSEMBLY__ -c $< -o $@
 
Index: 2.6.14/arch/cris/arch-v32/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/cris/arch-v32/boot/compressed/misc.c	2005-10-30 13:07:19.000000000 -0800
+++ 2.6.14/arch/cris/arch-v32/boot/compressed/misc.c	2005-10-30 13:07:25.000000000 -0800
@@ -16,6 +16,7 @@
 
 #include <linux/config.h>
 #include <linux/types.h>
+#include <linux/inflate.h>
 #include <asm/arch/hwregs/reg_rdwr.h>
 #include <asm/arch/hwregs/reg_map.h>
 #include <asm/arch/hwregs/ser_defs.h>
@@ -26,11 +27,8 @@ static u8 *output_data;
 
 static void puts(const char *);
 
-/* gzip declarations */
-static long free_mem_ptr = (long)&_end;
-static long free_mem_end_ptr = 0xffffffff;
-
-#include "../../../../../lib/inflate.c"
+/* for gunzip */
+long free_mem_ptr = (long)&_end, free_mem_end_ptr = 0xffffffff;
 
 /* decompressor info and error messages to serial console */
 
Index: 2.6.14/arch/i386/boot/compressed/Makefile
===================================================================
--- 2.6.14.orig/arch/i386/boot/compressed/Makefile	2005-10-30 13:07:19.000000000 -0800
+++ 2.6.14/arch/i386/boot/compressed/Makefile	2005-10-30 13:07:25.000000000 -0800
@@ -9,7 +9,11 @@ EXTRA_AFLAGS	:= -traditional
 
 LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup_32
 
-$(obj)/vmlinux: $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o FORCE
+$(obj)/inflate.o: lib/inflate.c
+	$(call cmd,cc_o_c)
+
+$(obj)/vmlinux: $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o $(obj)/inflate.o \
+		FORCE
 	$(call if_changed,ld)
 	@:
 
Index: 2.6.14/arch/i386/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/i386/boot/compressed/misc.c	2005-10-30 13:07:19.000000000 -0800
+++ 2.6.14/arch/i386/boot/compressed/misc.c	2005-10-30 13:07:25.000000000 -0800
@@ -8,6 +8,7 @@
 #include <linux/linkage.h>
 #include <linux/vmalloc.h>
 #include <linux/tty.h>
+#include <linux/inflate.h>
 #include <asm/io.h>
 #include <asm/page.h>
 
@@ -46,11 +47,7 @@ static int lines, cols;
 static void * xquad_portio = NULL;
 #endif
 
-/* gzip declarations */
-static long free_mem_ptr = (long)&end;
-static long free_mem_end_ptr;
-
-#include "../../../../lib/inflate.c"
+long free_mem_ptr = (long)&end, free_mem_end_ptr; /* for gunzip */
 
 static void scroll(void)
 {
Index: 2.6.14/arch/m32r/boot/compressed/Makefile
===================================================================
--- 2.6.14.orig/arch/m32r/boot/compressed/Makefile	2005-10-30 13:07:19.000000000 -0800
+++ 2.6.14/arch/m32r/boot/compressed/Makefile	2005-10-30 13:07:25.000000000 -0800
@@ -18,7 +18,11 @@ OBJECTS = $(obj)/head.o $(obj)/misc.o
 
 LDFLAGS_vmlinux := -T
 
-$(obj)/vmlinux: $(obj)/vmlinux.lds $(OBJECTS) $(obj)/piggy.o FORCE
+$(obj)/inflate.o: lib/inflate.c
+	$(call cmd,cc_o_c)
+
+$(obj)/vmlinux: $(obj)/vmlinux.lds $(OBJECTS) $(obj)/piggy.o $(obj)/inflate.o \
+		FORCE
 	$(call if_changed,ld)
 	@:
 
Index: 2.6.14/arch/m32r/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/m32r/boot/compressed/misc.c	2005-10-30 13:07:19.000000000 -0800
+++ 2.6.14/arch/m32r/boot/compressed/misc.c	2005-10-30 13:07:25.000000000 -0800
@@ -9,6 +9,7 @@
 
 #include <linux/config.h>
 #include <linux/string.h>
+#include <linux/inflate.h>
 
 static unsigned char *input_data;
 static int input_len;
@@ -18,11 +19,7 @@ static u8 *output_data;
 
 #define HEAP_SIZE             0x10000
 
-/* gzip declarations */
-static unsigned long free_mem_ptr;
-static unsigned long free_mem_end_ptr;
-
-#include "../../../../lib/inflate.c"
+unsigned long free_mem_ptr, free_mem_end_ptr; /* for gunzip */
 
 /* flush the gunzip output buffer */
 static void flush_window(const u8 *buf, int len)
Index: 2.6.14/arch/sh/boot/compressed/Makefile
===================================================================
--- 2.6.14.orig/arch/sh/boot/compressed/Makefile	2005-10-30 13:07:19.000000000 -0800
+++ 2.6.14/arch/sh/boot/compressed/Makefile	2005-10-30 13:07:25.000000000 -0800
@@ -24,7 +24,10 @@ IMAGE_OFFSET := $(shell printf "0x%8x" $
 
 LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup -T $(obj)/../../kernel/vmlinux.lds
 
-$(obj)/vmlinux: $(OBJECTS) $(obj)/piggy.o FORCE
+$(obj)/inflate.o: lib/inflate.c
+	$(call cmd,cc_o_c)
+
+$(obj)/vmlinux: $(OBJECTS) $(obj)/piggy.o $(obj)/inflate.o FORCE
 	$(call if_changed,ld)
 	@:
 
Index: 2.6.14/arch/sh/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/sh/boot/compressed/misc.c	2005-10-30 13:07:19.000000000 -0800
+++ 2.6.14/arch/sh/boot/compressed/misc.c	2005-10-30 13:07:59.000000000 -0800
@@ -7,6 +7,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/inflate.h>
 #include <asm/uaccess.h>
 #ifdef CONFIG_SH_STANDARD_BIOS
 #include <asm/sh_bios.h>
@@ -22,11 +23,7 @@ int puts(const char *);
 
 #define HEAP_SIZE             0x10000
 
-/* gzip declarations */
-static unsigned long free_mem_ptr;
-static unsigned long free_mem_end_ptr;
-
-#include "../../../../lib/inflate.c"
+unsigned long free_mem_ptr, free_mem_end_ptr; /* for gunzip */
 
 #ifdef CONFIG_SH_STANDARD_BIOS
 size_t strlen(const char *s)
Index: 2.6.14/arch/sh64/boot/compressed/Makefile
===================================================================
--- 2.6.14.orig/arch/sh64/boot/compressed/Makefile	2005-10-30 13:07:19.000000000 -0800
+++ 2.6.14/arch/sh64/boot/compressed/Makefile	2005-10-30 13:07:25.000000000 -0800
@@ -28,7 +28,10 @@ LDFLAGS_vmlinux := -Ttext $(ZIMAGE_OFFSE
 		    -T $(obj)/../../kernel/vmlinux.lds \
 		    --no-warn-mismatch
 
-$(obj)/vmlinux: $(OBJECTS) $(obj)/piggy.o FORCE
+$(obj)/inflate.o: lib/inflate.c
+	$(call cmd,cc_o_c)
+
+$(obj)/vmlinux: $(OBJECTS) $(obj)/piggy.o $(obj)/inflate.o FORCE
 	$(call if_changed,ld)
 	@:
 
Index: 2.6.14/arch/sh64/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/sh64/boot/compressed/misc.c	2005-10-30 13:07:19.000000000 -0800
+++ 2.6.14/arch/sh64/boot/compressed/misc.c	2005-10-30 13:07:25.000000000 -0800
@@ -5,6 +5,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/inflate.h>
 #include <asm/uaccess.h>
 
 /* cache.c */
@@ -22,11 +23,7 @@ static void puts(const char *);
 
 #define HEAP_SIZE             0x10000
 
-/* gzip declarations */
-static unsigned long free_mem_ptr;
-static unsigned long free_mem_end_ptr;
-
-#include "../../../../lib/inflate.c"
+unsigned long free_mem_ptr, free_mem_end_ptr; /* for gunzip */
 
 void puts(const char *s)
 {
Index: 2.6.14/arch/x86_64/boot/compressed/Makefile
===================================================================
--- 2.6.14.orig/arch/x86_64/boot/compressed/Makefile	2005-10-30 13:07:19.000000000 -0800
+++ 2.6.14/arch/x86_64/boot/compressed/Makefile	2005-10-30 13:07:25.000000000 -0800
@@ -16,7 +16,11 @@ LDFLAGS := -m elf_i386
 
 LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup_32 -m elf_i386
 
-$(obj)/vmlinux: $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o FORCE
+$(obj)/inflate.o: lib/inflate.c
+	$(call cmd,cc_o_c)
+
+$(obj)/vmlinux: $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o $(obj)/inflate.o \
+		FORCE
 	$(call if_changed,ld)
 	@:
 
Index: 2.6.14/arch/x86_64/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/x86_64/boot/compressed/misc.c	2005-10-30 13:07:19.000000000 -0800
+++ 2.6.14/arch/x86_64/boot/compressed/misc.c	2005-10-30 13:07:25.000000000 -0800
@@ -6,6 +6,7 @@
  */
 
 #include "miscsetup.h"
+#include <linux/inflate.h>
 #include <asm/io.h>
 #include <asm/page.h>
 
@@ -39,11 +40,7 @@ static char *vidmem = (char *)0xb8000;
 static int vidport;
 static int lines, cols;
 
-/* gzip declarations */
-static long free_mem_ptr = (long)&end;
-static long free_mem_end_ptr;
-
-#include "../../../../lib/inflate.c"
+long free_mem_ptr = (long)&end, free_mem_end_ptr; /* for gunzip */
 
 static void scroll(void)
 {
Index: 2.6.14/include/linux/inflate.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ 2.6.14/include/linux/inflate.h	2005-10-30 13:07:25.000000000 -0800
@@ -0,0 +1,9 @@
+#ifndef _LINUX_INFLATE_H
+#define _LINUX_INFLATE_H
+
+int gunzip(u8 *ibuf, int isize, void (*fill)(u8 *buf, int size),
+	   void (*flush)(const u8 *buf, int size),
+	   void (*error)(const char *msg));
+
+#endif /* _LINUX_INFLATE_H */
+
Index: 2.6.14/init/do_mounts_rd.c
===================================================================
--- 2.6.14.orig/init/do_mounts_rd.c	2005-10-30 13:07:19.000000000 -0800
+++ 2.6.14/init/do_mounts_rd.c	2005-10-30 13:07:25.000000000 -0800
@@ -1,4 +1,3 @@
-
 #include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/minix_fs.h>
@@ -7,6 +6,7 @@
 #include <linux/cramfs_fs.h>
 #include <linux/initrd.h>
 #include <linux/string.h>
+#include <linux/inflate.h>
 
 #include "do_mounts.h"
 
@@ -269,13 +269,6 @@ int __init rd_load_disk(int n)
 
 #ifdef BUILD_CRAMDISK
 
-/* gzip declarations */
-#define INIT __init
-#define INITDATA __initdata
-#define NO_INFLATE_MALLOC
-
-#include "../lib/inflate.c"
-
 #define INBUFSIZ 4096
 static u8 *inbuf;
 static int exit_code;
Index: 2.6.14/init/initramfs.c
===================================================================
--- 2.6.14.orig/init/initramfs.c	2005-10-30 13:07:19.000000000 -0800
+++ 2.6.14/init/initramfs.c	2005-10-30 13:07:25.000000000 -0800
@@ -6,6 +6,7 @@
 #include <linux/delay.h>
 #include <linux/string.h>
 #include <linux/syscalls.h>
+#include <linux/inflate.h>
 
 static __initdata const char *message;
 static void __init error(const char *x)
@@ -329,14 +330,6 @@ static void __init flush_buffer(const u8
 	}
 }
 
-/* gzip declarations */
-
-#define INIT __init
-#define INITDATA __initdata
-#define NO_INFLATE_MALLOC
-
-#include "../lib/inflate.c"
-
 static const char * __init unpack_to_rootfs(char *buf, unsigned len,
 					    int check_only)
 {
Index: 2.6.14/lib/Makefile
===================================================================
--- 2.6.14.orig/lib/Makefile	2005-10-30 13:07:19.000000000 -0800
+++ 2.6.14/lib/Makefile	2005-10-30 13:07:25.000000000 -0800
@@ -5,12 +5,14 @@
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o
+	 sha1.o inflate.o
 
 lib-y	+= kobject.o kref.o kobject_uevent.o klist.o
 
 obj-y += sort.o parser.o halfmd4.o
 
+CFLAGS_inflate.o += -DCORE
+
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
 CFLAGS_kobject_uevent.o += -DDEBUG
Index: 2.6.14/lib/inflate.c
===================================================================
--- 2.6.14.orig/lib/inflate.c	2005-10-30 13:07:19.000000000 -0800
+++ 2.6.14/lib/inflate.c	2005-10-30 13:07:25.000000000 -0800
@@ -99,22 +99,19 @@
       a repeat code (16, 17, or 18) to go across the boundary between
       the two sets of lengths.
  */
+#include <linux/kernel.h>
 #include <linux/compiler.h>
+#include <asm/types.h>
 
-#ifndef INIT
+#ifndef CORE
 #define INIT
-#endif
-#ifndef INITDATA
 #define INITDATA
-#endif
-
-#include <asm/types.h>
 
-#ifndef NO_INFLATE_MALLOC
 /* A trivial malloc implementation, adapted from
  *  malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
  */
 
+extern long free_mem_ptr, free_mem_end_ptr;
 static unsigned long malloc_ptr;
 static int malloc_count;
 
@@ -148,10 +145,17 @@ static void free(void *where)
 }
 
 static u8 INITDATA window[0x8000]; /* use a statically allocated window */
+
 #else
+
+#include <linux/module.h>
+
 static u8 *window; /* dynamically allocate */
 #define malloc(a) kmalloc(a, GFP_KERNEL)
 #define free(a) kfree(a)
+#define INIT __init
+#define INITDATA __initdata
+
 #endif
 
 static u32 crc_32_tab[256];
@@ -937,9 +941,9 @@ static void INIT makecrc(void)
  * @flush: function to flush the output pool
  * @error: function to report an error
  */
-static int INIT gunzip(u8 *ibuf, int isize, void (*fill)(u8 *buf, int size),
-		       void (*flush)(const u8 *buf, int size),
-		       void (*error)(const char *msg))
+int INIT gunzip(u8 *ibuf, int isize, void (*fill)(u8 *buf, int size),
+		void (*flush)(const u8 *buf, int size),
+		void (*error)(const char *msg))
 {
 	u8 flags;
 	unsigned char magic[2];	/* magic header */
