Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262168AbRFDAGT>; Sun, 3 Jun 2001 20:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263827AbRFCXzP>; Sun, 3 Jun 2001 19:55:15 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:25353 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263814AbRFCXdI>; Sun, 3 Jun 2001 19:33:08 -0400
Date: Sun, 3 Jun 2001 16:32:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Rik van Riel <riel@conectiva.com.br>, Andrea Arcangeli <andrea@suse.de>,
        Ben LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.5
In-Reply-To: <Pine.LNX.4.21.0105270318490.4096-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0106031618100.32451-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Back from Japan - don't start sending me tons of emails yet, as you can
  see I'm only picking up last weeks discussion where it ended right
  now.. ]

On Sat-Sun, 26-27 May 2001, Marcelo Tosatti wrote:
> 
> You are not going to fix the problem by _only_ doing this bh allocation
> change.

I would obviously not disagree with that statement. There are multiple
users of the low-memory zone, and they are all likely to have some of the
same problems. 

> Even if some bh allocators _can_ block on IO, there is no guarantee that
> they are going to free low memory --- they may start more IO on highmem
> pages.

Now, this was actually something I already referred to earlier in this
same thread, see one of myt first mails about this:

Fri, 25 May 2001 21:22:05 Linus Torvalds wrote:
>>
>> For example, we used to have logic in swapout_process to _not_ swap
>> out zones that don't need it. We changed swapout to happen in
>> "page_launder()", but that logic got lost. It's entirely possible that
>> we should just say "don't bother writing out dirty pages that are in
>> zones that have no memory pressure", so that we don't use up pages
>> from the _precious_ zones to free pages in zones that don't need
>> freeing.

So note how there are multiple facets to this problem.


Marcelo goes on to write:
> 
> I've just tried something similar to the attached patch, which is a "more
> aggressive" version of your suggestion to use SLAB_KERNEL for bh
> allocations when possible. This one makes all bh allocators block on IO. 

The patch looks fine. Has anybody else tried it?

Along with, for example, something like this [warning: whitespace damage,
I just cut-and-pasted this as a test-patch], we might actually _fix_ the
problem:

--- v2.4.5/linux/mm/vmscan.c    Fri May 25 18:28:55 2001
+++ linux/mm/vmscan.c   Sun Jun  3 16:26:20 2001
@@ -463,6 +463,7 @@
 
                /* Page is or was in use?  Move it to the active list. */
                if (PageReferenced(page) || page->age > 0 ||
+                               page->zone->free_pages > page->zone->pages_max ||
                                (!page->buffers && page_count(page) > 1) ||
                                page_ramdisk(page)) {
                        del_page_from_inactive_dirty_list(page);

What the above does is fairly obvious: it considers all pages in zones
that don't need to be free'd to be "young", and doesn't even try to write
them out. Because we have absolutely no reason to do so.

This is similar to what we used to do in "try_to_swap_out()" before, and
it still makes sense.

		Linus

