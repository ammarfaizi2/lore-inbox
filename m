Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263167AbUEWQoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbUEWQoO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 12:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbUEWQoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 12:44:13 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12813 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263167AbUEWQoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 12:44:02 -0400
Date: Sun, 23 May 2004 17:43:59 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: scheduler: IRQs disabled over context switches
Message-ID: <20040523174359.A21153@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The 2.6.6 scheduler disables IRQs across context switches, which is
bad news for IRQ latency on ARM - to the point where 16550A FIFO
UARTs to overrun.

I'm considering defining prepare_arch_switch & co as follows on ARM,
so that we release IRQs over the call to context_switch().

#define prepare_arch_switch(rq,next)		\
do {						\
	spin_lock(&(next)->switch_lock);	\
	spin_unlock_irq(&(rq)->lock);		\
} while (0)
#define finish_arch_switch(rq,prev)		\
	spin_unlock(&(prev)->switch_lock)
#define task_running(rq,p)			\
	((rq)->curr == (p) || spin_is_locked(&(p)->switch_lock))

The question is... why are we keeping IRQs disabled over context_switch()
in the first case?  Looking at the code, the only thing which is touched
outside of the two tasks is rq->prev_mm.  Since runqueues are CPU-
specific and we're holding at least one spinlock, I think the above
is preempt safe and SMP safe.

However, I'd like to find out from someone who knows this code why
IRQs are disabled by default here.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
