Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278080AbRJPDpD>; Mon, 15 Oct 2001 23:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278081AbRJPDoy>; Mon, 15 Oct 2001 23:44:54 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:12417 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278080AbRJPDoo>;
	Mon, 15 Oct 2001 23:44:44 -0400
Date: Mon, 15 Oct 2001 23:45:16 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] large /proc/mounts and friends
In-Reply-To: <Pine.LNX.4.33.0110151936580.4179-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0110152308440.11608-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Oct 2001, Linus Torvalds wrote:

> 
> If you have a character sequence number, that means that you _always_ have
> to re-generate the whole file up to the new read-point. That simply does
> not scale. Sure, it works well enough when the user usually reads the
> whole file, but it's still a silly design.

I don't.  ->f_pos is an entry number.  That's it.
 
> Can it get confused when people insert/remove entries at the same time we
> read /proc? Sure. That's pretty much unavoidable with the /proc interface,
> as we can't hold any locks across user-mode system calls. But using a
> structured approach may make it _much_ more likely that the user doesn't
> get data where a entry is cut off in the middle, though - especially if
> you make the read routine be eager to return partial reads rather than
> cutting things off in the middle..

If seq_read() returns a partial entry, it still has its tail in m->buf.
Unless you lseek() away, next call will read from that buffer before
doing anything else.
 
> (In other words: with a structured approach you can make guarantees about
> the stability of each entry - you just can't necessarily guarantee that
> all entries are shown or that some entries might not be duplicated..)

Already done.

> Final note: another _extremely_ useful thing for performance is to have a
> special "EOF" value for f_pos, because all normal applications end up
> having to always do at least two reads: first to get the data (usually
> the user buffer is larger than the amounf of data generated), the second
> to just get the "0" for EOF. If the second read can be done without any
> data generation or lock handling, that often speeds up /proc accesses by
> a noticeable amount.

Umm... That makes sense and it's easy to do.

I suspect that you had misinterpreted the way seq_file.c works.  Actually
it's a fairly simply datagram->byte-stream buffering.  I _don't_ regenerate
the whole file on each read().  Walk the sequence - sure, but that's it.
Algorithm looks so:

	if buffer is non-empty
		read from it
	if we are done - exit
	/* buffer is empty now */
repeat:
	get Nth entry and try to print it into buffer
	if it doesn't exist or an error had happened - exit
	if it didn't fit into buffer - expand and repeat
	/* now we have one record in buffer */
	while we have less than user asked
		get next entry and try to print into buffer
		if there is none or error had happened - exit
		if it doesn't fit into buffer - end the loop
	copy data to user, possibly leaving the tail of last entry in buffer

That's it. ->f_pos is advanced when we cross the record boundary.  Yes, it
means that positions within a record are indistinguishable.  But think what
can be done with them - we can't do any meaningful arithmetics on them
anyway, so the only things that make sense is "where are we now" and
"return where we had been".  Both of them don't have resolution better
than a record.

IOW, I don't see the point in giving sub-record resolution.  It can be
done - I can easily fit that into mechanism above, but I don't see
what would we win from that.

Notice that we always preserve integrity of record - if read() had grabbed
a part of it, the next one is guaranteed to pick the rest. No "but it's
gone, we don't know where to pick that tail" business and certainly no
"here's a tail of something" crap inherent to ->read_proc() use.

Comments?  All this stuff is bog-standard buffering, nothing fancy...

