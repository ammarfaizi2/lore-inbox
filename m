Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131453AbQL3WnO>; Sat, 30 Dec 2000 17:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132870AbQL3WnF>; Sat, 30 Dec 2000 17:43:05 -0500
Received: from slc828.modem.xmission.com ([166.70.6.66]:58630 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S131453AbQL3Wm4>; Sat, 30 Dec 2000 17:42:56 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <Pine.LNX.4.10.10012301214210.1017-100000@penguin.transmeta.com>
From: ebiederman@uswest.net (Eric W. Biederman)
Date: 30 Dec 2000 15:00:43 -0700
In-Reply-To: Linus Torvalds's message of "Sat, 30 Dec 2000 12:21:50 -0800 (PST)"
Message-ID: <m1u27lpo1g.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:


> In short, I don't see _those_ kinds of issues. I do see error reporting as
> a major issue, though. If we need to do proper low-level block allocation
> in order to get correct ENOSPC handling, then the win from doing deferred
> writes is not very big.

To get ENOSPC handling 99% correct all we need to do is decrement a counter,
that remembers how many disks blocks are free.  If we need a better
estimate than just the data blocks it should not be hard to add an
extra callback to the filesystem.  

There look to be some interesting cases to handle when we fill up a
filesystem.  Before actually failing and returning ENOSPC the
filesystem might want to fsync itself. And see how correct it's
estimates were.  But that is the rare case and shouldn't affect
performance.

<rant>
In the long term VFS support for deferred writes looks like a major
win.  Knowing how large a file is before we write it to disk allows
very efficient disk organization, and fast file access (esp combined
with an extent based fs).   Support for compressing files in real time
falls out naturally.  Support for filesystems maintain coherency by
never writing the same block back to the same disk location also
appears.
</rant>

One other thing to think about for the VFS/MM layer is limiting the
total number of dirty pages in the system (to what disk pressure shows
the disk can handle), to keep system performance smooth when swapping.
All cases except mmaped files are easy, and they can be handled by a
modified page fault handler that directly puts the dirty bit on the
struct page.  (Except that is buggy with respect to clearing the dirty
bit on the struct page.)  In reality we would have to create a queue
of pointers to dirty pte's from the page fault handler and depending
on a timer or memory pressure move the dirty bits to the actual page.

Combined with the code to make sync and fsync to work on the page
cache we msync would be obsolete?

Of course the most important part is that when all of that is
working, the VFS/MM layer it would be perfect.  World domination
would be achieved.  For who would be caught using an OS with an
imperfect VFS layer :)

Eric

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
