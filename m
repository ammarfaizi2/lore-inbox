Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262542AbSJGSGG>; Mon, 7 Oct 2002 14:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262543AbSJGSGG>; Mon, 7 Oct 2002 14:06:06 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2432 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262542AbSJGSGE>; Mon, 7 Oct 2002 14:06:04 -0400
Date: Mon, 7 Oct 2002 14:11:22 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Nicolas Pitre <nico@cam.org>
cc: Mark Mielke <mark@mark.mielke.cc>, "David S. Miller" <davem@redhat.com>,
       Russell King <rmk@arm.linux.org.uk>, simon@baydel.com,
       alan@lxorguk.ukuu.org.uk, lkml <linux-kernel@vger.kernel.org>
Subject: Re: The end of embedded Linux?
In-Reply-To: <Pine.LNX.4.44.0210071307420.913-100000@xanadu.home>
Message-ID: <Pine.LNX.3.95.1021007135820.231A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2002, Nicolas Pitre wrote:

> On Mon, 7 Oct 2002, Mark Mielke wrote:
> 
> > On Mon, Oct 07, 2002 at 09:02:33AM -0700, David S. Miller wrote:
> > >    From: Nicolas Pitre <nico@cam.org>
> > >    Date: Mon, 7 Oct 2002 12:05:16 -0400 (EDT)
> > >    2) Not inlining inb() and friend reduce the bloat but then you further 
> > >       impact performances on CPUs which are generally many order of
> > >       magnitude slower than current desktop machines.
> > > I don't buy this one.  You are saying that the overhead of a procedure
> > > call is larger than the overhead of going out over the I/O bus to
> > > touch a device?
> > 
> > I think the key phrase is 'further impact'.
> > 
> > If anything, the procedure call increases latency.
> > 
> > Although... I don't see why CONFIG_TINY wouldn't be able to decide whether
> > inb() should be inlined or not...
> 
> Please don't mix up the issues.
> 
> The problems with inb() and friends as it stands in the embedded world right
> now as to do with code cleanness not kernel image bloat.  Nothing to be 
> solved with CONFIG_TINY.  Please let's keep those issues separate.
> 
> Here's the IO macro issue:  On some embedded platforms the IO bus is only 8
> bit wide or only 16 bit wide, or address lines are shifted so registers
> offsets are not the same, etc.  All this because embedded platforms are
> often using standard ISA peripheral chipsets since they can be easily glued
> to any kind of bare buses or static memory banks.
> 
> The nice thing here is the fact that only by modifying inb() and friends you
> can reuse most current kernel drivers without further modifications.  
> However the modifs to inb() are often different whether the peripheral in
> question is wired to a static memory bank, to the PCMCIA space or onto some
> expansion board via a CPLD or other weirdness some hardware designers are
> pleased to come with.  Hence no global inb() and friend tweaking is possible
> without some performance hit by using a runtime fixup based on the address
> passed to them.
> 
> We therefore end up with something that looks like this in each drivers for 
> which a fixup is needed:
> 
> #ifdef CONFIG_ASSABET_NEPONSET
> 
> /*
>  * These functions allow us to handle IO addressing as we wish - this
>  * ethernet controller can be connected to a variety of busses.  Some
>  * busses do not support 16 bit or 32 bit transfers.  --rmk
>  */
> static inline u8 smc_inb(u_int base, u_int reg)
> {
>         u_int port = base + reg * 4;
> 
>         return readb(port);
> }
> 
> static inline u16 smc_inw(u_int base, u_int reg)
> {
>         u_int port = base + reg * 4;
> 
>         return readb(port) | readb(port + 4) << 8;
> }
> 
> static inline void smc_outb(u8 val, u_int base, u_int reg)
> {
>         u_int port = base + reg * 4;
> 
>         writeb(val, port);
> }
> 
> static inline void smc_outw(u16 val, u_int base, u_int reg)
> {
>         u_int port = base + reg * 4;
> 
>         writeb(val, port);
>         writeb(val >> 8, port + 4);
> }
> 
> #endif
> 
> As you can see such code duplicated multiple times for all bus arrangements
> in existence out there is just not pretty and was refused by Alan.  We lack
> a global lightweight IO abstraction to nicely override the default IO macros
> for individual drivers at compile time to fix that problem optimally and
> keep the driver proper clean.
> 
> 
> Nicolas

If linux, with no modifications, can be booted on your hardware, then
you don't need any kernel modifications. You can do all your special
I/O through your own modules using whatever techniques you want since
your modules are for your system, therefore by definition, not portable.

This is the method we used here. Also, since any modules are designed
to interface with our proprietary hardware, any customer can get
the source-code because its pretty worthless without the proprietary
hardware. So, we don't have a problem with GPL or anything like that.
If you buy the box, you get anything you want without an NDA.

The only thing we keep under our belt is the BIOS that we wrote. Since
this effectively builds a pretty dumb hunk of coal into an AT Class
machine, we don't give that away as a freebee. We don't waste any
I/O space, the NVRAM used as the data-source of a virtual floppy drive
is accessed through a very small 0x1000 window. We use this window to
burn new PROMS and even to upgrade the BIOS. That virtual floppy
drive 'boots' Linux using LILO and friends.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

