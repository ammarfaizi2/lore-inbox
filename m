Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129763AbQLETY3>; Tue, 5 Dec 2000 14:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129563AbQLETYT>; Tue, 5 Dec 2000 14:24:19 -0500
Received: from zeus.kernel.org ([209.10.41.242]:19984 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129543AbQLETYH>;
	Tue, 5 Dec 2000 14:24:07 -0500
Date: Tue, 5 Dec 2000 18:50:30 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Alexander Viro <viro@math.psu.edu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <aviro@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        Alan Cox <alan@redhat.com>, Christoph Rohland <cr@sap.com>,
        Rik van Riel <riel@conectiva.com.br>,
        MOLNAR Ingo <mingo@chiara.elte.hu>
Subject: Re: test12-pre5
Message-ID: <20001205185030.H10663@redhat.com>
In-Reply-To: <20001205170950.D10663@redhat.com> <Pine.LNX.4.21.0012050930170.18170-100000@dual.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0012050930170.18170-100000@dual.transmeta.com>; from torvalds@transmeta.com on Tue, Dec 05, 2000 at 09:48:51AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 05, 2000 at 09:48:51AM -0800, Linus Torvalds wrote:
> 
> On Tue, 5 Dec 2000, Stephen C. Tweedie wrote:
> > 
> > That is still buggy.  We MUST NOT invalidate the inode buffers unless
> > i_nlink == 0, because otherwise a subsequent open() and fsync() will
> > have forgotten what buffers are dirty, and hence will fail to
> > synchronise properly with the disk.
> 
> Are you all on drugs?
> 
> Look at where clear_inode() is called. It's called by
> ext2_delete_inode(). It's not called by close(). Never has, never will.

It is also called during prune_icache().  Yes, I know that the
CAN_UNUSE() macro should make sure we never try to do this on a
count==0 inode which still has dirty buffers, but I'd feel happier if
we had the safety net to guard against any callers ever doing a
clear_inode while we have dirty buffers around.

We have two completely different paths to clear_inode() here: one in
which there had better not be any dirty buffers or we've got a data
corrupter on our hands, and a second in which dirty buffers are
irrelevant because we're doing a delete.

That's the problem --- doing the invalidate in clear_inode() feels
like the wrong place to do it, because our treatment of the dirty
buffers list differs depending on the caller.  I'd be much happer with
the delete case doing the invalidate, and leave clear_inode BUG()ing
if there are any dirty buffers left, and that's basically what the
test with i_nlink==0 did.

> So I repeat: are there known bugs in this area left in pre5? And with
> "bugs", I don't mean fever-induced rants like the above (*).

No, I don't think so.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
