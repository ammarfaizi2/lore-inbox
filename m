Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbUCQVVf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 16:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbUCQVVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 16:21:35 -0500
Received: from magic.adaptec.com ([216.52.22.17]:34714 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S262073AbUCQVTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 16:19:08 -0500
Message-ID: <4058C089.9060603@adaptec.com>
Date: Wed, 17 Mar 2004 14:18:01 -0700
From: Scott Long <scott_long@adaptec.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.4) Gecko/20030817
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-raid@vger.kernel.org,
       "Gibbs, Justin" <justin_gibbs@adaptec.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: "Enhanced" MD code avaible for review
References: <459805408.1079547261@aslan.scsiguy.com> <4058A481.3020505@pobox.com>
In-Reply-To: <4058A481.3020505@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Justin T. Gibbs wrote:
>  > [ I tried sending this last night from my Adaptec email address and have
>  >   yet to see it on the list.  Sorry if this is dup for any of you. ]
> 
> Included linux-kernel in the CC (and also bounced this post there).
> 
> 
>  > For the past few months, Adaptec Inc, has been working to enhance MD.
> 
> The FAQ from several corners is going to be "why not DM?", so I would
> humbly request that you (or Scott Long) re-post some of that rationale
> here...
> 
> 
>  > The goals of this project are:
>  >
>  >       o Allow fully pluggable meta-data modules
> 
> yep, needed
> 
> 
>  >       o Add support for Adaptec ASR (aka HostRAID) and DDF
>  >         (Disk Data Format) meta-data types.  Both of these
>  >         formats are understood natively by certain vendor
>  >         BIOSes meaning that arrays can be booted from transparently.
> 
> yep, needed
> 
> For those who don't know, DDF is particularly interesting.  A storage
> industry association, "SNIA", has gotten most of the software and
> hardware RAID folks to agree on a common, vendor-neutral on-disk format.
>   Pretty historic, IMO :)  Since this will be appearing on most of the
> future RAID hardware, Linux users will be left out in a big way if this
> isn't supported.
> 
> EARLY DRAFT spec for DDF was posted on snia.org at
> http://www.snia.org/tech_activities/ddftwg/DDFTrial-UseDraft_0_45.pdf
> 
> 
>  >       o Improve the ability of MD to auto-configure arrays.
> 
> hmmmm.  Maybe in my language this means "improve ability for low-level
> drivers to communicate RAID support to upper layers"?
> 

No, this is full auto-configuration support at boot-time, and when
drives are hot-added.  I think that you comment applies to the next
item, and yes, you are correct.

> 
>  >       o Support multi-level arrays transparently yet allow
>  >         proper event notification across levels when the
>  >         topology is known to MD.
> 
> I'll need to see the code to understand what this means, much less
> whether it is needed ;-)
> 
> 
>  >       o Create a more generic "work item" framework which is
>  >         used to support array initialization, rebuild, and
>  >         verify operations as well as miscellaneous tasks that
>  >         a meta-data or RAID personality may need to perform
>  >         from a thread context (e.g. spare activation where
>  >         meta-data records may need to be sequenced carefully).
> 
> This is interesting.  (guessing) sort of like a pluggable finite state
> machine?
> 

More or less, yes.  We needed a way to bridge the gap from an error
being reported in an interrupt context to being able to allocate memory
and do blocking I/O from a thread context.  The md_error() interface
already existed to do this, but was way too primitive for our needs.  It
had no way to handle cascading or compound events.

> 
>  >       o Modify the MD ioctl interface to allow the creation
>  >         of management utilities that are meta-data format
>  >         agnostic.
> 
> I'm thinking that for 2.6, it is much better to use a more tightly
> defined interface via a Linux character driver.  Userland write(2)'s
> packets of data (h/w raid commands or software raid configuration
> commands), and read(2)'s the responses.
> 
> ioctl's are a pain for 32->64-bit translation layers.  Using a
> read/write interface allows one to create an interface that requires no
> translation layer -- a big deal for AMD64 and IA32e processors moving
> forward -- and it also gives one a lot more control over the interface.
> 

I'm not exactly sure what the difference is here.  Both the ioctl and 
read/write paths copy data in and out of the kernel.  The ioctl
method is a little bit easier since you don't have to stream in a chunk
of data before knowing what to do with it.  ANd I also don't see how
read/write protect you from endian and 64/32-bit issues better than
ioctl.  If you write your code cleanly and correctly, it's a moot point.

