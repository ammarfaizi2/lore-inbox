Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293638AbSCFQNN>; Wed, 6 Mar 2002 11:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293640AbSCFQNF>; Wed, 6 Mar 2002 11:13:05 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:40652 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293638AbSCFQMx>;
	Wed, 6 Mar 2002 11:12:53 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Futexes III :  performance numbers
Date: Wed, 6 Mar 2002 11:13:34 -0500
X-Mailer: KMail [version 1.3.1]
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
In-Reply-To: <E16i8x2-0008TV-00@wagner.rustcorp.com.au> <20020305212210.B10A33FF04@smtp.linux.ibm.com> <20020306185420.29df1bf2.rusty@rustcorp.com.au>
In-Reply-To: <20020306185420.29df1bf2.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020306161229.0821D3FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 March 2002 02:54 am, Rusty Russell wrote:
> On Tue, 5 Mar 2002 16:23:14 -0500
>
> Hubertus Franke <frankeh@watson.ibm.com> wrote:
> > Interesting... the strict FIFO ordering of my fast semaphores limits
> > performance as seen by 99.71% contention, so we always ditch
> > into the kernel. Convoy Avoidance locks 2.5 times better.
> > Wohh futex rock, BUT... with 0.29% contention it basically tells
> > me that we are exhausting our entire quantum getting the lock
> > without contention. So their is some serious fairness issue here
> > at least for the tightly scheduled locks. Compare the M numbers
> > for 2 and 3 children.
>
> Fairness <sigh>.  This patch should be much more FIFO: it works by handing
> the mutex straight to the first one on the queue if there is one, and only
> actually "freeing" it if there's noone waiting.
>
> Unfortunately, it seems to hurt performance by 50% on tdbtorture (although
> there are weird scheduler things happening too).
>
> Here's the "fair" patch:
> Rusty.

Rusty why not provide something along the line <snipped all over the place>.

#define FUTEX_DOWN    (0)
#define FUTEX_UP          (1)
#define FUTEX_FAIR_UP (2)

static int futex_up(struct list_head *head, atomic_t *count)
{
       atomic_set(count, 1);
       smp_wmb();
       wake_one_waiter(head, count);
       return 0;
}  

static int futex_fair_up(truct list_head *head, atomic_t *count)
{
       spin_lock(&futex_lock);
       if (!pass_futex(head, count))
               /* Noone to receive: set to one and leave it free. */
               atomic_set(count, 1);
       spin_unlock(&futex_lock);
       return 0;
}


asmlinkage int sys_futex(void *uaddr, int op) 
{
       <..... snip ....>

       head = hash_futex(page, pos_in_page);
       switch (op) {

       case FUTEX_DOWN:
               ret = futex_down(head, page_address(page) + pos_in_page);
               break;

       case FUTEX_UP:
               ret = futex_up(head, page_address(page) + pos_in_page);
               break;
 
       case FUTEX_FAIR_UP:
               ret = futex_fair_up(head, page_address(page) + pos_in_page);
               break;
 
       default :

       <..... snip ....>
}


This would satisfy the fair vs. calock issue, you let the app decide what to 
use. Best of all, it seems to me you can even mix it.
Imagine, if a process knows it will soon reaquire the lock, then it would
use FUTEX_UP to avoid being tagged back to the end of wait queue
avoiding costly scheduling events. At the same time, if the process knows
that its done for a while with that lock, then it issues FUTEX_FAIR_UP.
The best of two worlds..

It also shows how cleanly the code can be expanded in the future.
The more I look at the hash queues the more I like it. 
Will look at the rwlock now. Let me know what you think.

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
