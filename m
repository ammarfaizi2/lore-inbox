Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUDANTG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 08:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbUDANTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 08:19:06 -0500
Received: from chaos.analogic.com ([204.178.40.224]:54917 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262905AbUDANRa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 08:17:30 -0500
Date: Thu, 1 Apr 2004 08:17:06 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Jamie Lokier <jamie@shareable.org>, Bill Davidsen <davidsen@tmr.com>,
       Len Brown <len.brown@intel.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Willy Tarreau <willy@w.ods.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
In-Reply-To: <Pine.LNX.4.55.0404011423070.3675@jurand.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.53.0404010814420.15020@chaos>
References: <4069A359.7040908@nortelnetworks.com> <1080668673.989.106.camel@dhcppc4>
 <4069D3D2.2020402@tmr.com> <Pine.LNX.4.55.0403311305000.24584@jurand.ds.pg.gda.pl>
 <20040331150219.GC18990@mail.shareable.org> <Pine.LNX.4.55.0404011423070.3675@jurand.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2004, Maciej W. Rozycki wrote:

> On Wed, 31 Mar 2004, Jamie Lokier wrote:
>
> > >  Well, "cmpxchg", "xadd", etc. can be easily emulated with an aid of a
> > > spinlock.  With SMP operation included.
> >
> > Nope.  Len Brown wrote:
> >
> > > Linux uses this locking mechanism to coordinate shared access
> > > to hardware registers with embedded controllers,
> > > which is true also on uniprocessors too.
> >
> > You can't do that with a spinlock.  The embedded controllers would
> > need to know about the spinlock.
>
>  Hmm, does it mean we support x86 systems where an iomem resource has to
> be atomically accessible by a CPU and a peripheral controller?
>
> --
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +


Of course they all can be emulated. And some "embedded
controllers" don't care and won't have a clue.

The whole idea of atomic operations is to have the specific
operation complete entirely so there is no intermediate
state that can catch you with your pants down.

For instance, If I code something in 'C' as:

	x++;

I would expect that the value of x after the sequence-
point is exactly one more than it was before. However,
if x happens to be a long long in ix86 machines, you
are screwed because the operation occurs in two stages.

	addl	$1,(x)		# Low word
	adcl	$0,4(x)		# CY into high word

If you got interrupted between the first and second operation,
AND if the result of the operation was used before it was
completed, the user gets the wrong value.

In Intel machines ALL memory operations are atomic. What
the means is that if I make code that does:

	addl	%eax,(memory)

... what's in memory will always be the sum of what it was
before and the value in the EAX register. However, if I
made code that did:

	movl	(memory), %ecx	# Get value from memory
	addl	%eax, %ecx	# Add from EAX
	movl	%ecx, (memory)	# Put value back into memory

... such operations are not atomic even though they do the
same thing.

A long time ago, somebody invented the 'lock' instruction
for Intel machines. It turns out that the first ones locked
the whole bus during an operation. Eventually somebody looked
at that, and by the time the '486 came out, they no longer
locked the whole bus. Then somebody else said; "WTF...
Why do we even need this stuff". It was a throw-back to
early primitive machines where there were only load and
store operations in memory. All arithmetic had to be done
in registers. Now, there are only a couple instructions you
can use the lock prefix with, or you get an invalid opcode
trap, and they are really no-ops because the instruction
itself is atomic.

To make the:

	movl	(memory), %ecx	# Get value from memory
	addl	%eax, %ecx	# Add from EAX
	movl	%ecx, (memory)	# Put value back into memory

... code atomic, you need only to prevent it from being
interrupted. On a non-SMP machine, it's easy.

	pushf			# Save flags
	cli			# Clear interrupt bit
	movl	(memory), %ecx	# Get value from memory
	addl	%eax, %ecx	# Add from EAX
	movl	%ecx, (memory)	# Put value back into memory
	popf			# Restore flags (and interrupt bit)

It's a bit more complicated on SMP machines because CLI only
affects the CPU that fetched it. You need a spin-lock for
that.

Now, if my memory operand happens to be some bits that
control a machine, we are not talking about atomic operations
at all, but the order of operations. This could take a
whole chapter in a book.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


