Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946021AbWKAEjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946021AbWKAEjm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 23:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946060AbWKAEjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 23:39:42 -0500
Received: from mx3.cs.washington.edu ([128.208.3.132]:50109 "EHLO
	mx3.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1946021AbWKAEjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 23:39:41 -0500
Date: Tue, 31 Oct 2006 20:39:27 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Paul Menage <menage@google.com>
cc: Paul Jackson <pj@sgi.com>, dev@openvz.org, vatsa@in.ibm.com,
       sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
In-Reply-To: <6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com>
Message-ID: <Pine.LNX.4.64N.0610311951280.7538@attu4.cs.washington.edu>
References: <20061030103356.GA16833@in.ibm.com> 
 <6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com> 
 <20061030031531.8c671815.pj@sgi.com>  <6599ad830610300404v1e036bb7o7ed9ec0bc341864e@mail.gmail.com>
  <20061030042714.fa064218.pj@sgi.com>  <6599ad830610300953o7cbf5a6cs95000e11369de427@mail.gmail.com>
  <20061030123652.d1574176.pj@sgi.com> <6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2006, Paul Menage wrote:

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
> 

This approach appears to be the most complete and extensible 
implementation of containers for all practical uses.  Not only can you use 
these process containers in conjunction with your choice of memory 
controllers, network controllers, disk I/O controllers, etc, but you can 
also pick and choose your own modular controller of choice to meet your 
needs.

So here's our three process containers, A, B, and C, with our tasks m-t:

	-----A-----	-----B-----	-----C-----
	|    |    |     |    |    |     |    |
	m    n    o	p    q    r	s    t

Here's our memory controller groups D and E and our containers set within 
them:

	-----D-----	-----E-----
	|         |	|
	A         B	C

 [ My memory controller E is for my real-time processes so I set its
   attributes appropriately so that it never breaks. ]

And our network controller groups F, G, and H:

	-----F-----	-----G-----
			|         |
		   -----H-----    C
		   |         |
		   A	     B

 [ I'm going to leave my network controller F open for my customer's
   WWW browsing, but nobody is using it right now. ]

I choose not to control disk I/O so there is change from current behavior 
for any of the processes listed above.

There's two things I notice about this approach (my use of the word 
"container" refers to the process containers A, B, and C; my use of the 
word "controller" refers to memory, disk I/O, network, etc controllers):

 - While the process containers are only single-level, the controllers are
   _inherently_ hierarchial just like a filesystem.  So it appears that
   the manipulation of these controllers would most effectively be done
   from userspace with a filesystem approach.  While it may not be served
   by forcing CONFIG_CONFIGFS_FS to be enabled, I observe no objection to
   giving it its own filesystem capability, apart from configfs, through 
   the kernel.  The filesystem manipulation tools that everybody is
   familiar with makes the implementation of controllers simple and, more
   importantly, easier to _use_.

 - The process containers will need to be setup as desired following
   boot.  So if the current approach of cpusets is used, where the
   functionality is enabled on mount, all processes will originally belong
   to the default container that encompasses the entire system.  Since
   each process must belong to only one process container as per Paul
   Menage's proposal, a new container will need to be created and
   processes _moved_ to it for later use by controllers.  So it appears
   that the manipulation of containers would most effectively be done from
   userspace by a syscall approach.

In this scenario, it is not necessary for network controller groups F and 
G above to be limited (or guaranteed) to 100% of our network load.  It is 
quite possible that we do not assign every container to a network 
controller so that they receive the remainder of the bandwidth that is not 
already attributed to F and G.  The same is true with any controller.  Our 
controllers should only seek the limit or guarantee certain amount of 
resources, not force each system process to be a member of one group or 
another to receive the resources.

Two questions also arise:

 - Why do I need to create (i.e. mount the filesystem) the container in
   the first place?  Since the use of these containers are entirely on the 
   shoulders of the optional controllers, there should be no interference 
   with current behavior if I choose not to use any controller.  So why 
   not take the approach that NUMA did whereas if we're on an UMA machine, 
   all of memory belongs to a node 0?  In our case, all processes will 
   inherently belong to a system-wide container similar to procfs.  In
   fact, procfs is how this can be implemented apart from configfs
   following the criticism from UBC.

 - How is forking handled with the various controllers?  Do child 
   processes automatically inherit all the controller groups of its
   parent?  If not (or if its dependant on a user-configured attribute
   of the controller), what happens when I want forked processes to
   belong to a new network controller group from container A in the
   illustration above?  Certaintly that new controller cannot be
   created as a sibling of F and G; and determining the limit on
   network for a third child of H would be non-trivial because then
   the network resources allocated to A and B would be scaled back
   prehaps in an undesired manner.

So the container abstraction looks appropriate for a syscall interface 
whereas a controller abstraction looks appropriate for a filesystem 
interface.  If Paul Menage's proposal of above is adopted, it seems like 
the design and implementation of containers is the first milestone; how 
far does the current patchset get us to what is described above?  Does it 
still support a hierarchy just like cpusets?

And following that, it seems like the next milestone would be to design 
the different characteristics that the various modular controllers could 
support such as notify_on_release, limits/guarantees, behavior on fork, 
and privileges.

		David
