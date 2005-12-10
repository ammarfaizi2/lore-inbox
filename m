Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbVLJAYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbVLJAYB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 19:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbVLJAYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 19:24:01 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:16879 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932531AbVLJAYA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 19:24:00 -0500
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3EC7CB34-6913-11DA-BDBB-000A959BB91E@mvista.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
From: david singleton <dsingleton@mvista.com>
Subject: Robust futex update:
Date: Fri, 9 Dec 2005 16:23:53 -0800
To: robustmutexes@lists.osdl.org
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	There is a new robust futex patch on 
http://source.mvista.com/~dsingleton/patch-2.6.14-rt22-rf11
	that fixes three bugs.  One of the bugs was an SMP race condition that 
Dave Carlson had spotted
	and has been gracious enough to test for me.
	
	The bug fixes are:

         1) Down_futex() must call put_task_struct() before the
         call to __down_interruptible so other blocking threads
         can find the owning thread's task struct and block on the futex.

         If put_task_struct is called after down_interruptible returns
         only the first waiter can block through down_interruptible,
         all other waiters can not find the task struct until the
         first waiter is woken.

         2) Robust mutexes only set a timeout if the user requests one.
         This is mainly a performance optimization.  We don't set up
         and tear down a timeout unless the user requested one.

         3) To fix an SMP race condition between wait and wake
         futex_wait_robust() now passes the same parameters and performs
         the same checks for user land race as futex_wait().

         This change makes the code simpler and more similar to 
futex_wait.

         Futex_wait passes in the value that that glibc got from the
         pthread_mutex at compare and xchange time.  Futex_wait_robust 
now
         does the same check, after aquiring the correct locks, to see if
         the lock in user space has changed since entering the kernel.

         (There is a corresponding patch for glibc to pass the lock
         value into futex_wait_robust.)

         Futex wake also has a new race condition check for the following
         SMP race scenario:

         Thread A gets the pthread_mutex via the fast path and does not
         enter the kernel.

         Thread B tries to lock the same pthread mutex and discovers its
         already locked.  It sets the waiters flag in the lock and enters
         the kernel to block on the futex.

         Thread A releases the lock and sees the waiters flag. Thread A
         enters the kernel to unlock the futex and wake the waiters
         before thread B can get into the kernel and lock the futex
         on behalf of thread A.

         Thread A discovers that it does not own the lock and returns
         EINVAL erroneously.

         With this fix Thread A now locks the futex and unlocks the
         robust semaphore protecting the futex and the mmap_sem
         protecting the vma and goes around the loop one more time
         to allow the waiters a chance to actually block before the
         wake occurs.


David 

