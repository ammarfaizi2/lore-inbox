Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWJERF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWJERF7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 13:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWJERF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 13:05:59 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:20875 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1751382AbWJERF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 13:05:57 -0400
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       Matthew Wilcox <matthew@wil.cx>,
       Matthew Wilcox <willy@parisc-linux.org>
Subject: [PATCH] Consolidate check_signature
Reply-To: Matthew Wilcox <matthew@wil.cx>
Date: Thu, 05 Oct 2006 11:05:55 -0600
Message-Id: <11600679552794-git-send-email-matthew@wil.cx>
X-Mailer: git-send-email 1.4.1.1
In-Reply-To: <11600679551209-git-send-email-matthew@wil.cx>
References: <11600679551209-git-send-email-matthew@wil.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's nothing arch-specific about check_signature(), so move it to
<linux/io.h>.  Use a cross between the Alpha and i386 implementations
as the generic one.

Signed-off-by: Matthew Wilcox <willy@parisc-linux.org>
---
 include/asm-alpha/io.h   |   13 -------------
 include/asm-arm/io.h     |   17 -----------------
 include/asm-frv/io.h     |   21 ---------------------
 include/asm-i386/io.h    |   27 ---------------------------
 include/asm-m32r/io.h    |   32 --------------------------------
 include/asm-mips/io.h    |   26 --------------------------
 include/asm-powerpc/io.h |   26 --------------------------
 include/asm-ppc/io.h     |   16 ----------------
 include/asm-sh/io.h      |   16 ----------------
 include/asm-sh64/io.h    |   16 ----------------
 include/asm-sparc64/io.h |   15 ---------------
 include/asm-x86_64/io.h  |   27 ---------------------------
 include/linux/io.h       |   27 +++++++++++++++++++++++++++
 13 files changed, 27 insertions(+), 252 deletions(-)

