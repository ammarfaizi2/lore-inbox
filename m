Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbUBZCVr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 21:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbUBZCVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 21:21:47 -0500
Received: from pxy2allmi.all.mi.charter.com ([24.247.15.40]:6575 "EHLO
	proxy2-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S261435AbUBZCVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 21:21:05 -0500
Message-ID: <403D58D2.4020903@quark.didntduck.org>
Date: Wed, 25 Feb 2004 21:24:18 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] remove __io_virt_debug
Content-Type: multipart/mixed;
 boundary="------------030606030809090301010509"
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030606030809090301010509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Drivers should all be converted to use ioremap() or isa_*() by now.

--
				Brian Gerst

--------------030606030809090301010509
Content-Type: text/plain;
 name="io_virt-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="io_virt-1"

diff -urN linux-bk/arch/i386/Kconfig linux/arch/i386/Kconfig
--- linux-bk/arch/i386/Kconfig	2004-02-20 21:37:32.895756504 -0500
+++ linux/arch/i386/Kconfig	2004-02-21 19:40:17.906440952 -0500
@@ -1231,17 +1231,6 @@
 	  allocation as well as poisoning memory on free to catch use of freed
 	  memory.
 
-config DEBUG_IOVIRT
-	bool "Memory mapped I/O debugging"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here to get warned whenever an attempt is made to do I/O on
-	  obviously invalid addresses such as those generated when ioremap()
-	  calls are forgotten.  Memory mapped I/O will go through an extra
-	  check to catch access to unmapped ISA addresses, an access method
-	  that can still be used by old drivers that are being ported from
-	  2.0/2.2.
-
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
 	depends on DEBUG_KERNEL
diff -urN linux-bk/arch/i386/kernel/i386_ksyms.c linux/arch/i386/kernel/i386_ksyms.c
--- linux-bk/arch/i386/kernel/i386_ksyms.c	2004-02-18 01:37:14.000000000 -0500
+++ linux/arch/i386/kernel/i386_ksyms.c	2004-02-21 19:40:12.789218888 -0500
@@ -88,10 +88,6 @@
 EXPORT_SYMBOL(cpu_khz);
 EXPORT_SYMBOL(apm_info);
 
-#ifdef CONFIG_DEBUG_IOVIRT
-EXPORT_SYMBOL(__io_virt_debug);
-#endif
-
 EXPORT_SYMBOL_NOVERS(__down_failed);
 EXPORT_SYMBOL_NOVERS(__down_failed_interruptible);
 EXPORT_SYMBOL_NOVERS(__down_failed_trylock);
diff -urN linux-bk/arch/i386/lib/iodebug.c linux/arch/i386/lib/iodebug.c
--- linux-bk/arch/i386/lib/iodebug.c	2003-12-17 21:59:37.000000000 -0500
+++ linux/arch/i386/lib/iodebug.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,11 +0,0 @@
-#include <asm/io.h>
-
-void * __io_virt_debug(unsigned long x, const char *file, int line)
-{
-	if (x < PAGE_OFFSET) {
-		printk("io mapaddr 0x%05lx not valid at %s:%d!\n", x, file, line);
-		return __va(x);
-	}
-	return (void *)x;
-}
-
diff -urN linux-bk/arch/i386/lib/Makefile linux/arch/i386/lib/Makefile
--- linux-bk/arch/i386/lib/Makefile	2003-12-17 21:58:07.000000000 -0500
+++ linux/arch/i386/lib/Makefile	2004-02-21 19:39:35.010962056 -0500
@@ -9,4 +9,3 @@
 
 lib-$(CONFIG_X86_USE_3DNOW) += mmx.o
 lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
-lib-$(CONFIG_DEBUG_IOVIRT)  += iodebug.o
diff -urN linux-bk/arch/x86_64/kernel/x8664_ksyms.c linux/arch/x86_64/kernel/x8664_ksyms.c
--- linux-bk/arch/x86_64/kernel/x8664_ksyms.c	2004-02-20 21:37:34.634492176 -0500
+++ linux/arch/x86_64/kernel/x8664_ksyms.c	2004-02-21 19:50:22.381546768 -0500
@@ -61,10 +61,6 @@
 EXPORT_SYMBOL(pm_power_off);
 EXPORT_SYMBOL(get_cmos_time);
 
-#ifdef CONFIG_IO_DEBUG
-EXPORT_SYMBOL(__io_virt_debug);
-#endif
-
 EXPORT_SYMBOL_NOVERS(__down_failed);
 EXPORT_SYMBOL_NOVERS(__down_failed_interruptible);
 EXPORT_SYMBOL_NOVERS(__down_failed_trylock);
