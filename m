Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269187AbRHBWUc>; Thu, 2 Aug 2001 18:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269185AbRHBWUW>; Thu, 2 Aug 2001 18:20:22 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:28668 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S269187AbRHBWUJ>; Thu, 2 Aug 2001 18:20:09 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108022218.f72MIm8v028137@webber.adilger.int>
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
In-Reply-To: <20010802204710.B18742@emma1.emma.line.org> "from Matthias Andree
 at Aug 2, 2001 08:47:10 pm"
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Date: Thu, 2 Aug 2001 16:18:48 -0600 (MDT)
CC: Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@bonn-fries.net>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthais Andree writes:
> fsync()ing the dir is not the minimal work possible, if e. g. temporary
> files are open that don't need their names synched. Fsync()ing the
> directory syncs also these temporary file NAMES that other processes may
> have open (but that they unlink rather than fsync()).
> 
> Assume:
> 
> open -> asynchronous, but filename synched on fsync()
> rename/link/unlink(/symlink) -> synchronous
> 
> This way, you never need to fsync() the directory, so you never sync()
> entries of temporary files. You never lose important files (because the
> application uses fsync() and the OS synchs rename/link etc.).

Do you read what you are writing?  How can a "synchronous" operation for
rename/link/unlink/symlink NOT also write out "temporary" files in the
same directory?  How does calling fsync() on the directory IF YOU REQUIRE
SYNCHRONOUS DIRECTORY OPERATIONS differ from making the specific operations
synchronous from within the kernel???

The only difference I can see is that making these specific operations
ALWAYS be synchronous hurts the common case when they can be async (see
Solaris UFS vs. Linux benchmark elsewhere in this thread), while requiring
an fsync() on the directory == only synchronous operation when it is
actually needed, and no "extra" performance hit.

The only slight point of contention is if you have very large directories
which span several filesystem blocks, in which case it _would_ be possible
to write out some blocks synchronously, while leaving other blocks dirty.
In practise however, you will either only be modifying a small number of
blocks (at the end of the directory) because an MTA usually only creates
files and doesn't delete them, and the actual speed of syncing several
blocks at one time is not noticably different than syncing only one.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

