Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267278AbUIWUci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267278AbUIWUci (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267248AbUIWUc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:32:29 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:9600 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S265805AbUIWU03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:26:29 -0400
Date: Thu, 23 Sep 2004 22:26:01 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roland Dreier <roland@topspin.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] matroxfb big-endian update (was Re: [PATCH] ppc64: Fix __raw_* IO accessors)
Message-ID: <20040923202601.GA6586@vana.vc.cvut.cz>
References: <1095761113.30931.13.camel@localhost.localdomain> <1095766919.3577.138.camel@gaston> <523c1bpghm.fsf@topspin.com> <Pine.LNX.4.58.0409211237510.25656@ppc970.osdl.org> <52mzzjnuq7.fsf@topspin.com> <Pine.LNX.4.58.0409211510150.25656@ppc970.osdl.org> <1095816897.21231.32.camel@gaston> <20040922185851.GA11017@vana.vc.cvut.cz> <1095900539.6359.46.camel@gaston> <20040923152530.GA9377@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040923152530.GA9377@vana.vc.cvut.cz>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew & Linus,

This change disconnects matroxfb accelerator endianess from processor endianess, plus
ports big-endian accessors from __raw_xxx to xxx + appropriate byte swaps.

Now you can select accelerator endianess during 'make config', while framebuffer endianess
depends on processor endianess (I hope that this is correct byte ordering for framebuffer).

Originally I tried to make CONFIG_FB_MATROX_BIG_ENDIAN_ACCEL depending on BE hardware (so
LE users could not screw their X servers), but unfortunately there does not seem to be generic
BIG_ENDIAN configuration option, and list of BE architectures seemed too long to me
(depends on FB_MATROX && (ARCH_S390 || ARM || H8300 || M32R || M69K || MIPS || PARISC || PPC ||
   SPARC32 || SPARC64 || SUPERH) ), so now also little-endian users can run accelerator
in BE mode.

If you prefer just dropping support for BE accel instead (and BE users will have to cope),
just tell me.

It also fixes small typo - M_C2CTL should be 0x3C10 and not 0x3E10.  Apparently Matrox notes
about need to program this register during initialization are not so important...

Patch was tested only on little-endian hardware, with both values for CONFIG_FB_MATROX_BIG_ENDIAN_ACCEL
(and I verified that hardware actually was in BE mode).  Patch applies to current -bk, and
with small offset in video/Kconfig also to 2.6.9-rc2-mm2.



Signed-off-by: Petr Vandrovec <vandrove@vc.cvut.cz>



diff -urdN linux/drivers/video/Kconfig linux/drivers/video/Kconfig
--- linux/drivers/video/Kconfig	2004-09-23 15:39:47.000000000 +0000
+++ linux/drivers/video/Kconfig	2004-09-23 18:44:50.000000000 +0000
@@ -654,6 +654,16 @@
 	  There is no need for enabling 'Matrox multihead support' if you have
 	  only one Matrox card in the box.
 
+config FB_MATROX_BIG_ENDIAN_ACCEL
+	bool "Drive accelerator in big-endian mode"
+	depends on FB_MATROX
+	---help---
+	  Say Y here if you are using applications which depend on Matrox
+	  device being in big-endian mode.  Note that it is not recommended
+	  to run device in big-endian mode on little-endian systems.
+
+	  If you do not know what this option talks about, say N.
+
 config FB_RADEON_OLD
 	tristate "ATI Radeon display support (Old driver)"
 	depends on FB && PCI
