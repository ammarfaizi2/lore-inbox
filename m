Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266898AbSKKSD2>; Mon, 11 Nov 2002 13:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266901AbSKKSDX>; Mon, 11 Nov 2002 13:03:23 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:33446 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S266898AbSKKSDQ>;
	Mon, 11 Nov 2002 13:03:16 -0500
Message-ID: <3DCFF273.4020403@colorfullife.com>
Date: Mon, 11 Nov 2002 19:09:55 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com, viro@math.psu.edu,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] epoll bits 0.34
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
> - Cleaned up locking
>
The cleanup is dangerous/broken: You call f_op->poll with disabled 
interrupts.

> 	/* We have to drop the new item inside our item list to keep track of it */
> 	write_lock_irqsave(&ep->lock, flags);
> 
>+	/* Add the current item to the hash table */
> 	list_add(&dpi->llink, ep_hash_entry(ep, ep_hash_index(ep, tfile)));
> 
>+	/* Attach the item to the poll hooks and get current event bits */
>+	revents = tfile->f_op->poll(tfile, &pt);
>+
>  
>
Which file descriptors are pollable with eventpoll? For example rtc_poll 
does

    spin_lock_irq();
    do_work();
    spin_unlock_irq();

I'm sure that there are other drivers that are be affected, I haven't 
checked networking.

And is that really needed? Could you do the real work in the poll 
callback instead of locking around the f_op call?

--
    Manfred

