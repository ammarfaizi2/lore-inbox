Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWHDFDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWHDFDz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWHDFDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:03:54 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:22981 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751392AbWHDFDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:03:53 -0400
Date: Fri, 4 Aug 2006 10:37:53 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Mike Galbraith <efault@gmx.de>,
       Balbir Singh <balbir@in.ibm.com>, sekharan@us.ibm.com,
       Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu controller
Message-ID: <20060804050753.GD27194@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resource management has been talked about quite extensively in the
past, more recently in the context of containers. The basic requirement
here is to provide isolation between *groups* of task wrt their use
of various resources like CPU, Memory, I/O bandwidth, open file-descriptors etc.

Different maintainers have however expressed different opinions over the need to
complicate the kernel to meet this need, especially since it involves core 
kernel code like the resource schedulers. 

A BoF was hence held at OLS this year to come to a consensus on the minimum 
requirements of a resource management solution for Linux kernel. Some notes 
taken at the BoF are posted here:

	http://www.uwsg.indiana.edu/hypermail/linux/kernel/0607.3/0896.html

An important consensus point of the BoF seemed to be "focus on real 
controllers more, preferably memory first, using some simple interface
and task grouping mechanism".

In going forward, following points will need to be addressed:

	- Grouping and interface
		- What mechanism to use for grouping tasks and
		  for specifying task-group resource usage limits?
	- Design of individual resource controllers like memory and cpu

This patch series is an attempt to take forward the design discussion of a
CPU controller.

For simplicity and convenience, cpuset has been chosen as the means to group 
tasks here, primarily because cpuset already exists in the kernel and also 
perhaps resource container definition should be unique only inside a cpuset.

Also I think the controller design can be independent of the grouping
interface and hence can work with any other grouping interface we may
settle on finally for resource management.

Other salient notes about this CPU controller:

	- Is work-in-progress! I am sending this early so that I can get
	  some feedback on the general direction in which to proceed
	  further.  

	- Works only on UP for now (boot with maxcpus=1). IMO group-aware SMP
	  load-balancing can be met using smpnice feature. I will work on this 
	  feature next.

	- Only soft-limit is supported (work-conserving).

	- Each task-group gets its own runqueue on every cpu.

        - In addition, there is an active and expired array of
          task-groups themselves. Task-groups who have expired their
          quota are put into expired array.

        - Task-groups have priorities. Priority of a task-group is the
          same as the priority of the highest-priority runnable task it
          has. This I feel will retain interactiveness of the system
          as it is today.

        - Scheduling the next task involves picking highest priority
          task-group from active array first and then picking highest-priority 
	  task within it. Both steps are O(1).

        - Token are assigned to task-groups based on their assigned quota. Once 
	  they run out of tokens, the task-group is put in an expired array. 
	  Array switch happens when active array is empty.

        - Although the algorithm is very simple, it perhaps needs more
          refinement to handle different cases. Especially I feel task-groups 
	  which are idle most of the time and experience bursts once in a while 
	  will need to be handled better than in this simple scheme.

I would love to hear your comments on these design aspects of the
controller.

-- 
Regards,
vatsa
