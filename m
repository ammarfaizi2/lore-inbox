Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbTEBRtd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 13:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263026AbTEBRtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 13:49:33 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:11711 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S262951AbTEBRt3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 13:49:29 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] alternative compat_ioctl table implementation
Date: Fri, 2 May 2003 19:59:02 +0200
User-Agent: KMail/1.5.1
Cc: Pavel Machek <pavel@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305021959.02726.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had some trouble making the 2.5.68bk implementation
for compat_ioctl work on s390x because of a cross-compiling
bug in gcc-2.95.

This patch changes the way that the translation table
is generated and solves the problem by replacing
the assembler magic with linker magic.

As a side effect, it adds type-checking for the handler
functions and makes it possible to put COMPATIBLE_IOCTL()
in places other than arch/*/kernel/ioctl32.c, e.g. next
to the normal ioctl handler.

This needs the compat-ioctl-fix.patch from 2.5.68mm4.

Opinions?

	Arnd <><

===== include/asm-generic/vmlinux.lds.h 1.7 vs edited =====
--- 1.7/include/asm-generic/vmlinux.lds.h	Mon Feb  3 22:00:30 2003
+++ edited/include/asm-generic/vmlinux.lds.h	Fri May  2 16:47:13 2003
@@ -1,3 +1,5 @@
+#include <linux/config.h>
+
 #ifndef LOAD_OFFSET
 #define LOAD_OFFSET 0
 #endif
@@ -45,3 +47,11 @@
 		*(__ksymtab_strings)					\
 	}
 
+#ifdef CONFIG_COMPAT							\
+#define COMPAT_IOCTL_TABLE						\
+  ioctl_start = .;							\
+  .data.ioctltrans : { *(.data.ioctltrans) }				\
+  ioctl_end = .;
+#else
+#define COMPAT_IOCTL_TABLE
+#endif
===== include/linux/compat.h 1.11 vs edited =====
--- 1.11/include/linux/compat.h	Wed Apr 16 07:48:21 2003
+++ edited/include/linux/compat.h	Fri May  2 16:47:13 2003
@@ -12,6 +12,14 @@
 #include <linux/param.h>	/* for HZ */
 #include <asm/compat.h>
 
+#define __IOCTL_HANDLER(name,cmd,handler)				\
+	static struct ioctl_trans name					\
+			__attribute_used__				\
+			__attribute__((section(".data.ioctltrans"))) = 	\
+		{ cmd, handler, 0 };
+#define HANDLE_IOCTL(cmd,handler) __IOCTL_HANDLER(handle_ioctl_ ## cmd,cmd,handler)
+#define COMPATIBLE_IOCTL(cmd)     __IOCTL_HANDLER(compatible_ioctl_ ## cmd,cmd,0)
+
 #define compat_jiffies_to_clock_t(x)	\
 		(((unsigned long)(x) * COMPAT_USER_HZ) / HZ)
 
===== arch/parisc/vmlinux.lds.S 1.13 vs edited =====
--- 1.13/arch/parisc/vmlinux.lds.S	Wed Apr  2 10:42:56 2003
+++ edited/arch/parisc/vmlinux.lds.S	Fri May  2 16:56:36 2003
@@ -44,6 +44,7 @@
 	*(.data)
 	}
 
+  COMPAT_IOCTL_TABLE
 #ifdef CONFIG_PARISC64
   . = ALIGN(16);               /* Linkage tables */
   .opd : { *(.opd) } PROVIDE (__gp = .); 
===== arch/parisc/kernel/ioctl32.c 1.8 vs edited =====
--- 1.8/arch/parisc/kernel/ioctl32.c	Wed Apr 30 20:03:39 2003
+++ edited/arch/parisc/kernel/ioctl32.c	Fri May  2 16:47:13 2003
@@ -2893,13 +2893,6 @@
 	return err;
 }
 
