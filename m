Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267519AbUIUJ0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267519AbUIUJ0W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 05:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267545AbUIUJ0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 05:26:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:61639 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267519AbUIUJ0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 05:26:18 -0400
Subject: [PATCH] ppc64: Fix __raw_* IO accessors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>
Content-Type: text/plain
Message-Id: <1095758630.3332.133.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 21 Sep 2004 19:23:50 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Linus, I don't know if you did that on purpose, but you removed the
"volatile" statement from the definition of the __raw_* IO accessors
on ppc64, which cause some real bad optisations to happen in some
fbdev's like matroxfb to happen (just imagine that matroxfb loops
reading an IO register waiting for a bit to change).

(Note: matroxfb has other potential problems due to the fact that
__raw_* do not do any barrier (Petr, we probably need to fix that
some way, unfortunatley, I don't think we have a good abstraction
for providing the missing barrier to a driver using __raw... can't
you just switch back to little endian registers and use normal
readX/writeX ?)

Anyway, here's the fix for asm-ppc64/io.h

Signed-off-by: Benjamin Herrenschmidt <benh@kenrel.crashing.org>

===== include/asm/io.h 1.21 vs edited =====
--- 1.21/include/asm-ppc64/io.h	2004-09-14 04:31:52 +10:00
+++ edited/include/asm/io.h	2004-09-21 19:14:10 +10:00
@@ -71,35 +71,35 @@
 
 static inline unsigned char __raw_readb(const volatile void __iomem *addr)
 {
-	return *(unsigned char __force *)addr;
+	return *(volatile unsigned char __force *)addr;
 }
 static inline unsigned short __raw_readw(const volatile void __iomem *addr)
 {
-	return *(unsigned short __force *)addr;
+	return *(volatile unsigned short __force *)addr;
 }
 static inline unsigned int __raw_readl(const volatile void __iomem *addr)
 {
-	return *(unsigned int __force *)addr;
+	return *(volatile unsigned int __force *)addr;
 }
 static inline unsigned long __raw_readq(const volatile void __iomem *addr)
 {
-	return *(unsigned long __force *)addr;
+	return *(volatile unsigned long __force *)addr;
 }
 static inline void __raw_writeb(unsigned char v, volatile void __iomem *addr)
 {
-	*(unsigned char __force *)addr = v;
+	*(volatile unsigned char __force *)addr = v;
 }
 static inline void __raw_writew(unsigned short v, volatile void __iomem *addr)
 {
-	*(unsigned short __force *)addr = v;
+	*(volatile unsigned short __force *)addr = v;
 }
 static inline void __raw_writel(unsigned int v, volatile void __iomem *addr)
 {
-	*(unsigned int __force *)addr = v;
+	*(volatile unsigned int __force *)addr = v;
 }
 static inline void __raw_writeq(unsigned long v, volatile void __iomem *addr)
 {
-	*(unsigned long __force *)addr = v;
+	*(volatile unsigned long __force *)addr = v;
 }
 #define readb(addr)		eeh_readb(addr)
 #define readw(addr)		eeh_readw(addr)



