Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUEJMa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUEJMa3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 08:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264663AbUEJMa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 08:30:29 -0400
Received: from niit.caravan.ru ([217.23.131.158]:2321 "EHLO mail.tv-sign.ru")
	by vger.kernel.org with ESMTP id S264665AbUEJMaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 08:30:20 -0400
Message-ID: <409F7634.D1834978@tv-sign.ru>
Date: Mon, 10 May 2004 16:31:48 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] WAIT_BIT_QUEUE
References: <409F668A.CEFD60F6@tv-sign.ru> <20040510043010.0c9dd1e8.akpm@osdl.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>
> Oleg Nesterov <oleg@tv-sign.ru> wrote:
> > 
> >  process waiting in wait_on_page_bit() will be woken only after
> >  the required bit is cleared.
> > 
> >  so there is no need to recheck the bit in do/while loop, because
> >  there is no false wakeups now.
> 
> yup.  Please see the new patches in 2.6.6-mm1 - the waiter puts the bit
> number into the waitqueue structure and the waker tests it before
> delivering the wakeup.

and it puts page or buffer_head in waitqueue instead of just flags.

> +static int page_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key)
> +{
> +	struct page *page = key;
> +	struct page_wait_queue *wq;
> +
> +	wq = container_of(wait, struct page_wait_queue, wait);
> +	if (wq->page != page || test_bit(wq->bit, &page->flags))
> +		return 0;
> +	else
> +		return autoremove_wake_function(wait, mode, sync, NULL);
> +}

Why bother to check if (wq->page != page) ?
Yes, without this check waiting process can be waken _before_
wake_up_all(page_waitqueue(page)) but i see no problems here.

In fact, this can happen with clean kernel as well.
Let us suppose page_waitqueue(A) == page_waitqueue(B), and
we have two concurrent unlock_page() on these pages.

unlock_page(A)                       unlock_page(B)
TestClearPageLocked(A)
                                     TestClearPageLocked(B)
                                     wake_up_all(page_waitqueue(B)
                                           wakes up process waiting for A,
                                           it returns from wait_on_page_bit()
                                           because !test_bit(bit_nr, &page->flags)
wake_up_all(page_waitqueue(A)
     waiter already running.


So, I beleive, we need not key parameter in page_wake_function.
If we will put flags in waitqueue, bh_wake_function becomes identical
to page_wake_function, and we do not have to modify wakers at all,
there is no need to push page/buffer_head to wake_up().

So, new key parameter for wake_up becomes unneeded.

Oleg.
