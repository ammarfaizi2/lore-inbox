Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317026AbSF1Bsy>; Thu, 27 Jun 2002 21:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317030AbSF1Bsx>; Thu, 27 Jun 2002 21:48:53 -0400
Received: from mail.iil.ie ([217.78.0.17]:50703 "HELO
	mail1.internet-ireland.ie") by vger.kernel.org with SMTP
	id <S317026AbSF1Bsv>; Thu, 27 Jun 2002 21:48:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: David Golden <david.golden@unison.ie>
To: linux-kernel@vger.kernel.org
Subject: Removable Media Handling...
Date: Fri, 28 Jun 2002 02:59:06 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020628015026.957E4B636F@mail1.internet-ireland.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Or "/Why I think there should be thingys like block special files named
by disk label./"

My argument does go back to how block devices/block special files are
handled.  It is my humble opinion that a block special file, or something
like one, should represent a particular sort of set of related data blocks -
the set of blocks in a particular disk/partition. Such a set would
typically have a filesystem mounted on top of it.

You may think this is the current situation, but it isn't, really, as
far as I can tell. 

My argument is that there should be a separate block-special-file for
each such set of blocks.   On linux, there's instead a handle
to a different sort of set of blocks consisting of "the set of blocks
currently accessible as block 1,2,3 on drive xdN (or maybe partition
xdNy)"  (Yes, the LVM etc. complicates this a bit, but as far as I can
tell, does not help to resolve the stuff I dislike.)

Now, I may be wrong, but please bear with me - if nothing else, you can
enjoy correcting me.  Please hold off correcting me until you've
read the whole thing... :-)


Worked example:

Imagine two floppy disks. That's two different disks out there in the
physical world, busily avoiding occupying the same space at the same time.
I'll call them FLOX and FLOY.
There is a set of data blocks on FLOX, which I will call SBOX
There is a set of data blocks on FLOY, which I will call SBOY

SBFLOX underlies a filesystem I'lll call FSOX, SBOY underlies a
filesystem I'll call FSOY

Imagine a computer with two floppy drives. I'll call the *drives* DF0
and DF1.  At any particular time, there is sets of blocks accessible
via each of these drives, which I will call SBDF0 and SBDF1

SBFLOX is only the same as SBDF0 when FLOX is in DF0, obviously enough.

When you mount a filesystem under linux, though, you are mounting it on
SBDF0, via a handle in /dev/, which I will call BDDF0. I'll call this
mounted filesystem MFSDF0.  If FLOX was in DF0 when you did this mount,
then MFSDF0 would be effectively the same as FSOX - all fine and dandy.

If you were to remove FLOX from DF0 and put in FLOY into DF0, while
leaving MFSDF0) mounted, then things go a bit pear shaped.


If the filesystem were instead mounted on SBOX via a handle BDOX giving
a mounted filesystem of MFSOX, then MFSOX would stay equivalent to 
FSOX.  In fact, umount could refuse to unmount MFSOX if it _couldn't_
find SBOX via BDOX - akin to "device temporarily unavailable".  The
blocks could stay in memory until FSOX was put back in (or a forced
umount took place) 


Also, what if you took FLOX out of DFO and put it in DF1? 
(and what if MFSOY was mounted on SBOY?)

Well, if you've mounted the filesystem on SBOX, and the system can deal
with that fact, then it can say "so #@?% what? I can still see SBOX,
I can still see SBOY, so no problems!"

But what is the BDOX - well, for FLOX, it could be,
say, the disk label? For disk partitioning schemes that allow one to
label the partitions, the handle for the set-of-blocks-in-the-partition
could be the partition label...

Now, I know you can pass mount -L the disk/partition label rather
than the block dev. file in /dev/ - but, as far as I can tell, 
that label is used to find which drive that disk is currently in,
and then mount mounts the filesystem on the set of blocks currently
accessible via that drive, and _not_ on the set of blocks that the
label identifies!


So, I would propose something like a devfs that produces a 
/dev/xyzzy block special file representing the set of blocks
identified by a disk label xyzzy - i.e. the set of blocks on that
disk, and a directory /dev/current containing managed symlinks back
to those block special files - e.g. /dev/current/fd0 symlinked to
/dev/xyzzy while xyzzy is in fd0.  

Of course, this would involve having the block device layer
support it too...



Further speculation:

The duty of an automounter could then be to mount a filesystem
on /dev/xyzzy at e.g. /mnt/xyzzy, unmounting it when no more files
are open on xyzzy. It would, of course, be nice if it tracked
/dev/current, managing corresponding symlinks in /mnt/current

It wouldn't have to worry much about timeouts, since if
a new disk was swapped in the same drive, with files still open on
xyzzy, one would still have /dev/xyzzy's blocks as mentioned above,
with /mnt/xyzzy unmounting being blocked until /dev/xyzzy was
reinserted or /mnt/xyzzy force-unmounted


Phew!  Thanks for reading this far....

IMHO, that's the "clean" way to handle removable media, fixing
a long-standing issue I have with "the unix way". Am I going to 
implement it?  I dunno - I'm not that good a kernel hacker, I
suspect.  I wanted to at least make sure the ideas out there...

That would bring the advantages of the Amiga's removable media
handling to Linux, wihtout the adhoccery of userspace solutions
or supermount.

Now, perhaps this has been thrashed out before, I'm young
and ignorant - but I still would like to get the opinions
of linux kernel people on the above.  

Best Regards,

David Golden

