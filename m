Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266543AbUIUWHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266543AbUIUWHM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 18:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268084AbUIUWHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 18:07:12 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:13137 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266543AbUIUWG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 18:06:58 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>
X-Message-Flag: Warning: May contain useful information
References: <1095758630.3332.133.camel@gaston>
	<1095761113.30931.13.camel@localhost.localdomain>
	<1095766919.3577.138.camel@gaston> <523c1bpghm.fsf@topspin.com>
	<Pine.LNX.4.58.0409211237510.25656@ppc970.osdl.org>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 21 Sep 2004 15:05:36 -0700
In-Reply-To: <Pine.LNX.4.58.0409211237510.25656@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 21 Sep 2004 12:41:56 -0700 (PDT)")
Message-ID: <52mzzjnuq7.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH] ppc64: Fix __raw_* IO accessors
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 21 Sep 2004 22:05:37.0655 (UTC) FILETIME=[20230070:01C4A027]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Linus> I don't think normal readb/writeb should know about EEH
    Linus> either. If you want error handling, there's a separate
    Linus> interface being worked on, so that normal accesses don't
    Linus> have to pay the cost..

I guess I wasn't totally clear.  In <asm-ppc64/io.h>, compare:

	static inline void __raw_writel(unsigned int v, volatile void __iomem *addr)
	{
		*(volatile unsigned int __force *)addr = v;
	}

to:

	#define writel(data, addr)	eeh_writel((data), (addr))

where eeh_writel() is:

	static inline void eeh_writel(u32 val, volatile void __iomem *addr) {
		volatile u32 *vaddr = (volatile u32 *)IO_TOKEN_TO_ADDR(addr);
		out_le32(vaddr, val);
	}

That means using __raw_writel() is pretty much guaranteed to blow up
on IBM pSeries (and I do care about pSeries for my driver).

Maybe something like the patch below would make sense?  (Reordering of
code is to make sure IO_TOKEN_TO_ADDR() is defined before the
__raw_*() functions; eeh.h has to be included after the in_*() and
out_*() functions are defined)

By the way, I notice that <asm-ppc64/eeh.h> has a bunch of eeh_raw_*
functions that appear to be completely unused.  I didn't use them in
my patch because they add memory ordering (isync or sync) that Alan
says __raw_* functions shouldn't have.

    Linus> Ok, so that _is_ insane. Mind telling what kind of insane
    Linus> hardware is BE in this day and age?

:) Mellanox InfiniBand HCAs....

Thanks,
 Roland


Use IO_TOKEN_TO_ADDR() in ppc64 __raw_*() functions, so that drivers
don't need to know about EEH for __raw_*() to work on pSeries.

Signed-off-by: Roland Dreier <roland@topspin.com>

Index: linux-bk/include/asm-ppc64/io.h
===================================================================
--- linux-bk.orig/include/asm-ppc64/io.h	2004-09-21 14:09:30.000000000 -0700
+++ linux-bk/include/asm-ppc64/io.h	2004-09-21 14:29:17.000000000 -0700
@@ -67,40 +67,8 @@
  */
 #define insw_ns(port, buf, ns)	_insw_ns((u16 *)((port)+pci_io_base), (buf), (ns))
 #define insl_ns(port, buf, nl)	_insl_ns((u32 *)((port)+pci_io_base), (buf), (nl))
-#else
+#else /* CONFIG_PPC_ISERIES */
 
-static inline unsigned char __raw_readb(const volatile void __iomem *addr)
-{
-	return *(volatile unsigned char __force *)addr;
-}
-static inline unsigned short __raw_readw(const volatile void __iomem *addr)
-{
-	return *(volatile unsigned short __force *)addr;
-}
-static inline unsigned int __raw_readl(const volatile void __iomem *addr)
-{
-	return *(volatile unsigned int __force *)addr;
-}
-static inline unsigned long __raw_readq(const volatile void __iomem *addr)
-{
-	return *(volatile unsigned long __force *)addr;
-}
-static inline void __raw_writeb(unsigned char v, volatile void __iomem *addr)
-{
-	*(volatile unsigned char __force *)addr = v;
-}
-static inline void __raw_writew(unsigned short v, volatile void __iomem *addr)
-{
-	*(volatile unsigned short __force *)addr = v;
-}
-static inline void __raw_writel(unsigned int v, volatile void __iomem *addr)
-{
-	*(volatile unsigned int __force *)addr = v;
-}
-static inline void __raw_writeq(unsigned long v, volatile void __iomem *addr)
-{
-	*(volatile unsigned long __force *)addr = v;
-}
 #define readb(addr)		eeh_readb(addr)
 #define readw(addr)		eeh_readw(addr)
 #define readl(addr)		eeh_readl(addr)
@@ -134,7 +102,7 @@
 #define outsw(port, buf, ns)  _outsw_ns((u16 *)((port)+pci_io_base), (buf), (ns))
 #define outsl(port, buf, nl)  _outsl_ns((u32 *)((port)+pci_io_base), (buf), (nl))
 
-#endif
+#endif /* CONFIG_PPC_ISERIES */
 
 #define readb_relaxed(addr) readb(addr)
 #define readw_relaxed(addr) readw(addr)
@@ -390,9 +358,42 @@
 	__asm__ __volatile__("std%U0%X0 %1,%0; sync" : "=m" (*addr) : "r" (val));
 }
 
-#ifndef CONFIG_PPC_ISERIES 
+#ifndef CONFIG_PPC_ISERIES
 #include <asm/eeh.h>
-#endif
+
+static inline unsigned char __raw_readb(const volatile void __iomem *addr)
+{
+	return *(volatile unsigned char *) IO_TOKEN_TO_ADDR(addr);
+}
+static inline unsigned short __raw_readw(const volatile void __iomem *addr)
+{
+	return *(volatile unsigned short *) IO_TOKEN_TO_ADDR(addr);
+}
+static inline unsigned int __raw_readl(const volatile void __iomem *addr)
+{
+	return *(volatile unsigned int *) IO_TOKEN_TO_ADDR(addr);
+}
+static inline unsigned long __raw_readq(const volatile void __iomem *addr)
+{
+	return *(volatile unsigned long *) IO_TOKEN_TO_ADDR(addr);
+}
+static inline void __raw_writeb(unsigned char v, volatile void __iomem *addr)
+{
+	*(volatile unsigned char *) IO_TOKEN_TO_ADDR(addr) = v;
+}
+static inline void __raw_writew(unsigned short v, volatile void __iomem *addr)
+{
+	*(volatile unsigned short *) IO_TOKEN_TO_ADDR(addr) = v;
+}
+static inline void __raw_writel(unsigned int v, volatile void __iomem *addr)
+{
+	*(volatile unsigned int *) IO_TOKEN_TO_ADDR(addr) = v;
+}
+static inline void __raw_writeq(unsigned long v, volatile void __iomem *addr)
+{
+	*(volatile unsigned long *) IO_TOKEN_TO_ADDR(addr) = v;
+}
+#endif /* CONFIG_PPC_ISERIES */
 
 #ifdef __KERNEL__
 
