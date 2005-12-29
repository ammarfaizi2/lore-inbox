Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbVL2Aoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbVL2Aoe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 19:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbVL2AjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 19:39:12 -0500
Received: from mx.pathscale.com ([64.160.42.68]:43240 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932567AbVL2AjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 19:39:08 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 3 of 20] Add memcpy_toio32 to each arch
X-Mercurial-Node: b792638cc4bc83566587d685f95660eba575952e
Message-Id: <b792638cc4bc83566587.1135816282@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1135816279@eng-12.pathscale.com>
Date: Wed, 28 Dec 2005 16:31:22 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most arches use the generic __memcpy_toio32 routine, while x86_64
uses memcpy32, which is substantially faster.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 801287704e40 -r b792638cc4bc include/asm-alpha/io.h
--- a/include/asm-alpha/io.h	Wed Dec 28 14:19:42 2005 -0800
+++ b/include/asm-alpha/io.h	Wed Dec 28 14:19:42 2005 -0800
@@ -504,6 +504,8 @@
 extern void memcpy_toio(volatile void __iomem *, const void *, long);
 extern void _memset_c_io(volatile void __iomem *, unsigned long, long);
 
+#define memcpy_toio32 __memcpy_toio32
+
 static inline void memset_io(volatile void __iomem *addr, u8 c, long len)
 {
 	_memset_c_io(addr, 0x0101010101010101UL * c, len);
diff -r 801287704e40 -r b792638cc4bc include/asm-arm/io.h
--- a/include/asm-arm/io.h	Wed Dec 28 14:19:42 2005 -0800
+++ b/include/asm-arm/io.h	Wed Dec 28 14:19:42 2005 -0800
@@ -184,6 +184,8 @@
 #define memset_io(c,v,l)	_memset_io(__mem_pci(c),(v),(l))
 #define memcpy_fromio(a,c,l)	_memcpy_fromio((a),__mem_pci(c),(l))
 #define memcpy_toio(c,a,l)	_memcpy_toio(__mem_pci(c),(a),(l))
+
+#define memcpy_toio32 __memcpy_toio32
 
 #define eth_io_copy_and_sum(s,c,l,b) \
 				eth_copy_and_sum((s),__mem_pci(c),(l),(b))
diff -r 801287704e40 -r b792638cc4bc include/asm-cris/io.h
--- a/include/asm-cris/io.h	Wed Dec 28 14:19:42 2005 -0800
+++ b/include/asm-cris/io.h	Wed Dec 28 14:19:42 2005 -0800
@@ -121,6 +121,8 @@
 #define memcpy_fromio(a,b,c)	memcpy((a),(void *)(b),(c))
 #define memcpy_toio(a,b,c)	memcpy((void *)(a),(b),(c))
 
+#define memcpy_toio32 __memcpy_toio32
+
 /*
  * Again, CRIS does not require mem IO specific function.
  */
diff -r 801287704e40 -r b792638cc4bc include/asm-frv/io.h
--- a/include/asm-frv/io.h	Wed Dec 28 14:19:42 2005 -0800
+++ b/include/asm-frv/io.h	Wed Dec 28 14:19:42 2005 -0800
@@ -124,6 +124,8 @@
 	memcpy((void __force *) dst, src, count);
 }
 
