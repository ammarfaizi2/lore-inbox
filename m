Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbTJ3Nri (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 08:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbTJ3Nri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 08:47:38 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:45554 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262458AbTJ3Nre
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 08:47:34 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Scott Robert Ladd <coyote@coyotegulch.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Things that Longhorn seems to be doing right
Date: Thu, 30 Oct 2003 07:46:52 -0600
X-Mailer: KMail [version 1.2]
Cc: Erik Andersen <andersen@codepoet.org>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org
References: <3F9F7F66.9060008@namesys.com> <20031030015212.GD8689@thunk.org> <3FA08C42.6050107@coyotegulch.com>
In-Reply-To: <3FA08C42.6050107@coyotegulch.com>
MIME-Version: 1.0
Message-Id: <03103007465200.23446@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 October 2003 21:57, Scott Robert Ladd wrote:
> Theodore Ts'o wrote:
> > Keep in mind that just because Windows does thing a certain way
> > doesn't mean we have to provide the same functionality in exactly the
> > same way.
>
> Very true. Linux is best defined by those who proactively implement
> powerful ideas.
>
> That doesn't mean, however, that the folks in Redmond can't come up with
> an interesting and useful idea that we might just want to consider.
>
> > Also keep in mind that Microsoft very deliberately blurs what they do
> > in their "kernel" versus what they provide via system libraries
> > (i.e., API's provided via their DLL's, or shared libraries).
>
> Any database-style file system should be implemented in a modular
> fashion, just like current Linux file systems.
>
[snip]
> > Fortunately, I have enough faith in Linus Torvalds' taste that I'm
> > not particularly worried what would happen if someone were to send
> > him a patch that attempted to cram MySQL or Postgres into the guts of
> > the Linux kernel....  although I would like to watch when someone
> > proposes such a thing!
>
> MySQL wouldn't need to be shoved into the kernel; a small, fast database
> engine (one of my professional specialities, BTW) could provide metadata
> services in a file system module. SQL is a bloated pig; an effective
> file system needs to be both useful and efficient, leading me to think
> that we should consider a more succinct query mechanism for any
> metadata-based file system.

Umm... keep in mind that every system that has a in-kernel database system
has tanked. Remember PIC systems? How about MUMPS?

The closest thing to this that hasn't died (quite?) has been the VMS
datatrieve facility. But even that wasn't in the kernel proper, it was
a layered facility added to the DCL user API that was accessable to
applications. It basicly provided multiple ISAM support to read/write.
And no, the files were not portable... they had to be converted to normal
RMS files/stream files first; and you lost the keys when you did.

The problem with the database system (anywhere) is that it is absolutely
horrible for I/O throughput. Having to reference schemas, multiple key
hashing, even key identification all takes multiple I/O operations to do.
Not to mention the duplications caused by having to store the results in
addition to storing the raw data.

And you no longer get to do a simple "read" of data. You have to completely
drop the concept of "data stream" and data portability. If you DO keep the
original semantics of a file, then you double/triple the data I/O (once for
the data, once for the keys, and once for the correlation/compound keys).
Then you have to deal with the huge amount of metadata that maintains the
above. On top of that, you also have to include a general purpose locking
facility (NOT advisory either) or you WILL get a corrupted data file with
only one writer (do a "tail -f" on a file, and the file gets corrupted during
updates to the keys or base data).

The last time I saw this amount of crap/problems was with a Clearcase file
system (couldn't even back the system up).

If you REALLY want to test this, make it a user mode NFS server, and mount
it through a loopback.

I think it would be more usefull to have file migration support added to the
current metadata (extra index, extra modes, compressed data, compressed date,
migrated date, unmigrated date, migration expiration date... possible with
XFS maybe. and only a little more changes needed...).
