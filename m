Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbVKLExx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbVKLExx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 23:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbVKLExM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 23:53:12 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9225 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751354AbVKLEwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 23:52:22 -0500
Date: Sat, 12 Nov 2005 05:52:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       netdev@vger.kernel.org, jonathan@buzzard.org.uk,
       tlinux-users@linux.toshiba-dme.co.jp, Jaroslav Kysela <perex@suse.cz>
Subject: [RFC: 2.6 patch] remove ISA legacy functions
Message-ID: <20051112045216.GY5376@stusta.de>
References: <20051107200336.GH3847@stusta.de> <20051110042857.38b4635b.akpm@osdl.org> <20051111021258.GK5376@stusta.de> <20051110182443.514622ed.akpm@osdl.org> <20051111201849.GP5376@stusta.de> <20051111202005.GQ5376@stusta.de> <20051111203601.GR5376@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051111203601.GR5376@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the ISA legacy functions that are deprecated since 
kernel 2.4 and that aren't available on all architectures.

The 7 drivers that were still using this obsolete API are now marked
as BROKEN.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/DocBook/deviceiobook.tmpl |   19 -----
 arch/i386/Kconfig                       |    1 
 drivers/net/Kconfig                     |    6 -
 drivers/net/arcnet/Kconfig              |    4 -
 drivers/scsi/Kconfig                    |    2 
 include/asm-alpha/io.h                  |   83 ------------------------
 include/asm-arm/arch-aaec2000/io.h      |    1 
 include/asm-arm/arch-clps711x/io.h      |    1 
 include/asm-arm/arch-ebsa285/io.h       |    8 --
 include/asm-arm/arch-integrator/io.h    |    1 
 include/asm-arm/arch-iop3xx/io.h        |    1 
 include/asm-arm/arch-l7200/io.h         |    1 
 include/asm-arm/arch-lh7a40x/io.h       |    1 
 include/asm-arm/arch-omap/io.h          |    1 
 include/asm-arm/arch-pxa/io.h           |    1 
 include/asm-arm/arch-realview/io.h      |    1 
 include/asm-arm/arch-sa1100/io.h        |    1 
 include/asm-arm/arch-versatile/io.h     |    1 
 include/asm-arm/io.h                    |   36 ----------
 include/asm-i386/io.h                   |   11 ---
 include/asm-m68k/io.h                   |   21 ++----
 include/asm-mips/io.h                   |   23 ------
 include/asm-parisc/io.h                 |   18 -----
 include/asm-sh/io.h                     |   13 ---
 include/asm-x86_64/io.h                 |   11 ---
 25 files changed, 15 insertions(+), 252 deletions(-)

--- linux-2.6.14-mm2-full/Documentation/DocBook/deviceiobook.tmpl.old	2005-11-11 21:44:08.000000000 +0100
+++ linux-2.6.14-mm2-full/Documentation/DocBook/deviceiobook.tmpl	2005-11-11 21:44:18.000000000 +0100
@@ -270,25 +270,6 @@
       </para>
     </sect1>
 
-    <sect1>
-      <title>ISA legacy functions</title>
-      <para>
-	On older kernels (2.2 and earlier) the ISA bus could be read or
-	written with these functions and without ioremap being used. This is
-	no longer true in Linux 2.4. A set of equivalent functions exist for
-	easy legacy driver porting. The functions available are prefixed
-	with 'isa_' and are <function>isa_readb</function>,
-	<function>isa_writeb</function>, <function>isa_readw</function>, 
-	<function>isa_writew</function>, <function>isa_readl</function>,
-	<function>isa_writel</function>, <function>isa_memcpy_fromio</function>
-	and <function>isa_memcpy_toio</function>
-      </para>
-      <para>
-	These functions should not be used in new drivers, and will
-	eventually be going away.
-      </para>
-    </sect1>
-
   </chapter>
 
   <chapter>
--- linux-2.6.14-mm2-full/include/asm-alpha/io.h.old	2005-11-11 21:39:55.000000000 +0100
+++ linux-2.6.14-mm2-full/include/asm-alpha/io.h	2005-11-11 21:59:27.000000000 +0100
@@ -534,9 +534,6 @@
 #define eth_io_copy_and_sum(skb,src,len,unused) \
   memcpy_fromio((skb)->data,src,len)
 
