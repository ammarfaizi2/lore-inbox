Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRBQRFD>; Sat, 17 Feb 2001 12:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129581AbRBQREx>; Sat, 17 Feb 2001 12:04:53 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:30496 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129183AbRBQREs>; Sat, 17 Feb 2001 12:04:48 -0500
Date: Sat, 17 Feb 2001 11:04:12 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Hugh Dickins <hugh@veritas.com>, Paul Gortmaker <p_gortmaker@yahoo.com>,
        Keith Owens <kaos@ocs.com.au>,
        linux-kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] conditionalize __io_virt_debug
In-Reply-To: <20010217161426.A981@werewolf.able.es>
Message-ID: <Pine.LNX.3.96.1010217110040.10869A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Feb 2001, J . A . Magallon wrote:
> On 02.17 J . A . Magallon wrote:
> > #if 1
> >   extern void *__io_virt_debug(unsigned long x, const char *file, int line);
> >   extern unsigned long __io_phys_debug(unsigned long x, const char *file, int
> > li
> > ne);
> >   #define __io_virt(x) __io_virt_debug((unsigned long)(x), __FILE__, __LINE__)
> > //#define __io_phys(x) __io_phys_debug((unsigned long)(x), __FILE__, __LINE__)
> > #else
> >   #define __io_virt(x) ((void *)(x))
> > //#define __io_phys(x) __pa(x)
> > #endif
> > ..
> 
> Loking at it (arch/i386/lib/iodebug.c):
> void * __io_virt_debug(unsigned long x, const char *file, int line)
> {
>     if (x < PAGE_OFFSET) {
>         printk("io mapaddr 0x%05lx not valid at %s:%d!\n", x, file, line);
>         return __va(x);
>     }
>     return (void *)x;
> }
> 
> is changed (if you turn off the #if 1), from 1_function_call+1_if+cache
> pollution with the function code to nothing (just a cast).
> This will make some difference in performance, won't it ?

Speaking of io_virt_debug... This patch that makes all your MMIO
devices run faster, simply by eliminating io_virt_debug :)

(sorry for the CONFIG_VMDUMP pollution in config.in... I'm too slack
to rediff nicely)

	Jeff




Index: linux_2_4/arch/i386/config.in
diff -u linux_2_4/arch/i386/config.in:1.1.1.20 linux_2_4/arch/i386/config.in:1.1.1.20.2.2
--- linux_2_4/arch/i386/config.in:1.1.1.20	Fri Feb  9 15:23:38 2001
+++ linux_2_4/arch/i386/config.in	Fri Feb  9 19:15:10 2001
@@ -365,5 +365,7 @@
 comment 'Kernel hacking'
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
+bool 'I/O read/write debugging' CONFIG_DEBUG_IOVIRT
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Support kernel crash dump capabilities' CONFIG_VMDUMP
 endmenu
Index: linux_2_4/arch/i386/kernel/i386_ksyms.c
diff -u linux_2_4/arch/i386/kernel/i386_ksyms.c:1.1.1.14 linux_2_4/arch/i386/kernel/i386_ksyms.c:1.1.1.14.2.1
--- linux_2_4/arch/i386/kernel/i386_ksyms.c:1.1.1.14	Fri Feb  9 15:23:46 2001
+++ linux_2_4/arch/i386/kernel/i386_ksyms.c	Fri Feb  9 15:52:23 2001
@@ -59,7 +60,9 @@
 EXPORT_SYMBOL(dump_extended_fpu);
 EXPORT_SYMBOL(__ioremap);
 EXPORT_SYMBOL(iounmap);
+#ifdef CONFIG_DEBUG_IOVIRT
 EXPORT_SYMBOL(__io_virt_debug);
+#endif
 EXPORT_SYMBOL(enable_irq);
 EXPORT_SYMBOL(disable_irq);
 EXPORT_SYMBOL(disable_irq_nosync);
Index: linux_2_4/arch/i386/lib/Makefile
diff -u linux_2_4/arch/i386/lib/Makefile:1.1.1.11 linux_2_4/arch/i386/lib/Makefile:1.1.1.11.2.1
--- linux_2_4/arch/i386/lib/Makefile:1.1.1.11	Fri Feb  9 15:23:43 2001
+++ linux_2_4/arch/i386/lib/Makefile	Fri Feb  9 15:52:23 2001
@@ -8,10 +8,11 @@
 L_TARGET = lib.a
 
 obj-y = checksum.o old-checksum.o delay.o \
-	usercopy.o getuser.o putuser.o iodebug.o \
+	usercopy.o getuser.o putuser.o \
 	memcpy.o
 
 obj-$(CONFIG_X86_USE_3DNOW) += mmx.o
 obj-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
+obj-$(CONFIG_DEBUG_IOVIRT)  += iodebug.o
 
 include $(TOPDIR)/Rules.make
Index: linux_2_4/include/asm-i386/io.h
diff -u linux_2_4/include/asm-i386/io.h:1.1.1.1 linux_2_4/include/asm-i386/io.h:1.1.1.1.118.1
--- linux_2_4/include/asm-i386/io.h:1.1.1.1	Sun Oct 22 12:36:21 2000
+++ linux_2_4/include/asm-i386/io.h	Fri Feb  9 15:52:29 2001
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
   extern unsigned long __io_phys_debug(unsigned long x, const char *file, int line);
   #define __io_virt(x) __io_virt_debug((unsigned long)(x), __FILE__, __LINE__)

