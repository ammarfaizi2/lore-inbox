Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275857AbRJULlf>; Sun, 21 Oct 2001 07:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275861AbRJULl0>; Sun, 21 Oct 2001 07:41:26 -0400
Received: from calais.pt.lu ([194.154.192.52]:7628 "EHLO calais.pt.lu")
	by vger.kernel.org with ESMTP id <S275857AbRJULlQ>;
	Sun, 21 Oct 2001 07:41:16 -0400
Message-Id: <200110211136.f9LBa9B17801@hitchhiker.org.lu>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, kamil@science.uva.nl, adilger@turbolabs.com,
        vherva@niksula.hut.fi, nleroy@cs.wisc.edu, davidsen@tmr.com,
        viro@math.psu.edu, andrea@suse.de, landley@trommello.org,
        manfred@colorfullife.com
Reply-To: alain@linux.lu
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Re: Poor floppy performance in kernel 2.4.10
Date: Sun, 21 Oct 2001 13:36:09 +0200
From: Alain Knaff <Alain.Knaff@hitchhiker.org.lu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for joining this discussion so late, but I only check
linux-kernel only about once or twice a week.

Rather than responding to each message individually, here's a small
summary about my take on the issues:

Andreas Dilger writes:
>In the case of a floppy drive, this is very important, as you don't
>want to be cacheing data from one floppy after you have inserted a new
>floppy.

Actually, the floppy drive is able to detect disk changes just fine,
and since 1.0's the disk change signal (DCL) has been used to trigger
cache flushing.

Ville Herva wrote:
>That's propably beacause it syncs the writes on close(). 

This is done for the benefit of those OS'es that don't automatically
sync() removeable media on last close. On Linux this is not necessary
(or at least, it wasn't when I last looked at the code, but that's a
long while ago...), but it is not harmful either: even though the sync
would hold up mtools for a while, the close would go through much
faster, as the work already will have done. And besides, as far as I
understood, Kamil was speaking about read performance, where the sync
would be a non-issue.

Nick LeRoy wrote:
>Perhaps there should be a pair of "mtools" added: mopen and mclose, that do 
>basically this. That way it could be a "standard" item, documented in man 
>pages, etc., not some secret that only the l-k users know. Thoughts? 

A nice workaround. However, personnally I'd rather have this fixed in
the kernel, rather than having to resort to those kinds of
workarounds. Moreover, this is potentially dangerous: it could
actually mask a real disk change, if the user forgets the mclose.  The
same holds for other techniques, such as sleep 3600 </dev/fd0 & Btw,
it works now (actual disk change detected, even while the sleep runs),
but who will guarantee it still will work in 2.6 ?

Nevertheless, I'm thinking about introducing this to mtools as a
stop-gap measure, but with ample warnings in the manpage...

Bill Davidsen wrote:
>That said, I have a few other thoughts. First, can't the kernel 
>detect when a new floppy is inserted?

Yes, the kernel (floppy driver) can do this, and indeed it does.

>I can't remember if there is an 
>interupt generated when the floppy seats or not. 

Actually, it is not really an interrupt, but a bit that is set in the
FD_DIR register. It stays set until the floppy disk driver
acknowledges it by seeking the drive, or by selecting/unselecting it.

Before reading from the disk (or whenever it needs to know whether a
disk has been changed or not), the floppy driver reads this bit, and
if set notifies the VFS of the disk change. It then proceeds to seek,
in order to clear this flag (needed in order to detect further
changes)


>I 
>seem to remember that not all drives provide the signal, at least back 
>when I wrote my last floppy driver (DEC Rainbow, about 20 years
ago). 