+#define memcpy_toio32 __memcpy_toio32
+
 static inline uint8_t inb(unsigned long addr)
 {
 	return __builtin_read8((void *)addr);
diff -r 801287704e40 -r b792638cc4bc include/asm-h8300/io.h
--- a/include/asm-h8300/io.h	Wed Dec 28 14:19:42 2005 -0800
+++ b/include/asm-h8300/io.h	Wed Dec 28 14:19:42 2005 -0800
@@ -209,6 +209,8 @@
 #define memcpy_fromio(a,b,c)	memcpy((a),(void *)(b),(c))
 #define memcpy_toio(a,b,c)	memcpy((void *)(a),(b),(c))
 
+#define memcpy_toio32 __memcpy_toio32
+
 #define mmiowb()
 
 #define inb(addr)    ((h8300_buswidth(addr))?readw((addr) & ~1) & 0xff:readb(addr))
diff -r 801287704e40 -r b792638cc4bc include/asm-i386/io.h
--- a/include/asm-i386/io.h	Wed Dec 28 14:19:42 2005 -0800
+++ b/include/asm-i386/io.h	Wed Dec 28 14:19:42 2005 -0800
@@ -203,6 +203,9 @@
 {
 	__memcpy((void __force *) dst, src, count);
 }
+
+#define memcpy_toio32 __memcpy_toio32
+
 
 /*
  * ISA space is 'always mapped' on a typical x86 system, no need to
diff -r 801287704e40 -r b792638cc4bc include/asm-ia64/io.h
--- a/include/asm-ia64/io.h	Wed Dec 28 14:19:42 2005 -0800
+++ b/include/asm-ia64/io.h	Wed Dec 28 14:19:42 2005 -0800
@@ -443,6 +443,8 @@
 extern void memcpy_toio(volatile void __iomem *dst, const void *src, long n);
 extern void memset_io(volatile void __iomem *s, int c, long n);
 
+#define memcpy_toio32 __memcpy_toio32
+
 #define dma_cache_inv(_start,_size)             do { } while (0)
 #define dma_cache_wback(_start,_size)           do { } while (0)
 #define dma_cache_wback_inv(_start,_size)       do { } while (0)
diff -r 801287704e40 -r b792638cc4bc include/asm-m32r/io.h
--- a/include/asm-m32r/io.h	Wed Dec 28 14:19:42 2005 -0800
+++ b/include/asm-m32r/io.h	Wed Dec 28 14:19:42 2005 -0800
@@ -216,6 +216,8 @@
 	memcpy((void __force *) dst, src, count);
 }
 
+#define memcpy_toio32 __memcpy_toio32
+
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
diff -r 801287704e40 -r b792638cc4bc include/asm-m68knommu/io.h
--- a/include/asm-m68knommu/io.h	Wed Dec 28 14:19:42 2005 -0800
+++ b/include/asm-m68knommu/io.h	Wed Dec 28 14:19:42 2005 -0800
@@ -113,6 +113,8 @@
 #define memcpy_fromio(a,b,c)	memcpy((a),(void *)(b),(c))
 #define memcpy_toio(a,b,c)	memcpy((void *)(a),(b),(c))
 
+#define memcpy_toio32 __memcpy_toio32
+
 #define inb(addr)    readb(addr)
 #define inw(addr)    readw(addr)
 #define inl(addr)    readl(addr)
diff -r 801287704e40 -r b792638cc4bc include/asm-mips/io.h
--- a/include/asm-mips/io.h	Wed Dec 28 14:19:42 2005 -0800
+++ b/include/asm-mips/io.h	Wed Dec 28 14:19:42 2005 -0800
@@ -534,6 +534,8 @@
 	memcpy((void __force *) dst, src, count);
 }
 
+#define memcpy_toio32 __memcpy_toio32
+
 /*
  * Memory Mapped I/O
  */
diff -r 801287704e40 -r b792638cc4bc include/asm-parisc/io.h
--- a/include/asm-parisc/io.h	Wed Dec 28 14:19:42 2005 -0800
+++ b/include/asm-parisc/io.h	Wed Dec 28 14:19:42 2005 -0800
@@ -294,6 +294,8 @@
 void memcpy_fromio(void *dst, const volatile void __iomem *src, int count);
 void memcpy_toio(volatile void __iomem *dst, const void *src, int count);
 
+#define memcpy_toio32 __memcpy_toio32
+
 /* Support old drivers which don't ioremap.
  * NB this interface is scheduled to disappear in 2.5
  */
diff -r 801287704e40 -r b792638cc4bc include/asm-powerpc/io.h
--- a/include/asm-powerpc/io.h	Wed Dec 28 14:19:42 2005 -0800
+++ b/include/asm-powerpc/io.h	Wed Dec 28 14:19:42 2005 -0800
@@ -63,6 +63,8 @@
 #define memcpy_fromio(a,b,c)	iSeries_memcpy_fromio((a), (b), (c))
 #define memcpy_toio(a,b,c)	iSeries_memcpy_toio((a), (b), (c))
 
+#define memcpy_toio32 __memcpy_toio32
+
 #define inb(addr)		readb(((void __iomem *)(long)(addr)))
 #define inw(addr)		readw(((void __iomem *)(long)(addr)))
 #define inl(addr)		readl(((void __iomem *)(long)(addr)))
diff -r 801287704e40 -r b792638cc4bc include/asm-ppc/io.h
--- a/include/asm-ppc/io.h	Wed Dec 28 14:19:42 2005 -0800
+++ b/include/asm-ppc/io.h	Wed Dec 28 14:19:42 2005 -0800
@@ -367,6 +367,8 @@
 }
 #endif
 
