Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935062AbWKXVNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935062AbWKXVNN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 16:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935063AbWKXVNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 16:13:13 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:50152 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S935062AbWKXVNM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 16:13:12 -0500
Date: Sat, 25 Nov 2006 00:13:00 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061124211300.GA102@oleg>
References: <20061124182153.GA9868@oleg> <Pine.LNX.4.44L0.0611241545400.16422-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0611241545400.16422-100000@netrider.rowland.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24, Alan Stern wrote:
>
> On Fri, 24 Nov 2006, Oleg Nesterov wrote:
> 
> > Ok, synchronize_xxx() passed 1 hour rcutorture test on dual P-III.
> > 
> > It behaves the same as srcu but optimized for writers. The fast path
> > for synchronize_xxx() is mutex_lock() + atomic_read() + mutex_unlock().
> > The slow path is __wait_event(), no polling. However, the reader does
> > atomic inc/dec on lock/unlock, and the counters are not per-cpu.
> > 
> > Jens, is it ok for you? Alan, Paul, what is your opinion?
> 
> Given that you aren't using per-cpu data, why not just rely on a spinlock?

I thought about this too, and we can re-use sp->wq.lock,

> Then everything will be simple and easy to verify,

xxx_read_lock() will be simpler, but not too much. synchronize_xxx() needs
some complication.

>                                                     with no need to worry 
> about atomic instructions or memory barriers.

spin_lock() + spin_unlock() doesn't imply mb(), it allows subsequent loads
to move into the the critical region.

I personally prefer this way, but may be you are right.

Oleg.

