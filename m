Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265336AbSJXHtB>; Thu, 24 Oct 2002 03:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265339AbSJXHtB>; Thu, 24 Oct 2002 03:49:01 -0400
Received: from [202.88.156.6] ([202.88.156.6]:2993 "EHLO saraswati.hathway.com")
	by vger.kernel.org with ESMTP id <S265336AbSJXHtA>;
	Thu, 24 Oct 2002 03:49:00 -0400
Date: Thu, 24 Oct 2002 13:20:04 +0530
From: Dipankar Sarma <dipankar@gamebox.net>
To: Corey Minyard <cminyard@mvista.com>
Cc: linux-kernel@vger.kernel.org, John Levon <levon@movementarian.org>
Subject: Re: [PATCH] NMI request/release, version 4
Message-ID: <20021024132004.A29039@dikhow>
Reply-To: dipankar@gamebox.net
References: <20021022232345.A25716@dikhow> <3DB59385.6050003@mvista.com> <20021022233853.B25716@dikhow> <3DB59923.9050002@mvista.com> <20021022190818.GA84745@compsoc.man.ac.uk> <3DB5C4F3.5030102@mvista.com> <20021023230327.A27020@dikhow> <3DB6E45F.5010402@mvista.com> <20021024002741.A27739@dikhow> <3DB7033C.1090807@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DB7033C.1090807@mvista.com>; from cminyard@mvista.com on Wed, Oct 23, 2002 at 03:14:52PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, some more comments -

On Wed, Oct 23, 2002 at 03:14:52PM -0500, Corey Minyard wrote:
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

Can release_nmi() be done from irq context ? If not, I don't see
why spin_lock_irqsave() is required here. If it can be called
from irq context, then I can't see how you can schedule()
(or wait_for_completion() for that matter :)).

Thanks
Dipankar
