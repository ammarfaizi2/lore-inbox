Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263114AbUC2ThW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 14:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263104AbUC2ThV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 14:37:21 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36766 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263124AbUC2ThG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 14:37:06 -0500
To: Jamie Lokier <jamie@shareable.org>
Cc: =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Davide Libenzi <davidel@xmailserver.org>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
References: <m1ptb0zjki.fsf@ebiederm.dsl.xmission.com>
	<20040327102828.GA21884@mail.shareable.org>
	<m1vfkq80oy.fsf@ebiederm.dsl.xmission.com>
	<20040327214238.GA23893@mail.shareable.org>
	<m1ptax97m6.fsf@ebiederm.dsl.xmission.com>
	<m1brmhvm1s.fsf@ebiederm.dsl.xmission.com>
	<20040328122242.GB32296@mail.shareable.org>
	<m14qs8vipz.fsf@ebiederm.dsl.xmission.com>
	<20040328235528.GA2693@mail.shareable.org>
	<m1zna0tp55.fsf@ebiederm.dsl.xmission.com>
	<20040329123658.GA4984@mail.shareable.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 29 Mar 2004 12:36:39 -0700
In-Reply-To: <20040329123658.GA4984@mail.shareable.org>
Message-ID: <m18yhjh2d4.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Eric W. Biederman wrote:
> > The file will become a cow file only after it is modified or it's
> > containing directory is modified.
> 
> Eh?  The file (or directory) must be labelled as a cowlinked file the
> moment you make the cowlink, not when the data is modified.  It's
> _breaking_ the cowlink that happens when the data (or directory
> contents) are modified.

We have the mechanism of:
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

This mechanism does not label all files below a directory as cowlinked
the moment the cowlink.

Therefore cowlink on a directory as described may be an interesting
operation but it is not an atomic snapshot of the directory and
it's contents.  

> > Thus you can have data in the
> > file that was written after the snapshot operation finished, but
> > before the individual file itself is marked cow.
> 
> The creation of a cowlink should be atomic w.r.t. writing.
> 
> Specifically, the operation which moves the contents of a non-cowlink
> inode to a newly created shared inode, and converts the original
> non-cowlink inode to a cowlink inode, should be atomic.
> 
> Is there an unavoidable race condition?  I don't see one.

Only if the following apply.

- A correct cow on a directory is considered to be an atomic snapshot
  of both the directory and everything below it.
- You break the cow on the directories on demand, as above.

Scenario. The directory tree looks like:

/dir1 (inode 1)/link1 (inode 10)
/dir2 (inode 2)/link2 (inode 10)

Then a cow link is performed:

ln --cow dir2 cow1

Resulting in a directory tree that looks like:
/dir1 (inode 1)/link1 (inode 10)
/dir2 (inode 2) -> (inode 3)/link2 (inode 10)
/cow1 (inode 4) -> (inode 3)/link2 (inode 10)


Then we have several things that could happen.
Scenario A: fd = open(/cow1/link2); write(fd, ....);
Scenario B: fd = open(/dir2/link2); write(fd, ....);
Scenario C: fd = open(/dir1/link1); write(fd, ....);

** 
In Scenario A the open breaks the cow on the directory, so that
the cow copy can have it's own inode as:

/dir1 (inode 1)/link1 (inode 10) -> (inode 11)
/dir2 (inode 2)/link2 (inode 10) -> (inode 11)
/cow1 (inode 3)/link2 (inode 12) -> (inode 11)

Then the write occurs the cow is broken and the tree looks like:

/dir1 (inode 1)/link1 (inode 10)
/dir2 (inode 2)/link2 (inode 10) -> (inode 11)
/cow1 (inode 3)/link2 (inode 12)

** 
In Scenario B the open breaks the cow on the directory, so that
the cow copy can potentially have it's own inode as:

/dir1 (inode 1)/link1 (inode 10) -> (inode 11)
/dir2 (inode 2)/link2 (inode 10) -> (inode 11)
/cow1 (inode 3)/link2 (inode 12) -> (inode 11)

Then the write occurs the cow is broken and the tree looks like:

/dir1 (inode 1)/link1 (inode 10)
/dir2 (inode 2)/link2 (inode 10)
/cow1 (inode 3)/link2 (inode 12) -> (inode 11)


** 
In Scenario C their is no open for the cow to break and
things proceed normally the directory tree remains looking like:

/dir1 (inode 1)/link1 (inode 10)
/dir2 (inode 2) -> (inode 3)/link2 (inode 10)
/cow1 (inode 3) -> (inode 3)/link2 (inode 10)

Then when the write occurs there is not cow to break, and the
tree remains looking like:

/dir1 (inode 1)/link1 (inode 10)
/dir2 (inode 2) -> (inode 3)/link2 (inode 10)
/cow1 (inode 3) -> (inode 3)/link2 (inode 10)

So I see a problem with Scenario C.   Perhaps you can refute it.

Eric
