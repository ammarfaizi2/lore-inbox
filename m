Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272790AbTHEONE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 10:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272794AbTHEONE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 10:13:04 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:58106 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S272790AbTHEOM6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 10:12:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: FS: hardlinks on directories
Date: Tue, 5 Aug 2003 09:12:31 -0500
X-Mailer: KMail [version 1.2]
Cc: aebr@win.tue.nl, linux-kernel@vger.kernel.org
References: <20030804141548.5060b9db.skraw@ithnet.com> <03080416092800.04444@tabby> <20030805003210.2c7f75f6.skraw@ithnet.com>
In-Reply-To: <20030805003210.2c7f75f6.skraw@ithnet.com>
MIME-Version: 1.0
Message-Id: <03080509123100.05972@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 August 2003 17:32, Stephan von Krawczynski wrote:
> On Mon, 4 Aug 2003 16:09:28 -0500
>
> Jesse Pollard <jesse@cats-chateau.net> wrote:
> > > tar --dereference loops on symlinks _today_, to name an example.
> > > All you have to do is to provide a way to find out if a directory is a
> > > hardlink, nothing more. And that should be easy.
> >
> > Yup - because a symlink is NOT a hard link. it is a file.
> >
> > If you use hard links then there is no way to determine which is the
> > "proper" link.
>
> Where does it say that an fs is not allowed to give you this information in
> some way?
>
> > > > It was also done in one of the "popular" code management systems
> > > > under unix. (it allowed a "mount" of the system root to be under the
> > > > CVS repository to detect unauthorized modifications...).
> > > > Unfortunately, the system could not be backed up anymore. 1. A dump
> > > > of the CVS filesystem turned into a dump of the entire system... 2.
> > > > You could not restore the backups... The dumps failed (bru at the
> > > > time) because the pathnames got too long, the restore failed since it
> > > > ran out of disk space due to the multiple copies of the tree being
> > > > created.
> > >
> > > And they never heard of "--exclude" in tar, did they?
> >
> > Doesn't work. Remember - you have to --exclude EVERY possible loop. And
> > unless you know ahead of time, you can't exclude it. The only way we
> > found to reliably do the backup was to dismount the CVS.
>
> And if you completely run out of ideas in your
> wild-mounts-throughout-the-tree problem you should simply use "tar -l".
>
> And in just the same way fs could provide a mode bit saying "hi, I am a
> hardlink", and tar can then easily provide option number 1345 saying "stay
> away from hardlinks".

Do you know what a hard link is? Or a directory entry?

A directory is a file of records with two fields: an inode number, and a
name (string).

Nothing else.

The "hard link" is the inode number. The count of hard links is maintained in 
the inode data structure. One for each (inode, filename) entry in a directory.

Multiple hard links are just having the same inode number used with two names.
Those two names do not have to exist in the same directory.

A directory is a special file. It has a bit that says "hi, i am a directory".
At a minimum it contains two implicit hard links. One to itself, and one to
it's parent. The parent inode is also a directory. The parent, in addition to
its own two hard links, contains a (inode, name) pair where the inode number
is the same as the inode number for the subdirectory. This way each directory
inode ALWAYS has a minimum of two hard links - the one to itself, and the one
from its' parent.

This implements the tree. It permits the concept of "working directory" with
relative path names ("../.." and "./name" contstructs).

What you say when you want additional hard links to a directory is that a
directory will have two (or more) parents.

If the fs provides a mode bit to identify something different that points to
a directory, then you have a SYMLINK. This is because the directory entry
currently only carries inode,name pairs. -- logically carries. Specific
implementations may have ANY choice implementation of a directory file, tree,
hash, whatever. To the VFS it always appears as if it were a linear file 
containing inode,name pairs.

The entry for a symlink is still (inode, name), but the inode structure
referenced contains a bit that says "hi, i am a symlink". The system THEN
knows that the data contents of the inode point to another file. It doesn't
matter whether that file is a regular file, a directory file, or a device
file.

> If you can do the fs patch, I can do the tar patch.

The patch is FAR too extensive. It would have to be a whole new filesystem
where a directory entry would have to carry additional information. And a
rather large patch to the VFS to support it. And a new fsck to try and 
maintain it. Directory locking would no longer be reliable. And modifications
to various system calls and facilities (unlink, link, namei, open, opendir, 
readdir, ...) Certain Linux features would have to be disallowed ("mv dir 
../otherdir" for instance could generate backward loops).

Tar would have to maintain a "pathname,inode" array for each file it backed
up, so that it could verify that if "inode" is already copied, the new name
is the only thing copied... (some graphs will cause the array to grow without
bounds... so watch it...).

It would be interesting in the abstract - as in using a datafile to store
the graph, utilities to insert, delete, store data, retrieve data, 
import/export data.. Fsck would have to be implemented with a "mark and
sweep" garbage collector.

Hmmmm It would support an augmented transition matrix.... (ie most computer
games are ATMs... as are large simulations...)

As a Unix filesystem... It doesn't fit. (which is one reason databases
are used to implement ATMs... The database backup ignores the contents
other than to copy data in/out. The application program uses the data as
an ATM, and the application has to deal with consistancy.)