-#define HANDLE_IOCTL(cmd, handler) { cmd, (ioctl_trans_handler_t)handler, 0 },
-#define COMPATIBLE_IOCTL(cmd) HANDLE_IOCTL(cmd, sys_ioctl) 
-
-#define IOCTL_TABLE_START  struct ioctl_trans ioctl_start[] = {
-#define IOCTL_TABLE_END    }; struct ioctl_trans ioctl_end[0];
-
-IOCTL_TABLE_START
 #include <linux/compat_ioctl.h>
 
 /* Might be moved to compat_ioctl.h with some ifdefs... */
@@ -3084,5 +3077,4 @@
 HANDLE_IOCTL(DRM32_IOCTL_DMA, drm32_dma);
 HANDLE_IOCTL(DRM32_IOCTL_RES_CTX, drm32_res_ctx);
 #endif /* DRM */
-IOCTL_TABLE_END
 
===== arch/ppc64/vmlinux.lds.S 1.14 vs edited =====
--- 1.14/arch/ppc64/vmlinux.lds.S	Wed Apr  2 10:42:56 2003
+++ edited/arch/ppc64/vmlinux.lds.S	Fri May  2 16:56:48 2003
@@ -57,6 +57,7 @@
     *(.dynamic)
     CONSTRUCTORS
   }
+  COMPAT_IOCTL_TABLE
   . = ALIGN(4096);
   _edata  =  .;
   PROVIDE (edata = .);
===== arch/ppc64/kernel/ioctl32.c 1.27 vs edited =====
--- 1.27/arch/ppc64/kernel/ioctl32.c	Wed Apr 30 17:47:36 2003
+++ edited/arch/ppc64/kernel/ioctl32.c	Fri May  2 16:47:14 2003
@@ -3649,14 +3649,9 @@
 	unsigned long next;
 };
 
-#define COMPATIBLE_IOCTL(cmd) { cmd, (unsigned long)sys_ioctl, 0 },
-
-#define HANDLE_IOCTL(cmd,handler) { cmd, (unsigned long)handler, 0 },
-
 #define AUTOFS_IOC_SETTIMEOUT32 _IOWR(0x93,0x64,unsigned int)
 #define SMB_IOC_GETMOUNTUID_32 _IOR('u', 1, compat_uid_t)
 
-static struct ioctl_trans ioctl_translations[] = {
     /* List here explicitly which ioctl's need translation,
      * all others default to calling sys_ioctl().
      */
@@ -4473,4 +4468,3 @@
 HANDLE_IOCTL(BLKBSZGET_32, do_blkbszget)
 HANDLE_IOCTL(BLKBSZSET_32, do_blkbszset)
 HANDLE_IOCTL(BLKGETSIZE64_32, do_blkgetsize64)
-};
===== arch/s390/vmlinux.lds.S 1.12 vs edited =====
--- 1.12/arch/s390/vmlinux.lds.S	Mon Apr 14 21:11:57 2003
+++ edited/arch/s390/vmlinux.lds.S	Fri May  2 19:28:50 2003
@@ -3,7 +3,6 @@
  */
 
 #include <asm-generic/vmlinux.lds.h>
-#include <linux/config.h>
 
 #ifndef CONFIG_ARCH_S390X
 OUTPUT_FORMAT("elf32-s390", "elf32-s390", "elf32-s390")
@@ -46,6 +45,7 @@
 	*(.data)
 	CONSTRUCTORS
 	}
+  COMPAT_IOCTL_TABLE
 
   . = ALIGN(4096);
   __nosave_begin = .;
===== arch/sparc64/vmlinux.lds.S 1.18 vs edited =====
--- 1.18/arch/sparc64/vmlinux.lds.S	Wed Apr  2 10:42:56 2003
+++ edited/arch/sparc64/vmlinux.lds.S	Fri May  2 16:47:14 2003
@@ -28,6 +28,7 @@
     CONSTRUCTORS
   }
   .data1   : { *(.data1) }
+  COMPAT_IOCTL_TABLE
   . = ALIGN(64);
   .data.cacheline_aligned : { *(.data.cacheline_aligned) }
   _edata  =  .;