diff --git a/include/asm-alpha/io.h b/include/asm-alpha/io.h
index f5ae98c..5d15af2 100644
--- a/include/asm-alpha/io.h
+++ b/include/asm-alpha/io.h
@@ -533,19 +533,6 @@ extern void outsl (unsigned long port, c
 #define eth_io_copy_and_sum(skb,src,len,unused) \
   memcpy_fromio((skb)->data,src,len)
 
-static inline int
-check_signature(const volatile void __iomem *io_addr,
-		const unsigned char *signature, int length)
-{
-	do {
-		if (readb(io_addr) != *signature)
-			return 0;
-		io_addr++;
-		signature++;
-	} while (--length);
-	return 1;
-}
-
 /*
  * The Alpha Jensen hardware for some rather strange reason puts
  * the RTC clock at 0x170 instead of 0x70. Probably due to some
diff --git a/include/asm-arm/io.h b/include/asm-arm/io.h
index 8076a85..54d5f94 100644
--- a/include/asm-arm/io.h
+++ b/include/asm-arm/io.h
@@ -193,23 +193,6 @@ #define memcpy_toio(c,a,l)	_memcpy_toio(
 #define eth_io_copy_and_sum(s,c,l,b) \
 				eth_copy_and_sum((s),__mem_pci(c),(l),(b))
 
-static inline int
-check_signature(void __iomem *io_addr, const unsigned char *signature,
-		int length)
-{
-	int retval = 0;
-	do {
-		if (readb(io_addr) != *signature)
-			goto out;
-		io_addr++;
-		signature++;
-		length--;
-	} while (length);
-	retval = 1;
-out:
-	return retval;
-}
-
 #elif !defined(readb)
 
 #define readb(c)			(__readwrite_bug("readb"),0)
diff --git a/include/asm-frv/io.h b/include/asm-frv/io.h
index 7765f55..20e44fe 100644
--- a/include/asm-frv/io.h
+++ b/include/asm-frv/io.h
@@ -385,27 +385,6 @@ #define xlate_dev_mem_ptr(p)	__va(p)
  */
 #define xlate_dev_kmem_ptr(p)	p
 
-/*
- * Check BIOS signature
- */
-static inline int check_signature(volatile void __iomem *io_addr,
-				  const unsigned char *signature, int length)
-{
-	int retval = 0;
-
-	do {
-		if (readb(io_addr) != *signature)
-			goto out;
-		io_addr++;
-		signature++;
-		length--;
-	} while (length);
-
-	retval = 1;
-out:
-	return retval;
-}
-
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_IO_H */
diff --git a/include/asm-i386/io.h b/include/asm-i386/io.h
index b3724fe..68df0dc 100644
--- a/include/asm-i386/io.h
+++ b/include/asm-i386/io.h
@@ -224,33 +224,6 @@ #define __ISA_IO_base ((char __iomem *)(
 
 #define eth_io_copy_and_sum(a,b,c,d)		eth_copy_and_sum((a),(void __force *)(b),(c),(d))
 
-/**
- *	check_signature		-	find BIOS signatures
- *	@io_addr: mmio address to check 
- *	@signature:  signature block
- *	@length: length of signature
- *
- *	Perform a signature comparison with the mmio address io_addr. This
- *	address should have been obtained by ioremap.
- *	Returns 1 on a match.
- */
- 
-static inline int check_signature(volatile void __iomem * io_addr,
-	const unsigned char *signature, int length)
-{
-	int retval = 0;
-	do {
-		if (readb(io_addr) != *signature)
-			goto out;
-		io_addr++;
-		signature++;
-		length--;
-	} while (length);
-	retval = 1;
-out:
-	return retval;
-}
-
 /*
  *	Cache management
  *
diff --git a/include/asm-m32r/io.h b/include/asm-m32r/io.h
index 70ad1c9..d06933b 100644
--- a/include/asm-m32r/io.h
+++ b/include/asm-m32r/io.h
@@ -166,38 +166,6 @@ #define mmiowb()
 
 #define flush_write_buffers() do { } while (0)  /* M32R_FIXME */
 
-/**
- *	check_signature		-	find BIOS signatures
- *	@io_addr: mmio address to check
- *	@signature:  signature block
- *	@length: length of signature
- *
- *	Perform a signature comparison with the ISA mmio address io_addr.
- *	Returns 1 on a match.
- *
- *	This function is deprecated. New drivers should use ioremap and
- *	check_signature.
- */
-
-static inline int check_signature(void __iomem *io_addr,
-        const unsigned char *signature, int length)
-{
-        int retval = 0;
-#if 0
-printk("check_signature\n");
-        do {
-                if (readb(io_addr) != *signature)
-                        goto out;
-                io_addr++;
-                signature++;
-                length--;
-        } while (length);
-        retval = 1;
-out:
-#endif
-        return retval;
-}
-
 static inline void
 memset_io(volatile void __iomem *addr, unsigned char val, int count)
 {
diff --git a/include/asm-mips/io.h b/include/asm-mips/io.h
index df624e1..c2d124b 100644
--- a/include/asm-mips/io.h
+++ b/include/asm-mips/io.h
@@ -562,32 +562,6 @@ #define __ISA_IO_base ((char *)(isa_slot
 #define eth_io_copy_and_sum(skb,src,len,unused) memcpy_fromio((skb)->data,(src),(len))
 
 /*
- *     check_signature         -       find BIOS signatures
- *     @io_addr: mmio address to check
- *     @signature:  signature block
- *     @length: length of signature
- *
- *     Perform a signature comparison with the mmio address io_addr. This
- *     address should have been obtained by ioremap.
- *     Returns 1 on a match.
- */
-static inline int check_signature(char __iomem *io_addr,
-	const unsigned char *signature, int length)
-{
-	int retval = 0;
-	do {
-		if (readb(io_addr) != *signature)
-			goto out;
-		io_addr++;
-		signature++;
-		length--;
-	} while (length);
-	retval = 1;
-out:
-	return retval;
-}
-
-/*
  * The caches on some architectures aren't dma-coherent and have need to
  * handle this in software.  There are three types of operations that
  * can be applied to dma buffers.
diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
index cbbd8c6..3baff8b 100644
--- a/include/asm-powerpc/io.h
+++ b/include/asm-powerpc/io.h
@@ -404,32 +404,6 @@ static inline void __out_be64(volatile u
 
 #include <asm/eeh.h>
 
-/**
- *	check_signature		-	find BIOS signatures
- *	@io_addr: mmio address to check
- *	@signature:  signature block
- *	@length: length of signature
- *
- *	Perform a signature comparison with the mmio address io_addr. This
- *	address should have been obtained by ioremap.
- *	Returns 1 on a match.
- */
-static inline int check_signature(const volatile void __iomem * io_addr,
-	const unsigned char *signature, int length)
-{
-	int retval = 0;
-	do {
-		if (readb(io_addr) != *signature)
-			goto out;
-		io_addr++;
-		signature++;
-		length--;
-	} while (length);
-	retval = 1;
-out:
-	return retval;
-}
-
 /* Nothing to do */
 
 #define dma_cache_inv(_start,_size)		do { } while (0)
diff --git a/include/asm-ppc/io.h b/include/asm-ppc/io.h
index 3d9a9e6..a4c411b 100644
--- a/include/asm-ppc/io.h
+++ b/include/asm-ppc/io.h
@@ -439,22 +439,6 @@ #define iobarrier_rw() eieio()
 #define iobarrier_r()  eieio()
 #define iobarrier_w()  eieio()
 
-static inline int check_signature(volatile void __iomem * io_addr,
-	const unsigned char *signature, int length)
-{
-	int retval = 0;
-	do {
-		if (readb(io_addr) != *signature)
-			goto out;
-		io_addr++;
-		signature++;
-		length--;
-	} while (length);
-	retval = 1;
-out:
-	return retval;
-}
-
 /*
  * Here comes the ppc implementation of the IOMAP 
  * interfaces.
diff --git a/include/asm-sh/io.h b/include/asm-sh/io.h
index ed12d38..a0e55b0 100644
--- a/include/asm-sh/io.h
+++ b/include/asm-sh/io.h
@@ -304,22 +304,6 @@ #define p3_ioremap(offset, size, flags)	
 #define iounmap(addr)					\
 	__iounmap((addr))
 
-static inline int check_signature(char __iomem *io_addr,
-			const unsigned char *signature, int length)
-{
-	int retval = 0;
-	do {
-		if (readb(io_addr) != *signature)
-			goto out;
-		io_addr++;
-		signature++;
-		length--;
-	} while (length);
-	retval = 1;
-out:
-	return retval;
-}
-
 /*
  * The caches on some architectures aren't dma-coherent and have need to
  * handle this in software.  There are three types of operations that
diff --git a/include/asm-sh64/io.h b/include/asm-sh64/io.h
index 252fedb..14d8e7b 100644
--- a/include/asm-sh64/io.h
+++ b/include/asm-sh64/io.h
@@ -178,22 +178,6 @@ extern void iounmap(void *addr);
 unsigned long onchip_remap(unsigned long addr, unsigned long size, const char* name);
 extern void onchip_unmap(unsigned long vaddr);
 
-static __inline__ int check_signature(volatile void __iomem *io_addr,
-			const unsigned char *signature, int length)
-{
-	int retval = 0;
-	do {
-		if (readb(io_addr) != *signature)
-			goto out;
-		io_addr++;
-		signature++;
-		length--;
-	} while (length);
-	retval = 1;
-out:
-	return retval;
-}
-
 /*
  * The caches on some architectures aren't dma-coherent and have need to
  * handle this in software.  There are three types of operations that
diff --git a/include/asm-sparc64/io.h b/include/asm-sparc64/io.h
index 0056770..30b912d 100644
--- a/include/asm-sparc64/io.h
+++ b/include/asm-sparc64/io.h
@@ -440,21 +440,6 @@ _memcpy_toio(volatile void __iomem *dst,
 
 #define memcpy_toio(d,s,sz)	_memcpy_toio(d,s,sz)
 
-static inline int check_signature(void __iomem *io_addr,
-				  const unsigned char *signature,
-				  int length)
-{
-	int retval = 0;
-	do {
-		if (readb(io_addr) != *signature++)
-			goto out;
-		io_addr++;
-	} while (--length);
-	retval = 1;
-out:
-	return retval;
-}
-
 #define mmiowb()
 
 #ifdef __KERNEL__
diff --git a/include/asm-x86_64/io.h b/include/asm-x86_64/io.h
index 70e91fe..6ee9fad 100644
--- a/include/asm-x86_64/io.h
+++ b/include/asm-x86_64/io.h
@@ -254,33 +254,6 @@ #define __ISA_IO_base ((char __iomem *)(
 
 #define eth_io_copy_and_sum(a,b,c,d)		eth_copy_and_sum((a),(void *)(b),(c),(d))
 
-/**
- *	check_signature		-	find BIOS signatures
- *	@io_addr: mmio address to check 
- *	@signature:  signature block
- *	@length: length of signature
- *
- *	Perform a signature comparison with the mmio address io_addr. This
- *	address should have been obtained by ioremap.
- *	Returns 1 on a match.
- */
- 
-static inline int check_signature(void __iomem *io_addr,
-	const unsigned char *signature, int length)
-{
-	int retval = 0;
-	do {
-		if (readb(io_addr) != *signature)
-			goto out;
-		io_addr++;
-		signature++;
-		length--;
-	} while (length);
-	retval = 1;
-out:
-	return retval;
-}
-
 /* Nothing to do */
 
 #define dma_cache_inv(_start,_size)		do { } while (0)
diff --git a/include/linux/io.h b/include/linux/io.h
index aa3f5af..8194375 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -27,4 +27,31 @@ void __iowrite64_copy(void __iomem *to, 
 int ioremap_page_range(unsigned long addr, unsigned long end,
 		       unsigned long phys_addr, pgprot_t prot);
 
+/**
+ *	check_signature		-	find BIOS signatures
+ *	@io_addr: mmio address to check 
+ *	@signature:  signature block
+ *	@length: length of signature
+ *
+ *	Perform a signature comparison with the mmio address io_addr. This
+ *	address should have been obtained by ioremap.
+ *	Returns 1 on a match.
+ */
+ 
+static inline int check_signature(const volatile void __iomem *io_addr,
+	const unsigned char *signature, int length)
+{
+	int retval = 0;
+	do {
+		if (readb(io_addr) != *signature)
+			goto out;
+		io_addr++;
+		signature++;
+		length--;
+	} while (length);
+	retval = 1;
+out:
+	return retval;
+}
+
 #endif /* _LINUX_IO_H */
-- 
1.4.1.1

