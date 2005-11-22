Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbVKVQ2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbVKVQ2y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 11:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbVKVQ2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 11:28:54 -0500
Received: from thunk.org ([69.25.196.29]:45697 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S964982AbVKVQ2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 11:28:53 -0500
Date: Tue, 22 Nov 2005 11:28:36 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Alfred Brons <alfredbrons@yahoo.com>, pocm@sat.inesc-id.pt,
       linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
Message-ID: <20051122162836.GA31444@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Christoph Hellwig <hch@infradead.org>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	Alfred Brons <alfredbrons@yahoo.com>, pocm@sat.inesc-id.pt,
	linux-kernel@vger.kernel.org
References: <11b141710511210144h666d2edfi@mail.gmail.com> <20051121095915.83230.qmail@web36406.mail.mud.yahoo.com> <20051121101959.GB13927@wohnheim.fh-wedel.de> <20051122075148.GB20476@infradead.org> <20051122145047.GB29179@thunk.org> <20051122152531.GU12760@delft.aura.cs.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122152531.GU12760@delft.aura.cs.cmu.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 10:25:31AM -0500, Jan Harkes wrote:
> On Tue, Nov 22, 2005 at 09:50:47AM -0500, Theodore Ts'o wrote:
> > I will note though that there are people who are asking for 64-bit
> > inode numbers on 32-bit platforms, since 2**32 inodes are not enough
> > for certain distributed/clustered filesystems.  And this is something
> > we don't yet support today, and probably will need to think about much
> > sooner than 128-bit filesystems....
> 
> As far as the kernel is concerned this hasn't been a problem in a while
> (2.4.early). The iget4 operation that was introduced by reiserfs (now
> iget5) pretty much makes it possible for a filesystem to use anything to
> identify it's inodes. The 32-bit inode numbers are simply used as a hash
> index.

iget4 wasn't even strictly necessary, unless you want to use the inode
cache (which has always been strictly optional for filesystems, even
inode-based ones) --- Linux's VFS is dentry-based, not inode-based, so
we don't use inode numbers to index much of anything inside the
kernel, other than the aforementioned optional inode cache.

The main issue is the lack of a 64-bit interface to extract inode
numbers, which is needed as you point out for userspace archiving
tools like tar. There are also other programs or protocols that in the
past have broken as a result of inode number collisions.

As another example, a quick google search indicates that the some mail
programs can use inode numbers as a part of a technique to create
unique filenames in maildir directories.  One could easily also
imagine using inode numbers as part of creating unique ids returned by
an IMAP server --- not something I would recommend, but it's an
example of what some people might have done, since everybody _knows_
they can count on inode numbers on Unix systems, right?  POSIX
promises that they won't break!

> The only thing that tends to break are userspace archiving tools like
> tar, which assume that 2 objects with the same 32-bit st_ino value are
> identical. I think that by now several actually double check that the
> inode linkcount is larger than 1.

Um, that's not good enough to avoid failure modes; consider what might
happen if you have two inodes that have hardlinks, so that st_nlink >
1, but whose inode numbers are the same if you only look at the low 32
bits?  Oops.

It's not a bad hueristic, if you don't have that many hard-linked
files on your system, but if you have a huge number of hard-linked
trees (such as you might find on a kernel developer with tons of
hard-linked trees), I wouldn't want to count on this always working.

						- Ted








> 
> Jan
