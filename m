Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274194AbRJ0SAc>; Sat, 27 Oct 2001 14:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274299AbRJ0SAW>; Sat, 27 Oct 2001 14:00:22 -0400
Received: from calais.pt.lu ([194.154.192.52]:47493 "EHLO calais.pt.lu")
	by vger.kernel.org with ESMTP id <S274194AbRJ0SAF>;
	Sat, 27 Oct 2001 14:00:05 -0400
Message-Id: <200110271800.f9RI0M803440@hitchhiker.org.lu>
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org
Reply-To: alain@linux.lu
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Re: Poor floppy performance in kernel 2.4.10 
In-Reply-To: Your message of "Sat, 27 Oct 2001 13:42:32 EDT."
             <Pine.GSO.4.21.0110271320540.21545-100000@weyl.math.psu.edu> 
Date: Sat, 27 Oct 2001 20:00:22 +0200
From: Alain Knaff <Alain.Knaff@hitchhiker.org.lu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>On Sat, 27 Oct 2001, Alain Knaff wrote:
>
>> Cursory examination of floppy.c (as an example of a block device
>> driver) showed that bdops are also registered using devfs_register and
>> register_disk (what's THAT for?!? Floppies don't have partitions...)
>
>Actually, _that_ is Right Thing(tm) - it should allocate a structure that
>would contain pointer to methods table and would be controlled by
>driver.  devfs_register() would get that + prefered name, etc. so that
>we had a common object.  Then driver would have a point where it could
>tell the rest of kernel that disk is gone.

Register_disk seems to be related to partitions... and is yet another
place where floppy_fops is handed out. And it doesn't seem to have a
corresponding unregister_disk function, so this worries me
somewhat. Who did that, and why didn't he contact me?

>> Apparently, devfs_register allows a direct mapping from the device's
>> name to its driver, without going through its major/minor number.
>> 
>> Thus, a possible solution would be to equip all possible paths leading
>> to the driver's block_device_operations with correct "teardown"
>> function. Thus, not only unregister_blkdev would dump the cache, but
>> also devfs_unregister (maybe near the place in unregister() where
>> de->u.fcb.ops = NULL is done?). Best make this call generic, such as
>
>No go.  We can have situations where some of uses come from devfs and
>some - from normal device nodes.  struct block_device will be the same.

Ok. So maybe some kind of counter? When it drops to zero, dump the
cache?

>> All this begs of course the following question: what kind of
>> idnetifier does the buffer cache code actually use to refer to the
>> block device, if there is no longer a major?
>
>Right now - major:minor, in 2.5 - struct block_device *.

Good. But then, what's the point of devfs=only ? I assumed this was
intended for situations where we had a direct mapping from filename to
device.

Ok, so in 2.5 will be possible with struct block_device, and the
option will make sense.

So, in the interest of stability, shouldn't we (temporarily) disable
this devfs=only stuff in 2.4 ?

>> We could either use bdev->bd_sem (awkward, as many drivers implement
>> multiple bdev's), or a new per-major device lock to protect that
>> section.
>
>I'd rather have refcount raised by get_blkfops().  Again, that code path
>is not a problem.  devfs_get_ops() is.
> 
>> unregister_blkdev would need to acquire the same lock while zero-ing
>> blkdevs[major].bdops.
>
>We could put bdev on per-major cyclic list and have it killed on
>unregister_blkdev().  _That_ is easy.  The trouble being, with devfs
>we don't have a single removal point.  Sometimes it's still
>unregister_blkdev(), sometimes - crapload of devfs_unregister() for
>each minor, sometimes - both.  Worse yet, we have one more place that
>holds pointer to block_device_operations - gendisk.  Also used by
>devfs (and nothing else) and logics is, to put it mildly, fuzzy.
>
>Frankly, at that point I would prefer to remove the code in devfs that
>tries to provide bdev methods by devfs entry.  Rationale:
>	a) it's fucked up beyond any repair
>	b) it will be useless until we switch buffer cache to block_device *
>	c) we will need to change that logics anyway - as it is the thing is
>inherently racy
>	d) right now it stands in the way of long-living cache stuff _and_
>introduces an oopsable race between mount and rmmod.
>

I agree. We could maybe just #ifdef those methods out, so that we
could easily add them back in 2.5 once struct block_device is in
place.

Regards,

Alain
