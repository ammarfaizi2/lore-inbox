Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262990AbUCXC1J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 21:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbUCXC1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 21:27:09 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:28051 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262961AbUCXC05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 21:26:57 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Date: Wed, 24 Mar 2004 13:26:47 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16480.61927.863086.637055@notabene.cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: "Enhanced" MD code avaible for review
In-Reply-To: message from Justin T. Gibbs on Monday March 22
References: <760890000.1079727553@aslan.btc.adaptec.com>
	<16479.50592.944904.708098@notabene.cse.unsw.edu.au>
	<2128160000.1080023015@aslan.btc.adaptec.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday March 22, gibbs@scsiguy.com wrote:
> >> o Any successful solution will have to have "meta-data modules" for
> >>   active arrays "core resident" in order to be robust.  This
> 
> ...
> 
> > I agree.
> > 'Linear' and 'raid0' arrays don't really need metadata support in the
> > kernel as their metadata is essentially read-only.
> > There are interesting applications for raid1 without metadata, but I
> > think that for all raid personalities where metadata might need to be
> > updated in an error condition to preserve data integrity, the kernel
> > should know enough about the metadata to perform that update.
> > 
> > It would be nice to keep the in-kernel knowledge to a minimum, though
> > some metadata formats probably make that hard.
> 
> Can you further explain why you want to limit the kernel's knowledge
> and where you would separate the roles between kernel and userland?

General caution.
It is generally harder the change mistakes in the kernel than it is to
change mistakes in userspace, and similarly it is easer to add
functionality and configurability in userspace.  A design that puts
the control in userspace is therefore preferred.  A design that ties
you to working through a narrow user-kernel interface is disliked.
A design that gives easy control to user-space, and allows the kernel
to do simple things simply is probably best.

I'm not particularly concerned with code size and code duplication.  A
clean, expressive design is paramount.

> 2) Solution Complexity
> 
> Two entities understand how to read and manipulate the meta-data.
> Policies and APIs must be created to ensure that only one entity
> is performing operations on the meta-data at a time.  This is true
> even if one entity is primarily a read-only "client".  For example,
> a meta-data module may defer meta-data updates in some instances
> (e.g. rebuild checkpointing) until the meta-data is closed (writing
> the checkpoint sooner doesn't make sense considering that you should
> restart your scrub, rebuild or verify if the system is not safely
> shutdown).  How does the userland client get the most up-to-date
> information?  This is just one of the problems in this area.

If the kernel and userspace both need to know about metadata, then the
design must make clear how they communicate.  

> 
> > Currently partitions are (sufficiently) needs-driven.  It is true that
> > any partitionable devices has it's partitions presented.  However the
> > existence of partitions does not affect access to the whole device at
> > all.  Only once the partitions are claimed is the whole-device
> > blocked. 
> 
> This seems a slight digression from your earlier argument.  Is your
> concern that the arrays are auto-enumerated, or that the act of enumerating
> them prevents the component devices from being accessed (due to
> bd_clam)?

Primarily the latter.  But also that the act of enumerating them may
cause an update to an underlying devices (e.g. metadata update or
resync).  That is what I am particularly uncomfortable about.

> 
> > Providing that auto-assembly of arrays works the same way (needs
> > driven), I am happy for arrays to auto-assemble.
> > I happen to think this most easily done in user-space.
> 
> I don't know how to reconcile a needs based approach with system
> features that require arrays to be exported as soon as they are
> detected.
> 

Maybe if arrays were auto-assembled in a read-only mode that guaranteed
not to write to the devices *at*all* and did not bd_claim them.

When they are needed (either though some explicit set-writable command
or through an implicit first-write) then the underlying components are
bd_claimed.  If that succeeds, the array becomes "live".  If it fails,
it stays read-only.

> 
> > But back to your original post:  I suspect there is lots of valuable
> > stuff in your emd patch, but as you have probably gathered, big
> > patches are not the way we work around here, and with good reason.
> > 
> > If you would like to identify isolated pieces of functionality, create
> > patches to implement them, and submit them for review I will be quite
> > happy to review them and, when appropriate, forward them to
> > Andrew/Linus.
> > I suggest you start with less controversial changes and work your way
> > forward.
> 
> One suggestion that was recently raised was to present these changes
> in the form of an alternate "EMD" driver to avoid any potential
> breakage of the existing MD.  Do you have any opinion on this?

Choice is good.  Competition is good.  I would not try to interfere
with you creating a new "emd" driver that didn't interfere with "md". 
What Linus would think of it I really don't know.  It is certainly not
impossible that he would accept it.

However I'm not sure that having three separate device-array systems
(dm, md, emd) is actually a good idea.  It would probably be really
good to unite md and dm somehow, but no-one seems really keen on
actually doing the work.

I seriously think the best long-term approach for your emd work is to
get it integrated into md.  I do listen to reason and I am not
completely head-strong, but I do have opinions, and you would need to
put in the effort to convincing me.

NeilBrown

