Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWKEFBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWKEFBg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 00:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbWKEFBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 00:01:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30373 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030210AbWKEFBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 00:01:35 -0500
Date: Sat, 4 Nov 2006 21:00:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: lib/iomap.c mmio_{in,out}s* vs. __raw_* accessors
In-Reply-To: <1162701537.28571.156.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0611042054210.25218@g5.osdl.org>
References: <1162626761.28571.14.camel@localhost.localdomain> 
 <20061104140559.GC19760@flint.arm.linux.org.uk>  <1162678639.28571.63.camel@localhost.localdomain>
  <Pine.LNX.4.64.0611041544030.25218@g5.osdl.org> 
 <1162689005.28571.118.camel@localhost.localdomain> 
 <1162697533.28571.131.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0611041946020.25218@g5.osdl.org>  <1162699255.28571.150.camel@localhost.localdomain>
  <Pine.LNX.4.64.0611042013400.25218@g5.osdl.org> <1162701537.28571.156.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Nov 2006, Benjamin Herrenschmidt wrote:
> 
> I'm not doing a swab(readl()), I'm doing a swab(insl()) and have the
> arch provide a native BE accessor for readl_be().

Ok.

Can you work based on something like this instead?

(Totally untested, I just did this as an example of what I think is a lot 
more maintainable)

Basically, it allow you to replace _all_ of the individual small thing, 
and doesn't require any architecture that doesn't need to, to do anything 
new at all. I find it very irritating to have architectures that don't 
actually need any new stuff to have to define new accessor functions, and 
I also find it silly to have to have magic new #define's to show that you 
have some other functions.

This just basically says:

	If something isn't #define'd by the architecture, we'll fall back 
	to using our own defaults.

which is nice, in that you don't have to have any definitions, and if you 
_do_ have definitions, it's only for the functions that you actually 
define, ie there is no new magic ARCH_HAS_xyzzy to keep track of.

So if you can do (for example) a "pio_read16be()" in the architecture some 
sane way, just do it, either directly as a #define, or as an inline 
function that you then tell the rest of the system is there by just doing

	#define pio_read16be pio_read16be

and you're all done. In other words, you can have fine granularity of what 
the architecture supports, _without_ having to have tons of illogical and 
hard-to-track ARCH_HAS_xyzzy things. You define exactly what you have. 

This does assume that if you have the "16be" functions, you'll also have 
the 32be versions, of course - there's "fine granularity" and then there's 
"insanity", and this goes for the non-insane granularity ;)

Anyway, I'll just blow away this example from my tree, I generated it just 
for discussion, and as an example of what I think is much easier to 
maintain. It's also an example of something I'll happily apply if it comes 
back with a "yeah, that works for me, and I tested it"

		Linus

---
diff --git a/lib/iomap.c b/lib/iomap.c
index 55689c5..d6ccdd8 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -50,6 +50,16 @@
 	}							\
 } while (0)
 
+#ifndef pio_read16be
+#define pio_read16be(port) swab16(inw(port))
+#define pio_read32be(port) swab32(inl(port))
+#endif
+
+#ifndef mmio_read16be
+#define mmio_read16be(addr) be16_to_cpu(__raw_readw(addr))
+#define mmio_read32be(addr) be32_to_cpu(__raw_readl(addr))
+#endif
+
 unsigned int fastcall ioread8(void __iomem *addr)
 {
 	IO_COND(addr, return inb(port), return readb(addr));
@@ -60,7 +70,7 @@ unsigned int fastcall ioread16(void __io
 }
 unsigned int fastcall ioread16be(void __iomem *addr)
 {
-	IO_COND(addr, return inw(port), return be16_to_cpu(__raw_readw(addr)));
+	IO_COND(addr, return pio_read16be(port), return mmio_read16be(addr));
 }
 unsigned int fastcall ioread32(void __iomem *addr)
 {
@@ -68,7 +78,7 @@ unsigned int fastcall ioread32(void __io
 }
 unsigned int fastcall ioread32be(void __iomem *addr)
 {
-	IO_COND(addr, return inl(port), return be32_to_cpu(__raw_readl(addr)));
+	IO_COND(addr, return pio_read32be(port), return mmio_read32be(addr));
 }
 EXPORT_SYMBOL(ioread8);
 EXPORT_SYMBOL(ioread16);
@@ -76,6 +86,16 @@ EXPORT_SYMBOL(ioread16be);
 EXPORT_SYMBOL(ioread32);
 EXPORT_SYMBOL(ioread32be);
 
+#ifndef pio_write16be
+#define pio_write16be(val,port) outw(swab16(val),port)
+#define pio_write32be(val,port) outl(swab32(val),port)
+#endif
+
+#ifndef mmio_write16be
+#define mmio_write16be(val,port) __raw_writew(be16_to_cpu(val),port)
+#define mmio_write32be(val,port) __raw_writel(be32_to_cpu(val),port)
+#endif
+
 void fastcall iowrite8(u8 val, void __iomem *addr)
 {
 	IO_COND(addr, outb(val,port), writeb(val, addr));
@@ -86,7 +106,7 @@ void fastcall iowrite16(u16 val, void __
 }
 void fastcall iowrite16be(u16 val, void __iomem *addr)
 {
-	IO_COND(addr, outw(val,port), __raw_writew(cpu_to_be16(val), addr));
+	IO_COND(addr, pio_write16be(val,port), mmio_write16be(val, addr));
 }
 void fastcall iowrite32(u32 val, void __iomem *addr)
 {
@@ -94,7 +114,7 @@ void fastcall iowrite32(u32 val, void __
 }
 void fastcall iowrite32be(u32 val, void __iomem *addr)
 {
-	IO_COND(addr, outl(val,port), __raw_writel(cpu_to_be32(val), addr));
+	IO_COND(addr, pio_write32be(val,port), mmio_write32be(val, addr));
 }
 EXPORT_SYMBOL(iowrite8);
 EXPORT_SYMBOL(iowrite16);
@@ -108,6 +128,7 @@ EXPORT_SYMBOL(iowrite32be);
  * convert to CPU byte order. We write in "IO byte
  * order" (we also don't have IO barriers).
  */
+#ifndef mmio_insb
 static inline void mmio_insb(void __iomem *addr, u8 *dst, int count)
 {
 	while (--count >= 0) {
@@ -132,7 +153,9 @@ static inline void mmio_insl(void __iome
 		dst++;
 	}
 }
+#endif
 
+#ifndef mmio_outsb
 static inline void mmio_outsb(void __iomem *addr, const u8 *src, int count)
 {
 	while (--count >= 0) {
@@ -154,6 +177,7 @@ static inline void mmio_outsl(void __iom
 		src++;
 	}
 }
+#endif
 
 void fastcall ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
 {
