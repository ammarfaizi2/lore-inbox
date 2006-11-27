Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934363AbWK0WjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934363AbWK0WjY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 17:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934369AbWK0WjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 17:39:24 -0500
Received: from smtp.osdl.org ([65.172.181.25]:45273 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S934363AbWK0WjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 17:39:24 -0500
Date: Mon, 27 Nov 2006 14:38:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Caputo <ccaputo@alt.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       trivial@kernel.org
Subject: Re: [PATCH 2.6.19-rc6] sched: cleanup output of
 show_state/show_task
Message-Id: <20061127143813.a9f4f696.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611250416240.10489@nacho.alt.net>
References: <Pine.LNX.4.64.0611250416240.10489@nacho.alt.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2006 04:48:15 +0000 (GMT)
Chris Caputo <ccaputo@alt.net> wrote:

> 
> This patch cleans up the output of show_state/task() (aka magic-sysrq-t) 
> so that free stack space is printed as appropriate based on 
> CONFIG_DEBUG_STACK_USAGE.
> 
> Also, without this patch the header is not aligned with the data and is 
> thus confusing.  Free stack is labeled as pid, pid is labeled as father, 
> and so on.
> 
> Signed-off-by: Chris Caputo <ccaputo@alt.net>
> ---
> 
> diff -uprN a/kernel/sched.c b/kernel/sched.c
> --- a/kernel/sched.c	2006-11-25 04:11:12.000000000 +0000
> +++ b/kernel/sched.c	2006-11-25 04:13:07.000000000 +0000
> @@ -4757,7 +4757,6 @@ static const char stat_nam[] = "RSDTtZX"
>  static void show_task(struct task_struct *p)
>  {
>  	struct task_struct *relative;
> -	unsigned long free = 0;
>  	unsigned state;
>  
>  	state = p->state ? __ffs(p->state) + 1 : 0;
> @@ -4779,10 +4778,10 @@ static void show_task(struct task_struct
>  		unsigned long *n = end_of_stack(p);
>  		while (!*n)
>  			n++;
> -		free = (unsigned long)n - (unsigned long)end_of_stack(p);
> +		printk("%5lu ", (unsigned long)n - (unsigned long)end_of_stack(p));
>  	}
>  #endif
> -	printk("%5lu %5d %6d ", free, p->pid, p->parent->pid);
> +	printk("%5d %6d ", p->pid, p->parent->pid);

This will cause the output format to be dependent upon the setting of
CONFIG_DEBUG_STACK_USAGE.  So any code which attempts to parse the output
of this function will somehow need to work out whether or not the `free'
field is present.

Which is why we still print out a zero if CONFIG_DEBUG_STACK_USAGE=n.
