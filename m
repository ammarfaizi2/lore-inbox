Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWFRKZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWFRKZH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 06:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbWFRKZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 06:25:07 -0400
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:59500 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751037AbWFRKZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 06:25:05 -0400
Message-ID: <449529FE.1040008@bigpond.net.au>
Date: Sun, 18 Jun 2006 20:25:02 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: kernel@kolivas.org, sam@vilain.net, bsingharora@gmail.com,
       vatsa@in.ibm.com, dev@openvz.org, linux-kernel@vger.kernel.org,
       efault@gmx.de, kingsley@aurema.com, ckrm-tech@lists.sourceforge.net,
       mingo@elte.hu, rene.herman@keyaccess.nl
Subject: Re: [PATCH 0/4] sched: Add CPU rate caps
References: <20060618082638.6061.20172.sendpatchset@heathwren.pw.nest> <20060618025046.77b0cecf.akpm@osdl.org>
In-Reply-To: <20060618025046.77b0cecf.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sun, 18 Jun 2006 10:25:03 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sun, 18 Jun 2006 18:26:38 +1000
> Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
>> These patches implement CPU usage rate limits for tasks.
> 
> Via /proc/pid/cpu_rate_cap.  Important detail, that.

Via /proc/tgid/task/pid/cpu_rate_cap actually.  I.e. it's at the task 
level not the process level.

Also, the /proc interface is just one possible interface and the one I 
implemented because it was easy and useful for testing.  Alternate 
interfaces would be easy to provide (or add).

There are exported functions to set/get caps and all the necessary 
checking is done there.  The /proc stuff is a very thin wrapper around that.

Other options for interfaces would be RLIMIT and/or a syscall.

> 
> People are going to want to extend this to capping a *group* of tasks, with
> some yet-to-be-determined means of tying those tasks together.  How well
> suited is this code to that extension?

Quite good.  It can be used from outside the scheduler to impose caps on 
arbitrary groups of tasks.  Were the PAGG interface available I could 
knock up a module to demonstrate this.  When/if the "task watchers" 
patch is included I will try and implement a higher level mechanism 
using that.  The general technique is to get an estimate of the 
"effective number" of tasks in the group (similar to load) and give each 
task in the group a cap which is the group's cap divided by the 
effective number of tasks (or the group cap whichever is smaller -- i.e. 
the effective number of tasks could be less than one).

Doing it inside the scheduler is also doable but would have some locking 
issues.  The run queue lock could no longer be used to protect the data 
as there's no guarantee that all the tasks in the group are associated 
with the same queue.

> 
> If the task can exceed its cap without impacting any other tasks (ie: there
> is spare idle capacity), what happens?

That's the difference between soft and hard caps.  If it's a soft cap 
then the task is allowed to exceed it if there's spare capacity.  If 
it's a hard cap it's not.

>  I trust that spare capacity gets
> used?  (Is this termed "work conserving"?)

Soft caps, yes.  Hard caps, no.

> 
>> 5. Code size measurements:
>>
>> Vanilla kernel:
>>
>>    text    data     bss     dec     hex filename
>>   33800    4689     296   38785    9781 sched.o
>>    2554      79       0    2633     a49 mutex.o
>>   12076    2632       0   14708    3974 base.o
>>
>> Patches applied:
>>
>>    text    data     bss     dec     hex filename
>>   36870    4721     296   41887    a39f sched.o
>>    2630      79       0    2709     a95 mutex.o
>>   13011    2920       0   15931    3e3b base.o
>>
>> Indicating that the size cost of the patch proper is about
>> 3 kilobytes and the procfs costs about another 1.2 kilobytes.
>>
> 
> hm.  That seems rather a lot.  I guess it's not a simple thing to do.

I suspect that a large part of that is the functions that set the caps 
(i.e. the equivalents of set_user_nice()) one for soft and one for hard 
caps.  The actual capping mechanisms are quite simple.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
