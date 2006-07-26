Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161021AbWGZSa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbWGZSa7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 14:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbWGZSa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 14:30:59 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:23783 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161021AbWGZSa6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 14:30:58 -0400
Date: Wed, 26 Jul 2006 07:33:20 -0700
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Kirill Korotaev <dev@sw.ru>, Dipankar <dipankar@in.ibm.com>,
       riel@redhat.com, jdike@addtoit.com,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Dave Hansen <haveblue@us.ibm.com>, clg@fr.ibm.com,
       Serge Hellyn <serue@us.ibm.com>, ebiederm@xmission.com,
       Badari Pulavarti <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       sekharan@us.ibm.com, Balbir Singh <balbir@in.ibm.com>,
       Shailabh Nagar <nagar@watson.ibm.com>, a.p.zijlstra@chello.nl
Subject: OLS BoF on Resource Management - some notes
Message-ID: <20060726143320.GC16852@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,
	The recent (ongoing) work on containers has brought a lot of focus to 
resource management capabilities of Linux kernel. Workload management tools 
also need the capability to manage workloads better. Both users have felt the 
need for better resource management capabilities of Linux kernel than what 
exists today. Nick (at OLS) suggested that some minimal requirements be worked 
out that can satisfy some needs of both parties.

An impromptu BoF was hence arranged by Dipankar Sarma to discuss this at OLS. 
The BoF was attended by several folks (most of folks on CC list), including 
those from ckrm and openvz teams. Shailabh Nagar (of ckrm team) and Kirill 
Korotaev (of openvz team) presented their views/requirements of resource 
management from workload manager and container perspectives respectively.

I did some note-taking during the BoF, which is shared below. I sincerely 
apologize if there are some errors in the notes or if I have missed to note 
other important points that were discussed.

Broadly these were the points discussed. I dont think these reflect any final 
decisions made on the interface/requirements but more of a common ground to 
begin with.

A - Task grouping
	Ability to apply resource control over a group tasks was felt necessary.

	It was suggested that the kernel maintain some generic "task group" 
	structure, to represent a group of tasks, which can be used for
	various purposes - resource management, security, containers (?) etc.

- Heirarchial grouping?
	Should we support a heirarchy of groups?  This can be supported only 
	if various controllers recognize/support the heirarchy too, which will 
	complicate them.

	It was suggested that we dont support this initially. 

- Dynamic group membership
	Should we allow movement of tasks willingly from one group to other?

	Some implications of this requirement in memory controller (transfer of 
	page-ownership) were discussed. Also questions like "how fast should 
	this change be visible" were raised.

	It was felt that this be not allowed in the 1st pass i.e once a 
	task is bound to a group, it is struck to that group till it exits.

- Controller-specific grouping?
	Should the task-group definition be different for different controllers?

	For example, should we allow container A to belong to two different 
	groups, G1 and G2, simultaneously, where G1 governs its CPU usage and 
	G2 governs its memory usage?

	It was felt that we dont attempt to do this initially.

- Interface to manage (create/delete) groups:
	Should it be system-call or file-system based?

	This was not discussed and was felt to be a non-issue. Maybe we could 
	start with system call to begin with (like what the openvz people have).


B - Resource limit and/or guarantee
	Should the resource control be specified in terms of guarantee or 
	(soft/hard) limit?

	It was felt that we attempt to provide limit functionality only in 
	the 1st pass. Soft or hard limit can be left to the discreetion of 
	controller.

- Absolute or relative limit?
	Should the limit be specified in absolute terms (limit group G1's
	memory usage to 20%) or relative terms (group G1's limit is half
	that of G2)?

		It was felt again that this be left to the discreetion of the 
	controller. Controller should export this information and also
	the unit of measuring this limit.

-  Resource control epoch:
	Over what interval should the resource control be applied?

	This was again felt should be left to the discreetion of the controller.


C - Resources to manage
	Openvz cares for almost everything (cpu, memory, disk i/o, network,
	open files, etc)! 

	Some suggested that a simple controller like number-of-tasks be posted
	to illustrate the grouping and infrastructure. Others felt that
	we need to go for "real" controllers like memory and cpu. The design
	of memory controller received lot of interest and it was felt that
	we attempt to do memory controller first.


In summary, the consensus seemed to be:

	- Focus on controllers more (preferably memory first). Keep them
	  simple to begin with, willing to sacrifice accuracy to an
	  extent where necessary.

	- Choose some minimal interface for starters (say a syscall to
	  start new group and another one to set/change limit?).


-- 
Regards,
vatsa
