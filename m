Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWFBTHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWFBTHA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWFBTHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:07:00 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:13513 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750718AbWFBTG7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:06:59 -0400
Subject: Re: [ckrm-tech] [RFC 3/5] sched: Add CPU rate hard caps
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Peter Williams <peterw@aurema.com>
Cc: Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       dev@openvz.org, Srivatsa <vatsa@in.ibm.com>,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com,
       Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Sam Vilain <sam@vilain.net>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>
In-Reply-To: <447FAEB0.3060103@aurema.com>
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>
	 <20060526042051.2886.70594.sendpatchset@heathwren.pw.nest>
	 <661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com>
	 <44781167.6060700@bigpond.net.au> <447D95DE.1080903@sw.ru>
	 <447DBD44.5040602@in.ibm.com> <447E9A1D.9040109@openvz.org>
	 <447EA694.8060407@in.ibm.com> <1149187413.13336.24.camel@linuxchandra>
	 <447F77A4.3000102@bigpond.net.au> <1149213759.10377.7.camel@linuxchandra>
	 <447FAEB0.3060103@aurema.com>
Content-Type: text/plain
Organization: IBM
Date: Fri, 02 Jun 2006 12:06:47 -0700
Message-Id: <1149275207.20050.16.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-02 at 13:21 +1000, Peter Williams wrote:
> Chandra Seetharaman wrote:
> > On Fri, 2006-06-02 at 09:26 +1000, Peter Williams wrote:
> >> Chandra Seetharaman wrote:
> >>> On Thu, 2006-06-01 at 14:04 +0530, Balbir Singh wrote:
> >>>> Hi, Kirill,
> >>>>
> >>>> Kirill Korotaev wrote:
> >>>>>> Do you have any documented requirements for container resource 
> >>>>>> management?
> >>>>>> Is there a minimum list of features and nice to have features for 
> >>>>>> containers
> >>>>>> as far as resource management is concerned?
> >>>>> Sure! You can check OpenVZ project (http://openvz.org) for example of 
> >>>>> required resource management. BTW, I must agree with other people here 
> >>>>> who noticed that per-process resource management is really useless and 
> >>>>> hard to use :(
> >>> I totally agree.
> >>>> I'll take a look at the references. I agree with you that it will be useful
> >>>> to have resource management for a group of tasks.
> >> But you don't need something as complex as CKRM either.  This capping
> > 
> > All CKRM^W Resource Groups does is to group unrelated/related tasks to a
> > group and apply resource limits. 
> > 
> >>  
> >> functionality coupled with (the lamented) PAGG patches (should have been 
> >> called TAGG for "task aggregation" instead of PAGG for "process 
> >> aggregation") would allow you to implement a kernel module that could 
> >> apply caps to arbitrary groups of tasks.
> > 
> > I do not follow how PAGG + this cap feature can be used to put cap of
> > related/unrelated tasks. Can you provide little more explanation,
> > please.
> 
> I would have thought it was fairly obvious.  PAGG supplies the task 
> aggregation mechanism, these patches provide per task caps and all 
> that's needed is the code that marries the two.

May be obvious from your usage point of view. It wasn't for what i was
thinking as resource management.

I thought there is some way the user can associate some amount of
resources (limits and guarantees) to a PAGG group and move the
corresponding tasks to that PAGG and that is all needed from user
space. 

In other words i thought there is some clever way to manage resources at
the PAGG level (without needing to tinker with the per task caps), which
wasn't obvious for me, and it is now clear that is not the case, and one
still have to keep tweaking the "per task" caps to get the result they
want. 

>From your explanation, complex stuff need to happen in the user space to
manage resource for a group of tasks.

Knobs that are available to the user are
 - per task nice values
 - per task cap limits and
 - per task statistics, if and when they become available.

user level application has to constantly monitor the stats of _all_ the
tasks and constantly keep changing the knobs if they want to keep the
"group of tasks" within their guarantees and limits. As others pointed
already, this may still _not_ yield what one wants, if you have tasks
with disparate need for a resource.

I certainly do not see it as the result of a simple marriage between
PAGG and "per task caps".
> 
> > 
> > Also, i do not think it can provide guarantees to that group of tasks.
> > can it ?
> 
> It could do that by manipulating nice which is already available in the 
> kernel.
> 
> I.e. these patches plus improved statistics (which are coming, I hope) 
> together with the existing policy controls provide all that is necessary 
> to do comprehensive CPU resource control.  If there is an efficient way 
> to get the statistics out to user space (also coming, I hope) this 
> control could be exercised from user space.
> 
> Peter
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


