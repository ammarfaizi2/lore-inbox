Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264377AbRFGI6b>; Thu, 7 Jun 2001 04:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264378AbRFGI6W>; Thu, 7 Jun 2001 04:58:22 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56620 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S264377AbRFGI6R>; Thu, 7 Jun 2001 04:58:17 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <Pine.LNX.4.21.0106070109210.5128-100000@penguin.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Jun 2001 02:54:34 -0600
In-Reply-To: <Pine.LNX.4.21.0106070109210.5128-100000@penguin.transmeta.com>
Message-ID: <m1u21s4qlx.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On 7 Jun 2001, Eric W. Biederman wrote:
> 
> No - I suspect that we're not actually doing all that much IO at all, and
> the real reason for the lock-up is just that the current algorithm is so
> bad that when it starts to act exponentially worse it really _is_ taking
> minutes of CPU time following pointers and generally not being very nice
> on the CPU cache etc..

Hmm.  Unless I am mistaken the complexity is O(SwapPages*VMSize)
Which is very bad, but no where near exponentially horrible.
 
> The bulk of the work is walking the process page tables thousands and
> thousands of times. Expensive.

Definitely.  I played following the page tables in a good way a while
back, and even when you do it right the process is slow.  Is 
if (need_resched) {
        schedule();
}
A good idiom to use when you know you have a loop that will take a
long time.  Because even if we do this right we should do our best to
avoid starving other processes in the system 

Hmm.  There is a nasty case with turning the walk inside out.  When we
read a page into RAM there could still be other users of that page
that still refer to the swap entry.  So we cannot immediately remove
the page from the swap cache.  Unless we want to break sharing and
increase the demands upon the virtual memory when we are shrinking
it...  

 
> > If this is going on I think we need to look at our delayed
> > deallocation policy a little more carefully.
> 
> Agreed. I already talked in private with some people about just
> re-visiting the issue of the lazy de-allocation. It has nice properties,
> but it certainly appears as if the nasty cases just plain outweigh the
> advantages.

I'm trying to remember the advantages.  Besides not having to care
that a page is a swap page in free_pte.  If there really is some value
in not handling the pages there (and I seem to recall something about
pages under I/O).  It might at least be worth putting the pages on
their own LRU list.  So that kswapd can cruch through the list
whenever it wakes up and gives a bunch of free pages.

Eric
