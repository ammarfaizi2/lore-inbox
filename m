Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129458AbQLEUUd>; Tue, 5 Dec 2000 15:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129434AbQLEUUX>; Tue, 5 Dec 2000 15:20:23 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:41997 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129562AbQLEUUI>; Tue, 5 Dec 2000 15:20:08 -0500
Date: Tue, 5 Dec 2000 11:48:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <aviro@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        Alan Cox <alan@redhat.com>, Christoph Rohland <cr@sap.com>,
        Rik van Riel <riel@conectiva.com.br>,
        MOLNAR Ingo <mingo@chiara.elte.hu>
Subject: Re: test12-pre5
In-Reply-To: <Pine.GSO.4.21.0012051337290.12284-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10012051144060.2178-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Dec 2000, Alexander Viro wrote:
> > 
> > Stephen is _wrong_ wrt fsync().
> > 
> > Why?
> > 
> > Think about it for a second. How the hell could you even _call_ fsync() on
> > a file that no longer exists, and has no file handles open to it?
> 		^^^^^^^^^^^^^^
> clear_inode() <- dispose_list() <- prune_icache().

No. prune_icache() will absolutely _refuse_ to prune an inode that is
still in use. Where "in use" is defined to be an aggregate of many things,
including the fact that the inode is dirty (even if there are no actual
references to it any more) _or_ the fact that the inode has cached data
associated with it.

Page cache counts as cached data.

As does dirty buffers.

So clean_inode() is basically always called only for "dead" objects. 

And this is not just a "it happens to be like this" kind of thing. It
_has_ to be like this, because every time we call clear_inode() we are
going to physically free the memory associated with the inode very soon
afterwards. Which means that _any_ use of the inode had better be long
gone. Dirty buffers included.

So it's definitely ok to say that "once we get to clean_inode(), there is
no way in h*ll that dirty buffers can be valid any more". Because either
we have checked that by hand (prune_icache), or we're killing the inode
outright (no more users and the inode has been removed).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
