Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132573AbRDEITS>; Thu, 5 Apr 2001 04:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132576AbRDEITI>; Thu, 5 Apr 2001 04:19:08 -0400
Received: from eschelon.gamesquad.net ([216.115.239.45]:23558 "HELO
	eschelon.gamesquad.net") by vger.kernel.org with SMTP
	id <S132573AbRDEITA>; Thu, 5 Apr 2001 04:19:00 -0400
From: "Vibol Hou" <vhou@khmer.cc>
To: "Andrew Morton" <andrewm@uow.edu.au>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: RE: mysqld [3.2.23] hangs when key_buffer ~256MB on [2.4.2-ac28+]
Date: Thu, 5 Apr 2001 01:17:17 -0700
Message-ID: <NDBBKKONDOBLNCIOPCGHEEPPFOAA.vhou@khmer.cc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3ACB7C88.40DB16FA@uow.edu.au>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I've applied the patch.  The processes usually start dying within a few
minutes so it shouldn't be hard to tell if this patch is working or not.
I'll let you know what's up.

-Vibol

-----Original Message-----
From: akpm@uow.edu.au [mailto:akpm@uow.edu.au]On Behalf Of Andrew Morton
Sent: Wednesday, April 04, 2001 12:57 PM
To: Alan Cox
Cc: Vibol Hou; Linux-Kernel
Subject: Re: mysqld [3.2.23] hangs when key_buffer ~256MB on
[2.4.2-ac28+]


Alan Cox wrote:
>
> > I initially upgraded my kernel from 2.4.2-ac5 to 2.4.3 and the first
thing I
> > noticed was that mysqld was stuck.  Killing it left it hanging in a D
state.
> > Then I tried 2.4.2-ac28 (which I am using now), and the got the same
result.
>
> I'd expect that bit. 2.4.2-ac28 basically has the same new rwlock VM and
> behaviour as 2.4.3pre8. What would be really useful to know is if anyone
can
> duplicate the problem non x86
>
> > Can anyone reproduce this problem?
>
> Yes

Untested patch:


--- semaphore.c.orig    Wed Apr  4 12:54:30 2001
+++ semaphore.c Wed Apr  4 12:54:58 2001
@@ -363,26 +363,26 @@
  */
 struct rw_semaphore *down_write_failed(struct rw_semaphore *sem)
 {
        struct task_struct *tsk = current;
        DECLARE_WAITQUEUE(wait, tsk);

        __up_write(sem);        /* this takes care of granting the lock
*/

-       add_wait_queue_exclusive(&sem->wait, &wait);
+       add_wait_queue_exclusive(&sem->write_bias_wait, &wait);

        while (atomic_read(&sem->count) < 0) {
                set_task_state(tsk, TASK_UNINTERRUPTIBLE);
                if (atomic_read(&sem->count) >= 0)
                        break;  /* we must attempt to acquire or bias
the lock */
                schedule();
        }

-       remove_wait_queue(&sem->wait, &wait);
+       remove_wait_queue(&sem->write_bias_wait, &wait);
        tsk->state = TASK_RUNNING;

        return sem;
 }

 asm(
 "
 .align 4

