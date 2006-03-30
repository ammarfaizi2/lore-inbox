Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWC3QKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWC3QKs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 11:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWC3QKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 11:10:48 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:17117 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750773AbWC3QKq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 11:10:46 -0500
Message-ID: <442C0304.3030003@watson.ibm.com>
Date: Thu, 30 Mar 2006 11:10:44 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch 6/8] virtual cpu run time
References: <442B271D.10208@watson.ibm.com>	<442B2C5D.2020300@watson.ibm.com> <20060329210415.5d84e5a5.akpm@osdl.org>
In-Reply-To: <20060329210415.5d84e5a5.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Shailabh Nagar <nagar@watson.ibm.com> wrote:
>  
>
>>delayacct-virtcpu.patch
>>
>>Distinguish between "wall-clock" and "virtual" cpu run times and return
>>both, at per-task and per-tgid granularity.
>>
>>Some architectures adjust tsk->utime+tsk->stime to reflect the time that
>>the kernel wasn't scheduled in hypervised environments and this is the
>>"wall-clock" cpu run time. "Virtual" cpu run time, on the other hand, does
>>not account for the kernel being descheduled.
>>
>>This patch allows the most accurate "virtual" cpu run time, collected by
>>the schedstats code (now shared with delay accounting code), to be returned
>>to user space, in addition to the "wall-clock" cpu time that was being exported
>>earlier. Both these times are useful for workload management in different
>>situations.
>>
>>In a non-virtualized environment, or on architectures which do not adjust
>>tsk->utime/stime, these will effectively be the same value but at different
>>granularities.
>>
>>...
>>
>>Index: linux-2.6.16/include/linux/taskstats.h
>>===================================================================
>>--- linux-2.6.16.orig/include/linux/taskstats.h	2006-03-29 18:13:18.000000000 -0500
>>+++ linux-2.6.16/include/linux/taskstats.h	2006-03-29 18:13:20.000000000 -0500
>>@@ -46,8 +46,14 @@ struct taskstats {
>> 	__u64	swapin_count;
>> 	__u64	swapin_delay_total;	/* swapin page fault wait*/
>>
>>-	__u64	cpu_run_total;		/* cpu running time
>>-					 * no count available/provided */
>>+	__u64	cpu_run_real_total;	/* cpu "wall-clock" running time
>>+					 * Potentially accounts for cpu
>>+					 * virtualization, on some arches
>>+					 */
>>+	__u64	cpu_run_virtual_total;	/* cpu "virtual" running time
>>+					 * Uses time intervals as seen by
>>+					 * the kernel
>>+					 */
>> };
>>
>>    
>>
>
>Again, the reader of this struct wants to know what the atomicity rules are.
>  
>
Will add comment.

>  
>
>>+	d->cpu_run_real_total = (tmp < (nsec_t)d->cpu_run_real_total)? 0: tmp;
>>    
>>
>
>	lval = expr1 ? expr2 : expr3;
>  
>
didn't get whats wrong ?

>  
>
>>+	tmp = (nsec_t)d->cpu_run_virtual_total
>>+		+ (nsec_t)jiffies_to_usecs(t3) * 1000;
>>    
>>
>
>umm, Linux doesn't have nsec_t any more.
>
>  
>
Ok, will switch to s64 everywhere.

--Shailabh


