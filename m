Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131030AbQLEEgW>; Mon, 4 Dec 2000 23:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131088AbQLEEgN>; Mon, 4 Dec 2000 23:36:13 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:54546 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131030AbQLEEf5>; Mon, 4 Dec 2000 23:35:57 -0500
Date: Mon, 4 Dec 2000 20:00:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <aviro@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        "Stephen C. Tweedie" <sct@redhat.com>, Alan Cox <alan@redhat.com>,
        Christoph Rohland <cr@sap.com>, Rik van Riel <riel@conectiva.com.br>,
        MOLNAR Ingo <mingo@chiara.elte.hu>
Subject: Re: test12-pre5
In-Reply-To: <Pine.GSO.4.21.0012042232220.7166-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10012041955000.860-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Dec 2000, Alexander Viro wrote:
> 
> On Mon, 4 Dec 2000, Linus Torvalds wrote:
> > 
> > Ok, this contains one of the fixes for the dirty inode buffer list (the
> > other fix is pending, simply because I still want to understand why it
> > would be needed at all). Al?
> 
> See previous posting. BTW, -pre5 doesn't do the right thing in clear_inode().
> 
> Scenario: bh of indirect block is busy (whatever reason, flush_dirty_buffers(),
> anything that can bump ->b_count for a while). ext2_truncate() frees the
> thing and does bforget(). bh is left on the inode's list. Woops...

So? Why wouldn't clear_inode() get rid of it?

> The minimal fix would be to make clear_inode() empty the list. IMO it's
> worse than preventing the freed stuff from being on that list...

This _is_ what clear_inode() does in pre5 (and in pre4, for that matter):

	void clear_inode(struct inode *inode)
	{  
	        if (!list_empty(&inode->i_dirty_buffers))
	                invalidate_inode_buffers(inode);

		...

which I find perfectly readable. And should mean that no dirty buffers
should be associated with the inode any more. ext2 calls clear_inode()
from ext2_free_inode(), and as far as I can tell the only thing that can
happen after that is that the inode is still scheduled for write-out
(which explains how the bug you fixed would cause a dirty block to be
attached to the inode _after_ we did a clear_inode() on it).

Or are you thinking of something else?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
