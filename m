Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbUKCC37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbUKCC37 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 21:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbUKCC37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 21:29:59 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:65194 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261336AbUKCC3i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 21:29:38 -0500
Message-ID: <41884257.7000105@us.ibm.com>
Date: Tue, 02 Nov 2004 20:28:39 -0600
From: Andrew Theurer <habanero@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: kernel@kolivas.org, ricklind@us.ibm.com,
       Nick Piggin <nickpiggin@yahoo.com.au>, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] sched: aggressive idle balance
References: <200411022230.iA2MUxq18736@unix-os.sc.intel.com>
In-Reply-To: <200411022230.iA2MUxq18736@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:

>Andrew Theurer wrote on Tuesday, November 02, 2004 12:17 PM
>  
>
>>This patch allows more aggressive idle balances, reducing idle time in
>>scenarios where should not be any, where nr_running > nr_cpus.  We have seen
>>this in a couple of online transaction workloads.  Three areas are targeted:
>>
>>1) In try_to_wake_up(), wake_idle() is called to move the task to a sibling if
>>the task->cpu is busy and the sibling is idle.  This has been expanded to any
>>idle cpu, but the closest idle cpu is picked first by starting with cpu->sd,
>>then going up the domains as necessary.
>>    
>>
>
>It occurs to me that half of the patch only applicable to HT, like the change
>in wake_idle().  And also, do you really want to put that functionality in
>wake_idle()?  Seems defeating the original intention of that function, which
>only tries to wake up sibling cpu as far as how I understand the code.
>  
>
The patch (wake_idle()) should still make a difference with nonHT 
systems.  It is true that in the mainline code, only HT systems 
benefited from wake_idle().  In fact, wake_idle() probably did nothing 
at all for Itanium, but with this patch it will, since we scan for an 
idle cpu up the domains that have flag SD_WAKE_IDLE (and we addedd that 
flag to SD_CPU_INIT and SD_NODE_INIT).

The patch's intention is to make sure we don't leave idle cpus idle.  
This can happen because the rate at which tasks are activated and 
deactivated is much higher than the idle balance interval, and because 
the task_hot prevents migrations even when we do encounter an idle 
balance tick.

Honsetly, I think you should be able to see the benefits form all 
seciotns of this patch, even without HT.

-Andrew Theurer
