Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbRAPULI>; Tue, 16 Jan 2001 15:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129593AbRAPULB>; Tue, 16 Jan 2001 15:11:01 -0500
Received: from mail.valinux.com ([198.186.202.175]:59396 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129532AbRAPUKi>;
	Tue, 16 Jan 2001 15:10:38 -0500
To: andrea@suse.de
CC: linux-kernel@vger.kernel.org, alan@redhat.com, aviro@redhat.com
In-Reply-To: <20010116203334.C19265@athlon.random> (message from Andrea
	Arcangeli on Tue, 16 Jan 2001 20:33:34 +0100)
Subject: Re: Locking problem in 2.2.18/19-pre7? (fs/inode.c and fs/dcache.c)
From: tytso@valinux.com
Phone: (781) 391-3464
In-Reply-To: <E14IbPR-0007Ye-00@beefcake.hdqt.valinux.com> <20010116203334.C19265@athlon.random>
Message-Id: <E14IcR5-0008HB-00@beefcake.hdqt.valinux.com>
Date: Tue, 16 Jan 2001 12:10:31 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Tue, 16 Jan 2001 20:33:34 +0100
   From: Andrea Arcangeli <andrea@suse.de>

   > Of course, this is utterly unsafe on an SMP machines, since access to
   > the "block" variable isn't protected at all.  So the first question is

   Wrong, it's obviously protected by the inode_lock. And even if it wasn't
   protected by the inode_lock in 2.2.x inode.c and dcache.c runs globally
   serialized by the BKL (but it is obviously protected regardless of the BKL).

Yes, you're quite right.  The fact that you have to have inode_lock
before you call try_to_free inodes would would protect the "block"
variable.

   > 	static struct semaphore block = MUTEX;
   > 	if (down_trylock(&block)) {
   > 		spin_unlock(&inode_lock);
   > 		down(&block);
   > 		spin_lock(&inode_lock);
   > 	}

   The above is overkill (there's no need to use further atomic API,
   when we can rely on the inode_lock for the locking. It's overcomplex
   and slower. 

Actually, looking at the fast path of down_trylock compared to huge mess
of code that's currently there, I actually suspect that using
down_trylock() would actually be faster, since in the fast path case
there would only two assembly language instructions, whereas the code
that's currently there is (a) much more complicated, and thus harder to
understand, and (b) is many more instructions to execute.  

Sometimes the simplest approach is the best.....

   > (with the appropriate unlocking code at the end of the function).
   > 
   > Next question.... why was this there in the first place?  After all,

   To fix the "inode-max limit reached" faliures that you could reproduce on
   earlier 2.2.x. (the freed inodes was re-used before the task that freed them
   had a chance to allocate them for itself)

Ah, OK.  Well, we're currently tracking down a slow inode leak which is
only happening on SMP machines, especially our mailhubs.  It's gradual,
but if you don't reboot the machine before you run out of inodes, it
will print the "inode-max limit reach" message, and then shortly after
that lock up the entire machine locks up until someone can come in and
hit the Big Red Button.  Monitoring the machine before it locks up, we
noted that the number of inodes in use was continually climbing until
the machine died.  (Yeah, we could put a reboot command into crontab,
but you should only need to do hacks like that on Windows NT machines.
:-)

We're running a reasonably recent 2.2 kernel on our machines, and the
problem is only showing up on SMP machines, so there's *some* kind of
SMP race hiding in the 2.2 inode code....

						- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
