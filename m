Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbUC0VBQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 16:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbUC0VBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 16:01:16 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48790 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261874AbUC0VBO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 16:01:14 -0500
To: Jamie Lokier <jamie@shareable.org>
Cc: =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Davide Libenzi <davidel@xmailserver.org>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
References: <20040321125730.GB21844@wohnheim.fh-wedel.de>
	<Pine.LNX.4.44.0403210944310.12359-100000@bigblue.dev.mdolabs.com>
	<20040321181430.GB29440@wohnheim.fh-wedel.de>
	<m1y8ptu42m.fsf@ebiederm.dsl.xmission.com>
	<20040325174942.GC11236@mail.shareable.org>
	<m1ekrgyf5y.fsf@ebiederm.dsl.xmission.com>
	<20040325194303.GE11236@mail.shareable.org>
	<m1ptb0zjki.fsf@ebiederm.dsl.xmission.com>
	<20040327102828.GA21884@mail.shareable.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 27 Mar 2004 14:00:45 -0700
In-Reply-To: <20040327102828.GA21884@mail.shareable.org>
Message-ID: <m1vfkq80oy.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Eric W. Biederman wrote:
> > It is easy to add something like a cowstat or a readcowlink and teach
> > the few programs that care (i.e. diff, tar,...) how to use it.  So I
> > would rather concentrate on making cow links look like a separate copy
> > than early optimizations.
> 
> I agree, having each cowlink look like a separate copy, with separate
> inode numbers, is best.  That _is_ POSIX compatible -- the sharing is
> just a storage optimisation, and programs which only use the POSIX API
> won't see the difference.
> 
> I have no problem with adding cowstat() to diff, and I'm sure other
> people will eventually extend rsync and tar to use it, if it becomes
> widely used.
> 
> It's not the simplest solution, though.  The filesystem changes are
> non-trivial.  (The simplest solution is just an ext2 attribute which
> says you can't write to the file if it has >1 links).

There are two possible implementations strategies for implementing
cow files.  You can either start as Jörn did with hardlinks, or you
can start with symlinks.

The set of tradeoffs is interesting.  When using hardlinks the only
sane thing to do is to change the inode number when you do a copy.
You are limited to normal files, no directories, no symlinks, and the
original must resided on the same filesystem as the copy.  In addition
a copy will always have a link count of one.  So on that score I
see a hard time getting POSIX semantics out of the a hard link based
cow.

When you start with symlinks the tradeoffs are different.  You only
trigger a copy on write when you go through the copy not when you
write through the original.  You get distinct inodes for free.  They
can be straight forwardly extended to work on symlinks and other node
types.  You can have multiple links at the end of the copy, because
symlinks can be hard linked.  The original can be stored on another
filesystem.  If you don't change the original you get POSIX semantics.

As for simplicity I think the two approaches are roughly equal.  

As my memory has it the proto implementation I saw using a stackable
fs and cow symlinks was about a 1000 lines.  And it was that large
because it was complete (i.e. it did the copies including copying
directories.)

Eric
