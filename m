Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268812AbTBZQaC>; Wed, 26 Feb 2003 11:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268813AbTBZQaC>; Wed, 26 Feb 2003 11:30:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4871 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268812AbTBZQ37>; Wed, 26 Feb 2003 11:29:59 -0500
Date: Wed, 26 Feb 2003 08:37:16 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <mingo@redhat.com>, Mikael Pettersson <mikpe@csd.uu.se>,
       Asit Mallick <asit.k.mallick@intel.com>
Subject: Re: [BUG] 2.5.63: ESR killed my box!
In-Reply-To: <2880000.1046274724@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0302260813510.1423-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ I added Mikael and Asit to the Cc, since they might be able to confirm 
  or deny the ESR issue ]

On Wed, 26 Feb 2003, Martin J. Bligh wrote:
> 
> Now in the case Rusty has, would be nice to find why it's changed, this was
> just a workaround. On the NUMA-Qs, this always happened, so it's not so
> interesting ;-)

Well, after having re-read the ESR description in the Intel manuals, and 
looking at our code, I think the code has always been crap.

The manual clearly states that you clear the ESR by doing back-to-back
writes, and that you read it by writing to it and then reading it. That's
not at _all_ what we do at bootup. It's _also_ not what we do at 
"clear_local_apic()".

>From the description in the Intel docs, it really looks like the ESR works 
as follows:
 - reading ESR reads the "cached" register (which is nothing but a latch, 
   and has no real "meaning" except as exactly that)
 - writing to ESR moves the current real hardware register into the 
   latched one and it resets the real hardware one.

In other words, you have three cases:

 - "read previous state" (which is only really useful for software that 
   doesn't want to carry the state with it, ie things like status 
   printing stuff in the error handler):

	value = apic_read(APIC_ESR)

   This has _nothing_ to do with whatever the current ESR state is, and 
   only reads the value as it was at the previous latch event.

 - latch current state and read it:

	apic_write(0, APIC_ESR);	// I doubt the value matters
	value = apic_read(APIC_ESR);

   This reads the real "current state", leaving it in the latch.

 - clear and read current state:

	apic_write(0, APIC_ESR);
	value = apic_read(APIC_ESR);
	apic_write(0, APIC_ESR);

   (You probably might as well do this sequence to clear the thing even if
   you don't actually care what the old value was, if only to make sure 
   there are no write-buffer bugs).

Also, I would _assume_ that the error interrupt is active based on the
bit-wise "or" of both the latched and the real value, since the docs
clearly say that it must be cleared by sw by back-to-back writes
(rationale: if the error interrupt is only triggered by the latch it is
obviously useless, since we wouldn't get an interrupt for new events. If
the error interrupt is only triggered by the real value, we'd only need a
single write to clear it).

Anyway, the above is clearly not what we're doing with the ESR right now.

Martin: in the esr disable case you clearly write the ESR multiple times
("over the head with a big hammer"), and you must do that because you
noticed that a single write was insufficient. Why four? Did you just
decide that as long as you're doing multiple writes, you might as well
just do "several". Or did four writes work and two didn't?

Asit, can you confirm/deny (or know who can)?

			Linus

