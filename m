Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266645AbSLJGVt>; Tue, 10 Dec 2002 01:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266643AbSLJGVs>; Tue, 10 Dec 2002 01:21:48 -0500
Received: from panzer.kdm.org ([216.160.178.169]:44302 "EHLO panzer.kdm.org")
	by vger.kernel.org with ESMTP id <S266637AbSLJGVk>;
	Tue, 10 Dec 2002 01:21:40 -0500
Date: Mon, 9 Dec 2002 23:28:56 -0700
From: "Kenneth D. Merry" <ken@kdm.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: RFC - new raid superblock layout for md driver
Message-ID: <20021209232856.A47324@panzer.kdm.org>
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au> <Pine.SOL.3.96.1021120095120.2764A-100000@libra.cus.cam.ac.uk> <20021121170823.A54989@panzer.kdm.org> <15860.4971.982540.695313@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15860.4971.982540.695313@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Mon, Dec 09, 2002 at 02:52:11PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2002 at 14:52:11 +1100, Neil Brown wrote:
> >  - Enough per-disk state so you can determine, if you're doing a resync or
> >    reconstruction, which disk is the target of the operation.  When I was
> >    doing a lot of work on md a while back, one of the things I ran into is
> >    that when you do a resync of a RAID-1, it always resyncs from the first
> >    to the second disk, even if the first disk is the one out of sync.  (I
> >    changed this, with Adaptec metadata at least, so it would resync onto
> >    the correct disk.)
> 
> When a raid1 array is out of sync, it doesn't mean anything to say
> which disc is out of sync.  They all are, with each other...
> Nonetheless, the per-device stateflags have an 'in-sync' bit which can
> be set or cleared as appropriate.

This sort of information (if it is used) would be very useful for dealing
with Adaptec metadata.  Adaptec HostRAID adapters let you build a RAID-1 by
copying one disk onto the other, with the state set to indicate the source
and target disks.

Since the BIOS on those adapters takes a long time to do a copy, it's
easier to break out of the build after it gets started, and let the kernel
pick back up where the BIOS left off.  To do that, you need checkpointing
support (i.e. be able to figure out where we left off with a particular
operation) and you need to be able to determine which disk is the source
and which is the target.

To do this with the first set of Adaptec metadata patches I wrote for
md, I had to kinda "bolt on" some extra state in the kernel, so I could
figure out which disk was the target, since md doesn't really pay attention
to the current per-disk in sync flags.

I solved this the second time around by making the in-core metadata generic
(and thus a superset of all the metadata types I planned on supporting),
and each metadata personality could supply target disk information if
possible.

> >  - Each component knows about every other component in the array.  (It
> >    knows by UUID, not just that there are N other devices in the array.)
> >    This is an important piece of information:
> > 	- You can compose the array now, using each disk's set_uuid and the
> > 	  position of the device in the array, and by using the events
> > 	  field to filter out the older of two disks that claim the same
> > 	  position.
> > 
> > 	  The problem comes in more complicated scenarios.  For example:
> > 		- user pulls one disk out of a RAID-1 with a spare
> > 		- md reconstructs onto the spare
> > 		- user shuts down machine, pulls the (former) spare that is
> > 		  now part of the machine, and replaces the disk that he
> > 		  originally pulled.
> > 
> > 	  So now you've got a scenario where you have a disk that claims to
> > 	  be part of the array (same set_uuid), but its events field is a
> > 	  little behind.  You could just resync the disk since it is out of
> > 	  date, but still claims to be part of the array.  But you'd be
> > 	  back in the same position if the user pulls the disk again and
> > 	  puts the former spare back in -- you'd have to resync again.
> > 
> > 	  If each disk had a list of the uuids of every disk in the array,
> > 	  you could tell from the disk table on the "freshest" disk that
> > 	  the disk the user stuck back in isn't part of the array, despite
> > 	  the fact that it claims to be.  (It was at one point, and then
> > 	  was removed.)  You can then make the user add it back explicitly,
> > 	  instead of just resyncing onto it.
> 
> The event counter is enough to determine if a device is really part of
> the current array or not, and I cannot see why you need more than
> that.
> As far as I can tell, everything that you have said can be achieved
> with setuid/devnumber/event.

It'll work with just the setuuid/devnumber/event, but as I mentioned in the
last paragraph above, you'll end up resyncing onto the disk that is pulled
and then reinserted, because you don't really have any way of knowing it is
no longer a part of the array.  All you know is that it is out of date.

> >  - Possibly the ability to setup multilevel arrays within a given piece of
> >    metadata.  As far as multilevel arrays go, there are two basic
> >    approaches to the metadata:
> 
> How many actual uses of multi-level arrays are there??
> 
> The most common one is raid0 over raid1, and I think there is a strong
> case for implementing a 'raid10' module that does that, but also
> allows a raid10 of an odd number of drives and things like that.

RAID-10 is the most common, but RAID-50 is found in the "wild" as well.

It would be more flexible if you could stack personalities on top of each
other.  This would give people the option of combining whatever
personalities they want (within reason; the multipath personality doesn't
make a whole lot of sense to stack).

> I don't think anything else is sufficiently common to really deserve
> special treatment:  recursive metadata is adequate I think.

Recursive metadata is fine, but I would encourage you to think about how
you would (structurally) support multilevel arrays that use integrated
metadata.  (e.g. like RAID-10 on an Adaptec HostRAID board)

> Concerning the  auto-assembly of multi-level arrays, that is not
> particularly difficult, it just needs to be described precisely, and
> coded.
> It is a user-space thing and easily solved at that level.

How does it work if you're trying to boot off the array?  The kernel needs
to know how to auto-assemble the array in order to run init and everything
else that makes a userland program run.

> > 
> > I know Neil has philosophical issues with autoconfiguration (or perhaps
> > in-kernel autoconfiguration), but it really is helpful, especially in
> > certain situations.
> 
> I have issues with autoconfiguration that is not adequately
> configurable, and current linux in-kernel autoconfiguration is not
> adequately configurable.  With mdadm autoconfiguration is (very
> nearly) adequately configurable and is fine.  There is still room for
> some improvement, but not much.

I agree that userland configuration is very flexible, but I think there is
a place for kernel-level autoconfiguration as well.  With something like an
Adaptec HostRAID board (i.e. something you can boot from), you need kernel
level autoconfiguration in order for it to work smoothly.

Ken
-- 
Kenneth Merry
ken@kdm.org
