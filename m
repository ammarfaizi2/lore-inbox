Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935587AbWKZVe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935587AbWKZVe3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 16:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758003AbWKZVe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 16:34:29 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:12433 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1758002AbWKZVe2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 16:34:28 -0500
Date: Mon, 27 Nov 2006 00:34:01 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Jens Axboe <jens.axboe@oracle.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061126213401.GA110@oleg>
References: <20061125171438.GA159@oleg> <Pine.LNX.4.44L0.0611251648380.28957-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0611251648380.28957-100000@netrider.rowland.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25, Alan Stern wrote:
>
> Yes, you are right.  The corrected routine (including your little 
> optimization) looks like this:
> 
> void synchronize_xxx(struct xxx_struct *sp)
> {
> 	int idx;
> 
> 	mutex_lock(&sp->mutex);
> 	spin_lock(&sp->lock);
> 	idx = sp->completed & 0x1;
> 	if (sp->ctr[idx] == 1)
> 		goto done;

Actually, this optimization doesn't make sense with spinlocks. If we use
atomic_t the fast path is just atomic_read(), no stores at all. But if we
are doing lock/unlock anyway, it is silly to optimize out '++sp->completed'.

> 	++sp->completed;
> 	--sp->ctr[idx];
> 	sp->ctr[idx ^ 1] = 1;
> 
> 	spin_unlock(&sp->lock);
> 	__wait_event(sp->wq, sp->ctr[idx] == 0);
> 	spin_lock(&sp->lock);
> 
> done:
> 	spin_unlock(&sp->lock);

Oh, please no. The empty critical section is silly. Also, the spinlock based
implementation doesn't need to have additional "reference" in ->ctr[completed].

	struct xxx_struct {
		int completed;
		int ctr[2];
		struct mutex mutex;
		wait_queue_head_t wq;
	};

	void init_xxx_struct(struct xxx_struct *sp)
	{
		sp->completed = 0;
		sp->ctr[0] = sp->ctr[1] = 0;
		mutex_init(&sp->mutex);
		init_waitqueue_head(&sp->wq);
	}

	int xxx_read_lock(struct xxx_struct *sp)
	{
		int idx;

		spin_lock(&sp->lock);
		idx = sp->completed & 0x1;
		sp->ctr[idx]++;
		spin_unlock(&sp->lock);

		return idx;
	}

	void xxx_read_unlock(struct xxx_struct *sp, int idx)
	{
		spin_lock(&sp->lock);
		if (!--sp->ctr[idx])
			wake_up(&sp->wq);
		spin_unlock(&sp->lock);
	}

	void synchronize_xxx(struct xxx_struct *sp)
	{
		int idx;

		mutex_lock(&sp->mutex);

		spin_lock(&sp->lock);
		idx = sp->completed++ & 0x1;
		spin_unlock(&sp->lock);

		wait_event(sp->wq, !sp->ctr[idx]);
		spin_unlock_wait(&sp->lock);

		mutex_unlock(&sp->mutex);
	}

> It may indeed be equivalent.  But _proving_ it is equivalent is certainly 
> not easy.  The advantage of spinlocks is that they remove the necessity 
> for outrageous mental contortions to verify that all possible execution 
> paths will work correctly.
> ...
> It will generally be somewhat slower.

I still like atomic_t more :)  Let's wait for Paul's opinion.

What about naming? synchronize_qrcu?

Oleg