diff -urN linux-bk/arch/x86_64/lib/io.c linux/arch/x86_64/lib/io.c
--- linux-bk/arch/x86_64/lib/io.c	2003-12-17 21:58:08.000000000 -0500
+++ linux/arch/x86_64/lib/io.c	2004-02-21 19:52:47.010559816 -0500
@@ -4,12 +4,12 @@
 
 void *memcpy_toio(void *dst,const void*src,unsigned len)
 {
-	return __inline_memcpy(__io_virt(dst),src,len);
+	return __inline_memcpy(dst,src,len);
 }
 
 void *memcpy_fromio(void *dst,const void*src,unsigned len)
 {
-	return __inline_memcpy(dst,__io_virt(src),len);
+	return __inline_memcpy(dst,src,len);
 }
 
 EXPORT_SYMBOL(memcpy_toio);
diff -urN linux-bk/arch/x86_64/lib/iodebug.c linux/arch/x86_64/lib/iodebug.c
--- linux-bk/arch/x86_64/lib/iodebug.c	2003-12-17 21:58:57.000000000 -0500
+++ linux/arch/x86_64/lib/iodebug.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,11 +0,0 @@
-#include <asm/io.h>
-
-void * __io_virt_debug(unsigned long x, const char *file, int line)
-{
-	if (x < PAGE_OFFSET) {
-		printk("io mapaddr 0x%05lx not valid at %s:%d!\n", x, file, line);
-		return __va(x);
-	}
-	return (void *)x;
-}
-
diff -urN linux-bk/arch/x86_64/lib/Makefile linux/arch/x86_64/lib/Makefile
--- linux-bk/arch/x86_64/lib/Makefile	2003-12-17 21:58:16.000000000 -0500
+++ linux/arch/x86_64/lib/Makefile	2004-02-21 19:49:49.693516104 -0500
@@ -9,5 +9,4 @@
 	thunk.o io.o clear_page.o copy_page.o bitstr.o
 lib-y += memcpy.o memmove.o memset.o copy_user.o
 
-lib-$(CONFIG_IO_DEBUG) += iodebug.o
 lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
diff -urN linux-bk/include/asm-i386/io.h linux/include/asm-i386/io.h
--- linux-bk/include/asm-i386/io.h	2004-02-18 01:37:26.000000000 -0500
+++ linux/include/asm-i386/io.h	2004-02-21 19:45:07.305445616 -0500
@@ -45,17 +45,6 @@
 
 #include <linux/vmalloc.h>
 
-/*
- * Temporary debugging check to catch old code using
- * unmapped ISA addresses. Will be removed in 2.4.
- */
-#ifdef CONFIG_DEBUG_IOVIRT
-  extern void *__io_virt_debug(unsigned long x, const char *file, int line);
-  #define __io_virt(x) __io_virt_debug((unsigned long)(x), __FILE__, __LINE__)
-#else
-  #define __io_virt(x) ((void *)(x))
-#endif
-
 /**
  *	virt_to_phys	-	map virtual addresses to physical
  *	@address: address to remap
@@ -150,9 +139,9 @@
  * memory location directly.
  */
 
-#define readb(addr) (*(volatile unsigned char *) __io_virt(addr))
-#define readw(addr) (*(volatile unsigned short *) __io_virt(addr))
-#define readl(addr) (*(volatile unsigned int *) __io_virt(addr))
+#define readb(addr) (*(volatile unsigned char *) (addr))
+#define readw(addr) (*(volatile unsigned short *) (addr))
+#define readl(addr) (*(volatile unsigned int *) (addr))
 #define readb_relaxed(addr) readb(addr)
 #define readw_relaxed(addr) readw(addr)
 #define readl_relaxed(addr) readl(addr)
@@ -160,16 +149,16 @@
 #define __raw_readw readw
 #define __raw_readl readl
 
-#define writeb(b,addr) (*(volatile unsigned char *) __io_virt(addr) = (b))
-#define writew(b,addr) (*(volatile unsigned short *) __io_virt(addr) = (b))
-#define writel(b,addr) (*(volatile unsigned int *) __io_virt(addr) = (b))
+#define writeb(b,addr) (*(volatile unsigned char *) (addr) = (b))
+#define writew(b,addr) (*(volatile unsigned short *) (addr) = (b))
+#define writel(b,addr) (*(volatile unsigned int *) (addr) = (b))
 #define __raw_writeb writeb
 #define __raw_writew writew
 #define __raw_writel writel
 
-#define memset_io(a,b,c)	memset(__io_virt(a),(b),(c))
-#define memcpy_fromio(a,b,c)	__memcpy((a),__io_virt(b),(c))
-#define memcpy_toio(a,b,c)	__memcpy(__io_virt(a),(b),(c))
+#define memset_io(a,b,c)	memset((void *)(a),(b),(c))
+#define memcpy_fromio(a,b,c)	__memcpy((a),(void *)(b),(c))
+#define memcpy_toio(a,b,c)	__memcpy((void *)(a),(b),(c))
 
 /*
  * ISA space is 'always mapped' on a typical x86 system, no need to
@@ -196,8 +185,8 @@
  * Again, i386 does not require mem IO specific function.
  */
 
