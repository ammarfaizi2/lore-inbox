Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbUC1Xzl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 18:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbUC1Xzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 18:55:41 -0500
Received: from mail.shareable.org ([81.29.64.88]:4499 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S262493AbUC1Xzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 18:55:37 -0500
Date: Mon, 29 Mar 2004 00:55:28 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Davide Libenzi <davidel@xmailserver.org>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040328235528.GA2693@mail.shareable.org>
References: <m1ekrgyf5y.fsf@ebiederm.dsl.xmission.com> <20040325194303.GE11236@mail.shareable.org> <m1ptb0zjki.fsf@ebiederm.dsl.xmission.com> <20040327102828.GA21884@mail.shareable.org> <m1vfkq80oy.fsf@ebiederm.dsl.xmission.com> <20040327214238.GA23893@mail.shareable.org> <m1ptax97m6.fsf@ebiederm.dsl.xmission.com> <m1brmhvm1s.fsf@ebiederm.dsl.xmission.com> <20040328122242.GB32296@mail.shareable.org> <m14qs8vipz.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m14qs8vipz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> A COW on a directory implies a COW on everything in it.  So the implication
> is an atomic snapshot of that directory and everything below it.
> 
> Assuming no files are open and in use.  The implementation would
> create the cow link on the directory just like it would on a file.
> Then when you open/modify a directory or file the cow copies would be
> taken up to the point of the original cow directory so you have a
> separate directory structure.
> 
> All of which works great until you have a file that has one hard link
> in your cow directory structure and another hard link outside of
> any cow.  An application can come in and modify the file through that
> second cow link causing problems.

I don't see that problem (although I see another, see below).  The
application will modify only one instance of the file, and it's the
correct instance.  If the application writes through the link outside
both trees, or the link inside the original tree, it will only affect
the tree that was cowlinked _from_, which is correct.  If the
application writes to the name inside the snapshot tree, it will only
affect that tree, which is also correct.

You cowlinked a directory.  That converts the original directory inode
to a cowlink, creates another cowlink, and creates a shared inode
which now contains the directory.

Then you modify the directory or anything below it.  That duplicates
the directory, breaking the directory cowlinks and duplicating the
shared directory inode -- so that the two directory cowlink inodes
become normal directory inodes.  The directory duplication results in
two directory which are full of cowlinks -- every object in the
original directory is cowlinked by this operation.

A file which was originally hard-linked inside the tree and also
outside both trees retains the correct hard-link identity: the hard
link is simply two directory entries referring to the same inode,
which at all times is the inode visible inside the original tree and
not visible inside the snapshot, cowlinked tree.  That inode changes
its underlying representation from file-inode to cowlink-inode
(pointing to a shared file-inode) and back again during these
operations.  However, the hard link identity remains correct at all
times.  Writing to a file won't ever modify the wrong file.

There is a different problem, though: cowlinking whole trees like that
doesn't preserve hard-linkage _within_ the tree being copied.  Each
time a directory is lazily duplicated, every entry in it is cowlinked,
and if two or more entries are hard linked to the same inode, the
cowlinked copies won't share an inode.  It's as if you did "cp -p"
instead of "cp -pd".  This can be solved easily within a single
directory, but when there are hard linked within the tree from
different directories, it's too hard to solve with lazy directory
duplication, without keeping a lot of extra metadata.  (That's the
same metadata that "cp --preserve=links" or "rsync -H" has to keep
track of when copying a whole tree: on my home system, there's so much
of it due to hard links that rsync can't copy my home directory).

So I don't see the problem you describe, where an application could
accidentally modify the wrong file.  (Perhaps my imagined mechanism
for cowlinking directories is different from yours).  In particular, I
see no problem at all with hard links outside the cowlinked trees:
they would be fine.

But I see a different problem: the equivalent of something
semantically equivalent to "cp -pr" is fine and fast, but "cp -dpr"
(aka. "cp -a") must, unless it's quite complicated with filesystem
metadata, duplicate the whole directories immediately rather than
lazily, or at least scan them looking for hard links.

-- Jamie
