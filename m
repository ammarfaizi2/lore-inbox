Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbVEMR2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbVEMR2y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 13:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbVEMR2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 13:28:53 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:34769 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262448AbVEMRZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 13:25:47 -0400
Date: Fri, 13 May 2005 22:55:40 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Dinakar Guniguntala <dino@in.ibm.com>
Cc: Nathan Lynch <ntl@pobox.com>, Paul Jackson <pj@sgi.com>,
       Simon.Derr@bull.net, lse-tech@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       lkml <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Lse-tech] Re: [PATCH] cpusets+hotplug+preepmt broken
Message-ID: <20050513172540.GA28018@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050511191654.GA3916@in.ibm.com> <20050511195156.GE3614@otto> <20050513123216.GB3968@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513123216.GB3968@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 06:02:17PM +0530, Dinakar Guniguntala wrote:
> attach_task in cpuset.c is called without holding the hotplug 
> lock and it is possible to call set_cpus_allowed for a task with no 
> online cpus. 

This in fact was the reason that we added lock_cpu_hotplug in sched_setaffinity.

Also guarantee_online_cpus seems to be accessing cpu_online_map with preemption 
enabled (& no hotplug lock taken). This is highly not recommended.

> Given this I think the patch I sent first is the most appropriate
> patch. 

I agree that taking the hotplug lock seems reasonable here.

> In addition we also need to take hotplug lock in the cpusets
> code whenever we are modifying cpus_allowed of a task. IOW make cpusets 
> and hotplug operations completly exclusive to each other. The same 
> applies to memory hotplug code once it gets in.
> 
> However on the downside this would mean 
> 1. A lot of nested locks (mostly in cpuset_common_file_write)
> 2. Taking of hotplug (cpu now and later memory) locks for operations
>    that may just be updating a flag

Given the fact that CPU/Memory hotplug and cpuset operation may
be infrequent events, this will probably be not a concern. 

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
