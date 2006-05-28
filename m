Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWE1Xab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWE1Xab (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 19:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWE1Xaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 19:30:30 -0400
Received: from omta04sl.mx.bigpond.com ([144.140.93.156]:16247 "EHLO
	omta04sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751048AbWE1Xaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 19:30:30 -0400
Message-ID: <447A3292.5070606@bigpond.net.au>
Date: Mon, 29 May 2006 09:30:26 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
CC: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>,
       Herbert Poetzl <herbert@13thfloor.at>, Kirill Korotaev <dev@sw.ru>
Subject: Re: [RFC 0/5] sched: Add CPU rate caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest> <1148630661.7589.65.camel@homer> <20060526161148.GA23680@atjola.homenet> <447A2853.2080901@vilain.net>
In-Reply-To: <447A2853.2080901@vilain.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sun, 28 May 2006 23:30:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain wrote:
> Björn Steinbrink wrote:
> 
>>> The killer problem I see with this approach is that it doesn't address
>>> the divide and conquer problem.  If a task is capped, and forks off
>>> workers, each worker inherits the total cap, effectively extending same.
>>>    
>>>
> 
> Yes, although the current thinking is that you need to set a special
> clone() flag (which may be restricted via capabilities such as
> CAP_SYS_RESOURCE) to set a new CPU scheduling namespace, so the workers
> will inherit the same scheduling ns and therefore be accounted against
> the one resource.
> 
> Sorry if I'm replying out of context, I'll catch up on this thread
> shortly.  Thanks for including me.
> 
>>> IMHO, per task resource management is too severely limited in it's
>>> usefulness, because jobs are what need managing, and they're seldom
>>> single threaded.  In order to use per task limits to manage any given
>>> job, you have to both know the number of components, and manually
>>> distribute resources to each component of the job.  If a job has a
>>> dynamic number of components, it becomes impossible to manage.
>>>    
>>>
>> Linux-VServer uses a token bucket scheduler (TBS) to limit cpu ressources
>> for processes in a "context". All processes in a context share one token
>> bucket, which has a set of parameters to tune scheduling behaviour.
>> As the token bucket is shared by a group of processes, and inherited by
>> child processes/threads, management is quite easy. And the parameters
>> can be tuned to allow different scheduling behaviours, like allowing a
>> process group to burst, ie. use as much cpu time as is available, after
>> being idle for some time, but being limited to X % cpu time on average.
>>  
>>
> 
> This is correct.  Basically I read the LARTC.org (which explains Linux
> network schedulers etc) and the description of the Token Bucket
> Scheduler inspired me to write the same thing for CPU resources.  It was
> originally developed for the 2.4 Alan Cox series kernels.  The primary
> design guarantee of the scheduler is a low total performance impact -
> maximum CPU utilisation prioritisation and fairness a secondary
> concern.  It was built with the idea that people wanting different sorts
> of scheduling policies could at least get a set of userland controls to
> implement their approach - to the limit of the effectiveness of task
> priorities.
> 
> I most recently described this at http://lkml.org/lkml/2006/3/29/59, a
> lot of that thread is probably worth catching up on.
> 
> It would be nice if we could somehow re-use the scheduling algorithms in
> use in the network space here, if it doesn't impact on performance.
> 
> For instance, the "CBQ" network scheduler is the same approach as used
> in OpenVZ's CPU scheduler, and the classful Token Bucket Filter is the
> approach used in VServer.  The "Sched_prio" and "Sched_hard" distinction
> in vserver could probably be compared to "Ingres Policing", where
> available CPU that could run a process instead sits idle - similar to
> the network world where data that has arrived is dropped to try to
> convince the application to throttle its network activity.
> 
> As in the network space (http://lkml.org/lkml/2006/5/19/216) in this
> space we have a continual scale of possible implementations, marked by a
> highly efficient solution akin to "binding" at one end, and a
> virtualisation at the other.  Each deliver guarantees most applicable to
> certain users or workloads.
> 
> Sam.
> 
>> I'm CC'ing Herbert and Sam on this as they can explain the whole thing a
>> lot better and I'm not familiar with implementation details.

Have you considered adding an implementation of these schedulers to 
PlugSched?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