diff -urdN linux/drivers/video/matrox/matroxfb_accel.c linux/drivers/video/matrox/matroxfb_accel.c
--- linux/drivers/video/matrox/matroxfb_accel.c	2004-09-23 15:46:44.000000000 +0000
+++ linux/drivers/video/matrox/matroxfb_accel.c	2004-09-23 20:12:25.000000000 +0000
@@ -432,32 +432,24 @@
 	mga_writel(mmio, M_AR3, 0);
 	if (easy) {
 		mga_writel(mmio, M_YDSTLEN | M_EXEC, ydstlen);
-		mga_memcpy_toio(mmio, 0, chardata, xlen);
+		mga_memcpy_toio(mmio, chardata, xlen);
 	} else {
 		mga_writel(mmio, M_AR5, 0);
 		mga_writel(mmio, M_YDSTLEN | M_EXEC, ydstlen);
 		if ((step & 3) == 0) {
 			/* Great. Source has 32bit aligned lines, so we can feed them
 			   directly to the accelerator. */
-			mga_memcpy_toio(mmio, 0, chardata, charcell);
+			mga_memcpy_toio(mmio, chardata, charcell);
 		} else if (step == 1) {
 			/* Special case for 1..8bit widths */
 			while (height--) {
-#ifdef __LITTLE_ENDIAN
-				mga_writel(mmio, 0, *chardata);
-#else
-				mga_writel(mmio, 0, (*chardata) << 24);
-#endif
+				writel(*chardata, mmio.vaddr);
 				chardata++;
 			}
 		} else if (step == 2) {
 			/* Special case for 9..15bit widths */
 			while (height--) {
-#ifdef __LITTLE_ENDIAN
-				mga_writel(mmio, 0, *(u_int16_t*)chardata);
-#else
-				mga_writel(mmio, 0, (*(u_int16_t*)chardata) << 16);
-#endif
+				writel(*(u_int16_t*)chardata, mmio.vaddr);
 				chardata += 2;
 			}
 		} else {
@@ -467,7 +459,7 @@
 				
 				for (i = 0; i < step; i += 4) {
 					/* Hope that there are at least three readable bytes beyond the end of bitmap */
-					mga_writel(mmio, 0, get_unaligned((u_int32_t*)(chardata + i)));
+					writel(get_unaligned((u_int32_t*)(chardata + i)), mmio.vaddr);
 				}
 				chardata += step;
 			}
diff -urdN linux/drivers/video/matrox/matroxfb_base.h linux/drivers/video/matrox/matroxfb_base.h
--- linux/drivers/video/matrox/matroxfb_base.h	2004-09-23 15:42:26.000000000 +0000
+++ linux/drivers/video/matrox/matroxfb_base.h	2004-09-23 20:15:13.000000000 +0000
@@ -99,17 +99,6 @@
 #endif
 #endif
 
-#if defined(__alpha__) || defined(__mc68000__) || defined(__i386__) || defined(__x86_64__)
-#define READx_WORKS
-#define MEMCPYTOIO_WORKS
-#else
-/* ppc/ppc64 must use __raw_{read,write}[bwl] as we drive adapter 
-   in big-endian mode for compatibility with XFree mga driver, and
-   so we do not want little-endian {read,write}[bwl] */
-#define READx_FAILS
-#define MEMCPYTOIO_WRITEL
-#endif
-
 #if defined(__mc68000__)
 #define MAP_BUSTOVIRT
 #else
@@ -155,86 +144,78 @@
 #endif
 
 typedef struct {
-	u_int8_t __iomem*	vaddr;
+	void __iomem*	vaddr;
 } vaddr_t;
 
-#ifdef READx_WORKS
 static inline unsigned int mga_readb(vaddr_t va, unsigned int offs) {
 	return readb(va.vaddr + offs);
 }
 
-static inline unsigned int mga_readw(vaddr_t va, unsigned int offs) {
-	return readw(va.vaddr + offs);
-}
-
-static inline u_int32_t mga_readl(vaddr_t va, unsigned int offs) {
-	return readl(va.vaddr + offs);
-}
-
 static inline void mga_writeb(vaddr_t va, unsigned int offs, u_int8_t value) {
 	writeb(value, va.vaddr + offs);
 }
 
-static inline void mga_writew(vaddr_t va, unsigned int offs, u_int16_t value) {
+static inline void mga_writew_le(vaddr_t va, unsigned int offs, u_int16_t value) {
 	writew(value, va.vaddr + offs);
 }
 
-static inline void mga_writel(vaddr_t va, unsigned int offs, u_int32_t value) {
-	writel(value, va.vaddr + offs);
-}
-#else
-static inline unsigned int mga_readb(vaddr_t va, unsigned int offs) {
-	return __raw_readb(va.vaddr + offs);
-}
-
-static inline unsigned int mga_readw(vaddr_t va, unsigned int offs) {
-	return __raw_readw(va.vaddr + offs);
+#ifdef CONFIG_FB_MATROX_BIG_ENDIAN_ACCEL
+static inline void mga_writew(vaddr_t va, unsigned int offs, u_int16_t value) {
+	mga_writew_le(va, offs, swab16(value));
 }
 
 static inline u_int32_t mga_readl(vaddr_t va, unsigned int offs) {
-	return __raw_readl(va.vaddr + offs);
+	return swab32(readl(va.vaddr + offs));
 }
 
-static inline void mga_writeb(vaddr_t va, unsigned int offs, u_int8_t value) {
-	__raw_writeb(value, va.vaddr + offs);
+static inline void mga_writel(vaddr_t va, unsigned int offs, u_int32_t value) {
+	writel(swab32(value), va.vaddr + offs);
 }
-
+#else
+#if defined(__alpha__) || defined(__i386__) || defined(__x86_64__)
+#define MEMCPYTOIO_WORKS
+#endif
 static inline void mga_writew(vaddr_t va, unsigned int offs, u_int16_t value) {
-	__raw_writew(value, va.vaddr + offs);
+	mga_writew_le(va, offs, value);
+}
+
+static inline u_int32_t mga_readl(vaddr_t va, unsigned int offs) {
+	return readl(va.vaddr + offs);
 }
 
 static inline void mga_writel(vaddr_t va, unsigned int offs, u_int32_t value) {
-	__raw_writel(value, va.vaddr + offs);
+	writel(value, va.vaddr + offs);
 }
 #endif
 
-static inline void mga_memcpy_toio(vaddr_t va, unsigned int offs, const void* src, int len) {
+static inline void mga_memcpy_toio(vaddr_t va, const void* src, int len) {
 #ifdef MEMCPYTOIO_WORKS
-	memcpy_toio(va.vaddr + offs, src, len);
-#elif defined(MEMCPYTOIO_WRITEL)
-	if (offs & 3) {
+	/*
+	 * memcpy_toio works for us if:
+	 *  (1) Copies data as 32bit quantities, not byte after byte,
+	 *  (2) Performs LE ordered stores, and
+	 *  (3) It copes with unaligned source (destination is guaranteed to be page
+	 *      aligned and length is guaranteed to be multiple of 4).
+	 */
+	memcpy_toio(va.vaddr, src, len);
+#else
+        u_int32_t __iomem* addr = va.vaddr;
+
+	if ((unsigned long)src & 3) {
 		while (len >= 4) {
-			mga_writel(va, offs, get_unaligned((u32 *)src));
-			offs += 4;
+			writel(get_unaligned((u32 *)src), addr);
+			addr++;
 			len -= 4;
 			src += 4;
 		}
 	} else {
 		while (len >= 4) {
-			mga_writel(va, offs, *(u32 *)src);
-			offs += 4;
+			writel(*(u32 *)src, addr);
+			addr++;
 			len -= 4;
 			src += 4;
 		}
 	}
-	if (len) {
-		u_int32_t tmp;
-
-		memcpy(&tmp, src, len);
-		mga_writel(va, offs, tmp);
-	}
-#else
-#error "Sorry, do not know how to write block of data to device"
 #endif
 }
 
@@ -774,11 +755,15 @@
 #define DAC_XGENIOCTRL		0x2A
 #define DAC_XGENIODATA		0x2B
 
-#define M_C2CTL		0x3E10
+#define M_C2CTL		0x3C10
 
-#ifdef __LITTLE_ENDIAN
-#define MX_OPTION_BSWAP		0x00000000
+#ifdef CONFIG_FB_MATROX_BIG_ENDIAN_ACCEL
+#define MX_OPTION_BSWAP		0x80000000
+#else
+#define MX_OPTION_BSWAP         0x00000000
+#endif
 
+#ifdef __LITTLE_ENDIAN
 #define M_OPMODE_4BPP	(M_OPMODE_DMA_LE | M_OPMODE_DIR_LE | M_OPMODE_DMA_BLIT)
 #define M_OPMODE_8BPP	(M_OPMODE_DMA_LE | M_OPMODE_DIR_LE | M_OPMODE_DMA_BLIT)
 #define M_OPMODE_16BPP	(M_OPMODE_DMA_LE | M_OPMODE_DIR_LE | M_OPMODE_DMA_BLIT)
@@ -786,29 +771,28 @@
 #define M_OPMODE_32BPP	(M_OPMODE_DMA_LE | M_OPMODE_DIR_LE | M_OPMODE_DMA_BLIT)
 #else
 #ifdef __BIG_ENDIAN
-#define MX_OPTION_BSWAP		0x80000000
-
-#define M_OPMODE_4BPP	(M_OPMODE_DMA_LE | M_OPMODE_DIR_LE | M_OPMODE_DMA_BLIT)	/* TODO */
+#define M_OPMODE_4BPP	(M_OPMODE_DMA_LE       | M_OPMODE_DIR_LE       | M_OPMODE_DMA_BLIT)	/* TODO */
 #define M_OPMODE_8BPP	(M_OPMODE_DMA_BE_8BPP  | M_OPMODE_DIR_BE_8BPP  | M_OPMODE_DMA_BLIT)
 #define M_OPMODE_16BPP	(M_OPMODE_DMA_BE_16BPP | M_OPMODE_DIR_BE_16BPP | M_OPMODE_DMA_BLIT)
-#define M_OPMODE_24BPP	(M_OPMODE_DMA_BE_8BPP | M_OPMODE_DIR_BE_8BPP | M_OPMODE_DMA_BLIT)	/* TODO, ?32 */
+#define M_OPMODE_24BPP	(M_OPMODE_DMA_BE_8BPP  | M_OPMODE_DIR_BE_8BPP  | M_OPMODE_DMA_BLIT)	/* TODO, ?32 */
 #define M_OPMODE_32BPP	(M_OPMODE_DMA_BE_32BPP | M_OPMODE_DIR_BE_32BPP | M_OPMODE_DMA_BLIT)
 #else
 #error "Byte ordering have to be defined. Cannot continue."
 #endif
 #endif
 
-#define mga_inb(addr)	mga_readb(ACCESS_FBINFO(mmio.vbase), (addr))
-#define mga_inl(addr)	mga_readl(ACCESS_FBINFO(mmio.vbase), (addr))
-#define mga_outb(addr,val) mga_writeb(ACCESS_FBINFO(mmio.vbase), (addr), (val))
-#define mga_outw(addr,val) mga_writew(ACCESS_FBINFO(mmio.vbase), (addr), (val))
-#define mga_outl(addr,val) mga_writel(ACCESS_FBINFO(mmio.vbase), (addr), (val))
-#define mga_readr(port,idx) (mga_outb((port),(idx)), mga_inb((port)+1))
-#ifdef __LITTLE_ENDIAN
-#define mga_setr(addr,port,val) mga_outw(addr, ((val)<<8) | (port))
-#else
-#define mga_setr(addr,port,val) do { mga_outb(addr, port); mga_outb((addr)+1, val); } while (0)
-#endif
+#define mga_inb(addr)		mga_readb(ACCESS_FBINFO(mmio.vbase), (addr))
+#define mga_inl(addr)		mga_readl(ACCESS_FBINFO(mmio.vbase), (addr))
+#define mga_outb(addr,val)	mga_writeb(ACCESS_FBINFO(mmio.vbase), (addr), (val))
+#define mga_outw(addr,val)	mga_writew(ACCESS_FBINFO(mmio.vbase), (addr), (val))
+#define mga_outw_le(addr,val)	mga_writew_le(ACCESS_FBINFO(mmio.vbase), (addr), (val))
+#define mga_outl(addr,val)	mga_writel(ACCESS_FBINFO(mmio.vbase), (addr), (val))
+#define mga_readr(port,idx)	(mga_outb((port),(idx)), mga_inb((port)+1))
+/*
+ * 1F00-1FFF and 3C00-3C0F ranges are not byteswapped (doc says 3C00-3CFF, but it
+ * is incorrect, 3C10-3CFF are swapped)
+ */
+#define mga_setr(addr,port,val)	mga_outw_le(addr, ((val)<<8) | (port))
 
 #define mga_fifo(n)	do {} while ((mga_inl(M_FIFOSTATUS) & 0xFF) < (n))
 
