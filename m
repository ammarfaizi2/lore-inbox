Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266917AbSLJX7u>; Tue, 10 Dec 2002 18:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266903AbSLJX7u>; Tue, 10 Dec 2002 18:59:50 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:32741 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S266865AbSLJX7m>; Tue, 10 Dec 2002 18:59:42 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Kenneth D. Merry" <ken@kdm.org>
Date: Wed, 11 Dec 2002 11:07:14 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15862.33202.634662.276558@notabene.cse.unsw.edu.au>
Cc: Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: RFC - new raid superblock layout for md driver
In-Reply-To: message from Kenneth D. Merry on Monday December 9
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au>
	<Pine.SOL.3.96.1021120095120.2764A-100000@libra.cus.cam.ac.uk>
	<20021121170823.A54989@panzer.kdm.org>
	<15860.4971.982540.695313@notabene.cse.unsw.edu.au>
	<20021209232856.A47324@panzer.kdm.org>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday December 9, ken@kdm.org wrote:
> On Mon, Dec 09, 2002 at 14:52:11 +1100, Neil Brown wrote:
> > >  - Enough per-disk state so you can determine, if you're doing a resync or
> > >    reconstruction, which disk is the target of the operation.  When I was
> > >    doing a lot of work on md a while back, one of the things I ran into is
> > >    that when you do a resync of a RAID-1, it always resyncs from the first
> > >    to the second disk, even if the first disk is the one out of sync.  (I
> > >    changed this, with Adaptec metadata at least, so it would resync onto
> > >    the correct disk.)
> > 
> > When a raid1 array is out of sync, it doesn't mean anything to say
> > which disc is out of sync.  They all are, with each other...
> > Nonetheless, the per-device stateflags have an 'in-sync' bit which can
> > be set or cleared as appropriate.
> 
> This sort of information (if it is used) would be very useful for dealing
> with Adaptec metadata.  Adaptec HostRAID adapters let you build a RAID-1 by
> copying one disk onto the other, with the state set to indicate the source
> and target disks.
> 
> Since the BIOS on those adapters takes a long time to do a copy, it's
> easier to break out of the build after it gets started, and let the kernel
> pick back up where the BIOS left off.  To do that, you need checkpointing
> support (i.e. be able to figure out where we left off with a particular
> operation) and you need to be able to determine which disk is the source
> and which is the target.
> 
> To do this with the first set of Adaptec metadata patches I wrote for
> md, I had to kinda "bolt on" some extra state in the kernel, so I could
> figure out which disk was the target, since md doesn't really pay attention
> to the current per-disk in sync flags.

The way to solve this that would be most in-keeping with the raid code
in 2.4 would be for the drives that were not yet in-sync to appear as
'spare' drives.  On array assembly, the first spare would get rebuilt
by md and then fully incorporated into the array.  I agree that this is
not a very good conceptual fit.

The 2.5 code is a lot tidier with respect to this.  Each device has an
'in-sync' flag so when an array has a missing drive, a spare is added
and marked not-in-sync.  When recovery finishes, the drive that was
spare has the in-sync flag set.

2.5 code has an insync flag to, but it is not used sensibly.

Note that this relates to a drive being out-of-sync (as in a
reconstruction or recovery operation).  It is quite different to the
array being out-of-sync which requires a resync operation.


> > > 
> > > 	  If each disk had a list of the uuids of every disk in the array,
> > > 	  you could tell from the disk table on the "freshest" disk that
> > > 	  the disk the user stuck back in isn't part of the array, despite
> > > 	  the fact that it claims to be.  (It was at one point, and then
> > > 	  was removed.)  You can then make the user add it back explicitly,
> > > 	  instead of just resyncing onto it.
> > 
> > The event counter is enough to determine if a device is really part of
> > the current array or not, and I cannot see why you need more than
> > that.
> > As far as I can tell, everything that you have said can be achieved
> > with setuid/devnumber/event.
> 
> It'll work with just the setuuid/devnumber/event, but as I mentioned in the
> last paragraph above, you'll end up resyncing onto the disk that is pulled
> and then reinserted, because you don't really have any way of knowing it is
> no longer a part of the array.  All you know is that it is out of
> date.

If you pull drive N, then it will appear to fail and all other drives
will be marked to say that 'drive N is faulty'.
If you plug drive N back in, the md code simply wont notice.
If you tell it to 'hot-add' the drive, it will rebuild onto it, but
that is what you asked to do.
If you shut down and restart, the auto-detection may well find drive
N, but even if it's event number is sufficiently recent (which would
require an unclean shutdown of the array), the fact that the most
recent superblocks will say that drive N is failed will mean that it
doesn't get incorporated into the array.  You still have to explicitly
hot-add it before it will resync.

