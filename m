Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbTIVSgE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 14:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbTIVSgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 14:36:04 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34877 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262114AbTIVSf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 14:35:59 -0400
To: linux@horizon.com
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Can we kill f inb_p, outb_p and other random I/O on port 0x80, in 2.6?
References: <20030922153651.16497.qmail@science.horizon.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Sep 2003 12:35:49 -0600
In-Reply-To: <20030922153651.16497.qmail@science.horizon.com>
Message-ID: <m1brtck6wq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com writes:

> > inb_p and outb_p issue outb's to port 0x80 to achieve a short delay.
> > In a reasonable system there is nothing listening to port 0x80 
> > or there is a post card, but there are no other devices there.
> > 
> > On a modern system with no post card the outb travels it's
> > way down to the LPC bus, and the outb is terminated by an abort
> > because nothing is listening.
> > 
> > So far so good.  Except for the fact that recent high volume
> > ROM chips get confused when they see an abort on the LPC
> > bus.  Making it problematic to update the ROM from under Linux.
> 
> Juts when we think we've found a safe time delay, somebody goes and
> screws it up.
> 
> 1) Could you specify the ROM chips concerned?  Is it possible to
>    unconfuse them in software as a workaround?

SST.   And they don't stay confused.  They just drop whatever
command you were sending them.  And dropping writes to a ROM
chip is very nasty.  If you don't catch and fix it your system
will not boot the next time.

> 2) Do the BIOSes not write to port 0x80 themselves?  The port was
>    chosen precisely because most current BIOSes write boot progress
>    indicators there, so Linux shouldn't be doing anything new.

I think they do.  I have not been able to hook up a post card to
check.   The difference is that they don't do it while talking
to the ROM chip.

> > I don't know if there are other buggy LPC devices or not.  But
> > I do know that it is generally bad form do I/O to a random port.
> 
> It's bad form to do I/O on a *random* port because you don't know what
> might be listening.  It's *not* bad form to write to a known unused
> I/O port.  On the original ISA bus, that's harmless, and the LPC bus is
> supposed to emulate that.
> 
> And, as I mentioned, most BIOSes write to that port periodically.

Yes.  There are a few boards and few weird cases where 0x80 is
not safe.  This just adds to the list of problematic cases.

> > So can we gradually kill inb_p, outb_p in 2.6?  An the other
> > miscellaneous users of I/O port 0x80 for I/O delays?
> 
> Actually, It's not easy.  The issue got debated a lot a few years ago.
> A read is also acceptable, and allows a few more ports to be
> potentially used, but that corrupts %al and thus bloats the code.
> 
> > Or possibly rewriting outb_p to look something like:
> > outb(); udelay(200);  or whatever the appropriate delay is?
> 
> As Alan points out, udelay() requires either using the 8254 PIT or knowing
> at least one system clock speed to calibrate a bogomips-style delay loop.
> All of the known clock frequencies are on ISA-bus peripherals.  So we
> have to access them BEFORE udelay() is calibrated.
> 
> And the 8254 is one of the chips which requires the pause.
> This creates a significant boot-order challenge.

Yes, I agree.  And during bootstrap the 0x80 case does not cause me
problems.  But when the system is running I either need
cli();
......
sti();
pairs in my code, a global lpc bus lock, or I need to avoid
the writes to port 0x80.  I can't even use cli()/sti() because
they have been removed in 2.6.

> > When debugging this I modified arch/i386/io.h to read:
> > #define  __SLOW_DOWN_IO__ ""
> > Which totally removed the delay and the system ran fine.
> 
> Yes, in 98% of modern boards it *does* work fine to just omit the delays
> entirely, because the motherboard chipset emulation can cope.
> But the original chip specs call for the delay, and the kernel
> has a hard time figuring out what's what early in the boot process.

Right.  So this does need to be handled and delicately.  

My main goal is to remove the deep magic voodoo in place.  I would
object less if the code was clearly commented and isolated, to those
few places that need it.  

Eric


