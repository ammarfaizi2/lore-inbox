Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266324AbUGJR7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266324AbUGJR7b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 13:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266327AbUGJR7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 13:59:31 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:9764 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S266324AbUGJR7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 13:59:24 -0400
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: Daniel Phillips <phillips@arcor.de>
Cc: Daniel Phillips <phillips@redhat.com>,
       David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org,
       Lars Marowsky-Bree <lmb@suse.de>
In-Reply-To: <200407100058.28599.phillips@arcor.de>
References: <200407050209.29268.phillips@redhat.com>
	 <200407081422.19566.phillips@redhat.com>
	 <1089315680.3371.26.camel@persist.az.mvista.com>
	 <200407100058.28599.phillips@arcor.de>
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Message-Id: <1089482358.19787.14.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 10 Jul 2004 10:59:18 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comments inline thanks
-steve

On Fri, 2004-07-09 at 21:58, Daniel Phillips wrote:
> Hi Steven,
> 
> On Thursday 08 July 2004 15:41, Steven Dake wrote:
> > On Thu, 2004-07-08 at 11:22, Daniel Phillips wrote:
> > > While we're in here, could you please explain why CMAN needs to be
> > > kernel-based?  (Just thought I'd broach the question before Christoph
> > > does.)
> >
> > Daniel,
> >
> > I have that same question as well.  I can think of several
> > disadvantages:
> >
> > 1) security faults in the protocol can crash the kernel or violate
> >     system security
> > 2) secure group communication is difficult to implement in kernel
> >     - secure group key protocols can be implemented fairly easily in
> >        userspace using packages like openssl.  Implementing these
> >        protocols in kernel will prove to be very complex.
> > 3) live upgrades are much more difficult with kernel components
> > 4) a standard interface (the SA Forum AIS) is not being used,
> >     disallowing replaceability of components.  This is a big deal for
> >     people interested in clustering that dont want to be locked into
> >     a partciular implementation.
> > 5) dlm, fencing, cluster messaging (including membership) can be done
> >     in userspace, so why not do it there.
> > 6) cluster services for the kernel and cluster services for applications
> >     will fork, because SA Forum AIS will be chosen for application
> >    level services.
> > 7) faults in the protocols can bring down all of Linux, instead of one
> >     cluster service on one node.
> > 8) kernel changes require much longer to get into the field and are
> >    much more difficult to distribute.  userspace applications are much
> >    simpler to unit test, qualify, and release.
> >
> > The advantages are:
> > interrupt driven timers
> > some possible reduction in latency related to the cost of executing a
> > system call when sending messages (including lock messages)
> 
> I'm not saying you're wrong, but I can think of an advantage you didn't 
> mention: a service living in kernel will inherit the PF_MEMALLOC state of the 
> process that called it, that is, a VM cache flushing task.  A userspace 
> service will not.  A cluster block device in kernel may need to invoke some 
> service in userspace at an inconvenient time.
> 
> For example, suppose somebody spills coffee into a network node while another 
> network node is in PF_MEMALLOC state, busily trying to write out dirty file 
> data to it.  The kernel block device now needs to yell to the user space 
> service to go get it a new network connection.  But the userspace service may 
> need to allocate some memory to do that, and, whoops, the kernel won't give 
> it any because it is in PF_MEMALLOC state.  Now what?
> 

overload conditions that have caused the kernel to run low on memory are
a difficult problem, even for kernel components.  Currently openais
includes "memory pools" which preallocate data structures.  While that
work is not yet complete, the intent is to ensure every data area is
preallocated so the openais executive (the thing that does all of the
work) doesn't ever request extra memory once it becomes operational.

This of course, leads to problems in the following system calls which
openais uses extensively:
sys_poll
sys_recvmsg
sys_sendmsg

which require the allocations of memory with GFP_KERNEL, which can then
fail returning ENOMEM to userland.  The openais protocol currently can
handle low memory failures in recvmsg and sendmsg.  This is because it
uses a protocol designed to operate on lossy networks.

The poll system call problem will be rectified by utilizing
sys_epoll_wait which does not allocate any memory (the poll data is
preallocated).

I hope that helps atleast answer that some r&d is underway to solve this
particular overload problem in userspace.

> > One of these projects, the openais project which I maintain, implements
> > 3 of these services (and the rest will be done in the timeframes we are
> > talking about) in user space without any kernel changes required.  It
> > would be possible with kernel to userland communication for the cluster
> > applications (GFS, distributed block device, etc) to use this standard
> > interface and implementation.  Then we could avoid all of the
> > unnecessary kernel maintenance and potential problems that come along
> > with it.
> >
> > Are you interested in such an approach?
> 
> We'd be remiss not to be aware of it, and its advantages.  It seems your 
> project is still in early stages.  How about we take pains to ensure that 
> your cluster membership service is plugable into the CMAN infrastructure, as 
> a starting point.
> 
sounds good

> Though I admit I haven't read through the whole code tree, there doesn't seem 
> to be a distributed lock manager there.  Maybe that is because it's so 
> tightly coded I missed it?
> 

There is as of yet no implementation of the SAF AIS dlock API in
openais.  The work requires about 4 weeks of development for someone
well-skilled.  I'd expect a contribution for this API in the timeframes
that make GFS interesting.

I'd invite you, or others interested in these sorts of services, to
contribute that code, if interested.  If interested in developing such a
service for openais, check out the developer's map (which describes
developing a service for openais) at:

http://developer.osdl.org/dev/openais/src/README.devmap

Thanks!
-steve

> Regards,
> 
> Daniel

