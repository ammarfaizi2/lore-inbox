Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130236AbQJ2TMh>; Sun, 29 Oct 2000 14:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130339AbQJ2TM2>; Sun, 29 Oct 2000 14:12:28 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:39437 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130236AbQJ2TMT>; Sun, 29 Oct 2000 14:12:19 -0500
Date: Sun, 29 Oct 2000 11:12:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Paul Mackerras <paulus@linuxcare.com.au>, linux-kernel@vger.kernel.org
Subject: Re: page->mapping == 0
In-Reply-To: <Pine.GSO.4.21.0010291308260.27484-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10010291100030.18939-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 29 Oct 2000, Alexander Viro wrote:
> 
> One possible way is to access page->mapping _only_ under the page lock
> and in cases when we call ->i_mapping->a_ops->foo check the ->mapping
> before the method call.

I'm leaning towards this for a 2.4.x solution.

As far as I can tell, page->mapping is _already_ only accessed and
modified with the page lock held. It's just that we don't test it for
NULL, in case an earlier lock holder decided to clear it.

(No, I didn't look through all the users, but at least conceptually it
_should_ be true that we only look at "mapping" with the lock held: it's
mainly used for pagein, and pageout, buth with the lock held for other
reasons already. Certainly all the places where we have had bug-reports
have been of this type).

Making it policy that we have to re-test page->mapping after aquireing the
page lock might be the simplest fix for 2.4.x. It still means that we
might end up allowing people to have a "bad" page in the VM space due to
the "test->insert" race condition, but it woul dmake that event pretty
much a harmless bug (and thus move it to the "beauty wart - to be fixed
later" category).

And the places where we get the page lock and use page->mapping are not
that many, I think. 

(And notice how we actually _have_ this approach already in
do_buffer_fdatasync(), for similar reasons - we use the "re-test the
page->buffers" thing there. Of course, there we do it because the clearing
of page->buffers is easier to see, and can happen as a result of memory
pressure, and not just truncate()).

So, for example, in __find_lock_page() we should re-test the mapping after
we aquired the page lock. Which is fairly easy, just add something like

	/* Race: did the mapping go away before we got the page lock? */
	if (page && page->mapping != mapping) {
		page_cache_release(page);
		goto repeat;
	}

to the end of __find_lock_page(). Add similar logic to
do_generic_file_read(), filemap_nopage() and filemap_sync_pte() and
read_cache_page(), and you're pretty much done.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
