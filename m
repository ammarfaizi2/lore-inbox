Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265189AbSJWUta>; Wed, 23 Oct 2002 16:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265194AbSJWUta>; Wed, 23 Oct 2002 16:49:30 -0400
Received: from [202.88.156.6] ([202.88.156.6]:65196 "EHLO
	saraswati.hathway.com") by vger.kernel.org with ESMTP
	id <S265189AbSJWUt3>; Wed, 23 Oct 2002 16:49:29 -0400
Date: Thu, 24 Oct 2002 02:20:26 +0530
From: Dipankar Sarma <dipankar@gamebox.net>
To: Corey Minyard <cminyard@mvista.com>
Cc: linux-kernel@vger.kernel.org, John Levon <levon@movementarian.org>
Subject: Re: [PATCH] NMI request/release, version 4
Message-ID: <20021024022026.D27739@dikhow>
Reply-To: dipankar@gamebox.net
References: <20021022232345.A25716@dikhow> <3DB59385.6050003@mvista.com> <20021022233853.B25716@dikhow> <3DB59923.9050002@mvista.com> <20021022190818.GA84745@compsoc.man.ac.uk> <3DB5C4F3.5030102@mvista.com> <20021023230327.A27020@dikhow> <3DB6E45F.5010402@mvista.com> <20021024002741.A27739@dikhow> <3DB7033C.1090807@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DB7033C.1090807@mvista.com>; from cminyard@mvista.com on Wed, Oct 23, 2002 at 03:14:52PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I haven't looked at the whole patch yet, but some quick
responses -

On Wed, Oct 23, 2002 at 03:14:52PM -0500, Corey Minyard wrote:
> I have noticed that the rcu callback can be delayed a long time, 
> sometimes up to 3 seconds.  That seems odd.  I have verified that the 
> delay happens there.

That kind of latency is really bad. Could you please check the latency 
with this change in kernel/rcupdate.c -

 void rcu_check_callbacks(int cpu, int user)
 {
        if (user ||
-           (idle_cpu(cpu) && !in_softirq() && hardirq_count() <= 1))
+           (idle_cpu(cpu) && !in_softirq() &&
+                               hardirq_count() <= (1 << HARDIRQ_SHIFT)))
                RCU_qsctr(cpu)++;
        tasklet_schedule(&RCU_tasklet(cpu));

After local_irq_count() went away, the idle CPU check was broken
and that meant that if you had an idle CPU, it could hold up RCU
grace period completion.


> +void release_nmi(struct nmi_handler *handler)
> +{
> +	wait_queue_t  q_ent;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&nmi_handler_lock, flags);
> +	list_del_rcu(&(handler->link));
> +
> +	/* Wait for handler to finish being freed.  This can't be
> +           interrupted, we must wait until it finished. */
> +	init_waitqueue_head(&(handler->wait));
> +	init_waitqueue_entry(&q_ent, current);
> +	add_wait_queue(&(handler->wait), &q_ent);
> +	call_rcu(&(handler->rcu), free_nmi_handler, handler);
> +	for (;;) {
> +		set_current_state(TASK_UNINTERRUPTIBLE);
> +		if (list_empty(&(handler->link)))
> +			break;
> +		spin_unlock_irqrestore(&nmi_handler_lock, flags);
> +		schedule();
> +		spin_lock_irqsave(&nmi_handler_lock, flags);
> +	}
> +	remove_wait_queue(&(handler->wait), &q_ent);
> +	spin_unlock_irqrestore(&nmi_handler_lock, flags);
> +}

It might just be simpler to use completions instead -

	call_rcu(&(handler->rcu), free_nmi_handler, handler);
	init_completion(&handler->completion);
	spin_unlock_irqrestore(&nmi_handler_lock, flags);
	wait_for_completion(&handler->completion);

and do

	complete(&handler->completion);

in the  the RCU callback.

Also, now I think your original idea of "Don't do this!" :) was right.
Waiting until an nmi handler is seen unlinked could make a task
block for a long time if another task re-installs it. You should
probably just fail installation of a busy handler (checked under
lock).


Thanks
Dipankar