> See, we need what I described _anyway_, as a chrdev-based interface to
> sending and receiving ATA taskfiles or SCSI cdb's.
> 
> It would be IMO simple to extend this to a looks-a-lot-like-ioctl
> raid_op interface.
> 
> 
>  > A snapshot of this work is now available here:
>  >
>  >       http://people.freebsd.org/~gibbs/linux/SRC/emd-0.7.0-tar.gz
> 
> Your email didn't say...  this appears to be for 2.6, correct?
> 
> 
>  > This snapshot includes support for RAID0, RAID1, and the Adaptec
>  > ASR and DDF meta-data formats.  Additional RAID personalities and
>  > support for the Super90 and Super 1 meta-data formats will be added
>  > in the coming weeks, the end goal being to provide a superset of
>  > the functionality in the current MD.
> 
> groovy
> 
> 
>  > Since the current MD notification scheme does not allow MD to receive
>  > notifications unless it is statically compiled into the kernel, we
>  > would like to work with the community to develop a more generic
>  > notification scheme to which modules, such as MD, can dynamically
>  > register.  Until that occurs, these EMD snapshots will require at
>  > least md.c to be a static component of the kernel.
> 
> You would just need a small stub that holds a notifier pointer, yes?
> 

I think that we are flexible on this.  We have an implementation from
several years ago that records partition type information and passes it
around in the notification message so that consumers can register for
distinct types of disks/partitions/etc.  Our needs aren't that complex,
but we would be happy to share it anyways since it is useful.

> 
>  > Architectural Notes
>  > ===================
>  > The major areas of change in "EMD" can be categorized into:
>  >
>  > 1) "Object Oriented" Data structure changes
>  >
>  >       These changes are the basis for allowing RAID personalities
>  >       to transparently operate on "disks" or "arrays" as member
>  >       objects.  While it has always been possible to create
>  >       multi-level arrays in MD using block layer stacking, our
>  >       approach allows MD to also stack internally.  Once a given
>  >       RAID or meta-data personality is converted to the new
>  >       structures, this "feature" comes at no cost.  The benefit
>  >       to stacking internally, which requires a meta-data format
>  >       that supports this, is that array state can propagate up
>  >       and down the topology without the loss of information
>  >       inherent in using the block layer to traverse levels of an
>  >       array.
> 
> I have a feeling that consensus will prefer that we fix the block layer,
> and then figure out the best way to support "automatic stacking" --
> since DDF and presumeably other RAID formats will require automatic
> setup of raid0+1, etc.
> 
> Are there RAID-specific issues here, that do not apply to e.g.
> multipathing, which I've heard needs more information at the block layer?
> 

No, the issue is, how do you propagate events through the block layer?
EIO/EINVAL/etc error codes just don't cut it.  Also, many metadata 
formats are unified, in that even though the arrays are stacked, the
metadata sees the entire picture.  Updates might need to touch every 
disk in the compound array, not just a certain sub-array.

The stacking that we do internal to MD is still fairly clean and doesn't
prevent one from stacking outside of MD.

