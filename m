Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129950AbQLWHWY>; Sat, 23 Dec 2000 02:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130003AbQLWHWO>; Sat, 23 Dec 2000 02:22:14 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:25553 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129950AbQLWHWM>; Sat, 23 Dec 2000 02:22:12 -0500
Message-ID: <3A444CAA.4C5A7A89@uow.edu.au>
Date: Sat, 23 Dec 2000 17:56:42 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@redhat.com>
Subject: Re: Linux 2.2.19pre2
In-Reply-To: <E147MkJ-00036t-00@the-village.bc.nu>, <E147MkJ-00036t-00@the-village.bc.nu>; <20001220142858.A7381@athlon.random> <3A40C8CB.D063E337@uow.edu.au>, <3A40C8CB.D063E337@uow.edu.au>; <20001220162456.G7381@athlon.random> <3A41DDB3.7E38AC7@uow.edu.au>, <3A41DDB3.7E38AC7@uow.edu.au>; <20001221161952.B20843@athlon.random> <3A4303AC.C635F671@uow.edu.au>,
		<3A4303AC.C635F671@uow.edu.au>; from andrewm@uow.edu.au on Fri, Dec 22, 2000 at 06:33:00PM +1100 <20001222141929.A13032@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> [ 2.2 waitqueue stuff ]
>

Andrea, it occurs to me...

__wake_up() is using read_lock(waitqueue_lock).  This means that
two CPUs could simultaneously run __wake_up().  They could both
find the same task and they could both try to wake it up. The
net result would be two wakeup events, but only one task woken
up.  That's a lost wakeup.

Now, it's probably the case that the 2.2 network serialisation
prevents this from happening - I haven't looked.  If not,
then we need to use spin_lock_irqsave.

Alternatively, we can teach wake_up_process to return a success
value if it successfully moved a task onto the runqueue.  Test that
in __wake_up and keep on going if it's zero.

2.4 needs this as well, BTW, to fix an SMP race where a task is on two
waitqueues at the same time.  I did a patch which took the "wake_up_process
returns success value" approach and it felt clean.  I haven't submitted
it due to general end-of-year patch exhaustion :)

If we elect to not address this problem in 2.2 and to rely upon the network
locking then we need to put a BIG FAT warning in the code somewhere, because
if someone else tries to use the new wake-one capability, they may not be
so lucky.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
