Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263163AbUEXHK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbUEXHK4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 03:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbUEXHK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 03:10:56 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:51316 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263163AbUEXHKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 03:10:52 -0400
Message-ID: <40B19FF8.2050402@yahoo.com.au>
Date: Mon, 24 May 2004 17:10:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       rmk+lkml@arm.linux.org.uk
Subject: Re: scheduler: IRQs disabled over context switches
References: <20040523174359.A21153@flint.arm.linux.org.uk> <20040524083715.GA24967@elte.hu> <Pine.LNX.4.58.0405232340070.2676@bigblue.dev.mdolabs.com> <20040524090538.GA26183@elte.hu>
In-Reply-To: <20040524090538.GA26183@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Davide Libenzi <davidel@xmailserver.org> wrote:
> 
> 
>>We used to do it in 2.4. What changed to make it fragile? The
>>threading (TLS) thing?
> 
> 
> it _should_ work, but in the past we only had trouble from such changes
> (at least in the O(1) tree of scheduling - 2.4 scheduler is OK.). We
> could try the patch below. It certainly boots on SMP x86. But it causes
> a 3.5% slowdown in lat_ctx so i'd not do it unless there are some really
> good reasons.
> 
> 	Ingo
> 
> --- linux/kernel/sched.c.orig	
> +++ linux/kernel/sched.c	
> @@ -247,9 +247,15 @@ static DEFINE_PER_CPU(struct runqueue, r
>   * Default context-switch locking:
>   */
>  #ifndef prepare_arch_switch
> -# define prepare_arch_switch(rq, next)	do { } while (0)
> -# define finish_arch_switch(rq, next)	spin_unlock_irq(&(rq)->lock)
> -# define task_running(rq, p)		((rq)->curr == (p))
> +# define prepare_arch_switch(rq, next)				\
> +		do {						\
> +			spin_lock(&(next)->switch_lock);	\
> +			spin_unlock(&(rq)->lock);		\

spin_unlock_irq?
