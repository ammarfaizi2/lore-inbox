Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbVLSNy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbVLSNy5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 08:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbVLSNy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 08:54:57 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:34741 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1750743AbVLSNy4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 08:54:56 -0500
Date: Mon, 19 Dec 2005 06:54:53 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Nicolas Pitre <nico@cam.org>, Linus Torvalds <torvalds@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>, mingo@redhat.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/12]: MUTEX: Implement mutexes
Message-ID: <20051219135453.GQ2361@parisc-linux.org>
References: <14917.1134847311@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0512171201200.3698@g5.osdl.org> <Pine.LNX.4.64.0512172018410.26663@localhost.localdomain> <Pine.LNX.4.64.0512171803580.3698@g5.osdl.org> <Pine.LNX.4.64.0512172150260.26663@localhost.localdomain> <Pine.LNX.4.64.0512172227280.3698@g5.osdl.org> <20051218092616.GA17308@flint.arm.linux.org.uk> <Pine.LNX.4.64.0512181027220.4827@g5.osdl.org> <Pine.LNX.4.64.0512181657050.26663@localhost.localdomain> <20051219092743.GA9609@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051219092743.GA9609@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 09:27:44AM +0000, Russell King wrote:
> > 	mov	r0, #1
> > 	swp	r1, r0, [%0]
> > 	cmp	r1, #0
> > 	bne	__contention

> That's over-simplified, and is the easy bit.  Now work out how you handle
> the unlock operation.
> 
> You don't know whether the lock is contended or not in the unlock path,
> so you always have to do the "wake up" thing.  (You can't rely on the
> value of the lock since another thread may well be between this swp
> instruction and entering the __contention function.  Hence you can't
> use the value of the lock to determine whether there's anyone sleeping
> on it.)

Here's a slightly less efficient way to determine if anyone else has
swp'd behind your back (apologies if I get my ARM assembly wrong, it's
been a few years):

	swp	r1, r13, [%0]	# load r1 from addr and store r13 there
	cmp	r1, #0		# is r1 0?
	streq	r13, [%0, #4]	# if it is, store a copy of r13 at the
				# next address
	blne	__lock_contention

I'm assuming that r13 (the stack pointer) will be different for each
task, and (with this being a mutex), we won't try to double-acquire it.
Unlock is then:

	mov	r0, #0		# put 0 in r0
	swp	r1, r0, [%0]	# release the lock
	ldr	r0, [%0, #4]	# load the copy
	cmp	r0, r1		# did it change?
	blne	__unlock_contention

In __unlock_contention, thread1 would try to re-acquire the mutex (at
[%0]), and if it does, wake up the first waiter.  Obviously it's unfair
as thread3 could come along and grab the mutex, but that's not a huge
deal.

Note that we're not checking the value of r13 at the unlock site as lock
and unlock can be done at different stack levels.  We're checking to see
if the value last written to the lock was the one by the successful
acquirer.
