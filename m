Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLEU5K>; Tue, 5 Dec 2000 15:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbQLEU5A>; Tue, 5 Dec 2000 15:57:00 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:21470 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129257AbQLEU4y>;
	Tue, 5 Dec 2000 15:56:54 -0500
Date: Tue, 5 Dec 2000 15:17:07 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <aviro@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        Alan Cox <alan@redhat.com>, Christoph Rohland <cr@sap.com>,
        Rik van Riel <riel@conectiva.com.br>,
        MOLNAR Ingo <mingo@chiara.elte.hu>
Subject: Re: test12-pre5
In-Reply-To: <Pine.LNX.4.10.10012051144060.2178-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0012051502140.12284-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Dec 2000, Linus Torvalds wrote:

> And this is not just a "it happens to be like this" kind of thing. It
> _has_ to be like this, because every time we call clear_inode() we are
> going to physically free the memory associated with the inode very soon
> afterwards. Which means that _any_ use of the inode had better be long
> gone. Dirty buffers included.

Urgh. Linus, AFAICS we _all_ agree on that. The only real question is
whether we consider calling clear_inode() with droppable dirty buffers
to be OK. It can't happen on the dispose_list() path and I'ld rather
see it _not_ happening on the delete_inode() one. It's a policy question,
not the correctness one.

IOW, I would prefer to have BUG() instead of invalidate_inode_buffers()
and let the ->delete_inode() make sure that list is empty. I'm not saying
that current code doesn't work. However, "let's clean after the
truncate_inode_page()/foo_delete_inode(), they might leave some junk
on the list" looks like a wrong thing.

Notice that policy wrt pages is already of that kind - clear_inode()
expects the callers to make sure that ->i_data.nr_pages is zero instead of
trying to clean after them. I think that we will be better off with
similar rules wrt dirty buffers list.

Comments?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
