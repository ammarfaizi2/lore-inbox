Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965238AbVKPDvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965238AbVKPDvp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 22:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965225AbVKPDvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 22:51:00 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:17092 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965233AbVKPDu6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 22:50:58 -0500
To: torvalds@osdl.org
Subject: [PATCH 8/8] isaectomy: helpers
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EcEK1-0007eU-A0@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 16 Nov 2005 03:50:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1132110644 -0500

unused isa_...() helpers removed.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 include/asm-alpha/io.h  |   84 -----------------------------------------------
 include/asm-arm/io.h    |   36 --------------------
 include/asm-i386/io.h   |   12 -------
 include/asm-mips/io.h   |   13 -------
 include/asm-parisc/io.h |   18 ----------
 include/asm-sh/io.h     |   13 -------
 include/asm-x86_64/io.h |   12 -------
 7 files changed, 0 insertions(+), 188 deletions(-)

943f09ec07bccaf8c2526fdb42796d7dccac93db
diff --git a/include/asm-alpha/io.h b/include/asm-alpha/io.h
--- a/include/asm-alpha/io.h
+++ b/include/asm-alpha/io.h
@@ -534,9 +534,6 @@ extern void outsl (unsigned long port, c
 #define eth_io_copy_and_sum(skb,src,len,unused) \
   memcpy_fromio((skb)->data,src,len)
 
-#define isa_eth_io_copy_and_sum(skb,src,len,unused) \
-  isa_memcpy_fromio((skb)->data,src,len)
-
 static inline int
 check_signature(const volatile void __iomem *io_addr,
 		const unsigned char *signature, int length)
@@ -550,87 +547,6 @@ check_signature(const volatile void __io
 	return 1;
 }
 
-
-/*
- * ISA space is mapped to some machine-specific location on Alpha.
- * Call into the existing hooks to get the address translated.
- */
-
-static inline u8
-isa_readb(unsigned long offset)
-{
-	void __iomem *addr = ioremap(offset, 1);
-	u8 ret = readb(addr);
-	iounmap(addr);
-	return ret;
-}
-
-static inline u16
-isa_readw(unsigned long offset)
-{
-	void __iomem *addr = ioremap(offset, 2);
-	u16 ret = readw(addr);
-	iounmap(addr);
-	return ret;
-}
-
-static inline u32
-isa_readl(unsigned long offset)
-{
-	void __iomem *addr = ioremap(offset, 2);
-	u32 ret = readl(addr);
-	iounmap(addr);
-	return ret;
-}
-
-static inline void
-isa_writeb(u8 b, unsigned long offset)
-{
-	void __iomem *addr = ioremap(offset, 2);
-	writeb(b, addr);
-	iounmap(addr);
-}
-
-static inline void
-isa_writew(u16 w, unsigned long offset)
-{
-	void __iomem *addr = ioremap(offset, 2);
-	writew(w, addr);
-	iounmap(addr);
-}
-
-static inline void
-isa_writel(u32 l, unsigned long offset)
-{
-	void __iomem *addr = ioremap(offset, 2);
-	writel(l, addr);
-	iounmap(addr);
-}
-
-static inline void
-isa_memset_io(unsigned long offset, u8 val, long n)
-{
-	void __iomem *addr = ioremap(offset, n);
-	memset_io(addr, val, n);
-	iounmap(addr);
-}
-
-static inline void
-isa_memcpy_fromio(void *dest, unsigned long offset, long n)
-{
-	void __iomem *addr = ioremap(offset, n);
-	memcpy_fromio(dest, addr, n);
-	iounmap(addr);
-}
-
-static inline void
-isa_memcpy_toio(unsigned long offset, const void *src, long n)
-{
-	void __iomem *addr = ioremap(offset, n);
-	memcpy_toio(addr, src, n);
-	iounmap(addr);
-}
-
 /*
  * The Alpha Jensen hardware for some rather strange reason puts
  * the RTC clock at 0x170 instead of 0x70. Probably due to some
diff --git a/include/asm-arm/io.h b/include/asm-arm/io.h
--- a/include/asm-arm/io.h
+++ b/include/asm-arm/io.h
@@ -215,42 +215,6 @@ out:
 #endif	/* __mem_pci */
 
 /*
- * If this architecture has ISA IO, then define the isa_read/isa_write
- * macros.
- */
-#ifdef __mem_isa
-
-#define isa_readb(addr)			__raw_readb(__mem_isa(addr))
-#define isa_readw(addr)			__raw_readw(__mem_isa(addr))
-#define isa_readl(addr)			__raw_readl(__mem_isa(addr))
-#define isa_writeb(val,addr)		__raw_writeb(val,__mem_isa(addr))
-#define isa_writew(val,addr)		__raw_writew(val,__mem_isa(addr))
-#define isa_writel(val,addr)		__raw_writel(val,__mem_isa(addr))
-#define isa_memset_io(a,b,c)		_memset_io(__mem_isa(a),(b),(c))
-#define isa_memcpy_fromio(a,b,c)	_memcpy_fromio((a),__mem_isa(b),(c))
-#define isa_memcpy_toio(a,b,c)		_memcpy_toio(__mem_isa((a)),(b),(c))
-
-#define isa_eth_io_copy_and_sum(a,b,c,d) \
-				eth_copy_and_sum((a),__mem_isa(b),(c),(d))
-
-#else	/* __mem_isa */
-
-#define isa_readb(addr)			(__readwrite_bug("isa_readb"),0)
-#define isa_readw(addr)			(__readwrite_bug("isa_readw"),0)
-#define isa_readl(addr)			(__readwrite_bug("isa_readl"),0)
-#define isa_writeb(val,addr)		__readwrite_bug("isa_writeb")
-#define isa_writew(val,addr)		__readwrite_bug("isa_writew")
-#define isa_writel(val,addr)		__readwrite_bug("isa_writel")
-#define isa_memset_io(a,b,c)		__readwrite_bug("isa_memset_io")
-#define isa_memcpy_fromio(a,b,c)	__readwrite_bug("isa_memcpy_fromio")
-#define isa_memcpy_toio(a,b,c)		__readwrite_bug("isa_memcpy_toio")
-
-#define isa_eth_io_copy_and_sum(a,b,c,d) \
-				__readwrite_bug("isa_eth_io_copy_and_sum")
-
-#endif	/* __mem_isa */
-
-/*
  * ioremap and friends.
  *
  * ioremap takes a PCI memory address, as specified in
diff --git a/include/asm-i386/io.h b/include/asm-i386/io.h
--- a/include/asm-i386/io.h
+++ b/include/asm-i386/io.h
@@ -214,23 +214,11 @@ static inline void memcpy_toio(volatile 
  */
 #define __ISA_IO_base ((char __iomem *)(PAGE_OFFSET))
 
-#define isa_readb(a) readb(__ISA_IO_base + (a))
-#define isa_readw(a) readw(__ISA_IO_base + (a))
-#define isa_readl(a) readl(__ISA_IO_base + (a))
-#define isa_writeb(b,a) writeb(b,__ISA_IO_base + (a))
-#define isa_writew(w,a) writew(w,__ISA_IO_base + (a))
-#define isa_writel(l,a) writel(l,__ISA_IO_base + (a))
-#define isa_memset_io(a,b,c)		memset_io(__ISA_IO_base + (a),(b),(c))
-#define isa_memcpy_fromio(a,b,c)	memcpy_fromio((a),__ISA_IO_base + (b),(c))
-#define isa_memcpy_toio(a,b,c)		memcpy_toio(__ISA_IO_base + (a),(b),(c))
-
-
 /*
  * Again, i386 does not require mem IO specific function.
  */
 
 #define eth_io_copy_and_sum(a,b,c,d)		eth_copy_and_sum((a),(void __force *)(b),(c),(d))
-#define isa_eth_io_copy_and_sum(a,b,c,d)	eth_copy_and_sum((a),(void __force *)(__ISA_IO_base + (b)),(c),(d))
 
 /**
  *	check_signature		-	find BIOS signatures
diff --git a/include/asm-mips/io.h b/include/asm-mips/io.h
--- a/include/asm-mips/io.h
+++ b/include/asm-mips/io.h
@@ -572,24 +572,11 @@ extern void pci_iounmap(struct pci_dev *
  */
 #define __ISA_IO_base ((char *)(isa_slot_offset))
 
-#define isa_readb(a)		readb(__ISA_IO_base + (a))
-#define isa_readw(a)		readw(__ISA_IO_base + (a))
-#define isa_readl(a)		readl(__ISA_IO_base + (a))
-#define isa_readq(a)		readq(__ISA_IO_base + (a))
-#define isa_writeb(b,a)		writeb(b,__ISA_IO_base + (a))
-#define isa_writew(w,a)		writew(w,__ISA_IO_base + (a))
-#define isa_writel(l,a)		writel(l,__ISA_IO_base + (a))
-#define isa_writeq(q,a)		writeq(q,__ISA_IO_base + (a))
-#define isa_memset_io(a,b,c)	memset_io(__ISA_IO_base + (a),(b),(c))
-#define isa_memcpy_fromio(a,b,c) memcpy_fromio((a),__ISA_IO_base + (b),(c))
-#define isa_memcpy_toio(a,b,c)	memcpy_toio(__ISA_IO_base + (a),(b),(c))
-
 /*
  * We don't have csum_partial_copy_fromio() yet, so we cheat here and
  * just copy it. The net code will then do the checksum later.
  */
 #define eth_io_copy_and_sum(skb,src,len,unused) memcpy_fromio((skb)->data,(src),(len))
-#define isa_eth_io_copy_and_sum(a,b,c,d) eth_copy_and_sum((a),(b),(c),(d))
 
 /*
  *     check_signature         -       find BIOS signatures
diff --git a/include/asm-parisc/io.h b/include/asm-parisc/io.h
--- a/include/asm-parisc/io.h
+++ b/include/asm-parisc/io.h
@@ -294,22 +294,6 @@ void memset_io(volatile void __iomem *ad
 void memcpy_fromio(void *dst, const volatile void __iomem *src, int count);
 void memcpy_toio(volatile void __iomem *dst, const void *src, int count);
 
-/* Support old drivers which don't ioremap.
- * NB this interface is scheduled to disappear in 2.5
- */
-
-#define __isa_addr(x) (void __iomem *)(F_EXTEND(0xfc000000) | (x))
-#define isa_readb(a) readb(__isa_addr(a))
-#define isa_readw(a) readw(__isa_addr(a))
-#define isa_readl(a) readl(__isa_addr(a))
-#define isa_writeb(b,a) writeb((b), __isa_addr(a))
-#define isa_writew(b,a) writew((b), __isa_addr(a))
-#define isa_writel(b,a) writel((b), __isa_addr(a))
-#define isa_memset_io(a,b,c) memset_io(__isa_addr(a), (b), (c))
-#define isa_memcpy_fromio(a,b,c) memcpy_fromio((a), __isa_addr(b), (c))
-#define isa_memcpy_toio(a,b,c) memcpy_toio(__isa_addr(a), (b), (c))
-
-
 /*
  * XXX - We don't have csum_partial_copy_fromio() yet, so we cheat here and 
  * just copy it. The net code will then do the checksum later. Presently 
@@ -318,8 +302,6 @@ void memcpy_toio(volatile void __iomem *
 
 #define eth_io_copy_and_sum(skb,src,len,unused) \
   memcpy_fromio((skb)->data,(src),(len))
-#define isa_eth_io_copy_and_sum(skb,src,len,unused) \
-  isa_memcpy_fromio((skb)->data,(src),(len))
 
 /* Port-space IO */
 
diff --git a/include/asm-sh/io.h b/include/asm-sh/io.h
--- a/include/asm-sh/io.h
+++ b/include/asm-sh/io.h
@@ -159,19 +159,6 @@ static inline void __set_io_port_base(un
 	generic_io_base = pbase;
 }
 
-#define isa_readb(a) readb(isa_port2addr(a))
-#define isa_readw(a) readw(isa_port2addr(a))
-#define isa_readl(a) readl(isa_port2addr(a))
-#define isa_writeb(b,a) writeb(b,isa_port2addr(a))
-#define isa_writew(w,a) writew(w,isa_port2addr(a))
-#define isa_writel(l,a) writel(l,isa_port2addr(a))
-#define isa_memset_io(a,b,c) \
-  memset((void *)(isa_port2addr((unsigned long)a)),(b),(c))
-#define isa_memcpy_fromio(a,b,c) \
-  memcpy((a),(void *)(isa_port2addr((unsigned long)(b))),(c))
-#define isa_memcpy_toio(a,b,c) \
-  memcpy((void *)(isa_port2addr((unsigned long)(a))),(b),(c))
-
 /* We really want to try and get these to memcpy etc */
 extern void memcpy_fromio(void *, unsigned long, unsigned long);
 extern void memcpy_toio(unsigned long, const void *, unsigned long);
diff --git a/include/asm-x86_64/io.h b/include/asm-x86_64/io.h
--- a/include/asm-x86_64/io.h
+++ b/include/asm-x86_64/io.h
@@ -264,23 +264,11 @@ void memset_io(volatile void __iomem *a,
  */
 #define __ISA_IO_base ((char __iomem *)(PAGE_OFFSET))
 
-#define isa_readb(a) readb(__ISA_IO_base + (a))
-#define isa_readw(a) readw(__ISA_IO_base + (a))
-#define isa_readl(a) readl(__ISA_IO_base + (a))
-#define isa_writeb(b,a) writeb(b,__ISA_IO_base + (a))
-#define isa_writew(w,a) writew(w,__ISA_IO_base + (a))
-#define isa_writel(l,a) writel(l,__ISA_IO_base + (a))
-#define isa_memset_io(a,b,c)		memset_io(__ISA_IO_base + (a),(b),(c))
-#define isa_memcpy_fromio(a,b,c)	memcpy_fromio((a),__ISA_IO_base + (b),(c))
-#define isa_memcpy_toio(a,b,c)		memcpy_toio(__ISA_IO_base + (a),(b),(c))
-
-
 /*
  * Again, x86-64 does not require mem IO specific function.
  */
 
 #define eth_io_copy_and_sum(a,b,c,d)		eth_copy_and_sum((a),(void *)(b),(c),(d))
-#define isa_eth_io_copy_and_sum(a,b,c,d)	eth_copy_and_sum((a),(void *)(__ISA_IO_base + (b)),(c),(d))
 
 /**
  *	check_signature		-	find BIOS signatures

