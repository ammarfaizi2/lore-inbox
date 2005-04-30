Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262504AbVD3E0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262504AbVD3E0A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 00:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVD3E0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 00:26:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6379 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262504AbVD3EZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 00:25:47 -0400
Date: Sat, 30 Apr 2005 12:29:15 +0800
From: David Teigland <teigland@redhat.com>
To: Daniel McNeil <daniel@osdl.org>
Cc: Lars Marowsky-Bree <lmb@suse.de>, Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1b/7] dlm: core locking
Message-ID: <20050430042915.GA10473@redhat.com>
References: <1114466097.30427.32.camel@persist.az.mvista.com> <20050426054933.GC12096@redhat.com> <1114537223.31647.10.camel@persist.az.mvista.com> <20050427030217.GA9963@redhat.com> <20050427134142.GZ4431@marowsky-bree.de> <20050427142638.GG16502@redhat.com> <20050428123315.GP21645@marowsky-bree.de> <1114706362.18352.85.camel@ibm-c.pdx.osdl.net> <20050429040104.GB9900@redhat.com> <1114815509.18352.200.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114815509.18352.200.camel@ibm-c.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 03:58:29PM -0700, Daniel McNeil wrote:

> So the Connection Manager controlled membership, quorum, and fencing
> (stalling all disk i/o, etc).  AFAIR, the DLM would get a membership
> event and do recovery after quorum and fencing.   

Right

> From the description above, nodes not part of the membership with quorum
> could not do anything.

Right

> I have always thought that an distributed application could use the DLM
> alone to protect access to shared storage.   The DLM would coordinate
> access between the distributed application running on the nodes
> in the cluster AND DLM locks would not be recovered and possibly
> granted to applications running on the nodes still in the membership
> until after nodes that are no longer a member of the cluster are safely
> prevented from doing any harm.
> 
> So, when I said that the DLM was dependent on fencing, I was thinking
> of the membership, quorum, prevention of harm (stalling of i/o to
> prevent corrupting shared resource) as described above.
> 
> So, if an application was using your DLM to protect shared storage,
> I think you are saying it possible the DLM lock could be granted 
> before the node that was previously holding the lock and now is not
> part of the cluster is fenced.  Is that right?

It depends on how the clustering infrastructure coordinates the various
aspects of recovery.  The dlm doesn't specify how that's done because
there's no universal answer.  If it's important to your application that
fencing happens before the dlm grants locks from failed nodes, then you
need to be sure that's how the infrastructure coordinates recovery of
fencing, the dlm and your application.

I can talk about GFS's requirements on how fencing and dlm recovery
happen, but other apps will be different.

GFS requires that a gfs fs has been "suspended" (told that recovery will
be happening) on all nodes _before_ the dlm grants locks from failed nodes
(i.e. before the dlm starts recovery).  Because the dlm grants locks
previously held by failed nodes when its recovery completes, gfs has a
much stricter standard for using dlm locks while it's in this suspended
state: the gfs recovery process can acquire new locks, but no one else.

That leaves GFS's fencing requirement.  GFS requires that a failed node be
fenced prior to gfs being told to begin recovery for that node (which
involves recovering the journal of the failed node.)

So for gfs, it's important that fencing and dlm recovery both happen
before gfs recovery, but the order of fencing and dlm recovery (with
respect to each other) doesn't matter.  As I said, the dlm doesn't require
that fencing happen first, but as you suggest, an application may want it
that way.

> PS if an application is writing to local storage, what does it need a
> DLM for?

My experience is pretty limited, but I suspect there are distributed
applications, requiring synchronization, that don't write to shared
storage.

Thanks for the info and good questions
Dave

