Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129694AbQKGDQM>; Mon, 6 Nov 2000 22:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129716AbQKGDQE>; Mon, 6 Nov 2000 22:16:04 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:36318 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S129694AbQKGDPk>; Mon, 6 Nov 2000 22:15:40 -0500
From: kumon@flab.fujitsu.co.jp
Date: Tue, 7 Nov 2000 12:15:16 +0900
Message-Id: <200011070315.MAA15183@asami.proc.flab.fujitsu.co.jp>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        "kumon@flab.fujitsu.co.jp" <kumon@flab.fujitsu.co.jp>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: locks.c: removal of semaphores
In-Reply-To: <3A053B05.2AE5D4EB@uow.edu.au>
In-Reply-To: <3A053B05.2AE5D4EB@uow.edu.au>
Reply-To: kumon@flab.fujitsu.co.jp
Cc: kumon@flab.fujitsu.co.jp
X-Mailer: Handmade Mailer version 1.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
I got 5250 Req/s with your locks-sem.patch on normal Apache.
It is good performance on normal Apache.

Andrew Morton writes:
 > Kouichi, could you please test the performance of this on
 > your 8-way with Apache+fcntl serialisation? (the normal
 > Apache).  Please use 2.4.0-test10-pre5, not 2.4.0-test10.
 > Something has gone funny with test10 and I'm getting much
 > lower rates.

Followings are the recent data with/without serialization.

			w/ serialize	w/o serialize
240t10pre5		2237		5358
240t10pre5+P2		5253		5355**
240t10pre5+P3		---		NG
240t10pre5+locksem	5250		---
	**: once we found deadlock
	NG: cannot complete measurement
	--: we've not measured.

Normal apache on various kernel setting as follows:

> test8			5287 <-- best performance
> test10-pre5+P2	5258
> 240t10pre5+locksem	5250
> test9+P2		5243
> test9+mypatch		5192 <-- a little bit worse
> test10-pre5+P1	5187
> test1			3702 <-- no good scalability
> test10-pre5		2255 <-- negative scalability
> test9			2193


We also did durability test of 2.4.0-test10-pre5.  Unfortunately
enough, we didn't successfully complete the test of Apache w/o
serialization (-DSINGLE_LISTEN_UNSERIALIZED_ACCEPT), it couldn't
continue to run for a night.  The kernel got complete deadlock.

The message is:
"Unable to handle kernel NULL pointer dereference NMI watchdog detected LOCKUP on CPU1."

Yes, obviously it's not Andrew's problem, that is genuine test10-pre5.

Hidden bugs are awakened by removing serialization.

If the bug is same as what I observed, It is NULL pointer dereference
on run-queue list.
--
Computer Systems Laboratory, Fujitsu Labs.
kumon@flab.fujitsu.co.jp
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
