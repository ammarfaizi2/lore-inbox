Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291784AbSBHUOJ>; Fri, 8 Feb 2002 15:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291782AbSBHUN7>; Fri, 8 Feb 2002 15:13:59 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:31376 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S291787AbSBHUNq>; Fri, 8 Feb 2002 15:13:46 -0500
Message-Id: <5.1.0.14.2.20020208174632.00b0dad0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 08 Feb 2002 20:14:32 +0000
To: nigel@nrg.org
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [RFC] New locking primitive for 2.5
Cc: Christoph Hellwig <hch@ns.caldera.de>, Ingo Molnar <mingo@elte.hu>,
        yodaiken <yodaiken@fsmlabs.com>, Martin Wirth <Martin.Wirth@dlr.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, akpm <akpm@zip.com.au>,
        torvalds <torvalds@transmet.com>, rml <rml@tech9.net>
In-Reply-To: <Pine.LNX.4.40.0202080838230.3883-100000@cosmic.nrg.org>
In-Reply-To: <200202081231.g18CV7e31341@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 16:51 08/02/02, Nigel Gamble wrote:
> > No.  i_sem should be split into a spinlock for short-time accessed
> > fields that get written to even if the file content is only read (i.e.
> > atime) and a read-write semaphore.
>
>Read-write semaphores should never be used.  As others have pointed out,
>they cause really intractable priority inversion problems (because a
>high priority writer will often have to wait for an unbounded number of
>lower priority readers, some of which may have called a blocking
>function while holding the read lock).
>
>Note that I'm not talking about read-write spinlocks, which are (or
>should be) held for a short, bounded time and can't be held over a
>blocking call, so they are not quite so problematic.

Read-write semaphores have their use and the current Linux implementation 
(big reader/occasional writer) guarantees that the writer is not starved as 
incoming read locks are put to sleep as soon as a write lock request comes 
in, even if that is sleeping waiting for the old readlocks to be released 
(unless the readers are holding the semaphore forever in which case this is 
the programmers fault and not the rw semaphore implementations fault). [I 
should add I only am familliar with the i386 implementation but I assume 
the others are the same.]

The value of allowing multiple cpus to read the same data simultaneously by 
far offsets the priority problems IMVHO. At least the way I am using rw 
semaphores in ntfs it is. Readlocks are grabbed loads and loads of times to 
serialize meta data access in the page cache while writelocks are a minute 
number in comparison and because the data required to be accessed may not 
be cached in memory (page cache page is not read in, is swapped out, 
whatever) a disk access may be required which means a rw spin lock is no 
good. In fact ntfs would be the perfect candidate for automatic rw combi 
locks where the locking switches from spinning to sleeping if the code path 
reaches a disk access. I can't use a manually controlled lock as the page 
cache lookups are done via the mm/filemap.c access functions which are the 
only ones who can know if a disk access is required or not so ntfs would 
never know if it is going to sleep or not so unless the locks had 
autodetection of whether to spin or sleep they would be useless.

I guess the point I am trying to make is that both rw semaphores and combi 
locks are not bad per se but, as all other locking mechanisms, they should 
be used in situations appropriate for their locktype and their 
implementation...

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

