Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWFAPxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWFAPxG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 11:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbWFAPxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 11:53:06 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:8409 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1030210AbWFAPxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 11:53:05 -0400
X-AuthUser: davidel@xmailserver.org
Date: Thu, 1 Jun 2006 08:52:57 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Arjan van de Ven <arjan@infradead.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: deadlock in epoll (found by lockdep)
In-Reply-To: <1149151538.3115.29.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0606010847430.28155@alien.or.mcafeemobile.com>
References: <1149151538.3115.29.camel@laptopd505.fenrus.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2006, Arjan van de Ven wrote:

> in ep_poll() (fs/eventpoll.c) the code does
>
>       write_lock_irqsave(&ep->lock, flags);
>
>        res = 0;
>        if (list_empty(&ep->rdllist)) {
>                /*
>                 * We don't have any available event to return to the caller.
>                 * We need to sleep here, and we will be wake up by
>                 * ep_poll_callback() when events will become available.
>                 */
>                init_waitqueue_entry(&wait, current);
>                add_wait_queue(&ep->wq, &wait);
>
> eg we first take ep->lock and then call add_wait_queue which takes
>         spin_lock_irqsave(&q->lock, flags);
> for obvious reasons.
> this would mean that ep->lock would be the outer lock, and q->lock the
>
>
> HOWEVER, __wake_up does this:
> void fastcall __wake_up(wait_queue_head_t *q, unsigned int mode,
>                        int nr_exclusive, void *key)
> {
>        unsigned long flags;
>
>        spin_lock_irqsave(&q->lock, flags);
>        __wake_up_common(q, mode, nr_exclusive, 0, key);
>        spin_unlock_irqrestore(&q->lock, flags);
> }
>
> where __wake_up_common calls into ep_poll_callback, which in term does
>        write_lock_irqsave(&ep->lock, flags);
> as one of the first things.
>
> ... which implies that q->lock is the outer lock, and ep->lock is the
> inner lock....
>
> can you explain which order is right, and if/why this is not an AB-BA
> deadlock??

Just woke up and still dangerously low on caffeine, but that would happen 
if and only if the wake up target of the epoll fd #N is the epoll fd #N, 
and this is explicitly denied in epoll_ctl(ADD). I'll take a deeper look 
once I get in the office with my venti latte ;)



- Davide


