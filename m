Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264397AbUEIVyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264397AbUEIVyH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 17:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264393AbUEIVyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 17:54:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62945 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264397AbUEIVxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 17:53:51 -0400
Date: Sun, 9 May 2004 23:53:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: =?iso-8859-2?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Message-ID: <20040509215351.GA15307@atrey.karlin.mff.cuni.cz>
References: <20040506131731.GA7930@wohnheim.fh-wedel.de> <200405081645.06969.vda@port.imtp.ilyichevsk.odessa.ua> <20040508221017.GA29255@atrey.karlin.mff.cuni.cz> <200405091709.37518.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405091709.37518.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > That is probably unfixable now, but you can avoid making similar
> > > error. Provide is_cowlinked(fd1,fd2) syscall. Pity you will
> > > have to use different inode numbers for cowlinks (due to tar/cp),
> > > and this won't fly:
> >
> > is_cowlinked does not fly, either. For n files, you have to do O(n^2)
> > calls to find those that are linked.
> 
> Hm, let me think about it. diff does not need to check all permutations,
> it checks only those two which it needs to compare.

And tar?

> IMHO "inodes done right" is something like this: if inode numbers are
> different, then files are not hardlinked/cowlinked. If they are the same,
> check is_hardlinked(a,b) or is_cowlinked(a,b) to find out.
> 
> This beats O(n^2) argument.
> 
> But this is non-POSIX, would not be accepted.

I do not see how this matters. cowlinks are already non-POSIX. If
is_hardlinked() always returns 1, but is_cowlinked() sometimes returns
something else, you are still "as much POSIX as possible".

> I don't know how to handle this now. Introducing cow-inode number
> with semantic "cowino1==cowino2 => files are cowlinked" is
> ugly and won't deal with per-block cow. Sooner or later someone
> will want to have per block cow. Think about cow'ing multi-gigabyte
> database files for checkpointing/backup purposes...

Well, if only block 17 is cowlink-shared between two files, I guess
userspace does not want to know... And I think that cow-inode number
*can* handle all other cases.

Oh, get_cow_inode() should really be allowed to fail in some usefull
way, so that filesystems do not have to implement it if its hard for
them.

> > You want get_cowlinked_id which can return -1 "I do not know".
> 
> Is this the same to my "cow-inode number" concept above?

Yes.

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
