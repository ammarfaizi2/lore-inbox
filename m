Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbUC2BcN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 20:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbUC2BcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 20:32:13 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4507 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262548AbUC2BcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 20:32:00 -0500
To: Jamie Lokier <jamie@shareable.org>
Cc: =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Davide Libenzi <davidel@xmailserver.org>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
References: <m1ekrgyf5y.fsf@ebiederm.dsl.xmission.com>
	<20040325194303.GE11236@mail.shareable.org>
	<m1ptb0zjki.fsf@ebiederm.dsl.xmission.com>
	<20040327102828.GA21884@mail.shareable.org>
	<m1vfkq80oy.fsf@ebiederm.dsl.xmission.com>
	<20040327214238.GA23893@mail.shareable.org>
	<m1ptax97m6.fsf@ebiederm.dsl.xmission.com>
	<m1brmhvm1s.fsf@ebiederm.dsl.xmission.com>
	<20040328122242.GB32296@mail.shareable.org>
	<m14qs8vipz.fsf@ebiederm.dsl.xmission.com>
	<20040328235528.GA2693@mail.shareable.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Mar 2004 18:31:34 -0700
In-Reply-To: <20040328235528.GA2693@mail.shareable.org>
Message-ID: <m1zna0tp55.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Eric W. Biederman wrote:
> > All of which works great until you have a file that has one hard link
> > in your cow directory structure and another hard link outside of
> > any cow.  An application can come in and modify the file through that
> > second cow link causing problems.
> 
> I don't see that problem (although I see another, see below).  The
> application will modify only one instance of the file, and it's the
> correct instance.  If the application writes through the link outside
> both trees, or the link inside the original tree, it will only affect
> the tree that was cowlinked _from_, which is correct.  If the
> application writes to the name inside the snapshot tree, it will only
> affect that tree, which is also correct.

What I see is a race.  An application may write through the link outside
both trees before any of the links is marked cow.  With the result
that you don't have a snapshot of your data.
 
> You cowlinked a directory.  That converts the original directory inode
> to a cowlink, creates another cowlink, and creates a shared inode
> which now contains the directory.
> 
> Then you modify the directory or anything below it.  That duplicates
> the directory, breaking the directory cowlinks and duplicating the
> shared directory inode -- so that the two directory cowlink inodes
> become normal directory inodes.  The directory duplication results in
> two directory which are full of cowlinks -- every object in the
> original directory is cowlinked by this operation.
> 
> A file which was originally hard-linked inside the tree and also
> outside both trees retains the correct hard-link identity: the hard
> link is simply two directory entries referring to the same inode,
> which at all times is the inode visible inside the original tree and
> not visible inside the snapshot, cowlinked tree.  That inode changes
> its underlying representation from file-inode to cowlink-inode
> (pointing to a shared file-inode) and back again during these
> operations.  However, the hard link identity remains correct at all
> times.  Writing to a file won't ever modify the wrong file.

Correct to a point.  And we seem to be imagining the same operations.
However while you will always modify the correct file, as the metadata
is correct.  There is no guarantee that the data will be correct.  The
file will become a cow file only after it is modified or it's
containing directory is modified.  Thus you can have data in the file
that was written after the snapshot operation finished, but before the
individual file itself is marked cow.

> There is a different problem, though: cowlinking whole trees like that
> doesn't preserve hard-linkage _within_ the tree being copied.

> I see a different problem: the equivalent of something
> semantically equivalent to "cp -pr" is fine and fast, but "cp -dpr"
> (aka. "cp -a") must, unless it's quite complicated with filesystem
> metadata, duplicate the whole directories immediately rather than
> lazily, or at least scan them looking for hard links.

Now that you bring it out I see that problem as well.  I have seen it
in other proposed implementations as well.  Keeping hard links linked
requires for some amount of context to be maintained for the entire
copy operation.  If necessary you could keep that context where it is
available to the lazy copy but it is far from trivial. 

In short lazy copying for creating snapshots is dangerous.  The
data you are copying may be modified before you are done.  It is
difficult to maintain state across the entire copy.

All of which sounds like a job for user space to me.

Eric

