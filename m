Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263457AbUEWTiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263457AbUEWTiT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 15:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbUEWTiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 15:38:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4111 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263457AbUEWTiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 15:38:17 -0400
Date: Sun, 23 May 2004 20:38:14 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: scheduler: IRQs disabled over context switches
Message-ID: <20040523203814.C21153@flint.arm.linux.org.uk>
Mail-Followup-To: Davide Libenzi <davidel@xmailserver.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20040523174359.A21153@flint.arm.linux.org.uk> <Pine.LNX.4.58.0405231125420.512@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0405231125420.512@bigblue.dev.mdolabs.com>; from davidel@xmailserver.org on Sun, May 23, 2004 at 11:59:01AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 11:59:01AM -0700, Davide Libenzi wrote:
> On Sun, 23 May 2004, Russell King wrote:
> 
> > The 2.6.6 scheduler disables IRQs across context switches, which is
> > bad news for IRQ latency on ARM - to the point where 16550A FIFO
> > UARTs to overrun.
> > 
> > I'm considering defining prepare_arch_switch & co as follows on ARM,
> > so that we release IRQs over the call to context_switch().
> > 
> > #define prepare_arch_switch(rq,next)		\
> > do {						\
> > 	spin_lock(&(next)->switch_lock);	\
> > 	spin_unlock_irq(&(rq)->lock);		\
> > } while (0)
> > #define finish_arch_switch(rq,prev)		\
> > 	spin_unlock(&(prev)->switch_lock)
> > #define task_running(rq,p)			\
> > 	((rq)->curr == (p) || spin_is_locked(&(p)->switch_lock))
> > 
> > The question is... why are we keeping IRQs disabled over context_switch()
> > in the first case?  Looking at the code, the only thing which is touched
> > outside of the two tasks is rq->prev_mm.  Since runqueues are CPU-
> > specific and we're holding at least one spinlock, I think the above
> > is preempt safe and SMP safe.
> 
> Other archs already do the above.

Not quite - look harder.  They use spin_unlock_irq in finish_arch_switch
rather than prepare_arch_switch.

Ralf Baechle mentioned that he thinks the above on MIPS causes some
rare but weird problems, though he wasn't able to give anything
specific at the time.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
