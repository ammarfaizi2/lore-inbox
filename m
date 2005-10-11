Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbVJKEYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbVJKEYQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 00:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbVJKEYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 00:24:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38362 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751286AbVJKEYP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 00:24:15 -0400
Date: Tue, 11 Oct 2005 05:24:12 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, tcallawa@redhat.com
Subject: Re: Linux v2.6.14-rc4
Message-ID: <20051011042412.GT7992@ftp.linux.org.uk>
References: <Pine.LNX.4.64.0510101824130.14597@g5.osdl.org> <20051011034127.GS7992@ftp.linux.org.uk> <20051010.205827.122179808.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010.205827.122179808.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 08:58:27PM -0700, David S. Miller wrote:
> From: Al Viro <viro@ftp.linux.org.uk>
> Date: Tue, 11 Oct 2005 04:41:27 +0100
> 
> > On Mon, Oct 10, 2005 at 06:31:12PM -0700, Linus Torvalds wrote:
> > > Tom 'spot' Callaway:
> > >       [SPARC32]: Enable generic IOMAP.
> > 
> > ... breaks non-PCI builds (aka the absolute majority of sparc32 boxen).
> > On sparc32 insl() et.al. are defined only if CONFIG_PCI is set.
> > 
> > Moreover, I really doubt that generic_iomap is the right thing to do
> > there - all these guys end up as memory dereferences anyway, so ioread...()
> > et.al. have no reason to care about the origin of iomem pointer they get.
> 
> Also, Tom never answered my query about the driver he stated
> this was needed for (sym53c8xx) which appears on no sparc32
> PCI box in the world :-)
> 
> I'll revert this for now, push that to Linus, and we can hash it out
> better in 2.6.15

For sparc32 ioread*/iowrite* are _trivial_.  Look, the only defining
properties are

* if p is ioremap(whatever, len), then for any q from p to p + len - 1
we have ioread8(q) == readb(q), etc.
* if p is ioport_map(whatever, len), then for any q from p to p + len - 1
we have ioread8(q) == inb(whatever + q - p), etc.

ioread8		readb			inb
iowrite8	writeb			outb
ioread16	readw			inw
iowrite16	writew			outw
ioread32	readl			inl
iowrite32	writel			outl
ioread.._rep	loop of raw_read...	ins...
iowrite.._rep	loop of raw_write...	outs...

And that's it.  On sparc32 we can just have ioport_map() cast to void __iomem *
and be done with that.  And have io...() do corresponding memory access;
the only thing to keep in mind is that _rep variants do native-endian
access.

lib/iomap.c versions assume that PIO space needs different low-level
primitives for access and can be shifted outside of iomem space.
There we have ioport_map() add offset to port number and io{read,write}...
check the address and either do iomem access or subtract that offset and
do PIO one.  Nothing of that kind makes sense on sparc32 - the only
use for similar mechanism would be to try and encode AST into pointer.
But we are mapping them all into kernel context anyway, so there's no
need to bother with that...
