Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbUC0Pk0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 10:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbUC0PkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 10:40:25 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:5058 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261794AbUC0PkE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 10:40:04 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
To: linux-kernel@vger.kernel.org, "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: "Enhanced" MD code avaible for review
Date: Sat, 27 Mar 2004 09:39:29 -0600
User-Agent: KMail/1.6
Cc: Jeff Garzik <jgarzik@pobox.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-raid@vger.kernel.org, dm-devel@redhat.com
References: <760890000.1079727553@aslan.btc.adaptec.com> <200403261315.20213.kevcorry@us.ibm.com> <1644340000.1080333901@aslan.btc.adaptec.com>
In-Reply-To: <1644340000.1080333901@aslan.btc.adaptec.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403270939.29164.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 March 2004 2:45 pm, Justin T. Gibbs wrote:
> We don't have control over the meta-data formats being used by the
> industry. Coming up with a solution that only works for "Linux Engineered
> Meta-data formats" removes any possibility of supporting things like DDF,
> Adaptec ASR, and a host of other meta-data formats that can be plugged into
> things like EMD.  In the two cases we are supporting today with EMD, the
> records required for doing discovery reside in the same sectors as those
> that need to be updated at runtime from some "in-core" context.

Well, there's certainly no guarantee that the "industry" will get it right. In
this case, it seems that they didn't. But even given that we don't have ideal
metadata formats, it's still possible to do discovery and a number of other
management tasks from user-space.

> > The main point I'm trying to get across here is that DM provides a simple
> > yet extensible kernel framework for a variety of storage management
> > tasks, including a lot more than just RAID. I think it would be a huge
> > benefit for the RAID drivers to make use of this framework to provide
> > functionality beyond what is currently available.
>
> DM is a transform layer that has the ability to pause I/O while that
> transform is updated from userland.  That's all it provides.

I think the DM developers would disagree with you on this point.

> As such, 
> it is perfectly suited to some types of logical volume management
> applications.  But that is as far as it goes.  It does not have any
> support for doing "sync/resync/scrub" type operations or any generic
> support for doing anything with meta-data.

The core DM driver would not and should not be handling these operations.
These are handled in modules specific to one type of mapping. There's no
need for the DM core to know anything about any metadata. If one particular
module (e.g. dm-mirror) needs to support one or more metadata formats, it's
free to do so.

On the other hand, DM *does* provide services that make "sync/resync" a great
deal simpler for such a module. It provides simple services for performing
synchronous or asynchronous I/O to pages or vm areas. It provides a service
for performing copies from one block-device area to another. The dm-mirror
module uses these for this very purpose. If we need additional "libraries"
for common RAID tasks (e.g. parity calculations) we can certainly add them.

> In all of the examples you 
> have presented so far, you have not explained how this part of the equation
> is handled.  Sure, adding a member to a RAID1 is trivial.  Just pause the
> I/O, update the transform, and let it go.  Unfortunately, that new member
> is not in sync with the rest.  The transform must be aware of this and only
> trust the member below the sync mark.  How is this information communicated
> to the transform?  Who updates the sync mark?  Who copies the data to the
> new member while guaranteeing that an in-flight write does not occur to the
> area being synced?

Before the new disk is added to the raid1, user-space is responsible for
writing an initial state to that disk, effectively marking it as completely
dirty and unsynced. When the new table is loaded, part of the "resume" is for
the module to read any metadata and do any initial setup that's necessary. In
this particular example, it means the new disk would start with all of its
"regions" marked "dirty", and all the regions would need to be synced from
corresponding "clean" regions on another disk in the set.

If the previously-existing disks were part-way through a sync when the table
was switched, their metadata would indicate where the current "sync mark" was
located. The module could then continue the sync from where it left off,
including the new disk that was just added. When the sync completed, it might
have to scan back to the beginning of the new disk to see if had any remaining
dirty regions that needed to be synced before that disk was completely clean.

And of course the I/O-mapping path just has to be smart enough to know which
regions are dirty and avoid sending live I/O to those.

(And I'm sure Joe or Alasdair could provide a better in-depth explanation of 
the current dm-mirror module than I'm trying to. This is obviously a very 
high-level overview.)

This process is somewhat similar to how dm-snapshot works. If it reads an 
empty header structure, it assumes it's a new snapshot, and starts with an 
empty hash table. If it reads a previously existing header, it continues to 
read the on-disk COW tables and constructs the necessary in-memory hash-table 
to represent that initial state.

> If you intend to add all of this to DM, then it is no 
> longer any "simpler" or more extensible than EMD.

Sure it is. Because very little (if any) of this needs to affect the core DM
driver, that core remains as simple and extensible as it currently is. The
extra complexity only really affects the new modules that would handle RAID.

> Don't take my arguments the wrong way.  I believe that DM is useful
> for what it was designed for: LVM.  It does not, however, provide the
> machinery required for it to replace a generic RAID stack.  Could
> you merge a RAID stack into DM.  Sure.  Its only software.  But for
> it to be robust, the same types of operations MD/EMD perform in kernel
> space will have to be done there too.
>
> The simplicity of DM is part of why it is compelling.  My belief is that
> merging RAID into DM will compromise this simplicity and divert DM from
> what it was designed to do - provide LVM transforms.

I disagree. The simplicity of the core DM driver really isn't at stake here.
We're only talking about adding a few relatively complex target modules. And
with DM you get the benefit of a very simple user/kernel interface.

> As for RAID discovery, this is the trivial portion of RAID.  For an extra
> 10% or less of code in a meta-data module, you get RAID discovery.  You
> also get a single point of access to the meta-data, avoid duplicated code,
> and complex kernel/user interfaces.  There seems to be a consistent feeling
> that it is worth compromising all of these benefits just to push this 10%
> of the meta-data handling code out of the kernel (and inflate it by 5 or
> 6 X duplicating code already in the kernel).  Where are the benefits of
> this userland approach?

I've got to admit, this whole discussion is very ironic. Two years ago I
was exactly where you are today, pushing for in-kernel discover, a variety of 
metadata modules, internal opaque device stacking, etc, etc. I can only
imagine that hch is laughing his ass off now that I'm the one arguing for
moving all this stuff to user-space.

I don't honestly expect to suddenly change your mind on all these issues.
A lot of work has obviously gone into EMD, and I definitely know how hard it
can be when the community isn't greeting your suggestions with open arms. And
I'm certainly not saying the EMD method isn't a potentially viable approach.
But it doesn't seem to be the approach the community is looking for. We faced
the same resistance two years ago. It took months of arguing with the 
community and arguing amongst ourselves before we finally decided to move 
EVMS to user-space and use MD and DM. It was a decision that meant 
essentially throwing away an enormous amount of work from several people. It 
was an incredibly hard choice, but I really believe now that it was the right
decision. It was the direction the community wanted to move in, and the only
way for our project to truely survive was to move with them.

So feel free to continue to develop and promote EMD. I'm not trying to stop
you and I don't mind having competition for finding the best way to do RAID
in Linux. But I can tell you from experience that EMD is going to face a good
bit of opposition based on its current design and you might want to take that
into consideration.

I am interested in discussing if and how RAID could be supported under
Device-Mapper (or some other "merging" of these two drivers). Jeff and Lars
have shown some interest, and I certainly hope we can convince Neil and Joe
that this is a good direction. Maybe it can be done and maybe it can't. I
personally think it can be, and I'd at least like to have that discussion
and find out.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/
