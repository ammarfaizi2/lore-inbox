Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbRABFbO>; Tue, 2 Jan 2001 00:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129597AbRABFbF>; Tue, 2 Jan 2001 00:31:05 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:54994 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129595AbRABFa6>;
	Tue, 2 Jan 2001 00:30:58 -0500
Date: Tue, 2 Jan 2001 00:00:21 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Roman Zippel <zippel@fh-brandenburg.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <Pine.GSO.4.10.10101020351500.24795-100000@zeus.fh-brandenburg.de>
Message-ID: <Pine.GSO.4.21.0101012337320.11870-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Jan 2001, Roman Zippel wrote:

> Block allocation is not my problem right now (and even directory handling
> is not that difficult), but I will post somethings about this on fsdevel
> later.
> But one question is still open, I'd really like an answer for:
> Is it possible to use a per-inode-indirect-block-semaphore?

Depends on a filesystem. Generally you don't want asynchronous operations
to grab semaphores shared with something else. kswapd knows to skip the locked
pages, but that's it - if writepage() is going to block on a semaphore you
will not know what had hit you. And while buffer-cache operations will not
trigger writepage() (grep for GFP_BUFFER and GFP_IO and you'll see) you have
no such warranties for other sources of memory pressure. If one of them
hits while you are holding such semaphore - you are toast.

We probably could pull it off for ext2_truncate() vs. ext2_get_block()
but it would not do us any good. It would give excessive exclusion for
operations that can be done in parallel just fine (example: we have
a hole from 100Kb to 200Kb. Pageouts in that area can be trivially
done i parallel - current code will not even try to do unrolls. With
your locking they will be serialized for no good reason). What for?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
