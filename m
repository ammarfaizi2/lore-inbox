Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262486AbSLIDp1>; Sun, 8 Dec 2002 22:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262449AbSLIDp1>; Sun, 8 Dec 2002 22:45:27 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:25828 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S262448AbSLIDpX>; Sun, 8 Dec 2002 22:45:23 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Kenneth D. Merry" <ken@kdm.org>
Date: Mon, 9 Dec 2002 14:52:11 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15860.4971.982540.695313@notabene.cse.unsw.edu.au>
Cc: Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: RFC - new raid superblock layout for md driver
In-Reply-To: message from Kenneth D. Merry on Thursday November 21
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au>
	<Pine.SOL.3.96.1021120095120.2764A-100000@libra.cus.cam.ac.uk>
	<20021121170823.A54989@panzer.kdm.org>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday November 21, ken@kdm.org wrote:
> 
> This is a good idea.  Having all of the devices listed in the metadata on
> each disk is very helpful.  (See below for why.)
> 
> Here are some of my ideas about the features you'll want out of a new type
> of metadata:
...
> 
> [ these are features I think would be good to have ]
> 
>  - Per-array state that lets you know whether you're doing a resync,
>    reconstruction, verify, verify and fix, and so on.  This is part of the
>    state you'll need to do checkpointing -- picking up where you left off
>    after a reboot during the middle of an operation.
> 
 
Yes, a couple of flags in the 'state' field could do this.

>  - Per-array block number that tells you how far along you are in a verify,
>    resync, reconstruction, etc.  If you reboot, you can, for example, pick
>    a verify back up where you left off.

Got that, called "resync-position" (though I guess I have to change
the hypen...).

> 
>  - Enough per-disk state so you can determine, if you're doing a resync or
>    reconstruction, which disk is the target of the operation.  When I was
>    doing a lot of work on md a while back, one of the things I ran into is
>    that when you do a resync of a RAID-1, it always resyncs from the first
>    to the second disk, even if the first disk is the one out of sync.  (I
>    changed this, with Adaptec metadata at least, so it would resync onto
>    the correct disk.)

When a raid1 array is out of sync, it doesn't mean anything to say
which disc is out of sync.  They all are, with each other...
Nonetheless, the per-device stateflags have an 'in-sync' bit which can
be set or cleared as appropriate.

> 
>  - Each component knows about every other component in the array.  (It
>    knows by UUID, not just that there are N other devices in the array.)
>    This is an important piece of information:
> 	- You can compose the array now, using each disk's set_uuid and the
> 	  position of the device in the array, and by using the events
> 	  field to filter out the older of two disks that claim the same
> 	  position.
> 
> 	  The problem comes in more complicated scenarios.  For example:
> 		- user pulls one disk out of a RAID-1 with a spare
> 		- md reconstructs onto the spare
> 		- user shuts down machine, pulls the (former) spare that is
> 		  now part of the machine, and replaces the disk that he
> 		  originally pulled.
> 
> 	  So now you've got a scenario where you have a disk that claims to
> 	  be part of the array (same set_uuid), but its events field is a
> 	  little behind.  You could just resync the disk since it is out of
> 	  date, but still claims to be part of the array.  But you'd be
> 	  back in the same position if the user pulls the disk again and
> 	  puts the former spare back in -- you'd have to resync again.
> 
> 	  If each disk had a list of the uuids of every disk in the array,
> 	  you could tell from the disk table on the "freshest" disk that
> 	  the disk the user stuck back in isn't part of the array, despite
> 	  the fact that it claims to be.  (It was at one point, and then
> 	  was removed.)  You can then make the user add it back explicitly,
> 	  instead of just resyncing onto it.

The event counter is enough to determine if a device is really part of
the current array or not, and I cannot see why you need more than
that.
As far as I can tell, everything that you have said can be achieved
with setuid/devnumber/event.

> 
>  - Possibly the ability to setup multilevel arrays within a given piece of
>    metadata.  As far as multilevel arrays go, there are two basic
>    approaches to the metadata:

How many actual uses of multi-level arrays are there??

The most common one is raid0 over raid1, and I think there is a strong
case for implementing a 'raid10' module that does that, but also
allows a raid10 of an odd number of drives and things like that.

I don't think anything else is sufficiently common to really deserve
special treatment:  recursive metadata is adequate I think.

Concerning the  auto-assembly of multi-level arrays, that is not
particularly difficult, it just needs to be described precisely, and
coded.
It is a user-space thing and easily solved at that level.

> 
> I know Neil has philosophical issues with autoconfiguration (or perhaps
> in-kernel autoconfiguration), but it really is helpful, especially in
> certain situations.

I have issues with autoconfiguration that is not adequately
configurable, and current linux in-kernel autoconfiguration is not
adequately configurable.  With mdadm autoconfiguration is (very
nearly) adequately configurable and is fine.  There is still room for
some improvement, but not much.

Thanks for your input,
NeilBrown
