Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130889AbQKBMuf>; Thu, 2 Nov 2000 07:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131462AbQKBMuZ>; Thu, 2 Nov 2000 07:50:25 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:57227 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S130889AbQKBMuS>; Thu, 2 Nov 2000 07:50:18 -0500
From: kumon@flab.fujitsu.co.jp
Date: Thu, 2 Nov 2000 21:50:08 +0900
Message-Id: <200011021250.VAA24349@asami.proc.flab.fujitsu.co.jp>
To: kumon@flab.fujitsu.co.jp
Cc: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Negative scalability by removal of lock_kernel()?(Was: 
 Strange performance behavior of 2.4.0-test9)
In-Reply-To: <200011021109.UAA24021@asami.proc.flab.fujitsu.co.jp>
In-Reply-To: <39F957BC.4289FF10@uow.edu.au>
	<39F92187.A7621A09@timpanogas.org>
	<Pine.GSO.4.21.0010270257550.18660-100000@weyl.math.psu.edu>
	<20001027094613.A18382@gruyere.muc.suse.de>
	<200010271257.VAA24374@asami.proc.flab.fujitsu.co.jp>
	<39FEE701.CAC21AE5@uow.edu.au>
	<200011021109.UAA24021@asami.proc.flab.fujitsu.co.jp>
Reply-To: kumon@flab.fujitsu.co.jp
Cc: kumon@flab.fujitsu.co.jp
X-Mailer: Handmade Mailer version 1.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kumon@flab.fujitsu.co.jp writes:
 > Your last patch makes the problem very clear.
 > 
 > 2.4.0-test10-pre5 with the LIFO patch (P3), we can't get the values.

It dies at the following line in kernel/sched.c:schedule() 

move_rr_back:

	switch (prev->state & ~TASK_EXCLUSIVE) {
		case TASK_INTERRUPTIBLE:
			if (signal_pending(prev)) {
				prev->state = TASK_RUNNING;
				break;
			}
		default:
here==>			del_from_runqueue(prev);
		case TASK_RUNNING:
	}


"prev" contains a run_list structure and prev->run_list.next pointed
to NULL.  This caused the bus-error in __list_del().

# actually the CPU accesses address 0x4 (4 is offset to prev within
# run_list).

BTW, why this switch statement has less breaks at everywhere.

--
Computer Systems Laboratory, Fujitsu Labs.
kumon@flab.fujitsu.co.jp
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
