Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130231AbQLESpY>; Tue, 5 Dec 2000 13:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130229AbQLESpO>; Tue, 5 Dec 2000 13:45:14 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:13443 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130228AbQLESpM>;
	Tue, 5 Dec 2000 13:45:12 -0500
Date: Tue, 5 Dec 2000 13:14:22 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <aviro@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        Alan Cox <alan@redhat.com>, Christoph Rohland <cr@sap.com>,
        Rik van Riel <riel@conectiva.com.br>,
        MOLNAR Ingo <mingo@chiara.elte.hu>
Subject: Re: test12-pre5
In-Reply-To: <Pine.LNX.4.21.0012050930170.18170-100000@dual.transmeta.com>
Message-ID: <Pine.GSO.4.21.0012051256470.12284-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Dec 2000, Linus Torvalds wrote:

> Get your acts together, guys. Stop blathering and frothing at the mouth.
> The only time clear_inode() should be called is (a) when we prune the
> inode cache - and we CLEARLY cannot prune an inode if it still has dirty
> blocks associated with it and CAN_UNUSE() already enforces this or (b)
> when we're getting rid of the very last occurrence of the inode. In one
> case the dirty list is already empty. In the other, invalidating it is
> clearly the right thing and the _required_ thing to do.


Sigh. OK, let me put it that way:

	* we _can_ have dirty blocks on the list when inode gets freed.
	* no, CAN_UNUSE will not see them.
	* no, we do not give a damn about forgetting them.

So Stephen is right wrt fsync() (it will not get that stuff on disk).
However, it's not a bug - if that crap will not end up on disk we
will only win.

However, I think that things would be cleaner if we wouldn't have that
call in clear_inode(). Why? Because filesystems that had ordered writing
the blocks would better tell us when they are no longer interested in it.
It does not matter for the current code. It may matter a lot for any
fs that does write ordering of any kind.

IOW, while with the current tree invalidate_inode_buffers() is not a band-aid
(just a bad misnomer) it may easily become such.

> So I repeat: are there known bugs in this area left in pre5?

AFAIK, none. I _really_ don't like the way we handle that stuff now (at
the very least let's rename the bloody thing - it doesn't invalidate
anything), but as far as I can see the code is technically correct.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
