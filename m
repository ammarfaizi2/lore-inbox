Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTJNEZC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 00:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbTJNEZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 00:25:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:53175 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262196AbTJNEY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 00:24:58 -0400
Date: Mon, 13 Oct 2003 21:24:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Manfred Spraul <manfred@colorfullife.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SMP races in the timer code, timer-fix-2.6.0-test7-A0
In-Reply-To: <Pine.LNX.4.56.0310111833550.11661@earth>
Message-ID: <Pine.LNX.4.44.0310132122160.2156-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 11 Oct 2003, Ingo Molnar wrote:
> 
> i've implemented the timer->running field, and it's quite straightforward
> and solves all 3 types of races. It also simplifies del_timer_sync() quite
> visibly, and it's probably a fair del_timer_sync() speedup as well. I
> tested the attached patch on SMP and UP x86 as well, works fine for me.

This one is also buggy.

It is _not_ ok to do this:

>  			list_del(&timer->entry);
>  			timer->base = NULL;
> -			set_running_timer(base, timer);
>  			spin_unlock_irq(&base->lock);
>  			fn(data);
>  			spin_lock_irq(&base->lock);
> +#ifdef CONFIG_SMP
> +			timer->running = 0;
> +#endif

since the timer may not even _exist_ any more - the act of running the 
timer may well have free'd the timer structure, and you're now zeroing 
memory that may have been re-allocated for something else.

This is exactly why we load all the timer data into local variables before 
we run the timer function, and we don't touch "timer" afterwards.

In short, you really need to re-visit this whole thing.

		Linus

