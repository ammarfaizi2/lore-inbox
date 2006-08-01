Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWGaUM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWGaUM6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 16:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWGaUM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 16:12:57 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:51683 "EHLO
	several.ru") by vger.kernel.org with ESMTP id S932461AbWGaUM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 16:12:57 -0400
Date: Tue, 1 Aug 2006 04:12:58 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: rt_mutex_timed_lock() vs hrtimer_wakeup() race ?
Message-ID: <20060801001258.GA130@oleg>
References: <20060730043605.GA2894@oleg> <1154298218.10074.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154298218.10074.33.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30, Steven Rostedt wrote:
>
> On Sun, 2006-07-30 at 08:36 +0400, Oleg Nesterov wrote:
> > 
> > Another question, task_blocks_on_rt_mutex() does get_task_struct() and checks
> > owner->pi_blocked_on != NULL under owner->pi_lock. Why ? RT_MUTEX_HAS_WAITERS
> > bit is set, we are holding ->wait_lock, so the 'owner' can't go away until
> > we drop ->wait_lock.
> 
> That's probably true that the owner can't disappear before we let go of
> the wait_lock, since the owner should not be disappearing while holding
> locks.  But you are missing the point to why we are grabbing the
> pi_lock.  We are preventing a race that can have us do unneeded work
> (see below).

Yes, I see. But ...

> ===================================================================
> --- linux-2.6.18-rc2.orig/kernel/rtmutex.c	2006-07-30 18:04:12.000000000 -0400
> +++ linux-2.6.18-rc2/kernel/rtmutex.c	2006-07-30 18:07:08.000000000 -0400
> @@ -433,25 +433,26 @@ static int task_blocks_on_rt_mutex(struc
>	...
>  	else if (debug_rt_mutex_detect_deadlock(waiter, detect_deadlock)) {
>  		spin_lock_irqsave(&owner->pi_lock, flags);
> -		if (owner->pi_blocked_on) {
> +		if (owner->pi_blocked_on)
>  			boost = 1;
> -			/* gets dropped in rt_mutex_adjust_prio_chain()! */
> -			get_task_struct(owner);
> -		}
>  		spin_unlock_irqrestore(&owner->pi_lock, flags);

In that case ->pi_lock can't buy anything. With or without ->pi_lock this
check is equally racy, so spin_lock() only adds unneeded work?

Thanks!

Oleg.