-#define eth_io_copy_and_sum(a,b,c,d)		eth_copy_and_sum((a),__io_virt(b),(c),(d))
-#define isa_eth_io_copy_and_sum(a,b,c,d)	eth_copy_and_sum((a),__io_virt(__ISA_IO_base + (b)),(c),(d))
+#define eth_io_copy_and_sum(a,b,c,d)		eth_copy_and_sum((a),(void *)(b),(c),(d))
+#define isa_eth_io_copy_and_sum(a,b,c,d)	eth_copy_and_sum((a),(void *)(__ISA_IO_base + (b)),(c),(d))
 
 /**
  *	check_signature		-	find BIOS signatures
diff -urN linux-bk/include/asm-x86_64/io.h linux/include/asm-x86_64/io.h
--- linux-bk/include/asm-x86_64/io.h	2004-02-18 01:37:27.000000000 -0500
+++ linux/include/asm-x86_64/io.h	2004-02-21 19:52:07.037636624 -0500
@@ -109,17 +109,6 @@
 
 #include <linux/vmalloc.h>
 
-/*
- * Temporary debugging check to catch old code using
- * unmapped ISA addresses. Will be removed in 2.4.
- */
-#ifdef CONFIG_IO_DEBUG
-  extern void *__io_virt_debug(unsigned long x, const char *file, int line);
-  #define __io_virt(x) __io_virt_debug((unsigned long)(x), __FILE__, __LINE__)
-#else
-  #define __io_virt(x) ((void *)(x))
-#endif
-
 #ifndef __i386__
 /*
  * Change virtual addresses to physical addresses and vv.
@@ -184,10 +173,10 @@
  * memory location directly.
  */
 
-#define readb(addr) (*(volatile unsigned char *) __io_virt(addr))
-#define readw(addr) (*(volatile unsigned short *) __io_virt(addr))
-#define readl(addr) (*(volatile unsigned int *) __io_virt(addr))
-#define readq(addr) (*(volatile unsigned long *) __io_virt(addr))
+#define readb(addr) (*(volatile unsigned char *) (addr))
+#define readw(addr) (*(volatile unsigned short *) (addr))
+#define readl(addr) (*(volatile unsigned int *) (addr))
+#define readq(addr) (*(volatile unsigned long *) (addr))
 #define readb_relaxed(a) readb(a)
 #define readw_relaxed(a) readw(a)
 #define readl_relaxed(a) readl(a)
@@ -197,10 +186,10 @@
 #define __raw_readl readl
 #define __raw_readq readq
 
-#define writeb(b,addr) (*(volatile unsigned char *) __io_virt(addr) = (b))
-#define writew(b,addr) (*(volatile unsigned short *) __io_virt(addr) = (b))
-#define writel(b,addr) (*(volatile unsigned int *) __io_virt(addr) = (b))
-#define writeq(b,addr) (*(volatile unsigned long *) __io_virt(addr) = (b))
+#define writeb(b,addr) (*(volatile unsigned char *) (addr) = (b))
+#define writew(b,addr) (*(volatile unsigned short *) (addr) = (b))
+#define writel(b,addr) (*(volatile unsigned int *) (addr) = (b))
+#define writeq(b,addr) (*(volatile unsigned long *) (addr) = (b))
 #define __raw_writeb writeb
 #define __raw_writew writew
 #define __raw_writel writel
@@ -208,7 +197,7 @@
 
 void *memcpy_fromio(void*,const void*,unsigned); 
 void *memcpy_toio(void*,const void*,unsigned); 
-#define memset_io(a,b,c)	memset(__io_virt(a),(b),(c))
+#define memset_io(a,b,c)	memset((void *)(a),(b),(c))
 
 /*
  * ISA space is 'always mapped' on a typical x86 system, no need to
@@ -235,8 +224,8 @@
  * Again, x86-64 does not require mem IO specific function.
  */
 
-#define eth_io_copy_and_sum(a,b,c,d)		eth_copy_and_sum((a),__io_virt(b),(c),(d))
-#define isa_eth_io_copy_and_sum(a,b,c,d)	eth_copy_and_sum((a),__io_virt(__ISA_IO_base + (b)),(c),(d))
+#define eth_io_copy_and_sum(a,b,c,d)		eth_copy_and_sum((a),(void *)(b),(c),(d))
+#define isa_eth_io_copy_and_sum(a,b,c,d)	eth_copy_and_sum((a),(void *)(__ISA_IO_base + (b)),(c),(d))
 
 /**
  *	check_signature		-	find BIOS signatures

--------------030606030809090301010509--
