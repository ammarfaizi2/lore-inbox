Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131502AbRABS6L>; Tue, 2 Jan 2001 13:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131199AbRABS6C>; Tue, 2 Jan 2001 13:58:02 -0500
Received: from d185fcbd7.rochester.rr.com ([24.95.203.215]:12550 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S131484AbRABS5r>; Tue, 2 Jan 2001 13:57:47 -0500
Date: Tue, 02 Jan 2001 13:27:06 -0500
From: Chris Mason <mason@suse.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Roman Zippel <zippel@fh-brandenburg.de>
cc: Andrea Arcangeli <andrea@suse.de>,
        "Eric W. Biederman" <ebiederman@uswest.net>,
        Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
Message-ID: <138080000.978460026@tiny>
In-Reply-To: <Pine.LNX.4.10.10012301816410.1743-100000@penguin.transmeta.com>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday, December 30, 2000 06:28:39 PM -0800 Linus Torvalds
<torvalds@transmeta.com> wrote:
 
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
> 
>  - Using "global" access patterns to do a better job of "get_block()", ie
>    taking advantage of issues with journalling etc and deferring the write
>    in order to get a bigger journal.
> 
> The second point is completely different, and THIS is where I think there
> are potentially real advantages. 

Absolutely.  I wrote reiserfs delayed allocation code back in october, and
kind of left it alone until the VM had the callbacks needed to make it
clean (err, less ugly).  I included bunches of optimizations to
reiserfs_get_block, and the most effective one was a cache of block
pointers in the inode to avoid consecutive tree searches.  This was a
locking and an i/o win, for both reading and writing (reiserfs needs this
more than ext2 does)

For growing the file, delayed allocation was a huge bonus.  For all the
reasons you've already discussed, and because writing a file went from this:
 
(reiserfs_get_block is starting/stopping the transaction)
while(bytes_to_write) 
	start_transaction
	allocate block
	insert block pointer
	end_transaction
end

To this:

while(bytes_to_write)
	update counters
end

(delayed alloc routine is starting/stopping trans)
start_transaction
allocate X blocks
insert X block pointers
update counters
end_transaction

A big fat transaction is a happy one ;-)

Anyway, I'll return to the optimizations once things have settled down a
bit, and might give the generic delayed allocation (instead of reiserfs
only code) a try.

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
