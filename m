Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129991AbQLWSnN>; Sat, 23 Dec 2000 13:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130187AbQLWSnD>; Sat, 23 Dec 2000 13:43:03 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:11072 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129991AbQLWSmp>; Sat, 23 Dec 2000 13:42:45 -0500
Date: Sat, 23 Dec 2000 19:11:59 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@redhat.com>
Subject: Re: Linux 2.2.19pre2
Message-ID: <20001223191159.B29450@athlon.random>
In-Reply-To: <3A40C8CB.D063E337@uow.edu.au>, <3A40C8CB.D063E337@uow.edu.au>; <20001220162456.G7381@athlon.random> <3A41DDB3.7E38AC7@uow.edu.au>, <3A41DDB3.7E38AC7@uow.edu.au>; <20001221161952.B20843@athlon.random> <3A4303AC.C635F671@uow.edu.au>, <3A4303AC.C635F671@uow.edu.au>; <20001222141929.A13032@athlon.random> <3A444CAA.4C5A7A89@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A444CAA.4C5A7A89@uow.edu.au>; from andrewm@uow.edu.au on Sat, Dec 23, 2000 at 05:56:42PM +1100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 23, 2000 at 05:56:42PM +1100, Andrew Morton wrote:
> If we elect to not address this problem in 2.2 and to rely upon the network

I see. There are two races:

1)	race inside __wake_up when it's run on the same waitqueue: 2.2.19pre3
	is affected as well as 2.2.18aa2, and 2.4.x is affected
	as well when #defining USE_RW_WAIT_QUEUE_SPINLOCK to 1.
2)	race between two parallel __wake_up running on different waitqueues
	(both 2.2.x and 2.4.x are affected)

1) could be fixed trivially by making the waitqueue_lock a spinlock, but
this way doesn't solve 2). And if we solve 2) properly than 1) gets fixed as
well.

I agree the right fix for 2) (and in turn for 1) ) is to count the number of
exclusive wake_up_process that moves the task in the runqueue, if the task was
just in the runqueue we must not consider it as an exclusive wakeup (so in turn
we'll try again to wakeup the next exclusive-wakeup waiter). This will
fix both races. Since the fix is self contained in __wake_up it's fine
for 2.2.19pre3 as well and we can keep using a read_write lock then.

Those races of course are orthogonal with the issue we discussed previously
in this thread: a task registered in two waitqueues and wanting an exclusive
wakeup from one waitqueue and a wake-all from the other waitqueue (for
addressing that we need to move the wake-one information from the task struct
to the waitqueue_head and I still think that shoudln't be addressed in 2.2.x,
2.2.x is fine with a per-task-struct wake-one information)

Should I take care of the 2.2.x fix, or will you take care of it? I'm not using
the wake-one patch in 2.2.19pre3 because I don't like it (starting from the
useless wmb() in accept) so if you want to take care of 2.2.19pre3 yourself I'd
suggest to apply the wake-one patch against 2.2.19pre3 in my ftp-patch area
first.  Otherwise give me an ack and I'll extend myself my wake-one patch to
ignore the wake_up_process()es that doesn't move the task in the runqueue.

Thanks,
Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
