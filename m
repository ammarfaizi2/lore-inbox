Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131871AbRA3SPz>; Tue, 30 Jan 2001 13:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131832AbRA3SPp>; Tue, 30 Jan 2001 13:15:45 -0500
Received: from chaos.analogic.com ([204.178.40.224]:39296 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131811AbRA3SPj>; Tue, 30 Jan 2001 13:15:39 -0500
Date: Tue, 30 Jan 2001 13:10:28 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Mark H. Wood" <mwood@IUPUI.Edu>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux Post codes during runtime, possibly OT
In-Reply-To: <Pine.LNX.4.21.0101301241250.11300-100000@mhw.ULib.IUPUI.Edu>
Message-ID: <Pine.LNX.3.95.1010130125040.13137A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001, Mark H. Wood wrote:

> On Sat, 27 Jan 2001, Rogier Wolff wrote:
> [snip]
> > I may have missed too much of the discussion, but I thought that the
> > idea was that some people noted that their POST-code-cards don't
> > really work all that well when Linux is running because Linux keeps on
> > sending garbage to port 0x80. 
> > 
> > You seem to state that if you want POST codes, you should find a
> > different port, modify the code, test the hell out of it, and then
> > submit the patch.
> > 
> > That is NOT the right way to go about this: Port 0x80 is RESERVED for
> > POST usage, that's why it's always free. If people want to use it for
> > the original purpose then that is a pretty damn good reason to bump
> > the non-intended users of that port somewhere else. 
> > 
> > Now, we've found that small delays are reasonably well generated with
> > an "outb" to 0x80. So, indeed changing that to something else is going
> > to be tricky. 
> 
> So how bad would it be to give these people a place to leave the value
> that they want to have displayed, and have the delay code write *that*
> instead of garbage?
> 
You need to save eax on the stack, you need to load al from memory,
you need to write al to the port, then you need to restore eax from
the stack, i.e.,

	pushl	%eax
	movb	(where_they_put_it),%al
	outb	%al,$0x80
	popl	%eax

This looks trivial. However, what happens if the kernel data segment
hasn't been set (yet), etc. To make this 'universal' you have to make
sure that "where_they_put_it" is accessible from the current segment.
Therefore, you have to do:

	pushl	%ds
	pushl	%eax
	movl	$KERNEL_DS,%eax
	movl	%eax,%ds
	movb	(where_they_put_it),%al
	outb	%al,$0x80
	popl	%eax
	popl	%ds

This gets a bit long for something that is, now, only:

	outb	%al,$0x80

I proposed a simple change, just do:

	outb	%al,$0x19

... instead.

That port is a R/W DMA scratch register. It's an 8-bit R/W latch
that is not internally connected to any DMA operations. It was
initially designed as a place to store page-register information
because the PC/XT/AT DMA controller is a 16-bit part. Since the
page register value must be computed for every DMA operation, it
is/was never used.

Simple decisions that used to be handled as; "Yeh, lets try it..."
now seem to be gobble-de-gooked with proving everything to the
world.

Just try it. You'll like it.

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
