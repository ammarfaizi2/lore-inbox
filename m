Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755764AbWKQRhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755764AbWKQRhh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 12:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755766AbWKQRhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 12:37:37 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:19602 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1755759AbWKQRhg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 12:37:36 -0500
Date: Fri, 17 Nov 2006 21:39:45 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Linus Torvalds <torvalds@osdl.org>, Thomas Gleixner <tglx@timesys.com>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>, David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, manfred@colorfullife.com
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061117183945.GA367@oleg>
References: <Pine.LNX.4.64.0611161414580.3349@woody.osdl.org> <Pine.LNX.4.44L0.0611162148360.24994-100000@netrider.rowland.org> <20061117065128.GA5452@us.ibm.com> <20061117092925.GT7164@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117092925.GT7164@kernel.dk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney wrote:
>
>  int srcu_read_lock(struct srcu_struct *sp)
>  {
> @@ -112,11 +126,24 @@ int srcu_read_lock(struct srcu_struct *s
>  
>  	preempt_disable();
>  	idx = sp->completed & 0x1;
> -	barrier();  /* ensure compiler looks -once- at sp->completed. */
> -	per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]++;
> -	srcu_barrier();  /* ensure compiler won't misorder critical section. */
> +	if (likely(sp->per_cpu_ref != NULL)) {
> +		barrier();  /* ensure compiler looks -once- at sp->completed. */
> +		per_cpu_ptr(rcu_dereference(sp->per_cpu_ref),
> +			    smp_processor_id())->c[idx]++;
> +		smp_mb();
> +		preempt_enable();
> +		return idx;
> +	}
>  	preempt_enable();
> -	return idx;
> +	mutex_lock(&sp->mutex);
> +	sp->per_cpu_ref = alloc_srcu_struct_percpu();

We should re-check sp->per_cpu_ref != NULL after taking sp->mutex,
it was probably allocated by another thread.

>  void srcu_read_unlock(struct srcu_struct *sp, int idx)
>  {
> -	preempt_disable();
> -	srcu_barrier();  /* ensure compiler won't misorder critical section. */
> -	per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]--;
> -	preempt_enable();
> +	if (likely(idx != -1)) {
> +		preempt_disable();
> +		smp_mb();
> +		per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]--;
> +		preempt_enable();
> +		return;
> +	}
> +	mutex_lock(&sp->mutex);
> +	sp->hardluckref--;
> +	mutex_unlock(&sp->mutex);
>  }

I think this is deadlockable, synchronize_srcu() does

  	while (srcu_readers_active_idx(sp, idx))
  		schedule_timeout_interruptible(1);

under sp->mutex, so the loop above may spin forever while the reader
waits for sp->mutex in srcu_read_unlock(sp, -1).

Oleg.

