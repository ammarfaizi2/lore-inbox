Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277774AbRJLQ6c>; Fri, 12 Oct 2001 12:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277775AbRJLQ6W>; Fri, 12 Oct 2001 12:58:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23304 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277774AbRJLQ6O>; Fri, 12 Oct 2001 12:58:14 -0400
Date: Fri, 12 Oct 2001 09:56:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: <dipankar@in.ibm.com>, <linux-kernel@vger.kernel.org>,
        <paul.mckenney@us.ibm.com>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists
 with insertion
In-Reply-To: <20011012132733.75734399.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.4.33.0110120948540.31692-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 Oct 2001, Rusty Russell wrote:
>
> And the read side is:
> 	lock
> 	loopup
> 	atomic_inc
> 	unlock
>
> With RCU, read side is:
> 	loopup
> 	atomic_inc

Yes. With maybe

	non_preempt()
	..
	preempt()

around it for the pre-emption patches.

However, you also need to make your free _free_ be aware of the count.
Which means that the current RCU patch is really unusable for this. You
need to have the "count" always in a generic place (put it with the hash),
and your schedule-time free needs to do

	if (atomic_read(&count))
		skip_this_do_it_next_time

which starts getting complicated (it means your RCU free now has to have a
notion of "next time" - just leaving the RCU active will slow down
scheduling for as long as any reader holds on to an entry). So your
unread() path probably has to be

	if (atomic_dec_and_test(&count))
		free_it()

and the act of hashing should add a count and unhashing should delete a
count (so that the reader doesn't free it while it is hashed).

Do that, and the RCU patches may start looking usable for the real world.

		Linus

