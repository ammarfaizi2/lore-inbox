Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbWAZW4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbWAZW4J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 17:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWAZW4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 17:56:09 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5639 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964981AbWAZW4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 17:56:06 -0500
Date: Thu, 26 Jan 2006 23:56:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [8/10] remove ISA legacy functions: remove the helpers
Message-ID: <20060126225604.GM3668@stusta.de>
References: <20060126223126.GD3668@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126223126.GD3668@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

unused isa_...() helpers removed.

Adrian Bunk:
The asm-sh part was rediffed due to unrelated changes.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/asm-alpha/io.h  |   84 ----------------------------------------
 include/asm-arm/io.h    |   36 -----------------
 include/asm-i386/io.h   |   12 -----
 include/asm-mips/io.h   |   13 ------
 include/asm-parisc/io.h |   18 --------
 include/asm-sh/io.h     |   14 ------
 include/asm-x86_64/io.h |   12 -----
 7 files changed, 189 deletions(-)

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

--- linux-2.6.16-rc1-mm2-full/include/asm-sh/io.h.old	2006-01-25 04:58:17.000000000 +0100
+++ linux-2.6.16-rc1-mm2-full/include/asm-sh/io.h	2006-01-25 04:58:31.000000000 +0100
@@ -174,20 +174,6 @@
 	generic_io_base = pbase;
 }
 
-#define isa_readb(a) readb(ioport_map(a, 1))
-#define isa_readw(a) readw(ioport_map(a, 2))
-#define isa_readl(a) readl(ioport_map(a, 4))
-#define isa_writeb(b,a) writeb(b,ioport_map(a, 1))
-#define isa_writew(w,a) writew(w,ioport_map(a, 2))
-#define isa_writel(l,a) writel(l,ioport_map(a, 4))
-
-#define isa_memset_io(a,b,c) \
-  memset((void *)(ioport_map((unsigned long)(a), 1)),(b),(c))
-#define isa_memcpy_fromio(a,b,c) \
-  memcpy((a),(void *)(ioport_map((unsigned long)(b), 1)),(c))
-#define isa_memcpy_toio(a,b,c) \
-  memcpy((void *)(ioport_map((unsigned long)(a), 1)),(b),(c))
-
 /* We really want to try and get these to memcpy etc */
 extern void memcpy_fromio(void *, volatile void __iomem *, unsigned long);
 extern void memcpy_toio(volatile void __iomem *, const void *, unsigned long);