-#define isa_eth_io_copy_and_sum(skb,src,len,unused) \
-  isa_memcpy_fromio((skb)->data,src,len)
-
 static inline int
 check_signature(const volatile void __iomem *io_addr,
 		const unsigned char *signature, int length)
@@ -552,86 +549,6 @@
 
 
 /*
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
-/*
  * The Alpha Jensen hardware for some rather strange reason puts
  * the RTC clock at 0x170 instead of 0x70. Probably due to some
  * misguided idea about using 0x70 for NMI stuff.
--- linux-2.6.14-mm2-full/include/asm-arm/io.h.old	2005-11-11 21:40:42.000000000 +0100
+++ linux-2.6.14-mm2-full/include/asm-arm/io.h	2005-11-11 21:59:36.000000000 +0100
@@ -215,42 +215,6 @@
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
--- linux-2.6.14-mm2-full/include/asm-i386/io.h.old	2005-11-11 21:41:07.000000000 +0100
+++ linux-2.6.14-mm2-full/include/asm-i386/io.h	2005-11-12 00:37:26.000000000 +0100
@@ -214,23 +214,12 @@
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
 
 /*
  * Again, i386 does not require mem IO specific function.
  */
 
 #define eth_io_copy_and_sum(a,b,c,d)		eth_copy_and_sum((a),(void __force *)(b),(c),(d))
-#define isa_eth_io_copy_and_sum(a,b,c,d)	eth_copy_and_sum((a),(void __force *)(__ISA_IO_base + (b)),(c),(d))
 
 /**
  *	check_signature		-	find BIOS signatures
--- linux-2.6.14-mm2-full/include/asm-mips/io.h.old	2005-11-11 21:41:23.000000000 +0100
+++ linux-2.6.14-mm2-full/include/asm-mips/io.h	2005-11-11 22:00:31.000000000 +0100
@@ -563,33 +563,10 @@
 extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
 
 /*
- * ISA space is 'always mapped' on currently supported MIPS systems, no need
- * to explicitly ioremap() it. The fact that the ISA IO space is mapped
- * to PAGE_OFFSET is pure coincidence - it does not mean ISA values
- * are physical addresses. The following constant pointer can be
- * used as the IO-area pointer (it can be iounmapped as well, so the
- * analogy with PCI is quite large):
- */
-#define __ISA_IO_base ((char *)(isa_slot_offset))
-
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
-/*
  * We don't have csum_partial_copy_fromio() yet, so we cheat here and
  * just copy it. The net code will then do the checksum later.
  */
 #define eth_io_copy_and_sum(skb,src,len,unused) memcpy_fromio((skb)->data,(src),(len))
-#define isa_eth_io_copy_and_sum(a,b,c,d) eth_copy_and_sum((a),(b),(c),(d))
 
 /*
  *     check_signature         -       find BIOS signatures
--- linux-2.6.14-mm2-full/include/asm-parisc/io.h.old	2005-11-11 21:41:44.000000000 +0100
+++ linux-2.6.14-mm2-full/include/asm-parisc/io.h	2005-11-11 22:01:12.000000000 +0100
@@ -294,22 +294,6 @@
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
@@ -318,8 +302,6 @@
 
 #define eth_io_copy_and_sum(skb,src,len,unused) \
   memcpy_fromio((skb)->data,(src),(len))
-#define isa_eth_io_copy_and_sum(skb,src,len,unused) \
-  isa_memcpy_fromio((skb)->data,(src),(len))
 
 /* Port-space IO */
 
--- linux-2.6.14-mm2-full/include/asm-x86_64/io.h.old	2005-11-11 21:41:58.000000000 +0100
+++ linux-2.6.14-mm2-full/include/asm-x86_64/io.h	2005-11-12 00:38:07.000000000 +0100
@@ -264,23 +264,12 @@
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
 
 /*
  * Again, x86-64 does not require mem IO specific function.
  */
 
 #define eth_io_copy_and_sum(a,b,c,d)		eth_copy_and_sum((a),(void *)(b),(c),(d))
