Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266025AbUGJQ0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266025AbUGJQ0z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 12:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbUGJQ0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 12:26:55 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:5010 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266025AbUGJQ0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 12:26:52 -0400
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
From: James Bottomley <James.Bottomley@SteelEye.com>
To: David Teigland <teigland@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040710160409.GA19471@redhat.com>
References: <1089471483.1750.31.camel@mulgrave> 
	<20040710160409.GA19471@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 10 Jul 2004 11:26:44 -0500
Message-Id: <1089476805.1750.54.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-10 at 11:04, David Teigland wrote:
> The "it" refers to gfs.  This means gfs doesn't make a lot of sense and isn't
> very practical without it.  I'm not the one to speculate on what gfs would
> become otherwise, others would do that better.

This is what you actually said:

> It simply makes most sense to put cman in the kernel for
> what we're doing with it.

I interpret that to mean you think cman (your cluster manager) should be
in the kernel.  Is this incorrect?

> 
> > You also face two other additional hurdles:
> > 
> > 1) GFS today uses a user space DLM.  What critical problems does this have
> > that you suddenly need to move it all into the kernel?
> 
> GFS does not use a user space dlm today.  GFS uses the client-server gulm lock
> manager for which the client (gfs) side runs in the kernel and the gulm server
> runs in userspace on some other node.  People have naturally been averse to
> using servers like this with gfs for a long time and we've finally created the
> serverless dlm (a la VMS clusters).  For many people this is the only option
> that makes gfs interesting; it's also what the opengfs group was doing.

OK, whatever you choose to call it, the previous lock manager used by
gfs was userspace.

OK, so why is a kernel based DLM the only option that makes GFS
interesting?  What are the concrete advantages you achieve with a kernel
based DLM that you don't get with a user space one?  There are plenty of
symmetric serverless userspace DLM implementations that follow the old
VMS (and even updated by Oracle) spec.

Steve Dake has already given a pretty compelling list of why you
shouldn't put the DLM and clustering in the kernel, what is the more
compelling list of reasons why it should be?

> This is a revealing discussion.  We've worked hard to make gfs's lock manager
> independent from gfs itself so it could be useful to others and make gfs less
> monolithic.  We could have left it embedded within the file system itself --
> that's what most other cluster file systems do.  If we'd done that we would
> have avoided this objection altogether but with an inferior design.  The fact
> that there's an independent lock manager to point at and question illustrates
> our success.  The same goes for the cluster manager.  (We could, of course, do
> some simple glueing together and make a monlithic system again :-)

I'm not questioning your goal, merely your in-kernel implementation.
Sharing is good.  However things which are shared don't automatically
have to be in-kernel.

> > 2) We have numerous other clustering products for Linux, none of which (well
> > except the Veritas one) has any requirement at all on having pieces in the
> > kernel.  If all the others operate in user space, why does yours need to be
> > in the kernel?
> 
> If you want gfs in user space you don't want gfs; you want something different.

I didn't say GFS, I said "cluster products".  That's the DLM and CMAN
pieces of your architecture.

Once you can convince us that CMAN et al should be in the kernel, the
next stage of the discussion would be the API.  Several groups (like
GGL, SAF and OCF) have done API work for clusters.  They were mostly
careful to select APIs that avoided mandating cluster policy.  You seem
to have chosen a particular policy (voting quorate) to implement. 
Again, that's a red flag.  Policy should not be in the kernel;  if we
all agree there should be in-kernel APIs for clustering then they should
be sufficiently abstracted to support all current cluster policies.

James


