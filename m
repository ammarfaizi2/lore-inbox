Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266136AbUGJE6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbUGJE6P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 00:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266138AbUGJE6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 00:58:15 -0400
Received: from cm217.omega59.maxonline.com.sg ([218.186.59.217]:47745 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266136AbUGJE6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 00:58:12 -0400
Date: Sat, 10 Jul 2004 12:58:24 +0800
From: David Teigland <teigland@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Steven Dake <sdake@mvista.com>, Daniel Phillips <phillips@redhat.com>,
       Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Message-ID: <20040710045824.GA14242@redhat.com>
References: <200407050209.29268.phillips@redhat.com> <20040708091043.GS12255@marowsky-bree.de> <20040708105338.GA16115@redhat.com> <200407081422.19566.phillips@redhat.com> <1089315680.3371.26.camel@persist.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089315680.3371.26.camel@persist.az.mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Jul 08, 2004 at 12:41:21PM -0700, Steven Dake wrote:
> On Thu, 2004-07-08 at 11:22, Daniel Phillips wrote:
> > Hi Dave,
> > 
> > On Thursday 08 July 2004 06:53, David Teigland wrote:
> > > We have a symmetric, kernel-based, stand-alone cluster manager (CMAN)
> > > that has no ties to anything else whatsoever.  It'll simply run and
> > > answer the question "who's in the cluster?" by providing a list of
> > > names/nodeids.
> > 
> > While we're in here, could you please explain why CMAN needs to be 
> > kernel-based?  (Just thought I'd broach the question before Christoph 
> > does.)
> 
> I have that same question as well.  

gfs needs to run in the kernel.  dlm should run in the kernel since gfs uses it
so heavily.  cman is the clustering subsystem on top of which both of those are
built and on which both depend quite critically.  It simply makes most sense to
put cman in the kernel for what we're doing with it.  That's not a dogmatic
position, just a practical one based on our experience.


> I can think of several disadvantages:
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

This view of advantages/disadvantages seems sensible when working with your
average userland clustering application.  The SAF spec looks pretty nice in
that context.  I think gfs and a kernel-based dlm for gfs are a different
story, though.  They're different enough from other things that few of the same
considerations seem practical.  This has been our experience so far, things
could possibly change for some next-generation (think time span of years).

You'll note that gfs uses external, interchangable locking/cluster systems
which makes it easy to look at alternatives.  cman and dlm are what gfs/clvm
use today; if they prove useful to others that's great, we'd even be happy to
help make them more useful.

-- 
Dave Teigland  <teigland@redhat.com>
