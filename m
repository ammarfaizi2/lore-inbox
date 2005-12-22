Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965079AbVLVE4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbVLVE4p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965081AbVLVEvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:51:10 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:26320 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965072AbVLVEuu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:50:50 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 21/36] m68k: basic iomem annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIPh-0004sT-LC@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:50:49 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1133512630 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/m68k/mm/kmap.c       |   12 ++++++-----
 include/asm-m68k/io.h     |   49 +++++++++++++++++++++++----------------------
 include/asm-m68k/raw_io.h |   40 ++++++++++++++++++-------------------
 include/asm-m68k/zorro.h  |    8 ++++---
 4 files changed, 55 insertions(+), 54 deletions(-)

1e91f0f0ade38fc27e22929dc2bd34af1908d098
diff --git a/arch/m68k/mm/kmap.c b/arch/m68k/mm/kmap.c
index fe2383e..85ad19a 100644
--- a/arch/m68k/mm/kmap.c
+++ b/arch/m68k/mm/kmap.c
@@ -102,7 +102,7 @@ static inline void free_io_area(void *ad
  */
 /* Rewritten by Andreas Schwab to remove all races. */
 
-void *__ioremap(unsigned long physaddr, unsigned long size, int cacheflag)
+void __iomem *__ioremap(unsigned long physaddr, unsigned long size, int cacheflag)
 {
 	struct vm_struct *area;
 	unsigned long virtaddr, retaddr;
@@ -121,7 +121,7 @@ void *__ioremap(unsigned long physaddr, 
 	if (MACH_IS_AMIGA) {
 		if ((physaddr >= 0x40000000) && (physaddr + size < 0x60000000)
 		    && (cacheflag == IOMAP_NOCACHE_SER))
-			return (void *)physaddr;
+			return (void __iomem *)physaddr;
 	}
 #endif
 
@@ -218,21 +218,21 @@ void *__ioremap(unsigned long physaddr, 
 #endif
 	flush_tlb_all();
 
-	return (void *)retaddr;
+	return (void __iomem *)retaddr;
 }
 
 /*
  * Unmap a ioremap()ed region again
  */
-void iounmap(void *addr)
+void iounmap(void __iomem *addr)
 {
 #ifdef CONFIG_AMIGA
 	if ((!MACH_IS_AMIGA) ||
 	    (((unsigned long)addr < 0x40000000) ||
 	     ((unsigned long)addr > 0x60000000)))
-			free_io_area(addr);
+			free_io_area((__force void *)addr);
 #else
-	free_io_area(addr);
+	free_io_area((__force void *)addr);
 #endif
 }
 
diff --git a/include/asm-m68k/io.h b/include/asm-m68k/io.h
index 6bb8b0d..dcfaa35 100644
--- a/include/asm-m68k/io.h
+++ b/include/asm-m68k/io.h
@@ -24,6 +24,7 @@
 #ifdef __KERNEL__
 
 #include <linux/config.h>
+#include <linux/compiler.h>
 #include <asm/raw_io.h>
 #include <asm/virtconvert.h>
 
@@ -120,68 +121,68 @@ extern int isa_sex;
  * be compiled in so the case statement will be optimised away
  */
 
-static inline u8 *isa_itb(unsigned long addr)
+static inline u8 __iomem *isa_itb(unsigned long addr)
 {
   switch(ISA_TYPE)
     {
 #ifdef CONFIG_Q40
-    case Q40_ISA: return (u8 *)Q40_ISA_IO_B(addr);
+    case Q40_ISA: return (u8 __iomem *)Q40_ISA_IO_B(addr);
 #endif
 #ifdef CONFIG_GG2
-    case GG2_ISA: return (u8 *)GG2_ISA_IO_B(addr);
+    case GG2_ISA: return (u8 __iomem *)GG2_ISA_IO_B(addr);
 #endif
 #ifdef CONFIG_AMIGA_PCMCIA
-    case AG_ISA: return (u8 *)AG_ISA_IO_B(addr);
+    case AG_ISA: return (u8 __iomem *)AG_ISA_IO_B(addr);
 #endif
-    default: return 0; /* avoid warnings, just in case */
+    default: return NULL; /* avoid warnings, just in case */
     }
 }
-static inline u16 *isa_itw(unsigned long addr)
+static inline u16 __iomem *isa_itw(unsigned long addr)
 {
   switch(ISA_TYPE)
     {
 #ifdef CONFIG_Q40
-    case Q40_ISA: return (u16 *)Q40_ISA_IO_W(addr);
+    case Q40_ISA: return (u16 __iomem *)Q40_ISA_IO_W(addr);
 #endif
 #ifdef CONFIG_GG2
-    case GG2_ISA: return (u16 *)GG2_ISA_IO_W(addr);
+    case GG2_ISA: return (u16 __iomem *)GG2_ISA_IO_W(addr);
 #endif
 #ifdef CONFIG_AMIGA_PCMCIA
-    case AG_ISA: return (u16 *)AG_ISA_IO_W(addr);
+    case AG_ISA: return (u16 __iomem *)AG_ISA_IO_W(addr);
 #endif
-    default: return 0; /* avoid warnings, just in case */
+    default: return NULL; /* avoid warnings, just in case */
     }
 }
-static inline u8 *isa_mtb(unsigned long addr)
+static inline u8 __iomem *isa_mtb(unsigned long addr)
 {
   switch(ISA_TYPE)
     {
 #ifdef CONFIG_Q40
-    case Q40_ISA: return (u8 *)Q40_ISA_MEM_B(addr);
+    case Q40_ISA: return (u8 __iomem *)Q40_ISA_MEM_B(addr);
 #endif
 #ifdef CONFIG_GG2
-    case GG2_ISA: return (u8 *)GG2_ISA_MEM_B(addr);
+    case GG2_ISA: return (u8 __iomem *)GG2_ISA_MEM_B(addr);
 #endif
 #ifdef CONFIG_AMIGA_PCMCIA
-    case AG_ISA: return (u8 *)addr;
+    case AG_ISA: return (u8 __iomem *)addr;
 #endif
-    default: return 0; /* avoid warnings, just in case */
+    default: return NULL; /* avoid warnings, just in case */
     }
 }
-static inline u16 *isa_mtw(unsigned long addr)
+static inline u16 __iomem *isa_mtw(unsigned long addr)
 {
   switch(ISA_TYPE)
     {
 #ifdef CONFIG_Q40
-    case Q40_ISA: return (u16 *)Q40_ISA_MEM_W(addr);
+    case Q40_ISA: return (u16 __iomem *)Q40_ISA_MEM_W(addr);
 #endif
 #ifdef CONFIG_GG2
-    case GG2_ISA: return (u16 *)GG2_ISA_MEM_W(addr);
+    case GG2_ISA: return (u16 __iomem *)GG2_ISA_MEM_W(addr);
 #endif
 #ifdef CONFIG_AMIGA_PCMCIA
-    case AG_ISA: return (u16 *)addr;
+    case AG_ISA: return (u16 __iomem *)addr;
 #endif
-    default: return 0; /* avoid warnings, just in case */
+    default: return NULL; /* avoid warnings, just in case */
     }
 }
 
@@ -326,20 +327,20 @@ static inline void isa_delay(void)
 
 #define mmiowb()
 
-static inline void *ioremap(unsigned long physaddr, unsigned long size)
+static inline void __iomem *ioremap(unsigned long physaddr, unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_NOCACHE_SER);
 }
-static inline void *ioremap_nocache(unsigned long physaddr, unsigned long size)
+static inline void __iomem *ioremap_nocache(unsigned long physaddr, unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_NOCACHE_SER);
 }
-static inline void *ioremap_writethrough(unsigned long physaddr,
+static inline void __iomem *ioremap_writethrough(unsigned long physaddr,
 					 unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_WRITETHROUGH);
 }
-static inline void *ioremap_fullcache(unsigned long physaddr,
+static inline void __iomem *ioremap_fullcache(unsigned long physaddr,
 				      unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_FULL_CACHING);
diff --git a/include/asm-m68k/raw_io.h b/include/asm-m68k/raw_io.h
index 041f0a8..5439bca 100644
--- a/include/asm-m68k/raw_io.h
+++ b/include/asm-m68k/raw_io.h
@@ -19,9 +19,9 @@
 #define IOMAP_NOCACHE_NONSER		2
 #define IOMAP_WRITETHROUGH		3
 
-extern void iounmap(void *addr);
+extern void iounmap(void __iomem *addr);
 
-extern void *__ioremap(unsigned long physaddr, unsigned long size,
+extern void __iomem *__ioremap(unsigned long physaddr, unsigned long size,
 		       int cacheflag);
 extern void __iounmap(void *addr, unsigned long size);
 
@@ -30,21 +30,21 @@ extern void __iounmap(void *addr, unsign
  * two accesses to memory, which may be undesirable for some devices.
  */
 #define in_8(addr) \
-    ({ u8 __v = (*(volatile u8 *) (addr)); __v; })
+    ({ u8 __v = (*(__force volatile u8 *) (addr)); __v; })
 #define in_be16(addr) \
-    ({ u16 __v = (*(volatile u16 *) (addr)); __v; })
+    ({ u16 __v = (*(__force volatile u16 *) (addr)); __v; })
 #define in_be32(addr) \
-    ({ u32 __v = (*(volatile u32 *) (addr)); __v; })
+    ({ u32 __v = (*(__force volatile u32 *) (addr)); __v; })
 #define in_le16(addr) \
-    ({ u16 __v = le16_to_cpu(*(volatile u16 *) (addr)); __v; })
+    ({ u16 __v = le16_to_cpu(*(__force volatile u16 *) (addr)); __v; })
 #define in_le32(addr) \
-    ({ u32 __v = le32_to_cpu(*(volatile u32 *) (addr)); __v; })
+    ({ u32 __v = le32_to_cpu(*(__force volatile u32 *) (addr)); __v; })
 
-#define out_8(addr,b) (void)((*(volatile u8 *) (addr)) = (b))
-#define out_be16(addr,w) (void)((*(volatile u16 *) (addr)) = (w))
-#define out_be32(addr,l) (void)((*(volatile u32 *) (addr)) = (l))
-#define out_le16(addr,w) (void)((*(volatile u16 *) (addr)) = cpu_to_le16(w))
-#define out_le32(addr,l) (void)((*(volatile u32 *) (addr)) = cpu_to_le32(l))
+#define out_8(addr,b) (void)((*(__force volatile u8 *) (addr)) = (b))
+#define out_be16(addr,w) (void)((*(__force volatile u16 *) (addr)) = (w))
+#define out_be32(addr,l) (void)((*(__force volatile u32 *) (addr)) = (l))
+#define out_le16(addr,w) (void)((*(__force volatile u16 *) (addr)) = cpu_to_le16(w))
+#define out_le32(addr,l) (void)((*(__force volatile u32 *) (addr)) = cpu_to_le32(l))
 
 #define raw_inb in_8
 #define raw_inw in_be16
@@ -54,7 +54,7 @@ extern void __iounmap(void *addr, unsign
 #define raw_outw(val,port) out_be16((port),(val))
 #define raw_outl(val,port) out_be32((port),(val))
 
-static inline void raw_insb(volatile u8 *port, u8 *buf, unsigned int len)
+static inline void raw_insb(volatile u8 __iomem *port, u8 *buf, unsigned int len)
 {
 	unsigned int i;
 
@@ -62,7 +62,7 @@ static inline void raw_insb(volatile u8 
 		*buf++ = in_8(port);
 }
 
-static inline void raw_outsb(volatile u8 *port, const u8 *buf,
+static inline void raw_outsb(volatile u8 __iomem *port, const u8 *buf,
 			     unsigned int len)
 {
 	unsigned int i;
@@ -71,7 +71,7 @@ static inline void raw_outsb(volatile u8
 		out_8(port, *buf++);
 }
 
-static inline void raw_insw(volatile u16 *port, u16 *buf, unsigned int nr)
+static inline void raw_insw(volatile u16 __iomem *port, u16 *buf, unsigned int nr)
 {
 	unsigned int tmp;
 
@@ -110,7 +110,7 @@ static inline void raw_insw(volatile u16
 	}
 }
 
-static inline void raw_outsw(volatile u16 *port, const u16 *buf,
+static inline void raw_outsw(volatile u16 __iomem *port, const u16 *buf,
 			     unsigned int nr)
 {
 	unsigned int tmp;
@@ -150,7 +150,7 @@ static inline void raw_outsw(volatile u1
 	}
 }
 
-static inline void raw_insl(volatile u32 *port, u32 *buf, unsigned int nr)
+static inline void raw_insl(volatile u32 __iomem *port, u32 *buf, unsigned int nr)
 {
 	unsigned int tmp;
 
@@ -189,7 +189,7 @@ static inline void raw_insl(volatile u32
 	}
 }
 
-static inline void raw_outsl(volatile u32 *port, const u32 *buf,
+static inline void raw_outsl(volatile u32 __iomem *port, const u32 *buf,
 			     unsigned int nr)
 {
 	unsigned int tmp;
@@ -230,7 +230,7 @@ static inline void raw_outsl(volatile u3
 }
 
 
-static inline void raw_insw_swapw(volatile u16 *port, u16 *buf,
+static inline void raw_insw_swapw(volatile u16 __iomem *port, u16 *buf,
 				  unsigned int nr)
 {
     if ((nr) % 8)
@@ -283,7 +283,7 @@ static inline void raw_insw_swapw(volati
 		: "d0", "a0", "a1", "d6");
 }
 
-static inline void raw_outsw_swapw(volatile u16 *port, const u16 *buf,
+static inline void raw_outsw_swapw(volatile u16 __iomem *port, const u16 *buf,
 				   unsigned int nr)
 {
     if ((nr) % 8)
diff --git a/include/asm-m68k/zorro.h b/include/asm-m68k/zorro.h
index cf81658..5ce97c2 100644
--- a/include/asm-m68k/zorro.h
+++ b/include/asm-m68k/zorro.h
@@ -15,24 +15,24 @@
 #define z_memcpy_fromio(a,b,c)	memcpy((a),(void *)(b),(c))
 #define z_memcpy_toio(a,b,c)	memcpy((void *)(a),(b),(c))
 
-static inline void *z_remap_nocache_ser(unsigned long physaddr,
+static inline void __iomem *z_remap_nocache_ser(unsigned long physaddr,
 					unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_NOCACHE_SER);
 }
 
-static inline void *z_remap_nocache_nonser(unsigned long physaddr,
+static inline void __iomem *z_remap_nocache_nonser(unsigned long physaddr,
 					   unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_NOCACHE_NONSER);
 }
 
-static inline void *z_remap_writethrough(unsigned long physaddr,
+static inline void __iomem *z_remap_writethrough(unsigned long physaddr,
 					 unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_WRITETHROUGH);
 }
-static inline void *z_remap_fullcache(unsigned long physaddr,
+static inline void __iomem *z_remap_fullcache(unsigned long physaddr,
 				      unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_FULL_CACHING);
-- 
0.99.9.GIT

