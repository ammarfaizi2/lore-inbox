Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316453AbSEUAMC>; Mon, 20 May 2002 20:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316455AbSEUAMB>; Mon, 20 May 2002 20:12:01 -0400
Received: from [66.105.142.142] ([66.105.142.142]:64263 "EHLO
	exchange1.FalconStor.Net") by vger.kernel.org with ESMTP
	id <S316453AbSEUAL7>; Mon, 20 May 2002 20:11:59 -0400
Message-ID: <E79B8AB303080F4096068F046CD1D89B934C94@exchange1.FalconStor.Net>
From: Ron Niles <Ron.Niles@falconstor.com>
To: linux-kernel@vger.kernel.org
Subject: Oops from local semaphore race condition
Date: Mon, 20 May 2002 20:11:57 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Many places in the kernel (mostly drivers, like in scsi_error.c,
scsi_sleep()) have the following construct:

void function(void)
{
	DECLARE_MUTEX_LOCKED(sem);

	/* let another thread do the work and up() when done */
	notify_handler(&sem);
	down(&sem);
}

I have used this construct very often and under stress testing my driver got
a few Oops in __up_wakeup, as if the semaphore went corrupt. Then I realized
it can possibly go corrupt, due to a race condition which lets down()
continue before up() is complete:

down decrements sem->counter to -1
   up increments sem->counter to 0
down enters __down, but does not sleep since sem->counter has already been
incremented
   up enters __up, tries to wake_up(&sem->wait) but sem is now garbage since
function has exited.

I think this race is possible only on SMP. This problem seems to show up
more if I have heavy irq activity which I guess will interrupt down()
between the --sem->counter and __down(), and also interrupt up() between
++sem->counter and __up().

I am interested in some opinions:
(1) does the following up_atomic() function instead of up() indeed fix the
race condition?
(2) it is worthwile to put it into semaphore.c and semaphore.h?
(3) is it worthwhile to fix the condition in scsi modules and other drivers
that do this?

void up_atomic(struct semaphore *sem)
{
	spin_lock_irq(&semaphore_lock);
	up(sem);		
	spin_unlock_irq(&semaphore_lock);
}

