Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbVLMUE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbVLMUE6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 15:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVLMUE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 15:04:58 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:4850 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751361AbVLMUE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 15:04:58 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Steven Rostedt <rostedt@goodmis.org>
To: David Howells <dhowells@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org, matthew@wil.cx, arjan@infradead.org,
       hch@infradead.org, akpm@osdl.org, torvalds@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <3874.1134480759@warthog.cambridge.redhat.com>
References: <1134479118.11732.14.camel@localhost.localdomain>
	 <dhowells1134431145@warthog.cambridge.redhat.com>
	 <3874.1134480759@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 15:04:20 -0500
Message-Id: <1134504260.18921.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-13 at 13:32 +0000, David Howells wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > >  (5) Redirects the following to apply to the new mutexes rather than the
> > >      traditional semaphores:
> > > 
> > > 	down()
> > ...
> > 
> > And you've audited every occurence ?
> 
> Outside of the arch directories, yes; but I don't know that I've made the
> correct decision in 100% of the cases.

I'm in the crowd that thinks that the mutex downs and ups should be
converted to mutex_lock/mutex_unlock.  Simply because that is basically
what a mutex is doing.  I rather not have another "historical" API in
the kernel.

> 
> I've changed some of the uses into completions, and found about a dozen or so
> uses of counting semaphores; but the vast majority of occurrences seem to be
> wanting mutex behaviour.

And we can take our time in looking at this in a case by case basis.

> 
> > It seems to me it would be far far saner to define something like
> > 
> > 	sleep_lock(&foo)
> > 	sleep_unlock(&foo)
> > 	sleep_trylock(&foo)
> 
> Which would be a _lot_ more work. It would involve about ten times as many
> changes, I think, and thus be more prone to errors.

I don't think this should be a one shot patch.  Your patch (and what you
would be responsible for) would just introduce the use of the mutex.
Let others go around and find the places where a semaphore is used where
a mutex should be.  Yes there is a lot more mutexes than true
semaphores, and that is why we really should look at this in a case by
case basis.  One big global change will probably more likely miss a case
that should be a semaphore.

> 
> > Its then obvious what it does, you don't randomly break other drivers you've
> > not reviewed and the interface is intuitive rather than obfuscated.
> 
> I've attempted to review everything in 2.6.15-rc5 outside of most of the archs.
> I can't easily modify any driver not contained in that tarball, but at least
> the compiler will barf and force a review.
> 
> > It won't take long for people to then change the name of the performance
> > critical cases and the others will catch up in time.
> 
> It took about ten hours to go through the declarations of struct semaphore and
> review them; I hate to think how long it'd take to go through all the ups and
> downs too.

That's why this should be a step by step integration.

> 
> > It also saves breaking every piece of out of tree kernel code for now
> > good reason.
> 
> But my patch means the changes required are in the most cases minimal: just
> changing struct semaphore to struct mutex is sufficient for the vast majority
> of cases.

But not every case.

> 
> Your way requires a lot more work, both in the tree and out of it.

Not really.  Over time this would be all cleaned up, but introducing a
new API should be the first step, then we can go to each and every spot
to find where a semaphore should be a mutex.  You'll get a lot more
people helping you in that method then you globally changing it, and
people only help when it breaks.

I'm sure I'm not the only one that would be happy to send patches in to
convert semaphores to mutexes where I find them.  But I'd be more
confused if something suddenly breaks that use to work, and then have to
see that "Oh this was a semaphore that mistakenly became a mutex!".

-- Steve

