Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129675AbQKBLJm>; Thu, 2 Nov 2000 06:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129734AbQKBLJe>; Thu, 2 Nov 2000 06:09:34 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:26623 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S129675AbQKBLJV>; Thu, 2 Nov 2000 06:09:21 -0500
From: kumon@flab.fujitsu.co.jp
Date: Thu, 2 Nov 2000 20:09:07 +0900
Message-Id: <200011021109.UAA24021@asami.proc.flab.fujitsu.co.jp>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: kumon@flab.fujitsu.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Negative scalability by removal of lock_kernel()?(Was: 
 Strange performance behavior of 2.4.0-test9)
In-Reply-To: <39FEE701.CAC21AE5@uow.edu.au>
In-Reply-To: <39F957BC.4289FF10@uow.edu.au>
	<39F92187.A7621A09@timpanogas.org>
	<Pine.GSO.4.21.0010270257550.18660-100000@weyl.math.psu.edu>
	<20001027094613.A18382@gruyere.muc.suse.de>
	<200010271257.VAA24374@asami.proc.flab.fujitsu.co.jp>
	<39FEE701.CAC21AE5@uow.edu.au>
Reply-To: kumon@flab.fujitsu.co.jp
Cc: kumon@flab.fujitsu.co.jp
X-Mailer: Handmade Mailer version 1.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > This patch is a moderate rewrite of __wake_up_common.  I'd be
 > interested in seeing how much difference it makes to the
 > performance of Apache when the file-locking serialisation is
 > disabled.
 > - It implements last-in/first-out semantics for waking
 >   TASK_EXCLUSIVE tasks.
 > - It fixes what was surely a bug wherein __wake_up_common
 >   scans the entire wait queue even when it has found the
 >   task which it wants to run.

We've measured Apache w/ and w/o serialize_accept on
several kernel configurations.

Apache compilation settings are those two:
	* without option (conventional setting)
	  (w/ serialize)
	* with -DSINGLE_LISTEN_UNSERIALIZED_ACCEPT
	  (w/o serialize)

We compared the performance of distributed binary and our binary with
default setting, the performance is almost equivalent. All following
data are based on our binaries.

			w/ serialize	w/o serialize
2.40-t10-pre5		2237		5358
2.40-t10-pre5+P2	5253		5355**
2.40-t10-pre5+P3	---		NG

** with this configuration, once we observed the machine completely
deadlocked with the following message:

Unable to handle kernel NULL pointer dereferenceNMI watchdog detected LOCKUP on CPU1.

Actually, the NMI message followed few seconds after the NULL
dereference message.
The virtual address nor eip are not displayed.

 > It's stable, but it's a work-in-progress.
 > - __wake_up_common does a fair amount of SMP-specific
 >   stuff when compiled for UP which needs sorting out
 > - it seems there's somebody in the networking code who
 >   changes a task state incorrectly when it's on a wait
 >   queue. This used to be OK, but it's not OK now that
 >   I'm relying upon the wait queue being in the state
 >   which it should be.

Your last patch makes the problem very clear.

2.4.0-test10-pre5 with the LIFO patch (P3), we can't get the values.
It always deadlock with same manner.  Perhaps, it failed to get
console lock then deadlock.

What we can now is combining several printk's in the null-pointer
dereference message into one printk and make it display much usefull
data.

--
Computer Systems Laboratory, Fujitsu Labs.
kumon@flab.fujitsu.co.jp
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
