Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315928AbSIEAVN>; Wed, 4 Sep 2002 20:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315946AbSIEAVM>; Wed, 4 Sep 2002 20:21:12 -0400
Received: from [195.223.140.120] ([195.223.140.120]:8234 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315928AbSIEAVL>; Wed, 4 Sep 2002 20:21:11 -0400
Date: Thu, 5 Sep 2002 02:25:37 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.20pre5aa1
Message-ID: <20020905002537.GE1238@dualathlon.random>
References: <20020904233528.GA1238@dualathlon.random> <3D769D99.CF054558@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D769D99.CF054558@zip.com.au>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2002 at 04:56:09PM -0700, Andrew Morton wrote:
> That's the right thing to do I guess.  Is this a problem in practice?

I hit this issue with one of the testcases of the libaio, the 10.p, it
still fails on a 1024 blocksize filesystem, while it works fine on a 4k
fs of course (as you could see from the previous email). While
investigating I noticed we didn't update i_size there, but it doesn't
fix the problem. Anyways it's a minor issue, and there's no fs
corruption and it's not specific to aio.

The problem with the 10.p is that after the file fills the disk and the
write returns -ENOSPC, an ftruncate(0) won't be enough to allow further
writes (no matter if it's an async write or not) . The next write on the
same inode will return -ENOSPC too regardless if the i_size is zero and
the df returns 100% disk free. So such place is involved with the
problem, I verified the reason the async write post-trunate fails is
because the prepare_write returns -ENOSPEC, the async-io layer is
completely fine. After killing the task the problem goes away
automatically and the next run of 10.p works fine again until the
-ENOSPC + ftruncate(0).  I was able to reproduce it also w/o async-io.
As said this isn't completely solved but it looks very low prio. In any
case no problem can happen on 4k softblocksize.

> If prepare_write() fails, generic_file_write() will truncate back to
> the current i_size?

Good point, so yes it shouldn't be needed and infact it doesn't make
differences, as said above the problem of the 10.p can still happen on a
1024 softblocksize despite my updates to the i_size. Now I wonder if the
vmtruncate there is involved.  I feel like dropping the vmtruncate there
and lefting my i_size_write in the prepare_write could fix it, but I'm
unsure. I still don't see exactly where the post-truncate problem cames
from.

> > Only in 2.4.20pre5aa1: 9920_kgdb-1.gz
> > 
> >         kgdb from akpm.
> 
> Life in the fast lane ;)  Kudos to Amit Kale.

btw, I'm not enabling the frame pointer, I use gcc 3.2 so I want to use
the dwarf2 information in the vmlinux binary, and the dwarf2 resolver
inside gdb on the client side to provide reliable stack traces. I'm not
sure if that works yet, the dwarf2 part is still untested but that's the
long term plan. Next would be to make it working via netconsole so I
don't need to wire cables to many boxes, the only problem with that is
that netconsole isn't a two way communication link but like it polls for
transmits it could poll for receives too.

BTW, while merging aio from 2.5 to 2.4 and fixing and porting the libaio
(in particular thanks to one of Ben's testcases that was checkin for
this specific case) I found this bug in 2.5, I'd suggest to apply it to
mainline (CC'ed Linus):

--- aio-2.5/fs/aio.c.~1~	Tue Aug 27 22:09:49 2002
+++ aio-2.5/fs/aio.c	Thu Sep  5 02:20:30 2002
@@ -992,7 +992,7 @@ asmlinkage long sys_io_submit(aio_contex
 			break;
 		}
 
-		if (unlikely(__copy_from_user(&tmp, user_iocb, sizeof(tmp)))) {
+		if (unlikely(copy_from_user(&tmp, user_iocb, sizeof(tmp)))) {
 			ret = -EFAULT;
 			break;
 		}

Andrea
