Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265367AbTFMM3m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 08:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265373AbTFMM3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 08:29:42 -0400
Received: from chaos.analogic.com ([204.178.40.224]:56452 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265367AbTFMM3k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 08:29:40 -0400
Date: Fri, 13 Jun 2003 08:44:52 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Robert Love <rml@tech9.net>
cc: Paul Mackerras <paulus@samba.org>, Patrick Mochel <mochel@osdl.org>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@digeo.com>,
       sdake@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
In-Reply-To: <1055461816.662.350.camel@localhost>
Message-ID: <Pine.LNX.4.53.0306130823170.4004@chaos>
References: <1055460564.662.339.camel@localhost>  <Pine.LNX.4.44.0306121629590.11379-100000@cherise>
  <16105.3943.510055.309447@nanango.paulus.ozlabs.org> <1055461816.662.350.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jun 2003, Robert Love wrote:

> On Thu, 2003-06-12 at 16:40, Paul Mackerras wrote:
>
> > BZZZT.  If another CPU is also doing atomic_inc_and_read you could end
> > up with both calls returning the same value.
>
> That is what I thought. Damn.
>
> > You can't do atomic_inc_and_read on 386.  You can on cpus that have
> > cmpxchg (e.g. later x86).  You can also on machines with load-locked
> > and store-conditional instructions (alpha, ppc, probably most other
> > RISCs).
>
> So this is doable on everything but old i386 chips... hrm.
>
> 	Robert Love
>

No! They do not return the same value. They just don't return the
final value, and the final value might not be important if the
atomic operations are used correctly.

The atomic stuff is to get rid of the read/modify/write problem where
you have a read *INTERRUPT* (other read, other modify, other write),
modify, write. Now the operand is nothing like expected. The
atomic operations guarantee that the memory operand will, in fact,
be completely modified as expected. Reading any value after such
modification does not necessarily return the final value because
somebody could modify it (again atomically), before you get
a chance to read it.

So, if you have N atomic_inc() and N atomic_dec() operations, the
value will be whatever it was before the first operation. In other
words, the value will be correct.

FYI, all memory modify operations, not using an intermediate register,
in  32-bit mode, of a longword or less, on ix86 machines are atomic,
even without the lock prefix.

like:

memory:	.long	0
	incl (memory)
	incw (memory)
	incb (memory)

This is because the CPU does not load the operand, modify it, then
write it back. It might "physically" do this in hardware, but the
physical operation cannot be interrupted until complete. So, in
principle, the lock instruction isn't necessary for things like above.

If you really need to know what the value of the memory operand
was at the instant it was modified, you need use the locked/exchange
instructions. Normally, you don't need to know the exact value
of some semaphore, etc., only that some conditions were true or
false at the instant of a test.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

