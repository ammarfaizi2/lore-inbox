Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWFRMTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWFRMTL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 08:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWFRMTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 08:19:10 -0400
Received: from omta01sl.mx.bigpond.com ([144.140.92.153]:8597 "EHLO
	omta01sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932197AbWFRMTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 08:19:08 -0400
Message-ID: <449544B9.7030501@bigpond.net.au>
Date: Sun, 18 Jun 2006 22:19:05 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>, kernel@kolivas.org, sam@vilain.net,
       bsingharora@gmail.com, dev@openvz.org, linux-kernel@vger.kernel.org,
       efault@gmx.de, kingsley@aurema.com, ckrm-tech@lists.sourceforge.net,
       mingo@elte.hu, rene.herman@keyaccess.nl
Subject: Re: [PATCH 0/4] sched: Add CPU rate caps
References: <20060618082638.6061.20172.sendpatchset@heathwren.pw.nest> <20060618025046.77b0cecf.akpm@osdl.org> <449529FE.1040008@bigpond.net.au> <20060618114246.GA17386@in.ibm.com>
In-Reply-To: <20060618114246.GA17386@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sun, 18 Jun 2006 12:19:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Sun, Jun 18, 2006 at 08:25:02PM +1000, Peter Williams wrote:
>>> People are going to want to extend this to capping a *group* of tasks, with
>>> some yet-to-be-determined means of tying those tasks together.  How well
>>> suited is this code to that extension?
>> Quite good.  It can be used from outside the scheduler to impose caps on 
>> arbitrary groups of tasks.  Were the PAGG interface available I could 
>> knock up a module to demonstrate this.  When/if the "task watchers" 
> 
> For demonstration purpose, maybe you could use tsk->uid to group tasks and 
> and see how capping at group level works out? Basically cap the per-user cpu
> usage.

I was thinking of doing the group of tasks that represent a process's 
threads as a first example as that will be more useful to ordinary users 
as well as demonstrating the technique.

> 
>> patch is included I will try and implement a higher level mechanism 
>> using that.  The general technique is to get an estimate of the 
>> "effective number" of tasks in the group (similar to load) and give each 
>> task in the group a cap which is the group's cap divided by the 
>> effective number of tasks (or the group cap whichever is smaller -- i.e. 
>> the effective number of tasks could be less than one).
> 
> For "effective number" do you include only runnable tasks?

It would be roughly equivalent to a smoothed smoothed estimate of the 
number of runnable tasks in the group.

> As and when
> this number changes, you would need to go and change the per-task cap of
> all tasks in the group. Any idea what the cost of that operation would
> be? Or do you intend to do it lazily to amortize some of that cost?

Yes.  It would be some form of periodical sampling mechanism.  It could 
be done from user space or from a module.

The costs can also be reduced by realizing that it is only necessary to 
do anything at all if the number of tasks in the group is greater than 
the group's cap.  I.e. if a group has a cap of 3000 but only two tasks 
there is no way the group can exceed its cap so that group can be ignored.

> 
>> Doing it inside the scheduler is also doable but would have some locking 
>> issues.  The run queue lock could no longer be used to protect the data 
>> as there's no guarantee that all the tasks in the group are associated 
>> with the same queue.
> 


-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
