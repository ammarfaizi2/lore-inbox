Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129346AbRCMIhC>; Tue, 13 Mar 2001 03:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129363AbRCMIgn>; Tue, 13 Mar 2001 03:36:43 -0500
Received: from server.divms.uiowa.edu ([128.255.28.165]:3089 "EHLO
	server.divms.uiowa.edu") by vger.kernel.org with ESMTP
	id <S129346AbRCMIgi>; Tue, 13 Mar 2001 03:36:38 -0500
From: Doug Siebert <dsiebert@divms.uiowa.edu>
Message-Id: <200103130836.CAA06967@server.divms.uiowa.edu>
Subject: Issues with disk block devices
To: linux-kernel@vger.kernel.org
Date: Tue, 13 Mar 2001 02:36:09 -0600 (CST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This note is sort of a half question half bug report.  I ran into a
problem with VMware, though it isn't really an issue with VMware -- I
was creating what it terms a "plain disk", and part of that process has
it trying to seek to the end of a disk partition and verifying it is
really the size it is being defined as, seemingly a very good precaution.
I received errors on one of my partitions that I was "trying to seek past
the end", and did a 'wc -c' on the device to see how big it really was.
Sure enough, 3K was missing from the end!

A further complication was that it would work OK on a partition that didn't
have a mounted filesystem on it, but once you mounted a filesystem (even
if you then later unmounted it) it lost the last 3K.  So I ended up
thinking I had found a bug, but later found it is not quite so clear what
it is.

After first testing 2.4.2ac19 to see if I ran into something fixed in
kernels later than my 2.2 series kernels I tried this on (on two different
machines) I looked through the source and found the "problem".  Since I'm
using block devices, the access is of course in blocks.  IDE disks use a
1K byte block size, ext2 fs uses 4K.  I'm curious why IDE disks use a 1K
block size rather than 512 byte, when 512 byte is its native sector size,
for at least the vast majority of drives.  Granted, it is doable to set
up your partitions so that they have an even number of sectors, but since
the fake "geometry" modern drives use tends to be 63 sectors, 255 heads
and whatever number of cylinders works out for the drive's capacity (not
to mention that the first and all extended partitions lose the first 63
sectors) you really end up with only a 50-50 shot.  I'm assuming of course
that you want to put your partitions on cylinder boundaries to keep other
operating systems you may have loaded happy and not trying to "fix" "bad"
partition tables for you.

OK, so the issue of the 1024 byte default blocksize aside, I do think it
is a bug to see that a partition will have a 1024 byte blocksize by
default, until it is used to mount a filesystem with some other blocksize.
After that time, even when the filesystem is unmounted, the blocksize is
left at what the filesystem changed it to.  I'm really not even sure how
good it is for the block device itself to have its blocksize changed due
to the fact you mounted its contents as a filesystem...  I'll include
some little printk debugging work I did while tracking this particular
thing down.  I was running a simple program which did a BLKGETSIZE ioctl
to find the device size, then lseek'd to size-7, size-6 and size-1 and
attemped to read 1024 bytes after each seek:

  /dev/hda5 before mount:
in block_read left 1024, block 2096447, offset 512, size 0, blocks 2096451
in block_read left 1024, block 2096448, offset 0, size 0, blocks 2096451
in block_read left 512, block 2096450, offset 512, size 0, blocks 2096451

  /dev/hda5 after mount and unmount:
in block_read left 1024, block 524111, offset 3584, size 0, blocks 524112
in block_read left 1024, block 524112, offset 0, size 0, blocks 524112
in block_read left 512, block 524112, offset 2560, size 0, blocks 524112

This was the case on 2.2.12, 2.2.16, 2.4.2 and 2.4.2ac19.

Is there any good way to get access to an entire disk partition, no matter
how badly it divides into a 1K/4K blocksize?  I tried using 'raw', but
it didn't produce a readable device, at least not readable for the 'wc'
command (tried under kernel 2.2.16)  Plus since it doesn't use the buffer
cache it is somewhat useless even if it works because you'd have to do
all your accesses with it.  In particular, you can't use it to access
something you may also want to mount, at least not if you care about data
integrity.

So to sum up, why are IDE disks using a 1K default blocksize, rather than
512 bytes?  And am I correct in believing that this issue with the
blocksize of a partition permanently changing when you mount a filesystem
using a different blocksize (4K ext2 in my case) on that partition, even
if you mount it read-only and immediately unmount it is a bug?  What would
be the recommended way around these problems, other than the only good fix
I can come up with, to repartition and choose my partition sizes such that
they all end up divisible by 4K?

I figure even if I'm wrong in thinking these two things are not working
the way they should, at least I'll learn something about why the design
was done in such a way that things end up like this.

Thanks!

-- 
Douglas Siebert
douglas-siebert@uiowa.edu

A computer without Microsoft software is like chocolate cake without ketchup.