===== arch/sparc64/kernel/ioctl32.c 1.60 vs edited =====
--- 1.60/arch/sparc64/kernel/ioctl32.c	Wed Apr 30 17:56:32 2003
+++ edited/arch/sparc64/kernel/ioctl32.c	Fri May  2 16:47:14 2003
@@ -3833,16 +3833,6 @@
 #define BNEPGETCONNLIST	_IOR('B', 210, int)
 #define BNEPGETCONNINFO	_IOR('B', 211, int)
 
-typedef int (* ioctl32_handler_t)(unsigned int, unsigned int, unsigned long, struct file *);
-
-#define COMPATIBLE_IOCTL(cmd)		HANDLE_IOCTL((cmd),sys_ioctl)
-#define HANDLE_IOCTL(cmd,handler)	{ (cmd), (ioctl32_handler_t)(handler), NULL },
-#define IOCTL_TABLE_START \
-	struct ioctl_trans ioctl_start[] = {
-#define IOCTL_TABLE_END \
-	}; struct ioctl_trans ioctl_end[0];
-
-IOCTL_TABLE_START
 #include <linux/compat_ioctl.h>
 COMPATIBLE_IOCTL(TCSBRKP)
 COMPATIBLE_IOCTL(TIOCSTART)
@@ -4154,4 +4144,3 @@
 HANDLE_IOCTL(BLKBSZGET_32, do_blkbszget)
 HANDLE_IOCTL(BLKBSZSET_32, do_blkbszset)
 HANDLE_IOCTL(BLKGETSIZE64_32, do_blkgetsize64)
-IOCTL_TABLE_END
===== arch/x86_64/vmlinux.lds.S 1.15 vs edited =====
--- 1.15/arch/x86_64/vmlinux.lds.S	Wed Apr  2 10:42:56 2003
+++ edited/arch/x86_64/vmlinux.lds.S	Fri May  2 16:57:36 2003
@@ -33,6 +33,7 @@
 	CONSTRUCTORS
 	}
 
+  COMPAT_IOCTL_TABLE
   _edata = .;			/* End of data section */
 
   __bss_start = .;		/* BSS */
===== arch/x86_64/ia32/ia32_ioctl.c 1.22 vs edited =====
--- 1.22/arch/x86_64/ia32/ia32_ioctl.c	Thu May  1 03:31:08 2003
+++ edited/arch/x86_64/ia32/ia32_ioctl.c	Fri May  2 16:47:14 2003
@@ -3136,14 +3136,6 @@
 	return err;
 } 
 
-#define REF_SYMBOL(handler) if (0) (void)handler;
-#define HANDLE_IOCTL2(cmd,handler) REF_SYMBOL(handler);  asm volatile(".quad %c0, " #handler ",0"::"i" (cmd)); 
-#define HANDLE_IOCTL(cmd,handler) HANDLE_IOCTL2(cmd,handler)
-#define COMPATIBLE_IOCTL(cmd) HANDLE_IOCTL(cmd,sys_ioctl)
-#define IOCTL_TABLE_START void ioctl_dummy(void) { asm volatile("\n.global ioctl_start\nioctl_start:\n\t" );
-#define IOCTL_TABLE_END  asm volatile("\n.global ioctl_end;\nioctl_end:\n"); }
-
-IOCTL_TABLE_START
 #include <linux/compat_ioctl.h>
 COMPATIBLE_IOCTL(HDIO_SET_KEEPSETTINGS)
 COMPATIBLE_IOCTL(HDIO_SCAN_HWIF)
@@ -3380,5 +3372,4 @@
 HANDLE_IOCTL(MTRRIOC32_DEL_PAGE_ENTRY, mtrr_ioctl32)
 HANDLE_IOCTL(MTRRIOC32_GET_PAGE_ENTRY, mtrr_ioctl32)
 HANDLE_IOCTL(MTRRIOC32_KILL_PAGE_ENTRY, mtrr_ioctl32)
-IOCTL_TABLE_END
 

