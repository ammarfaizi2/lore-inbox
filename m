Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263133AbSJGQBj>; Mon, 7 Oct 2002 12:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263134AbSJGQBj>; Mon, 7 Oct 2002 12:01:39 -0400
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:21635
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S263133AbSJGQBh>; Mon, 7 Oct 2002 12:01:37 -0400
Date: Mon, 7 Oct 2002 12:05:16 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Russell King <rmk@arm.linux.org.uk>
cc: "David S. Miller" <davem@redhat.com>, <simon@baydel.com>,
       <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: The end of embedded Linux?
In-Reply-To: <20021007125755.A5381@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0210071148450.913-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2002, Russell King wrote:

> On Mon, Oct 07, 2002 at 03:36:44AM -0700, David S. Miller wrote:
> >    No one else can run these drivers so 
> >    how could I expect someone else to maintain them ?
> > 
> > This is a common misconception.
> 
> Double that.  There are lots of drivers for embedded ARM stuff that
> should probably be in the tree, but because they typically add
> architecture specific crap to drivers to modify the IO support
> the weird and wonderful way the hardware designer has come up with
> to connect the device.  Examples of this are cs89x0.c and smc9192.c.
> 
> I've tried to coerce people in Alans suggested direction (hiding
> the architecture specific stuff behind inb and friends) but That
> Doesn't Work because embedded people will not do this.

And embedded people won't do that for many reasons:

1) It's unwise to bloat every use of inb() and friends through out the 
   kernel just because a single driver needs a special fixup.

2) Not inlining inb() and friend reduce the bloat but then you further 
   impact performances on CPUs which are generally many order of magnitude 
   slower than current desktop machines.

3) Getting the best code efficiency out of inb() and friends is therefore 
   premordial on those platforms which are sensitive to code performance to 
   achieve maximum bandwidth and power efficiency.  Remember that most of 
   embedded platforms where the SMC91C96 is used to pick up that example 
   aren't able to accomodate any form of DMA à la PCI most of the time.

So even with the current situation where inb() and friends are tweaked 
directly in each individual drivers I often see over 50% CPU usage in kernel 
space just by copying files over NFS.  Going with Alan's suggestion as you 
mentioned many times on linux-arm-kernel is just not acceptable.

There really should be a way to abstract things so the proper fixup is done
once at compilation time rather than across the board for every inb() access
at run time.

I'm sure those who take care of abstracting the code for SMP capabilities so 
it nicely becomes a no op on UP at compilation time understand this issue 
pretty well.  This should be the same for IO macros with embedded systems.


Nicolas

