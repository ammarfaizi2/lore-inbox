Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261778AbREPD0p>; Tue, 15 May 2001 23:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261779AbREPD0f>; Tue, 15 May 2001 23:26:35 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:22290 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S261778AbREPD0P>; Tue, 15 May 2001 23:26:15 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Wed, 16 May 2001 13:25:51 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15105.62271.988448.877669@notabene.cse.unsw.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: message from Linus Torvalds on Tuesday May 15
In-Reply-To: <15105.5789.377277.276674@notabene.cse.unsw.edu.au>
	<Pine.LNX.4.21.0105150819420.1802-100000@penguin.transmeta.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday May 15, torvalds@transmeta.com wrote:
> 
> On Tue, 15 May 2001, Neil Brown wrote:
> > 
> > Ofcourse setting the "queue" function that __blk_get_queue call to do
> > a lookup of the minor and choose an appropriate queue for the "real"
> > device wont work as you need to munge bh->b_rdev too.
> 
> What I would do is:
>  - remove b_rdev completely. No driver is actually interested in what the
>    device number is, the only thing they want to use it for is to look up
>    which device index we have (and for doing the partition handling, but
>    as discussed in a completely independent discussion a few months ago,
>    we should handle that as a lvm remapping thing, NOT at the driver
>    level!)
>  - replace is with b_index

Wouldn't 
    struct block_device *b_bdev
be a better choice? (though you would need to fiddle with reference
counts then, so maybe not, I'm not sure).

> 
> > You would still nee to make sure the blk_size[], blksize_size[],
> > hardsect_size[], max_readahead[], max_sectors[] all got handled
> > properly.
> 
> Actually, I htink Jens did most of these, and moved them into a device
> array.
> 

Will this go into 2.4.X anytime soon? or is it 2.5 material?

> > Does the minor number for this "disk" layer have N bits for partition
> > number and 8-N bits (later to be 20-N bits or similar) for device
> > number?
> 
> I'd go with N=8, and only use this for the "new" cases, We've seen that
> N=4 is too small (SCSI), and N=6 (IDE) is already too cramped with a 8-bit
> minor number.

I was assuming that this "disk" device was something that we could do
now, but if N==8, then we need more minor bits before it can be used
effectively, and that means lots of user-space changes doesn't it? So
it won't be in 2.4.

> 
> BUT! Note that when you do the partition handling in get_queue too (and
> thus index is an index to the _device_ and has nothing to do with
> partitions), you can trivially allow different majors to have different
> numbers of partition bits, because the driver no longer cares. This is
> required so that the get_queue remapping can easily handle the legacy
> IDE/SCSI numbers anyway, so it's easyish to just have both at the same
> time - you could have N=4 for a "disk major for old users that need the
> 16-bit device numbers and a single major", with N=8 for the "new style
> major" which doesn't fit in 8 bits.

Uhm.  If I understand you correctly, you are saying that a single
major (the "disk" major) could have different partition sub-divisions
for different minor ranges.  e.g:
 minor 0-15 is partitions of first scsi drive
 minor 16-31 is partitions of second scsi drive
 minor 64-128 is partitions of first IDE drive

Is that what you mean?  I wouldn't want to have to maintain /dev/...

> 
> > Finally, how do I say that I want the root filesystem to be on a
> > particular "mdp" device+partition.  I cannot assume that my device
> > will be the first to register with the "disk" layer, so I cannot be
> > sure that "root=/dev/diska1" will work.
> 
> You have never been able to really assume that. Disks move around. 
> 
> A lot of people seem to think that controller type or location on the PCI
> bus should somehow have some "meaning", and that it guarantees that the
> disks don't move in the namespace. That's crap. You can do that in user
> space ("what controller are you on?") if you really really care.

This is a topic that seems to be generating alot of discussion in these
threads.
Clearly each object (drive, partitions, filesystem, pointer, mouse,
framebuffer...) can potentially have several different names, each of
which may be valid in it's own context.  I think the kernel should
export all names equally without prejudice.

NeilBrown
