Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319296AbSIKTLs>; Wed, 11 Sep 2002 15:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319297AbSIKTLs>; Wed, 11 Sep 2002 15:11:48 -0400
Received: from gate.in-addr.de ([212.8.193.158]:38409 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S319295AbSIKTLp>;
	Wed, 11 Sep 2002 15:11:45 -0400
Date: Wed, 11 Sep 2002 21:17:01 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ?
Message-ID: <20020911191701.GE1212@marowsky-bree.de>
References: <20020910122650.A13738@eng2.beaverton.ibm.com> <200209111420.g8BEKdx01979@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200209111420.g8BEKdx01979@localhost.localdomain>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-09-11T09:20:38,
   James Bottomley <James.Bottomley@steeleye.com> said:

> patmans@us.ibm.com said:
> > The scsi multi-path code is not in 2.5.x, and I doubt it will be
> > accepted without the support of James and others. 
> I haven't said "no" yet (and Doug and Jens haven't said anything). 

Except for dasds, all devices I care for with regard to multipathing _are_
SCSI, so that would solve at least 90% of my worries in the mid-term. And also
do multipathing for !block devices, in theory.

It does have the advantage of knowing the topology better than the block
layer; the chance that a path failure only affects one of the LUNs on a device
is pretty much nil, so it would speed up error recovery.

However, I could also live with this being handled in the volume manager /
device mapper. This would transcend all potential devices - if the character
devices were really mapped through the block layer (didn't someone have this
weird idea once? ;-), it would too work for !block devs.

Exposing a better error reporting upwards is also definetely a good idea, and
if the device mapper could have the notion of "to what topology group does
this device belong to", or even "distance metric (without going into further
detail on what this is, as long as it is consistent to the physical layer) to
the current CPU" (so that the shortest path in NUMA could be selected), that
would be kinda cool ;-) And doesn't seem too intrusive.

Now, what I definetely dislike is the vaste amount of duplicated code. I'm not
sure whether we can get rid of this in 2.5 timeframe though.

<rant>

If EVMS was cleaned up some, maybe used the neat LVM2 device mapper
internally, and in fact is a superset of everything we've had before and can
support everything from our past as well as give us what we really want
(multi-pathing, journaled RAID etc), and we do the above, I vote for a legacy
free kernel. Unify the damn block device management and throw out the old
code. 

I hate cruft. Customers want to and will use it. Someone has to support it. It
breaks stuff. It cuts a 9 of my availability figure. ;-)

</rant>

> I think we all agree:

I agree here.

> 3) that errors (both medium and transport) may need to be propagated 
> immediately up the block layer in order for multi-path to be handled 
> efficiently.

Right. All the points you outline about the error handling are perfectly
valid.

But one of the issues with the md layer right now for example is the fact that
an error on a backup path will only be noticed as soon as it actually tries to
use it, even if the cpqfc (to name the culprit, worst code I've seen in a
while) notices a link-down event. It isn't communicated anywhere, and how
should it be?

This may be for later, but is something to keep in mind.

> thought how to do that).  Any commands that are sent down to probe the device 
> are generated from within the error handler thread (no device probing with 
> live commands).

If the path was somehow exposed to user-space (as it is with md right now),
the reprobing could even be done outside the kernel. This seems to make sense,
because a potential extensive device-specific diagnostic doesn't have to be
folded into it then.

> What other features do you need on the eh wishlist?

The other features on my list - prioritizing paths, a useful, consistent user
interface via driverfs/devfs/procfs  - are more or less policy I guess.



Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

