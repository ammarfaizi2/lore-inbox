Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130347AbQK2T47>; Wed, 29 Nov 2000 14:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130833AbQK2T4u>; Wed, 29 Nov 2000 14:56:50 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:12812 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S130347AbQK2T4p>; Wed, 29 Nov 2000 14:56:45 -0500
Date: Wed, 29 Nov 2000 11:25:54 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Andries.Brouwer@cwi.nl, Tigran Aivazian <tigran@veritas.com>,
        linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <Pine.GSO.4.21.0011290351080.14112-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10011291121090.15230-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Nov 2000, Alexander Viro wrote:
> 
> Problem fixed by Jens' patch had been there since March, so if it's a
> mix of __make_request() screwing up and something else... Urgh.

No, the bug really got introduced in test11 due to the request merging
stuff.

The patch may _look_ like it fixed a generic problem that has been there
forever, but we didn't actually need the spinlock for initializing "head"
at all. It's initialized to a constant offset within the unchaning request
queue, so we can happily do it outside the spinlock.

The reason the initialization was moved inside the spinlock was really
just that it had to be re-initialized for the case where we re-did the
merge, so it had to be moved down to inside the loop - and it just happens
to happen inside the spinlock now.

So the spinlock protection was never relevant to the bug - forgetting to
re-initialize a variable when a straight-line code was turned into a loop
was the bug.

> I'ld really like to see details on the box with ext2 corruption on SCSI.
> Tigran, IIRC you had it on SCSI boxen, right? Could you send me relevant
> part of logs?

I suspect that Tigran may have seen other instability (of which we had
lots back when he saw it), and that the current rash is for the IDE
problem only. 

Which is not to say that there might not be SCSI issues or other issues
too, but I'm also not convinced that the SCSI thing might not just be a
red herring at this point.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
