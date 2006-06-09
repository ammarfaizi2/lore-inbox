Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965231AbWFIGjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965231AbWFIGjA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 02:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965233AbWFIGjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 02:39:00 -0400
Received: from alt.aurema.com ([203.217.18.57]:45638 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S965231AbWFIGi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 02:38:59 -0400
Message-ID: <4489174F.4090305@aurema.com>
Date: Fri, 09 Jun 2006 16:38:07 +1000
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
CC: Peter Williams <pwil3058@bigpond.net.au>, Kirill Korotaev <dev@openvz.org>,
       Srivatsa <vatsa@in.ibm.com>, CKRM <ckrm-tech@lists.sourceforge.net>,
       Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Sam Vilain <sam@vilain.net>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ckrm-tech] [RFC 0/4] sched: Add CPU rate caps (improved)
References: <20060606023708.2801.24804.sendpatchset@heathwren.pw.nest>	<448688B2.2030206@jp.fujitsu.com> <4487D6B0.3080502@bigpond.net.au> <448909F2.2060306@jp.fujitsu.com>
In-Reply-To: <448909F2.2060306@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MAEDA Naoaki wrote:
> Peter Williams wrote:
> 
>> This behaviour is caused by the "make clean" being a short lived CPU 
>> intensive task.  It was made worse by the facts that my simplifications 
>> to the sinbin duration calculation which assumed a constant CPU burst 
>> size based on the time slice and that exiting tasks could still have 
>> caps enforced.  (The simplification was done to avoid 64 bit divides.)
>>
>> I've put in a more complex sinbin calculation (and don't think the 64 
>> bit divides will matter too much as they're on an infrequently travelled 
>> path.  Exiting tasks are now excluded from having caps enforced on the 
>> grounds that it's best for system performance to let them get out of the 
>> way as soon as possible.  A patch is attached and I would appreciate it 
>> if you could see if it improves the situation you are observing.
> 
> Sorry for my late reply.
> 
> The followings are the results of patched kernel. Unfortunately,
> the patch doesn't seem to help my situation.
> 
> $ ~/withcap.sh  -C 900 /usr/bin/time make clean
> 1.61user 0.29system 1:33.94elapsed 2%CPU
> 
> $ ~/withcap.sh  -C 100 /usr/bin/time make clean
> 1.68user 0.27system 3:34.45elapsed 0%CPU

I don't see anything that bad here.  E.g.

[peterw@heathwren SMP]$ /usr/bin/time make clean
make -C /home/peterw/KERNELS/PlugSched/MM-2.6.17-rc4-mm1 
O=/kbuild/Plugsched/MM-2.6.17-rc4-mm1/SMP clean
1.18user 0.81system 0:01.98elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+140353minor)pagefaults 0swaps
[peterw@heathwren SMP]$ withcap -C 900 /usr/bin/time make clean
make -C /home/peterw/KERNELS/PlugSched/MM-2.6.17-rc4-mm1 
O=/kbuild/Plugsched/MM-2.6.17-rc4-mm1/SMP clean
1.19user 0.80system 0:03.07elapsed 65%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+140322minor)pagefaults 0swaps
[peterw@heathwren SMP]$ withcap -C 100 /usr/bin/time make clean
make -C /home/peterw/KERNELS/PlugSched/MM-2.6.17-rc4-mm1 
O=/kbuild/Plugsched/MM-2.6.17-rc4-mm1/SMP clean
1.21user 0.82system 0:05.03elapsed 40%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+140374minor)pagefaults 0swaps
[peterw@heathwren SMP]$

These are worse than predicted by my tests for single processes leading 
me to the opinion that the make clean actually consists of a number or 
serially executed CPU intensive tasks whose total usage adds up to the 
reported times.  My tests (starting a background task before and another 
after running "make clean" and using the difference in their reported 
pids as an estimate of how many tasks were involved in the "make clean") 
indicate that there were about 660.  This gives them each an average 
duration of about 3 milliseconds (based on a total elapsed time of 1.98 
seconds).  Even with HZ of 1000 that's only about 3 jiffies and is well 
and truly in the "too short to do reasonable capping" basket.

Peter
-- 
Dr Peter Williams, Chief Scientist         <peterw@aurema.com>
Aurema Pty Limited
Level 2, 130 Elizabeth St, Sydney, NSW 2000, Australia
Tel:+61 2 9698 2322  Fax:+61 2 9699 9174 http://www.aurema.com
