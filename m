Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132057AbRDDT7l>; Wed, 4 Apr 2001 15:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132077AbRDDT7d>; Wed, 4 Apr 2001 15:59:33 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:23460 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S132057AbRDDT7P>; Wed, 4 Apr 2001 15:59:15 -0400
Message-ID: <3ACB7C88.40DB16FA@uow.edu.au>
Date: Wed, 04 Apr 2001 12:56:56 -0700
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18-0.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Vibol Hou <vhou@khmer.cc>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: mysqld [3.2.23] hangs when key_buffer ~256MB on [2.4.2-ac28+]
In-Reply-To: <NDBBKKONDOBLNCIOPCGHKELLFOAA.vhou@khmer.cc> from "Vibol Hou" at Apr 04, 2001 11:44:00 AM <E14ksXc-0002YN-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I initially upgraded my kernel from 2.4.2-ac5 to 2.4.3 and the first thing I
> > noticed was that mysqld was stuck.  Killing it left it hanging in a D state.
> > Then I tried 2.4.2-ac28 (which I am using now), and the got the same result.
> 
> I'd expect that bit. 2.4.2-ac28 basically has the same new rwlock VM and
> behaviour as 2.4.3pre8. What would be really useful to know is if anyone can
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
