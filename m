Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316503AbSHJB2Q>; Fri, 9 Aug 2002 21:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSHJB2Q>; Fri, 9 Aug 2002 21:28:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11539 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316503AbSHJB2P>; Fri, 9 Aug 2002 21:28:15 -0400
Date: Fri, 9 Aug 2002 18:33:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
In-Reply-To: <3D5464E3.74ED07CC@zip.com.au>
Message-ID: <Pine.LNX.4.44.0208091813470.1165-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Aug 2002, Andrew Morton wrote:
> 
> This patch allows the kernel to hold atomic kmaps across copy_*_user. 
> >From an idea by Linus and/or Martin Bligh and/or Andrea.

Argh.

I've come to hate this approach, I should have told you. That magic 
%esi/%edi thing disturbs me, even if I was one of the people responsible 
for polluting your virgin brain with the idea. It just makes me squirm, 
not just because there may be memcopies that would prefer to use other 
registers, but because I just think it's too damn fragile to play with 
register contents from exceptions.

So I would suggest instead:

 - do_page_fault() already does an

	if (in_interrupt() || !mm)
		goto no_context;

   and the fact is, the "in_interrupt()" should really be an 
   "preempt_count()", since it's illegal to take a page fault not just in 
   interrupts, but while non-preemptible in general.

 - now, if we do the copy_to/from_user() from a preempt-safe area, the 
   _existing_ code (with the above one-liner fix) already returns a
   partial error (ie no new code-paths - copy_to/from_user() already has 
   to handle the EFAULT case)

 - which means that we can do the kmap_copy_to_user() with _zero_ new 
   code, by just wrapping it something like this:

	repeat:
		kmap_atomic(..); // this increments preempt count
		nr = copy_from_user(..);
		kunmap_atomic(..);

		/* bytes uncopied? */
		if (nr) {
			if (!get_user(dummy, start_addr) &&
			    !get_user(dummy, end_addr))
				goto repeat;
			.. handle EFAULT ..
		}

Yes, the above requires some care about getting the details right, but
notice how it requires absolutely no magic new code, and how it actually
uses existing well-documented (and has-to-work-anyway) features.

And notice how it works as a _much_ more generic fix - the above actually 
allows the true anti-deadlock thing where you can basically "test" whether 
the page is already mapped with zero cost, and if it isn't mapped (and you 
worry about deadlocking because you've already locked the page that we're 
writing into), you can make the slow path do a careful "look up the page 
tables by hand" thing.

In other words, you can use the above trick to get rid of that horrible
"__get_user(dummy..)" thing that is one huge big hack right now in
generic_file_write().

(And yes, it requires incrementing the preempt count in kmap/kunmap even
if preemption is otherwise disabled, big deal).

			Linus

