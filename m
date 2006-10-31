Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161638AbWJaLtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161638AbWJaLtd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 06:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161640AbWJaLtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 06:49:33 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:61576 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161638AbWJaLtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 06:49:32 -0500
Date: Tue, 31 Oct 2006 17:23:43 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: "Paul Menage" <menage@google.com>
Cc: "Paul Jackson" <pj@sgi.com>, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-ID: <20061031115342.GB9588@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061030103356.GA16833@in.ibm.com> <6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com> <20061030031531.8c671815.pj@sgi.com> <6599ad830610300404v1e036bb7o7ed9ec0bc341864e@mail.gmail.com> <20061030042714.fa064218.pj@sgi.com> <6599ad830610300953o7cbf5a6cs95000e11369de427@mail.gmail.com> <20061030123652.d1574176.pj@sgi.com> <6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 12:47:59PM -0800, Paul Menage wrote:
> On 10/30/06, Paul Jackson <pj@sgi.com> wrote:
> >
> >In other words you are recommending delivering a system that internally
> >tracks separate hierarchies for each resource control entity, but where
> >the user can conveniently overlap some of these hierarchies and deal
> >with them as a single hierarchy.
> 
> More or less. More concretely:
> 
> - there is a single hierarchy of process containers
> - each process is a member of exactly one process container
> 
> - for each resource controller, there's a hierarchy of resource "nodes"
> - each process container is associated with exactly one resource node
> of each type
> 
> - by default, the process container hierarchy and the resource node
> hierarchies are isomorphic, but that can be controlled by userspace.

For the case where resource node hierarchy is different from process
container hierarchy, I am trying to make sense of "why do we need to
maintain two hierarchies" - one the actual hierarchy used for resource
control purpose, another the process container hierarchy. What purpose 
does maintaining the process container hierarchy (in addition to the
resource controller hierarchy) solve?

I am thinking we can avoid maintaining these two hierarchies, by 
something on these lines:

	mkdir /dev/cpu
	mount -t container -ocpu container /dev/cpu

		-> Represents a hierarchy for cpu control purpose.

		   tsk->cpurc	= represent the node in the cpu
				  controller hierarchy. Also maintains 
				  resource allocation information for
				  this node.

		   tsk->cpurc->parent = parent node.

	mkdir /dev/mem
	mount -t container -omem container /dev/mem

		-> Represents a hierarchy for mem control purpose.

		   tsk->memrc	= represent the node in the mem
				  controller hierarchy. Also maintains 
				  resource allocation information for
				  this node.

		   tsk->memrc->parent = parent node.


	mkdir /dev/containers
	mount -t container -ocontainer container /dev/container

		-> Represents a (mostly flat?) hierarchy for the real 
	  	   container (virtualization) purpose.

		   tsk->container = represent the node in the container
				    hierarchy. Also maintains relavant 
				    container information for this node.

		   tsk->container->parent = parent node.


I suspect this may simplify the "container" filesystem, since it doesnt
have to track multiple hierarchies at the same time, and improve lock
contention too (modifying the cpu controller hierarchy can take a different 
lock than the mem controller hierarchy).

-- 
Regards,
vatsa
