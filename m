Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbUCPTlo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 14:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbUCPTlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 14:41:36 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:24198 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261516AbUCPTka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 14:40:30 -0500
Message-Id: <200403161940.i2GJeP6m007930@eeyore.valparaiso.cl>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unionfs 
In-Reply-To: Your message of "Tue, 16 Mar 2004 19:04:13 +0100."
             <20040316180413.GA22482@wohnheim.fh-wedel.de> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Tue, 16 Mar 2004 15:40:24 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de> said:
> On Tue, 16 March 2004 18:31:47 +0100, Jörn Engel wrote:
> > On Tue, 16 March 2004 12:04:30 -0400, Horst von Brand wrote:
> > > 
> > > What happens if I mount the live 2.6.4 kernel source over a CD containing
> > > 2.5.30? What happens to identical files, files that moved, changed files,
> > > deleted files? Pray tell, how does the kernel find out which is which?
> > 
> > What happens if I write to /dev/hda while having my rootfs /dev/hda1?
> > Bad things, damn right.  But why would anyone do that?
> 
> There is really no point to this discussion, as it looks like a big
> misunderstanding.  Maybe you object less if you see the design:
> 
> Variant 1 (just a single filesystem):
> 
> - Introduce a new variant of links, which I call COW.
> - COWs can only link to hidden inodes.
> - Hidden inodes cannot be accessed directly.
> - COWs look like regular files to userspace.
> - Read access to COWs goes to the hidden inode.
> - Write access to COWs copies the hidden inode before writing to it.
> - Copying file1 to file2 does four things:
>   - Create a new hidden inode.
>   - Move data from file1 to hidden inode.
>   - Turn file1 into COW and link to hidden inode.
>   - Create COW for file2 and link to hidden inode.

Looks an awful lot like symlinks...

> There are some more special cases, but this is basically it.  So let's
> use the stuff a little:
> 
> $ cp -cr dir1 dir2
> 
> Behaves similar to 'cp -lr', but creates COWs instead of hard links.
> Can take a few seconds to create the directories, but not minutes.

Why does it magically take less time? The work done (recursing, fiddling
with directories, syscalls, ...) is nearly the same.

> $ vi dir2/bunch*of*files
> 
> Writing to those files makes a real copy for each.  dir1/* remains
> unaffected, no matter how careless you are.  We've made it foolproof,
> so the universe has to create greater fools again, right?

Just do it again, thinking _these_ versions are the ones safe from
fat-fingering...

> $ rm -rf dir2
> 
> Scraps one of the copies along with all modifications.  dir1/* remains
> unaffected gain.
> 
> $ cp -cr /fs1/dir1 /fs2/dir2
> 
> Fails, since links between different filesystems don't work.

Why?

How do you push changes back if needed? How do you get back the version 3
changes back? Oops, can't do... 

You do want version control.

> Variant 2 (across multiple filesystems now):
> 
> - COWs contain a filesystem identifier as well.
> - Accessing COWs linking to unavaillable filesystems returns -E...
> Alternatively:
> - Mounting such an fs fails, unless all links work.
> 
> Usage is as above.
> 
> $ mkfs /dev/fs2
> $ mount /dev/fs2 /fs2
> $ cp -cr /fs1 /fs2
> 
> Creates an identical copy of one filesystem on another one.  fs2 has
> to support COWs and fs2 has to be RO or support COWs.  A rw-fs mounted
> ro means trouble, as you know.
> 
 This is just one filesystem. Where are the others?

> Maybe I'm just stupid and missed some important detail, but this
> design looks like it can solve a bunch of problems.  Do you still
> think, it is useless?

I still think there are much better solutions to the problems you mention.

What I'd love to see is something like, say /usr for each package (complete
with binaries in /usr/bin/, manuals in /usr/share/man/, ...) that you can
mount together in any combination wanted (even per-user, a la Plan 9) over
/usr and have it fully populated. But that gets horribly messy when you
want files from different versions (say, I've got an overlay for vi(1) that
fixes a horrible bug, but the manual is in Czech, and I prefer English) to
show up on top, or have files one on top of the other (source code
versions?) and you delete/modify/move the top one. What happens then? If
you can't come up with a sensible interpretation of Unix file operations in
this scenario (and you can't, trust me), the idea is doomed.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