Yes, very old drives have problems supplying the signal. However, most
_recent_ cases of broken disk change line are due to ... badly
inserted cabled (d'oh). The problem is that the DCL is near the edge
(pin 34, according to http://www.moria.de/~michael/floppy/floppy.ps),
and if the cable is not inserted straight, the other wires may still
make contact, but not the DCL. Hence the drive "appears" to work at
first glance, except for the problem with the cached stale
data. Actually, in the last couple of years, I got less than a dozen
bug reports about a broken disk change line, and those could all be
traced to a badly inserted cable...

A compounding problem is that there are different ways to clear the
DCL signal. Many drives need a seek, but for some drives you can clear
the signal just by selecting/unselecting the drive, which makes it far
too easy to accidentally clear it. This was causing many problems in
the 1.0 days, but has been solved since long ago (by being extra
careful to check the DCL before unselecting a drive. This is also the
major reason for the convolutedness of that part of the code).

Alexander Viro wrote:
>We had been flushing the cache upon final close() for quite a while; recent 
>changes come from something else and figuring out WTF had happened in 2.4.12 
>would be a Good Thing(tm). 

Andrea Arcangeli wrote:
>Indeed, only 2.2 trusted the check media change information and left the 
>cache valid on top of the floppy across close/open of the blkdev. 

You are right: indeed, 2.4.4 seems to have the same problem. If you do
mcopy a:somefile . in a row, the second one is as slow as the first
one!

Only mdir a: seems to behave differently between 2.4.4 (on my laptop)
and 2.4.12 (on my desktop): in 2.4.4 the second one is instantaneous,
whereas in 2.4.12 it is slow.  Possible explanation: mdir reads so few
data that it fits in one track. And the floppy driver has an own
internal "track cache", which caches one track worth of data (needed
for some low-level optimizations, just like the on-board cache of hard
disks). Obviously, the floppy driver itself does not ignore the fact
that the disk has not been changed when deciding whether to flush its
own cache or not. Apparently, it's this particular feature which has
been broken in 2.4.10. I'll have to investigate further to find out
why exactly there is this difference. (I'll probably get around it
next weekend unfortunately, I'm somewhat busy right now).

>if mtools is doing something 
>stupid that sorted out to work ok when partial reads were supported. 

The problem can be easily demonstrated with doing 'cat /dev/fd0 >x'
twice in a row to simulate an mcopy. On both kernels that I tried, the
second one is as slow the first. So I don't think it's related to
mtools per se.

In order to simulate an mdir:
dd if=/dev/fd0 bs=1k count=18 of=/dev/null

Here, the second one is instantaneous on 2.4.4, but slow on
2.4.12. Changing the 18 into 19 makes it slow on both kernels (because
that's now two tracks, rather than one).

However, for the following one, it's fast the second time on both
kernels:
dd if=/dev/fd0 bs=1k count=2 of=/dev/null

Changing 2 into 3 makes it slow on 2.4.12

Maybe, it's some kind of read-ahead issue, that the kernel decides to
internally read much more sectors than fit in one track, which would
"push" the sectors of the first cylinder out of the floppy driver's
internal cache?

Andrea Arcangeli wrote:
>Yes, I was aware of that. We'd need a kind of "media change enabler" 
>bitflag in each lowlevel driver, to implement a blacklist (or whitelist 
>if you feel safer) that will tell us if to trust the media change info 
>or not.

Exactly!

Linus Torvalds wrote:
>And with 
>the floppy case, there was no way to notice at run-time whether the unit 
>was broken or not - the floppy drives have no ID's to blacklist etc.

True. However, we could use an ioctl to instruct the floppy driver,
(which would then instruct the VFS layer) whether it can trust the
disk change line or not.
That way, users with known broken drives can pluck that into their
/etc/rc.d/boot.local
Actually, we do have such a setting right now, it's called BROKEN_DCL
Just to floppycontrol --broken_dcl /dev/fd0 to set it.
Its effect can be easily verified: after doing this, mdir a: is slow
on both kernels...
You can also set it on the boot (LILO) command line: append="floppy=broken_dcl"
The only thing is, right now this is handled locally in the floppy
driver, and not communicated to the VFS. What we would need is a way
to tell the VFS "yes, you _can_ trust check_media_change". Or is there
already such a way?

Rob Landley wrote:
>Also, enough drives do it right (the vast majority), that a 
>"broken_disk_change" module/boot option seems more sensible as a non-default 
>thing for those that really are hosed... 

Surprise! There is such a setting (see above): broken_dcl and it works
as well for module (insmod floppy.o floppy=broken_dcl), as for boot
(see above), as for iotctl.
Only problem: although the floppy driver takes it into account, the
VFS layer seems to happily ignore it...

This happens in the following function, which is called
unconditionnally, whenever the numbers of "openers" (processes having
an open filehandle to the device) drops to zero:

(blkdev_put)
	if (kind == BDEV_FILE)
		__block_fsync(bd_inode);
	else if (kind == BDEV_FS)
		fsync_no_super(rdev);
	if (!--bdev->bd_openers)
		kill_bdev(bdev);


/* Kill _all_ buffers, dirty or not.. */
static void kill_bdev(struct block_device *bdev)
{
	invalidate_bdev(bdev, 1);
	truncate_inode_pages(bdev->bd_inode->i_mapping, 0);
}	

And in the comment for invalidate_bdev, we find the following comment:

   NOTE: In the case where the user removed a removable-media-disk even if
   there's still dirty data not synced on disk (due a bug in the device driver
   or due an error of the user), by not destroying the dirty buffers we could
   generate corruption also on the next media inserted, thus a parameter is
   necessary to handle this case in the most safe way possible (trying
   to not corrupt also the new disk inserted with the data belonging to
   the old now corrupted disk). Also for the ramdisk the natural thing
   to do in order to release the ramdisk memory is to destroy dirty buffers.

So, if the goal is only to catch user and/or driver error, maybe the
same thing could be achieved by _only_ flushing the dirty buffers (and
loudly complaining if it finds any: indeed, because of the call to
__block_fsync(bd_inode); there really shouldn't be any dirty buffers
at this point of time...


Manfred Spraul wrote:
>The standard trick is to start with media-change not supported, and 
>enable it if you get the first change signal. 
>There are really old floppies that don't support media-change signals, 
>and they _never_ send it. If you see a media-change signal, then you 
>know that the floppy is not broken.

Good idea! I'll think about implementing something like that.

Regards,

Alain
