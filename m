Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316644AbSFMFNs>; Thu, 13 Jun 2002 01:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316889AbSFMFNr>; Thu, 13 Jun 2002 01:13:47 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:43417 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S316644AbSFMFNq>; Thu, 13 Jun 2002 01:13:46 -0400
From: "BALBIR SINGH" <balbir.singh@wipro.com>
To: "lkml" <linux-kernel@vger.kernel.org>
Subject: [RFC] down and down_interruptible on x86
Date: Thu, 13 Jun 2002 10:47:00 +0530
Message-ID: <00a601c21299$8d998520$290806c0@wipro.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-a720cbd1-6dc1-4732-95c7-65cb743bf6e2"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-a720cbd1-6dc1-4732-95c7-65cb743bf6e2
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello, All,

I am a little confused about down and down_interruptible.
My mixed mind tells me it might be a bug in __down() and
__down_interruptible()

snippet from semaphore.c

int __down_interruptible(struct semaphore * sem)
{
....

                /*
                 * With signals pending, this turns into
                 * the trylock failure case - we won't be
                 * sleeping, and we* can't get the lock as
                 * it has contention. Just correct the count
                 * and exit.
                 */
                if (signal_pending(current)) {
                        retval = -EINTR;
                        sem->sleepers = 0;
                        atomic_add(sleepers, &sem->count);
                        break;
                }
.....

        spin_unlock_irq(&semaphore_lock);
        tsk->state = TASK_RUNNING;
        remove_wait_queue(&sem->wait, &wait);
        wake_up(&sem->wait);                     <---------------------
Is this correct?
        return retval;
}

Lets assume that two processes/threads called down_interruptible on a
semaphore.

P1							P2
---			                        ---

down_interruptible()			down_interruptible()
 |							 |
 V							 V
Did not get semaphore, so		signals pending, so leave (break
in the signal_pending if)
waits in the wait queue
 |							|
 V							V
schedule()					Remove self from
wait_queue
							|
							V
						Call wake_up on
&sem->wait

Wont wake_up(&sem->wait), wakeup p1, so then when up() is called for
waking up P1,
the system will panic.

Am I missing something?

Warm Regards,
Balbir


------=_NextPartTM-000-a720cbd1-6dc1-4732-95c7-65cb743bf6e2
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer************************************

Information contained in this E-MAIL being proprietary to Wipro Limited is 
'privileged' and 'confidential' and intended for use only by the individual
 or entity to which it is addressed. You are notified that any use, copying 
or dissemination of the information contained in the E-MAIL in any manner 
whatsoever is strictly prohibited.

***************************************************************************

------=_NextPartTM-000-a720cbd1-6dc1-4732-95c7-65cb743bf6e2--
