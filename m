Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVEaJqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVEaJqX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 05:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVEaJqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 05:46:23 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:39849 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261480AbVEaJqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 05:46:20 -0400
Message-ID: <429C3265.4010704@yahoo.com.au>
Date: Tue, 31 May 2005 19:46:13 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Shaohua Li <shaohua.li@intel.com>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Rusty Russell <rusty@rustcorp.com.au>, ashok.raj@intel.com
Subject: Re: [PATCH]CPU hotplug breaks wake_up_new_task
References: <1117524909.3820.11.camel@linux-hp.sh.intel.com> <20050531094045.GA9884@in.ibm.com>
In-Reply-To: <20050531094045.GA9884@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Tue, May 31, 2005 at 07:29:39AM +0000, Shaohua Li wrote:
> 
>>Hi,
>>There is a race condition at wake_up_new_task at CPU hotplug case.
>>Say do_fork
>>        copy_process (which sets new forked task's current cpu, cpu_allowed)
>>                <-------- the new forked task's current cpu is offline
>>        wake_up_new_task
>>wake_up_new_task will put the forked task into a dead cpu.
> 
> 
> This was noticed/fixed long back. Apparently somebody has reintroduced
> the bug. The simple fix for this race is:
> 

If you're looking at the -mm tree, then I think I must
have reintroduced the bug. It needs a comment.

> 
> --- kernel/fork.c.org	2005-05-31 14:57:15.000000000 +0530
> +++ kernel/fork.c	2005-05-31 15:07:20.000000000 +0530
> @@ -1024,8 +1024,7 @@ static task_t *copy_process(unsigned lon
>  	 * parent's CPU). This avoids alot of nasty races.
>  	 */
>  	p->cpus_allowed = current->cpus_allowed;
> -	if (unlikely(!cpu_isset(task_cpu(p), p->cpus_allowed)))
> -		set_task_cpu(p, smp_processor_id());
> +	set_task_cpu(p, smp_processor_id());
>  
>  	/*
>  	 * Check for pending SIGKILL! The new thread should not be allowed
> 
> Could you test and check if it avoids whatever problem you are seeing?
> 
> 

And this patch will break balance-on-fork.
How about conditionally setting task_cpu if the task's current
CPU is offline?

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
