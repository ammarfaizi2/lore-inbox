Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289369AbSAVTyv>; Tue, 22 Jan 2002 14:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289378AbSAVTym>; Tue, 22 Jan 2002 14:54:42 -0500
Received: from femail36.sdc1.sfba.home.com ([24.254.60.26]:25262 "EHLO
	femail36.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S289369AbSAVTyi>; Tue, 22 Jan 2002 14:54:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Preempt & how long it takes to interrupt (was Re: [2.4.17/18pre] VM and swap - it's really unusable)
Date: Tue, 22 Jan 2002 06:52:29 -0500
X-Mailer: KMail [version 1.3.1]
Cc: pavel@suse.cz (Pavel Machek), helgehaf@aitel.hist.no (Helge Hafting),
        linux-kernel@vger.kernel.org
In-Reply-To: <E16SmJC-0000uP-00@the-village.bc.nu>
In-Reply-To: <E16SmJC-0000uP-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020122195437.LDTC21740.femail36.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 January 2002 04:48 pm, Alan Cox wrote:
> > I'm not entirely certain what Alan's smoking if he's raising the straw
> > man argument of a two second delay dropping 300 packets and causing
> > connections
>
> Go read my original mail about the NE2000 driver. If you are going to
> accuse me of smoking things

For which I apologize,

> you could at least read the posts you base it on

I did.

Okay, let's review:

> On Sat, 12 Jan 2002 18:54:27 +0000 (GMT), Alan Cox spaketh thusly:
> 
>Another example is in the network drivers. The 8390 core for one example
>carefully disables an IRQ on the card so that it can avoid spinlocking on 
>uniprocessor boxes.

Sounds like a bit of a kludge, but it's not my code.  However, without 
preempt aren't spinlocks basically NOPs on uniprocessor boxes?  What did I 
miss?

And wasn't there discussion of using IRQ disabling as a preempt barrier (at 
least until the syscall returns to userspace or finished a module unload 
call, clueing us in that it won't reenable it any time soon.)

>So with pre-empt this happens
>
>        driver magic
>        disable_irq(dev->irq)
>PRE-EMPT:
>        [large periods of time running other code]
>PRE-EMPT:
>        We get back and we've missed 300 packets, the serial port sharing
>        the IRQ has dropped our internet connection completely.

Okay, please point out where I missed a curve here:

An NE2K cannot go faster than 10baseT.  (Never designed to.  It's an old ISA 
standard dragged along to PCI largely because they had these chips lying 
around and nobody wanted to come up with a new interface anyway.  But it can 
only handle packets one at a time, as far as I know.  I've got several of 
these suckers lying around in various drawers, some of which are ISA.  I'm 
considering throwing them out since a new 100baseT card is $9 retail.  But I 
digress...).

With 10baseT you've got a theoretical maximum throughput of 1.25 (decimal) 
megabytes/second.  Assuming 1500 byte packet sizes at 10 megabits per second 
on a saturated link, we're talking 833 packets/second so a little over a 
third of a second is the shortest amount of time in which you can drop 300 
packets.

So in a worst case scenario latency spike introduced by an overloaded system 
running make -j where niced down CPU bound processes are doing network I/O 
through a driver that's not doing the right locking for preempt to know it 
shouldn't be interrupted...  Yeah, it could lose 300 packets.  Why this is a 
bad thing when we're designing gigabit ethernet systems with interrupt 
mitigation so they intentionally drop thousands of packets at a time rather 
than livelocking...  Open question.  TCP/IP is designed to retransmit around 
this sort of thing, and even with ECN it's not going to forget how. 

But that wasn't really the bad thing.  The bad thing was the incidentally 
misconfigured serial connection (sharing the network card's IRQ) hanging up.  
Serial maxes out at 115,200 which is 14400 bytes/sec (assuming perfect 8 bit 
encoding with no overhead), and losing 1/3 of that means 4800 bytes, which is 
indeed noticeably more than a 16550a UART's 16 byte buffer.  And SLIP and PPP 
also tend to have smaller MTU, (around 256 bytes for latency reasons), 
meaning the loss here could be a whole 18 packets.  (Assuming your 56k modem 
that can't actually quite do 56k isn't the real bottleneck, but we won't go 
there...)

And I agree that's not good for playing quake, but again: playing quake with 
"make -j" running in the background isn't going to give you the world's 
greatest frame rates anyway.  The 1/3 second latency spike was ENTIRELY due 
to the computer being loaded up with other things to do and not scheduling 
back to you before then.  If your game of quake is experiencing those kind of 
SCHEDULING latency spikes, it's unplayable anyway.

As for hanging up, I've used slip at 2400 bps with no error correction, on 
noisy phone lines.  (It sucked, but it more or less worked.  Yes, it would 
hang up at times when the line noise made retransmission impossible for more 
than about fifteen seconds at a time, which is why PPP was invented.  PPP is 
designed to be MORE robust than slip, more intelligent than SLIP about 
retransmits, and above all not to give up nearly as easily.  It's been a 
couple years since I've messed with it in depth, but it seems to me the phone 
generally physically lost carrier before PPP gave up.  (Should PPP over 
Ethernet ever "hang up" and exit during a network storm?)  The modem itself 
doesn't care about the data being transmitted through it, that has no bearing 
on its carrier detect status.  And if pppd exited due to a 1/3 second dropout 
(producing at most 2 garbled packets: one cut off at the start and one cut 
off at the end, the rest simply dropped), then there would be something wrong 
with pppd.

So you've got a "gloom and doom" scenario that, even in this fairly 
pathlogical worst case, doesn't really seem all that bad.  And it's also a 
purely theoretical objection of a kind that I haven't heard anybody actually 
testing the patch complaining about, AND one that seems like it could be 
addressed by using IRQ disabling as a latency guard in addition to spinlocks.

>["Don't do that then" isnt a valid answer here. If I did hold a lock
> it would be for several milliseconds at a time anyway and would reliably
> trash performance this time]

If NE2K is holding the lock for several miliseconds at a time, how is it 
managing 833 packets/second?  (Is it NOT doing one per interrupt?)

If it's holding the lock for several miliseconds, the overhead of acquiring 
the lock in the first place isn't exactly a show-stopper, is it?

If spinlocks don't get compiled in on non-preempt UP boxes (and are basically 
just an increment in preempt), where is the killer overhead in the UP case?  
If you're saying spinlocks would kill SMP performance, on a lock which should 
basically have no contention at all (when we used to have 100baseT drivers 
using the Big Kernel Lock), 

And again, this is where the use of IRQ blocking as a preempt guard comes in 
handy.  (Which naturally expires when you return to userspace anyway, so 
hand-waving about unlimited blocking time is just that: there IS an upper 
bound here.  And an IRQ block that's part of a device shutdown is really a 
different call, which would probably mostly be confined to the module unload 
code anyway.)

>There are numerous other examples in the kernel tree where the current code
>knows that there is a small bounded time between two actions in kernel space
>that do not have a sleep.

Such as?

(And if the use of IRQ disabling as a preempt guard doesn't fix it, then the 
code is ALREADY hosed because interrupts can be arbitrarily long.  We're 
trying to keep them short now, but we used to switch consoles from interrupt 
context and that could take a LONG time if we were wandering between graphics 
and text consoles.  So you're saying this is code that didn't show up as a 
bug back then...)

>They are not spin locked, and putting spin locks
>everywhere will just trash performance. They are pure hardware interactions
>so you can't automatically detect them.

If they don't have IRQs blocked, they don't have any real latency guarantees 
anyway.  If the DO have IRQs blocked, they can be automatically detected.

>That is why the pre-empt code is a much much bigger problem and task than the
>low latency code.

I don't see it.  Care to point out what I've missed?

>Alan

Rob