-#define isa_eth_io_copy_and_sum(a,b,c,d)	eth_copy_and_sum((a),(void *)(__ISA_IO_base + (b)),(c),(d))
 
 /**
  *	check_signature		-	find BIOS signatures
--- linux-2.6.14-mm2-full/include/asm-m68k/io.h.old	2005-11-11 21:49:11.000000000 +0100
+++ linux-2.6.14-mm2-full/include/asm-m68k/io.h	2005-11-11 21:56:15.000000000 +0100
@@ -191,15 +191,6 @@
 #define isa_outb(val,port) out_8(isa_itb(port),(val))
 #define isa_outw(val,port) (ISA_SEX ? out_be16(isa_itw(port),(val)) : out_le16(isa_itw(port),(val)))
 
-#define isa_readb(p)       in_8(isa_mtb((unsigned long)(p)))
-#define isa_readw(p)       \
-	(ISA_SEX ? in_be16(isa_mtw((unsigned long)(p)))	\
-		 : in_le16(isa_mtw((unsigned long)(p))))
-#define isa_writeb(val,p)  out_8(isa_mtb((unsigned long)(p)),(val))
-#define isa_writew(val,p)  \
-	(ISA_SEX ? out_be16(isa_mtw((unsigned long)(p)),(val))	\
-		 : out_le16(isa_mtw((unsigned long)(p)),(val)))
-
 static inline void isa_delay(void)
 {
   switch(ISA_TYPE)
@@ -254,10 +245,14 @@
 #define insw    isa_insw
 #define outsb   isa_outsb
 #define outsw   isa_outsw
-#define readb   isa_readb
-#define readw   isa_readw
-#define writeb  isa_writeb
-#define writew  isa_writew
+#define readb(p) in_8(isa_mtb((unsigned long)(p)))
+#define readw(p)       \
+	(ISA_SEX ? in_be16(isa_mtw((unsigned long)(p)))	\
+		 : in_le16(isa_mtw((unsigned long)(p))))
+#define writeb(val,p)  out_8(isa_mtb((unsigned long)(p)),(val))
+#define writew(val,p)  \
+	(ISA_SEX ? out_be16(isa_mtw((unsigned long)(p)),(val))	\
+		 : out_le16(isa_mtw((unsigned long)(p)),(val)))
 #endif /* CONFIG_ISA */
 
 #if defined(CONFIG_PCI)
--- linux-2.6.14-mm2-full/include/asm-sh/io.h.old	2005-11-11 21:50:43.000000000 +0100
+++ linux-2.6.14-mm2-full/include/asm-sh/io.h	2005-11-11 22:01:37.000000000 +0100
@@ -159,19 +159,6 @@
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
--- linux-2.6.14-mm2-full/arch/i386/Kconfig.old	2005-11-11 21:44:56.000000000 +0100
+++ linux-2.6.14-mm2-full/arch/i386/Kconfig	2005-11-11 21:45:09.000000000 +0100
@@ -307,6 +307,7 @@
 
 config TOSHIBA
 	tristate "Toshiba Laptop support"
+	depends on BROKEN
 	---help---
 	  This adds a driver to safely access the System Management Mode of
 	  the CPU on Toshiba portables with a genuine Toshiba BIOS. It does
--- linux-2.6.14-mm2-full/drivers/net/Kconfig.old	2005-11-11 21:52:55.000000000 +0100
+++ linux-2.6.14-mm2-full/drivers/net/Kconfig	2005-11-11 22:02:32.000000000 +0100
@@ -726,7 +726,7 @@
 
 config LANCE
 	tristate "AMD LANCE and PCnet (AT1500 and NE2100) support"
-	depends on NET_ETHERNET && ISA && ISA_DMA_API
+	depends on NET_ETHERNET && ISA && ISA_DMA_API && BROKEN
 	help
 	  If you have a network (Ethernet) card of this type, say Y and read
 	  the Ethernet-HOWTO, available from
@@ -935,7 +935,7 @@
 
 config HP100
 	tristate "HP 10/100VG PCLAN (ISA, EISA, PCI) support"
-	depends on NET_ETHERNET && (ISA || EISA || PCI)
+	depends on NET_ETHERNET && (ISA || EISA || PCI) && BROKEN
 	help
 	  If you have a network (Ethernet) card of this type, say Y and read
 	  the Ethernet-HOWTO, available from
@@ -1021,7 +1021,7 @@
 
 config HPLAN_PLUS
 	tristate "HP PCLAN+ (27247B and 27252A) support"
-	depends on NET_ISA
+	depends on NET_ISA && BROKEN
 	select CRC32
 	help
 	  If you have a network (Ethernet) card of this type, say Y and read
