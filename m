Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWE3Cpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWE3Cpa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 22:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWE3Cp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 22:45:29 -0400
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:46050 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932087AbWE3Cp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 22:45:29 -0400
Message-ID: <447BB1C6.9050901@bigpond.net.au>
Date: Tue, 30 May 2006 12:45:26 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
CC: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>,
       Herbert Poetzl <herbert@13thfloor.at>, Kirill Korotaev <dev@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC 0/5] sched: Add CPU rate caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest> <1148630661.7589.65.camel@homer> <20060526161148.GA23680@atjola.homenet> <447A2853.2080901@vilain.net> <447A3292.5070606@bigpond.net.au> <447A65EA.9020705@vilain.net> <447A6D7B.9090302@bigpond.net.au> <447B64BF.4050806@vilain.net> <447B7FD6.6020405@bigpond.net.au> <447BA8ED.3080904@vilain.net>
In-Reply-To: <447BA8ED.3080904@vilain.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 30 May 2006 02:45:26 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain wrote:
> Peter Williams wrote:
> 
>>> I'd certainly be interested in having a look through the split out patch
>>> to see how namespaces and this advanced scheduling system might
>>> interoperate.
>>>    
>>>
>> OK.  I've tried very hard to make the scheduling code orthogonal to 
>> everything else and it essentially separates out the scheduling within a 
>> CPU from other issues e.g. load balancing.  This separation is 
>> sufficiently good for me to have merged PlugSched with an earlier 
>> version of CKRM's CPU management module in a way that made each of 
>> PlugSched's schedulers available within CKRM's infrastructure.  (CKRM 
>> have radically rewritten their CPU code since then and I haven't 
>> bothered to keep up.)
>>
>> The key point that I'm trying to make is that I would expect PlugSched 
>> and namespaces to coexist without any problems.  How it integrates with 
>> the "advanced" scheduling system would depend on how that system alters 
>> things such as load balancing and/or whether it goes for scheduling 
>> outcomes at a higher level than the task.
>>  
>>
> 
> Coexisting is the base line and I don't think they'll 'interfere' with
> each other, per se, but we specifically want to make it easy for
> userland to set up and configure scheduling policies to apply to groups
> of processes.

They shouldn't interfere as which scheduler to use is a boot time 
selection and only one scheduler is in force.  It's mainly a coding 
matter and in particular whether the "scheduler driver" interface would 
need to be modified or whether your scheduler can be implemented using 
the current interface.

> 
> For instance, the vserver scheduling extension I wrote changes
> scheduling policy so that the interactivity bonus is reduced to -5 ..
> -5, and -5 .. +15 is given as a bonus or penalty for an entire vserver
> that is currently below or above its allocated CPU quotient.  In this
> case the scheduling algorithm hasn't changed, just more feedback is
> given into the effective priorities of the processes being scheduled. 
> ie, there are now two "inputs" (task and vserver) to the existing scheduler.
> 
> I guess the big question is - is there a corresponding concept in
> PlugSched?  for instance, is there a reference in the task_struct to the
> current scheduling domain, or is it more CKRM-style with classification
> modules?

It uses the standard run queue structure with per scheduler 
modifications (via a union) to handle the different ways that the 
schedulers manage priority arrays (so yes).  As I said it restricts 
itself to scheduling matters within each run queue and leaves the wider 
aspects to the normal code.

At first guess, it sounds like adding your scheduler could be as simple 
as taking a copy of ingosched.c (which is the implementation of the 
standard scheduler within PlugSched) and then making your modifications. 
  You could probably even share the same run queue components but 
there's nothing to stop you adding new ones.

Each scheduler can also have its own per task data via a union in the 
task struct.

> 
> If there is a reference in the task_struct to some set of scheduling
> counters, maybe we could squint and say that looks like a namespace, and
> throw it into the nsproxy.

Depends on the scheduler.

> 
>> I'm assuming that you're happy to wait for the next release?  That will 
>> improve the likelihood of descriptions in the patches :-).
>>  
>>
> 
> Let's keep it the technical dialogue going for now, then.

OK.  I'm waiting for the next -mm kernel before I make the next release.

> 
> Now, forgive me if I'm preaching to the vicar here, but have you tried
> using Stacked Git for the patch development?

No, I actually use the gquilt GUI wrapper for quilt 
<http://freshmeat.net/projects/gquilt/> and, although I've modified it 
to use a generic interface to the underlying patch management system 
(a.k.a. back end), I haven't yet modified it to use Stacked GIT as a 
back end.  I have thought about it and it was the primary motivation for 
adding the generic interface but I ran out of enthusiasm.

>  I find the way that you
> build patch descriptions as you go along, can easily wind the commit
> stack to work on individual patches and import other people's work to be
> very simple and powerful.
> 
>   http://www.procode.org/stgit/
> 
> I just mention this because you're not the first person I've talked to
> using Quilt to express some difficulty in producing incremental patchset
> snapshots.  Not having used Quilt myself I'm unsure whether this is a
> deficiency or just "the way it is" once a patch set gets big.

Making quilt easier to use is why I wrote gquilt :-)

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
