Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264142AbRFFUsW>; Wed, 6 Jun 2001 16:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264141AbRFFUsN>; Wed, 6 Jun 2001 16:48:13 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:17 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264142AbRFFUsB>; Wed, 6 Jun 2001 16:48:01 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Break 2.4 VM in five easy steps
Date: 6 Jun 2001 13:47:35 -0700
Organization: A poorly-installed InterNetNews site
Message-ID: <9fm4t7$412$1@penguin.transmeta.com>
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3B1D5ADE.7FA50CD0@illusionary.com>,
Derek Glidden  <dglidden@illusionary.com> wrote:
>
>After reading the messages to this list for the last couple of weeks and
>playing around on my machine, I'm convinced that the VM system in 2.4 is
>still severely broken.  

Now, this may well be true, but what you actually demonstrated is that
"swapoff()" is extremely (and I mean _EXTREMELY_) inefficient, to the
point that it can certainly be called broken.

It got worse in 2.4.x not so much due to any generic VM worseness, as
due to the fact that the much more persistent swap cache behaviour in
2.4.x just exposes the fundamental inefficiencies of "swapoff()" more
clearly.  I don't think the swapoff() algorithm itself has changed, it's
just that the algorithm was always exponential, I think (and because of
the persistent swap cache, the "n" in the algorithm became much bigger). 

So this is really a separate problem from the general VM balancing
issues. Go and look at the "try_to_unuse()" logic, and wince. 

I'd love to have somebody look a bit more at swap-off.  It may well be,
for example, that swap-off does not correctly notice dead swap-pages at
all - somebody should verify that it doesn't try to read in and
"try_to_unuse()" dead swap entries.  That would make the inefficiency
show up even more clearly. 

(Quick look gives the following: right now try_to_unuse() in
mm/swapfile.c does something like

                lock_page(page);
                if (PageSwapCache(page))
                        delete_from_swap_cache_nolock(page);
                UnlockPage(page);
                read_lock(&tasklist_lock);
                for_each_task(p)
                        unuse_process(p->mm, entry, page);
                read_unlock(&tasklist_lock);
                shmem_unuse(entry, page);
                /* Now get rid of the extra reference to the temporary
                   page we've been using. */
                page_cache_release(page);

and we should trivially notice that if the page count is 1, it cannot be
mapped in any process, so we should maybe add something like

                lock_page(page);
                if (PageSwapCache(page))
                        delete_from_swap_cache_nolock(page);
                UnlockPage(page);
+		if (page_count(page) == 1)
+			goto nothing_to_do;
                read_lock(&tasklist_lock);
                for_each_task(p)
                        unuse_process(p->mm, entry, page);
                read_unlock(&tasklist_lock);
                shmem_unuse(entry, page);
+
+	nothing_to_do:
+
                /* Now get rid of the extra reference to the temporary
                   page we've been using. */
                page_cache_release(page);


which should (assuming I got the page count thing right - I'v eobviously
not tested the above change) make sure that we don't spend tons of time
on dead swap pages. 

Somebody interested in trying the above add? And looking for other more
obvious bandaid fixes.  It won't "fix" swapoff per se, but it might make
it bearable and bring it to the 2.2.x levels. 

The _real_ fix is to really make "swapoff()" work the other way around -
go through each process and look for swap entries in the page tables
_first_, and bring all entries for that device in sanely, and after
everything is brought in just drop all the swap cache pages for that
device. 

The current swapoff() thing is really a quick hack that has lived on
since early 1992 with quick hacks to make it work with the big VM
changes that have happened since. 

That would make swapoff be O(n) in VM size (and you can easily do some
further micro-optimizations at that time by avoiding shared mappings
with backing store and other things that cannot have swap info involved)

Is anybody interested in making "swapoff()" better? Please speak up..

		Linus
