Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131205AbREBHr6>; Wed, 2 May 2001 03:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131246AbREBHri>; Wed, 2 May 2001 03:47:38 -0400
Received: from ns1.crl.go.jp ([133.243.3.1]:27277 "EHLO ns1.crl.go.jp")
	by vger.kernel.org with ESMTP id <S131205AbREBHr1>;
	Wed, 2 May 2001 03:47:27 -0400
Date: Wed, 2 May 2001 16:47:21 +0900 (JST)
From: Tom Holroyd <tomh@po.crl.go.jp>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Unknown HZ value! (2000) Assume 1024.
In-Reply-To: <200105020642.f426gww379046@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.30.0105021600420.27862-100000@holly.crl.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 May 2001, Albert D. Cahalan wrote:

> This is pretty bogus. The idle time can run _backwards_ on an SMP
> system.

True, but it's failing for single CPU systems (like mine), too.

>> I notice also that since kstat.per_cpu_nice is an unsigned int, it's
>> going to overflow in another 3.6 days anyhow. ... Any chance of making
>> those guys longs?

> For 32-bit systems, we use 32-bit values to reduce overhead.
> This causes problems at 495/smp_num_cpus days of uptime.

You mean for HZ == 100.  And I guess the overhead in question is the cost
of a 64 bit add vs. a 32 bit add HZ times per second?  On a 64 bit
machine, that overhead is likely to be exactly zero.  It is zero on my
machine.  For integer math on an Alpha, changing the ints to longs can
even make a program run faster.

> Proposed hack: set a very-long-duration timer (several days)
> to check for the high bit changing. Count bit flips.

What about the interval between when it flips and when you notice it?

No, change the kstat variables to unsigned longs on 64 bit systems.
In fact, make them unsigned longs on any system, as opposed to something
like u_int64 or whatever.  (And fix the code in proc_misc.c that uses
them.)

For 32 bit systems with HZ == 1024, decide if an overhead of about 1 usec
per second is too much to justify using 64 bits.  That's 4 seconds lost
over the 49 days it takes to fail (if your hardware isn't that fast what
are you doing with HZ == 1024 in the first place).

