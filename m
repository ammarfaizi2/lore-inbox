Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129933AbQLIJPe>; Sat, 9 Dec 2000 04:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130606AbQLIJPX>; Sat, 9 Dec 2000 04:15:23 -0500
Received: from smtp5.libero.it ([193.70.192.55]:41160 "EHLO smtp5.libero.it")
	by vger.kernel.org with ESMTP id <S129933AbQLIJPN>;
	Sat, 9 Dec 2000 04:15:13 -0500
Message-ID: <3A31F094.480AAAFB@alsa-project.org>
Date: Sat, 09 Dec 2000 09:43:00 +0100
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [2*PATCH] alpha I/O access and mb()
Content-Type: multipart/mixed;
 boundary="------------6A571FE22658A1610E0A8F45"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6A571FE22658A1610E0A8F45
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Here you are two patches:

alpha-mb-2.2.diff add the missing mb() to the cores that still lack it
(against 2.2.18pre25)

alpha-mb-2.4.diff add missing defines from core_t2.h for non generic
kernel (against 2.4.0test11)

Please apply on your trees.

I've also noted that 2.4 uses mb() after read[bwlq] while 2.2 don't.
Who's right?

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project is            http://www.alsa-project.org
sponsored by SuSE Linux    http://www.suse.com

It sounds good!
--------------6A571FE22658A1610E0A8F45
Content-Type: text/plain; charset=us-ascii;
 name="alpha-mb-2.2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alpha-mb-2.2.diff"

--- linux-2.2/include/asm-alpha/core_pyxis.h.~1~	Tue Jan  4 19:12:24 2000
+++ linux-2.2/include/asm-alpha/core_pyxis.h	Sat Dec  9 09:17:43 2000
@@ -437,11 +437,13 @@
 __EXTERN_INLINE void pyxis_bw_writel(unsigned int b, unsigned long addr)
 {
 	*(vuip)(addr+PYXIS_BW_MEM) = b;
+	mb();
 }
 
 __EXTERN_INLINE void pyxis_bw_writeq(unsigned long b, unsigned long addr)
 {
 	*(vulp)(addr+PYXIS_BW_MEM) = b;
+	mb();
 }
 
 __EXTERN_INLINE unsigned long pyxis_srm_base(unsigned long addr)
@@ -504,6 +506,7 @@
 	if (work) {
 		work += 0x00;	/* add transfer length */
 		*(vuip) work = b * 0x01010101;
+		mb();
 	}
 }
 
@@ -513,6 +516,7 @@
 	if (work) {
 		work += 0x08;	/* add transfer length */
 		*(vuip) work = b * 0x00010001;
+		mb();
 	}
 }
 
@@ -551,6 +555,7 @@
 	set_hae(msb);
 
 	*(vuip) ((addr << 5) + PYXIS_SPARSE_MEM + 0x00) = b * 0x01010101;
+	mb();
 }
 
 __EXTERN_INLINE void pyxis_writew(unsigned short b, unsigned long addr)
@@ -562,6 +567,7 @@
 	set_hae(msb);
 
 	*(vuip) ((addr << 5) + PYXIS_SPARSE_MEM + 0x08) = b * 0x00010001;
+	mb();
 }
 
 __EXTERN_INLINE unsigned long pyxis_readl(unsigned long addr)
@@ -577,11 +583,13 @@
 __EXTERN_INLINE void pyxis_writel(unsigned int b, unsigned long addr)
 {
 	*(vuip) (addr + PYXIS_DENSE_MEM) = b;
+	mb();
 }
 
 __EXTERN_INLINE void pyxis_writeq(unsigned long b, unsigned long addr)
 {
 	*(vulp) (addr + PYXIS_DENSE_MEM) = b;
+	mb();
 }
 
 /* Find the DENSE memory area for a given bus address.  */
--- linux-2.2/include/asm-alpha/core_apecs.h.~1~	Mon Dec 28 00:21:50 1998
+++ linux-2.2/include/asm-alpha/core_apecs.h	Sat Dec  9 09:28:16 2000
@@ -543,6 +543,7 @@
 		set_hae(msb);
 	}
 	*(vuip) ((addr << 5) + APECS_SPARSE_MEM + 0x00) = b * 0x01010101;
+	mb();
 }
 
 __EXTERN_INLINE void apecs_writew(unsigned short b, unsigned long addr)
@@ -555,16 +556,19 @@
 		set_hae(msb);
 	}
 	*(vuip) ((addr << 5) + APECS_SPARSE_MEM + 0x08) = b * 0x00010001;
