Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265487AbUGHJL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265487AbUGHJL0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 05:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265644AbUGHJL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 05:11:26 -0400
Received: from gate.in-addr.de ([212.8.193.158]:23214 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S265487AbUGHJLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 05:11:21 -0400
Date: Thu, 8 Jul 2004 11:10:43 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Daniel Phillips <phillips@redhat.com>
Cc: linux-kernel@vger.kernel.org, Lon Hohberger <lhh@redhat.com>,
       David Teigland <teigland@redhat.com>
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Message-ID: <20040708091043.GS12255@marowsky-bree.de>
References: <200407050209.29268.phillips@redhat.com> <200407061734.51023.phillips@redhat.com> <20040707181650.GD12255@marowsky-bree.de> <200407072114.07291.phillips@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200407072114.07291.phillips@redhat.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-07-07T21:14:07,
   Daniel Phillips <phillips@redhat.com> said:

> OK, what I've learned from the discussion so far is, we need to avoid 
> getting stuck too much on the HA aspects and focus more on the 
> cluster/performance side for now.  There are just too many entrenched 
> positions on failover.

Well, first, failover is not all of HA. But that's a different diversion
again.

> Out of that, we need to pick the three or four items we're prepared to 
> address immediately, that we can obviously share between at least two 
> known cluster filesystems, and get them onto lkml for peer review.  

Ok.

> For example, the DLM is fairly non-controversial, and important in
> terms of performance and reliability.  Let's start with that.

I doubt that assessment, the DLM is going to be somewhat controversial
already and requires the dragging in of membership, inter-node
messaging, fencing and quorum. The problem is that you cannot easily
separate out the different pieces.

I'd humbly suggest to start with the changes in the VFS layers which the
CFS's of the different kinds require, regardless of which infrastructure
they use.

Of all the cluster-subsystems, the fencing system is likely the most
important. If the various implementations don't step on eachothers toes
there, the duplication of membership/messaging/etc is only inefficient,
but not actively harmful.

> I heard plenty of fascinating discussion of quorum strategies last 
> night, and have a number of papers to read as a result.  But that's a 
> diversion: it can and must be pluggable.  We just need to agree on how 
> the plugs work, a considerably less ambitious task.

When you argue whether or not you can mandate quorum for a given cluster
implementation, and which layers of the cluster are allowed to require
quorum (some will refuse to even tell you the membership without quorum;
some will require quorum before they fence, others will recover quorum
by fencing), this discussion is fairly complex.

Again, let's see what kernel hooks these require, and defer all the rest
of the discussions as far as possible.

> it policy, push it to user space, and move on.  We need to agree on the 
> basics so that we can manage network volumes with cluster filesystems 
> on top of them.

Ah, that in itself is a very data-centric point of view and not exactly
applicable to the needs of shared-nothing clusters. (I'm not trying to
nitpick, just trying to make you aware of all the hidden assumptions you
may not be aware of yourself.) Of course, this is perfectly fine for
something such as GFS (which, being SAN based, of course requires
these), but a cluster infrastructure in the kernel may not be limitted
to this.

> > Is there a KS presentation on this? I didn't get invited to KS and
> > will just be allowed in for OLS, but I'll be around town already...
> There will be a BOF at OLS, "Cluster Infrastructure".  Since I didn't 
> get a KS invite either and what remains is more properly lkml stuff 
> anyway, I will go canoing with Matt O'Keefe during KS as planned. 

Ah, okay.

> > Your fencing system is fine with me; based on the assumption that you
> > always have to fence a failed node, you are doing the right thing.
> > However, the issues are more subtle when this is no longer true, and
> > in a 1:1 how do you arbitate who is allowed to fence?
> Good question.  Since two-node clusters are my primary interest at the 
> moment, I need some answers. 

Two-node clusters are reasonably easy, true.

> I think the current plan is: they try to fence each other, winner take
> all.  Each node will introspect to decide if it's in good enough shape
> to do the job itself, then go try to fence the other one.

Ok, this is essentially what heartbeat does, but it gets more complex
with >2 nodes. In which case your cluster block device is going to run
into interesting synchronization issues, too, I'd venture. (Or at least
drbd does, where we look at replicating across >2 nodes.)

> > resources, obviously. However, if the CRM is the one which ultimately
> > decides whether a node needs to be fenced or not - based on its
> > knowledge of which resources it owns or could own - this gets a lot
> > more scary still...
> We do not see the CRM as being involved in fencing at present, though I 
> can see why perhaps it ought to be.  The resource manager that Lon 
> Hohberger is cooking up is scriptable and rule-driven. 

Frankly, I'm kind of disappointed; why are you cooking up your own once
more? When we set out to write a new dependency-based flexible resource
manager, we explicitly made it clear that it wasn't just meant to run on
top of heartbeat, but in theory on top of any cluster infrastructure.

I know this is the course of Open Source development, and that
"community project" basically means "my wheel be better than your wheel,
and you are allowed to get behind it after we are done, but don't
interfere before that", but I'd have expected some discussions or at
least solicitation of them on the established public mailing lists, just
to keep up the pretense ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	    \ ever tried. ever failed. no matter.
SUSE Labs, Research and Development | try again. fail again. fail better.
SUSE LINUX AG - A Novell company    \ 	-- Samuel Beckett

