Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129911AbRABR3a>; Tue, 2 Jan 2001 12:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130535AbRABR3V>; Tue, 2 Jan 2001 12:29:21 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:43930 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S129967AbRABR3S>; Tue, 2 Jan 2001 12:29:18 -0500
Date: Tue, 2 Jan 2001 17:53:12 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <Pine.GSO.4.21.0101012337320.11870-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.10.10101021242170.6558-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2 Jan 2001, Alexander Viro wrote:

> Depends on a filesystem. Generally you don't want asynchronous operations
> to grab semaphores shared with something else. kswapd knows to skip the locked
> pages, but that's it - if writepage() is going to block on a semaphore you
> will not know what had hit you. And while buffer-cache operations will not
> trigger writepage() (grep for GFP_BUFFER and GFP_IO and you'll see) you have
> no such warranties for other sources of memory pressure. If one of them
> hits while you are holding such semaphore - you are toast.

I just checked that and you're right, sorry for causing confusion and
thanks for clearing this up.

> We probably could pull it off for ext2_truncate() vs. ext2_get_block()
> but it would not do us any good. It would give excessive exclusion for
> operations that can be done in parallel just fine (example: we have
> a hole from 100Kb to 200Kb. Pageouts in that area can be trivially
> done i parallel - current code will not even try to do unrolls. With
> your locking they will be serialized for no good reason). What for?

Let me come back to the three phases I mentioned earlier:
alloc_block: does only a read-only check whether a block needs to be
allocated or not, this can be done in parallel and only needs the page
lock.
get_block: blocks are now really allocated and this needs locking of the
bitmap.
commit_block: write the allocated blocks to the inode and this now would
use an inode specific semaphore to protect the updates of indirect blocks.

The only problem I see is truncate, but if we move the release of unneeded
indirect blocks to file_close, only new indirect blocks can appear while
the file is open, but they won't change anymore, what would make lots of
the checks easier.

bye, Roman

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
