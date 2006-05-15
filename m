Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWEOG0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWEOG0A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 02:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWEOG0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 02:26:00 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:3541 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932314AbWEOG0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 02:26:00 -0400
Date: Mon, 15 May 2006 02:25:44 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: mingo@elte.hu, akpm@osdl.org, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document futex PI design
In-Reply-To: <20060514112839.d4d7fd93.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.58.0605150220060.6512@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605090954150.7007@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0605100331290.31598@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0605100429220.436@gandalf.stny.rr.com> <20060510101729.GB31504@elte.hu>
 <Pine.LNX.4.58.0605100657510.2485@gandalf.stny.rr.com>
 <20060513201402.68c2b205.rdunlap@xenotime.net>
 <Pine.LNX.4.58.0605140812340.12341@gandalf.stny.rr.com>
 <20060514112839.d4d7fd93.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 14 May 2006, Randy.Dunlap wrote:

> On Sun, 14 May 2006 10:00:16 -0400 (EDT) Steven Rostedt wrote:
>
> > OK, although I'm a native speaker, my English isn't that good.  Some of my
> > German colleagues are even better than I.  I always thought that an
> > apostrophe 's' after a 's' doesn't add the 's'.  Or should I say, a '\'s'
> > after a 's' doesn't include the 's'!
>
> Yep, it's easy to mess this one up.  Strunk & White keeps it simple,
> with very few exceptions.  Wikipedia seems to agree:
> http://en.wikipedia.org/wiki/Apostrophe_%28mark%29#Possessive_form_of_words_ending_in_s

OK, thanks for the link.

>
> > > > +top pi waiter - The highest priority process waiting on one of the mutexes
> > > > +                that a specific process owns.
> > >
> > >   top PI waiter (throughout)
> >
> > Does this make the document clearer to understand?  I have no problem with
> > it either way, I mainly want the document to be easy for people to read,
> > and I tried to use capitals to stress things.  But I would really like an
> > outside opinion on which reads better. (yours counts as an outside
> > opinion)
>
> Either way, just be consistent.

hmm, I'm thinking that I like the "top pi waiter".  That way you know that
I'm talking about the highest priority process waiting on a processes
pi_list.  This differentiates from PI when talking about "Priority
Inheritance". Yes the "pi" in "top pi waiter" refers to priority
inheritance, but it's part of a word and not PI itself.

>
> > > > +There are a few differences between plist and list, the most important one
> > > > +is that plist is a priority sorted link list.  This means that the priorities
> > > s/is/being/
> > > s/link/linked/
> >
> > "being that plist is a priority sorted linked list..."
> >
> > "being" is fine, but I usually think of link list as a single word.
> > Although you are correct in that grammically it should be linked.  Again
> > this isn't a matter of correctness of grammar, but the ease
> > of understanding.  Though, some may argue that correct grammar makes
> > understanding easier.
>
> Knuth Vol. 1 discusses *linked* lists.

OK, linked it is.

> > > > +If the task was not the top waiter of the mutex, but it was before we
> > > > +did the priority updates, that means we are deboosting/lowering the
> > > > +task.  In this case, the task is removed from the pi_list of the owner,
> > > > +and the new top waiter is added.
> > > > +
> > > > +Lastly, we unlock both the pi_lock of the task, as well as the mutex's
> > > > +wait_lock, and continue the loop again, this time the task is the owner
> > > s/this time/but this time/ (?)
> >
> > How about "the next iteration will have the owner of the previous mutex as
> > the task"
>
> How about just eliminating the run-on sentences?  :)

Doh, I just love my run-on sentences.  OK, I'll work on describing it with
smaller sentences.

>
> > > > +A check is made to see if the mutex has waiters or not, this can be the case for
> > > > +architectures without CMPXCHG, or a waiter had hit the timeout or signal and
> > > > +removed itself between the time the "Has Waiters" bit was checked and this
> > > > +check.  If there are no waiters than the mutex owner field is set to NULL,
> > > > +the wait_lock is released and nothing more is needed.
> > >
> > > First sentence of paragraph above needs some work, but I can't tell
> > > what is intended so I can't fix it.
> >
> > Ah, I don't like that explaination either.  Basically, what I'm trying to
> > say is that an architecture that doesn't have CMPXCHG will always check
> > for waiters on a lock here.  But for those archs that do have CMPXCHG, this
> > case is still needed.  One might think it's not, because the fast path
> > only goes into the slow path when CMPXCHG fails.  In other words, the
> > mutex has waiters.  But the check here is still needed, because if the
> > lock only has one waiter and it woke up by signal or timeout between the
> > CMPXCHG check and the grabbing of the wait_lock, the slowpath wont have
> > waiters.
>
> Yes, I gathered that.  It's just a case of run-on sentences being
> confusing (at least to me).
>
> > Is something like the above a better description.  I wrote it quick, so I
> > will even explain it better when I send a patch (and spend more time on
> > it)
>
> I think so.
>

OK, I'll give this all a try.

Thanks,

-- Steve

