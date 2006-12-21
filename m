Return-Path: <linux-kernel-owner+w=401wt.eu-S965179AbWLUJlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965179AbWLUJlq (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 04:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbWLUJlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 04:41:46 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:59316 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965179AbWLUJlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 04:41:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XtD7SpOQiYfjPzZQ11JP1OeqvQcdzsOp8SwXtRBgAbBAxkt/LYvKx6DcLNfU0qREJE/fP3KezSGuXWYAnFm+3aDYH3y056ajdys8arGedz/ERykWvV8BFaFwGWOIBzUGuZe6zCCXOtgw/+Xi9utHIEtcWA18tvsSaTUsEHYeBQQ=
Message-ID: <20170a030612210141y6578602eo525e6df5f324747d@mail.gmail.com>
Date: Thu, 21 Dec 2006 10:41:44 +0100
From: "Sorin Manolache" <sorinm@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: newbie questions about while (1) in kernel mode and spinlocks
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear list,

I am in the process of learning how to write linux device drivers.

I have a 2.6.16.5 kernel running on a monoprocessor machine.
#CONFIG_SMP is not set
CONFIG_DEBUG_SPINLOCK=y.
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y

First question:

I wrote

while (1)
    ;

in the read function of a test device driver. I expect the calling
process to freeze, and then a timer interrupt to preempt the kernel
and to schedule another process. This does not happen, the whole
system freezes. I see no effect from pressing keys or moving the
mouse. Why? The hardware interrupts are not disabled, are they? Why do
the interrupt handlers not get executed?

Second question:

I wrote

spin_lock(&lck);
down(&sem); /* I know that one shouldn't sleep when holding a lock */
                    /* but I want to understand why */
spin_unlock(&lck);

in the read function and

up(&sem)

in the write function. The semaphore is initially locked, so the first
process invoking down will sleep.

I invoke

cat /dev/test

and the process sleeps on the semaphore. Then I invoke

echo 1 > /dev/test

and I wake up the "cat" process.

Then I intend to invoke _two_ cat processes. I expect the first one to
sleep on the semaphore and the second on to spin at the spin_lock.
Then I expect to wake up the first process by invoking an echo, the
first process to release the lock and the second process to sleep on
the semaphore. What I get is that the system freezes as soon as I
invoke the second "cat" process. Again, no effect from key presses or
mouse movements. Why? Shouldn't the timer interrupt preempt the second
"cat" process that spins on the spinlock and give control to something
else, for example to the console where I could wake up the first "cat"
process? Why do I not see any effect from mouse movements? Hardware
interrupts are not disabled, are they?

Third question:

The Linux Device Drivers book says that a spin_lock should not be
shared between a process and an interrupt handler. The explanation is
that the process may hold the lock, an interrupt occurs, the interrupt
handler spins on the lock held by the process and the system freezes.
Why should it freeze? Isn't it possible for the interrupt handler to
re-enable interrupts as its first thing, then to spin at the lock, the
timer interrupt to preempt the interrupt handler and to relinquish
control to the process which in turn will finish its critical section
and release the lock, making way for the interrupt handler to
continue.

Thank you very much for clarifying these issues.

Regards,
Sorin