+	mb();
 }
 
 __EXTERN_INLINE void apecs_writel(unsigned int b, unsigned long addr)
 {
 	*(vuip) (addr + APECS_DENSE_MEM) = b;
+	mb();
 }
 
 __EXTERN_INLINE void apecs_writeq(unsigned long b, unsigned long addr)
 {
 	*(vulp) (addr + APECS_DENSE_MEM) = b;
+	mb();
 }
 
 /* Find the DENSE memory area for a given bus address.  */
--- linux-2.2/include/asm-alpha/core_cia.h.~1~	Thu Aug 26 02:29:49 1999
+++ linux-2.2/include/asm-alpha/core_cia.h	Sat Dec  9 09:28:16 2000
@@ -460,6 +460,7 @@
 		work += 0x00;	/* add transfer length */
 		w = __kernel_insbl(b, addr & 3);
 		*(vuip) work = w;
+		mb();
 	}
 }
 
@@ -470,6 +471,7 @@
 		work += 0x08;	/* add transfer length */
 		w = __kernel_inswl(b, addr & 3);
 		*(vuip) work = w;
+		mb();
 	}
 }
 
@@ -507,6 +509,7 @@
 
 	w = __kernel_insbl(b, addr & 3);
 	*(vuip) ((addr << 5) + CIA_SPARSE_MEM + 0x00) = w;
+	mb();
 }
 
 __EXTERN_INLINE void cia_writew(unsigned short b, unsigned long addr)
@@ -519,6 +522,7 @@
 
 	w = __kernel_inswl(b, addr & 3);
 	*(vuip) ((addr << 5) + CIA_SPARSE_MEM + 0x08) = w;
+	mb();
 }
 
 __EXTERN_INLINE unsigned long cia_readl(unsigned long addr)
@@ -534,11 +538,13 @@
 __EXTERN_INLINE void cia_writel(unsigned int b, unsigned long addr)
 {
 	*(vuip) (addr + CIA_DENSE_MEM) = b;
+	mb();
 }
 
 __EXTERN_INLINE void cia_writeq(unsigned long b, unsigned long addr)
 {
 	*(vulp) (addr + CIA_DENSE_MEM) = b;
+	mb();
 }
 
 /* Find the DENSE memory area for a given bus address.  */
--- linux-2.2/include/asm-alpha/core_t2.h.~1~	Mon Dec 28 00:21:50 1998
+++ linux-2.2/include/asm-alpha/core_t2.h	Sat Dec  9 09:28:16 2000
@@ -499,6 +499,7 @@
 	if (work) {
 		work += 0x00;	/* add transfer length */
 		*(vuip) work = b * 0x01010101;
+		mb();
 	}
 }
 
@@ -508,6 +509,7 @@
 	if (work) {
 		work += 0x08;	/* add transfer length */
 		*(vuip) work = b * 0x00010001;
+		mb();
 	}
 }
 
@@ -518,6 +520,7 @@
 	if (work) {
 		work += 0x18;	/* add transfer length */
 		*(vuip) work = b;
+		mb();
 	}
 }
 
@@ -530,6 +533,7 @@
 		work += 0x18;	/* add transfer length */
 		*(vuip) work = b;
 		*(vuip) (work + (4 << 5)) = b >> 32;
+		mb();
 	}
 }
 
@@ -592,6 +596,7 @@
 	set_hae(msb);
 
 	*(vuip) ((addr << 5) + T2_SPARSE_MEM + 0x00) = b * 0x01010101;
+	mb();
 }
 
 __EXTERN_INLINE void t2_writew(unsigned short b, unsigned long addr)
@@ -603,6 +608,7 @@
 	set_hae(msb);
 
 	*(vuip) ((addr << 5) + T2_SPARSE_MEM + 0x08) = b * 0x00010001;
+	mb();
 }
 
 /* On SABLE with T2, we must use SPARSE memory even for 32-bit access. */
@@ -615,6 +621,7 @@
 	set_hae(msb);
 
 	*(vuip) ((addr << 5) + T2_SPARSE_MEM + 0x18) = b;
+	mb();
 }
 
 __EXTERN_INLINE void t2_writeq(unsigned long b, unsigned long addr)
@@ -628,6 +635,7 @@
 	work = (addr << 5) + T2_SPARSE_MEM + 0x18;
 	*(vuip)work = b;
 	*(vuip)(work + (4 << 5)) = b >> 32;
+	mb();
 }
 
 /* Find the DENSE memory area for a given bus address.  */
