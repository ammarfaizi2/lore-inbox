Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130469AbQLEEBv>; Mon, 4 Dec 2000 23:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130579AbQLEEBm>; Mon, 4 Dec 2000 23:01:42 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:1714 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130469AbQLEEB2>;
	Mon, 4 Dec 2000 23:01:28 -0500
Date: Mon, 4 Dec 2000 22:31:00 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrew Morton <andrewm@uow.edu.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] inode dirty blocks
In-Reply-To: <Pine.LNX.4.10.10012041840240.1904-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0012042211310.7166-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Dec 2000, Linus Torvalds wrote:

> 
> 
> On Tue, 5 Dec 2000, Andrew Morton wrote:
> > 
> > 	- test12-pre4
> > 	- aviro bforget patch 
> 
> Is the bforget patch really needed?
> 
> If clear_inode() gets rid of dirty buffers, I don't see how new dirty
> buffers can magically appear. I may have missed part of the discussion on
> all this.

Well, to start with you don't want random bh's floating around on the
inode's list. With the current code truncate()+fsync() can send a lot
of already freed stuff to disk. Even though we can survive that (making
clear_inode() to get rid of the list will save you from corruption)...
it doesn't look like a good idea.

BTW, in the current form clear_inode() doesn't get rid of the dirty
buffers. It misses the pages that became anonymous and it misses the
metadata that became freed. We can do that, but I'ld rather avoid
leaving these buffer_heads on the inode's list - stuff that got freed
has no business to be accessible from in-core inode.

> I think that the second patch from Al (the inode dirty meta-data) is the
> _real_ fix, and I don't see why the bforget changes should matter.

We can survive without them (modulo patch to clear_inode()), but...
BTW, there is another reason why we want to have separate function
for freeing the stuff: we may want to mark them clean. If they are
already under IO it will do nothing, but if they are merely dirty...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
