Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbVLVOrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbVLVOrT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 09:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbVLVOrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 09:47:19 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:16286 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965112AbVLVOrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 09:47:18 -0500
Date: Thu, 22 Dec 2005 15:46:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 5/9] mutex subsystem, core
Message-ID: <20051222144626.GA31939@elte.hu>
References: <20051222114233.GF18878@elte.hu> <43AAAC6F.17CC646@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43AAAC6F.17CC646@tv-sign.ru>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Oleg Nesterov <oleg@tv-sign.ru> wrote:

> > +	/*
> > +	 * Lets try to take the lock again - this is needed even if
> > +	 * we get here for the first time (shortly after failing to
> > +	 * acquire the lock), to make sure that we get a wakeup once
> > +	 * it's unlocked. Later on this is the operation that gives
> > +	 * us the lock. If there are other waiters we need to xchg it
> > +	 * to -1, so that when we release the lock, we properly wake
> > +	 * up the other waiters:
> > +	 */
> > +	old_val = atomic_xchg(&lock->count, -1);
> > +
> > +	if (unlikely(old_val == 1)) {
> > +		/*
> > +		 * Got the lock - rejoice! But there's one small
> > +		 * detail to fix up: above we have set the lock to -1,
> > +		 * unconditionally. But what if there are no waiters?
> > +		 * While it would work with -1 too, 0 is a better value
> > +		 * in that case, because we wont hit the slowpath when
> > +		 * we release the lock. We can simply use atomic_set()
> > +		 * for this, because we are the owners of the lock now,
> > +		 * and are still holding the wait_lock:
> > +		 */
> > +		if (likely(list_empty(&lock->wait_list)))
> > +			atomic_set(&lock->count, 0);
> 
> This is a minor issue, but still I think it makes sense to optimize
> for uncontended case:
> 
> 	old_val = atomic_xchg(&lock->count, 0); // no sleepers
> 
> 	if (old_val == 1) {
> 		// sleepers ?
> 		if (!list_empty(&lock->wait_list))
> 			// need to wakeup them
> 			atomic_set(&lock->count, -1);
> 		...
> 	}
>       [*]

but then we'd have to set it to -1 again, at [*], because we are now 
about to become a waiter. So i'm not sure it's worth switching this 
around.

Also, there are two uses of this codepath: first it's the 'did we race 
with an unlocker', in which case the lock is almost likely still 
contended. The second pass comes after we have woken up, in which case 
it's likely uncontended.

while we could split up the two cases and optimize each for its own 
situation, i think it makes more sense to have then unified, and thus to 
have more compact code. It's the slowpath after all.

	Ingo
