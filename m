Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263616AbUC3LnC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 06:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263747AbUC3LnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 06:43:02 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:2991 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S263616AbUC3LmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 06:42:19 -0500
Date: Tue, 30 Mar 2004 13:40:54 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: Kars de Jong <jongk@linux-m68k.org>
Cc: Linux/m68k kernel mailing list <linux-m68k@lists.linux-m68k.org>,
       linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: Re: More fun with Gayle
Message-ID: <20040330114054.GA3545@linux-m68k.org>
References: <1080422949.4364.171.camel@kars.perseus.home> <20040329093725.GA1102@linux-m68k.org> <1080595277.4037.87.camel@kars.perseus.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1080595277.4037.87.camel@kars.perseus.home>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 11:21:17PM +0200, Kars de Jong wrote:
> On Mon, 2004-03-29 at 11:37, Richard Zidlicky wrote:
> > On Sat, Mar 27, 2004 at 10:29:09PM +0100, Kars de Jong wrote:

ugh, I am glad you stumbled over this bag of ****, time to take it
to lk I think..

> > > I got a chance to try out a 3Com 3C589 Etherlink III card, which didn't
> > > work. When debugging that I found out that apparently Gayle DOES need
> > > words and longwords to be byte-swapped! This card has 16 bit registers,
> > > so didn't work at all.
> > 
> > how did you swap the longwords? I assume the 2 16 bit words
> > byteswapped separately?
> 
> No, I think not. I just used in_le32().
> 
> I made a test program which did an inl() from the 3Com and ran it on
> m68k and x86:
> 
> On x86:
> inl 0x320=0x00006d50
> 
> On m68k:
> inl 0x320=0x506d0000

that means there is no problem with bus endianness here, your inl works
perfectly and the driver is simply not CPU byte order clean. There is no
way a 16 bit bus could swap a 32 bit word like that;)

The test is:

  char buf[4];
  
  *((unsigned long)(&data))=inl(0x320);
  for (i=0; i<4;i++)printk("%x",*(data+i));

If it displays the same result on all archs then your inl() is
correct - and that is your case.

But if you look at the dirvers/net/pcmcia/3c589_cs driver, there
are no measures to correct for CPU byte order (except in 1 or 2
lonely places..) but the #*@! driver expects inw/inl/outw/outl will
magically fix CPU byte order for it !

This is wrong and explains much of your trouble.


BUS and CPU byte order are different things and mixing them will result
in disaster.

With bus access functions like inw/inl/insw/insl you access opaque
unstructured data. The data may in some cases have a valid interpretation
as a word or long but it can be 4 bytes of an chacracter string or some
bitfield just as well. <asm/io.h> knows nothing about this and must
only fix BUS byte order.
The driver knows the difference and only the driver must fix CPU byte
order issues.

So drivers/net/pcmcia/3c589_cs.c is completely broken wrt CPU
endianness and some folks on other archs tried to compensate
for this by breaking their asm/io.h. That also explains the
kludges like __raw_readw and such crap that should never appear
in a wannabe portable driver.

> > > The reason NE2000 clones and UART cards did work is probably that their
> > > registers are 8 bit (except for the NE2000 data register but since that
> > > is only read/written with insw()/outsw() it didn't matter. I was a bit
> > > surprised by that but I found the reason for that in
> > > include/asm-ppc/io.h:
> > > 
> > > /*
> > >  * The insw/outsw/insl/outsl macros don't do byte-swapping.
> > >  * They are only used in practice for transferring buffers which
> > >  * are arrays of bytes, and byte-swapping is not appropriate in
> > >  * that case.  - paulus
> > >  */

nonsense. If the BUS is byteswapped you *must* swap, otherwise leave
it alone. <asm/io.h> macros *must not* fix CPU byte order, they
*must* fix BUS byte order.

> > You get the bytes in wrong order, it doesnt matter if the buffer
> > is array of bytes.. what else should it be? Someone confused bus
> > and cpu byte order I would think.
> 
> I'm not entirely sure, but this issue came up in the past on the PPC
> mailing list, see the following thread for instance:
> 
> http://lists.linuxppc.org/linuxppc-dev/200002/msg00352.html
> http://lists.linuxppc.org/linuxppc-dev/200002/msg00356.html

Well that was back in 2000 and we should be smarter by now?
There is of course the ugly problem with DMA and inw/inl consistency
though this is no justification to break inw/inl and must be fixed
somewhere else.

Problem is - how to fix it some years and many kludges later? The
damage appears pretty widespread in the PCMCIA subsystem and it makes
it impossible to use same asm/io.h definitions with correct drivers
(like drivers/net/ne.c) at the same time.

So either define and use <asm/broken_pcmcia_io.h> or fix all pcmcia
drivers.

> > There are rare cases where you don't care about bus byte order but
> > it may bite you later - it did bite the Q40 and Atari with IDE.
> 
> But on the Q40 and the Atari the data is now swapped twice sometimes...
> 
> So is the IDE interface on the Q40 special, and the ISA bus "normal"?

they are both the same. However, in asm/ide.h we dismiss the io.h
definitions of in*w/out*w and define our own not doing any swaps.
The address translation is done at init time in ide/*/q40ide.c.
While the address translation works, the missing bswap is an ugly
problem. If I take a disk from my Q40 and attach it on an Amiga
or PC I would have to bswap it to get meaningfull data. Worse, all
advanced ATA functionality like taskfiles is expected to break
horribly.
Well that problem is long known and I am working on a solution..

> It would be fun if you could test a 16-bit ISA board, like an NE2000
> clone or something on the Q40. Does it work?

it works perfectly since ages and before that it worked the same way
on Arno Griffioen's GG2 NE2K.

Richard
