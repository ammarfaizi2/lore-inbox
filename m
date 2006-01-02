Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWABXyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWABXyF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 18:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWABXyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 18:54:04 -0500
Received: from omta04sl.mx.bigpond.com ([144.140.93.156]:23944 "EHLO
	omta04sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751126AbWABXyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 18:54:03 -0500
Message-ID: <43B9BD19.5050408@bigpond.net.au>
Date: Tue, 03 Jan 2006 10:54:01 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client on	interactive
 response
References: <43A8EF87.1080108@bigpond.net.au> <1135145341.7910.17.camel@lade.trondhjem.org> <43A8F714.4020406@bigpond.net.au> <20060102110145.GA25624@aitel.hist.no>
In-Reply-To: <20060102110145.GA25624@aitel.hist.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 2 Jan 2006 23:54:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> On Wed, Dec 21, 2005 at 05:32:52PM +1100, Peter Williams wrote:
> 
>>Trond Myklebust wrote:
> 
> [...]
> 
>>>Sorry. That theory is just plain wrong. ALL of those case _ARE_
>>>interactive sleeps.
>>
>>It's not a theory.  It's a result of observing a -j 16 build with the 
>>sources on an NFS mounted file system with top with and without the 
>>patches and comparing that with the same builds with the sources on a 
>>local file system.  Without the patches the tasks in the kernel build 
>>all get the same dynamic priority as the X server and other interactive 
>>programs when the sources are on an NFS mounted file system.  With the 
>>patches they generally have dynamic priorities between 6 to 10 higher 
>>than the X server and other interactive programs.
>>
> 
> A process waiting for NFS data looses cpu time, which is spent on running 
> something else.  Therefore, it gains some priority so it won't be
> forever behind when it wakes up.  Same as for any other io waiting.

That's more or less independent of this issue as the distribution of CPU 
to tasks is largely determined by the time slice mechanism and the 
dynamic priority is primarily about latency.  (This distinction is a 
little distorted by the fact that, under some circumstances, 
"interactive" tasks don't get moved to the expired list at the end of 
their time slice but this usually won't matter as genuine interactive 
tasks aren't generally CPU hogs.)  In other words, the issue that you 
raised is largely solved by the time tasks spend on the active queue 
before moving to the expired queue rather than the order in which they 
run when on the active queue.

This problem is all about those tasks getting an inappropriate boost to 
improve their latency because they are mistakenly believed to be 
interactive.  Having had a closer think about the way the scheduler 
works I'm now of the opinion that completely ignoring sleeps labelled as 
TASK_NONINTERACTIVE may be a mistake and that it might be more 
appropriate to treat them the same as TASK_UNITERRUPTIBLE but I'll bow 
to Ingo on this as he would have a better understanding of the issues 
involved.

> 
> Perhaps expecting a 16-way parallel make to have "no impact" is
> a bit optimistic.  How about nicing the make, explicitly telling
> linux that it isn't important?

Yes, but that shouldn't be necessary.  If I do the same build on a local 
file system everything works OK and the tasks in the build have dynamic 
priorities 8 to 10 slots higher than the X server and other interactive 
programs.

>  Or how about giving important
> tasks extra priority?

Only root can do that.  But some operating systems do just that e.g. 
Solaris has an IA scheduling class (which all X based programs are run 
in) that takes precedence over programs in the TS class (which is the 
equivalent of Linus's SCHED_NORMAL).  I'm not sure how they handle the 
privileges issues related to stopping inappropriate programs misusing 
the IA class.  IA is really just TS with a boost which is effectively 
just the reverse implementation of what the new SCHED_BATCH achieves. 
Arguably, SCHED_BATCH is the superior way of doing this as it doesn't 
cause any privilege issues as shifting to SCHED_BATCH can be done by the 
owner of the task.

The main drawback to the SCHED_BATCH approach is that it (currently) 
requires the user to explicitly set it on the relevant tasks.  It's long 
term success would be greatly enhanced if programmers could be convinced 
to have their programs switch themselves to SCHED_BATCH unless they are 
genuine interactive processes.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
