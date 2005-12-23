Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030482AbVLWKtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030482AbVLWKtd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 05:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030484AbVLWKtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 05:49:33 -0500
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:14272 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030482AbVLWKtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 05:49:32 -0500
Message-ID: <43ABD639.2060200@bigpond.net.au>
Date: Fri, 23 Dec 2005 21:49:29 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Kyle Moffett <mrmacman_g4@mac.com>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Fix	adverse	effects	of	NFS	client	on	interactive
 response
References: <43A8EF87.1080108@bigpond.net.au>	 <1135145341.7910.17.camel@lade.trondhjem.org>	 <43A8F714.4020406@bigpond.net.au>	 <1135171280.7958.16.camel@lade.trondhjem.org>	 <962C9716-6F84-477B-8B2A-FA771C21CDE8@mac.com>	 <1135172453.7958.26.camel@lade.trondhjem.org>	 <43AA0EEA.8070205@bigpond.net.au>	 <1135289282.9769.2.camel@lade.trondhjem.org>	 <43AB29B8.7050204@bigpond.net.au>	 <1135292364.9769.58.camel@lade.trondhjem.org>	 <AAF94E06-ACB9-4ABE-AC15-49C6B3BE21A0@mac.com>	 <1135297525.3685.57.camel@lade.trondhjem.org>	 <43AB69B8.4080707@bigpond.net.au> <1135330757.8167.44.camel@lade.trondhjem.org>
In-Reply-To: <1135330757.8167.44.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 23 Dec 2005 10:49:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> On Fri, 2005-12-23 at 14:06 +1100, Peter Williams wrote:
> 
>>>As far as a filesystem is concerned, there should be 2 scheduling
>>>states: running and sleeping. Any scheduling policy beyond that belongs
>>>in kernel/*.
>>
>>Actually there are currently two kinds of sleep: interruptible and 
>>uninterruptible.  This just adds a variation to one of these, 
>>interruptible, that says even though I'm interruptible I'm not 
>>interactive (i.e. I'm not waiting for human intervention via a key 
>>press, mouse action, etc. to initiate the interrupt).  This helps the 
>>scheduler to decide whether the task involved is an interactive one or 
>>not which in turn improves users' interactive experiences by ensuring 
>>snappy responses to keyboard and mouse actions even when the system is 
>>heavily loaded.
> 
> 
> No! This is not the same thing at all.
> 
> You are asking the coder to provide a policy judgement as to whether or
> not the users might care.

No.  It is asking whether the NORMAL interruption of this interruptible 
sleep will be caused by a human user action such as a keystroke or mouse 
action.  For the NFS client the answer to that question is unequivically 
no.  It's not a matter of policy it's a matter of fact.

> 
> As far as I'm concerned, other users' MP3 player, X processes, and
> keyboard response times can rot in hell whenever I'm busy writing out
> data at full blast. I don't give a rats arse about user interactivity,
> because my priority is to see the batch jobs complete.
> 
> However on another machine, the local administrator may have a different
> opinion. That sort of difference in opinion is precisely why we do not
> put this sort of policy

It's not policy.  It's a statement of fact about the nature of the sleep 
that is being undertaken.

> in the filesystem code but leave it all in the
> scheduler code where all the bits and pieces can (hopefully) be treated
> consistently as a single policy, and where the user can be given tools
> in order to tweak the policy.
> 
> TASK_NONINTERACTIVE is basically a piss-poor interface because it moves
> the policy into the lower level code where the user has less control.

TASK_INTERACTIVE is not about policy.

> 
> 
>>There are probably many interruptible sleeps in the kernel that should 
>>be marked as non interactive but for most of them it doesn't matter 
>>because the duration of the sleep is so short that being mislabelled 
>>doesn't materially effect the decision re whether a task is interactive 
>>or not.  However, for reasons not related to the quality or efficiency 
>>of the code, NFS interruptible sleeps do not fall into that category as 
>>they can be quite long due to server load or network congestion.  (N.B. 
>>the size of delays that can be significant is quite small i.e. much less 
>>than the size of a normal time slice.)
>>
>>An alternative to using TASK_NONINTERACTIVE to mark non interactive 
>>interruptible sleeps that are significant (probably a small number) 
>>would be to go in the other direction and treat all interruptible sleeps 
>>as being non interactive and then labelling all the ones that are 
>>interactive as such.  Although this would result in no changes being 
>>made to the NFS code, I'm pretty sure that this option would involve a 
>>great deal more code changes elsewhere as all the places where genuine 
>>interactive sleeping were identified and labelled.
> 
> 
> That is exactly the same rotten idea, just implemented differently.

I thought that I said (or at least implied) that.  The difference is 
that we wouldn't be having this conversation.

> You
> are still asking coders to guess as to what the scheduling policy should
> be instead of letting the user decide.

I wish that I could make you understand that that isn't the case. 
You're not being asked to make a policy decision you're being asked to 
make a statement of fact about whether the interruptible sleep is 
interactive or not.  In the cases involved in this patch this question 
is always "no, it's not an interactive" sleep and it can be answered at 
compile time with absolutely no run time overhead incurred.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
