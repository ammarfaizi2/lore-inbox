Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267259AbUIOSB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267259AbUIOSB0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 14:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266878AbUIOSAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 14:00:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:15064 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267184AbUIOR5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:57:37 -0400
Date: Wed, 15 Sep 2004 10:57:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more anal about iospace accesses..
In-Reply-To: <20040915173236.GE6158@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.58.0409151045530.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org> <20040915165450.GD6158@wohnheim.fh-wedel.de>
 <Pine.LNX.4.58.0409151004370.2333@ppc970.osdl.org> <20040915173236.GE6158@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Sep 2004, Jörn Engel wrote:
> 
> But it still leaves me confused.  Before I had this code:
> 
> 	struct regs {
> 		uint32_t status;
> 		...
> 	}
> 
> 	...
> 
> 	struct regs *regs = ioremap(...);
> 	uint32_t status = regs->status;
> 	...
> 
> So now I should do it like this:
> 
> 	#define REG_STATUS 0
> 
> 	...
> 
> 	void __iomem *regs = ioremap(...);
> 	uint32_t status = readl(regs + REG_STATUS);

No, you can certainly continue to use non-void pointers. The "void __iomem
*" case is just the typeless one, exactly equivalent to regular void
pointer usage.

So let me clarify my original post with two points:

 - if your device only supports MMIO, you might as well just use the old 
   interfaces. The new interface will _also_ work, but there is no real 
   advantage, unless you count the "pci_iomap()" as a simpler interface.

   The new interface is really only meaningful for things that want to 
   support _both_ PIO and MMIO. It's also, perhaps, a bit syntactically 
   easier to work with, so some people might prefer that for that 
   reason. See my comments further down on the auto-sizing. BUT it doesn't 
   make the old interfaces go away by any means, and I'm not even
   suggesting that people should re-write drivers just for the hell of it.

   In short: if you don't go "ooh, that will simplify XXX", then you 
   should just ignore the new interfaces.

 - you can _absolutely_ use other pointers than "void *". You should 
   annotate them with "__iomem" if you want to be sparse-clean (and it 
   often helps visually to clarify the issue), but gcc won't care, the 
   "__iomem" annotation is purely a extended check.

So you can absolutely still continue with

	struct mydev_iolayout {
		__u32 status;
		__u32 irqmask;
		...

	struct mydev_iolayout __iomem *regs = pci_map(...);
	status = ioread32(&regs.status);

which is often a lot more readable, and thus in fact _preferred_. It also
adds another level of type-checking, so I applaud drivers that do this.

Now, I'm _contemplating_ also allowing the "get_user()" kind of "unsized" 
access function for the new interface. Right now all the old (and the new) 
access functions are all explicitly sized. But for the "struct layout" 
case, it's actually often nice to just say

	status = ioread(&regs.status);

and the compiler can certainly figure out the size of the register on its
own. This was impossible with the old interface, because the old 
interfaces didn't even take a _pointer_, much less one that could be sized 
up automatically.

(The auto-sizing is something that "get_user()" and "put_user()" have
always done, and it makes them very easy to use. It involved a few pretty
ugly macros, but hey, that's all hidden away, and is actually pretty
simple in the end).

		Linus