I still don't see the problem, sorry.

> 
> > >  - Possibly the ability to setup multilevel arrays within a given piece of
> > >    metadata.  As far as multilevel arrays go, there are two basic
> > >    approaches to the metadata:
> > 
> > How many actual uses of multi-level arrays are there??
> > 
> > The most common one is raid0 over raid1, and I think there is a strong
> > case for implementing a 'raid10' module that does that, but also
> > allows a raid10 of an odd number of drives and things like that.
> 
> RAID-10 is the most common, but RAID-50 is found in the "wild" as well.
> 
> It would be more flexible if you could stack personalities on top of each
> other.  This would give people the option of combining whatever
> personalities they want (within reason; the multipath personality doesn't
> make a whole lot of sense to stack).
> 
> > I don't think anything else is sufficiently common to really deserve
> > special treatment:  recursive metadata is adequate I think.
> 
> Recursive metadata is fine, but I would encourage you to think about how
> you would (structurally) support multilevel arrays that use integrated
> metadata.  (e.g. like RAID-10 on an Adaptec HostRAID board)

How about this:
  Option 1:
    Assertion: The only sensible raid stacks involve two levels:  A
      level that provides redundancy (Raid1/raid5) on the bottom, and a
      level that compbines capacity on the top (raid0/linear).

    Observation: in-kernel knowledge of superblock is only needed for
      levels that provide redundancy (raid1/raid5) and so need to
      update to superblock after errors, etc.  raid0/linear can 
      be managed fine without any in-kernel knowledge of superblocks.

    Approach:
      Teach the kernel to read your adaptec raid10 superblock and
      present it to md as N separate raid1 arrays.
      Have a user-space tool that assembles the array as follows:
	1/ read the superblocks
	2/ build the raid1 arrays
	3/ build the raid0 on-top using non-persistant superblocks.

    There may need to be small changes to the md code to make this work
    properly, but I feel that it is a good approach.

 Option 2:
    Possibly you disagree with the above assertion.  Possibly you
    think that a raid5 build from a number of raid1's is a good idea.
    And maybe you are right.

    Approach:
      Add an ioctl, or possibly an 'magic' address, so that it is
      possible to read a raw superblock from an md array.
      Define two in-kernel superblock reading methods.  One reads the 
      superblock and presents it as the bottom level only.  The other
      reads the raw superblock out of the underlying device, using the
      ioctl or magic address (e.g. read from MAX_SECTOR-8) and
      presents it as the next level of the raid stack.

  I think this approach, possible with some refinement, would be
  adequate to support any sort of stacking and any sort of raid
  superblock, and it would be my preferred way to go, if this were
  necessary. 

> 
> > Concerning the  auto-assembly of multi-level arrays, that is not
> > particularly difficult, it just needs to be described precisely, and
> > coded.
> > It is a user-space thing and easily solved at that level.
> 
> How does it work if you're trying to boot off the array?  The kernel needs
> to know how to auto-assemble the array in order to run init and everything
> else that makes a userland program run.

initramdisk or initramfs or whatever is appropriate for the kernel you
are using.  

Also, remember to keep the concepts of 'boot' and 'root' distinct.

To boot off an array, your BIOS needs to know about the array.  There
are no two ways about that.  It doesn't need to know a lot about the
array, and for raid1 all it needs to know is 'try this device, and if
it fails, try that device'.

To have root on an array, you need to be able to assemble the array
before root is mounted.  md= kernel parameters in one option, but not
a very extensible one.
initramfs will be the preferred approach in 2.6.  i.e. an initial root
is loaded along with the kernel, and it has the user-space tools for
finding, assembling and mounting the root device.

> 
> > > 
> > > I know Neil has philosophical issues with autoconfiguration (or perhaps
> > > in-kernel autoconfiguration), but it really is helpful, especially in
> > > certain situations.
> > 
> > I have issues with autoconfiguration that is not adequately
> > configurable, and current linux in-kernel autoconfiguration is not
> > adequately configurable.  With mdadm autoconfiguration is (very
> > nearly) adequately configurable and is fine.  There is still room for
> > some improvement, but not much.
> 
> I agree that userland configuration is very flexible, but I think there is
> a place for kernel-level autoconfiguration as well.  With something like an
> Adaptec HostRAID board (i.e. something you can boot from), you need kernel
> level autoconfiguration in order for it to work smoothly.

I disagree, and the development directions of 2.5 tend to support me.
You certainly need something before root is mounted, but 2.5 is
leading us to 'early-user-space configuration' rather than 'in-kernel
configuration'.

NeilBrown
