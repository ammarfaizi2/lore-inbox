Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311014AbSCHTC7>; Fri, 8 Mar 2002 14:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311018AbSCHTCu>; Fri, 8 Mar 2002 14:02:50 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:49134 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311014AbSCHTCp>; Fri, 8 Mar 2002 14:02:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Linus Torvalds <torvalds@transmeta.com>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
Date: Fri, 8 Mar 2002 14:03:28 -0500
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0203080953420.2608-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0203080953420.2608-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020308190232.A2D273FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 March 2002 01:07 pm, Linus Torvalds wrote:
> On Tue, 5 Mar 2002, Rusty Russell wrote:
> > 1) FUTEX_UP and FUTEX_DOWN defines. (Robert Love)
> > 2) Fix for the "decrement wraparound" problem (Paul Mackerras)
> > 3) x86 fixes: tested on dual x86 box.
>
> This doesn't work on highmem machines - doing the conversion from "<struct
> page, offset>" to "page_address(page)+offset" is simply not legal (not
> even for pure hashing purposes - page_address() changes as you kmap it).
>
> You need to keep the <struct page,offset> tuple in that format, and no
> other. And when you actually touch the page, you need to do the
> kmap()/kunmap() (and you must not keep it mapped while you sleep, because
> that might trivially make the kernel run out of virtual mappings).
>
> 		Linus
>

Good point, my package doesn't have that problem, but your suggestion
should nicely fit into Rusty's patch, but it seems like increasing in 
overhead now. 

Could you also comment on the functionality that has been discussed. 


(I) the fairness issues that have been raised.
    do you support two wakeup mechanism: FUTEX_UP and FUTEX_UP_FAIR 
    or you don't care about fairness and starvation
(II) the rwlocks issues,
     do you support rich set of functions/ops such as below

(a) writer preference
        if any writer is waiting then wake that one up.
(b) reader preference
        if any reader is waiting wait up all the readers in the queue
(c) fifo preference
        if the first waiter is a writer wait it up, otherwise wake up all 
readers
(d) fifo-fair  preference
        like (c), but only wake up readers until the next writer is 
encountered

(a) - (c) can be implemented with Rusty's 2 user-ueue approach as long
as the wakeup type is always the same. The last one can't (?).

In the kernel this is easy to implement, but the trouble is the status
word in user space, still thinking about it.
It also requires compare and swap.

Thanks for your time and pointing this out. 

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
