Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267229AbTATWtJ>; Mon, 20 Jan 2003 17:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267244AbTATWtJ>; Mon, 20 Jan 2003 17:49:09 -0500
Received: from users.ccur.com ([208.248.32.211]:49086 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S267229AbTATWtI>;
	Mon, 20 Jan 2003 17:49:08 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200301202258.WAA02263@rudolph.ccur.com>
Subject: Re: spinlock efficiency problem [was 2.5.57 IO slowdown with CONFIG_PREEMPT enabled)
To: joe.korty@ccur.com
Date: Mon, 20 Jan 2003 17:58:07 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
Reply-To: joe.korty@ccur.com (Joe Korty)
In-Reply-To: <no.id> from "jak" at Jan 20, 2003 05:51:55 PM
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ resend - forgot to send this to the list, also forgot intro text ]

> Robert Macaulay <robert_macaulay@dell.com> wrote:
>>
>> On Wed, 15 Jan 2003, Andrew Morton wrote:
>>> if you could please test that with CONFIG_PREEMPT=y
>> 
>> Reverting that brings the speed back up
>
> OK.  How irritating.
>
> Presumably there's a fairness problem - once a CPU goes in there to start
> spinning on the lock, the length of the loop is such that it's easy for
> non-holders to zoom in and claim it first.  Or something.
>
> Unless another way of solving the problem which that patch solves presents
> itself we may need to revert it.
>
> Or not.  Should a CONFIG_PREEMPT SMP kernel compromise its latency because of
> overused locking??


Andrew, Everyone,

The new, preemptable spin_lock() spins on an atomic bus-locking
read/write instead of an ordinary read, as the original spin_lock
implementation did.  Perhaps that is the source of the inefficiency
being seen.

Attached sample code compiles but is untested and incomplete (present
only to illustrate the idea).

Joe



--- 2.5-bk/kernel/sched.c.orig	2003-01-20 14:14:55.000000000 -0500
+++ 2.5-bk/kernel/sched.c	2003-01-20 17:31:49.000000000 -0500
@@ -2465,15 +2465,13 @@
 		_raw_spin_lock(lock);
 		return;
 	}
-
-	while (!_raw_spin_trylock(lock)) {
-		if (need_resched()) {
-			preempt_enable_no_resched();
-			__cond_resched();
-			preempt_disable();
+	do {
+		preempt_enable();
+		while(spin_is_locked(lock)) {
+			cpu_relax();
 		}
-		cpu_relax();
-	}
+		preempt_disable();
+	} while (!_raw_spin_trylock(lock));
 }
 
 void __preempt_write_lock(rwlock_t *lock)

