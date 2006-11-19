Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933476AbWKSW3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933476AbWKSW3F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 17:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933479AbWKSW3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 17:29:04 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:5568 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S933476AbWKSW3C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 17:29:02 -0500
Date: Mon, 20 Nov 2006 01:28:47 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Jens Axboe <jens.axboe@oracle.com>,
       Linus Torvalds <torvalds@osdl.org>, Thomas Gleixner <tglx@timesys.com>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>, David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, manfred@colorfullife.com
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061119222847.GA189@oleg>
References: <20061119205516.GA117@oleg> <Pine.LNX.4.44L0.0611191606580.20262-100000@netrider.rowland.org> <20061119211731.GA151@oleg> <20061119215421.GK4427@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061119215421.GK4427@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19, Paul E. McKenney wrote:
>
> On Mon, Nov 20, 2006 at 12:17:31AM +0300, Oleg Nesterov wrote:
> > 
> > It will wait for xxx_read_unlock() on reader's side. And for this reason
> > this idx in fact is not exactly wrong :)
> 
> I am not seeing this.
> 
> Let's assume sp->completed starts out zero.
> 
> o	CPU 0 starts executing xxx_read_lock(), but is interrupted
> 	(or whatever) just before the atomic_inc().  Upon return,
> 	it will increment sp->ctr[0].

Right.

> o	CPU 1 executes synchronize_xxx() to completion, which it
> 	can because CPU 0 has not yet incremented the counter.
> 	It waited on sp->ctr[0], and incremented sp->completed to 1.
> 
> o	CPU 0 returns from interrupt and completes xxx_read_lock(),
> 	but has incremented sp->ctr[0].
> 
> o	CPU 0 continues into its critical section, picking up a
> 	pointer to an xxx-protected data structure (or, in Jens's
> 	case starting an xxx-protected I/O).
> 
> o	CPU 1 executes another synchronize_xxx().  This completes
> 	immediately because it is waiting for sp->ctr[1] to go
> 	to zero, but CPU 0 incremented sp->ctr[0].  (Right?)

Right!

> o	CPU 1 continues, either freeing a data structure while
> 	CPU 0 is still referencing it, or, in Jens's case, completing
> 	an I/O barrier while there is still outstanding I/O.
> 
> Or am I missing something?

No, it is me.

Alan, Paul, thanks a lot for your patience!

Oleg.

