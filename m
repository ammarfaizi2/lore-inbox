Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273009AbRIISVn>; Sun, 9 Sep 2001 14:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273010AbRIISVe>; Sun, 9 Sep 2001 14:21:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12042 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273009AbRIISV3>; Sun, 9 Sep 2001 14:21:29 -0400
Date: Sun, 9 Sep 2001 11:17:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <Pine.LNX.4.33L.0109090909001.21049-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0109091105380.14479-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Sep 2001, Rik van Riel wrote:
> On Sat, 8 Sep 2001, Linus Torvalds wrote:
>
> > It's only filesystems that have modified buffers without marking them
> > dirty (by virtue of having pointers to buffers and delaying the dirtying
> > until later) that are broken by the "try to make sure all buffers are
> > up-to-date by reading them in" approach.
>
> Think of the inode and dentry caches.  I guess we need
> some way to invalidate those.

Note that we've never done it before. The inode and dentry caches have
never been coherent with the buffer cache, and we have in fact
historically not even tried to shrink them (to try to minimize the impact
of the non-coherency).

The inode data in memory doesn't even show _up_ in the buffer cache, for
example. Much less dentries, which are so virtualized inside the kernel
that they have absolutely no information on whether they exist on a disk
at all, much less any way to map them to a disk location.

I agree that coherency wrt fsck is something that theoretically would be a
GoodThing(tm). And this is, in fact, why I believe that filesystem
management _must_ have a good interface to the low-level filesystem.
Because you cannot do it any other way.

This is not a fsck-only issue. I am a total non-believer in the "dump"
program, for example. I always found it to be a totally ridiculous and
idiotic way to make backups. It would be much better to have good
(filesystem-independent) interfaces to do what "dump" wants to do (ie have
ways of explicitly bypassing the accessed bits and get the full inode
information etc).

Nobody does a "read()" on directories any more to parse the directory
structure. Similarly, nobody should have done a "dump" on the raw device
any more for the last 20 years or so. But some backwards places still do.

Backup of a live filesystem should be much easier than fsck of a live
filesystem, but I believe that there are actually lots of common issues
there, and such an interface should eventually be designed with both in
mind. Both want to get raw inode lists, for exaple. Both potentially want
to be able to read (and specify) block positions on the disk. Etc etc.

And notice now de-fragmentation falls neatly into this hole too: I bet
that if you had good management interfaces for fsck and backup, you'd
pretty much automatically be able to do defrag through the same
interfaces.

			Linus

