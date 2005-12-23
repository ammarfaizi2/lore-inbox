Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030397AbVLWDai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbVLWDai (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 22:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030395AbVLWDai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 22:30:38 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:60784 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030397AbVLWDah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 22:30:37 -0500
Message-ID: <43AB69B8.4080707@bigpond.net.au>
Date: Fri, 23 Dec 2005 14:06:32 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Kyle Moffett <mrmacman_g4@mac.com>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Fix adverse	effects	of	NFS	client	on	interactive
 response
References: <43A8EF87.1080108@bigpond.net.au>	 <1135145341.7910.17.camel@lade.trondhjem.org>	 <43A8F714.4020406@bigpond.net.au>	 <1135171280.7958.16.camel@lade.trondhjem.org>	 <962C9716-6F84-477B-8B2A-FA771C21CDE8@mac.com>	 <1135172453.7958.26.camel@lade.trondhjem.org>	 <43AA0EEA.8070205@bigpond.net.au>	 <1135289282.9769.2.camel@lade.trondhjem.org>	 <43AB29B8.7050204@bigpond.net.au>	 <1135292364.9769.58.camel@lade.trondhjem.org>	 <AAF94E06-ACB9-4ABE-AC15-49C6B3BE21A0@mac.com> <1135297525.3685.57.camel@lade.trondhjem.org>
In-Reply-To: <1135297525.3685.57.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 23 Dec 2005 03:06:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> On Thu, 2005-12-22 at 19:02 -0500, Kyle Moffett wrote:
> 
>>On Dec 22, 2005, at 17:59, Trond Myklebust wrote:
>>
>>>On Fri, 2005-12-23 at 09:33 +1100, Peter Williams wrote:
>>>
>>>>>It still has sod all business being in the NFS code. We don't  
>>>>>touch task scheduling in the filesystem code.
>>>>
>>>>How do you explain the use of the TASK_INTERRUPTIBLE flag then?
>>>
>>>Oh, please...
>>>
>>>TASK_INTERRUPTIBLE is used to set the task to sleep. It has NOTHING  
>>>to do with scheduling.
>>
>>Putting a task to sleep _is_ rescheduling it.  TASK_NONINTERACTIVE  
>>means that you are about to reschedule and are willing to tolerate a  
>>higher wakeup latency.  TASK_INTERRUPTABLE means you are about to  
>>sleep and want to be woken up using the "standard" latency.  If you  
>>do any kind of sleep at all, both are valid, independent of what part  
>>of the kernel you are.  There's a reason that both are TASK_* flags.
> 
> 
> Tolerance for higher wakeup latencies is a scheduling _policy_ decision.
> Please explain why the hell we should have to deal with that in
> filesystem code?

In order to make good decisions it needs good data.  I don't think that 
it's unreasonable to expect sub systems to help in that regard 
especially when there is no cost involved.  The patch just turns another 
bit on (at compile time) in some integer constants.  No extra space or 
computing resources are required.

> 
> As far as a filesystem is concerned, there should be 2 scheduling
> states: running and sleeping. Any scheduling policy beyond that belongs
> in kernel/*.

Actually there are currently two kinds of sleep: interruptible and 
uninterruptible.  This just adds a variation to one of these, 
interruptible, that says even though I'm interruptible I'm not 
interactive (i.e. I'm not waiting for human intervention via a key 
press, mouse action, etc. to initiate the interrupt).  This helps the 
scheduler to decide whether the task involved is an interactive one or 
not which in turn improves users' interactive experiences by ensuring 
snappy responses to keyboard and mouse actions even when the system is 
heavily loaded.

There are probably many interruptible sleeps in the kernel that should 
be marked as non interactive but for most of them it doesn't matter 
because the duration of the sleep is so short that being mislabelled 
doesn't materially effect the decision re whether a task is interactive 
or not.  However, for reasons not related to the quality or efficiency 
of the code, NFS interruptible sleeps do not fall into that category as 
they can be quite long due to server load or network congestion.  (N.B. 
the size of delays that can be significant is quite small i.e. much less 
than the size of a normal time slice.)

An alternative to using TASK_NONINTERACTIVE to mark non interactive 
interruptible sleeps that are significant (probably a small number) 
would be to go in the other direction and treat all interruptible sleeps 
as being non interactive and then labelling all the ones that are 
interactive as such.  Although this would result in no changes being 
made to the NFS code, I'm pretty sure that this option would involve a 
great deal more code changes elsewhere as all the places where genuine 
interactive sleeping were identified and labelled.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
