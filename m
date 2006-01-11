Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbWAKWlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWAKWlz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 17:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWAKWlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 17:41:31 -0500
Received: from mx.pathscale.com ([64.160.42.68]:20172 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932469AbWAKWl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 17:41:27 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 3 of 3] Add __raw_memcpy_toio32 to each arch
X-Mercurial-Node: ee6ce7e55dc7aec0d87007cf868b6a2702e03a00
Message-Id: <ee6ce7e55dc7aec0d870.1137019197@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1137019194@eng-12.pathscale.com>
Date: Wed, 11 Jan 2006 14:39:57 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, ak@suse.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most arches use the generic routine.  x86_64 uses memcpy32 instead;
this is substantially faster, even over a bus that is much slower than
the CPU.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 1052904816d7 -r ee6ce7e55dc7 arch/x86_64/lib/io.c
--- a/arch/x86_64/lib/io.c	Wed Jan 11 14:35:45 2006 -0800
+++ b/arch/x86_64/lib/io.c	Wed Jan 11 14:35:45 2006 -0800
@@ -21,3 +21,9 @@
 	memset((void *)a,b,c);
 }
 EXPORT_SYMBOL(memset_io);
+
+/* override generic definition in lib/raw_memcpy_io.c */
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count)
+{
+	memcpy32((void __force *) to, from, count);
+}
diff -r 1052904816d7 -r ee6ce7e55dc7 include/asm-alpha/io.h
--- a/include/asm-alpha/io.h	Wed Jan 11 14:35:45 2006 -0800
+++ b/include/asm-alpha/io.h	Wed Jan 11 14:35:45 2006 -0800
@@ -504,6 +504,8 @@
 extern void memcpy_toio(volatile void __iomem *, const void *, long);
 extern void _memset_c_io(volatile void __iomem *, unsigned long, long);
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 static inline void memset_io(volatile void __iomem *addr, u8 c, long len)
 {
 	_memset_c_io(addr, 0x0101010101010101UL * c, len);
diff -r 1052904816d7 -r ee6ce7e55dc7 include/asm-arm/io.h
--- a/include/asm-arm/io.h	Wed Jan 11 14:35:45 2006 -0800
+++ b/include/asm-arm/io.h	Wed Jan 11 14:35:45 2006 -0800
@@ -189,6 +189,8 @@
 #define memset_io(c,v,l)	_memset_io(__mem_pci(c),(v),(l))
 #define memcpy_fromio(a,c,l)	_memcpy_fromio((a),__mem_pci(c),(l))
 #define memcpy_toio(c,a,l)	_memcpy_toio(__mem_pci(c),(a),(l))
+
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
 
 #define eth_io_copy_and_sum(s,c,l,b) \
 				eth_copy_and_sum((s),__mem_pci(c),(l),(b))
diff -r 1052904816d7 -r ee6ce7e55dc7 include/asm-cris/io.h
--- a/include/asm-cris/io.h	Wed Jan 11 14:35:45 2006 -0800
+++ b/include/asm-cris/io.h	Wed Jan 11 14:35:45 2006 -0800
@@ -121,6 +121,8 @@
 #define memcpy_fromio(a,b,c)	memcpy((a),(void *)(b),(c))
 #define memcpy_toio(a,b,c)	memcpy((void *)(a),(b),(c))
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 /*
  * Again, CRIS does not require mem IO specific function.
  */
diff -r 1052904816d7 -r ee6ce7e55dc7 include/asm-frv/io.h
--- a/include/asm-frv/io.h	Wed Jan 11 14:35:45 2006 -0800
+++ b/include/asm-frv/io.h	Wed Jan 11 14:35:45 2006 -0800
@@ -127,6 +127,8 @@
 	memcpy((void __force *) dst, src, count);
 }
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 static inline uint8_t inb(unsigned long addr)
 {
 	return __builtin_read8((void *)addr);
diff -r 1052904816d7 -r ee6ce7e55dc7 include/asm-h8300/io.h
--- a/include/asm-h8300/io.h	Wed Jan 11 14:35:45 2006 -0800
+++ b/include/asm-h8300/io.h	Wed Jan 11 14:35:45 2006 -0800
@@ -209,6 +209,8 @@
 #define memcpy_fromio(a,b,c)	memcpy((a),(void *)(b),(c))
 #define memcpy_toio(a,b,c)	memcpy((void *)(a),(b),(c))
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 #define mmiowb()
 
 #define inb(addr)    ((h8300_buswidth(addr))?readw((addr) & ~1) & 0xff:readb(addr))
diff -r 1052904816d7 -r ee6ce7e55dc7 include/asm-i386/io.h
--- a/include/asm-i386/io.h	Wed Jan 11 14:35:45 2006 -0800
+++ b/include/asm-i386/io.h	Wed Jan 11 14:35:45 2006 -0800
@@ -203,6 +203,8 @@
 {
 	__memcpy((void __force *) dst, src, count);
 }
+
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
 
 /*
  * ISA space is 'always mapped' on a typical x86 system, no need to
diff -r 1052904816d7 -r ee6ce7e55dc7 include/asm-ia64/io.h
--- a/include/asm-ia64/io.h	Wed Jan 11 14:35:45 2006 -0800
+++ b/include/asm-ia64/io.h	Wed Jan 11 14:35:45 2006 -0800
@@ -444,6 +444,8 @@
 extern void memcpy_toio(volatile void __iomem *dst, const void *src, long n);
 extern void memset_io(volatile void __iomem *s, int c, long n);
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 #define dma_cache_inv(_start,_size)             do { } while (0)
 #define dma_cache_wback(_start,_size)           do { } while (0)
 #define dma_cache_wback_inv(_start,_size)       do { } while (0)
diff -r 1052904816d7 -r ee6ce7e55dc7 include/asm-m32r/io.h
--- a/include/asm-m32r/io.h	Wed Jan 11 14:35:45 2006 -0800
+++ b/include/asm-m32r/io.h	Wed Jan 11 14:35:45 2006 -0800
@@ -216,6 +216,8 @@
 	memcpy((void __force *) dst, src, count);
 }
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
diff -r 1052904816d7 -r ee6ce7e55dc7 include/asm-m68knommu/io.h
--- a/include/asm-m68knommu/io.h	Wed Jan 11 14:35:45 2006 -0800
+++ b/include/asm-m68knommu/io.h	Wed Jan 11 14:35:45 2006 -0800
@@ -113,6 +113,8 @@
 #define memcpy_fromio(a,b,c)	memcpy((a),(void *)(b),(c))
 #define memcpy_toio(a,b,c)	memcpy((void *)(a),(b),(c))
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 #define inb(addr)    readb(addr)
 #define inw(addr)    readw(addr)
 #define inl(addr)    readl(addr)
diff -r 1052904816d7 -r ee6ce7e55dc7 include/asm-mips/io.h
--- a/include/asm-mips/io.h	Wed Jan 11 14:35:45 2006 -0800
+++ b/include/asm-mips/io.h	Wed Jan 11 14:35:45 2006 -0800
@@ -534,6 +534,8 @@
 	memcpy((void __force *) dst, src, count);
 }
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 /*
  * Memory Mapped I/O
  */
diff -r 1052904816d7 -r ee6ce7e55dc7 include/asm-parisc/io.h
--- a/include/asm-parisc/io.h	Wed Jan 11 14:35:45 2006 -0800
+++ b/include/asm-parisc/io.h	Wed Jan 11 14:35:45 2006 -0800
@@ -294,6 +294,8 @@
 void memcpy_fromio(void *dst, const volatile void __iomem *src, int count);
 void memcpy_toio(volatile void __iomem *dst, const void *src, int count);
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 /* Support old drivers which don't ioremap.
  * NB this interface is scheduled to disappear in 2.5
  */
diff -r 1052904816d7 -r ee6ce7e55dc7 include/asm-powerpc/io.h
--- a/include/asm-powerpc/io.h	Wed Jan 11 14:35:45 2006 -0800
+++ b/include/asm-powerpc/io.h	Wed Jan 11 14:35:45 2006 -0800
@@ -64,6 +64,8 @@
 #define memcpy_fromio(a,b,c)	iSeries_memcpy_fromio((a), (b), (c))
 #define memcpy_toio(a,b,c)	iSeries_memcpy_toio((a), (b), (c))
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 #define inb(addr)		readb(((void __iomem *)(long)(addr)))
 #define inw(addr)		readw(((void __iomem *)(long)(addr)))
 #define inl(addr)		readl(((void __iomem *)(long)(addr)))
diff -r 1052904816d7 -r ee6ce7e55dc7 include/asm-ppc/io.h
--- a/include/asm-ppc/io.h	Wed Jan 11 14:35:45 2006 -0800
+++ b/include/asm-ppc/io.h	Wed Jan 11 14:35:45 2006 -0800
@@ -369,6 +369,8 @@
 }
 #endif
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 #define eth_io_copy_and_sum(a,b,c,d)		eth_copy_and_sum((a),(void __force *)(void __iomem *)(b),(c),(d))
 
 /*
diff -r 1052904816d7 -r ee6ce7e55dc7 include/asm-s390/io.h
--- a/include/asm-s390/io.h	Wed Jan 11 14:35:45 2006 -0800
+++ b/include/asm-s390/io.h	Wed Jan 11 14:35:45 2006 -0800
@@ -99,6 +99,8 @@
 #define memcpy_fromio(a,b,c)    memcpy((a),__io_virt(b),(c))
 #define memcpy_toio(a,b,c)      memcpy(__io_virt(a),(b),(c))
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 #define inb_p(addr) readb(addr)
 #define inb(addr) readb(addr)
 
diff -r 1052904816d7 -r ee6ce7e55dc7 include/asm-sh/io.h
--- a/include/asm-sh/io.h	Wed Jan 11 14:35:45 2006 -0800
+++ b/include/asm-sh/io.h	Wed Jan 11 14:35:45 2006 -0800
@@ -177,6 +177,8 @@
 extern void memcpy_toio(unsigned long, const void *, unsigned long);
 extern void memset_io(unsigned long, int, unsigned long);
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 /* SuperH on-chip I/O functions */
 static __inline__ unsigned char ctrl_inb(unsigned long addr)
 {
diff -r 1052904816d7 -r ee6ce7e55dc7 include/asm-sh64/io.h
--- a/include/asm-sh64/io.h	Wed Jan 11 14:35:45 2006 -0800
+++ b/include/asm-sh64/io.h	Wed Jan 11 14:35:45 2006 -0800
@@ -125,6 +125,8 @@
 
 void memcpy_toio(void __iomem *to, const void *from, long count);
 void memcpy_fromio(void *to, void __iomem *from, long count);
+
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
 
 #define mmiowb()
 
diff -r 1052904816d7 -r ee6ce7e55dc7 include/asm-sparc/io.h
--- a/include/asm-sparc/io.h	Wed Jan 11 14:35:45 2006 -0800
+++ b/include/asm-sparc/io.h	Wed Jan 11 14:35:45 2006 -0800
@@ -239,6 +239,8 @@
 
 #define memcpy_toio(d,s,sz)	_memcpy_toio(d,s,sz)
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 #ifdef __KERNEL__
 
 /*
diff -r 1052904816d7 -r ee6ce7e55dc7 include/asm-sparc64/io.h
--- a/include/asm-sparc64/io.h	Wed Jan 11 14:35:45 2006 -0800
+++ b/include/asm-sparc64/io.h	Wed Jan 11 14:35:45 2006 -0800
@@ -440,6 +440,8 @@
 
 #define memcpy_toio(d,s,sz)	_memcpy_toio(d,s,sz)
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 static inline int check_signature(void __iomem *io_addr,
 				  const unsigned char *signature,
 				  int length)
diff -r 1052904816d7 -r ee6ce7e55dc7 include/asm-v850/io.h
--- a/include/asm-v850/io.h	Wed Jan 11 14:35:45 2006 -0800
+++ b/include/asm-v850/io.h	Wed Jan 11 14:35:45 2006 -0800
@@ -130,6 +130,8 @@
 #define memcpy_fromio(dst, src, len) memcpy (dst, (void *)src, len)
 #define memcpy_toio(dst, src, len) memcpy ((void *)dst, src, len)
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
diff -r 1052904816d7 -r ee6ce7e55dc7 include/asm-x86_64/io.h
--- a/include/asm-x86_64/io.h	Wed Jan 11 14:35:45 2006 -0800
+++ b/include/asm-x86_64/io.h	Wed Jan 11 14:35:45 2006 -0800
@@ -252,6 +252,8 @@
 	__memcpy_toio((unsigned long)to,from,len);
 }
 
+void __raw_memcpy_toio32(void __iomem *dst, const void *src, size_t count);
+
 void memset_io(volatile void __iomem *a, int b, size_t c);
 
 /*
diff -r 1052904816d7 -r ee6ce7e55dc7 include/asm-xtensa/io.h
--- a/include/asm-xtensa/io.h	Wed Jan 11 14:35:45 2006 -0800
+++ b/include/asm-xtensa/io.h	Wed Jan 11 14:35:45 2006 -0800
@@ -159,6 +159,8 @@
 #define memcpy_fromio(a,b,c)   memcpy((a),(void *)(b),(c))
 #define memcpy_toio(a,b,c)      memcpy((void *)(a),(b),(c))
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 /* At this point the Xtensa doesn't provide byte swap instructions */
 
 #ifdef __XTENSA_EB__
