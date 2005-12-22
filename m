Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbVLVS3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbVLVS3B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbVLVS2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:28:50 -0500
Received: from waste.org ([64.81.244.121]:27856 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030285AbVLVS2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:28:32 -0500
Date: Thu, 22 Dec 2005 12:27:11 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linux-tiny@selenic.com
In-Reply-To: <19.150843412@selenic.com>
Message-Id: <20.150843412@selenic.com>
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

Index: 2.6.14-inflate/arch/alpha/boot/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/alpha/boot/misc.c	2005-12-21 21:19:23.000000000 -0600
+++ 2.6.14-inflate/arch/alpha/boot/misc.c	2005-12-21 21:19:24.000000000 -0600
@@ -14,6 +14,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/inflate.h>
 #include <asm/uaccess.h>
 
 #define puts		srm_printk
@@ -27,10 +28,7 @@ static u8 *output_data;
 
 #define HEAP_SIZE 0x2000
 
-/* gzip delarations */
-static char *free_mem_ptr, *free_mem_ptr_end;
-
-#include "../../../lib/inflate.c"
+char *free_mem_ptr, *free_mem_ptr_end; /* for gunzip */
 
 /* flush gunzip output window */
 static void flush_window(const u8 *buf, int len)
Index: 2.6.14-inflate/arch/arm/boot/compressed/Makefile
===================================================================
--- 2.6.14-inflate.orig/arch/arm/boot/compressed/Makefile	2005-12-21 21:19:23.000000000 -0600
+++ 2.6.14-inflate/arch/arm/boot/compressed/Makefile	2005-12-21 21:19:24.000000000 -0600
@@ -91,12 +91,16 @@ endif
 LDFLAGS_vmlinux += -p --no-undefined -X \
 	$(shell $(CC) $(CFLAGS) --print-libgcc-file-name) -T
 
-# Don't allow any static data in misc.o, which
+# Don't allow any static data in misc.o or inflate.o, which
 # would otherwise mess up our GOT table
 CFLAGS_misc.o := -Dstatic=
+CFLAGS_inflate.o := -Dstatic=
+
+$(obj)/inflate.o: lib/inflate.c
+	$(call if_changed_rule,cc_o_c)
 
 $(obj)/vmlinux: $(obj)/vmlinux.lds $(obj)/$(HEAD) $(obj)/piggy.o \
-	 	$(addprefix $(obj)/, $(OBJS)) FORCE
+	 	$(addprefix $(obj)/, $(OBJS)) $(obj)/inflate.o FORCE
 	$(call if_changed,ld)
 	@:
 
Index: 2.6.14-inflate/arch/arm/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/arm/boot/compressed/misc.c	2005-12-21 21:19:23.000000000 -0600
+++ 2.6.14-inflate/arch/arm/boot/compressed/misc.c	2005-12-21 21:19:24.000000000 -0600
@@ -14,6 +14,7 @@
 unsigned int __machine_arch_type;
 
 #include <linux/string.h>
+#include <linux/inflate.h>
 #include <asm/arch/uncompress.h>
 
 #ifdef STANDALONE_DEBUG
@@ -36,21 +37,14 @@ icedcc_putstr(const char *ptr)
 
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
-static char *free_mem_ptr, *free_mem_ptr_end;
+char *free_mem_ptr, *free_mem_ptr_end; /* for gunzip */
 
 #define HEAP_SIZE 0x2000
 
Index: 2.6.14-inflate/arch/arm26/boot/compressed/Makefile
===================================================================
--- 2.6.14-inflate.orig/arch/arm26/boot/compressed/Makefile	2005-12-21 21:19:23.000000000 -0600
+++ 2.6.14-inflate/arch/arm26/boot/compressed/Makefile	2005-12-21 21:19:24.000000000 -0600
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
+        $(call if_changed_rule,cc_o_c)
+
 $(obj)/font.o: $(FONTC)
 	$(CC) $(CFLAGS) -Dstatic= -c $(FONTC) -o $(obj)/font.o
 
 $(obj)/vmlinux.lds: $(obj)/vmlinux.lds.in Makefile arch/arm26/boot/Makefile .config
 	@sed "$(SEDFLAGS)" < $< > $@
 
-$(obj)/misc.o: $(obj)/misc.c $(obj)/uncompress.h lib/inflate.c
+$(obj)/misc.o: $(obj)/misc.c $(obj)/uncompress.h
 
Index: 2.6.14-inflate/arch/arm26/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/arm26/boot/compressed/misc.c	2005-12-21 21:19:23.000000000 -0600
+++ 2.6.14-inflate/arch/arm26/boot/compressed/misc.c	2005-12-21 21:19:24.000000000 -0600
@@ -14,6 +14,7 @@
 unsigned int __machine_arch_type;
 
 #include <linux/kernel.h>
+#include <linux/inflate.h>
 #include <asm/uaccess.h>
 #include "uncompress.h"
 
@@ -30,14 +31,7 @@ static void puts(const char *);
 
 #define HEAP_SIZE 0x2000
 
-/* gzip delarations */
-static char *free_mem_ptr, *free_mem_ptr_end;
-
-#include "../../../../lib/inflate.c"
-
-#ifdef STANDALONE_DEBUG
-#define NO_INFLATE_MALLOC
-#endif
+char *free_mem_ptr, *free_mem_ptr_end; /* for gunzip */
 
 /* flush the gunzip output window */
 static void flush_window(const u8 *buf, int len)
Index: 2.6.14-inflate/arch/cris/arch-v10/boot/compressed/Makefile
===================================================================
--- 2.6.14-inflate.orig/arch/cris/arch-v10/boot/compressed/Makefile	2005-12-21 21:19:23.000000000 -0600
+++ 2.6.14-inflate/arch/cris/arch-v10/boot/compressed/Makefile	2005-12-21 21:19:24.000000000 -0600
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
 
Index: 2.6.14-inflate/arch/cris/arch-v10/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/cris/arch-v10/boot/compressed/misc.c	2005-12-21 21:19:23.000000000 -0600
+++ 2.6.14-inflate/arch/cris/arch-v10/boot/compressed/misc.c	2005-12-21 21:19:24.000000000 -0600
@@ -16,6 +16,7 @@
 
 #include <linux/config.h>
 #include <linux/types.h>
+#include <linux/inflate.h>
 #include <asm/arch/svinto.h>
 
 extern int end; /* the "heap" is put directly after the BSS ends, at end */
@@ -29,8 +30,6 @@ static void puts(const char *);
 static char *free_mem_ptr = (char *)&end;
 static char *free_mem_end_ptr = (char *)0xffffffff;
 
-#include "../../../../../lib/inflate.c"
-
 /* decompressor info and error messages to serial console */
 
 static void
Index: 2.6.14-inflate/arch/cris/arch-v32/boot/compressed/Makefile
===================================================================
--- 2.6.14-inflate.orig/arch/cris/arch-v32/boot/compressed/Makefile	2005-12-21 21:19:23.000000000 -0600
+++ 2.6.14-inflate/arch/cris/arch-v32/boot/compressed/Makefile	2005-12-21 21:19:24.000000000 -0600
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
+	$(call if_changed_rule,cc_o_c)
+
 $(target)/head.o: $(src)/head.S
 	$(CC) -D__ASSEMBLY__ -c $< -o $@
 
Index: 2.6.14-inflate/arch/cris/arch-v32/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/cris/arch-v32/boot/compressed/misc.c	2005-12-21 21:19:23.000000000 -0600
+++ 2.6.14-inflate/arch/cris/arch-v32/boot/compressed/misc.c	2005-12-21 21:19:24.000000000 -0600
@@ -16,6 +16,7 @@
 
 #include <linux/config.h>
 #include <linux/types.h>
+#include <linux/inflate.h>
 #include <asm/arch/hwregs/reg_rdwr.h>
 #include <asm/arch/hwregs/reg_map.h>
 #include <asm/arch/hwregs/ser_defs.h>
@@ -27,10 +28,8 @@ static u8 *output_data;
 static void puts(const char *);
 
 /* gzip declarations */
-static char *free_mem_ptr = (char *)&_end;
-static char *free_mem_end_ptr = (char *)0xffffffff;
-
-#include "../../../../../lib/inflate.c"
+char *free_mem_ptr = (char *)&_end;
+char *free_mem_end_ptr = (char *)0xffffffff;
 
 /* decompressor info and error messages to serial console */
 
Index: 2.6.14-inflate/arch/i386/boot/compressed/Makefile
===================================================================
--- 2.6.14-inflate.orig/arch/i386/boot/compressed/Makefile	2005-12-21 21:19:23.000000000 -0600
+++ 2.6.14-inflate/arch/i386/boot/compressed/Makefile	2005-12-21 21:19:24.000000000 -0600
@@ -9,7 +9,11 @@ EXTRA_AFLAGS	:= -traditional
 
 LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup_32
 
-$(obj)/vmlinux: $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o FORCE
+$(obj)/inflate.o: lib/inflate.c
+	$(call if_changed_rule,cc_o_c)
+
+$(obj)/vmlinux: $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o $(obj)/inflate.o \
+		FORCE
 	$(call if_changed,ld)
 	@:
 
Index: 2.6.14-inflate/arch/i386/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/i386/boot/compressed/misc.c	2005-12-21 21:19:23.000000000 -0600
+++ 2.6.14-inflate/arch/i386/boot/compressed/misc.c	2005-12-21 21:19:24.000000000 -0600
@@ -8,6 +8,7 @@
 #include <linux/linkage.h>
 #include <linux/vmalloc.h>
 #include <linux/tty.h>
+#include <linux/inflate.h>
 #include <asm/io.h>
 #include <asm/page.h>
 
@@ -46,10 +47,7 @@ static int lines, cols;
 static void * xquad_portio = NULL;
 #endif
 
-/* gzip declarations */
-static char *free_mem_ptr = (char *)&end, *free_mem_end_ptr;
-
-#include "../../../../lib/inflate.c"
+char *free_mem_ptr = (char *)&end, *free_mem_end_ptr; /* for gzip */
 
 static void scroll(void)
 {
Index: 2.6.14-inflate/arch/m32r/boot/compressed/Makefile
===================================================================
--- 2.6.14-inflate.orig/arch/m32r/boot/compressed/Makefile	2005-12-21 21:19:23.000000000 -0600
+++ 2.6.14-inflate/arch/m32r/boot/compressed/Makefile	2005-12-21 21:19:24.000000000 -0600
@@ -18,7 +18,11 @@ OBJECTS = $(obj)/head.o $(obj)/misc.o
 
 LDFLAGS_vmlinux := -T
 
-$(obj)/vmlinux: $(obj)/vmlinux.lds $(OBJECTS) $(obj)/piggy.o FORCE
+$(obj)/inflate.o: lib/inflate.c
+	$(call if_changed_rule,cc_o_c)
+
+$(obj)/vmlinux: $(obj)/vmlinux.lds $(OBJECTS) $(obj)/piggy.o $(obj)/inflate.o \
+		FORCE
 	$(call if_changed,ld)
 	@:
 
Index: 2.6.14-inflate/arch/m32r/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/m32r/boot/compressed/misc.c	2005-12-21 21:19:23.000000000 -0600
+++ 2.6.14-inflate/arch/m32r/boot/compressed/misc.c	2005-12-21 21:19:24.000000000 -0600
@@ -9,6 +9,7 @@
 
 #include <linux/config.h>
 #include <linux/string.h>
+#include <linux/inflate.h>
 
 static unsigned char *input_data;
 static int input_len;
@@ -18,11 +19,7 @@ static u8 *output_data;
 
 #define HEAP_SIZE             0x10000
 
-/* gzip declarations */
-static char *free_mem_ptr;
-static char *free_mem_end_ptr;
-
-#include "../../../../lib/inflate.c"
+static char *free_mem_ptr, *free_mem_end_ptr; /* for gunzip */
 
 /* flush the gunzip output buffer */
 static void flush_window(const u8 *buf, int len)
Index: 2.6.14-inflate/arch/sh/boot/compressed/Makefile
===================================================================
--- 2.6.14-inflate.orig/arch/sh/boot/compressed/Makefile	2005-12-21 21:19:23.000000000 -0600
+++ 2.6.14-inflate/arch/sh/boot/compressed/Makefile	2005-12-21 21:19:24.000000000 -0600
@@ -24,7 +24,10 @@ IMAGE_OFFSET := $(shell printf "0x%8x" $
 
 LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup -T $(obj)/../../kernel/vmlinux.lds
 
-$(obj)/vmlinux: $(OBJECTS) $(obj)/piggy.o FORCE
+$(obj)/inflate.o: lib/inflate.c
+	$(call if_changed_rule,cc_o_c)
+
+$(obj)/vmlinux: $(OBJECTS) $(obj)/piggy.o $(obj)/inflate.o FORCE
 	$(call if_changed,ld)
 	@:
 
Index: 2.6.14-inflate/arch/sh/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/sh/boot/compressed/misc.c	2005-12-21 21:19:23.000000000 -0600
+++ 2.6.14-inflate/arch/sh/boot/compressed/misc.c	2005-12-21 21:19:24.000000000 -0600
@@ -7,6 +7,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/inflate.h>
 #include <asm/uaccess.h>
 #ifdef CONFIG_SH_STANDARD_BIOS
 #include <asm/sh_bios.h>
Index: 2.6.14-inflate/arch/sh64/boot/compressed/Makefile
===================================================================
--- 2.6.14-inflate.orig/arch/sh64/boot/compressed/Makefile	2005-12-21 21:19:23.000000000 -0600
+++ 2.6.14-inflate/arch/sh64/boot/compressed/Makefile	2005-12-21 21:19:24.000000000 -0600
@@ -28,7 +28,10 @@ LDFLAGS_vmlinux := -Ttext $(ZIMAGE_OFFSE
 		    -T $(obj)/../../kernel/vmlinux.lds \
 		    --no-warn-mismatch
 
-$(obj)/vmlinux: $(OBJECTS) $(obj)/piggy.o FORCE
+$(obj)/inflate.o: lib/inflate.c
+	$(call if_changed_rule,cc_o_c)
+
+$(obj)/vmlinux: $(OBJECTS) $(obj)/piggy.o $(obj)/inflate.o FORCE
 	$(call if_changed,ld)
 	@:
 
Index: 2.6.14-inflate/arch/sh64/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/sh64/boot/compressed/misc.c	2005-12-21 21:19:23.000000000 -0600
+++ 2.6.14-inflate/arch/sh64/boot/compressed/misc.c	2005-12-21 21:19:24.000000000 -0600
@@ -5,6 +5,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/inflate.h>
 #include <asm/uaccess.h>
 
 /* cache.c */
Index: 2.6.14-inflate/arch/x86_64/boot/compressed/Makefile
===================================================================
--- 2.6.14-inflate.orig/arch/x86_64/boot/compressed/Makefile	2005-12-21 21:19:23.000000000 -0600
+++ 2.6.14-inflate/arch/x86_64/boot/compressed/Makefile	2005-12-21 21:19:24.000000000 -0600
@@ -16,7 +16,11 @@ LDFLAGS := -m elf_i386
 
 LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup_32 -m elf_i386
 
-$(obj)/vmlinux: $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o FORCE
+$(obj)/inflate.o: lib/inflate.c
+	$(call if_changed_rule,cc_o_c)
+
+$(obj)/vmlinux: $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o $(obj)/inflate.o \
+		FORCE
 	$(call if_changed,ld)
 	@:
 
Index: 2.6.14-inflate/arch/x86_64/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/x86_64/boot/compressed/misc.c	2005-12-21 21:19:23.000000000 -0600
+++ 2.6.14-inflate/arch/x86_64/boot/compressed/misc.c	2005-12-21 21:19:24.000000000 -0600
@@ -6,6 +6,7 @@
  */
 
 #include "miscsetup.h"
+#include <linux/inflate.h>
 #include <asm/io.h>
 #include <asm/page.h>
 
Index: 2.6.14-inflate/include/linux/inflate.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ 2.6.14-inflate/include/linux/inflate.h	2005-12-21 21:19:24.000000000 -0600
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
Index: 2.6.14-inflate/init/do_mounts_rd.c
===================================================================
--- 2.6.14-inflate.orig/init/do_mounts_rd.c	2005-12-21 21:19:23.000000000 -0600
+++ 2.6.14-inflate/init/do_mounts_rd.c	2005-12-21 21:19:24.000000000 -0600
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
Index: 2.6.14-inflate/init/initramfs.c
===================================================================
--- 2.6.14-inflate.orig/init/initramfs.c	2005-12-21 21:19:23.000000000 -0600
+++ 2.6.14-inflate/init/initramfs.c	2005-12-21 21:19:24.000000000 -0600
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
Index: 2.6.14-inflate/lib/Makefile
===================================================================
--- 2.6.14-inflate.orig/lib/Makefile	2005-12-21 21:19:23.000000000 -0600
+++ 2.6.14-inflate/lib/Makefile	2005-12-21 21:19:24.000000000 -0600
@@ -5,12 +5,14 @@
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o
+	 sha1.o inflate.o
 
 lib-y	+= kobject.o kref.o kobject_uevent.o klist.o
 
 obj-y += sort.o parser.o halfmd4.o
 
+CFLAGS_inflate.o += -DNO_INFLATE_MALLOC
+
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
 CFLAGS_kobject_uevent.o += -DDEBUG
Index: 2.6.14-inflate/lib/inflate.c
===================================================================
--- 2.6.14-inflate.orig/lib/inflate.c	2005-12-21 21:19:23.000000000 -0600
+++ 2.6.14-inflate/lib/inflate.c	2005-12-21 21:19:36.000000000 -0600
@@ -100,14 +100,7 @@
       the two sets of lengths.
  */
 #include <linux/compiler.h>
-
-#ifndef INIT
-#define INIT
-#endif
-#ifndef INITDATA
-#define INITDATA const
-#endif
-
+#include <linux/kernel.h>
 #include <asm/types.h>
 
 #ifndef NO_INFLATE_MALLOC
@@ -117,6 +110,7 @@
 
 static char *malloc_ptr;
 static int malloc_count;
+extern char *free_mem_ptr, *free_mem_end_ptr;
 
 static void *malloc(int size)
 {
@@ -147,10 +141,20 @@ static void free(void *where)
 }
 
 static u8 window[0x8000]; /* use a statically allocated window */
+
+#define INIT
+#define INITDATA const
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
@@ -936,9 +940,9 @@ static void INIT makecrc(void)
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
