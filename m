Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265732AbTF2Sfq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 14:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265733AbTF2Sfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 14:35:45 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:22658 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265732AbTF2Sfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 14:35:37 -0400
Date: Sun, 29 Jun 2003 19:58:15 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306291858.h5TIwFTZ001196@81-2-122-30.bradfords.org.uk>
To: john@grabjohn.com, linux-kernel@vger.kernel.org, mlmoser@comcast.net
Subject: Re: File System conversion -- ideas
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> Anyhow, I'm thinking still about when reiser4 comes out.  I want to
> >> convert to it from reiser3.6.  It came to my attention that a user-space
> >> tool to convert between filesystems is NOT the best way to deal with
> >> this. Seriously, you'd think it would be, right?  Wrong, IMHO.
> >>
> >> You have the filesystem code for every filesystem Linux supports.  It's
> >> there, in the kernel.  So why maintain a kludgy userspace tool that has
> >> to be rewritten to understand them all?  I have a better idea.
> >>
> >> How about a kernel syscall?  It's possible to do this on a running
> >> filesystem but it's far too difficult for a start, so let's start with
> >> unmounted filesystems mmkay?
> >
> >Apart from the special case of converting from one major version of a
> >filesystem to another major version of the same filesystem, I think
> >the performance of an on-the-fly filesystem conversion utility is
> >going to be so much worse than just creating a new partition and
> >copying the data across, that the only reason to do it would be if you
> >could do it on a read-write filesystem without unmounting it.
> >
>
> You've entirely missed the point :/  Did you read the last section?

Yes, but...

> I noted
> that the "make new partition and copy" method requires, first off, space
> for a new partition.  All my partitions have massive amount of data on them.
> I can't do that.  Those of us that can have to either do it twice, or rewrite
> fstab.

Rewriting fstab shouldn't be a problem :-).

> Eventually I'm hoping it can be done on a read-write filesystem.  It's
> possible; I've thought about how to defragment read-write datasystems
> without getting in the way of logical operations.

Seriously, though, I was thinking more of what's most useful in a
server situation, where it's not uncommon to have a lot of spare
capacity - I don't think that the kernel mode read-only only converter
is going to be much of an advantage over a userspace solution in those
situations, whereas a read-write one would potentially be, because
although it's reasonable to expect backups to be done anyway, if you
can avoid the downtime needed for the restore, that's a Good Thing.

> >What I'd like to see is union mounts which allowed you to mount a new
> >filesystem of a different type over the original one, and have all new
> >writes go to the new fileystem.  I.E. as files were modified, they
> >would be re-written to the new FS.  That would be one way of avoiding
> >the performance hit on a busy server.
> >
>
> mmmm, then you'd need both fs' though.  That's not conversion ;-)

The idea was to transparently delete files from the old filesystem
once they had been written to, and therefore transferred to the new
filesystem.

I think you've missed my point - for a desktop machine, an hour or two
downtime is usually no problem.  For an ISPs webserver, it usually
is, (unless there are a cluster of them serving requests for the same
sites).  However, to be able to convert filesystems without:

* Significant performance loss of network serving applications
* Significant downtime

is a very desireable feature, but the ability to do this on a
read-write filesystem is critical - if it has to be unmounted, it's
not as useful.

The reason I mentioned union mounts was because BSD already has union
mounts - see the mount_union manual page for more details.  I don't
know of an implementation that allows you to automatically delete the
file on the old filesystem, when the copy on the new filesystem has
been made, though.

John.
