Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967681AbWK3ABY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967681AbWK3ABY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 19:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936117AbWK3ABY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 19:01:24 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:29912 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S936113AbWK3ABX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 19:01:23 -0500
Date: Thu, 30 Nov 2006 03:01:20 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Jens Axboe <jens.axboe@oracle.com>,
       linux-kernel@vger.kernel.org, davem@davemloft.net, dhowells@redhat.com
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061130000120.GA999@oleg>
References: <20061117065128.GA5452@us.ibm.com> <20061117092925.GT7164@kernel.dk> <20061119190027.GA3676@oleg> <20061123145910.GA145@oleg> <20061124182153.GA9868@oleg> <20061127050247.GC5021@us.ibm.com> <20061127161106.GA279@oleg> <20061129192953.GA2335@us.ibm.com> <20061129201646.GA81@oleg> <20061129230818.GE2335@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129230818.GE2335@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29, Paul E. McKenney wrote:
>
> On Wed, Nov 29, 2006 at 11:16:46PM +0300, Oleg Nesterov wrote:
> > 
> > Hmm... SRCU can't be used from irq, yes. But I think that both versions
> > (spinlock needs _irqsave) can ?
> 
> I didn't think you could call wait_event() from irq.

Ah, sorry for confusion, I talked only about read lock/unlock of course.

Just in case, it is not safe to do srcu_read_{,un}lock() from irq,

	per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]++
	                                                  ^^^^^^^^
we need local_t for that.

> For the locked version, you would also need spin_lock_irqsave() or some
> such to avoid self-deadlock.
> 
> For the atomic version, the fact that synchronize_qrcu() increments
> the new counter before decrmenting the old one should mean that calls
> to qrcu_read_lock() and qrcu_read_unlock() can be called from irq.

Yes, exactly! There is another reason, suppose we did

	qp->completed++;
	atomic_inc(qp->ctr + (idx ^ 0x1));

In that case the reader could be stalled if synchronize_qrcu() takes a
preemption in between.

> But synchronize_qrcu() must be called from process context, since it
> can block.

Surely.

Oleg.