--- linux-2.2/include/asm-alpha/core_lca.h.~1~	Mon Dec 28 00:21:50 1998
+++ linux-2.2/include/asm-alpha/core_lca.h	Sat Dec  9 09:28:16 2000
@@ -349,6 +349,7 @@
 	}
 	w = __kernel_insbl(b, addr & 3);
 	*(vuip) ((addr << 5) + LCA_SPARSE_MEM + 0x00) = w;
+	mb();
 }
 
 __EXTERN_INLINE void lca_writew(unsigned short b, unsigned long addr)
@@ -363,16 +364,19 @@
 	}
 	w = __kernel_inswl(b, addr & 3);
 	*(vuip) ((addr << 5) + LCA_SPARSE_MEM + 0x08) = w;
+	mb();
 }
 
 __EXTERN_INLINE void lca_writel(unsigned int b, unsigned long addr)
 {
 	*(vuip) (addr + LCA_DENSE_MEM) = b;
+	mb();
 }
 
 __EXTERN_INLINE void lca_writeq(unsigned long b, unsigned long addr)
 {
 	*(vulp) (addr + LCA_DENSE_MEM) = b;
+	mb();
 }
 
 /* Find the DENSE memory area for a given bus address.  */
--- linux-2.2/include/asm-alpha/core_mcpcia.h.~1~	Tue Jan  4 19:12:24 2000
+++ linux-2.2/include/asm-alpha/core_mcpcia.h	Sat Dec  9 09:28:16 2000
@@ -352,6 +352,7 @@
 	if (work) {
 		work += 0x00;	/* add transfer length */
 		*(vuip) work = b * 0x01010101;
+		mb();
 	}
 }
 
@@ -361,6 +362,7 @@
 	if (work) {
 		work += 0x08;	/* add transfer length */
 		*(vuip) work = b * 0x00010001;
+		mb();
 	}
 }
 
@@ -405,6 +407,7 @@
 	set_hae(msb);
 
 	*(vuip) ((addr << 5) + MCPCIA_SPARSE(hose) + 0x00) = b * 0x01010101;
+	mb();
 }
 
 __EXTERN_INLINE void mcpcia_writew(unsigned short b, unsigned long in_addr)
@@ -418,6 +421,7 @@
 	set_hae(msb);
 
 	*(vuip) ((addr << 5) + MCPCIA_SPARSE(hose) + 0x08) = b * 0x00010001;
+	mb();
 }
 
 __EXTERN_INLINE unsigned long mcpcia_readl(unsigned long in_addr)
@@ -439,6 +443,7 @@
 	unsigned long addr = in_addr & 0xffffffffUL;
 	unsigned long hose = (in_addr >> 32) & 3;
 	*(vuip) (addr + MCPCIA_DENSE(hose)) = b;
+	mb();
 }
 
 __EXTERN_INLINE void mcpcia_writeq(unsigned long b, unsigned long in_addr)
@@ -446,6 +451,7 @@
 	unsigned long addr = in_addr & 0xffffffffUL;
 	unsigned long hose = (in_addr >> 32) & 3;
 	*(vulp) (addr + MCPCIA_DENSE(hose)) = b;
+	mb();
 }
 
 /* Find the DENSE memory area for a given bus address.  */

--------------6A571FE22658A1610E0A8F45
Content-Type: text/plain; charset=us-ascii;
 name="alpha-mb-2.4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alpha-mb-2.4.diff"

--- linux/include/asm-alpha/core_t2.h.~1~	Fri Mar 17 22:01:38 2000
+++ linux/include/asm-alpha/core_t2.h	Sat Dec  9 09:07:35 2000
@@ -533,6 +533,21 @@
 #define __ioremap(a)		t2_ioremap((unsigned long)(a))
 #define __is_ioaddr(a)		t2_is_ioaddr((unsigned long)(a))
 
+#define inb(p)			__inb(p)
+#define inw(p)			__inw(p)
+#define inl(p)			__inl(p)
+#define outb(x,p)		__outb((x),(p))
+#define outw(x,p)		__outw((x),(p))
+#define outl(x,p)		__outl((x),(p))
+#define __raw_readb(a)		__readb(a)
+#define __raw_readw(a)		__readw(a)
+#define __raw_readl(a)		__readl(a)
+#define __raw_readq(a)		__readq(a)
+#define __raw_writeb(v,a)	__writeb((v),(a))
+#define __raw_writew(v,a)	__writew((v),(a))
+#define __raw_writel(v,a)	__writel((v),(a))
+#define __raw_writeq(v,a)	__writeq((v),(a))
+
 #endif /* __WANT_IO_DEF */
 
 #ifdef __IO_EXTERN_INLINE

--------------6A571FE22658A1610E0A8F45--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
