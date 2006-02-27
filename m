Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751688AbWB0JRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbWB0JRr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 04:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbWB0JRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 04:17:47 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:9379 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750909AbWB0JRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 04:17:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=u2ckx7qo4e0BHAwSoKd9XCKYQHkSRaA9URF7Qills+7P//fKGLqMgTPNArWE1VWL/Vx59XP7WvS/7a5gOp60EV0r7H1YhYA2g9RTzrBBonrhYSBcQnnBEGV9z+AoI7qD1Kq+T13dsisynt3IJUfHJujbzKe+HLmwIZ6LU3Gu/pI=  ;
Message-ID: <4402C3BB.7010705@yahoo.com.au>
Date: Mon, 27 Feb 2006 20:17:47 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: nagar@watson.ibm.com
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Patch 2/7] Add sysctl for schedstats
References: <1141026996.5785.38.camel@elinux04.optonline.net>	 <1141027367.5785.42.camel@elinux04.optonline.net> <1141027923.5785.50.camel@elinux04.optonline.net>
In-Reply-To: <1141027923.5785.50.camel@elinux04.optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:
> schedstats-sysctl.patch
> 
> Add sysctl option for controlling schedstats collection
> dynamically. Delay accounting leverages schedstats for
> cpu delay statistics.
> 

I'd sort of rather not tie this in with schedstats if possible.
Schedstats adds a reasonable amount of cache footprint and
branches in hot paths. Most of schedstats stuff is something that
hardly anyone will use.

Sure you can share common code though...

>  
> Index: linux-2.6.16-rc4/kernel/sched.c
> ===================================================================
> --- linux-2.6.16-rc4.orig/kernel/sched.c	2006-02-27 01:20:04.000000000 -0500
> +++ linux-2.6.16-rc4/kernel/sched.c	2006-02-27 01:52:52.000000000 -0500
> @@ -382,11 +382,56 @@ static inline void task_rq_unlock(runque
>  }
>  
>  #ifdef CONFIG_SCHEDSTATS
> +
> +int schedstats_sysctl = 0;		/* schedstats turned off by default */

Should be read mostly.

> +static DEFINE_PER_CPU(int, schedstats) = 0;
> +

When the above is in the read mostly section, you won't need this at all.

You don't intend to switch the sysctl with great frequency, do you?

> +static void schedstats_set(int val)
> +{
> +	int i;
> +	static spinlock_t schedstats_lock = SPIN_LOCK_UNLOCKED;
> +
> +	spin_lock(&schedstats_lock);
> +	schedstats_sysctl = val;
> +	for (i = 0; i < NR_CPUS; i++)
> +		per_cpu(schedstats, i) = val;
> +	spin_unlock(&schedstats_lock);
> +}
> +
> +static int __init schedstats_setup_enable(char *str)
> +{
> +	schedstats_sysctl = 1;
> +	schedstats_set(schedstats_sysctl);
> +	return 1;
> +}
> +
> +__setup("schedstats", schedstats_setup_enable);
> +
> +int schedstats_sysctl_handler(ctl_table *table, int write, struct file *filp,
> +			void __user *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int ret, prev = schedstats_sysctl;
> +	struct task_struct *g, *t;
> +
> +	ret = proc_dointvec(table, write, filp, buffer, lenp, ppos);
> +	if ((ret != 0) || (prev == schedstats_sysctl))
> +		return ret;
> +	if (schedstats_sysctl) {
> +		read_lock(&tasklist_lock);
> +		do_each_thread(g, t) {
> +			memset(&t->sched_info, 0, sizeof(t->sched_info));
> +		} while_each_thread(g, t);
> +		read_unlock(&tasklist_lock);
> +	}
> +	schedstats_set(schedstats_sysctl);

You don't clear the rq's schedstats stuff here.

And clearing this at all is not really needed for the schedstats interface.
You have a timestamp and a set of accumulated values, so it is easy to work
out deltas. So do you need this?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
