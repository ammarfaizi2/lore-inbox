Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263338AbUEWS7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbUEWS7x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 14:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbUEWS7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 14:59:53 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:25741 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263338AbUEWS7v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 14:59:51 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 23 May 2004 11:59:01 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: scheduler: IRQs disabled over context switches
In-Reply-To: <20040523174359.A21153@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0405231125420.512@bigblue.dev.mdolabs.com>
References: <20040523174359.A21153@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 May 2004, Russell King wrote:

> The 2.6.6 scheduler disables IRQs across context switches, which is
> bad news for IRQ latency on ARM - to the point where 16550A FIFO
> UARTs to overrun.
> 
> I'm considering defining prepare_arch_switch & co as follows on ARM,
> so that we release IRQs over the call to context_switch().
> 
> #define prepare_arch_switch(rq,next)		\
> do {						\
> 	spin_lock(&(next)->switch_lock);	\
> 	spin_unlock_irq(&(rq)->lock);		\
> } while (0)
> #define finish_arch_switch(rq,prev)		\
> 	spin_unlock(&(prev)->switch_lock)
> #define task_running(rq,p)			\
> 	((rq)->curr == (p) || spin_is_locked(&(p)->switch_lock))
> 
> The question is... why are we keeping IRQs disabled over context_switch()
> in the first case?  Looking at the code, the only thing which is touched
> outside of the two tasks is rq->prev_mm.  Since runqueues are CPU-
> specific and we're holding at least one spinlock, I think the above
> is preempt safe and SMP safe.

Other archs already do the above. The only reason I can think of is an 
optimization issue. The above code does a spin_lock/unlock more than the 
default code. For archs where the ctx switch is fast, this might matter.
Whereas archs with slow ctx switch might want to use the above code to 
reduce IRQ latency. Also, if the ctx switch code involves acquiring some 
"external" spinlock, care should be taken to verify that cross-lock 
happens (see ia64 code for example). IMO, if this is an optimization 
issue, and if the thing does not buy us much in terms of performance, I'd 
rather use the above code as default. Ingo?



- Davide

