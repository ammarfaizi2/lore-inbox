Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266139AbUGJEvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266139AbUGJEvm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 00:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266137AbUGJEvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 00:51:33 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:13705 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S266136AbUGJEvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 00:51:12 -0400
From: Daniel Phillips <phillips@arcor.de>
To: sdake@mvista.com
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Date: Sat, 10 Jul 2004 00:58:28 -0400
User-Agent: KMail/1.6.2
Cc: Daniel Phillips <phillips@redhat.com>,
       David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org,
       Lars Marowsky-Bree <lmb@suse.de>
References: <200407050209.29268.phillips@redhat.com> <200407081422.19566.phillips@redhat.com> <1089315680.3371.26.camel@persist.az.mvista.com>
In-Reply-To: <1089315680.3371.26.camel@persist.az.mvista.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407100058.28599.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Thursday 08 July 2004 15:41, Steven Dake wrote:
> On Thu, 2004-07-08 at 11:22, Daniel Phillips wrote:
> > While we're in here, could you please explain why CMAN needs to be
> > kernel-based?  (Just thought I'd broach the question before Christoph
> > does.)
>
> Daniel,
>
> I have that same question as well.  I can think of several
> disadvantages:
>
> 1) security faults in the protocol can crash the kernel or violate
>     system security
> 2) secure group communication is difficult to implement in kernel
>     - secure group key protocols can be implemented fairly easily in
>        userspace using packages like openssl.  Implementing these
>        protocols in kernel will prove to be very complex.
> 3) live upgrades are much more difficult with kernel components
> 4) a standard interface (the SA Forum AIS) is not being used,
>     disallowing replaceability of components.  This is a big deal for
>     people interested in clustering that dont want to be locked into
>     a partciular implementation.
> 5) dlm, fencing, cluster messaging (including membership) can be done
>     in userspace, so why not do it there.
> 6) cluster services for the kernel and cluster services for applications
>     will fork, because SA Forum AIS will be chosen for application
>    level services.
> 7) faults in the protocols can bring down all of Linux, instead of one
>     cluster service on one node.
> 8) kernel changes require much longer to get into the field and are
>    much more difficult to distribute.  userspace applications are much
>    simpler to unit test, qualify, and release.
>
> The advantages are:
> interrupt driven timers
> some possible reduction in latency related to the cost of executing a
> system call when sending messages (including lock messages)

I'm not saying you're wrong, but I can think of an advantage you didn't 
mention: a service living in kernel will inherit the PF_MEMALLOC state of the 
process that called it, that is, a VM cache flushing task.  A userspace 
service will not.  A cluster block device in kernel may need to invoke some 
service in userspace at an inconvenient time.

For example, suppose somebody spills coffee into a network node while another 
network node is in PF_MEMALLOC state, busily trying to write out dirty file 
data to it.  The kernel block device now needs to yell to the user space 
service to go get it a new network connection.  But the userspace service may 
need to allocate some memory to do that, and, whoops, the kernel won't give 
it any because it is in PF_MEMALLOC state.  Now what?

> One of these projects, the openais project which I maintain, implements
> 3 of these services (and the rest will be done in the timeframes we are
> talking about) in user space without any kernel changes required.  It
> would be possible with kernel to userland communication for the cluster
> applications (GFS, distributed block device, etc) to use this standard
> interface and implementation.  Then we could avoid all of the
> unnecessary kernel maintenance and potential problems that come along
> with it.
>
> Are you interested in such an approach?

We'd be remiss not to be aware of it, and its advantages.  It seems your 
project is still in early stages.  How about we take pains to ensure that 
your cluster membership service is plugable into the CMAN infrastructure, as 
a starting point.

Though I admit I haven't read through the whole code tree, there doesn't seem 
to be a distributed lock manager there.  Maybe that is because it's so 
tightly coded I missed it?

Regards,

Daniel
