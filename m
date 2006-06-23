Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932771AbWFWBtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932771AbWFWBtF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 21:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932767AbWFWBtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 21:49:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60033 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161009AbWFWBtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 21:49:02 -0400
Date: Thu, 22 Jun 2006 18:48:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [patch 1/3] Drop tasklist lock in do_sched_setscheduler
Message-Id: <20060622184850.29e26ce6.akpm@osdl.org>
In-Reply-To: <20060622082812.492564000@cruncher.tec.linutronix.de>
References: <20060622082758.669511000@cruncher.tec.linutronix.de>
	<20060622082812.492564000@cruncher.tec.linutronix.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 09:08:38 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> 
> There is no need to hold tasklist_lock across the setscheduler call, when we
> pin the task structure with get_task_struct(). Interrupts are disabled in 
> setscheduler anyway and the permission checks do not need interrupts disabled.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
>  kernel/sched.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6.17-mm/kernel/sched.c
> ===================================================================
> --- linux-2.6.17-mm.orig/kernel/sched.c	2006-06-22 10:26:11.000000000 +0200
> +++ linux-2.6.17-mm/kernel/sched.c	2006-06-22 10:26:11.000000000 +0200
> @@ -4140,8 +4140,10 @@
>  		read_unlock_irq(&tasklist_lock);
>  		return -ESRCH;
>  	}
> -	retval = sched_setscheduler(p, policy, &lparam);
> +	get_task_struct(p);
>  	read_unlock_irq(&tasklist_lock);
> +	retval = sched_setscheduler(p, policy, &lparam);
> +	put_task_struct(p);
>  	return retval;
>  }
>  

Is this optimisation actually related to the rt-mutex patches, or to the
other two patches?

