Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSFFWzM>; Thu, 6 Jun 2002 18:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311871AbSFFWzL>; Thu, 6 Jun 2002 18:55:11 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:25741 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S311025AbSFFWzK>; Thu, 6 Jun 2002 18:55:10 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Martin Wirth <martin.wirth@dlr.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futex Asynchronous Interface 
In-Reply-To: Your message of "Thu, 06 Jun 2002 18:08:36 +0200."
             <3CFF8904.9010703@dlr.de> 
Date: Fri, 07 Jun 2002 08:59:19 +1000
Message-Id: <E17G6Dv-0000Ei-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3CFF8904.9010703@dlr.de> you write:
> Hi Rusty,
> 
> >if (this->page == page && this->offset == offset) {
> > 			list_del_init(i);
> > 			tell_waiter(this);
> >+			unpin_page(this->page);
> > 			num_woken++;
> > 			if (num_woken >= num) break;
> > 		}
> > 	}
> > 	spin_unlock(&futex_lock);
> >+	unpin_page(page);
> > 	return num_woken;
> 
> If I understand right you shouldn't unpin the page if you are not sure that
> all waiters for a specific (page,offset)-combination are woken up and deleted
> from the waitqueue. Otherwise a second call to futex_wake may look on the wro
ng
> hash_queue or wake the wrong waiters.

No, we delete them from the list (list_del_init) so we can't find it
again: ie. futex_wake can't be invoked twice on the same thing without
someone putting it back on the queue...

> In general, I think fast userspace synchronization primitives and
> asynchronous notification are different enough to keep them
> logically more separated.  Your double use of the hashed wait queues
> and sys_call make the code difficult to grasp and thus open for
> subtle error.

I don't think the complexity is much worse: async is inherently
complex given that there are no real in-kernel primitives to do offer
both sync and async cleanly.  Having two incompatible primitives would
be painful, too.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