+#define memcpy_toio32 __memcpy_toio32
+
 #define eth_io_copy_and_sum(a,b,c,d)		eth_copy_and_sum((a),(void __force *)(void __iomem *)(b),(c),(d))
 
 /*
diff -r 801287704e40 -r b792638cc4bc include/asm-s390/io.h
--- a/include/asm-s390/io.h	Wed Dec 28 14:19:42 2005 -0800
+++ b/include/asm-s390/io.h	Wed Dec 28 14:19:42 2005 -0800
@@ -99,6 +99,8 @@
 #define memcpy_fromio(a,b,c)    memcpy((a),__io_virt(b),(c))
 #define memcpy_toio(a,b,c)      memcpy(__io_virt(a),(b),(c))
 
+#define memcpy_toio32 __memcpy_toio32
+
 #define inb_p(addr) readb(addr)
 #define inb(addr) readb(addr)
 
diff -r 801287704e40 -r b792638cc4bc include/asm-sh/io.h
--- a/include/asm-sh/io.h	Wed Dec 28 14:19:42 2005 -0800
+++ b/include/asm-sh/io.h	Wed Dec 28 14:19:42 2005 -0800
@@ -177,6 +177,8 @@
 extern void memcpy_toio(unsigned long, const void *, unsigned long);
 extern void memset_io(unsigned long, int, unsigned long);
 
+#define memcpy_toio32 __memcpy_toio32
+
 /* SuperH on-chip I/O functions */
 static __inline__ unsigned char ctrl_inb(unsigned long addr)
 {
diff -r 801287704e40 -r b792638cc4bc include/asm-sh64/io.h
--- a/include/asm-sh64/io.h	Wed Dec 28 14:19:42 2005 -0800
+++ b/include/asm-sh64/io.h	Wed Dec 28 14:19:42 2005 -0800
@@ -125,6 +125,8 @@
 
 void memcpy_toio(void __iomem *to, const void *from, long count);
 void memcpy_fromio(void *to, void __iomem *from, long count);
+
+#define memcpy_toio32 __memcpy_toio32
 
 #define mmiowb()
 
diff -r 801287704e40 -r b792638cc4bc include/asm-sparc/io.h
--- a/include/asm-sparc/io.h	Wed Dec 28 14:19:42 2005 -0800
+++ b/include/asm-sparc/io.h	Wed Dec 28 14:19:42 2005 -0800
@@ -239,6 +239,8 @@
 
 #define memcpy_toio(d,s,sz)	_memcpy_toio(d,s,sz)
 
+#define memcpy_toio32 __memcpy_toio32
+
 #ifdef __KERNEL__
 
 /*
diff -r 801287704e40 -r b792638cc4bc include/asm-sparc64/io.h
--- a/include/asm-sparc64/io.h	Wed Dec 28 14:19:42 2005 -0800
+++ b/include/asm-sparc64/io.h	Wed Dec 28 14:19:42 2005 -0800
@@ -440,6 +440,8 @@
 
 #define memcpy_toio(d,s,sz)	_memcpy_toio(d,s,sz)
 
+#define memcpy_toio32 __memcpy_toio32
+
 static inline int check_signature(void __iomem *io_addr,
 				  const unsigned char *signature,
 				  int length)
diff -r 801287704e40 -r b792638cc4bc include/asm-v850/io.h
--- a/include/asm-v850/io.h	Wed Dec 28 14:19:42 2005 -0800
+++ b/include/asm-v850/io.h	Wed Dec 28 14:19:42 2005 -0800
@@ -130,6 +130,8 @@
 #define memcpy_fromio(dst, src, len) memcpy (dst, (void *)src, len)
 #define memcpy_toio(dst, src, len) memcpy ((void *)dst, src, len)
 
+#define memcpy_toio32 __memcpy_toio32
+
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
diff -r 801287704e40 -r b792638cc4bc include/asm-x86_64/io.h
--- a/include/asm-x86_64/io.h	Wed Dec 28 14:19:42 2005 -0800
+++ b/include/asm-x86_64/io.h	Wed Dec 28 14:19:42 2005 -0800
@@ -252,6 +252,13 @@
 	__memcpy_toio((unsigned long)to,from,len);
 }
 
+#include <asm/string.h>
+
+static inline void memcpy_toio32(void __iomem *dst, const void *src, size_t count)
+{
+	memcpy32((void __force *) dst, src, count);
+}
+
 void memset_io(volatile void __iomem *a, int b, size_t c);
 
 /*
diff -r 801287704e40 -r b792638cc4bc include/asm-xtensa/io.h
--- a/include/asm-xtensa/io.h	Wed Dec 28 14:19:42 2005 -0800
+++ b/include/asm-xtensa/io.h	Wed Dec 28 14:19:42 2005 -0800
@@ -159,6 +159,8 @@
 #define memcpy_fromio(a,b,c)   memcpy((a),(void *)(b),(c))
 #define memcpy_toio(a,b,c)      memcpy((void *)(a),(b),(c))
 
+#define memcpy_toio32 __memcpy_toio32
+
 /* At this point the Xtensa doesn't provide byte swap instructions */
 
 #ifdef __XTENSA_EB__
