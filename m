Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266425AbUGJUtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266425AbUGJUtw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 16:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266431AbUGJUtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 16:49:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56796 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266425AbUGJUts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 16:49:48 -0400
From: Daniel Phillips <phillips@redhat.com>
Organization: Red Hat
To: sdake@mvista.com
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Date: Sat, 10 Jul 2004 16:57:06 -0400
User-Agent: KMail/1.6.2
Cc: Daniel Phillips <phillips@arcor.de>, David Teigland <teigland@redhat.com>,
       linux-kernel@vger.kernel.org, Lars Marowsky-Bree <lmb@suse.de>
References: <200407050209.29268.phillips@redhat.com> <200407100058.28599.phillips@arcor.de> <1089482358.19787.14.camel@persist.az.mvista.com>
In-Reply-To: <1089482358.19787.14.camel@persist.az.mvista.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407101657.06314.phillips@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 July 2004 13:59, Steven Dake wrote:
> > I'm not saying you're wrong, but I can think of an advantage you
> > didn't mention: a service living in kernel will inherit the
> > PF_MEMALLOC state of the process that called it, that is, a VM
> > cache flushing task.  A userspace service will not.  A cluster
> > block device in kernel may need to invoke some service in userspace
> > at an inconvenient time.
> >
> > For example, suppose somebody spills coffee into a network node
> > while another network node is in PF_MEMALLOC state, busily trying
> > to write out dirty file data to it.  The kernel block device now
> > needs to yell to the user space service to go get it a new network
> > connection.  But the userspace service may need to allocate some
> > memory to do that, and, whoops, the kernel won't give it any
> > because it is in PF_MEMALLOC state.  Now what?
>
> overload conditions that have caused the kernel to run low on memory
> are a difficult problem, even for kernel components.  Currently
> openais includes "memory pools" which preallocate data structures. 
> While that work is not yet complete, the intent is to ensure every
> data area is preallocated so the openais executive (the thing that
> does all of the work) doesn't ever request extra memory once it
> becomes operational.
>
> This of course, leads to problems in the following system calls which
> openais uses extensively:
> sys_poll
> sys_recvmsg
> sys_sendmsg
>
> which require the allocations of memory with GFP_KERNEL, which can
> then fail returning ENOMEM to userland.  The openais protocol
> currently can handle low memory failures in recvmsg and sendmsg. 
> This is because it uses a protocol designed to operate on lossy
> networks.
>
> The poll system call problem will be rectified by utilizing
> sys_epoll_wait which does not allocate any memory (the poll data is
> preallocated).

But if the user space service is sitting in the kernel's dirty memory 
writeout path, you have a real problem: the low memory condition may 
never get resolved, rendering your userspace service autistic.  
Meanwhile, whoever is generating the dirty memory just keeps spinning 
and spinning, generating more of it, ensuring that if the system does 
survive the first incident, there's another, worse traffic jam coming 
down the pipe.  To trigger this deadlock, a kernel filesystem or block 
device module just has to lose its cluster connection(s) at the wrong 
time.

> I hope that helps atleast answer that some r&d is underway to solve
> this particular overload problem in userspace.

I'm certain there's a solution, but until it is demonstrated and proved, 
any userspace cluster services must be regarded with narrow squinty 
eyes.

> > Though I admit I haven't read through the whole code tree, there
> > doesn't seem to be a distributed lock manager there.  Maybe that is
> > because it's so tightly coded I missed it?
>
> There is as of yet no implementation of the SAF AIS dlock API in
> openais.  The work requires about 4 weeks of development for someone
> well-skilled.  I'd expect a contribution for this API in the
> timeframes that make GFS interesting.

I suspect you have underestimated the amount of development time 
required.

> I'd invite you, or others interested in these sorts of services, to
> contribute that code, if interested.

Humble suggestion: try grabbing the Red Hat (Sistina) DLM code and see 
if you can hack it to do what you want.  Just write a kernel module 
that exports the DLM interface to userspace in the desired form.

   http://sources.redhat.com/cluster/dlm/

Regards,

Daniel
