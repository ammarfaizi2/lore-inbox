Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbUC1UHs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 15:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbUC1UHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 15:07:48 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55705 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262415AbUC1UHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 15:07:45 -0500
To: Jamie Lokier <jamie@shareable.org>
Cc: =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Davide Libenzi <davidel@xmailserver.org>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
References: <m1y8ptu42m.fsf@ebiederm.dsl.xmission.com>
	<20040325174942.GC11236@mail.shareable.org>
	<m1ekrgyf5y.fsf@ebiederm.dsl.xmission.com>
	<20040325194303.GE11236@mail.shareable.org>
	<m1ptb0zjki.fsf@ebiederm.dsl.xmission.com>
	<20040327102828.GA21884@mail.shareable.org>
	<m1vfkq80oy.fsf@ebiederm.dsl.xmission.com>
	<20040327214238.GA23893@mail.shareable.org>
	<m1ptax97m6.fsf@ebiederm.dsl.xmission.com>
	<m1brmhvm1s.fsf@ebiederm.dsl.xmission.com>
	<20040328122242.GB32296@mail.shareable.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Mar 2004 13:07:20 -0700
In-Reply-To: <20040328122242.GB32296@mail.shareable.org>
Message-ID: <m14qs8vipz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Eric W. Biederman wrote:
> > > The addictive thing about the prototype implementation was that you
> > > could do ``ln --cow / /some/other/directory'' and you would have an
> > > atomic snapshot of your filesystem.  Definitely not a feature for the
> > > first implementation but certainly something to dream about.
> > 
> > Addictive but broken by design.  If any of the files inside your
> > directory tree have hard links outside of the tree there is no way
> > short of recursing through all of the subdirectories directories to
> > tell if a given inode has is in use.  Except in the special case
> > where you are taking a cow copy of the entire filesystem.  At which
> > point a magic mount option is likely a better interface.
> 
> I don't understand this explanation.  Can you explain again?  What is
> the problem with inodes being in use?

A COW on a directory implies a COW on everything in it.  So the implication
is an atomic snapshot of that directory and everything below it.

Assuming no files are open and in use.  The implementation would
create the cow link on the directory just like it would on a file.
Then when you open/modify a directory or file the cow copies would be
taken up to the point of the original cow directory so you have a
separate directory structure.

All of which works great until you have a file that has one hard link
in your cow directory structure and another hard link outside of
any cow.  An application can come in and modify the file through that
second cow link causing problems.

So the problem is not really with open files at the time of the cow
although there is a variation of it there as well.  At the time of the
cow it is possible to look through the dcache and find all of the
files that are in the cow directory or a subdirectory of the it.  Then
you can make those cow files.   But again you run into the problem of
an application using a file through a link that is not a subdirectory
of the cow directory. 

So in the presence of hard links doing cow on a directory other than
the root directory can not be implemented correctly short of doing a
complete recursive directory copy at the time you create the cow.  At
which point you might as well just copy the directories in user space.
At least the race conditions are easily apparent.

Eric

