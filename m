Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271413AbTHDOey (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 10:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271688AbTHDOex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 10:34:53 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:18163 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S271413AbTHDOes
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 10:34:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Stephan von Krawczynski <skraw@ithnet.com>,
       Andries Brouwer <aebr@win.tue.nl>
Subject: Re: FS: hardlinks on directories
Date: Mon, 4 Aug 2003 09:33:44 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
References: <20030804141548.5060b9db.skraw@ithnet.com> <20030804134415.GA4454@win.tue.nl> <20030804155604.2cdb96e7.skraw@ithnet.com>
In-Reply-To: <20030804155604.2cdb96e7.skraw@ithnet.com>
MIME-Version: 1.0
Message-Id: <03080409334500.03650@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 August 2003 08:56, Stephan von Krawczynski wrote:
> On Mon, 4 Aug 2003 15:44:15 +0200
>
> Andries Brouwer <aebr@win.tue.nl> wrote:
> > On Mon, Aug 04, 2003 at 02:15:48PM +0200, Stephan von Krawczynski wrote:
> > > although it is very likely I am entering (again :-) an ancient
> > > discussion I would like to ask why hardlinks on directories are not
> > > allowed/no supported fs action these days.
> >
> > Quite a lot of software thinks that the file hierarchy is a tree,
> > if you wish a forest.
> >
> > Things would break badly if the hierarchy became an arbitrary graph.
>
> Care to name one? What exactly is the rule you see broken? Sure you can
> build loops, but you cannot prevent people from doing braindamaged things
> to their data anyway. You would not ban dd either for being able to flatten
> your harddisk only because of one mistyping char...
> Every feature can be misused and then damaging, but that is no real reason
> not to have it - IMHO.

Find for one. Any application that must scan the tree in a search. Any 
application that must backup every file for another (I know, dump bypasses
the filesystem to make backups, tar doesn't).

tar, cpio, rm
fsck for another...
ls for another.. (ls -R)

The problem is backward links. If the forward link to a directory points to a 
directory above the entry for that link will cause a failure.

Another problem is reverse links...
for example:
	a/b/c		and
	a/b/d		are in the same directory b, (c and d are both directories)
	a/e/f		is hardlinked to the directory d.
current directory is in "f".

How do you address "../c" ?

I've used systems that allowed this (VMS was one, though it wasn't really
documented). The filesystem repair utilitity insisted that "directory was
not properly linked...", and any attempt to fix it caused the other link
to show up as "not properly".

It introduces too many unique problems to be easily handled. That is why
symbolic links actually work. Symbolic links are not hard links, therefore
they are not processed as part of the tree. and do not cause loops.

It was also done in one of the "popular" code management systems under
unix. (it allowed a "mount" of the system root to be under the CVS
repository to detect unauthorized modifications...). Unfortunately,
the system could not be backed up anymore. 1. A dump of the CVS filesystem
turned into a dump of the entire system... 2. You could not restore the
backups... The dumps failed (bru at the time) because the pathnames got
too long, the restore failed since it ran out of disk space due to the
multiple copies of the tree being created.

The KIS principle is the key. A graph is NOT simple to maintain.
