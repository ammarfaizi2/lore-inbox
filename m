Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287348AbSALTVt>; Sat, 12 Jan 2002 14:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287342AbSALTVa>; Sat, 12 Jan 2002 14:21:30 -0500
Received: from gumby.it.wmich.edu ([141.218.23.21]:8639 "EHLO
	gumby.it.wmich.edu") by vger.kernel.org with ESMTP
	id <S287348AbSALTVL>; Sat, 12 Jan 2002 14:21:11 -0500
Message-ID: <005b01c19b9e$90a5af40$0501a8c0@psuedogod>
From: "Ed Sweetman" <ed.sweetman@wmich.edu>
To: <arjan@fenrus.demon.nl>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Rob Landley" <landley@trommello.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <E16PTIR-0002sL-00@the-village.bc.nu>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Sat, 12 Jan 2002 14:23:00 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Another example is in the network drivers. The 8390 core for one example
> carefully disables an IRQ on the card so that it can avoid spinlocking on
> uniprocessor boxes.
>
> So with pre-empt this happens
>
> driver magic
> disable_irq(dev->irq)
> PRE-EMPT:
> [large periods of time running other code]
> PRE-EMPT:
> We get back and we've missed 300 packets, the serial port sharing
> the IRQ has dropped our internet connection completely.
>
> ["Don't do that then" isnt a valid answer here. If I did hold a lock
>  it would be for several milliseconds at a time anyway and would reliably
>  trash performance this time

> There are numerous other examples in the kernel tree where the current
code
> knows that there is a small bounded time between two actions in kernel
space
> that do not have a sleep. They are not spin locked, and putting spin locks
> everywhere will just trash performance. They are pure hardware
interactions
> so you can't automatically detect them.

hardware to hardware could have a higher priority than normal programs being
run.   That way they're not preempted by simple programs, it would have to
be purposely preempted by the user.

> That is why the pre-empt code is a much much bigger problem and task than
the
> low latency code.

Lowering the latency, sure the low latency code probably does nearly as well
as the preempt patch.  that's fine.  Shortening the time locks are held by
better code can help to a certain extent (unless a lot of the kernel code is
poorly written, which i doubt).  at it's present state though,  my idea to
fix the kernel would be to give parts of the kernel where locks are made,
that shouldn't be broken normally, higher priorities.  That way we can
distinguish between safe locks to preempt at and the ones that can do harm.
But those people who require their app to be treated special can run it
with -20 and preempt everything.   To me that makes sense.  Is there a
reason why it doesn't?  Besides ethstetics.   the only way the ethsetic
argument people are going to be pleased is if the kernel is designed from
the ground up to be better latency and lock-wise.   A lot of people would
like to not have to wait until that time in the meantime.

