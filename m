Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130061AbQL2RlB>; Fri, 29 Dec 2000 12:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131632AbQL2Rkw>; Fri, 29 Dec 2000 12:40:52 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:37200 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130061AbQL2Rkh>; Fri, 29 Dec 2000 12:40:37 -0500
Date: Fri, 29 Dec 2000 18:09:49 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@redhat.com>
Subject: wake-one-3 bug (affected 2.2.19pre3aa[123])
Message-ID: <20001229180949.F12791@athlon.random>
In-Reply-To: <3A41DDB3.7E38AC7@uow.edu.au>; <20001221161952.B20843@athlon.random> <3A4303AC.C635F671@uow.edu.au>, <3A4303AC.C635F671@uow.edu.au>; <20001222141929.A13032@athlon.random> <3A444CAA.4C5A7A89@uow.edu.au>, <3A444CAA.4C5A7A89@uow.edu.au>; <20001223191159.B29450@athlon.random> <3A454205.D33090A8@uow.edu.au> <20001224164009.A8636@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001224164009.A8636@athlon.random>; from andrea@suse.de on Sun, Dec 24, 2000 at 04:40:09PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 24, 2000 at 04:40:09PM +0100, Andrea Arcangeli wrote:
> On Sun, Dec 24, 2000 at 11:23:33AM +1100, Andrew Morton wrote:
> > ack.
> 
> This patch against 2.2.19pre3 should fix all races. (note that wait->flags
> doesn't need to be initialized in the critical section in test1X too)
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.19pre3/wake-one-3
> 
> Comments?

Woops, it had a bug (I overlooked the usage of __add_wait_queue in sleep_on),
the bug was reproduced and fixed by Chris Mason and his fix is obviously right,
see:

--- 2.2.19pre3aa3/kernel/sched.c.~1~	Wed Dec 27 04:49:37 2000
+++ 2.2.19pre3aa3/kernel/sched.c	Fri Dec 29 17:03:09 2000
@@ -1018,6 +1018,7 @@
 
 #define	SLEEP_ON_HEAD					\
 	wait.task = current;				\
+	wait.flags = 0;					\
 	write_lock_irqsave(&waitqueue_lock,flags);	\
 	__add_wait_queue(p, &wait);			\
 	write_unlock(&waitqueue_lock);

New patch (revision n.4) against vanilla 2.2.19pre3 is here:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.19pre3/wake-one-4

Since 2.2.19pre3aa[123] included the wake-one-3 patch they can generate task in
D state blocked in sleep_on* too. So if you're running 2.2.19pre3aa[123] you
should either upgrade to 2.2.19pre3aa4 or to apply the above inlined one liner
on top of 2.2.19pre3aa[123] sources and recompile (just make bzImage again will
be enough).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
