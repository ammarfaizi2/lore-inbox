Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263893AbUGHKxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUGHKxW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 06:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbUGHKxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 06:53:22 -0400
Received: from cm217.omega59.maxonline.com.sg ([218.186.59.217]:40836 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263893AbUGHKxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 06:53:19 -0400
Date: Thu, 8 Jul 2004 18:53:38 +0800
From: David Teigland <teigland@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Daniel Phillips <phillips@redhat.com>, Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Message-ID: <20040708105338.GA16115@redhat.com>
References: <200407050209.29268.phillips@redhat.com> <200407061734.51023.phillips@redhat.com> <20040707181650.GD12255@marowsky-bree.de> <200407072114.07291.phillips@redhat.com> <20040708091043.GS12255@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708091043.GS12255@marowsky-bree.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 11:10:43AM +0200, Lars Marowsky-Bree wrote:

> Of all the cluster-subsystems, the fencing system is likely the most
> important. If the various implementations don't step on eachothers toes
> there, the duplication of membership/messaging/etc is only inefficient,
> but not actively harmful.

I'm afraid the fencing issue has been rather misrepresented.  Here's what we're
doing (a lot of background is necessary I'm afraid.)  We have a symmetric,
kernel-based, stand-alone cluster manager (CMAN) that has no ties to anything
else whatsoever.  It'll simply run and answer the question "who's in the
cluster?" by providing a list of names/nodeids.

So, if that's all you want you can just run cman on all your nodes and it'll
tell you who's in the cluster (kernel and userland api's).  CMAN will also do
generic callbacks to tell you when the membership has changed.  Some people can
stop reading here.

In the event of network partitions you can obviously have two cman clusters
form independently (i.e. "split-brain").  Some people care about this.  Quorum
is a trivial true/false property of the cluster.  Every cluster member has a
number of votes and the cluster itself has a number of expected votes.  Using
these simple values, cman does a quick computation to tell you if the cluster
has quorum.  It's a very standard way of doing things -- we modelled it
directly off the VMS-cluster style.  Whether you care about this quorum value
or what you do with it are beside the point.  Some may be interested in
discussing how cman works and participating in further development; if so go
ahead and ask on linux-cluster@redhat.com.  We've been developing and using
cman for 3-4 years.  Are there other valid approaches? of course.  Is cman
suitable for many people? yes.  Suitable for everyone? no.

(see http://sources.redhat.com/cluster/ for patches and mailing list)

What about the DLM?  The DLM we've developed is again modelled exactly after
that in VMS-clusters.  It depends on cman for the necessary clustering input.
Note that it uses the same generic cman api's as any other system.  Again, the
DLM is utterly symmetric; there is no server or master node involved.  Is this
DLM suitable for many people? yes.  For everyone? no.  (Right now gfs and clvm
are the primary dlm users simply because those are the other projects our group
works on.  DLM is in no way specific to either of those.) 

What about Fencing?  Fencing is not a part of the cluster manager, not a part
of the dlm and not a part of gfs.  It's an entirely independent system that
runs on its own in userland.  It depends on cman for cluster information just
like the dlm or gfs does.  I'll repeat what I said on the linux-cluster mailing
list:

--
Fencing is a service that runs on its own in a CMAN cluster; it's entirely
independent from other services.  GFS simply checks to verify fencing is
running before allowing a mount since it's especially dangerous for a mount to
succeed without it.

As soon as a node joins a fencing domain it will be fenced by another domain
member if it fails.  i.e. as soon as a node runs:

> cman_tool join    (joins the cluster)
> fence_tool join   (starts fenced which joins the default fence domain)

it will be fenced by another fence domain member if it fails.  So, you simply
need to configure your nodes to run fence_tool join after joining the cluster
if you want fencing to happen.  You can add any checks later on that you think
are necessary to be sure that the node is in the fence domain.

Running fence_tool leave will remove a node cleanly from the fence domain (it
won't be fenced by other members.)
--

This fencing system is suitable for us in our gfs/clvm work.  It's probably
suitable for others, too.  For everyone? no.  Can be improved with further
development? yes.  A central or difficult issue? not really.  Again, no need to
look at the dlm or gfs or clvm to work with this fencing system.

-- 
Dave Teigland  <teigland@redhat.com>
