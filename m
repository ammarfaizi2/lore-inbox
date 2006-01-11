Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751713AbWAKUrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbWAKUrk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 15:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbWAKUrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 15:47:40 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:37067 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751694AbWAKUrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 15:47:40 -0500
Subject: 2.6.15-rt4-sr1
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: George Anzinger <george@mvista.com>, john stultz <johnstul@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 15:47:11 -0500
Message-Id: <1137012431.6197.117.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just uploaded my new maintenance release.

fixes:

- light soft lockup - currently it doesn't detect the light soft lockups
    because the counter was being reset in the wrong place.  Not sure if
    this was done earlier with some other issue.  But I needed this fix
    to get the low priority lockup to be detected.

- posix_timers deadlock - There's a loop in the posix_timeres code that 
    is entered if the current process is a higher priority than the 
    softirqd thread, and it spins until the softirqd thread is finished.
    But since the thread is of a higher priority than the softirqd, it
    deadlocks.

- read_trylock_rt  - added this for cases that have a loop on
    read_trylock.  Since in RT a read lock is a mutex, a read_trylock
    will fail even if the owner has it only for reading.  But since
    the reads are not protected with irqsaves, this can deadlock when
    a high priority process preempts the owner of the lock and spins
    till it's released. (this was seen in signal.c: send_group_sigqueue,
    there may be others)

Still at the normal location:

http://home.stny.rr.com/rostedt/patches/patch-2.6.15-rt4-sr1

Here is the program that showed all these nice deadlocks ;)

http://www.kihontech.com/tests/rt/timer_stress.c

(Run with -P to get the posix deadlocks)

-- Steve


