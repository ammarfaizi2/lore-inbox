Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317063AbSHJPac>; Sat, 10 Aug 2002 11:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317066AbSHJPac>; Sat, 10 Aug 2002 11:30:32 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:36366 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S317063AbSHJPa2>; Sat, 10 Aug 2002 11:30:28 -0400
Date: Sat, 10 Aug 2002 19:33:49 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>,
       Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5.30] alpha: misc fixes [9/10]
Message-ID: <20020810193349.H20534@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Set of small fixes:
- pcibios_init() must be int;
- fls() - ctlz on ev67, generic on others. This was required for
  something several kernel releases back, now it seems to be unused.
  Anyway, it shouldn't hurt, so included here.
- missing #includes, missing #if RTC_IRQ in drivers/char/rtc.c;
- define USER_HZ;
>From Jeff Wiedemeier:
- rename alpha-specific config section 'General setup' to 'System setup'
  to avoid confusion with generic 'General setup';
- fix the 'bootpfile' build.

Ivan.

--- 2.5.30/arch/alpha/kernel/pci.c	Fri Aug  2 01:16:06 2002
+++ linux/arch/alpha/kernel/pci.c	Thu Aug  8 19:28:01 2002
@@ -190,12 +190,12 @@ pcibios_align_resource(void *data, struc
 #undef MB
 #undef GB
 
-static void __init
+static int __init
 pcibios_init(void)
 {
-	if (!alpha_mv.init_pci)
-		return;
-	alpha_mv.init_pci();
+	if (alpha_mv.init_pci)
+		alpha_mv.init_pci();
+	return 0;
 }
 
 subsys_initcall(pcibios_init);
--- 2.5.30/arch/alpha/kernel/signal.c	Fri Aug  2 01:16:24 2002
+++ linux/arch/alpha/kernel/signal.c	Thu Aug  8 19:28:01 2002
@@ -18,6 +18,7 @@
 #include <linux/smp_lock.h>
 #include <linux/stddef.h>
 #include <linux/tty.h>
+#include <linux/binfmts.h>
 
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
--- 2.5.30/include/asm-alpha/bitops.h	Fri Aug  2 01:16:26 2002
+++ linux/include/asm-alpha/bitops.h	Thu Aug  8 19:28:02 2002
@@ -315,6 +315,20 @@ static inline int ffs(int word)
 	return word ? result+1 : 0;
 }
 
+/*
+ * fls: find last bit set.
+ */
+#if defined(__alpha_cix__) && defined(__alpha_fix__)
+static inline int fls(int word)
+{
+	long result;
+	__asm__("ctlz %1,%0" : "=r"(result) : "r"(word & 0xffffffff));
+	return 64 - result;
+}
+#else
+#define fls	generic_fls
+#endif
+
 /* Compute powers of two for the given integer.  */
 static inline int floor_log2(unsigned long word)
 {
--- 2.5.30/include/asm-alpha/pgalloc.h	Fri Aug  2 01:16:02 2002
+++ linux/include/asm-alpha/pgalloc.h	Thu Aug  8 19:28:02 2002
@@ -2,6 +2,7 @@
 #define _ALPHA_PGALLOC_H
 
 #include <linux/config.h>
+#include <linux/mm.h>
 
 /*      
  * Allocate and free page tables. The xxx_kernel() versions are
--- 2.5.30/include/asm-alpha/param.h	Fri Aug  2 01:16:22 2002
+++ linux/include/asm-alpha/param.h	Thu Aug  8 19:28:02 2002
@@ -15,6 +15,8 @@
 # endif
 #endif
 
+#define USER_HZ		HZ
+
 #define EXEC_PAGESIZE	8192
 
 #ifndef NGROUPS
--- 2.5.30/arch/alpha/config.in	Fri Aug  2 01:16:14 2002
+++ linux/arch/alpha/config.in	Thu Aug  8 19:49:18 2002
@@ -11,7 +11,7 @@ define_bool CONFIG_RWSEM_XCHGADD_ALGORIT
 source init/Config.in
 
 mainmenu_option next_comment
-comment 'General setup'
+comment 'System setup'
 
 choice 'Alpha system type' \
 	"Generic		CONFIG_ALPHA_GENERIC		\
--- 2.5.30/arch/alpha/boot/Makefile	Fri Aug  2 01:16:12 2002
+++ linux/arch/alpha/boot/Makefile	Thu Aug  8 19:45:03 2002
@@ -20,6 +20,7 @@ BPOBJECTS = head.o bootp.o
 TARGETS = vmlinux.gz tools/objstrip # also needed by aboot & milo
 VMLINUX = $(TOPDIR)/vmlinux
 OBJSTRIP = tools/objstrip
+LIBS := $(patsubst lib/%,$(TOPDIR)/lib/%,$(LIBS))
 
 all:	$(TARGETS)
 	@echo Ready to install kernel in $(shell pwd)/vmlinux.gz
--- 2.5.30/drivers/char/rtc.c	Fri Aug  2 01:16:21 2002
+++ linux/drivers/char/rtc.c	Thu Aug  8 19:28:01 2002
@@ -870,7 +870,9 @@ no_irq:
 
 	if (misc_register(&rtc_dev))
 		{
+#if RTC_IRQ
 		free_irq(RTC_IRQ, NULL);
+#endif
 		release_region(RTC_PORT(0), RTC_IO_EXTENT);
 		return -ENODEV;
 		}
