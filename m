Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267234AbSKVABs>; Thu, 21 Nov 2002 19:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267233AbSKVABs>; Thu, 21 Nov 2002 19:01:48 -0500
Received: from panzer.kdm.org ([216.160.178.169]:40461 "EHLO panzer.kdm.org")
	by vger.kernel.org with ESMTP id <S267231AbSKVABk>;
	Thu, 21 Nov 2002 19:01:40 -0500
Date: Thu, 21 Nov 2002 17:08:23 -0700
From: "Kenneth D. Merry" <ken@kdm.org>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: RFC - new raid superblock layout for md driver
Message-ID: <20021121170823.A54989@panzer.kdm.org>
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au> <Pine.SOL.3.96.1021120095120.2764A-100000@libra.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.SOL.3.96.1021120095120.2764A-100000@libra.cus.cam.ac.uk>; from aia21@cantab.net on Wed, Nov 20, 2002 at 10:03:26AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 10:03:26 +0000, Anton Altaparmakov wrote:
> Hi,
> 
> On Wed, 20 Nov 2002, Neil Brown wrote:
> > I (and others) would like to define a new (version 1) format that
> > resolves the problems in the current (0.90.0) format.
> > 
> > The code in 2.5.lastest has all the superblock handling factored out so
> > that defining a new format is very straight forward.
> > 
> > I would like to propose a new layout, and to receive comment on it..
> 
> If you are making a new layout anyway, I would suggest to actually add the
> complete information about each disk which is in the array into the raid
> superblock of each disk in the array. In that way if a disk blows up, you
> can just replace the disk use some to be written (?) utility to write the
> correct superblock to the new disk and add it to the array which then
> reconstructs the disk. Preferably all of this happens without ever
> rebooting given a hotplug ide/scsi controller. (-;
> 
> >From a quick read of the layout it doesn't seem to be possible to do the
> above trivially (or certainly not without help of /etc/raidtab), but
> perhaps I missed something...
> 
> Also, autoassembly would be greatly helped if the superblock contained the
> uuid for each of the devices contained in the array. It is then trivial to
> unplug all raid devices and move them around on the controller and it
> would still just work. Again I may be missing something and that is
> already possible to do trivially.

This is a good idea.  Having all of the devices listed in the metadata on
each disk is very helpful.  (See below for why.)

Here are some of my ideas about the features you'll want out of a new type
of metadata:

[ these you've already got ]

 - each array has a unique identifier (you've got this already)
 - each disk/partition/component has a unique identifier (you've got this
   already)
 - a monotonically increasing serial number that gets incremented every
   time you write out the metadata (you've got this, the 'events' field)

[ these are features I think would be good to have ]

 - Per-array state that lets you know whether you're doing a resync,
   reconstruction, verify, verify and fix, and so on.  This is part of the
   state you'll need to do checkpointing -- picking up where you left off
   after a reboot during the middle of an operation.

 - Per-array block number that tells you how far along you are in a verify,
   resync, reconstruction, etc.  If you reboot, you can, for example, pick
   a verify back up where you left off.

 - Enough per-disk state so you can determine, if you're doing a resync or
   reconstruction, which disk is the target of the operation.  When I was
   doing a lot of work on md a while back, one of the things I ran into is
   that when you do a resync of a RAID-1, it always resyncs from the first
   to the second disk, even if the first disk is the one out of sync.  (I
   changed this, with Adaptec metadata at least, so it would resync onto
   the correct disk.)

 - Each component knows about every other component in the array.  (It
   knows by UUID, not just that there are N other devices in the array.)
   This is an important piece of information:
	- You can compose the array now, using each disk's set_uuid and the
	  position of the device in the array, and by using the events
	  field to filter out the older of two disks that claim the same
	  position.

	  The problem comes in more complicated scenarios.  For example:
		- user pulls one disk out of a RAID-1 with a spare
		- md reconstructs onto the spare
		- user shuts down machine, pulls the (former) spare that is
		  now part of the machine, and replaces the disk that he
		  originally pulled.

	  So now you've got a scenario where you have a disk that claims to
	  be part of the array (same set_uuid), but its events field is a
	  little behind.  You could just resync the disk since it is out of
	  date, but still claims to be part of the array.  But you'd be
	  back in the same position if the user pulls the disk again and
	  puts the former spare back in -- you'd have to resync again.

	  If each disk had a list of the uuids of every disk in the array,
	  you could tell from the disk table on the "freshest" disk that
	  the disk the user stuck back in isn't part of the array, despite
	  the fact that it claims to be.  (It was at one point, and then
	  was removed.)  You can then make the user add it back explicitly,
	  instead of just resyncing onto it.

 - Possibly the ability to setup multilevel arrays within a given piece of
   metadata.  As far as multilevel arrays go, there are two basic
   approaches to the metadata:
	- Integrated metadata defines all levels of the array in a single
	  chunk of metadata.  So, for example, by reading metadata off of
	  sdb, you can figure out that it is a component of a RAID-1 array,
	  and that that RAID-1 array is a component of a RAID-10.

	  There are a couple of advantages to integrated metadata:
		- You can keep state that applies to the whole array
		  (clean/dirty, for example) in one place.
		- It helps in autoconfiguring an array, since you don't
		  have to go through multiple steps to find out all the
		  levels of an array.  You just read the metadata from one
		  place on one disk, and you've got

	  There are a couple of disadvantages to integrated metadata:
		- Possibly reduced/limited space for defining multiple
		  array levels or arrays with lots of disks.  This is not a
		  problem, though, given sufficient metadata space.

		- Marginally more difficulty handling metadata updates,
		  depending on how you handle your multilevel arrays.  If
		  you handle them like md currently does (separate block
		  devices for each level and component of the array), it'll
		  be pretty difficult to use integrated metadata.

	- Recursive metadata defines each level of the array separately.
	  So, for example, you'd read the metadata from the end of a disk
	  and determine it is part of a RAID-1 array.  Then, you configure
	  the RAID-1 array, and read the metadata from the end of that
	  array, and determine it is part of a RAID-0 array.  So then you
	  configure the RAID-0 array, look at the end, fail to find
	  metadata, and figure out that you've reached the top level of the
	  array.

	  This is almost how md currently does things, except that it
	  really has no mechanism for autoconfiguring multilevel arrays.

	  There are a couple of advantages to recursive metadata:
		- It is easier to handle metadata updates for multilevel
		  arrays, especially if the various levels of the array are
		  handled by different block devices, as md does.

		- You've potentially got more space for defining disks as
		  part of the array, since you're only defining one level
		  at a time.

	  There are a couple of disadvantages to recursive metadata:
		- You have to have multiple copies of any state that
		  applies to the whole array (e.g. clean/dirty).

		- More windows of opportunity for incomplete metadata
		  writes.  Since metadata is in multiple places, there are
		  more opportunities for scenarios where you'll have
		  metadata for one part of the array written out, but not
		  another part before you crash or a disk crashes...etc.

I know Neil has philosophical issues with autoconfiguration (or perhaps
in-kernel autoconfiguration), but it really is helpful, especially in
certain situations.

As for recursive versus integrated metadata, it would be nice if md could
handle autoconfiguration with either type of multilevel array.  The reason
I say this is that Adaptec HostRAID adapters use integrated metadata.
So if you want to support multilevel arrays with md on HostRAID adapters,
you have to have support for multilevel arrays with integrated metadata.

When I did the first port of md to work on HostRAID, I pretty much had to
skip doing RAID-10 support because it wasn't structurally feasible to
autodetect and configure a multilevel array.  (I ended up doing a full
rewrite of md that I was partially done with when I got laid off from
Adaptec.)

Anyway, if you want to see the Adaptec HostRAID support, which includes
metadata definitions:

http://people.freebsd.org/~ken/linux/md.html

The patches are against 2.4.18, but you should be able to get an idea of
what I'm talking about as far as integrated metadata goes.

This is all IMO, maybe it'll be helpful, maybe not, but hopefully it'll be
useful to consider these ideas.

Ken
-- 
Kenneth Merry
ken@kdm.org
