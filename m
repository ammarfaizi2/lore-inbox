Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUCPSEb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 13:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUCPSEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 13:04:31 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:22672 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261179AbUCPSE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 13:04:27 -0500
Date: Tue, 16 Mar 2004 19:04:13 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unionfs
Message-ID: <20040316180413.GA22482@wohnheim.fh-wedel.de>
References: <40563A2B.4040800@nortelnetworks.com> <200403161604.i2GG4Vcl004724@eeyore.valparaiso.cl> <20040316173146.GB27046@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040316173146.GB27046@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 March 2004 18:31:47 +0100, Jörn Engel wrote:
> On Tue, 16 March 2004 12:04:30 -0400, Horst von Brand wrote:
> > 
> > What happens if I mount the live 2.6.4 kernel source over a CD containing
> > 2.5.30? What happens to identical files, files that moved, changed files,
> > deleted files? Pray tell, how does the kernel find out which is which?
> 
> What happens if I write to /dev/hda while having my rootfs /dev/hda1?
> Bad things, damn right.  But why would anyone do that?

There is really no point to this discussion, as it looks like a big
misunderstanding.  Maybe you object less if you see the design:

Variant 1 (just a single filesystem):

- Introduce a new variant of links, which I call COW.
- COWs can only link to hidden inodes.
- Hidden inodes cannot be accessed directly.
- COWs look like regular files to userspace.
- Read access to COWs goes to the hidden inode.
- Write access to COWs copies the hidden inode before writing to it.
- Copying file1 to file2 does four things:
  - Create a new hidden inode.
  - Move data from file1 to hidden inode.
  - Turn file1 into COW and link to hidden inode.
  - Create COW for file2 and link to hidden inode.

There are some more special cases, but this is basically it.  So let's
use the stuff a little:

$ cp -cr dir1 dir2

Behaves similar to 'cp -lr', but creates COWs instead of hard links.
Can take a few seconds to create the directories, but not minutes.

$ vi dir2/bunch*of*files

Writing to those files makes a real copy for each.  dir1/* remains
unaffected, no matter how careless you are.  We've made it foolproof,
so the universe has to create greater fools again, right?

$ rm -rf dir2

Scraps one of the copies along with all modifications.  dir1/* remains
unaffected gain.

$ cp -cr /fs1/dir1 /fs2/dir2

Fails, since links between different filesystems don't work.


Variant 2 (across multiple filesystems now):

- COWs contain a filesystem identifier as well.
- Accessing COWs linking to unavaillable filesystems returns -E...
Alternatively:
- Mounting such an fs fails, unless all links work.

Usage is as above.

$ mkfs /dev/fs2
$ mount /dev/fs2 /fs2
$ cp -cr /fs1 /fs2

Creates an identical copy of one filesystem on another one.  fs2 has
to support COWs and fs2 has to be RO or support COWs.  A rw-fs mounted
ro means trouble, as you know.


Maybe I'm just stupid and missed some important detail, but this
design looks like it can solve a bunch of problems.  Do you still
think, it is useless?

Jörn

-- 
The cheapest, fastest and most reliable components of a computer
system are those that aren't there.
-- Gordon Bell, DEC labratories
