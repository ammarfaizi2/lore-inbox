Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272549AbRIKT5g>; Tue, 11 Sep 2001 15:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272558AbRIKT51>; Tue, 11 Sep 2001 15:57:27 -0400
Received: from ns.caldera.de ([212.34.180.1]:26243 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S272549AbRIKT5T>;
	Tue, 11 Sep 2001 15:57:19 -0400
Date: Tue, 11 Sep 2001 21:57:35 +0200
From: Christoph Hellwig <hch@caldera.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IBMs LVM ?
Message-ID: <20010911215735.A14883@caldera.de>
In-Reply-To: <3B9E255C.8943D6BB@uni-mb.si> <200109111526.f8BFQLr25266@ns.caldera.de> <20010911115713.D29347@turbolinux.com> <20010911200633.A5816@caldera.de> <20010911131531.E29347@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010911131531.E29347@turbolinux.com>; from adilger@turbolabs.com on Tue, Sep 11, 2001 at 01:15:31PM -0600
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2001 at 01:15:31PM -0600, Andreas Dilger wrote:
> Well, you don't get anything for free.  You need to have some abstraction
> in order to handle multiple LVM-type systems in a useful way, I don't see
> any way around that.  As for the kernel code, I don't see TOO much
> abstraction.
> 
> - You need code to read each separate on-disk format (partition headers,
>   LVM metadata, etc)
> - You need code to combine each of these into some useful "volume"
> - You need code to do mapping from input volume/block to output disk/block
> - You need code to be able to modify a volume metadata.

Yupp.


> You need code to do this for each different metadata format or partition
> type.  Luckily (hopefully?) most people won't have systems with more than
> a couple different metadata formats at a time.  HOWEVER, you NEED to be
> able to migrate from one format to another, so you will have periods when
> you have extra modules loaded during a migration.

No - there is no reason we need support for migration in our volume
managment system.  The reason to have a framework is excatly that we
can have multiple different formats.  If there is a tool to provide
migration it's nice, but it shouldn't complicate the actual volume
managment core.

> > god-mode that allows even root to do anything and we come back.
> 
> It is not clear if you are you for or against "god-mode"?  Would you
> like it so that it is easy to shoot themselves in the head (or it
> is so complex/manual that it is hard not to), or rather everyone in
> straight-jackets in rubber rooms (ala Windows)?  Some safety is needed,
> but there are also reasons to bypass that safety.  I don't know what
> the current state of "god-mode" is in the EVMS code (if it is there,
> needed, whatever, so it is a moot point).

In unix we have the useruser (or more precise the capabilities model),
no need for a damn god mode.

> Exactly.  It was me and the EVMS LVM-emulation author that pointed out to
> the Sistina folks that there was NO need to have an incompatible change
> to the on-disk layout.  In fact, the EVMS code can handle BOTH formats,
> and did so before LVM did.

Of course they don't, but Sistina doesn't like staying with one version
more than a few month.  See my compat code to support 0.8 volumes on 0.9
that got rejected.

> But, strangely it didn't make it into the LVM codebase.  Why is that?

Why didn't all your nice stuff get merged? :P

> I'm not blaming you, of course.  EVMS is at least a SourceForge project.

With the problem that the IBM guys ignore me since someone told them that
I'm "not part of the OpenSource movement".  I started sending fixes in
the very beginning..

> Well, there are obvious reasons for that.  Some people won't want to have
> EVMS in the kernel (clearly you are one of them), so their patch can't
> just rip out the existing partition scanning code.  Maybe there will be a
> config option to not compile it later, or there will be an "EVMS-lite"
> which handles basic partitions, or whatever.

The naming doesn't matter.  (BTW, EVMS is a damn stupid name..).
Either we do the - as you say - VFS for blockdevices or we don't - it doesn't
make sense to do it conditional.  Wether the complicated drivers are actually
use, and wether people want to use the integrated userspace soloutions is
a very different question.

> 
> In any case, I doubt an EVMS patch would be accepted if it removed that
> code to start with.

I think such an patch would be accepted much more likely.  You know Linus
(and we all :)) likes ripping out code.

