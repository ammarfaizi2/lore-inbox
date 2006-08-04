Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWHDLMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWHDLMd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 07:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWHDLMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 07:12:33 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:56044 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751412AbWHDLMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 07:12:32 -0400
Date: Fri, 4 Aug 2006 16:46:38 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu controller
Message-ID: <20060804111638.GA28490@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060804050753.GD27194@in.ibm.com> <20060803223650.423f2e6a.akpm@osdl.org> <20060804065615.GA26960@in.ibm.com> <20060804001342.1168e5ab.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060804001342.1168e5ab.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 12:13:42AM -0700, Andrew Morton wrote:
> There was a lot of discussion last time - Mike, Ingo, others.  It would be
> a useful starting point if we could be refreshed on what the main issues
> were, and whether/how this new patchset addresses them.

The main issues raised against the CPU controller posted last time were
these:

(ref : http://lkml.org/lkml/2006/4/20/404)

a. Interactive tasks not handled
	The patch, which was mainly based on scaling down timeslice of tasks 
	that are above their guarantee, left interactive tasks untouched. This 
	meant that interactive tasks could run uncontrolled and would have 
	affected the guaranteed bandwidth provided for other tasks.

b. Task groups with uncontrolled number of tasks not handled well
	The patch retained current single runqueue per-cpu. Thus the runqueue 
	would contain a mixture of tasks belonging to different groups. Also 
	each task was given a minimum timeslice of 1 tick. This meant that we 
	could not limit the CPU bandwidth of a group that has a large number of 
	tasks to the desired extent.

c. SMP-correctness not implemented
	 Guaranteed bandwidth wasn't observed on all CPUs put together

d. Supported only guaranteed bandwidth and not soft/hard limit.

e. Bursty workloads not handled well
	Scaling down of timeslice, to meet the increased demand of 
	higher-guaranteed task-groups, was not instantaneous. Rather 
   	timeslice was scaled down when tasks expired their timeslice
   	and were moved to expired array. This meant that bursty workloads
   	would get their due share rather slowly.

Apart from these, the other observation I had was that:

f. Incorrect load accounting?
	Load of a task was accounted only when it expired its timeslice, rather 
	than while it was running. This IMO can lead to improper observation of 
	load a task-group has on a given CPU at times and thus affect
	guaranteed bandwidth for other task-groups.

Could we have overcome all these issue with slight changes to the
design? Hard to say. IMHO we get better control only by segregating tasks
into different runqueues and getting control over which task-group to
schedule next, which is what this new patch attempts to do.

In summary, the patch should address limitations a, b, e and f. I am hoping to 
address c using smpnice approach. Regarding d, this patch provides more
of a soft-limit feature. Some guaranteed usage for task-groups can still
be met, I feel, by limiting the CPU usage of other groups.

To take all this forward, these significant points need to be decided
for a CPU controller:

1. Do we want to split the current 1 runqueue per-CPU into 1 runqueue
   per-task-group per-CPU?

2. How should task-group priority be decided? The decision we take for
   this impacts interactivity of the system. In my patch, I attempt to
   retain good interactivty by letting task-group priority be decided by
   the highest priority task it has.

3. How do we accomplish SMP correctness for task-group bandwidth?
   I believe OpenVZ uses virtual runqueues, which simplifies 
   load balancing a bit, though not sure if that is at the expense
   of increased lock contention. IMHO we can try going smpnice route and
   see how far that can take us.

Ingo/Nick, what are your thoughts here?

-- 
Regards,
vatsa
