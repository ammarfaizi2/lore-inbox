Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264301AbUEXRNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264301AbUEXRNl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 13:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264357AbUEXRNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 13:13:41 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:63187 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264301AbUEXRNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 13:13:21 -0400
Date: Mon, 24 May 2004 10:09:07 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
cc: Erik Jacobson <erikj@subway.americas.sgi.com>, Paul Jackson <pj@sgi.com>,
       frankeh@watson.ibm.com, hannal@us.ibm.com, kanderso@redhat.com,
       limin@sgi.com, jlan@sgi.com, jh@sgi.com,
       Vivek Kashyap <kashyapv@us.ibm.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Shailabh Nagar <nagar@watson.ibm.com>, Rik van Riel <riel@redhat.com>,
       gh@us.ibm.com, peterw@aurema.com, ralf@suse.de, mason@suse.com
Subject: Minutes from 5/19 CKRM/PAGG discussion
Message-ID: <30270000.1085418547@dyn318071bld.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Minutes from LSE call on CKRM and PAGG on May 19, 2004. 

Here are the websites for the respective projects:

http://ckrm.sf.net
http://sourceforge.net/projects/ckrm/
http://oss.sgi.com/projects/pagg
http://oss.sgi.com/projects/csa
http://elsa.sf.net

Conclusion:

        CSA/PAGG look at CKRM
        CKRM look at PAGG

Shailabh presented a short overview of CKRM.
	- for the latest design description read LinuxTAG paper
	- working prototype on ckrm.sf.net
	- Major concepts:
		-> Class type refers to kernel objects being controlled
		-> Class -> grouping of objects	
			e.g. task_class is equivalent to a job 
			container which is a collection of tasks
			e.g. socket_class
		-> Resource Controller
			-> control and modifications to basic schedulers
				- enforce resource shares
				- gather statistics
		-> Classification Engine
			-> automatic classification of kernel objects 
				into classes
		-> RCFS:
			- a file system interface 
			- Class types are top level directories
			- Classes are sub-directories under the 
			  class types
			- resource controllers show up as lines in the 
			  files contained in the directories
		-> flexible and generic
			- Modular. One can include only what one 
			needs and/or prefers.
			- development of various components is 
			independent of others
		-> one run queue per class
			-> controllers need read write
			-> hierarchical sub classes requires rewrite
		-> monitoring module
			-> class level monitoring module
			-> per class monitoring to be developed fully
		-> flexibility to the user
			-> dynamic grouping defined by the user.
			-> emphasis on rapidly moving from one class 
			   to another 
		-> performance impact of hierarchies not looked at.
			-> if hiearrchies in kernel is costly then we 
			   will move to flat hierarchies.
		-> working prototype of all 

Discussion on hierarchies:
(could not map all voices to names...also might have guessed wrong.)

	-> Rik: hierarchical schedulers exist in the kernel. 
		Does have hierarchical network schedulers
	-> if you go hierarchical cpu scheduler will not scale 
	-> you don't have to check limits for each walk. 
	   keep track of usage and once in a while update it.
			(edit: lazy update and lazy evaluation)
	-> you have to take walks -- potentially every scheduling decision 
	   might becoming serialised. -- peter Williams....
	-> instead do it for your hierarchies once in a while take a global view.
	->Shailabh: Such evaluation might introduce inaccuracies in share 
	 enforcement. Therefore it is a balance between accurate enforcement 
	of share vs. hierarchy.
		(edit: maybe a hierarchy only a few levels deep -upto 3/4-
		 will be accurate enough??)
	-> then do it in user space.
	-> leave the scheduler alone
		-> do it from the outside -- from kernel module or user space
	-> Gerrit: NUMA hierarchy/hyper threading is a heirarchy. 
		Kernel scheduler has NUMA hooks
	-> NUMA -- only load balancing not scheduling -- 
	-> Rik: class is similar  -- only once in a while
		-> need not be in the main scheduler

	------> might be implementable in differnet ways. Need to discuss in
		more detail.
	
Overview of PAGG:
	process aggregate
	kernel modules to group process together
	child will inherit the pagg and notify the kernel module
	
