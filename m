Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265116AbSKETXO>; Tue, 5 Nov 2002 14:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265132AbSKETXO>; Tue, 5 Nov 2002 14:23:14 -0500
Received: from chaos.analogic.com ([204.178.40.224]:7296 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265116AbSKETXN>; Tue, 5 Nov 2002 14:23:13 -0500
Date: Tue, 5 Nov 2002 14:29:51 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Willy Tarreau <willy@w.ods.org>
cc: Jim Paris <jim@jtan.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: time() glitch on 2.4.18: solved
In-Reply-To: <20021105190854.GA25877@alpha.home.local>
Message-ID: <Pine.LNX.3.95.1021105141917.604A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2002, Willy Tarreau wrote:

> On Tue, Nov 05, 2002 at 01:57:16PM -0500, Richard B. Johnson wrote:
> 
> > No! You will break many machines. You cannot use out_p() when
> > writing the latch it __must__ be out(). the "_p" puts a write
> > to another port between the two writes. That will screw up
> > the internal state-machine of most PITs including AMD-SC520.
>  
> You make an interesting point. Have you checked if an inb_p() on this hardware
> could unlock the latch when reading the first byte ? It may also be one cause
> of time jumps if the counter is just about to wrap when it's being read, and
> gets unlocked by an out to port 0x80 (the "_p").
> 
> >  		count = inb_p(0x40);    /* read the latched count */
> >  		count |= inb(0x40) << 8;
> 
> Or perhaps it will be time to change port 0x80 to something else, that no
> chipset will use. I've seen 0xED in a bios somewhere, but I don't remember
> where.
> 
> Cheers,
> Willy
> 

It may well be that the inb_p() also causes the same problem. You
don't want any port read/write between those required consecutive
reads or writes. You just don't want to use the _p option there --ever.

The _p option is not a panacea that one uses to make sure that the
port read/writes go okay. It's also not a "bus settle time" as IBM
said in their BIOS. It is to give the internal state-machine of
some devices enough time to set up. For instance, the CMOS clock
runs with low-power CMOS. Its internal state-machine is low-power.
It does not run as fast as an external bus can run. Therefore, when
you set the next address to be read or written, with an out to the
port at 0x70, you need to wait for the internal low-power CMOS state
machine to actually latch the internal address. Then you can read
or write from 0x71.

There are only a few devices that require the _p. They are not the
PIT, any UARTS, or the DMA controller. Sometimes you need to play
nurse-maid to the FDC, but modern ones in super-IO chips are fine.
The only hardware a modern PC needs to use "slow-down_io" on is
the RTC CMOS device. Since we need to support older boards, you
don't want to remove the _p options indiscriminately, but you do
not want them ever between two consecutive writes to the same device-
port.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


