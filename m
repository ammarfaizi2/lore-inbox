Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbVJWUuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVJWUuV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 16:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbVJWUuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 16:50:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22431 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750765AbVJWUuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 16:50:19 -0400
Date: Sun, 23 Oct 2005 13:49:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: minyard@acm.org
Cc: linux-kernel@vger.kernel.org, Matt_Domsch@dell.com
Subject: Re: [PATCH 9/9] ipmi: add timer thread
Message-Id: <20051023134934.1b81d9c6.akpm@osdl.org>
In-Reply-To: <20051021145835.GI19532@i2.minyard.local>
References: <20051021145835.GI19532@i2.minyard.local>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard <minyard@acm.org> wrote:
>
> We must poll for responses to commands when interrupts aren't in use.
> The default poll interval is based on using a kernel timer, which
> varies with HZ.  For character-based interfaces like KCS and SMIC
> though, that can be way too slow (>15 minutes to flash a new firmware
> with KCS, >20 seconds to retrieve the sensor list).
> 
> This creates a low-priority kernel thread to poll more often.  If the
> state machine is idle, so is the kernel thread.  But if there's an
> active command, it polls quite rapidly.  This decrease a firmware
> flash time from 15 minutes to 1.5 minutes, and the sensor list time to
> 4.5 seconds, on a Dell PowerEdge x8x system.
> 
> The timer-based polling remains, to ensure some amount of
> responsiveness even under high user process CPU load.
> 
> Checking for a stopped timer at rmmod now uses atomics and
> del_timer_sync() to ensure safe stoppage.
> 
> ...
>
> +static int ipmi_thread(void *data)
> +{
> +	struct smi_info *smi_info = data;
> +	unsigned long flags, last=1;
> +	enum si_sm_result smi_result;
> +
> +	daemonize("kipmi%d", smi_info->intf_num);
> +	allow_signal(SIGKILL);
> +	set_user_nice(current, 19);
> +	while (!atomic_read(&smi_info->stop_operation)) {
> +		schedule_timeout(last);
> +		spin_lock_irqsave(&(smi_info->si_lock), flags);
> +		smi_result=smi_event_handler(smi_info, 0);
> +		spin_unlock_irqrestore(&(smi_info->si_lock), flags);
> +		if (smi_result == SI_SM_CALL_WITHOUT_DELAY)
> +			last = 0;
> +		else if (smi_result == SI_SM_CALL_WITH_DELAY) {
> +			udelay(1);
> +			last = 0;
> +		}
> +		else {
> +			/* System is idle; go to sleep */
> +			last = 1;
> +			current->state = TASK_INTERRUPTIBLE;
> +		}
> +	}
> +	smi_info->thread_pid = 0;
> +	complete_and_exit(&(smi_info->exiting), 0);
> +	return 0;
> +}

The kthread API would be preferred, please.  That way we avoid using
signals in-kernel too - they're a bit awkward.  (Do you really want
userspace to be able to kill this kernel thread?)

The first call to schedule_timeout() here will not actually sleep at all,
due to it being in state TASK_RUNNING.  Is that deliberate?

Also, this thread can exit in state TASK_INTERUPTIBLE.  That's not a bug
per-se, but apparently it'll spit a warning in some of the patches which
Ingo is working on.  I don't know why, but I'm sure there's a good reason
;)
