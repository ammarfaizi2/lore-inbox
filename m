Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWFSIm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWFSIm1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 04:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWFSIm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 04:42:27 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:53977 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751233AbWFSIm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 04:42:26 -0400
Message-ID: <44966320.6080308@jp.fujitsu.com>
Date: Mon, 19 Jun 2006 17:41:04 +0900
From: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
Cc: vatsa@in.ibm.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       Kirill Korotaev <dev@openvz.org>, Mike Galbraith <efault@gmx.de>,
       Ingo Molnar <mingo@elte.hu>, Peter Williams <pwil3058@bigpond.net.au>,
       Andrew Morton <akpm@osdl.org>, sekharan@us.ibm.com,
       Balbir Singh <balbir@in.ibm.com>, linux-kernel@vger.kernel.org,
       kurosawa@valinux.co.jp, ckrm-tech@lists.sourceforge.net,
       MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Subject: Re: [RFC] CPU controllers?
References: <20060615134632.GA22033@in.ibm.com> <4493C1D1.4020801@yahoo.com.au> <20060617164812.GB4643@in.ibm.com> <4494DF50.2070509@yahoo.com.au> <4494EA66.8030305@vilain.net> <20060618071847.GA4988@in.ibm.com> <449606F5.6050909@vilain.net> <44964C89.6060003@jp.fujitsu.com> <44965E0C.9050508@vilain.net>
In-Reply-To: <44965E0C.9050508@vilain.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain wrote:
> MAEDA Naoaki wrote:
>>> ok, so basically the bit in cpu_rc_load() where for_each_cpu_mask() is
>>> called, in Maeda Naoaki's patch "CPU controller - Add class load
>>> estimation support", is where O(N) creeps in that could be remedied with
>>> a token bucket algorithm. You don't want this because if you have 10,000
>>> processes on a system in two resource groups, the aggregate performance
>>> will suffer due to the large number of cacheline misses during the 5,000
>>> size loop that runs every resched.
>>>     
>> Thank you for looking the code.
>>
>> cpu_rc_load() is never called unless sysadm tries to access the load
>> information via configfs from userland. In addition, it sums up per-CPU
>> group stats, so the size of loop is the number of CPU, not process in
>> the group.
>>
>> However, there is a similer loop in cpu_rc_recalc_tsfactor(), which runs
>> every CPU_RC_RECALC_INTERVAL that is defined as HZ. I don't think it
>> will cause a big performance penalty.
>>   
> 
> Ok, so that's not as bad as it looked.  So, while it is still O(N), the
> fact that it is O(N/HZ) makes this not a problem until you get to
> possibly impractical levels of runqueue length.

Do you mean N is the size of the loop? for_each_cpu_mask() loops
the number of CPUs times. It is not directly related to runqueue length.

> I'm thinking it's probably worth doing anyway, just so that it can be
> performance tested to see if this performance guestimate is accurate.
> 
>>> To apply the token bucket here, you would first change the per-CPU
>>> struct cpu_rc to have the TBF fields; minimally:
>>>
>>> [...]
>>> I think that the characteristics of these two approaches are subtly
>>> different. Both scale timeslices, but in a different way - instead of
>>> estimating the load and scaling back timeslices up front, busy Resource
>>> Groups are relied on to deplete their tokens in a timely manner, and get
>>> shorter slices allocated because of that. No doubt from 10,000 feet they
>>> both look the same.
>>>     
>> Current 0(1) scheduler gives extra bonus for interactive tasks by
>> requeuing them to active array for a while. It would break
>> the controller's efforts. So, I'm planning to stop the interactive
>> task requeuing if the target share doesn't meet.
>>
>> Are there a similar issue on the vserver scheduler?
>>   
> 
> Not an issue - those extra requeued timeslices are accounted for normally.

It's great.

Thanks,
MAEDA Naoaki

