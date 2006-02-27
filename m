Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbWB0Jlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWB0Jlm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 04:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWB0Jlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 04:41:42 -0500
Received: from mta9.srv.hcvlny.cv.net ([167.206.4.204]:39412 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1750924AbWB0Jll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 04:41:41 -0500
Date: Mon, 27 Feb 2006 04:41:40 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [Patch 2/7] Add sysctl for schedstats
In-reply-to: <4402C3BB.7010705@yahoo.com.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Message-id: <4402C954.2080606@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <1141026996.5785.38.camel@elinux04.optonline.net>
 <1141027367.5785.42.camel@elinux04.optonline.net>
 <1141027923.5785.50.camel@elinux04.optonline.net>
 <4402C3BB.7010705@yahoo.com.au>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

<snip>

>> +int schedstats_sysctl_handler(ctl_table *table, int write, struct 
>> file *filp,
>> +            void __user *buffer, size_t *lenp, loff_t *ppos)
>> +{
>> +    int ret, prev = schedstats_sysctl;
>> +    struct task_struct *g, *t;
>> +
>> +    ret = proc_dointvec(table, write, filp, buffer, lenp, ppos);
>> +    if ((ret != 0) || (prev == schedstats_sysctl))
>> +        return ret;
>> +    if (schedstats_sysctl) {
>> +        read_lock(&tasklist_lock);
>> +        do_each_thread(g, t) {
>> +            memset(&t->sched_info, 0, sizeof(t->sched_info));
>> +        } while_each_thread(g, t);
>> +        read_unlock(&tasklist_lock);
>> +    }
>> +    schedstats_set(schedstats_sysctl);
>
>
> You don't clear the rq's schedstats stuff here.

Good point.

>
> And clearing this at all is not really needed for the schedstats 
> interface.
> You have a timestamp and a set of accumulated values, so it is easy to 
> work
> out deltas. So do you need this?

Not clearing the stats will mean userspace has to distinguish between 
the tasks
that are hanging around from before the last turn off, and the ones 
created after
wards. Any delta taken across an interval where schedstats was turned 
off will
give the impression a task was sleeping during the interval (and hence 
show it had
a lesser average wait time than it might actually have experienced). 

--Shailabh
