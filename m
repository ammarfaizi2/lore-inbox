Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129685AbQLESVm>; Tue, 5 Dec 2000 13:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129518AbQLESVV>; Tue, 5 Dec 2000 13:21:21 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:34823 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129458AbQLESVM>; Tue, 5 Dec 2000 13:21:12 -0500
Date: Tue, 5 Dec 2000 09:48:51 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Alexander Viro <viro@math.psu.edu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <aviro@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        Alan Cox <alan@redhat.com>, Christoph Rohland <cr@sap.com>,
        Rik van Riel <riel@conectiva.com.br>,
        MOLNAR Ingo <mingo@chiara.elte.hu>
Subject: Re: test12-pre5
In-Reply-To: <20001205170950.D10663@redhat.com>
Message-ID: <Pine.LNX.4.21.0012050930170.18170-100000@dual.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Dec 2000, Stephen C. Tweedie wrote:
> 
> On Mon, Dec 04, 2000 at 08:00:03PM -0800, Linus Torvalds wrote:
> > 
> > On Mon, 4 Dec 2000, Alexander Viro wrote:
> > > 
> > This _is_ what clear_inode() does in pre5 (and in pre4, for that matter):
> > 
> > 	void clear_inode(struct inode *inode)
> > 	{  
> > 	        if (!list_empty(&inode->i_dirty_buffers))
> > 	                invalidate_inode_buffers(inode);
> 
> That is still buggy.  We MUST NOT invalidate the inode buffers unless
> i_nlink == 0, because otherwise a subsequent open() and fsync() will
> have forgotten what buffers are dirty, and hence will fail to
> synchronise properly with the disk.

Are you all on drugs?

Look at where clear_inode() is called. It's called by
ext2_delete_inode(). It's not called by close(). Never has, never will.

clear_inode() _destroys_ the inode. WE HAVE TO GET RID OF BUFFERS at that
point. Because there won't be anything left to index to. We're going to
free the memory in RAM held by the inode. Blathering on about
"i_nlink" etc is a complete and utter waste of time, because even if nlink
is a million, there's no way we could leave the buffers indexed on the
inode. We _will_ call destroy_inode() soon afterwards.

The thing that protects the inode while it is still truly in use, is the
CAN_UNUSE() macro, which explicitly tests that the inode is not used by
anybody and has no dirty pages. If that macro doesn't work, then we have a
damn more serious problem than nlink to worry about.

Get your acts together, guys. Stop blathering and frothing at the mouth.
The only time clear_inode() should be called is (a) when we prune the
inode cache - and we CLEARLY cannot prune an inode if it still has dirty
blocks associated with it and CAN_UNUSE() already enforces this or (b)
when we're getting rid of the very last occurrence of the inode. In one
case the dirty list is already empty. In the other, invalidating it is
clearly the right thing and the _required_ thing to do.

So I repeat: are there known bugs in this area left in pre5? And with
"bugs", I don't mean fever-induced rants like the above (*).

I don't see any. Andrew cannot re-create any. But I won't rest easy until
people agree that the code is ok as-is. After that I can consider applying
optimizations, because right now my personal conviction is that the
patches from Al are cleanups and optimizations, but _not_ bug-fixes. And
they will absolutely not get applied before there is some consensus on
these issues.

		Linus

(*) And yes, you can smack me on the head for that outburst if it turns
out that I just didn't see anything. I'll apologize. But right now I'm
irritated.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
