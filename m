Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272553AbRIKTPl>; Tue, 11 Sep 2001 15:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272530AbRIKTPc>; Tue, 11 Sep 2001 15:15:32 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:23803 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S272565AbRIKTPU>; Tue, 11 Sep 2001 15:15:20 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Tue, 11 Sep 2001 13:15:31 -0600
To: Christoph Hellwig <hch@caldera.de>
Cc: David Balazic <david.balazic@uni-mb.si>, linux-kernel@vger.kernel.org
Subject: Re: IBMs LVM ?
Message-ID: <20010911131531.E29347@turbolinux.com>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	David Balazic <david.balazic@uni-mb.si>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3B9E255C.8943D6BB@uni-mb.si> <200109111526.f8BFQLr25266@ns.caldera.de> <20010911115713.D29347@turbolinux.com> <20010911200633.A5816@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010911200633.A5816@caldera.de>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 11, 2001  20:06 +0200, Christoph Hellwig wrote:
> On Tue, Sep 11, 2001 at 11:57:13AM -0600, Andreas Dilger wrote:
> > Do you have a specific complaint?  The current LVM kernel code isn't all
> > that robust either (and the user-space code is not very pretty).
> 
> Please take a barf-bag, look at the code, look at the unneded abstrations,
> look at the uneeded interfaces, look at the code-duplication, look
> at the over-engineering.

Well, you don't get anything for free.  You need to have some abstraction
in order to handle multiple LVM-type systems in a useful way, I don't see
any way around that.  As for the kernel code, I don't see TOO much
abstraction.

- You need code to read each separate on-disk format (partition headers,
  LVM metadata, etc)
- You need code to combine each of these into some useful "volume"
- You need code to do mapping from input volume/block to output disk/block
- You need code to be able to modify a volume metadata.

You need code to do this for each different metadata format or partition
type.  Luckily (hopefully?) most people won't have systems with more than
a couple different metadata formats at a time.  HOWEVER, you NEED to be
able to migrate from one format to another, so you will have periods when
you have extra modules loaded during a migration.

Consider EVMS to be the VFS for block devices.  The VFS abstracts a lot
of common code out of the filesystems so that each individual one can be
less complex.  Yes, there is still duplication within the filesystems,
but it would be much moreso if the VFS didn't exist.  There is a lot of
abstraction in the VFS, but it is NOT bloat, it is code consolidation.
As enough filesystems need a specific feature, it is abstracted out of
the multiple filesystems and put into the VFS for all to use.

> IF you don't have enough read the archives of the mailinglist about
> god-mode that allows even root to do anything and we come back.

It is not clear if you are you for or against "god-mode"?  Would you
like it so that it is easy to shoot themselves in the head (or it
is so complex/manual that it is hard not to), or rather everyone in
straight-jackets in rubber rooms (ala Windows)?  Some safety is needed,
but there are also reasons to bypass that safety.  I don't know what
the current state of "god-mode" is in the EVMS code (if it is there,
needed, whatever, so it is a moot point).

> > I DO think that EVMS will replace the current LVM code in the kernel.  Why?
> > - It already has 100% compatibility with the current LVM on-disk layout.
> 
> With _which_ LVM on-disk layout (OOPS, this was a complaint to Sistina :))

Exactly.  It was me and the EVMS LVM-emulation author that pointed out to
the Sistina folks that there was NO need to have an incompatible change
to the on-disk layout.  In fact, the EVMS code can handle BOTH formats,
and did so before LVM did.

> > - It is already possible to do LVM autoconfig of volumes within the kernel
> >   without needing an initrd to activate the volumes.
> 
> I had that for LVM 0.8 as well, that's a year ago now.

But, strangely it didn't make it into the LVM codebase.  Why is that?
I'm not blaming you, of course.  EVMS is at least a SourceForge project.

> > - It removes knowlege of partitions out of the disk drivers and makes them
> >   a simple form of LV.
> 
> No - it duplicates the partitions scanning code.  It does not remove the
> simple partitioning code (which, BTW is not part of the drivers at all
> under Linux), makeing it's copy more complicated than the original version.

