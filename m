Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266025AbUARBms (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 20:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266205AbUARBms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 20:42:48 -0500
Received: from smtp2.fre.skanova.net ([195.67.227.95]:39402 "EHLO
	smtp2.fre.skanova.net") by vger.kernel.org with ESMTP
	id S266025AbUARBmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 20:42:46 -0500
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove sleep_on from sunrpc
References: <40098260.20800@colorfullife.com>
From: Peter Osterlund <petero2@telia.com>
Date: 18 Jan 2004 02:45:36 +0100
In-Reply-To: <40098260.20800@colorfullife.com>
Message-ID: <m2wu7qf2rj.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> writes:

> -	while (rpciod_pid) {
> +	add_wait_queue(&rpciod_killer, &wait);
> +	for (;;) {
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		if (rpciod_pid == 0)
> +			break;
>  		dprintk("rpciod_down: waiting for pid %d to exit\n", rpciod_pid);
>  		if (signalled()) {
>  			dprintk("rpciod_down: caught signal\n");
>  			break;
>  		}
> -		interruptible_sleep_on(&rpciod_killer);
> +		schedule();
>  	}
> -	spin_lock_irqsave(&current->sighand->siglock, flags);
> +	remove_wait_queue(&rpciod_killer, &wait);
> +	spin_lock_irq(&current->sighand->siglock);
>  	recalc_sigpending();
> -	spin_unlock_irqrestore(&current->sighand->siglock, flags);
> +	spin_unlock_irq(&current->sighand->siglock);
>  out:
>  	up(&rpciod_sema);
>  }

Aren't you forgetting to set_current_state(TASK_RUNNING) after the
loop?

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
