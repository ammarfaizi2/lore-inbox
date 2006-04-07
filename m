Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWDGSUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWDGSUq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 14:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWDGSUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 14:20:46 -0400
Received: from dvhart.com ([64.146.134.43]:20168 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S964844AbWDGSUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 14:20:46 -0400
Message-ID: <4436AD7D.5070307@mbligh.org>
Date: Fri, 07 Apr 2006 11:20:45 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: wierd failures from -mm1
References: <4436AA05.7020203@mbligh.org> <1144433309.24221.7.camel@localhost.localdomain>
In-Reply-To: <1144433309.24221.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Fri, 2006-04-07 at 11:05 -0700, Martin Bligh wrote:
> 
>>http://test.kernel.org/abat/27596/debug/console.log
>>Hangs after bringing up cpus. 
> 
> 
> See attached patch.  It fixes curly.

Splendid -thanks. This may well fix the first two ... I think the reiser
thing is likely still borked though.

M.

> -- Dave
> 
> 
> ------------------------------------------------------------------------
> 
> Subject:
> [PATCH 2.6.17-rc1-mm1] sched_domain-handle-kmalloc-failure-fix
> From:
> Lee Schermerhorn <Lee.Schermerhorn@hp.com>
> Date:
> Thu, 06 Apr 2006 15:58:47 -0400
> To:
> linux-kernel <linux-kernel@vger.kernel.org>
> 
> To:
> linux-kernel <linux-kernel@vger.kernel.org>
> CC:
> Andrew Morton <akpm@osdl.org>, Eric Whitney <eric.whitney@hp.com>
> 
> 
> [PATCH] sched_domain-handle-kmalloc-failure-fix
> 
> 2.6.17-rc1-mm1 hangs during boot on HP rx8620 and dl585 -- both 4 node
> NUMA platforms.  Problem is in build_sched_domains() setting up the
> sched_group_nodes[] lists, resulting from patch:
> sched_domain-handle-kmalloc-failure.patch
> 
> The referenced patch does not propagate the "next" pointer from the head
> of the list, resulting in a loop between the last 2 groups in the list.
> This causes a tight loop/hang in init_numa_sched_groups_power() because 
> 'sg->next' never == 'group_head' when you have > 2 nodes.
> 
> This patch seems to fix the problem.  
> 
> Signed-off-by:  Lee Schermerhorn <lee.schermerhorn@hp.com>
> 
> Index: linux-2.6.17-rc1-mm1/kernel/sched.c
> ===================================================================
> --- linux-2.6.17-rc1-mm1.orig/kernel/sched.c	2006-04-06 15:18:32.000000000 -0400
> +++ linux-2.6.17-rc1-mm1/kernel/sched.c	2006-04-06 15:20:49.000000000 -0400
> @@ -6360,7 +6360,7 @@ static int build_sched_domains(const cpu
>  			}
>  			sg->cpu_power = 0;
>  			sg->cpumask = tmp;
> -			sg->next = prev;
> +			sg->next = prev->next;
>  			cpus_or(covered, covered, tmp);
>  			prev->next = sg;
>  			prev = sg;
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

