Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265456AbTLHSDB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 13:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265473AbTLHSDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 13:03:01 -0500
Received: from ns.transas.com ([193.125.200.2]:30470 "EHLO
	harvester.transas.com") by vger.kernel.org with ESMTP
	id S265456AbTLHSBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 13:01:49 -0500
Message-ID: <2E74F312D6980D459F3A05492BA40F8D0391B0E9@clue.transas.com>
From: Andrew Volkov <Andrew.Volkov@transas.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: possible proceses leak 
Date: Mon, 8 Dec 2003 21:01:40 +0300 
Importance: high
X-Priority: 1
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="koi8-r"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

In all kernels (up to 2.6-test11) next sequence of code 
in __down/__down_interruptible function 
(arch/i386/kernel/semaphore.c) may cause processes or threads leaking.

void __down(struct semaphore * sem)
{
	struct task_struct *tsk = current;
	DECLARE_WAITQUEUE(wait, tsk);

|-----tsk->state = TASK_UNINTERRUPTIBLE;		<----- BUG: 
|          -- If "do_schedule" from kernel/schedule will calling
|              at this point, due to expire of time slice,
|              then current task will removed from run_queue,
| 		   but doesn't added to any waiting queue, and hence 
|	         will never run again. --
|	add_wait_queue_exclusive(&sem->wait, &wait);
|
|->	--- This code must be here. ---

	spin_lock_irq(&semaphore_lock);
	sem->sleepers++;
	for (;;) {
		int sleepers = sem->sleepers;

		/*
		 * Add "everybody else" into it. They aren't
		 * playing, because we own the spinlock.
		 */
		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
			sem->sleepers = 0;
			break;
		}
		sem->sleepers = 1;	/* us - see -1 above */
		spin_unlock_irq(&semaphore_lock);

		schedule();
		tsk->state = TASK_UNINTERRUPTIBLE; 
		spin_lock_irq(&semaphore_lock);
	}
	spin_unlock_irq(&semaphore_lock);

--->  Must be here.
|
|	remove_wait_queue(&sem->wait, &wait);	<----- SAME BUG
------tsk->state = TASK_RUNNING;
	wake_up(&sem->wait);

This bug in all  arch/*/kernel/semaphore.c files.

Regards
Andrey Volkov





