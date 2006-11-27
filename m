Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758407AbWK0Q5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758407AbWK0Q5K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 11:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758412AbWK0Q5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 11:57:09 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:47512 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1758407AbWK0Q5I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 11:57:08 -0500
Date: Mon, 27 Nov 2006 19:56:49 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Jens Axboe <jens.axboe@oracle.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061127165649.GB279@oleg>
References: <Pine.LNX.4.64.0611161414580.3349@woody.osdl.org> <Pine.LNX.4.44L0.0611162148360.24994-100000@netrider.rowland.org> <20061117065128.GA5452@us.ibm.com> <20061117092925.GT7164@kernel.dk> <20061119190027.GA3676@oleg> <20061123145910.GA145@oleg> <20061124182153.GA9868@oleg> <20061127050247.GC5021@us.ibm.com> <20061127161106.GA279@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061127161106.GA279@oleg>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27, Oleg Nesterov wrote:
>
> so synchronize_xxx() should be
> 
> 	void synchronize_xxx(struct xxx_struct *sp)
> 	{
> 		int idx;
> 
> 		smp_mb();
> 		mutex_lock(&sp->mutex);
> 
> 		idx = sp->completed & 0x1;
> 		if (atomic_read(sp->ctr + idx) == 1)
> 			goto out;
> 
> 		atomic_inc(sp->ctr + (idx ^ 0x1));
> 		sp->completed++;
> 
> 		atomic_dec(sp->ctr + idx);
> 		wait_event(sp->wq, !atomic_read(sp->ctr + idx));
> 	out:
> 		mutex_unlock(&sp->mutex);
> 	}
> 
> Yes, Alan was right, spinlock_t makes the code simpler.

Damn, it needs another mb() at the end,

	void synchronize_xxx(struct xxx_struct *sp)
	{
		int idx;

		smp_mb();
		mutex_lock(&sp->mutex);

		idx = sp->completed & 0x1;
		if (atomic_read(sp->ctr + idx) == 1)
			goto out;

		atomic_inc(sp->ctr + (idx ^ 0x1));
		sp->completed++;

		atomic_dec(sp->ctr + idx);
		wait_event(sp->wq, !atomic_read(sp->ctr + idx));
	out:
		mutex_unlock(&sp->mutex);
		smp_mb();
	}

Oleg.

