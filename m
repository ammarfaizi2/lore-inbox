Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131155AbQKVKJT>; Wed, 22 Nov 2000 05:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131140AbQKVKJJ>; Wed, 22 Nov 2000 05:09:09 -0500
Received: from smtp2.free.fr ([212.27.32.6]:50950 "EHLO smtp2.free.fr")
	by vger.kernel.org with ESMTP id <S130912AbQKVKJF>;
	Wed, 22 Nov 2000 05:09:05 -0500
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.2.1[78] : RTNETLINK lock not properly locking ?
Message-ID: <974885943.3a1b9437847da@imp.free.fr>
Date: Wed, 22 Nov 2000 10:39:03 +0100 (MET)
From: Willy Tarreau <willy.lkml@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 195.6.58.78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

while I was searching how to implement an rtnl_lock() in the bonding code,
I discovered that the rtnl_shlock() function in 2.2.1[78] could misbehave if
CONFIG_RTNETLINK is not set :
   - it will nearly never allow concurrent accesses (seems to be what was
     intented when it was written)
   - it will not always prevent concurrent accesses, which is weird because
     rtnl_lock() only relies on rtnl_shlock() (and exlock, which is empty) to
     protect sensible areas

The first case is trivial : one at a time.
(code taken from include/linux/rtnetlink.h, line 639)

     while (atomic_read(&rtnl_rlockct))
            sleep_on(&rtnl_wait);
     atomic_inc(&rtnl_rlockct);

The second case isn't trivial, so I will quote some points in the code :

[rtnl_shlock]
(1) ---------
        while (atomic_read(&rtnl_rlockct))
(2) ---------
                sleep_on(&rtnl_wait);
(3) ---------
        atomic_inc(&rtnl_rlockct);
(4) ---------

[rtnl_shunlock]
(5) ---------
        if (atomic_dec_and_test(&rtnl_rlockct))
(6) ---------
                wake_up(&rtnl_wait);
(7) ---------

Consider 3 concurrent threads A, B and C.
- First, A needs the lock. Noone has it. It enters (1), then (3), sets the
  rtnl_rlockct to 1 and exits at (4).
- now B comes in (1). The lock is already set by A, so B goes to (2) and
  sleeps.
- A unlocks. It goes to (5), then (6)
- at this moment, C tries to lock in (1), an succeeds since A has just released
  the lock. So it gets the lock and goes to (3), then (4).
- A is at (6) and wakes B up and steps to (7) and exits.
- B is woken up and goes to (3) then (4).

=> B and C both have the lock.

Perhaps I have missed something, but I don't find what. If I'm right, then why
don't we simply keep the same code as for the CONFIG_RTNETLINK case ?

Thanks in advance for any comment,

Regards,
Willy
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
