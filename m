Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266892AbRGWVuU>; Mon, 23 Jul 2001 17:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267927AbRGWVuK>; Mon, 23 Jul 2001 17:50:10 -0400
Received: from cpe-66-1-45-23.az.sprintbbd.net ([66.1.45.23]:49931 "EHLO
	deming-os.org") by vger.kernel.org with ESMTP id <S266892AbRGWVuD>;
	Mon, 23 Jul 2001 17:50:03 -0400
Message-ID: <3B5C9BFE.5BFB8BC7@deming-os.org>
Date: Mon, 23 Jul 2001 14:49:50 -0700
From: Russ Lewis <russ@deming-os.org>
X-Mailer: Mozilla 4.74 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Safely giving up a lock before sleeping
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I'm writing a module where I need to go to sleep and release a spinlock
as I do so.  I know how to do this, but it's not elegant...I'm wondering
if anyone has a more elegant solution to what I would guess is a common
problem.


The problem:
I have a module that gets called by other modules' bottom half
handlers.  These calls add information to a job queue I manage.  I then
have user processes that perform read operations on device files asking
for work.  If there is no work currently available, I put them to
sleep.  Of course, this user thread must release the spinlock before
going to sleep.  The calls from the bottom half handlers wake up the
wait queue after they put new work on the job queue.

If I implement this by calling spin_unlock_irqrestore() immediately
followed by interruptible_sleep_on(), then I have a race condition where
I could release the lock and immediately have a bottom half handler on
another processor grab it, put data in the queue, and wake the wait
queue.  My original (user-side) process then happily goes to sleep,
unaware that new information is available.

My current solution:
I looked at the source of interruptible_sleep_on and stuck my
spin_unlock_irqsave right into the middle of it.  My code currently is:

current->state = TASK_INTERRUPTIBLE;
add_wait_queue_exclusive(...);
spin_unlock_irqrestore(...);
schedule();

This avoids the wait condition, since the lock is not released until the
process is set to INTERRUPTIBLE and is on the qait queue.  Thus, if the
other process races me and puts work on the queue and wakes up the wait
queue before I complete schedule(), then my state is simply reset to
TASK_RUNNING and the user process just keeps going.

Of course, since I need the lock to do anything, the first thing I do
(after removing myself from the wait queue and checking for signals) is
to relock the lock.

Is this a common problem?  Is there a more elegant solution to this?