--- linux-2.6.14-mm2-full/drivers/net/arcnet/Kconfig.old	2005-11-11 21:45:50.000000000 +0100
+++ linux-2.6.14-mm2-full/drivers/net/arcnet/Kconfig	2005-11-11 21:46:22.000000000 +0100
@@ -80,7 +80,7 @@
 
 config ARCNET_COM90xx
 	tristate "ARCnet COM90xx (normal) chipset driver"
-	depends on ARCNET
+	depends on ARCNET && BROKEN
 	help
 	  This is the chipset driver for the standard COM90xx cards. If you
 	  have always used the old ARCnet driver without knowing what type of
@@ -105,7 +105,7 @@
 
 config ARCNET_RIM_I
 	tristate "ARCnet COM90xx (RIM I) chipset driver"
-	depends on ARCNET
+	depends on ARCNET && BROKEN
 	---help---
 	  This is yet another chipset driver for the COM90xx cards, but this
 	  time only using memory-mapped mode, and no IO ports at all. This
--- linux-2.6.14-mm2-full/drivers/scsi/Kconfig.old	2005-11-11 21:47:56.000000000 +0100
+++ linux-2.6.14-mm2-full/drivers/scsi/Kconfig	2005-11-11 21:48:17.000000000 +0100
@@ -474,7 +474,7 @@
 
 config SCSI_IN2000
 	tristate "Always IN2000 SCSI support"
-	depends on ISA && SCSI
+	depends on ISA && SCSI && BROKEN
 	help
 	  This is support for an ISA bus SCSI host adapter.  You'll find more
 	  information in <file:Documentation/scsi/in2000.txt>. If it doesn't work
--- linux-2.6.14-mm2-full/include/asm-arm/arch-aaec2000/io.h.old	2005-11-12 05:46:17.000000000 +0100
+++ linux-2.6.14-mm2-full/include/asm-arm/arch-aaec2000/io.h	2005-11-12 05:46:35.000000000 +0100
@@ -16,6 +16,5 @@
  */
 #define __io(a)			((void __iomem *)(a))
 #define __mem_pci(a)		(a)
-#define __mem_isa(a)		(a)
 
 #endif
--- linux-2.6.14-mm2-full/include/asm-arm/arch-clps711x/io.h.old	2005-11-12 05:46:40.000000000 +0100
+++ linux-2.6.14-mm2-full/include/asm-arm/arch-clps711x/io.h	2005-11-12 05:46:47.000000000 +0100
@@ -26,7 +26,6 @@
 
 #define __io(a)			((void __iomem *)(a))
 #define __mem_pci(a)		(a)
-#define __mem_isa(a)		(a)
 
 /*
  * We don't support ins[lb]/outs[lb].  Make them fault.
--- linux-2.6.14-mm2-full/include/asm-arm/arch-ebsa285/io.h.old	2005-11-12 05:47:02.000000000 +0100
+++ linux-2.6.14-mm2-full/include/asm-arm/arch-ebsa285/io.h	2005-11-12 05:47:43.000000000 +0100
@@ -24,7 +24,6 @@
 #define __io(a)			((void __iomem *)(PCIO_BASE + (a)))
 #if 1
 #define __mem_pci(a)		(a)
-#define __mem_isa(a)		((a) + PCIMEM_BASE)
 #else
 
 static inline void __iomem *___mem_pci(void __iomem *p)
@@ -34,14 +33,7 @@
 	return p;
 }
 
-static inline void __iomem *___mem_isa(void __iomem *p)
-{
-	unsigned long a = (unsigned long)p;
-	BUG_ON(a >= 16*1048576);
-	return p + PCIMEM_BASE;
-}
 #define __mem_pci(a)		___mem_pci(a)
-#define __mem_isa(a)		___mem_isa(a)
 #endif
 
 #endif
--- linux-2.6.14-mm2-full/include/asm-arm/arch-integrator/io.h.old	2005-11-12 05:48:52.000000000 +0100
+++ linux-2.6.14-mm2-full/include/asm-arm/arch-integrator/io.h	2005-11-12 05:48:56.000000000 +0100
@@ -32,6 +32,5 @@
 
 #define __io(a)			((void __iomem *)(PCI_IO_VADDR + (a)))
 #define __mem_pci(a)		(a)
-#define __mem_isa(a)		((a) + PCI_MEMORY_VADDR)
 
 #endif
--- linux-2.6.14-mm2-full/include/asm-arm/arch-iop3xx/io.h.old	2005-11-12 05:49:04.000000000 +0100
+++ linux-2.6.14-mm2-full/include/asm-arm/arch-iop3xx/io.h	2005-11-12 05:49:07.000000000 +0100
@@ -17,6 +17,5 @@
 
 #define __io(p)			((void __iomem *)(p))
 #define __mem_pci(a)		(a)
-#define __mem_isa(a)		(a)
 
 #endif
--- linux-2.6.14-mm2-full/include/asm-arm/arch-l7200/io.h.old	2005-11-12 05:49:23.000000000 +0100
+++ linux-2.6.14-mm2-full/include/asm-arm/arch-l7200/io.h	2005-11-12 05:49:28.000000000 +0100
@@ -19,7 +19,6 @@
  */
 #define __io_pci(a)		((void __iomem *)(PCIO_BASE + (a)))
 #define __mem_pci(a)		(a)
