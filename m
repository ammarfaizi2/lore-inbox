Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263491AbSKUAGG>; Wed, 20 Nov 2002 19:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263544AbSKUAGG>; Wed, 20 Nov 2002 19:06:06 -0500
Received: from netrealtor.ca ([216.209.85.42]:28170 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S263491AbSKUAGF>;
	Wed, 20 Nov 2002 19:06:05 -0500
Date: Wed, 20 Nov 2002 19:20:46 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [rfc] new poll callback'd wake up hell ...
Message-ID: <20021121002046.GD32715@mark.mielke.cc>
References: <Pine.LNX.4.44.0211201354210.1989-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211201354210.1989-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1) Move the wake_up() call done inside the poll callback outside the lock
> void poll_cb(xxx *data)
> {
> 	int pwake = 0;
> 
> 	lock(data);
> 	...
> 	if (wait_queue_active(&data->poll_wait))
> 		pwake++;
> 	unlock(data)
> 	if (pwake)
> 		ep_poll_safe_wakeup(&data->psw, &data->poll_wait)
> }

This looks like a good thing to do with or without the problem. Minimizing
the time that a lock is held is usually a good idea.

> 2) Use this infrastructure to perform safe poll wakeups
> ...
> static void ep_poll_safe_wakeup(struct poll_safewake *psw, wait_queue_head_t *wq)
> {
>         atomic_inc(&psw->count);
>         do {
>                 if (!xchg(&psw->wakedoor, 0))
>                         break;
>                 wake_up(wq);
>                 xchg(&psw->wakedoor, 1);
>         } while (!atomic_dec_and_test(&psw->count));
> }
> Does anyone foresee problem in this implementation ?
> Another ( crappy ) solution might be to avoid the epoll fd to drop inside
> its poll wait queue head, wait queues that has the function pointer != NULL

Clever. (I think the second xchg() can just be atomic_set()) Without actually
playing with it, it looks good to me.

If the problem is too hard to solve - it isn't that bad if one can't
epoll recursively. If the functionality was added later, it is
doubtful that the API itself would need to change.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

