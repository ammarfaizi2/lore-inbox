Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265986AbUGJXZC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265986AbUGJXZC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 19:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266049AbUGJXZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 19:25:01 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:7975 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S265986AbUGJXYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 19:24:55 -0400
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: Daniel Phillips <phillips@redhat.com>
Cc: Daniel Phillips <phillips@arcor.de>, David Teigland <teigland@redhat.com>,
       linux-kernel@vger.kernel.org, Lars Marowsky-Bree <lmb@suse.de>
In-Reply-To: <200407101657.06314.phillips@redhat.com>
References: <200407050209.29268.phillips@redhat.com>
	 <200407100058.28599.phillips@arcor.de>
	 <1089482358.19787.14.camel@persist.az.mvista.com>
	 <200407101657.06314.phillips@redhat.com>
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Message-Id: <1089501890.19787.33.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 10 Jul 2004 16:24:51 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

some comments inline


On Sat, 2004-07-10 at 13:57, Daniel Phillips wrote:
> On Saturday 10 July 2004 13:59, Steven Dake wrote:
> > > I'm not saying you're wrong, but I can think of an advantage you
> > > didn't mention: a service living in kernel will inherit the
> > > PF_MEMALLOC state of the process that called it, that is, a VM
> > > cache flushing task.  A userspace service will not.  A cluster
> > > block device in kernel may need to invoke some service in userspace
> > > at an inconvenient time.
> > >
> > > For example, suppose somebody spills coffee into a network node
> > > while another network node is in PF_MEMALLOC state, busily trying
> > > to write out dirty file data to it.  The kernel block device now
> > > needs to yell to the user space service to go get it a new network
> > > connection.  But the userspace service may need to allocate some
> > > memory to do that, and, whoops, the kernel won't give it any
> > > because it is in PF_MEMALLOC state.  Now what?
> >
> > overload conditions that have caused the kernel to run low on memory
> > are a difficult problem, even for kernel components.  Currently
> > openais includes "memory pools" which preallocate data structures. 
> > While that work is not yet complete, the intent is to ensure every
> > data area is preallocated so the openais executive (the thing that
> > does all of the work) doesn't ever request extra memory once it
> > becomes operational.
> >
> > This of course, leads to problems in the following system calls which
> > openais uses extensively:
> > sys_poll
> > sys_recvmsg
> > sys_sendmsg
> >
> > which require the allocations of memory with GFP_KERNEL, which can
> > then fail returning ENOMEM to userland.  The openais protocol
> > currently can handle low memory failures in recvmsg and sendmsg. 
> > This is because it uses a protocol designed to operate on lossy
> > networks.
> >
> > The poll system call problem will be rectified by utilizing
> > sys_epoll_wait which does not allocate any memory (the poll data is
> > preallocated).
> 
> But if the user space service is sitting in the kernel's dirty memory 
> writeout path, you have a real problem: the low memory condition may 
> never get resolved, rendering your userspace service autistic.  
> Meanwhile, whoever is generating the dirty memory just keeps spinning 
> and spinning, generating more of it, ensuring that if the system does 
> survive the first incident, there's another, worse traffic jam coming 
> down the pipe.  To trigger this deadlock, a kernel filesystem or block 
> device module just has to lose its cluster connection(s) at the wrong 
> time.
> 
> > I hope that helps atleast answer that some r&d is underway to solve
> > this particular overload problem in userspace.
> 
> I'm certain there's a solution, but until it is demonstrated and proved, 
> any userspace cluster services must be regarded with narrow squinty 
> eyes.
> 

I agree that a solution must be demonstrated and proved.

There is  another option, which I regularly recommend to anyone that
must deal with memory overload conditions.  Don't size the applications
in such a way as to ever cause memory overload.  This practical approach
requires just a little more thought on application deployment with the
benefit of avoiding the various and many problems with memory overload
that leads to application faults, OS faults, and other sorts of nasty
conditions.

> > > Though I admit I haven't read through the whole code tree, there
> > > doesn't seem to be a distributed lock manager there.  Maybe that is
> > > because it's so tightly coded I missed it?
> >
> > There is as of yet no implementation of the SAF AIS dlock API in
> > openais.  The work requires about 4 weeks of development for someone
> > well-skilled.  I'd expect a contribution for this API in the
> > timeframes that make GFS interesting.
> 
> I suspect you have underestimated the amount of development time 
> required.
> 

The checkpointing api took approx 3 weeks to develop and has many more
functions to implement.  Cluster membership took approx 1 week to
develop.  The AMF which provides application failover, the most
complicated of the APIs, took approx 8 weeks to develop.  The group
messaging protocol (which implements the virtual synchrony model) has
consumed 80% of the development time thus far.

So 4 weeks is reasonable for someone not familiar with the openais
architecture or SA Forum specification, since the virtual synchrony
group messaging protocol is complete enough to implement a lock service
with simple messaging without any race conditions even during network
partitions and merges.

> > I'd invite you, or others interested in these sorts of services, to
> > contribute that code, if interested.
> 
> Humble suggestion: try grabbing the Red Hat (Sistina) DLM code and see 
> if you can hack it to do what you want.  Just write a kernel module 
> that exports the DLM interface to userspace in the desired form.
> 
>    http://sources.redhat.com/cluster/dlm/
> 

I would rather avoid non-mainline kernel dependencies at this time as it
makes adoption difficult until kernel patches are merged into upstream
code.  Who wants to patch their kernel to try out some APIs?  I am
doubtful these sort of kernel patches will be merged without a strong
argument of why it absolutely must be implemented in the kernel vs all
of the counter arguments against a kernel implementation.  

There is one more advantage to group messaging and distributed locking
implemented within the kernel, that I hadn't originally considered; it
sure is sexy.

Regards
-steve

> Regards,
> 
> Daniel

