Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbUKHWIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbUKHWIQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 17:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbUKHWIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 17:08:15 -0500
Received: from smtp-out.hotpop.com ([38.113.3.71]:35511 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261264AbUKHWIM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 17:08:12 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
Date: Tue, 9 Nov 2004 06:08:02 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Guido Guenther <agx@sigxcpu.org>
References: <200411080521.iA85LbG6025914@hera.kernel.org> <200411090402.22696.adaplas@hotpop.com> <Pine.LNX.4.58.0411081211270.2301@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411081211270.2301@ppc970.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411090608.02759.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 November 2004 04:13, Linus Torvalds wrote:
> On Tue, 9 Nov 2004, Antonino A. Daplas wrote:
> > In big endian machines, the read*/write* accessors do a byteswap for an
> > inherently little endian PCI bus.  However, rivafb puts the hardwire in
> > big endian register access, thus the byteswap is not needed. So, instead
> > of read*/write*, use __raw_read*/__raw_write*.
>
> This fix should make the #ifdef CONFIG_PCC entirely superfluous afaik.

Ah, of course.

>
> The thing is, once riva does its HW accesses right, the special cases just
> go away. There's a reason we have abstractions..
>
> Does anybody have the hardware to test with?
>

I've asked Guido Guenther to test, might take a couple of days.  I also
asked him if he can use the in/out_be* which is probably safer for ppc.
And the mb()'s scattered all over the driver may be removed. 

Tony


In big endian machines, the read*/write* accessors do a byteswap for an
inherently little endian PCI bus.  However, rivafb puts the hardwire in big
endian register access, thus the byteswap is not needed. So for 16- and
32-bit access, instead of read*/write*, use __raw_read*/__raw_write* for all
archs.
 
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

diff -Nru a/drivers/video/riva/riva_hw.h b/drivers/video/riva/riva_hw.h
--- a/drivers/video/riva/riva_hw.h	2004-11-09 05:39:48 +08:00
+++ b/drivers/video/riva/riva_hw.h	2004-11-09 06:00:09 +08:00
@@ -73,18 +73,13 @@
 /*
  * HW access macros.
  */
-#if defined(__powerpc__)
 #include <asm/io.h>
-#define NV_WR08(p,i,d)	out_8(p+i, d)
-#define NV_RD08(p,i)	in_8(p+i)
-#else
 #define NV_WR08(p,i,d)  (writeb((d), (u8 __iomem *)(p) + (i)))
 #define NV_RD08(p,i)    (readb((u8 __iomem *)(p) + (i)))
-#endif
-#define NV_WR16(p,i,d)  (writew((d), (u16 __iomem *)(p) + (i)/2))
-#define NV_RD16(p,i)    (readw((u16 __iomem *)(p) + (i)/2))
-#define NV_WR32(p,i,d)  (writel((d), (u32 __iomem *)(p) + (i)/4))
-#define NV_RD32(p,i)    (readl((u32 __iomem *)(p) + (i)/4))
+#define NV_WR16(p,i,d)  (__raw_writew((d), (u16 __iomem *)(p) + (i)/2))
+#define NV_RD16(p,i)    (__raw_readw((u16 __iomem *)(p) + (i)/2))
+#define NV_WR32(p,i,d)  (__raw_writel((d), (u32 __iomem *)(p) + (i)/4))
+#define NV_RD32(p,i)    (__raw_readl((u32 __iomem *)(p) + (i)/4))
 #define VGA_WR08(p,i,d) NV_WR08(p,i,d)
 #define VGA_RD08(p,i)   NV_RD08(p,i)
 



