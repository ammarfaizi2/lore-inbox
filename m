Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUCADqY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 22:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbUCADqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 22:46:24 -0500
Received: from smtp-roam.Stanford.EDU ([171.64.14.91]:26244 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S262238AbUCADqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 22:46:19 -0500
Message-ID: <4042B1FD.9020508@stanford.edu>
Date: Sun, 29 Feb 2004 19:46:05 -0800
From: Andy Lutomirski <luto@stanford.edu>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <peterw@aurema.com>
CC: Andy Lutomirski <luto@myrealbox.com>, John Lee <johnl@aurema.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <fa.jgj0bdi.b3u6qk@ifi.uio.no> <404297D1.5010301@myrealbox.com> <4042A5E8.9040706@aurema.com>
In-Reply-To: <4042A5E8.9040706@aurema.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:

> Andy Lutomirski wrote:
> 
>> How hard would it be to make shares hierarchial?  For example (quoted 
>> names are just descriptive):
> 
> As Peter Chubb has stated such control is possible and is available on 
> Tru64, Solaris and Windows with Aurema's (<http://www.aurema.com>) 
> ARMTech product.  The CKRM project also addresses this issue.

Cool.  I hadn't realized ARMTech did that, and I haven't fully read up on CKRM.

> 
>>
>> Also, could interactivity problems be solved something like this:
>>
>>   prio = (  (old EBS usage ratio) - 0.5  ) * i + 0.5
>>
>> "i" would be a per-process interactivity factor (normally 1, but 
>> higher for interactive processes) which would only boost them when 
>> their CPU usage is low.  This makes interactive processes get their 
>> timeslices early (very high priority at low CPU consumption) but 
>> prevents abuse by preventing excessive CPU consumption.  This could 
>> even by set by the (untrusted) process itself.
>>
> 
> Interactive processes do very well under EBS without any special treatment.
> 
> Programs such as xmms aren't really interactive processes although they 
> usually have a very low CPU usage rate like interactive processes.  What 
> distinguishes them is their need for REGULAR access to the CPU.  It's 
> unlikely that such a modification would help with the need for regularity.

I'm guessing the reason make -j16 broke it is because it (i.e. make) spawns lots 
of processes frequenly.  Since make probably uses almost no CPU under this load, 
its usage per share stays near zero.  As long as it is below that of xmms, then 
all of its children are too, at least until part-way into their first 
timeslices.  The problem is that there are a bunch of these children, and, if 
enough start at once, they all run before xmms, and the audio buffer underruns. 
  My approach would give xmms a better chance of running sooner (in fact, it 
would potentially have better priority than any non-interactive task until it 
started hogging CPU).

> 
> Once again I'll stress that in order to cause xmms to skip we had to (on 
> a single CPU machine) run a kernel build with -j 16 which causes a 
> system load well in excess of 10 and is NOT a normal load.  Under normal 
> loads xmms performs OK.
> 
>>
>> I imagine that these two together would nicely solve most 
>> interactivity and fairness issues -- the former prevents starvation by 
>> other users and the latter prevents latency caused by large numbers of 
>> CPU-light tasks.
>>
>>
>> Is this sane?
> 
> 
> Yes.  Fairness between users rather than between tasks is a sane desire 
> but beyond the current scope of EBS.

I have this strange masochistic desire to implement this.  Don't expect patches 
any time soon -- it would be my first time playing with the scheduler ;)

> Peter

--Andy
