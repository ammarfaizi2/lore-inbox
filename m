Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310953AbSCMS0W>; Wed, 13 Mar 2002 13:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310960AbSCMS0N>; Wed, 13 Mar 2002 13:26:13 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:3252 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S310953AbSCMS0B>;
	Wed, 13 Mar 2002 13:26:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: drepper@redhat.com
Subject: futex and timeouts
Date: Wed, 13 Mar 2002 13:26:53 -0500
X-Mailer: KMail [version 1.3.1]
Cc: rusty@rustcorp.com.au, matthew@hairy.beasts.org,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020313182552.945523FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ulrich, it seems to me that absolute timeouts are the easiest to do.

(a) expand by additional parameter (0) means no timeout desired
(b) differentiate the schedule call in futex_down..

Question is whether the granularity of jiffies (10ms) is sufficiently small 
for timeouts.....

Rusty, take a look, wether there's something wrong with this and see whether
you can integrate it or improve and integrate it.

/* Simplified from arch/ppc/kernel/semaphore.c: Paul M. is a genius. */
static int futex_down(struct list_head *head, struct page *page, int offset,  
                             signed long timeout)
{
        int retval = 0;
        struct futex_q q;
 
        current->state = TASK_INTERRUPTIBLE;
        queue_me(head, &q, page, offset);
 
        while (!decrement_to_zero(page, offset)) {
                if (signal_pending(current)) {
                        retval = -EINTR;
                        break;
                }
	    if (!timeout) {
	        schedule();
                    current->state = TASK_INTERRUPTIBLE;	
	        continue;
                }
	    delay = schedule_timeout(timeout);
	    if (delay == 0)  {
		retval = -EAGAIN;
		break;
	    }
	    current->state = TASK_INTERRUPTIBLE;
	    timeout -= delay;
        }
        current->state = TASK_RUNNING;
        unqueue_me(&q);
        /* If we were signalled, we might have just been woken: we
           must wake another one.  Otherwise we need to wake someone
           else (if they are waiting) so they drop the count below 0,
           and when we "up" in userspace, we know there is a
           waiter. */
        wake_one_waiter(head, page, offset);
        return retval;
}

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