(John)	PAGG is simple...way of grouping process together. 
	have multiple simultaneous groupings.
	first modules is job module.
		- implements an inescapable set of processes
		- can't change job ids
	- working on code that implements cluster wide ids
	- processes that are related from the standpoint of 
	  NUMA placement
	-> associate process beyond process groups is very useful.
	->  There is similarity between PAGG and task_class
	-> Except a task can belong to different jobs	
	-> CSA on top of PAGG are like resource controllers.
	-> PAGG is more flexibile in one dimension
		-> how much resource is being used
		-> memory placement
	-> PAGG is more flexible due to this
	-> CKRM's objective is resource management
		-> choose your controllers
	-> then all controllers are active
	-> can have classtypes with different controllers
	-> PAGG Structure: Attach and detach functions and private data
	-> ... Makes it easy to load/unload a module.
	-> What was the real motivation for PAGG?
	-> multiple cases where we want to group processes
	-> What is using PAGG?
		->job container
		-> CSA using job container
		-> Working on:
			cluster wide collection of process
	-> What is the kernel impact of cluster wide id
		-> Unique id is needed for the cluster group
			-> cleanup reason ..track down all processes 
	->For NUMA placement
		- CPU Memset does work with it
		- has intenions of using it
		(edit: didn't catch if using if at present).
	-> How much is CSA code is all by itself?
		->  ...in theory independent but not in current 
			implementation. Need work. 
		Three ways:
		-> PAGG + job container
		-> PAGG + job container + CSA patch
		-> PAGG + NUMA
	-> What is required to integrate? 
		-> CKRM--- It is for resource control
	-> it is not all or nothing.
	-> does not allow NUMA grouping vs. resource grouping
	-> Question: Can one implement job container function using CKRM
	-> Answer: Take CKRM core patch -- write your own CE -- write your 
		set of fucntion hooks load your CE and that is all you need.
	-> Why are you against PAGG? Implementing on top of PAGG will reduce 
	the work CKRM needs?  Won't need to implement job container part.

	-> Not against. Trying to find out exploiters of PAGG functionlity:

	-> Does PAGG have capability to get notified on events...
	-> Callback? that adds setuid/setgid etc. 
	-> yes, just added...
	-> clone?
	-> go through fork

	-> What is the use of setuid/setgid for PAGG?
	-> affinity yes

Combining? Coming up with one solution:
	-> Break CKRM into small pieces...
	-> perception issue of breaking up the CKRM.... had 6 differnet patches
	-> Breaking up the patches...changes things
	-> Conceptually done it separately...but not presented it as well.
	-> (Suse: Chris Mason?) people really identify the common functionality.
	    hard to pick from among you.

	-> Something that is not going to change choose interfaces for 
	   userland and kernel
	->(Gerrit) Have opensource applications that use them
	-> PAGG/Peter? 
		Don't need to invent new ones but need to come together on it.	
	-> Shailabh: kernel - user interface e.g. /rcfs

	-> whether CPUMEMSETS and CKRM can be combined?
	- Paul Jackson : Not focussed on a particular technology
		CKRM purposes are distinct from NUMA purposes. Independent goals
		
		Have plans to use PAGG's lowest level hooks in CPUMEMSET.

	-> once the hook is there anyone can use it..

	- if it is useful and does't cause harm then use it.

	-> Hanna : discuss on lse-tech@lists.sf.net.
	-> can use pagg list
	-> Hanna/Gerrit : Talking about interop - scaling from desktop to 
		enterprise. 
	<Agreement on lse-tech...post minutes on lse-tech>

	-> Join forces and come up with a plan
	-> If PAGG functionality to include what CKRM needs.  
		- Expanding the goal makes it more complex....
		- harder to get in
		- performace implications

	-> Shailabh: CKRM will consider looking at the lowest level of PAGG 
			- Not committing to use it
			- Evaluating it

	Suse ? --- certainly willing to consolidate these projects.

	Ralf -- CKRM is in beta5
		- Looks like the teams can benefit from each other.
		- need to consider if CKRM needs to be pulled out now and
		  added later. 

	-> What are the users of PAGG other than CSA? at least one other user?
		-> (Peter) ARMTech  solaris and windows 
		-> Is it opensourced? 
		-> (Peter) should be somewhere....
		- (Peter?)Will look at CKRM hooks
		-> (Paul Jackson) CPUMEMSETS. don't know the timeframe 

Conclusion:

	CSA/PAGG look at CKRM 
	CKRM look at PAGG


