Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbQLaPL5>; Sun, 31 Dec 2000 10:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129588AbQLaPLq>; Sun, 31 Dec 2000 10:11:46 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:11786 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129401AbQLaPLl>; Sun, 31 Dec 2000 10:11:41 -0500
Date: Sun, 31 Dec 2000 15:38:49 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Roman Zippel <zippel@fh-brandenburg.de>,
        "Eric W. Biederman" <ebiederman@uswest.net>,
        Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
Message-ID: <20001231153849.B17728@athlon.random>
In-Reply-To: <Pine.GSO.4.10.10012310241300.8887-100000@zeus.fh-brandenburg.de> <Pine.LNX.4.10.10012301816410.1743-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10012301816410.1743-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Dec 30, 2000 at 06:28:39PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 30, 2000 at 06:28:39PM -0800, Linus Torvalds wrote:
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

get_block for large files can be improved using extents, but how can we
implement a fast get_block without restructuring the on-disk format of the
filesystem? (in turn using another filesystem instead of ext2?)

get_block needs to walk all level of inode metadata indirection if they
exists. It has to map the logical page from its (inode) address space to the
physical blocks. If those indirection blocks aren't in cache it has to block
to read them. It doesn't matter how it is actually implemented in core. And
then later as you say those allocated blocks could never get written because
the file may be deleted in the meantime.

With allocate on flush we can run the slow get_block in parallel
asynchronously using a kernel daemon after the page flushtime timeout
triggers. It looks nicer to me. The in-core overhead of the reserved
blocks for delayed allocation should be not relevant at all (and it also
should not need the big kernel lock making the whole write path big lock
free).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
