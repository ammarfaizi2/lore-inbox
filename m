Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265891AbUFTRf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265891AbUFTRf5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 13:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265801AbUFTReD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 13:34:03 -0400
Received: from nl-ams-slo-l4-01-pip-6.chellonetwork.com ([213.46.243.23]:6976
	"EHLO amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S265891AbUFTR1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 13:27:05 -0400
Date: Sun, 20 Jun 2004 19:27:04 +0200
Message-Id: <200406201727.i5KHR4ap001564@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 459] M68k I/O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k I/O abstraction updates:
  - Make I/O ports and addresses `unsigned long'
  - Add casts to make operations warning-compatible with other archs
  - Add {in,out}[wl]_p() and {in,out}l(), which are needed for some drivers

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.7/include/asm-m68k/io.h	2004-05-24 11:13:53.000000000 +0200
+++ linux-m68k-2.6.7/include/asm-m68k/io.h	2004-04-12 13:56:00.000000000 +0200
@@ -120,7 +120,7 @@ extern int isa_sex;
  * be compiled in so the case statement will be optimised away
  */
 
-static inline u8 *isa_itb(long addr)
+static inline u8 *isa_itb(unsigned long addr)
 {
   switch(ISA_TYPE)
     {
@@ -136,7 +136,7 @@ static inline u8 *isa_itb(long addr)
     default: return 0; /* avoid warnings, just in case */
     }
 }
-static inline u16 *isa_itw(long addr)
+static inline u16 *isa_itw(unsigned long addr)
 {
   switch(ISA_TYPE)
     {
@@ -152,7 +152,7 @@ static inline u16 *isa_itw(long addr)
     default: return 0; /* avoid warnings, just in case */
     }
 }
-static inline u8 *isa_mtb(long addr)
+static inline u8 *isa_mtb(unsigned long addr)
 {
   switch(ISA_TYPE)
     {
@@ -168,7 +168,7 @@ static inline u8 *isa_mtb(long addr)
     default: return 0; /* avoid warnings, just in case */
     }
 }
-static inline u16 *isa_mtw(long addr)
+static inline u16 *isa_mtw(unsigned long addr)
 {
   switch(ISA_TYPE)
     {
@@ -191,10 +191,14 @@ static inline u16 *isa_mtw(long addr)
 #define isa_outb(val,port) out_8(isa_itb(port),(val))
 #define isa_outw(val,port) (ISA_SEX ? out_be16(isa_itw(port),(val)) : out_le16(isa_itw(port),(val)))
 
-#define isa_readb(p)       in_8(isa_mtb(p))
-#define isa_readw(p)       (ISA_SEX ? in_be16(isa_mtw(p)) : in_le16(isa_mtw(p)))
-#define isa_writeb(val,p)  out_8(isa_mtb(p),(val))
-#define isa_writew(val,p)  (ISA_SEX ? out_be16(isa_mtw(p),(val)) : out_le16(isa_mtw(p),(val)))
+#define isa_readb(p)       in_8(isa_mtb((unsigned long)(p)))
+#define isa_readw(p)       \
+	(ISA_SEX ? in_be16(isa_mtw((unsigned long)(p)))	\
+		 : in_le16(isa_mtw((unsigned long)(p))))
+#define isa_writeb(val,p)  out_8(isa_mtb((unsigned long)(p)),(val))
+#define isa_writew(val,p)  \
+	(ISA_SEX ? out_be16(isa_mtw((unsigned long)(p)),(val))	\
+		 : out_le16(isa_mtw((unsigned long)(p)),(val)))
 
 static inline void isa_delay(void)
 {
@@ -215,17 +219,21 @@ static inline void isa_delay(void)
 
 #define isa_inb_p(p)      ({u8 v=isa_inb(p);isa_delay();v;})
 #define isa_outb_p(v,p)   ({isa_outb((v),(p));isa_delay();})
+#define isa_inw_p(p)      ({u16 v=isa_inw(p);isa_delay();v;})
+#define isa_outw_p(v,p)   ({isa_outw((v),(p));isa_delay();})
+#define isa_inl_p(p)      ({u32 v=isa_inl(p);isa_delay();v;})
+#define isa_outl_p(v,p)   ({isa_outl((v),(p));isa_delay();})
 
-#define isa_insb(port, buf, nr) raw_insb(isa_itb(port), (buf), (nr))
-#define isa_outsb(port, buf, nr) raw_outsb(isa_itb(port), (buf), (nr))
+#define isa_insb(port, buf, nr) raw_insb(isa_itb(port), (u8 *)(buf), (nr))
+#define isa_outsb(port, buf, nr) raw_outsb(isa_itb(port), (u8 *)(buf), (nr))
 
 #define isa_insw(port, buf, nr)     \
-       (ISA_SEX ? raw_insw(isa_itw(port), (buf), (nr)) :    \
-                  raw_insw_swapw(isa_itw(port), (buf), (nr)))
+       (ISA_SEX ? raw_insw(isa_itw(port), (u16 *)(buf), (nr)) :    \
+                  raw_insw_swapw(isa_itw(port), (u16 *)(buf), (nr)))
 
 #define isa_outsw(port, buf, nr)    \
-       (ISA_SEX ? raw_outsw(isa_itw(port), (buf), (nr)) :  \
-                  raw_outsw_swapw(isa_itw(port), (buf), (nr)))
+       (ISA_SEX ? raw_outsw(isa_itw(port), (u16 *)(buf), (nr)) :  \
+                  raw_outsw_swapw(isa_itw(port), (u16 *)(buf), (nr)))
 #endif  /* CONFIG_ISA */
 
 
@@ -235,9 +243,13 @@ static inline void isa_delay(void)
 #define outb    isa_outb
 #define outb_p  isa_outb_p
 #define inw     isa_inw
+#define inw_p   isa_inw_p
 #define outw    isa_outw
+#define outw_p  isa_outw_p
 #define inl     isa_inw
+#define inl_p   isa_inw_p
 #define outl    isa_outw
+#define outl_p  isa_outw_p
 #define insb    isa_insb
 #define insw    isa_insw
 #define outsb   isa_outsb
@@ -281,10 +293,16 @@ static inline void isa_delay(void)
 #define inb(port) ((port)<1024 ? isa_inb(port) : in_8(port))
 #define inb_p(port) ((port)<1024 ? isa_inb_p(port) : in_8(port))
 #define inw(port) ((port)<1024 ? isa_inw(port) : in_le16(port))
+#define inw_p(port) ((port)<1024 ? isa_inw_p(port) : in_le16(port))
+#define inl(port) ((port)<1024 ? isa_inl(port) : in_le32(port))
+#define inl_p(port) ((port)<1024 ? isa_inl_p(port) : in_le32(port))
 
 #define outb(val,port) ((port)<1024 ? isa_outb((val),(port)) : out_8((port),(val)))
 #define outb_p(val,port) ((port)<1024 ? isa_outb_p((val),(port)) : out_8((port),(val)))
 #define outw(val,port) ((port)<1024 ? isa_outw((val),(port)) : out_le16((port),(val)))
+#define outw_p(val,port) ((port)<1024 ? isa_outw_p((val),(port)) : out_le16((port),(val)))
+#define outl(val,port) ((port)<1024 ? isa_outl((val),(port)) : out_le32((port),(val)))
+#define outl_p(val,port) ((port)<1024 ? isa_outl_p((val),(port)) : out_le32((port),(val)))
 #endif
 #endif /* CONFIG_PCI */
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
