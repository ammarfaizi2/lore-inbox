Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbUGHTlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUGHTlr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 15:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUGHTlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 15:41:46 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:38625 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S262391AbUGHTlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 15:41:25 -0400
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: Daniel Phillips <phillips@redhat.com>
Cc: David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org,
       Lars Marowsky-Bree <lmb@suse.de>
In-Reply-To: <200407081422.19566.phillips@redhat.com>
References: <200407050209.29268.phillips@redhat.com>
	 <20040708091043.GS12255@marowsky-bree.de>
	 <20040708105338.GA16115@redhat.com>
	 <200407081422.19566.phillips@redhat.com>
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Message-Id: <1089315680.3371.26.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 08 Jul 2004 12:41:21 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-08 at 11:22, Daniel Phillips wrote:
> Hi Dave,
> 
> On Thursday 08 July 2004 06:53, David Teigland wrote:
> > We have a symmetric, kernel-based, stand-alone cluster manager (CMAN)
> > that has no ties to anything else whatsoever.  It'll simply run and
> > answer the question "who's in the cluster?" by providing a list of
> > names/nodeids.
> 
> While we're in here, could you please explain why CMAN needs to be 
> kernel-based?  (Just thought I'd broach the question before Christoph 
> does.)
> 
> Regards,
> 
> Daniel

Daniel,

I have that same question as well.  I can think of several
disadvantages:

1) security faults in the protocol can crash the kernel or violate 
    system security
2) secure group communication is difficult to implement in kernel
    - secure group key protocols can be implemented fairly easily in 
       userspace using packages like openssl.  Implementing these
       protocols in kernel will prove to be very complex.
3) live upgrades are much more difficult with kernel components
4) a standard interface (the SA Forum AIS) is not being used, 
    disallowing replaceability of components.  This is a big deal for
    people interested in clustering that dont want to be locked into
    a partciular implementation.
5) dlm, fencing, cluster messaging (including membership) can be done
    in userspace, so why not do it there.
6) cluster services for the kernel and cluster services for applications
    will fork, because SA Forum AIS will be chosen for application 
   level services.
7) faults in the protocols can bring down all of Linux, instead of one 
    cluster service on one node.
8) kernel changes require much longer to get into the field and are 
   much more difficult to distribute.  userspace applications are much
   simpler to unit test, qualify, and release.

The advantages are:
interrupt driven timers
some possible reduction in latency related to the cost of executing a
system call when sending messages (including lock messages)

I would like to share with you the efforts of the industry standards
body Service Availability Forum (www.saforum.org).  The Forum is
intersted in specifying interfaces for improving availability of a
system.  One of the collections of APIs (called the application
interface specification) utilizes redundant software components using
clustering approaches to improve availability.

The AIS specification specifies APIs for cluster membership, application
failover, checkpointing, eventing, messaging, and distributed locks. 
All of these services are designed to work with multiple nodes.

It would be beneficial to everyone to adopt these standard interfaces. 
Alot of thought has gone into them.  They are pretty solid.  And there
are atleast two open source implementations under way (openais and
linux-ha) and more on the horizon.

One of these projects, the openais project which I maintain, implements
3 of these services (and the rest will be done in the timeframes we are
talking about) in user space without any kernel changes required.  It
would be possible with kernel to userland communication for the cluster
applications (GFS, distributed block device, etc) to use this standard
interface and implementation.  Then we could avoid all of the
unnecessary kernel maintenance and potential problems that come along
with it. 

Are you interested in such an approach?

Thanks
-steve


> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

