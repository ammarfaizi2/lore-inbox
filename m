Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287996AbSAMHJd>; Sun, 13 Jan 2002 02:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287997AbSAMHJX>; Sun, 13 Jan 2002 02:09:23 -0500
Received: from femail48.sdc1.sfba.home.com ([24.254.60.42]:21923 "EHLO
	femail48.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S287996AbSAMHJH>; Sun, 13 Jan 2002 02:09:07 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Roman Zippel <zippel@linux-m68k.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Sat, 12 Jan 2002 18:07:10 -0500
X-Mailer: KMail [version 1.3.1]
Cc: arjan@fenrus.demon.nl, linux-kernel@vger.kernel.org
In-Reply-To: <E16PTIR-0002sL-00@the-village.bc.nu> <3C40A255.EBE646@linux-m68k.org>
In-Reply-To: <3C40A255.EBE646@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020113070906.OUZZ28486.femail48.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 January 2002 03:53 pm, Roman Zippel wrote:
> Hi,
>
> Alan Cox wrote:
> > So with pre-empt this happens
> >
> >         driver magic
> >         disable_irq(dev->irq)
> > PRE-EMPT:
> >         [large periods of time running other code]
> > PRE-EMPT:
> >         We get back and we've missed 300 packets, the serial port sharing
> >         the IRQ has dropped our internet connection completely.
>
> But it shouldn't deadlock as Victor is suggesting.

Um, hang on...

Obvioiusly, Alan, you know more about the networking stack than I do. :)  But 
could you define "large periods of time running other code"?

The real performance KILLER is when your code gets swapped out, and that 
simply doesn't happen in-kernel.  Yes, the niced app may get swapped out, but 
the syscall it's making is pinned in ram and it will only block on disk 
access when it returns.  So we're talking what kind of delay here, one second?

As for scheduling, even a nice 19 task will still get SOME time, and we can 
find out exactly what the worst case is since we hand out time slices and we 
don't hand out more until EVERYBODY exhausts theirs, including seriously 
niced processes.  So this isn't exactly non-deterministic behavior, is it?  
There IS an upper bound here...

There ISN'T an upper bound on interrupts.  We've got some nasty interrupts in 
the system.  How long does the PCI bus get tied up with spinning video cards 
flooding the bus to make their benchmarks look 5% better?  How long of a 
latency spike did we (until recently) get switching between graphics and text 
consoles?  (I heard that got fixed, moved into a tasklet or some such.  
Haven't looked at it yet.)  Without Andre's IDE patches, how much latency can 
the disk insert at random?

Yes, it's possible than if you have a fork bomb trying to take down your 
system, and you're using an old 10baseT ethernet driver built with some 
serious assumptions about how the kernel works, that you could drop some 
packets.  But I find it interesting that make -j can be considered a fairly 
unrealistic test intentionally overloading the system, yet an example with 
150 active threads all eating CPU time is NOT considered an example of how 
your process's receive buffer could easily fill up and drop packets no matter 
HOW fast the interrupt is working since even 10baseT feeds you 1.1 megabytes 
per second and with a 1 second delay we might have to swap stuff out to make 
room for them if we don't read from the socket in that long...

One other fun little thing about the scheduler: a process that is submitting 
network packets probably isn't entirely CPU bound, is it?  It's doing I/O.  
So even if it's niced, if it's competing with totally CPU bound tasks isn't 
it likely to get promoted?  How real-world is your overload-induced failure 
case example?

As for dropping 300 packets killing your connection, are you saying 802.11 
cards can't have a static burst that blocks your connection for half a 
second?  I've had full second gaps in network traffic on my cable modem, all 
time time, and the current overload behavior of most routers is dropping lots 
and lots of packets on the floor.  (My in-house network is still using an 
ancient 10baseT half-duplex hub.  I'm lazy, and it's still way faster than my 
upstream connection to the internet.)  Datagram delivery is not guaranteed.  
It never has been.  Maybe it will be once ECN comes in, but that's not yet.

What's one of the other examples you were worried about, besides NE2K (which 
can't do 100baseT, even on PCI, and a 100baseT PCI card is now $9 new.  Just 
a data point.)

Rob

(P.S.  The only behavior difference between preempt and SMP, apart from 
contention for per-cpu data, is the potential insertion of latency spikes in 
kernel code, which interrupts do anyway.  You're saying it can matter when 
something disables an interrupt.  Robert Love suggested the macro that 
disables an interrupt can count as a preemption guard just like a spinlock.  
Is this NOT enough to fix the objection?)
