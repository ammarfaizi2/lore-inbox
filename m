Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265012AbSKFMjG>; Wed, 6 Nov 2002 07:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265016AbSKFMjG>; Wed, 6 Nov 2002 07:39:06 -0500
Received: from chaos.analogic.com ([204.178.40.224]:641 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265012AbSKFMjD>; Wed, 6 Nov 2002 07:39:03 -0500
Date: Wed, 6 Nov 2002 07:47:01 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Willy Tarreau <willy@w.ods.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jim Paris <jim@jtan.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: time() glitch on 2.4.18: solved
In-Reply-To: <20021105231534.GA28279@alpha.home.local>
Message-ID: <Pine.LNX.3.95.1021106074128.3698A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2002, Willy Tarreau wrote:

> On Tue, Nov 05, 2002 at 03:38:00PM -0500, Richard B. Johnson wrote:
> > On Tue, 5 Nov 2002, Willy Tarreau wrote:
> > 
> > > On Tue, Nov 05, 2002 at 08:07:26PM +0000, Alan Cox wrote:
> > > > On Tue, 2002-11-05 at 19:29, Richard B. Johnson wrote:
> > > > > The only hardware a modern PC needs to use "slow-down_io" on is
> > > > > the RTC CMOS device. Since we need to support older boards, you
> > > > > don't want to remove the _p options indiscriminately, but you do
> > > > > not want them ever between two consecutive writes to the same device-
> > > > > port.
> > > > 
> > > > I own at least one that needs the _p on the DMA controller and at one
> > > > that needs _p on the PIT
> > > 
> > > Well, in fact, Intel's 82C54 datasheet says that this chip needs at least
> > > 165 ns between two consecutive operations, either read or write. So with a
> > > 8 Mhz bus, you may effectively need to insert fake accesses, although most
> > > modern chipsets certainly have better specs.
> > > 
> > 
> > Its not a clocked bus. The 8 MHz means nothing. It's an async bus
> > and if the setup timing of the data/address-decode/chip-select sequence
> > is not violated, you get ~200ns between accesses so chip-to-chip
> > select time comes automatically. But, some older motherboards violated
> > all kinds of specs. They did this deliberately so you could plug
> > RAM boards into the ISA bus and get reasonable performance. If we still
> > support them, you need some artifical waits.
> 
> Well, some older (386) motherboards had the 8254 directly connected to the ISA
> bus. And since Linux is 386-compatible, I think we should still support those
> boards.
> 
> > It's not the port address. It's the bus state. The chip requires two
> > consecutive writes when setting that latch. It's just like a 32-bit
> > write to a 32-bit port (like PCI access), you can't write to the
> > low-port, do something else, then write to the high port.
> 
> Yes you can ! the chip uses a CS (chip select) from an address decoder,
> and sees the reads/writes only when both CS and either RD or WR are low.
> I understand that all this circuitry may be simplified a bit in recent
> chipsets (one unified decoder, fewer glue logic between chips), but there's
> no reason that this should not be respected if the chip makers claim a bit
> of compatibility.
> 
> > It needs to be done with no intervening bus states. In the AMD case, it's
> > probably because the address is ignored on the second write.
> 
> Then it's buggy. This chip was originaly designed to work for 8086/80186,
> which barely means work when directly connected to an ISA bus. If AMD make
> their chip rely on PCI-like back-to-back behaviour, I don't agree for the
> compatibility.
> 
> Now, since there's at least one buggy implementation, the solution is udelay().
> But do you think that your chip may be confused by a memory access, when
> udelay() fetches the count variable from memory, for example ?
> 
> The last other solution may be to simply use jmp $+2, which will be slow
> enough on old sensible hardware, and imperceptible on more recent hardware
> which doesn't require this.
> 
> Since Alan and you have one piece of hardware which show opposite behaviour,
> we should get an ever working solution quickly :-)
> 

udelay() would work memory/read/write is entirely different from I/O
port read/write even though PWB traces are shared. But that might
result in wasted CPU cycles.

This works in all cases in machines I have tested. I can't test everything
but, depending upon whether or not the forces a cache-line refill, the
delay can be from 200 ns to over 800 ns. I have a single instance of this,
and call it, rather than doing in-line. This adds a further delay.

#
.section	.text
.global		cflush	
.type		cflush,@function

cflush: pushl	%cs		# Put code segment on the stack
	pushl	$goto		# Put offset on the stack
	lret			# Do a 'long' return (reloads cs)
goto:	ret
.end




Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


