Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265633AbTF3Ico (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 04:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265718AbTF3Ico
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 04:32:44 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:9088 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265633AbTF3Ici (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 04:32:38 -0400
Date: Mon, 30 Jun 2003 09:55:23 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306300855.h5U8tNG2000475@81-2-122-30.bradfords.org.uk>
To: jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org, mlmoser@comcast.net
Subject: Re: File System conversion -- ideas
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >I typically call that 'tar' and it works great whenever I want to
> >convert from one filesystem to another. I just haven't got a clue why
> >you want to implement tar (or cpio) in the kernel as the userspace
> >implementation is already pretty usable.
> >
>
> tar --inplace --fs-convert --targetfs=reiserfs /dev/hda1
>
> .......  it doesn't like it

tar -cf - -C /old_filesystem | tar -xf - -C /newfilesystem

Works fine, and copies symbolic links, and device files properly.  If
you don't want sparse files expanded, you can use --sparse.

Yes, it needs both old and new filesystems on-line at once.  That
isn't a problem for a lot of users.

It has the advantage over an on-line conversion utility that the files
are layed out in the way they were intended to be by the filesystem,
for performance, and anti-fragmentation reasons.

There are probably a few smaller ISPs, with customer webservers which
are not guaranteed to be backed up, who would like to be able to
switch to a more modern filesystem at some point in the future,
without downtime.  Union mounts would potentially be useful here - the
old data can be kept on whatever filesystem it's on, and a new
filesystem union mounted over it.  If a file is updated, it's
re-written to the new filesystem.  Data that's changed would migrate
to the new filesystem.  Once most of it is across, you could touch all
of the remaining files, and force them across.  Your webserver
performance shouldn't be impacted during all of this, (and might even
improve, if write performance is much better on the new filesystem).

For desktop users, small amounts of downtime usually don't matter,
filesystem performance isn't usually critical either, and if the data
isn't backed up anywhere, data integrity _is_ important, so I would
suggest that they either stick with their existing filesystem, or
backup and restore.

A conversion utility could save the time of the restore, but if it
leaves the user with a badly fragmented or poorly layed out
filesystem, it could well be counter-productive.

So, assuming that the main real world use would be small, but busy
servers which want better performance for new data, and old data
gradually migrated across, but with minimum performance impact, union
mounts would be a way to achieve this.

Union mounts would be a lot easier to implement, and a lot more
useful than a converstion utility.  Note that BSD already has union
mounts.

IFF a conversion utility could be written that:

* Works on read-write mounted filesystems
* Doesn't produce a poorly layed out filesystem

Then _maybe_ it would be useful.

Personally, if I was interested in implementing this, (which I'm not),
I wouldn't worry about data integrity at all times - (if it failed for
some reason, it would require a restore of the backup which the user
was advised to make anyway), but create the framework of the new
filesystem image in memory, with references to the location of data in
the old, (real), filesystem, having moved all the data to the end of
the existing filesystem.  Once complete, I'd unmount the existing FS,
and overwrite it with the in-memory filesystem, making sure to read
anything I needed from the old, (unmounted), filesystem image before
overwriting it.

I.E. to convert a filesystem with three files, (A, B, and C), and some
free space, (F).  The block numbers are underneath.

Old filesystem with 4K block size
----------------------------
AAAAABCCCBBCCBBCCCCCCCFFFFFF
1234567891111111111222222222
         0123456789012345678

Move data to the end.

FFFFFFCCCBBCCBBCCCCCCCAAAAAB

Desired new filesystem with 8K block size
----------------------------
AAAAAaFFBBBBBbFFCCCCCCCCCCCC
1 2 3 4 5 6 7 8 9 1 1 1 1 1
                  0 1 2 3 4

(the lower case letters represent the extra space taken up by the
larger block size).

So, we would create a table in memory:

New FS  Old FS
1       23,24
2       25,26
3       27
5       28,10
6       11,14
7       15
9       7,8
10      9,12
11      13,16
12      17,18
13      19,20
14      21,22

This table maps the in-memory new filesystem to blocks in the old
filesystem.  Now, we could unmount the old filesystem, and mount the
new virtual filesystem in it's place, then start writing the new
filesystem to disk:

Read data from old blocks 23 and 24, and write it to new block 1, overwriting old blocks 1 and 2,
Read data from old blocks 25 and 26, and write it to new block 2, overwriting old blocks 3 and 4,
Read data from old block  27       , and write it to new block 3, overwriting old blocks 5 and 6,
Store data from old blocks 7 and 8, (for new block 9), in RAM,
                                         erase block 4          , overwriting old blocks 7 and 8,
Read data from old blocks 28 and 10, and write it to new block 5, overwriting old blocks 9 and 10,
Store data from old block 12, (for new block 10) in RAM,
Read data from old blocks 11 and 14, and write it to new block 6, overwriting old blocks 11, and 12,
Store data from old block 13, (for new block 11), in to RAM.
Read data from old block  15       , and write it to new block 7, overwriting old blocks 13, and 14,
Read data from old block 16, (for new block 11), in to RAM.
                                         erase block 8          , overwriting old blocks 15, and 16,
Write data from RAM, in to new block 9, and free that RAM.

...etc...

At the end, you'd have the new filesystem on disk, and there would be
a direct mapping between the virtual RAM-based filesystem and the disk
blocks.  At that point, you could umount the virtual filesystem, and
mount the disk based one.

This would be do-able on a read-write filesystem, because writes would
go only to the new RAM-based virtual filesystem - the original
filesystem would be mounted read-only before the convertion process
started.

So, it's interesting and possible in theory, but is it practical or
worth implementing?  I don't think so.  If somebody is interested in
implementing it I'd be pleased to see it in the kernel, but it's not a
project I'd have any real interest in myself.

John.