If you come and say: this patch nukes all special cases for MD, LVM and
partition handling, the code is now X lines less I bet he will like it.

> HOWEVER, since EVMS can handle ALL disk devices,

A few days I read that thread on the EVMS list about only detecting
SCSI and IDE drives yet - I probably got that wrong?..

> even just regular partitions, at some point it COULD be possible to get
> rid of the mess of different major/minor numbers for different disk types
> (hdX, sdX, cciss, rd, ida, etc) and assign all of them to EVMS.  Since EVMS
> only needs a minor number for the end-result volume (which may represent
> many individual disks, and doesn't need a minor for unused partitions),
> we would likely not have any shortage of block major numbers.  Consider
> 10*hdX*256 + 8*sdX*256 + MD*256 + 8*CCISS*256 + 8*DAC960*256 + 8*IDA*256...
> and it is a long time until you have 10k+ VISIBLE volumes on a single system.

Yes, that's a nice thing and in fact linux already posted his opinion
about all disk drivers sharing the major numbers (for 2.5?).

But that just needs a small assignement layer (like sound_core), not
something as complex as EVMS.  Or a bugfree devfs.

> 
> > Yes, because it is a Meta-LVM, not an actualy inplementation.
> > I _really_ want something like that in 2.5 - but not this horrible IBM
> > implementation.
> 
> Maybe you can help them work on it?

If they stop ignoring me - sure.

> They have recently just redone a lot
> of the code, partly based on input from Andrew Clausen.  I don't see any
> other similar projects out there, and I think it is a waste of effort to
> complain about work that is done rather than fix it.  I tried for a long
> time (while it was still my job to do so) to fix the current Linux-LVM
> code, and I only had very minimal impact.  Even so, Linux-LVM will never
> become a Meta-LVM without AT LEAST as much "mess" as EVMS, and probably
> will contain a lot more.

Linux-LVM doesn't even try to be a "Meta-LVM".

> 
> IBM is at least doing something about this by putting their code where
> their mouth is.  Nothing is ever perfect.  Consider MD RAID - it isn't
> even compatible between "stock" 2.2 and 2.2+Mingo-0.9RAID patches (which
> is one reason why Alan never accepted the 0.9 MD RAID into 2.2, despite the
> fact that ALL distros used the 0.9 MD RAID patches).

It's a different issue.  For 2.4 ti sould be very easy to support both,
2.2 is missing a generic block remapping interface.

> > Nope - I'm currently working on implementing VxVM support, and I have
> > to redo all the RAID stuff because it is so incomaptible.
> 
> The question is - will the VxVM support be yet ANOTHER separate code base
> in the kernel?

Of course I plug into one of the many generic volume managment frameworks
that are available - that's why we have this thread, heh?

> You complain about code bloat in EVMS, but having LVM, MD,
> VxVM, NT LDM, etc. all separate is also code bloat,

I think al these are together smaller than EVMS.
At lest they don't have their own 200k linked list implementation :P

> > If you have a design to share the RAID engine for very different layouts:
> > nice - but I don'T see the relation to EVMS.
> 
> No, I can't say I do - it was purely speculation based on the concept that
> RAID-1 and RAID-5 are GENERALLY the same concept.  Maybe the reason VxVM
> is so different is that it also incorporates "LVM" style function as well?

Yes.  It has a completly different layering.  FreeBSD Vinum has a structure
that is somewhat similar if you want to take a look at another opensource
project.

> Note that NT-LDM ALSO has RAID-0/1/5 modes (not yet supported by the LDM
> driver) which will eventually need support.  Do you want the number of RAID
> implementations in the kernel to grow without bound, or rather try and
> consolidate them (where possible) into a generic interface like EVMS?

You forgot ATA fakeraid by arjan :)

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
