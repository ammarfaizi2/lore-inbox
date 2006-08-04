Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161233AbWHDPaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161233AbWHDPaB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 11:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbWHDPaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 11:30:01 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:47039 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932589AbWHDPaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 11:30:00 -0400
Message-ID: <44D367F3.8060108@watson.ibm.com>
Date: Fri, 04 Aug 2006 11:29:55 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: Andrew Morton <akpm@osdl.org>, vatsa@in.ibm.com, mingo@elte.hu,
       nickpiggin@yahoo.com.au, sam@vilain.net, linux-kernel@vger.kernel.org,
       dev@openvz.org, efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [ProbableSpam] Re: [RFC, PATCH 0/5] Going forward with Resource
 Management - A cpu  controller
References: <20060804050753.GD27194@in.ibm.com> <20060803223650.423f2e6a.akpm@osdl.org> <44D35794.2040003@sw.ru>
In-Reply-To: <44D35794.2040003@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:

> I was familiar. And I can arise many arguable points in the CKRM
> infrastructure.
> 
> For example:
> 1. Should task-group be changeable after set/inherited once?
>  Are you planning to recalculate resources on group change?
>  e.g. shared memory or used kernel memory is hard to recalculate.

As far as Resource Group requirements go, preserving the ability to
migrate tasks from one task-group to another is essential.

As Christoph points out, its not something we need to do right now
but it shouldn't and needn't be eliminated.

If userspace wants an application's resource usage to depend on the kind
of work it is doing, then it must have a way to move the tasks of that
application to a different task-group (which encapsulates a different resource
limit setting) without having to restart it.

If the application is having a heavy shared resource usage that makes it hard
to have *accurate* control once it is moved to a different resource group, thats
fine - the flexibility to move has a price.

But lets not worry about this aspect right now until the controllers are sorted
out.

> 2. should task-group resource container manage all the resources as a
> whole?
>  e.g. in OpenVZ tasks can belong to different CPU and UBC containers.
>  It is more flexible and e.g. we used to put some vital kernel threads
>  to a separate CPU group to decrease delays in service.

I personally like this flexibility too.
The price you pay for it is
- that the number of "attachments" from a task
grows with the number of controllers (not a big deal)
- if you expose the groupings to userspace, users have a larger namespace
(of controlled groups) to deal with which can get confusing if all they want
is "one" systemwide view of resource groups (and not one per resource).

At the BoF (and earlier discussions on this topic in CKRM), the reasons offered
for going with a single systemwide grouping was simplicity for the user and
since it would be simpler to implement initially.

But since one can always have a userspace tool that creates identical
groupings for each controller and presents a single systemwide grouping to the
user, I don't think this is a real issue.

> 3. I also don't understand why normal binary interface like system call
> is not used.
>   We have set_uid, sys_setrlimit and it works pretty good, does it?

If there are no hierarchies, a syscall interface is fine since the namespace
for the task-group is flat (so one can export to userspace either a number or a
string as a handle to that task-group for operations like create, delete,
set limit, get usage, etc)

A filesystem based interface is useful when you have hierarchies (as resource
groups and cpusets do) since it naturally defines a convenient to use
hierarchical namespace.

> 4. do we want hierarchical grouping?
> 
>>>     - Design of individual resource controllers like memory and cpu
>>
>>
>>
>> Right.  We won't be controlling memory, numtasks, disk, network etc
>> controllers via cpusets, will we?
> 
> I hope so :)
> 
> Thanks,
> Kirill
> 

