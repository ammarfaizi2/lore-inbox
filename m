Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbUC0Vm4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 16:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUC0Vm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 16:42:56 -0500
Received: from mail.shareable.org ([81.29.64.88]:31890 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261888AbUC0Vmp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 16:42:45 -0500
Date: Sat, 27 Mar 2004 21:42:38 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Davide Libenzi <davidel@xmailserver.org>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040327214238.GA23893@mail.shareable.org>
References: <20040321125730.GB21844@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0403210944310.12359-100000@bigblue.dev.mdolabs.com> <20040321181430.GB29440@wohnheim.fh-wedel.de> <m1y8ptu42m.fsf@ebiederm.dsl.xmission.com> <20040325174942.GC11236@mail.shareable.org> <m1ekrgyf5y.fsf@ebiederm.dsl.xmission.com> <20040325194303.GE11236@mail.shareable.org> <m1ptb0zjki.fsf@ebiederm.dsl.xmission.com> <20040327102828.GA21884@mail.shareable.org> <m1vfkq80oy.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m1vfkq80oy.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> There are two possible implementations strategies for implementing
> cow files.  You can either start as Jörn did with hardlinks, or you
> can start with symlinks.

Symlinks have a _big_ problem: move one, or move it's target, and it
no longer links to the same file.  That's nothing like the
transparency we need cowlinks to have.

There's a third implementation strategy.  Since we're talking in all
cases about adding a new feature to the underlying filesystem, why not
implement separate inodes pointing to an underlying shared inode which
holds the data.  (I think it was mentioned earlier in this thread).

The implementation is very similar to symbolic links, but instead of
having symlink inodes, you have cowlink inodes which point directly to
another inode and count as references to it.

That provides POSIX semantics and has none of the caveats you and I
have mentioned for hard links and symbolic links.

Implementation: Creating a cowlink to a non-cowlinked file creates a
new shared inode by cloning the file's inode, converts the original
inode to a cowlink-pointer inode, and creates a new cowlink-pointer
inode.

This provides 100% semantic equivalence to copying: all operations
including hard and symbolic links on the resulting cowlink files act
as if the cowlink operation was a copy, but faster and using less
space.

> As my memory has it the proto implementation I saw using a stackable
> fs and cow symlinks was about a 1000 lines.  And it was that large
> because it was complete (i.e. it did the copies including copying
> directories.)

I can see a stackable fs being useful for live CD distributions, where
tmpfs or disk hold the modifications stacked over the original
filesystem.

But mounting an fs for each version of a source tree and keeping track
of all those mounts: that would be incredibly clumsy to use.

You could implement a stackable fs which is mounted once and provides
cowlink operations within the fs.  That still be a bit clumsy, but not
so much as to make it unusable for source tree management.

-- Jamie
