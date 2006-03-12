Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWCLN0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWCLN0a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 08:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWCLN0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 08:26:30 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:44691 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750830AbWCLN0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 08:26:30 -0500
Date: Sun, 12 Mar 2006 14:26:22 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 5/8] hrtimer remove state field
In-Reply-To: <1142169010.19916.397.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0603121422180.16802@scrub.home>
References: <20060312080316.826824000@localhost.localdomain> 
 <20060312080332.274315000@localhost.localdomain>  <Pine.LNX.4.64.0603121302590.16802@scrub.home>
 <1142169010.19916.397.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 12 Mar 2006, Thomas Gleixner wrote:

> > BTW the active check can be removed again, as it was added for a state 
> > machine problem, I only didn't want to remove it for 2.6.16.
> 
> The check can not be removed. The reason why it was added is still the
> same. 
> 
> It has nothing to do with a state machine. It's a simple SMP locking
> issue.
> 
> softirq runs on CPU0
> base->lock()
> 
> remove_timer(timer);
> 
> base->unlock()
> 			signal of previous expiry is delivered on CPU1
> 			timer is reqeued.
> requeue = timer->fn();
> 
> base->lock()
> 
> if (requeue)
> 	enqueue_timer(timer)
> 
> --> OOPS
> 
> We can not wait in the signal delivery path until the callback has been
> executed, as we hold the posix-timer->lock and this would deadlock
> timer->fn().

posix_timer either restarts the timer directly or via signal delivery, but 
never both, so this case can't happen (unless there is a bug in the 
posix_timer).

bye, Roman
