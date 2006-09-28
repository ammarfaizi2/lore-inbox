Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWI1RZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWI1RZr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 13:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbWI1RZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 13:25:47 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:55174 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751958AbWI1RZq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 13:25:46 -0400
Date: Thu, 28 Sep 2006 22:55:20 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@openvz.org>,
       Mike Galbraith <efault@gmx.de>, Balbir Singh <balbir@in.ibm.com>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com,
       ckrm-tech@lists.sourceforge.net
Subject: [RFC, PATCH 0/9] CPU Controller V2
Message-ID: <20060928172520.GA8746@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's V2 of the token-based CPU controller I have been working on.

Changes since last version (posted at http://lkml.org/lkml/2006/8/20/115):

	- Task load was not changed when it moved between task-groups of
	  different quota (bug hit by Mike Galbraith).

	- SMP load balance seems to work -much- better now wrt its awaress
	  of quota on each task-group. The trick was to go beyond the
	  max_load difference in __move_tasks and instead use the load
	  difference between two task-groups on the different cpus as
	  basis of pulling tasks.

	- Better timeslice management, aimed at handling bursty
	  workloads better. Patch 3/9 has documentation on timeslice
	  management for various task-groups.

	- Modified cpuset interface as per Paul Jackson's suggestions.
	  Some of the changes are:
		- s/meter_cpu/cpu_meter_enabled
		- s/cpu_quota/cpu_meter_quota
		- s/FILE_METER_FLAG/FILE_CPU_METER_ENABLED
		- s/FILE_METER_QUOTA/FILE_CPU_METER_QUOTA
		- Dont allow cpu_meter_enabled to be turned on for an
		  "in-use" cpuset (which has tasks attached to it)
		- Dont allow cpu_meter_quota to be changed for an 
		  "in-use" cpuset (which has tasks attached to it)
		  
		  Last two are temporary limitations until we figure out how
		  to get to a cpuset's task-list more easily. 

Still on my todo list:

	- Improved surplus cycles management. If A, B and C groups have
	  been given 50%, 30% and 20%  quota respectively and if group B
	  is idle, B's quota has to be divided b/n A and C in the 5:2 
	  proportion.
	
	- Although load balance seems to be working nicely for the
	  testcases I have been running, I anticipate certain corner
	  cases which are yet to be worked out. Especially I need to
	  make sure some of the HT/MC optimizations are not broken.


Ingo/Nick, IMHO virtualizing cpu-runqueues approach to solve the controller 
need is not a good idea, since:

	- retaining existing load-balance optimizations for MC/SMT case is 
	  going to be hard (has to be done at schedule time now)
	- because of virtualization, two virtual cpus could end up running on 
	  the same physical cpu which would affect the carefull SMP 
	  optimizations put in place are all-over the kernel
	- not to mention specialized apps which want to bind to CPUs for 
	  performance reasons may behave badly in such a virtualized
	  environment.

Hence I have been pursuing more simpler approaches like in this patch.

Your comments/views on this are highly appreciated.

-- 
Regards,
vatsa
