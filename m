Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbWFBVYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbWFBVYH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 17:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbWFBVXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 17:23:50 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:35742 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030292AbWFBVXm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 17:23:42 -0400
Message-ID: <4480AC58.9030904@watson.ibm.com>
Date: Fri, 02 Jun 2006 17:23:36 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>, dev@openvz.org,
       Srivatsa <vatsa@in.ibm.com>, ckrm-tech@lists.sourceforge.net,
       balbir@in.ibm.com, Balbir Singh <bsingharora@gmail.com>,
       Mike Galbraith <efault@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Sam Vilain <sam@vilain.net>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Rene Herman <rene.herman@keyaccess.nl>,
       Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [ckrm-tech] [RFC 3/5] sched: Add CPU rate hard caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	<20060526042051.2886.70594.sendpatchset@heathwren.pw.nest>	<661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com>	<44781167.6060700@bigpond.net.au>	<447D95DE.1080903@sw.ru>	<447DBD44.5040602@in.ibm.com>	<447E9A1D.9040109@openvz.org>	<447EA694.8060407@in.ibm.com>	<1149187413.13336.24.camel@linuxchandra> <447FE9F8.4060004@sw.ru>
In-Reply-To: <447FE9F8.4060004@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:

>>>>- disk I/O bandwidth:
>>>>we started to use CFQv2, but it is quite poor in this regard. First, it 
>>>>doesn't prioritizes writes and async disk operations :( And even for 
>>>>sync reads we found some problems we work on now...
>>>>        
>>>>
>
>  
>
>>CKRM (on e-series) had an implementation based on a modified CFQ
>>scheduler. Shailabh is currently working on porting that controller to
>>f-series.
>>    
>>
>can you explain what was changed by CKRM there? Did you made it to 
>control ASYNC read/writes? I don't think so...
>  
>
In e-series, CFQ was modified to
- maintain request queues per ckrm-class (now resource group) rather 
than per-tgid
- explicitly maintain I/O bandwidth of each request queue (in terms of 
I/O issued by the I/O scheduler)
- select the "next request queue to service" based on its I/O 
bandwidth...if a queue exceeds its allocation (as calculated
from the CKRM guarantee values), the queue gets skipped.

So this did not use the CFQ priority scheme as such and only implemented 
the "limit" part.

The current plan is to exploit the CFQ prio levels and rely on CFQ doing 
a good enough job in maintaining an adequate
bandwidth differential between those prio levels.
Again, each queue would maintain a count of its consumed bandwidth as 
well as target bandwidth. While picking the next request
from the queue, if its observed that the queue is above its "guarantee", 
its priority will get reduced (it'll still supply a request) while
a queue that is below its share will get bumped up....Control will be 
much more gradual but the basic idea is to leverage CFQ's priority
handling than supplant it (since we get anticipation in the form of 
time-slicing for free).

One concern is whether the time-slicing of CFQ plays well with queues 
that aren't organized by tgid...I'm still looking into that.

>Do you have any plots on what is concurrent bandwidth is depending on 
>weights? Because, our measurements show that CFQ is not ideal and 
>behaves poorly when prio 0,5,6,7 are used :/ Only 1,2,3,4 are really 
>linear-scalable...
>  
>
Interesting. Whats the time-scale over which you expect I/O bandwidth 
rates to get enforced ?

Perhaps the iosched discussion should use  a different thread....

--Shailabh


