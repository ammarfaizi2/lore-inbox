Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbTF2T70 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 15:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265151AbTF2T7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 15:59:25 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3456 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265062AbTF2T6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 15:58:11 -0400
Date: Sun, 29 Jun 2003 21:20:59 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306292020.h5TKKxJ2000188@81-2-122-30.bradfords.org.uk>
To: john@grabjohn.com, linux-kernel@vger.kernel.org, mlmoser@comcast.net
Subject: Re: File System conversion -- ideas
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> You've entirely missed the point :/  Did you read the last section?
> >
> >Yes, but...
> >
> >> I noted
> >> that the "make new partition and copy" method requires, first off, space
> >> for a new partition.  All my partitions have massive amount of data on
> >> them.
> >> I can't do that.  Those of us that can have to either do it twice, or
> >> rewrite
> >> fstab.
> >
> >Rewriting fstab shouldn't be a problem :-).
> >
> >> Eventually I'm hoping it can be done on a read-write filesystem.  It's
> >> possible; I've thought about how to defragment read-write datasystems
> >> without getting in the way of logical operations.
> >
> >Seriously, though, I was thinking more of what's most useful in a
> >server situation, where it's not uncommon to have a lot of spare
> >capacity - I don't think that the kernel mode read-only only converter
> >is going to be much of an advantage over a userspace solution in those
> >situations, whereas a read-write one would potentially be, because
> >although it's reasonable to expect backups to be done anyway, if you
> >can avoid the downtime needed for the restore, that's a Good Thing.
> >
>
> It should be easy enough.  I dunno if it'll require a VFS rewrite or not though.
> The idea is to buffer changes to and allow retrieval of logical filesystem
> objects, which requires.. well, RAM.  Although, since the inodes on the new
> fs won't need to be in the same order they were in on the old fs, it should be
> possible to simply write new data to the new fs, IF you watch what you're
> doing.  And yes, I do realize I'm talking about writing to half-existant
> filesystems that by rights can't even mount.  (Actually, more like an empty
> filesystem that's jumbled around physically, but is being addressed logically
> anyway).
>
> Easy trick:  Skip deleted inodes, and if you have to change an inode, have
> the old fs go mark it as deleted real quick and free the space around it, giving
> it to the conversion datasystem.  Now you can run read-write while you do it.
>
> Remember also that I insist that there must be a journal in the CDS
> (conversion datasystem).
>
> >> >What I'd like to see is union mounts which allowed you to mount a new
> >> >filesystem of a different type over the original one, and have all new
> >> >writes go to the new fileystem.  I.E. as files were modified, they
> >> >would be re-written to the new FS.  That would be one way of avoiding
> >> >the performance hit on a busy server.
> >> >
> >>
> >> mmmm, then you'd need both fs' though.  That's not conversion ;-)
> >
> >The idea was to transparently delete files from the old filesystem
> >once they had been written to, and therefore transferred to the new
> >filesystem.
> >
>
> Heh, sounds like what I'm doing but you're hitting my final goal from the
> beginning, and using two partitions.
>
> >I think you've missed my point - for a desktop machine, an hour or two
> >downtime is usually no problem.  For an ISPs webserver, it usually
> >is, (unless there are a cluster of them serving requests for the same
> >sites).  However, to be able to convert filesystems without:
> >
> >* Significant performance loss of network serving applications
> >* Significant downtime
> >
> >is a very desireable feature, but the ability to do this on a
> >read-write filesystem is critical - if it has to be unmounted, it's
> >not as useful.
> >
>
> That's the eventual idea.  As for performance, errm.  The performance loss
> would be in referencing the CDS to find where the data in each filesystem is,
> and in the CPU time and RAM used up, along with the massive disk access,
> while the system does its job.  Shouldn't be a problem on servers though;
> IIRC they use SCSI disks and fast CPUs?

The disk accesses were what I was thinking of.  May well not be a
problem in reality.

> >The reason I mentioned union mounts was because BSD already has union
> >mounts - see the mount_union manual page for more details.  I don't
> >know of an implementation that allows you to automatically delete the
> >file on the old filesystem, when the copy on the new filesystem has
> >been made, though.
> >
>
> If you think about it, you have this:
>
> [PARTITION 1]
>     |
>    V
> [PARTITION 2]
>
> I have this (the == is an equivalence signm i.e. this is what's inside):
>
> [PARTITION]
>     ==
> [DATASYSTEM]
>     ==
> [FILESYSTEM 1]
>     |
>     V
> [DATASYSTEM ATOMS]
>     |
>     V
> [FILESYSTEM 2]
>
> Both filesystems are the full size of the partition, and so is the
> datasystem.  The only difference is that before you start you have
> to make sure that the datasystem's gonna fit in with the free space
> on the first filesystem, and still have space to start the second
> filesystem, and then have space for its atoms.

Just thought - that's going to be a problem in read-write mode :-/.

If the disk fills up, we'd need to be able to maintain a consistant
filesystem structure, (at least good enough so that a separate
fsck-like utility could repair it - if the disk filled up, then the
conversion couldn't be done on-the-fly).

> These atoms will
> slowly be destroyed as they go into the second filesystem.  You
> have to also make sure that the second FS won't be bigger than the
> first, and will at the end have enough to hold at least the empty
> datasystem and one atom.
>
> I feel I should note, since I forgot before, that an atom can contain part
> of the data for an inode, as long as you know this and can write the atom
> out to the new filesystem and get more of the old.

Seems like a solid idea, though.  As long as it worked on at least
read-only mounted filesystems, I'd be quite interested in seeing it in
the mainline kernel.

John.