Well, there are obvious reasons for that.  Some people won't want to have
EVMS in the kernel (clearly you are one of them), so their patch can't
just rip out the existing partition scanning code.  Maybe there will be a
config option to not compile it later, or there will be an "EVMS-lite"
which handles basic partitions, or whatever.

In any case, I doubt an EVMS patch would be accepted if it removed that
code to start with.  HOWEVER, since EVMS can handle ALL disk devices,
even just regular partitions, at some point it COULD be possible to get
rid of the mess of different major/minor numbers for different disk types
(hdX, sdX, cciss, rd, ida, etc) and assign all of them to EVMS.  Since EVMS
only needs a minor number for the end-result volume (which may represent
many individual disks, and doesn't need a minor for unused partitions),
we would likely not have any shortage of block major numbers.  Consider
10*hdX*256 + 8*sdX*256 + MD*256 + 8*CCISS*256 + 8*DAC960*256 + 8*IDA*256...
and it is a long time until you have 10k+ VISIBLE volumes on a single system.

> > - The AIX LVM on-disk metadata layout is FAR more robust than the current
> >   LVM metadata layout.  While this is supposed to be fixed for Linux-LVM
> >   at some point, the previous Linux-LVM changes have been TERRIBLE with
> >   respect to compatibility, while EVMS is DESIGNED to support multiple
> >   on-disk metadata layouts.
> 
> Yes, because it is a Meta-LVM, not an actualy inplementation.
> I _really_ want something like that in 2.5 - but not this horrible IBM
> implementation.

Maybe you can help them work on it?  They have recently just redone a lot
of the code, partly based on input from Andrew Clausen.  I don't see any
other similar projects out there, and I think it is a waste of effort to
complain about work that is done rather than fix it.  I tried for a long
time (while it was still my job to do so) to fix the current Linux-LVM
code, and I only had very minimal impact.  Even so, Linux-LVM will never
become a Meta-LVM without AT LEAST as much "mess" as EVMS, and probably
will contain a lot more.

IBM is at least doing something about this by putting their code where
their mouth is.  Nothing is ever perfect.  Consider MD RAID - it isn't
even compatible between "stock" 2.2 and 2.2+Mingo-0.9RAID patches (which
is one reason why Alan never accepted the 0.9 MD RAID into 2.2, despite the
fact that ALL distros used the 0.9 MD RAID patches).  With a framework like
EVMS it is possible to have both of the on-disk formats supported, and
migrate from one to the next (maybe even while the system is in use), and
then unload the module that supports the old format.

> > (*) While the exact on-disk layout of each RAID implementation may vary
> > slightly (block sizes, stripe widths, etc), I'm guessing that the majority
> > of it is common enough that we can re-use the existing MD code (parity
> > calculation, resync, etc) to handle most kinds of RAID-0/1/5 setups.
> 
> Nope - I'm currently working on implementing VxVM support, and I have
> to redo all the RAID stuff because it is so incomaptible.

The question is - will the VxVM support be yet ANOTHER separate code base
in the kernel?  You complain about code bloat in EVMS, but having LVM, MD,
VxVM, NT LDM, etc. all separate is also code bloat, and each one needs
separate admin tools.  Remember - EVMS is also modular, so you only need
the support for "LVM" types that you use.  The real benefit, however, is
that since it is integrated, you _could_ cleanly migrate from Linux-LVM
and/or MD-RAID and/or NT-LDM to whatever you wanted (maybe even on a live
system) if EVMS is handling all of the kernel interfaces for them.  I don't
think you could ever do that without full backup/restore on separate tools.

> If you have a design to share the RAID engine for very different layouts:
> nice - but I don'T see the relation to EVMS.

No, I can't say I do - it was purely speculation based on the concept that
RAID-1 and RAID-5 are GENERALLY the same concept.  Maybe the reason VxVM
is so different is that it also incorporates "LVM" style function as well?
Note that NT-LDM ALSO has RAID-0/1/5 modes (not yet supported by the LDM
driver) which will eventually need support.  Do you want the number of RAID
implementations in the kernel to grow without bound, or rather try and
consolidate them (where possible) into a generic interface like EVMS?

Again, if EVMS is the VFS of block devices, then we can consolidate RAID
code into a single place.  Yes, there may be RAID layouts that are too
different from the common code, but hopefully we will avoid duplication
for EACH new layout that we need to support.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

