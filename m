Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTF2S7M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 14:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTF2S7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 14:59:12 -0400
Received: from smtp-out.comcast.net ([24.153.64.113]:56185 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S261823AbTF2S7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 14:59:04 -0400
Date: Sun, 29 Jun 2003 15:12:05 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: File System conversion -- ideas
In-reply-to: <200306291858.h5TIwFTZ001196@81-2-122-30.bradfords.org.uk>
To: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Message-id: <200306291512050720.01F4A460@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <200306291858.h5TIwFTZ001196@81-2-122-30.bradfords.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 6/29/2003 at 7:58 PM John Bradford wrote:

>> >> Anyhow, I'm thinking still about when reiser4 comes out.  I want to
>> >> convert to it from reiser3.6.  It came to my attention that a
>user-space
>> >> tool to convert between filesystems is NOT the best way to deal with
>> >> this. Seriously, you'd think it would be, right?  Wrong, IMHO.
>> >>
>> >> You have the filesystem code for every filesystem Linux supports.
>It's
>> >> there, in the kernel.  So why maintain a kludgy userspace tool that
>has
>> >> to be rewritten to understand them all?  I have a better idea.
>> >>
>> >> How about a kernel syscall?  It's possible to do this on a running
>> >> filesystem but it's far too difficult for a start, so let's start with
>> >> unmounted filesystems mmkay?
>> >
>> >Apart from the special case of converting from one major version of a
>> >filesystem to another major version of the same filesystem, I think
>> >the performance of an on-the-fly filesystem conversion utility is
>> >going to be so much worse than just creating a new partition and
>> >copying the data across, that the only reason to do it would be if you
>> >could do it on a read-write filesystem without unmounting it.
>> >
>>
>> You've entirely missed the point :/  Did you read the last section?
>
>Yes, but...
>
>> I noted
>> that the "make new partition and copy" method requires, first off, space
>> for a new partition.  All my partitions have massive amount of data on
>them.
>> I can't do that.  Those of us that can have to either do it twice, or
>rewrite
>> fstab.
>
>Rewriting fstab shouldn't be a problem :-).
>
>> Eventually I'm hoping it can be done on a read-write filesystem.  It's
>> possible; I've thought about how to defragment read-write datasystems
>> without getting in the way of logical operations.
>
>Seriously, though, I was thinking more of what's most useful in a
>server situation, where it's not uncommon to have a lot of spare
>capacity - I don't think that the kernel mode read-only only converter
>is going to be much of an advantage over a userspace solution in those
>situations, whereas a read-write one would potentially be, because
>although it's reasonable to expect backups to be done anyway, if you
>can avoid the downtime needed for the restore, that's a Good Thing.
>

It should be easy enough.  I dunno if it'll require a VFS rewrite or not though.
The idea is to buffer changes to and allow retrieval of logical filesystem
objects, which requires.. well, RAM.  Although, since the inodes on the new
fs won't need to be in the same order they were in on the old fs, it should be
possible to simply write new data to the new fs, IF you watch what you're
doing.  And yes, I do realize I'm talking about writing to half-existant
filesystems that by rights can't even mount.  (Actually, more like an empty
filesystem that's jumbled around physically, but is being addressed logically
anyway).

Easy trick:  Skip deleted inodes, and if you have to change an inode, have
the old fs go mark it as deleted real quick and free the space around it, giving
it to the conversion datasystem.  Now you can run read-write while you do it.

Remember also that I insist that there must be a journal in the CDS
(conversion datasystem).

>> >What I'd like to see is union mounts which allowed you to mount a new
>> >filesystem of a different type over the original one, and have all new
>> >writes go to the new fileystem.  I.E. as files were modified, they
>> >would be re-written to the new FS.  That would be one way of avoiding
>> >the performance hit on a busy server.
>> >
>>
>> mmmm, then you'd need both fs' though.  That's not conversion ;-)
>
>The idea was to transparently delete files from the old filesystem
>once they had been written to, and therefore transferred to the new
>filesystem.
>

Heh, sounds like what I'm doing but you're hitting my final goal from the
beginning, and using two partitions.

>I think you've missed my point - for a desktop machine, an hour or two
>downtime is usually no problem.  For an ISPs webserver, it usually
>is, (unless there are a cluster of them serving requests for the same
>sites).  However, to be able to convert filesystems without:
>
>* Significant performance loss of network serving applications
>* Significant downtime
>
>is a very desireable feature, but the ability to do this on a
>read-write filesystem is critical - if it has to be unmounted, it's
>not as useful.
>

That's the eventual idea.  As for performance, errm.  The performance loss
would be in referencing the CDS to find where the data in each filesystem is,
and in the CPU time and RAM used up, along with the massive disk access,
while the system does its job.  Shouldn't be a problem on servers though;
IIRC they use SCSI disks and fast CPUs?

>The reason I mentioned union mounts was because BSD already has union
>mounts - see the mount_union manual page for more details.  I don't
>know of an implementation that allows you to automatically delete the
>file on the old filesystem, when the copy on the new filesystem has
>been made, though.
>

If you think about it, you have this:

[PARTITION 1]
    |
   V
[PARTITION 2]

I have this (the == is an equivalence signm i.e. this is what's inside):

[PARTITION]
    ==
[DATASYSTEM]
    ==
[FILESYSTEM 1]
    |
    V
[DATASYSTEM ATOMS]
    |
    V
[FILESYSTEM 2]

Both filesystems are the full size of the partition, and so is the
datasystem.  The only difference is that before you start you have
to make sure that the datasystem's gonna fit in with the free space
on the first filesystem, and still have space to start the second
filesystem, and then have space for its atoms.  These atoms will
slowly be destroyed as they go into the second filesystem.  You
have to also make sure that the second FS won't be bigger than the
first, and will at the end have enough to hold at least the empty
datasystem and one atom.

I feel I should note, since I forgot before, that an atom can contain part
of the data for an inode, as long as you know this and can write the atom
out to the new filesystem and get more of the old.

>John.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/



