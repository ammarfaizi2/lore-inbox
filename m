Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWFOXaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWFOXaI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 19:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWFOXaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 19:30:07 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:37335 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750768AbWFOXaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 19:30:06 -0400
Message-ID: <4491ED7B.2000003@bigpond.net.au>
Date: Fri, 16 Jun 2006 09:30:03 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Sam Vilain <sam@vilain.net>, Kirill Korotaev <dev@openvz.org>,
       Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       sekharan@us.ibm.com, Balbir Singh <balbir@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] CPU controllers?
References: <20060615134632.GA22033@in.ibm.com>
In-Reply-To: <20060615134632.GA22033@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 15 Jun 2006 23:30:03 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> Hello,
> 	There have been several proposals so far on this subject and no
> consensus seems to have been reached on what an acceptable CPU controller
> for Linux needs to provide. I am hoping this mail will trigger some
> discussions in that regard. In particular I am keen to know what the
> various maintainers think about this subject.
> 
> The various approaches proposed so far are:
> 
> 	- CPU rate-cap (limit CPU execution rate per-task)
> 		http://lkml.org/lkml/2006/5/26/7	
> 
> 	- f-series CKRM controller (CPU usage guarantee for a task-group)
> 		http://lkml.org/lkml/2006/4/27/399
> 
> 	- e-series CKRM controller (CPU usage guarantee/limit for a task-group)
> 		http://prdownloads.sourceforge.net/ckrm/cpu.ckrm-e18.v10.patch.gz?download
> 
> 	- OpenVZ controller (CPU usage guarantee/hard-limit for a task-group)
> 		http://openvz.org/
> 
> 	- vserver controller (CPU usage guarantee(?)/limit for a task-group)
> 		http://linux-vserver.org/
> 
> (I apologize if I have missed any other significant proposal for Linux)
> 
> Their salient features and limitations/drawbacks, as I could gather, are 
> summarized later below. To note is each controller varies in degree of 
> complexity and addresses its own set of requirements. 
> 
> In going forward for an acceptable controller in mainline it would help, IMHO, 
> if we put together the set of requirements which the Linux CPU controller 
> should support. Some questions that arise in this regard are:
> 
> 	- Do we need mechanisms to control CPU usage of tasks, further to what
> 	  already exists (like nice)?  IMO yes.
> 
> 	- What are the requirements of such a CPU controller? Some of them to
> 	  consider are:
> 
> 		- Should it operate on a per-task basis or on a per-task-group
> 	  	  basis?
> 		- Should it support more than one level of task-groups?
> 		- If we want to allow on a per-task-group basis, which mechanism
> 		  do we use for grouping tasks (Resource Groups, PAGG,
> 		  uid/session id ..)?
> 		- Should it support limit and guarantee both? In case of limit,
> 		  should it support both soft and hard limit?
> 		- What interface do we choose for user to specify
> 		  limit/guarantee? system call or filesystem based (ex: /proc or
> 		  Resource Group's rcfs)?
> 		- Over what interval should guarantee/limit be monitored and
> 		  controlled?
> 		- With what accuracy should we allow the limit/guarantee to be
> 		  expressed?
> 		- Co-existence with CPUset - should guarantee/limit be 
> 		  enforced only on the set of CPUs attached to the cpuset?
> 		- Should real-time tasks be outside the purview of this control?
> 		- Load balance to be made aware of the guarantee/limit of tasks
> 		  (or task-groups)? Ofcourse yes!
> 
> One possibility is to add a basic controller, that addresses some minimal
> requirements, to begin with and progressively enhance it capabilities.

I would amend this to say "provide the basic controllers and let more 
complex management mechanisms use them (from outside the scheduler) to 
provide higher level control.  An essential part of this will be the 
provision of statistics for these external controllers to use.

> From this
> pov, both the f-series resource group controller and cpu rate-cap seem to be 
> good candidates for a minimal controller to begin with.
> 
> Thoughts?
> 
> Salient features of various CPU controllers that have been proposed so far are
> summarized below. I have not captured OpenVZ and Vserver controller aspects
> well. Request the maintainers to fill-in!
> 
> 1. CPU Rate Cap	(by Peter Williams)
> 
> Features:
> 
> 	* Limit CPU execution rate on a per-task basis.
> 	* Limit specified in terms of parts-per-thousand. Limit set thr' /proc
> 	  interface.

The /proc interface is not an essential part of this patch and the 
reason that it was implemented is that it was simple, easy and useful 
for testing.  The patch "proper" provides four functions for 
setting/getting the soft/hard caps an exports these so that they can be 
used from modules.

I.e. it would be very easy to replace the /proc interface with another 
one (or more) or to keep it and make another interface as well.  All the 
essential testing/processing required for setting the caps properly is 
inside the functions NOT the /proc interface.

> 	* Supports hard limit and soft limit
> 	* Introduces new task priorities where tasks that have exceeded their 
> 	  soft limit can be "parked" until the O(1) scheduler picks them for
>  	  execution
> 	* Load balancing on SMP systems made aware of tasks whose execution
> 	  rate is limited by this feature
> 	* Patch is simple
> 
> Limitations:
> 	* Does not support guarantee

Why would a capping mechanism support guarantees?  The two mechanisms 
can be implemented separately.  The only interaction between them that 
is required is a statement about which has precedence.  I.e. if a cap is 
less than a guarantee is it enforced?  I would opine that it should be.

BTW if "nice" works properly, guarantees can be implemented by suitable 
fiddling of task "nice" values.

> 
> Drawbacks:
> 	* Limiting CPU execution rate of a group of tasks has to be tackled from
> 	  an external module (user or kernel space) which may make this approach
> 	  somewhat inconvenient to implement for task-groups.

Nevertheless it can be done and it has the advantage that the cost is 
only borne by those who wish to use such high level controls.

The caps provided by this (simple) patch provide functionality that 
ordinary can find useful.  In particular, the use of a soft cap of zero 
to effectively put a task (and all of its children) in the background is 
very useful for doing software builds on a work station.  Con Kolivas's 
SCHED_IDLE scheduling class in his staircase scheduler provides the same 
functionality and is (from all reports) very popular.

The key difference between soft caps and the SCHED_IDLE mechanism is 
that it is more general in that limits other than zero can be specified. 
  This provides more flexibility.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
