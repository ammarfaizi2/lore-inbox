Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129317AbRBWBdW>; Thu, 22 Feb 2001 20:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129323AbRBWBdM>; Thu, 22 Feb 2001 20:33:12 -0500
Received: from jalon.able.es ([212.97.163.2]:56035 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129317AbRBWBc6>;
	Thu, 22 Feb 2001 20:32:58 -0500
Date: Fri, 23 Feb 2001 02:32:50 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmio-debug
Message-ID: <20010223023250.A2786@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a patch that makes the __io_virt_debug use conditional. It is mainly
the patch submitted by Jeff Garzik but without the extra configs and a short
text in Configure.help.
(plz check help for my english...)

============= patch-mmio-debug

diff -ruN linux-2.4.2-ac1/Documentation/Configure.help
linux-2.4.2-ac1-mmio/Documentation/Configure.help
--- linux-2.4.2-ac1/Documentation/Configure.help	Thu Feb 22 23:35:34 2001
+++ linux-2.4.2-ac1-mmio/Documentation/Configure.help	Fri Feb 23 01:57:52
2001
@@ -15032,6 +15032,14 @@
   better 32 MB RAM to avoid excessive linking time. This is only
   useful for kernel hackers. If unsure, say N.
 
+Memory mapped I/O debug support
+CONFIG_DEBUG_IOVIRT
+  If you say Y here, all the memory mapped input and output on
+  devices will go through a check to catch access to unmapped
+  ISA addresses, that can still be used by old drivers.
+  If you say N, I/O will be faster and kernel will be a bit smaller,
+  but no check will be done.
+
 Magic System Request Key support
 CONFIG_MAGIC_SYSRQ
   If you say Y here, you will have some control over the system even
diff -ruN linux-2.4.2-ac1/arch/i386/config.in
linux-2.4.2-ac1-mmio/arch/i386/config.in
--- linux-2.4.2-ac1/arch/i386/config.in	Thu Feb 22 23:35:34 2001
+++ linux-2.4.2-ac1-mmio/arch/i386/config.in	Fri Feb 23 00:58:52 2001
@@ -370,5 +370,6 @@
 comment 'Kernel hacking'
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
+bool 'Memory mapped I/O debugging' CONFIG_DEBUG_IOVIRT
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 endmenu
diff -ruN linux-2.4.2-ac1/arch/i386/defconfig
linux-2.4.2-ac1-mmio/arch/i386/defconfig
--- linux-2.4.2-ac1/arch/i386/defconfig	Thu Feb 22 11:29:09 2001
+++ linux-2.4.2-ac1-mmio/arch/i386/defconfig	Fri Feb 23 00:49:32 2001
@@ -721,4 +721,5 @@
 #
 # Kernel hacking
 #
+CONFIG_DEBUG_IOVIRT=y
 # CONFIG_MAGIC_SYSRQ is not set
diff -ruN linux-2.4.2-ac1/arch/i386/kernel/i386_ksyms.c
linux-2.4.2-ac1-mmio/arch/i386/kernel/i386_ksyms.c
--- linux-2.4.2-ac1/arch/i386/kernel/i386_ksyms.c	Thu Feb 22 23:35:34
2001
+++ linux-2.4.2-ac1-mmio/arch/i386/kernel/i386_ksyms.c	Fri Feb 23
01:02:44 2001
@@ -60,7 +60,9 @@
 EXPORT_SYMBOL(dump_extended_fpu);
 EXPORT_SYMBOL(__ioremap);
 EXPORT_SYMBOL(iounmap);
+#ifdef CONFIG_DEBUG_IOVIRT
 EXPORT_SYMBOL(__io_virt_debug);
+#endif
 EXPORT_SYMBOL(enable_irq);
 EXPORT_SYMBOL(disable_irq);
 EXPORT_SYMBOL(disable_irq_nosync);
diff -ruN linux-2.4.2-ac1/arch/i386/lib/Makefile
linux-2.4.2-ac1-mmio/arch/i386/lib/Makefile
--- linux-2.4.2-ac1/arch/i386/lib/Makefile	Thu Feb 22 23:35:34 2001
+++ linux-2.4.2-ac1-mmio/arch/i386/lib/Makefile	Fri Feb 23 01:03:43 2001
@@ -8,10 +8,11 @@
 L_TARGET = lib.a
 
 obj-y = checksum.o old-checksum.o delay.o \
-	usercopy.o getuser.o putuser.o iodebug.o \
+	usercopy.o getuser.o putuser.o \
 	memcpy.o strstr.o
 
 obj-$(CONFIG_X86_USE_3DNOW) += mmx.o
 obj-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
+obj-$(CONFIG_DEBUG_IOVIRT)  += iodebug.o
 
 include $(TOPDIR)/Rules.make
diff -ruN linux-2.4.2-ac1/include/asm-i386/io.h
linux-2.4.2-ac1-mmio/include/asm-i386/io.h
--- linux-2.4.2-ac1/include/asm-i386/io.h	Tue Jan 30 00:48:52 2001
+++ linux-2.4.2-ac1-mmio/include/asm-i386/io.h	Fri Feb 23 02:12:31 2001
@@ -1,6 +1,8 @@
 #ifndef _ASM_IO_H
 #define _ASM_IO_H
 
+#include <linux/config.h>
+
 /*
  * This file contains the definitions for the x86 IO instructions
  * inb/inw/inl/outb/outw/outl and the "string versions" of the same
@@ -111,7 +113,7 @@
  * Temporary debugging check to catch old code using
  * unmapped ISA addresses. Will be removed in 2.4.
  */
-#if 1
+#if CONFIG_DEBUG_IOVIRT
   extern void *__io_virt_debug(unsigned long x, const char *file, int line);
   extern unsigned long __io_phys_debug(unsigned long x, const char *file, int
line);
   #define __io_virt(x) __io_virt_debug((unsigned long)(x), __FILE__, __LINE__)


-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.2 #1 SMP Thu Feb 22 11:40:37 CET 2001 i686

