Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbUDBLyO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 06:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263018AbUDBLyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 06:54:13 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:46095 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S262766AbUDBLyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 06:54:11 -0500
To: linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1080906456@astro.swin.edu.au>
Subject: Re:  [PATCH] cowlinks v2
In-reply-to: <m1k718zi5r.fsf@ebiederm.dsl.xmission.com>
References: <20040321125730.GB21844@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0403210944310.12359-100000@bigblue.dev.mdolabs.com> <20040321181430.GB29440@wohnheim.fh-wedel.de> <m1y8ptu42m.fsf@ebiederm.dsl.xmission.com> <20040325174942.GC11236@mail.shareable.org> <m1ekrgyf5y.fsf@ebiederm.dsl.xmission.com> <20040325194303.GE11236@mail.shareable.org> <Pine.LNX.4.58.0403251237200.1106@ppc970.osdl.org> <m1k718zi5r.fsf@ebiederm.dsl.xmission.com>
X-Face: "0\RuOFb6AcQ}B_F/^%;;AmS%><zZ_q?N1w1%1voDY7#Ywj~qRaL7].8HB'2~pDUS|{E=$R\-s?;+p!RCe:w||kS\T@[(eQHB*-8u;~)ZP4;QYUI`|GJ)NS\`jLbW<e'R*y+Od,S5D+Vz++a<[$g'>"qr*^0t%eriBMe_x]B7&@b8_\i<A/A@T
Message-ID: <slrn-0.9.7.4-23063-17448-200404022147-tc@hexane.ssi.swin.edu.au>
Date: Fri, 2 Apr 2004 21:54:09 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) said on 25 Mar 2004 15:16:48 -0700:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Thu, 25 Mar 2004, Jamie Lokier wrote:
> > > 
> > > That is not useful for me or the other people who want to use this to
> > > duplicate large source trees and run "diff" between trees.
> > > 
> > > "diff" depends on being able to check if files in the two trees are
> > > identical -- by checking whether the inode number and device (and
> > > maybe other stat data) are identical.  This allows "diff -ur" between
> > > two cloned trees the size of linux to be quite fast.  Without that
> > > optimisation, it's very slow indeed.
> > 
> > I think the correct thing to do is to just admit that cowlinks aren't
> > POSIX, and instead see the inode number as a way to see whether the link
> > has been broken or not. Ie just accept the inode number potentially
> > changing.
> > 
> > That would make "diff" (adn most other uses) ok with this, and anythign 
> > that isn't, just couldn't be used with cowlinked files.
> 
> Really?
> 
> tar and cp still need to be taught about them.  And if they are not taught
> they will do the wrong thing and hard link the files removing the
> copy on write semantics.  Which would do ugly thing when you restore
> from your backup.
> 
> I don't have a problem with the inode number changing when you write to
> a file, because I can't think of much that would care either way.
> But having the inode number of an open file change sounds like a very
> difficult problem to track. 

If the inode doesn't change upon a write, the system is still POSIX,
so nothing breaks (the problem is, cowlinks would be very useful, and
POSIX is very useful - making them incompatible would be a major
bummer)

If you use sendfile() or cowcp() or similar to implement cowlinks,
then only rsync/tar/cp need be taught about its usage. Someone
mentioned that diff will not be optimal with different inodes, because
diff compared inodes. So add some diffstat() that keeps track of some
magical inode like thingy that stays the same for cowed files. Then
teach diff to use diffstat().

Now, you have a system where if your program doesn't explicitly use
cowcp() and diffstat(), everything still works perfectly (we want to
still be able to use old coreutils on a machine that has a new kernel
applied, right? And vice-versa?). All that happens is that your
program may or may not be sub-optimal - you might have to compare
entire files instead of just inodes. Or you may have to copy entire
files instead of just cowing them. But it all still Just Works.

My AU$0.02.

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
I bet the human brain is a kludge.
                -- Marvin Minsky
