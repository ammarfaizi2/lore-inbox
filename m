Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315120AbSHAPLb>; Thu, 1 Aug 2002 11:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315406AbSHAPLb>; Thu, 1 Aug 2002 11:11:31 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7043 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315120AbSHAPLa>; Thu, 1 Aug 2002 11:11:30 -0400
Date: Thu, 1 Aug 2002 11:15:04 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Kasper Dupont <kasperd@daimi.au.dk>
cc: stas.orel@mailcity.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] vm86: Clear AC on INT
In-Reply-To: <3D493B06.3C20A88@daimi.au.dk>
Message-ID: <Pine.LNX.3.95.1020801105021.26692A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Aug 2002, Kasper Dupont wrote:

> Stas Sergeev wrote:
> > 
> > Hello.
> > 
> > According to this:
> > http://support.intel.com/design/intarch/techinfo/Pentium/instrefi.htm#89126
> > AC flag is cleared by an INT
> > instruction executed in real mode.
> > The attached patch implements that
> > functionality and solves some
> > problems recently discussed in
> > dosemu mailing list.
> 
> This sounds a little strange to me. AC is in the upper 16 bit
> of the EFLAGS register, so it is not saved on an interrupt
> where only lower 16 bits is saved. This means that when we
> clear it on the interrupt, the value will be lost for good.
> 

Alignment-check does not exist in real mode. Therefore AC flags
mean nothing. In fact, you can't even access more than 16 bits
of the flags register in real mode, even by playing tricks
(pushf pushes only 16 bits, even if you prefix it with 0x66).

> I can see the spec says it, so we'd better do that. But does
> the spec make any sense? And does the CPU really loose the
> AC flag on every interrupt in real mode?
> 

Sure, there is no alignment check in real mode. You can access
anything at any offset and an offset running off the end wraps
back through zero.

> A few other things got me wondering, it says there is tested
> for enough space in the stack. Does this mean something like
> if (SP<6) trap(); ? If it does, we should change do_int to
> actually do this. And how should we actually trap if there
> is not enough space for pushing values?
> 

If you execute an INT without enough stack, i.e., the SP
gets pushed through zero, as long as nobody trashed its values,
it will be poped back through zero on the IRET. Obviously a
coding bug, but it will still work.


> And does this testing apply to other instructions as well?
> 
> And it also says the IDT size is tested. But does that
> concept even exist in real mode?
> 

The IDT actually exists in real mode, and its layout is what
defines the interrupt table starting at offset 0. In fact, when
a BIOS needs to transition from/to/back 16/32/16 mode, it saves
the 16-bit table SIDT, so it can restore it with LIDT later.

> And finally, why do we have a 32 bit IRET instruction, but
> no 32 bit INT instruction? Is that really correct?
>

Int NN only references an interrupt number. In 32-bit mode, it
is a 32-bit interrupt which gets completed with a 32-bit IRET.
That number 'NN', references the entries in an IDT.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

