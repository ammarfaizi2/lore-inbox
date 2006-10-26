Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423620AbWJZRN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423620AbWJZRN4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 13:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423621AbWJZRN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 13:13:56 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:64606 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1423620AbWJZRNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 13:13:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=3GiuVSTnYE9Iael/Yq3Eewcz3SYjGMLhDZ079Vf+t4PPQs724alfrymOKC9Xf+XRbYxnQzp3/9rCa1XOuJMgMftDX75VBIH98YoN8mGWoei42+jrhU8ZrXUDPIoJ0B6yZFoibE2pNDq9mxdRlKpuZsVasAL/lTKVKM22DO7Uu54=  ;
Message-ID: <4540ECCD.7050700@yahoo.com.au>
Date: Fri, 27 Oct 2006 03:13:49 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: akpm@osdl.org, Peter Williams <pwil3058@bigpond.net.au>,
       linux-kernel@vger.kernel.org,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Chinner <dgc@sgi.com>, Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [PATCH 3/5] Use next_balance instead of last_balance
References: <20061024183104.4530.29183.sendpatchset@schroedinger.engr.sgi.com> <20061024183119.4530.64973.sendpatchset@schroedinger.engr.sgi.com> <4540A676.1070802@yahoo.com.au> <4540AACE.3010804@yahoo.com.au> <Pine.LNX.4.64.0610260924440.16978@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0610260924440.16978@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Thu, 26 Oct 2006, Nick Piggin wrote:
> 
> 
>>Actually, it is wrong, so nack.
>>
>>You didn't take into account that balance_interval may have changed,
>>and so might the idle status.
> 
> 
> Hmmmm... We change the point at which we calculate the interval relative 
> to load balancing. So move it after the load balance. This also avoids 
> having to do the calculation if the sched_domain has not expired.

That still doesn't take into account if the CPU goes idle/busy during
the interval.

> 
> Want a new rollup/testing cycle for all of this?
> 
> Index: linux-2.6.19-rc3/kernel/sched.c
> ===================================================================
> --- linux-2.6.19-rc3.orig/kernel/sched.c	2006-10-26 11:31:04.000000000 -0500
> +++ linux-2.6.19-rc3/kernel/sched.c	2006-10-26 11:41:07.129561438 -0500
> @@ -2867,15 +2867,6 @@ static void rebalance_domains(unsigned l
>  		if (!(sd->flags & SD_LOAD_BALANCE))
>  			continue;
>  
> -		interval = sd->balance_interval;
> -		if (idle != SCHED_IDLE)
> -			interval *= sd->busy_factor;
> -
> -		/* scale ms to jiffies */
> -		interval = msecs_to_jiffies(interval);
> -		if (unlikely(!interval))
> -			interval = 1;
> -
>  		if (jiffies >= sd->next_balance) {
>  			if (load_balance(this_cpu, this_rq, sd, idle)) {
>  				/*
> @@ -2885,6 +2876,14 @@ static void rebalance_domains(unsigned l
>  				 */
>  				idle = NOT_IDLE;
>  			}
> +			interval = sd->balance_interval;
> +			if (idle != SCHED_IDLE)
> +				interval *= sd->busy_factor;
> +
> +			/* scale ms to jiffies */
> +			interval = msecs_to_jiffies(interval);
> +			if (unlikely(!interval))
> +				interval = 1;
>  			sd->next_balance += interval;
>  		}
>  		next_balance = min(next_balance, sd->next_balance);
> 


-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
