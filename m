Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154945AbQBLBHH>; Fri, 11 Feb 2000 20:07:07 -0500
Received: by vger.rutgers.edu id <S155414AbQBLAw6>; Fri, 11 Feb 2000 19:52:58 -0500
Received: from [216.101.162.242] ([216.101.162.242]:33186 "EHLO pizda.ninka.net") by vger.rutgers.edu with ESMTP id <S155603AbQBKVGQ>; Fri, 11 Feb 2000 16:06:16 -0500
Date: Fri, 11 Feb 2000 17:02:38 -0800
Message-Id: <200002120102.RAA13221@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: eis@baty.hanse.de
Cc: linux-kernel@vger.rutgers.edu
In-reply-to: <ouwvobjyux.fsf@baty.hanse.de> (message from Henner Eisen on 11 Feb 2000 20:57:58 +0100)
Subject: Re: New network driver interface changes, README
References: <oun1p83j2e.fsf@totally-fudged-out-message-id> <ouwvobjyux.fsf@baty.hanse.de>
Sender: owner-linux-kernel@vger.rutgers.edu

   From: Henner Eisen <eis@baty.hanse.de>
   Date: 11 Feb 2000 20:57:58 +0100

   >>>>> "David" == David S Miller <davem@redhat.com> writes:

       David> 5) dev->hard_start_xmit()

	   [:]

       David> 	This method will be called with local _software_
						   ^^^^^^^^^^^^^^^^
       David> interrupts disabled.  If you need local hw IRQs disabled or
	      ^^^^^^^^^^^^^^^^^^^

   Is this part of the interface specification or just a feature of the
   current implementation?

   Should driver authors rely or better not rely on this if they want to
   reduce the probability of trouble in the future (future network changes)?

That's a very good question.  Here is how I would like driver authors
to think about this:

	The network queueing layer guarentees that your
	hard_start_xmit() method is not re-entrable.  This
	means that only one thread can be running in that
	method at once for a particular device instance.

	That is to say, if dev1->hard_start_xmit() is currently
	running, it will not be invoked for "dev1" anywhere
	else in the system until that thread returns from the
	function.

	You may not depend upon the mechanism used by the
	network queueing layer to achieve this.  It is only
	the property achieved which may be depended upon.

Does this clear up the issue?

Actually, we thought a lot about (and are still considering)
taking away this assumption as well, and making the atomicity
guarentee be a problem of the driver.  You may ask yourself
why we would do that, since it would make even more work for
the driver authors (well, to be really SMP safe you have to
interlock with your TX complete interrupt anyways).  Here are
the reasons:

Some software network devices require none of the locking, they
are self-consistent.  One great example is loopback.  It does not
need dev->xmit_lock nor the local software interrupt disabling.
All it does is pass the packet back to the input side of the
networking, via netif_rx(skb) which works only on cpu local state.

Secondly, since most ethernet/fddi/etc. drivers will need to do
their own spinlocking and hw IRQ disabling to protect against their
TX complete interrupt, we're just using twice as much locking overhead
by providing the non-reentrancy dev->xmit_lock buisness.

It's something to consider, but I probably won't allow this change
to happen for 2.4.x

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
