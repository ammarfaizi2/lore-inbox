Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279674AbRJ3AJL>; Mon, 29 Oct 2001 19:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279664AbRJ3AIy>; Mon, 29 Oct 2001 19:08:54 -0500
Received: from t02-11.ra.uc.edu ([129.137.228.35]:25984 "EHLO cartman")
	by vger.kernel.org with ESMTP id <S279662AbRJ3AIr>;
	Mon, 29 Oct 2001 19:08:47 -0500
Date: Mon, 29 Oct 2001 19:08:17 -0500
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 8139too termination
Message-ID: <20011029190817.B320@cartman>
In-Reply-To: <20011029181029.A320@cartman> <3BDDE5DF.71917D8F@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BDDE5DF.71917D8F@zip.com.au>
User-Agent: Mutt/1.3.23i
From: Robert Kuebel <kuebelr@email.uc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 	tp->diediedie = 1;
> 	wmb();
> 	ret = kill_proc(...);
> 
> and test the flag in rtl8139_thread().
> 

i had something like that in mind.

> The tricky part is teaching the thread to ignore the
> spurious signals - the signal_pending() state needs to be
> cleared.  I think flush_signals() is the way to do this.
> See context_thread() for an example.
> 
>            spin_lock_irq(&curtask->sigmask_lock);
>            flush_signals(curtask);
>            recalc_sigpending(curtask);
>            spin_unlock_irq(&curtask->sigmask_lock);
> 
> The recalc_sigpending() here appears to be unnecessary...
> 

what about changing doing
	spin_lock_irq(&current->sigmask_lock);
	sigfillset(&current->blocked);	/* block all sig's */
	recalc_sigpending(current);
	spin_unlock_irq(&current->sigmask_lock);

instead of 

	spin_lock_irq(&current->sigmask_lock);
	sigemptyset(&current->blocked);  
	recalc_sigpending(current);
	spin_unlock_irq(&current->sigmask_lock);

and replacing the signal_pending() stuff in the loops of
rtl8139_thread() with checks for tp->diediedie?


