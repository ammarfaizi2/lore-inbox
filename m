Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131406AbRAAN0Q>; Mon, 1 Jan 2001 08:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131515AbRAAN0G>; Mon, 1 Jan 2001 08:26:06 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:10392 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S131406AbRAANZ4>; Mon, 1 Jan 2001 08:25:56 -0500
Date: Mon, 1 Jan 2001 13:44:09 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <Pine.GSO.4.21.0012312220290.7648-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.10.10101011119240.10093-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 31 Dec 2000, Alexander Viro wrote:

> Reread the original thread. GFP_BUFFER protects us from buffer cache
> allocations triggering pageouts. It has nothing to the deadlock scenario
> that would come from grabbing ->i_sem on pageout.

I don't want to grab i_sem. It was a very, very early idea... :)

> Sheesh... "Complexity" of ext2_get_block() (down to the ext2_new_block()
> calls) is really, really not a problem. Normally it just gives you the
> straightforward path. All unrolls are for contention cases and they
> are precisely what we have to do there.

Maybe complexity is the wrong word, of course the logic in there is
straight forward (once one understood it :) ).
Let me ask it differently and it's now only about indirect block handling.
Is it possible to use a per-inode-indirect-block-semaphore?
The reason for the question is, that I maybe see a different sort of
contention here - live locks. I don't mind that getting of resources and
rechecking if everything went well. The problem is how much resources you
need to get (and to release, if something failed). Somewhere is always a
point, where two threads can't make any progress or one thread can stall
the progress of a second.
To get back to ext2_get_block: IMO such a scenario could happen in the
double or triple indirect block case, when two or more threads try to
allocate/truncate a block here. Maybe my concerns are baseless, but I'd
just like to know, that there isn't a possibility for a DOS attack here.
(BTW that's what I mean with complexity, it's less the logical complexity,
it's more the "runtime complexity").

The other reason for the question is that I'm currently overwork the block
handling in affs, especially the extended block handling, where I'm
implementing a new extended block cache, where I would pretty much prefer
to use a semaphore to protect it. Although I could do it probably without
the semaphore and use a spinlock+rechecking, but it would keep it so much
simpler. (I can post more details about this part on fsdevel if needed /
wanted.)

bye, Roman

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
