Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131686AbQLIPRm>; Sat, 9 Dec 2000 10:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131752AbQLIPRe>; Sat, 9 Dec 2000 10:17:34 -0500
Received: from front7.grolier.fr ([194.158.96.57]:64434 "EHLO
	front7.grolier.fr") by vger.kernel.org with ESMTP
	id <S131686AbQLIPRS> convert rfc822-to-8bit; Sat, 9 Dec 2000 10:17:18 -0500
Date: Sat, 9 Dec 2000 14:46:40 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: Abramo Bagnara <abramo@alsa-project.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2*PATCH] alpha I/O access and mb()
In-Reply-To: <3A32184F.547E7F8B@alsa-project.org>
Message-ID: <Pine.LNX.4.10.10012091351270.1004-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Dec 2000, Abramo Bagnara wrote:

> Gérard Roudier wrote:
> > 
> > 
> > Based on that, let me claim that most of blind barriers inserted this way
> > are useless (thus sob-optimal) and may band-aid useful barriers that are
> > missing. The result is subtle bugs, hidden most of the time, that we will
> > have to suffer for decades.
> > 
> > The only way to do things right regarding ordering it to have device
> > drivers _aware_ of such issues. Now, if we are happy with broken portable
> > or platform-independant drivers that rely on broken hidden ordering
> > alchemy rather than on correctness, then it is another story.
> 
> I see perfectly your point and this is the reason why we have
> __raw_write[bwlq] in 2.4, but write[bwlq] expected semantic is to ensure
> that write *happens* and are visible by other agents.

Ordering and flushing are different issues. Hardware may flush in order to
guarantee some order, but if nothing is to order it may not. A memory
barrier does not guarantee you that a write will go faster to the system
BUS. Basically, if no other agent does need the data and the data is
cacheable, the flushing is just useless. Confusing ordering and flushing
is a serious mistake in my humble opinion.

Speaking about MMIO which is not cacheable, indeed we want the data
targetting the MMIO area to be flushed quickly. But we also want the
device to have a consistent vue of the data in memory for all IOs it is
provided with. Usually, we have to deal with the following:

1) Prepare some DATA in cachable memory (DMA related)
2) Ensure ordering: i.e. may insert a MEMORY BARRIER
3) Tell the device about the IO to perform: write to MMIO

Drivers that are unaware of (2) _are_ broken.

Or:

1) Read device status register to know about IO that completed.
2) Ensure ordering of speculative reads against DMA from the device.
   i.e. may insert a MEMORY (READ) BARRIER.
3) Look into memory for IOs that have completed.

Drivers that are unaware of (2) _are_ broken.

Since the hidden BUS stuff just puts its implicit barriers at the wrong
place regarding the above, any device driver that does DMA and that does
not use explicit barriers is likely to be broken even if it uses normal
IOs. Reason is that the PCI specifications also allow host bridges to post
IO transactions and thus assuming 15 years old ISA-like behaviour is plain
wrong.

> You can tell me that almost nobody uses __raw_write now and this is bad
> and I agree with you, but sometime this is not a perfect world ;-)

The various BUS abstractions I have to suffer of are indeed a great
demonstration of our world being not perfect. ;-)

Hehe... I read so often that most drivers are broken that shoe-horning
bunches or barriers, bus things and other band-aidings is probably the
only way to have some of them mostly usable. ;-)
Or could it be that current O/S guys are still ISA-bussed. ;-)

By the way, given our real world, your patch is probably quite
reasonnable. My point was not to disagree with it, in particular.

  Gérard.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
