Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135272AbRAZQEi>; Fri, 26 Jan 2001 11:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135373AbRAZQE1>; Fri, 26 Jan 2001 11:04:27 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8064 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S135268AbRAZQEO>; Fri, 26 Jan 2001 11:04:14 -0500
Date: Fri, 26 Jan 2001 11:03:22 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux Post codes during runtime, possibly OT
In-Reply-To: <20010126163103.F7096@pcep-jamie.cern.ch>
Message-ID: <Pine.LNX.3.95.1010126104710.1321A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jan 2001, Jamie Lokier wrote:

> Mark Hahn wrote:
> > >  #ifdef SLOW_IO_BY_JUMPING
> > >  #define __SLOW_DOWN_IO "\njmp 1f\n1:\tjmp 1f\n1:"
> > >  #else
> > > -#define __SLOW_DOWN_IO "\noutb %%al,$0x80"
> > > +#define __SLOW_DOWN_IO "\noutb %%al,$0x19"
> > 
> > this is nutty: why can't udelay be used here?  empirical measurements
> > in the thread show the delay is O(2us).

NOT!  It takes almost exactly 300 ns to do port I/O on the motherboards
that actually do port I/O.

Slowing down I/O is absolutely necessary any time you set an index
register or a page register. For instance, to access the CMOS chip,
you write an index value out port 0x70, then you read or write from
port 0x71. Modern CPUs can execute instructions MUCH faster than
the port index can be switched. If you don't force the CPU to wait
until the hardware has actually switched the port offset, then
you read/write to/from the wrong location.

The same thing occurs with DMA page registers, i.e., 64 k chunks
of addresses. If takes time for hardware to switch in a new page --
a LOT more time than it takes to read/write RAM. If you don't wait,
you read/write to the wrong place.

The delay must be sufficient for the hardware to have accomplished
the switch. That's why writing to a hardware port is ideal. If you
have fast hardware, the delay is low. If you have slow hardware, the
delay is longer.

I'm not going to debate this. If you understand hardware there
is nothing to debate.

> 
> udelay() makes sense.  Modern drivers use small udelays themselves to
> confirm to chip specs.
> 

udelay() on a 33 MHz '486 makes no sense at all. The delay is always
much longer than the input value unless the input value exceeds 100.



Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
