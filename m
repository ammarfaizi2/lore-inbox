Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWENS0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWENS0P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 14:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWENS0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 14:26:14 -0400
Received: from xenotime.net ([66.160.160.81]:11758 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751072AbWENS0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 14:26:14 -0400
Date: Sun, 14 May 2006 11:28:39 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@elte.hu, akpm@osdl.org, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document futex PI design
Message-Id: <20060514112839.d4d7fd93.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.58.0605140812340.12341@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605090954150.7007@gandalf.stny.rr.com>
	<Pine.LNX.4.58.0605100331290.31598@gandalf.stny.rr.com>
	<Pine.LNX.4.58.0605100429220.436@gandalf.stny.rr.com>
	<20060510101729.GB31504@elte.hu>
	<Pine.LNX.4.58.0605100657510.2485@gandalf.stny.rr.com>
	<20060513201402.68c2b205.rdunlap@xenotime.net>
	<Pine.LNX.4.58.0605140812340.12341@gandalf.stny.rr.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 May 2006 10:00:16 -0400 (EDT) Steven Rostedt wrote:

> Some questions though: (embedded)
> 
> On Sat, 13 May 2006, Randy.Dunlap wrote:
> 
> > > +
> > > +Terminology
> > > +-----------
> > > +
> > > +waiter   - A waiter is a struct that is stored on the stack of a blocked
> > > +	   process.  Since the scope of the waiter is within the code for
> > > +	   a process being blocked on the mutex, it is fine to allocate
> > > +	   the waiter on the process' stack (local variable).  This
> >                              process's
> 
> OK, although I'm a native speaker, my English isn't that good.  Some of my
> German colleagues are even better than I.  I always thought that an
> apostrophe 's' after a 's' doesn't add the 's'.  Or should I say, a '\'s'
> after a 's' doesn't include the 's'!

Yep, it's easy to mess this one up.  Strunk & White keeps it simple,
with very few exceptions.  Wikipedia seems to agree:
http://en.wikipedia.org/wiki/Apostrophe_%28mark%29#Possessive_form_of_words_ending_in_s

> > > +top pi waiter - The highest priority process waiting on one of the mutexes
> > > +                that a specific process owns.
> >
> >   top PI waiter (throughout)
> 
> Does this make the document clearer to understand?  I have no problem with
> it either way, I mainly want the document to be easy for people to read,
> and I tried to use capitals to stress things.  But I would really like an
> outside opinion on which reads better. (yours counts as an outside
> opinion)

Either way, just be consistent.

> > > +There are a few differences between plist and list, the most important one
> > > +is that plist is a priority sorted link list.  This means that the priorities
> > s/is/being/
> > s/link/linked/
> 
> "being that plist is a priority sorted linked list..."
> 
> "being" is fine, but I usually think of link list as a single word.
> Although you are correct in that grammically it should be linked.  Again
> this isn't a matter of correctness of grammar, but the ease
> of understanding.  Though, some may argue that correct grammar makes
> understanding easier.

Knuth Vol. 1 discusses *linked* lists.

> Hmm, doing a search on Google with ("link list" "linked list") shows that
> both are used.  Whatever people find easier to understand, I'll use.

> > It would be good to use kernel coding style for these 4 functions....
> 
> You mean:
> 
> void func1(void)
> {
> 	mutex_lock(L1);
> 
> 	/* do anything */
> 
> 	mutex_unlock(L1);
> }

Yes.

> > > +      is OK, since plist_del does nothing if the plist node is not on any
> > > +      list.
> > > +
> > > +If the task was not the top waiter of the mutex, but it was before we
> > > +did the priority updates, that means we are deboosting/lowering the
> > > +task.  In this case, the task is removed from the pi_list of the owner,
> > > +and the new top waiter is added.
> > > +
> > > +Lastly, we unlock both the pi_lock of the task, as well as the mutex's
> > > +wait_lock, and continue the loop again, this time the task is the owner
> > s/this time/but this time/ (?)
> 
> How about "the next iteration will have the owner of the previous mutex as
> the task"

How about just eliminating the run-on sentences?  :)

> > > +A check is made to see if the mutex has waiters or not, this can be the case for
> > > +architectures without CMPXCHG, or a waiter had hit the timeout or signal and
> > > +removed itself between the time the "Has Waiters" bit was checked and this
> > > +check.  If there are no waiters than the mutex owner field is set to NULL,
> > > +the wait_lock is released and nothing more is needed.
> >
> > First sentence of paragraph above needs some work, but I can't tell
> > what is intended so I can't fix it.
> 
> Ah, I don't like that explaination either.  Basically, what I'm trying to
> say is that an architecture that doesn't have CMPXCHG will always check
> for waiters on a lock here.  But for those archs that do have CMPXCHG, this
> case is still needed.  One might think it's not, because the fast path
> only goes into the slow path when CMPXCHG fails.  In other words, the
> mutex has waiters.  But the check here is still needed, because if the
> lock only has one waiter and it woke up by signal or timeout between the
> CMPXCHG check and the grabbing of the wait_lock, the slowpath wont have
> waiters.

Yes, I gathered that.  It's just a case of run-on sentences being
confusing (at least to me).

> Is something like the above a better description.  I wrote it quick, so I
> will even explain it better when I send a patch (and spend more time on
> it)

I think so.

---
~Randy