> 
>  > 2) Opcode based interfaces.
>  >
>  >       Rather than add additional method vectors to either the
>  >       RAID personality or meta-data personality objects, the new
>  >       code uses only a few methods that are parameterized.  This
>  >       has allowed us to create a fairly rich interface between
>  >       the core and the personalities without overly bloating
>  >       personality "classes".
> 
> Modulo what I said above, about the chrdev userland interface, we want
> to avoid this.  You're already going down the wrong road by creating
> more untyped interfaces...
> 
> static int raid0_raidop(mdk_member_t *member, int op, void *arg)
> {
>          switch (op) {
>          case MDK_RAID_OP_MSTATE_CHANGED:
> 
> The preferred model is to create a single marshalling module (a la
> net/core/ethtool.c) that converts the ioctls we must support into a
> fully typed function call interface (a la struct ethtool_ops).
> 

These OPS don't exist soley for the userland ap.  They also exist for
communicating between the raid transform and metadata modules.

> 
>  > 3) WorkItems
>  >
>  >       Workitems provide a generic framework for queuing work to
>  >       a thread context.  Workitems include a "control" method as
>  >       well as a "handler" method.  This separation allows, for
>  >       example, a RAID personality to use the generic sync handler
>  >       while trapping the "open", "close", and "free" of any sync
>  >       workitems.  Since both handlers can be tailored to the
>  >       individual workitem that is queued, this removes the need
>  >       to overload one or more interfaces in the personalities.
>  >       It also means that any code in MD can make use of this
>  >       framework - it is not tied to particular objects or modules
>  >       in the system.
> 
> Makes sense, though I wonder if we'll want to make this more generic.
> hardware RAID drivers might want to use this sort of stuff internally?
> 

If you want to make it into a more generic kernel service, that fine. 
However, I'm not quite sure what kind of work items a hardware raid
driver will need.  The whole point there is to hide what's going on ;-)

> 
>  > 4) "Syncable Volume" Support
>  >
>  >       All of the transaction accounting necessary to support
>  >       redundant arrays has been abstracted out into a few inline
>  >       functions.  With the inclusion of a "sync support" structure
>  >       in a RAID personality's private data structure area and the
>  >       use of these functions, the generic sync framework is fully
>  >       available.  The sync algorithm is also now more like that
>  >       in 2.4.X - with some updates to improve performance.  Two
>  >       contiguous sync ranges are employed so that sync I/O can
>  >       be pending while the lock range is extended and new sync
>  >       I/O is stalled waiting for normal I/O writes that might
>  >       conflict with the new range complete.  The syncer updates
>  >       its stats more frequently than in the past so that it can
>  >       more quickly react to changes in the normal I/O load.  Syncer
>  >       backoff is also disabled anytime there is pending I/O blocked
>  >       on the syncer's locked region.  RAID personalities have
>  >       full control over the size of the sync windows used so that
>  >       they can be optimized based on RAID layout policy.
> 
> interesting.  makes sense on the surface, I'll have to think some more...
> 
> 
>  > 5) IOCTL Interface
>  >
>  >       "EMD" now performs all of its configuration via an "mdctl"
>  >       character device.  Since one of our goals is to remove any
>  >       knowledge of meta-data type in the user control programs,
>  >       initial meta-data stamping and configuration validation
>  >       occurs in the kernel.  In general, the meta-data modules
>  >       already need this validation code in order to support
>  >       auto-configuration, so adding this capability adds little
>  >       to the overall size of EMD.  It does, however, require a
>  >       few additional ioctls to support things like querying the
>  >       maximum "coerced" size of a disk targeted for a new array,
>  >       or enumerating the names of installed meta-data modules,
>  >       etc.
>  >      
>  >       This area of EMD is still in very active development and we expect
>  >       to provide a drop of an "emdadm" utility later this week.  
> 
> I haven't evaluated yet the ioctl interface.  I do understand the need
> to play alongside the existing md interface, but if there are huge
> numbers of additions, it would be preferred to just use the chrdev
> straightaway.  Such a chrdev would be easily portable to 2.4.x kernels
> too :)
> 
> 
>  > 7) Correction of RAID0 Transform
>  >
>  >       The RAID0 transform's "merge function" assumes that the
>  >       incoming bio's starting sector is the same as what will be
>  >       presented to its make_request function.  In the case of a
>  >       partitioned MD device, the starting sector is shifted by
>  >       the partition offset for the target offset.  Unfortunately,
>  >       the merge functions are not notified of the partition
>  >       transform, so RAID0 would often reject requests that span
>  >       "chunk" boundaries once shifted.  The fix employed here is
>  >       to determine if a partition transform will occur and take
>  >       this into account in the merge function.
> 
> interesting
> 
> 
>  > Adaptec is currently validating EMD through formal testing while
>  > continuing the build-out of new features.  Our hope is to gather
>  > feedback from the Linux community and adjust our approach to satisfy
>  > the community's requirements.  We look forward to your comments,
>  > suggestions, and review of this project.
> 
> Thanks much for working with the Linux community.
> 
> One overall comment on merging into 2.6:  the patch will need to be
> broken up into pieces.  It's OK if each piece is dependent on the prior
> one, and it's OK if there are 20, 30, even 100 pieces.  It helps a lot
> for review to see the evolution, and it also helps flush out problems
> you might not have even noticed.  e.g.
>         - add concept of member, and related helper functions
>         - use member functions/structs in raid drivers raid0.c, etc.
>         - fix raid0 transform
>         - add ioctls needed in order for DDF to be useful
>         - add DDF format
>         etc.
> 

We can provide our Perforce changelogs (just like we do for SCSI).

Scott

