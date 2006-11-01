Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752397AbWKAVGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752397AbWKAVGe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 16:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752410AbWKAVGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 16:06:34 -0500
Received: from mx4.cs.washington.edu ([128.208.4.190]:38889 "EHLO
	mx4.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1752395AbWKAVGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 16:06:33 -0500
Date: Wed, 1 Nov 2006 13:05:52 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
cc: Paul Menage <menage@google.com>, Paul Jackson <pj@sgi.com>, dev@openvz.org,
       sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
In-Reply-To: <20061101155937.GA2928@in.ibm.com>
Message-ID: <Pine.LNX.4.64N.0611011249440.30874@attu4.cs.washington.edu>
References: <20061030103356.GA16833@in.ibm.com>
 <6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com>
 <20061030031531.8c671815.pj@sgi.com> <6599ad830610300404v1e036bb7o7ed9ec0bc341864e@mail.gmail.com>
 <20061030042714.fa064218.pj@sgi.com> <6599ad830610300953o7cbf5a6cs95000e11369de427@mail.gmail.com>
 <20061030123652.d1574176.pj@sgi.com> <6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com>
 <Pine.LNX.4.64N.0610311951280.7538@attu4.cs.washington.edu>
 <20061101155937.GA2928@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2006, Srivatsa Vaddagiri wrote:

> This would forces all tasks in container A to belong to the same mem/io ctlr 
> groups. What if that is not desired? How would we achieve something like
> this:
> 
> 	tasks (m) should belong to mem ctlr group D,
> 	tasks (n, o) should belong to mem ctlr group E
>   	tasks (m, n, o) should belong to i/o ctlr group G
> 

With the example you would need to place task m in one container called 
A_m and tasks n and o in another container called A_n,o.  Then join A_m to 
D, A_n,o to E, and both to G.

I agree that this doesn't appear to be very easy to setup by the sysadmin 
or any automated means.  But in terms of the kernel, each of these tasks 
would have a pointer back to its container and that container would point 
to its assigned resource controller.  So it's still a double dereference 
to access the controller from any task_struct.

So if we proposed a hierarchy of containers, we could have the following:

			----------A----------
			|         |         |
		   -----B-----	  m    -----C------
		   |         |         |
		   n    -----D-----    o
			|	  |
			p         q

So instead we make the requirement that only one container can be attached 
to any given controller.  So if container A is attached to a disk I/O 
controller, for example, then it includes all processes.  If D is attached 
to it instead, only p and q are affected by its constraints.

This would be possible by adding a field to the struct container that 
would point to its parent cpu, net, mem, etc. container or NULL if it is 
itself.

The difference:

	Single-level container hierarchy

		struct task_struct {
			...
			struct container *my_container;
		}
		struct container {
			...
			struct controller *my_cpu_controller;
			struct controller *my_mem_controller;
		}

	Multi-level container hierarchy

		struct task_struct {
			...
			struct container *my_container;
		}
		struct container {
			...
			/* Root containers, NULL if itself */
			struct container *my_cpu_root_container;
			struct container *my_mem_root_container;
			/* Controllers, NULL if has parent */
			struct controller *my_cpu_controller;
			struct controller *my_mem_controller;
		}

This eliminates the need to put a pointer to each resource controller 
within each task_struct.

> (this example breaks the required condition/assumption that a task belong to 
> exactly only one process container).
> 

Yes, and that was the requirement that the above example was based upon.

		David
