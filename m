Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129983AbQLHXOA>; Fri, 8 Dec 2000 18:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130198AbQLHXNv>; Fri, 8 Dec 2000 18:13:51 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:61701 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129983AbQLHXNf>; Fri, 8 Dec 2000 18:13:35 -0500
Date: Fri, 8 Dec 2000 14:42:51 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: kernel BUG at buffer.c:827 in test12-pre6 and 7 
In-Reply-To: <Pine.GSO.4.21.0012081715330.27010-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10012081437150.31310-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Dec 2000, Alexander Viro wrote:
> 
> I'm quite aware of that fact ;-) However, you said 
> 
>    On the other hand, I have this suspicion that there is an even simpler
>    solution: stop using the end_buffer_io_sync version for writes
>    altogether.
> 
> If that happens (i.e. if write requests resulting from prepare_write()/
> commit_write()/bdflush sequence become async) we must stop unlocking pages
> after commit_write(). Essentially it would become unlocker of the same
> kind as readpage() and writepage() - callers must assume that page submitted
> to commit_write() will eventually be unlocked.

You're right, we can't do that for anonymous buffers right now. Mea culpa.

Looking more at this issue, I suspect that the easiest pretty solution
that everybody can probably agree is reasonable is to either pass down the
end-of-io callback to ll_rw_block as you suggested, or, preferably by just
forcing the _caller_ to do the buffer locking, and just do the b_end_io
stuff inside the buffer lock and get rid of all the races that way
instead (and make ll_rw_block() verify that the buffers it is passed are
always locked).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
