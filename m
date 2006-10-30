Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161211AbWJ3K3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161211AbWJ3K3J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 05:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161212AbWJ3K3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 05:29:09 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:42891 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161211AbWJ3K3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 05:29:07 -0500
Date: Mon, 30 Oct 2006 16:03:56 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: dev@openvz.org, sekharan@us.ibm.com, menage@google.com
Cc: pj@sgi.com, akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       rohitseth@google.com, balbir@in.ibm.com, dipankar@in.ibm.com,
       matthltc@us.ibm.com, haveblue@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [RFC] Resource Management - Infrastructure choices
Message-ID: <20061030103356.GA16833@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Over the last couple of months, we have seen a number of proposals for
resource management infrastructure/controllers and also good discussions
surrounding those proposals. These discussions has resulted in few
consensus points and few other points that are still being debated.

This RFC is an attempt to:

	o summarize various proposals to date for infrastructure

	o summarize consensus/debated points for infrastructure

	o (more importantly) get various stakeholders agree on what is a good 
	  compromise for infrastructure in going forward

Couple of questions that I am trying to address in this RFC:

	- Do we wait till controllers are worked out before merging
	  any infrastructure?

		IMHO, its good if we can merge some basic infrastructure now
		and incrementally enhance it and add controllers based on it. 
		This perspective leads to the second question below ..

	- Paul Menage's patches present a rework of existing code, which makes 
	  it simpler to get it in. Does it meet container (Openvz/Linux
	  VServer) and resource management requirements?

		Paul has ported over the CKRM code on top of his patches. So I 
		am optimistic that it meets resource management requirements in 
		general.

	  	One shortcoming I have seen in it is that it lacks an 
		efficient method to retrieve tasks associated with a group. 
		This may be needed by few controllers implementations if they 
		have to support, say, change of resource limits. This however 
		I think could be addressed quite easily (by a linked list
		hanging off each container structure).

Resource Management - Goals
---------------------------

Develop mechanisms for isolating use of shared resources like cpu, memory 
between various applications. This includes:

	- mechanism to group tasks by some attribute (ex: containers, 
	  CKRM/RG class, cpuset etc)

	- mechanism to monitor and control usage of a variety of resources by 
	  such groups of tasks

Resources to be managed:

	- Memory, CPU and disk I/O bandwidth (of high interest perhaps)
	- network bandwidth, number of tasks/file-descriptors/sockets etc.


Proposals to date for infrastructure
------------------------------------

	- CKRM/RG
	- UBC
	- Container implementation (by Paul Menage) based on generalization of 	
	  cpusets.


A. Class-based Kernel Resource Management/Resource Groups

	Framework to monitor/control use of various resources by a group of 
	tasks as per specified guarantee/limits.

	Provides a config-fs based interface to:

		- create/delete task-groups
		- allow a task to change its (or some other task's) association 
		  from one group to other (provided it has the right 
		  privileges). New children of the affected task inherit the 
		  same group association.
		- list tasks present in a group (A group can exist without any 
		  tasks associated with it)
		- specify group's min/max use of various resources. A special 
		  value "DONT_CARE" specifies that the group doesn't care for 
		  how much resource it gets.
		- obtain resource usage statistics
		- Supports heirarchy depth of 1 (??)

	In addition to this user-interface, it provides a framework for 
	controllers to:

		- register/deregister themselves
		- be intimated about changes in resource allocation for a group
		- be intimated about task movements between groups
		- be intimated about creation/deletion of groups
		- know which group a task belongs to

B. UBC

	Framework to account and limit usage of various resources by a 
	container (group of tasks).

	Provides a system call based interface to:

		- set a task's beancounter id. If the id does not exist, a new 
		  beancounter object is created
		- change a task's association from one beancounter to other
		- return beancounter id to which the calling task belongs
		- set limits of consumption of a particular resource by a 
		  beancounter
		- return statistics information for a given beancounter and 
		  resource.


	Provides a framework for controllers to:

		- register various resources
		- lookup beancounter object given a particular id
		- charge/uncharge usage of some resource to a beancounter by 
	 	  some amount
			- also know if the resulting usage is above the allowed 
			  soft/hard limit.
		- change a task's accounting beancounter (usefull in, say, 
		  interrupt handling)
		- know when the resource limits change for a beancounter

C. Paul Menage's container patches

	Provides a generic heirarchial process grouping mechanism based on 
	cpusets, which can be used for resource management purposes.

	Provides a filesystem-based interface to:

		- create/destroy containers
		- change a task's association from one container to other
		- retrieve all the tasks associated with a container
		- know which container a task belongs to (from /proc)
		- know when the last task belonging to a container has exited


Consensus/Debated Points
------------------------

Consensus:

	- Provide resource control over a group of tasks 
	- Support movement of task from one resource group to another
	- Dont support heirarchy for now
	- Support limit (soft and/or hard depending on the resource
	  type) in controllers. Guarantee feature could be indirectly
	  met thr limits.

Debated:
	- syscall vs configfs interface
	- Interaction of resource controllers, containers and cpusets
		- Should we support, for instance, creation of resource
		  groups/containers under a cpuset?
	- Should we have different groupings for different resources?
	- Support movement of all threads of a process from one group
	  to another atomically?

-- 
Regards,
vatsa
