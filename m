Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbQLaTDn>; Sun, 31 Dec 2000 14:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130352AbQLaTDd>; Sun, 31 Dec 2000 14:03:33 -0500
Received: from hermes.mixx.net ([212.84.196.2]:55813 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129370AbQLaTDO>;
	Sun, 31 Dec 2000 14:03:14 -0500
Message-ID: <3A4F7B45.C8313E8A@innominate.de>
Date: Sun, 31 Dec 2000 19:30:29 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <Pine.GSO.4.10.10012310241300.8887-100000@zeus.fh-brandenburg.de> <Pine.LNX.4.10.10012301816410.1743-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> There are only two real advantages to deferred writing:
> 
>  - not having to do get_block() at all for temp-files, as we never have to
>    do the allocation if we end up removing the file.
> 
>    NOTE NOTE NOTE! The overhead for trying to get ENOSPC and quota errors
>    right is quite possibly big enough that this advantage is possibly very
>    questionable.  It's very possible that people could speed things up
>    using this approach, but I also suspect that it is equally (if not
>    more) possible to speed things up by just making sure that the
>    low-level FS has a fast get_block().

It's not that hard or inefficient to return the ENOSPC from the usual
point.  For example, make a gross overestimate of the space needed for
the write, compare to a cached filesystem free space value less the
amount deferred so far, and fail to take the optimization if it looks
even close.  Also, it's not necessarily bad to defer the ENOSPC to file
close time.  The same thing can happen with failed disk io, and that's
just a fact of life with asynchronous io.  A reliable program needs to
be able to deal with it.  (I think there was a long thread on this not
long ago, regarding filesystem errors returned after a program exits.)

>  - Using "global" access patterns to do a better job of "get_block()", ie
>    taking advantage of issues with journalling etc and deferring the write
>    in order to get a bigger journal.

Another nicety is not having to bother the filesystem at all about
sequences of short writes.

> The second point is completely different, and THIS is where I think there
> are potentially real advantages. However, I also think that this is not
> actually about deferred writes at all: it's really a question of the
> filesystem having access to the page when the physical write is actually
> started so that the filesystem might choose to _change_ the allocation it
> did - it might have allocated a backing store block at "get_block()" time,
> but by the time it actually writes the stuff out to disk it may have
> allocated a bigger contiguous area somewhere else for the data..

You'd most likely be able to measure the overhead under load of doing
the allocation twice, due to the occasional need to read back a
swapped-out metadata block.

XFS does deferred allocation and the Reiser guys are talking about it -
it seems to be something worth doing.  For me the question is, if the
VFS can already do the deferring, is there a good reason for a
filesystem to duplicate that functionality?

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