-#define __mem_isa(a)		(a)
 
 #define __ioaddr(p)             __io_pci(p)
 
--- linux-2.6.14-mm2-full/include/asm-arm/arch-lh7a40x/io.h.old	2005-11-12 05:49:42.000000000 +0100
+++ linux-2.6.14-mm2-full/include/asm-arm/arch-lh7a40x/io.h	2005-11-12 05:49:47.000000000 +0100
@@ -18,6 +18,5 @@
 /* No ISA or PCI bus on this machine. */
 #define __io(a)			((void __iomem *)(a))
 #define __mem_pci(a)		(a)
-#define __mem_isa(a)		(a)
 
 #endif /* __ASM_ARCH_IO_H */
--- linux-2.6.14-mm2-full/include/asm-arm/arch-omap/io.h.old	2005-11-12 05:49:57.000000000 +0100
+++ linux-2.6.14-mm2-full/include/asm-arm/arch-omap/io.h	2005-11-12 05:50:01.000000000 +0100
@@ -44,7 +44,6 @@
  */
 #define __io(a)			((void __iomem *)(PCIO_BASE + (a)))
 #define __mem_pci(a)		(a)
-#define __mem_isa(a)		(a)
 
 /*
  * ----------------------------------------------------------------------------
--- linux-2.6.14-mm2-full/include/asm-arm/arch-pxa/io.h.old	2005-11-12 05:50:11.000000000 +0100
+++ linux-2.6.14-mm2-full/include/asm-arm/arch-pxa/io.h	2005-11-12 05:50:14.000000000 +0100
@@ -16,6 +16,5 @@
  */
 #define __io(a)			((void __iomem *)(a))
 #define __mem_pci(a)		(a)
-#define __mem_isa(a)		(a)
 
 #endif
--- linux-2.6.14-mm2-full/include/asm-arm/arch-sa1100/io.h.old	2005-11-12 05:50:22.000000000 +0100
+++ linux-2.6.14-mm2-full/include/asm-arm/arch-sa1100/io.h	2005-11-12 05:50:25.000000000 +0100
@@ -24,6 +24,5 @@
 }
 #define __io(a)			__io(a)
 #define __mem_pci(a)		(a)
-#define __mem_isa(a)		(a)
 
 #endif
--- linux-2.6.14-mm2-full/include/asm-arm/arch-versatile/io.h.old	2005-11-12 05:50:34.000000000 +0100
+++ linux-2.6.14-mm2-full/include/asm-arm/arch-versatile/io.h	2005-11-12 05:50:37.000000000 +0100
@@ -28,6 +28,5 @@
 }
 #define __io(a)	__io(a)
 #define __mem_pci(a)		(a)
-#define __mem_isa(a)		(a)
 
 #endif
--- linux-2.6.14-mm2-full/include/asm-arm/arch-realview/io.h.old	2005-11-12 05:50:45.000000000 +0100
+++ linux-2.6.14-mm2-full/include/asm-arm/arch-realview/io.h	2005-11-12 05:50:48.000000000 +0100
@@ -29,6 +29,5 @@
 
 #define __io(a)			__io(a)
 #define __mem_pci(a)		(a)
-#define __mem_isa(a)		(a)
 
 #endif

