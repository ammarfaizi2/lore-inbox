Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbUCAESm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 23:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbUCAESm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 23:18:42 -0500
Received: from alt.aurema.com ([203.217.18.57]:57012 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S262244AbUCAESe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 23:18:34 -0500
Message-ID: <4042B98D.1000006@aurema.com>
Date: Mon, 01 Mar 2004 15:18:21 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Lutomirski <luto@stanford.edu>
CC: Andy Lutomirski <luto@myrealbox.com>, John Lee <johnl@aurema.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <fa.jgj0bdi.b3u6qk@ifi.uio.no> <404297D1.5010301@myrealbox.com> <4042A5E8.9040706@aurema.com> <4042B1FD.9020508@stanford.edu>
In-Reply-To: <4042B1FD.9020508@stanford.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski wrote:
> Peter Williams wrote:
> 
>> Andy Lutomirski wrote:
>>
>>> How hard would it be to make shares hierarchial?  For example (quoted 
>>> names are just descriptive):
>>
>>
>> As Peter Chubb has stated such control is possible and is available on 
>> Tru64, Solaris and Windows with Aurema's (<http://www.aurema.com>) 
>> ARMTech product.  The CKRM project also addresses this issue.
> 
> 
> Cool.  I hadn't realized ARMTech did that, and I haven't fully read up 
> on CKRM.
> 
>>
>>>
>>> Also, could interactivity problems be solved something like this:
>>>
>>>   prio = (  (old EBS usage ratio) - 0.5  ) * i + 0.5
>>>
>>> "i" would be a per-process interactivity factor (normally 1, but 
>>> higher for interactive processes) which would only boost them when 
>>> their CPU usage is low.  This makes interactive processes get their 
>>> timeslices early (very high priority at low CPU consumption) but 
>>> prevents abuse by preventing excessive CPU consumption.  This could 
>>> even by set by the (untrusted) process itself.
>>>
>>
>> Interactive processes do very well under EBS without any special 
>> treatment.
>>
>> Programs such as xmms aren't really interactive processes although 
>> they usually have a very low CPU usage rate like interactive 
>> processes.  What distinguishes them is their need for REGULAR access 
>> to the CPU.  It's unlikely that such a modification would help with 
>> the need for regularity.
> 
> 
> I'm guessing the reason make -j16 broke it is because it (i.e. make) 
> spawns lots of processes frequenly.  Since make probably uses almost no 
> CPU under this load, its usage per share stays near zero.  As long as it 
> is below that of xmms, then all of its children are too, at least until 
> part-way into their first timeslices.  The problem is that there are a 
> bunch of these children, and, if enough start at once, they all run 
> before xmms, and the audio buffer underruns.  My approach would give 
> xmms a better chance of running sooner (in fact, it would potentially 
> have better priority than any non-interactive task until it started 
> hogging CPU).

That's close to the reason.  The real culprit is the dreaded "ramp up" 
which is our tag for the fact that it takes a short while (dependent on 
half life) for the scheduler to estimate the usage rate of a new process 
(or a sudden change in the usage rate of an existing process) so they 
get treated as low usage tasks for the first part of their life.  In 
most cases this is a good thing as it causes commands run from the 
command line to get a boost and since a lot of these are very short 
lived (e.g. ls) they run very quickly and have very good response times.

In the case of a kernel build there are lots of C compiler tasks being 
launched and these run for several seconds but for the first few moments 
of their lives (during ramp up) they look like low CPU usage tasks and 
get high priority.  This effect is short lived and doesn't effect normal 
interactive programs because regularity of access isn't important to 
them and the estimated usages of the C compiler tasks quickly exceeds 
the estimated usages of the interactive tasks. It only has an effect on 
xmms because regularity of access is important to it (i.e. xmms IS 
getting sufficient CPU but isn't always getting it as regularly as it 
likes).

The X server is a different case.  Although it isn't an interactive 
program it does have an influence on interactive responsiveness when X 
windows is being used.  Unfortunately, because it is generally serving a 
number of clients, its CPU usage can be quite high and it takes a little 
longer for the estimated usage rate of the C compiler tasks to exceed 
its estimated usage.  For this reason, we recommend that sysadmins 
arrange for the X server to be run at somewhere between nice -9 and nice 
-15.

It should be obvious from the above that another way that interactive 
response can be improved is by shortening the half life.  But there is a 
trade off with lowered overall system throughput resulting if the half 
life is too short.  In the current version of EBS, root can change the 
half life on a running system and this functionality is there so that 
experiments into the effect of changing the half life on system 
performance can be conducted without the need to recompile the kernel 
and reboot the system.  The default value of 5 seconds is one that we've 
found is good for overall performance and interactive response provided 
that the X server is run with an appropriate level of niceness.

> 
>>
>> Once again I'll stress that in order to cause xmms to skip we had to 
>> (on a single CPU machine) run a kernel build with -j 16 which causes a 
>> system load well in excess of 10 and is NOT a normal load.  Under 
>> normal loads xmms performs OK.
>>
>>>
>>> I imagine that these two together would nicely solve most 
>>> interactivity and fairness issues -- the former prevents starvation 
>>> by other users and the latter prevents latency caused by large 
>>> numbers of CPU-light tasks.
>>>
>>>
>>> Is this sane?
>>
>>
>>
>> Yes.  Fairness between users rather than between tasks is a sane 
>> desire but beyond the current scope of EBS.
> 
> 
> I have this strange masochistic desire to implement this.  Don't expect 
> patches any time soon -- it would be my first time playing with the 
> scheduler ;)
> 

Good luck
Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

