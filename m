Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135222AbRDVFyM>; Sun, 22 Apr 2001 01:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135224AbRDVFyB>; Sun, 22 Apr 2001 01:54:01 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:53246 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135222AbRDVFxv>;
	Sun, 22 Apr 2001 01:53:51 -0400
Date: Sun, 22 Apr 2001 01:53:49 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Roman Zippel <zippel@fh-brandenburg.de>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Races in affs_unlink(), affs_rmdir() and affs_rename()
In-Reply-To: <3AE206AC.E196AEBA@linux-m68k.org>
Message-ID: <Pine.GSO.4.21.0104220142150.27021-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 22 Apr 2001, Roman Zippel wrote:

> This is possible with affs, but will already deadlock in vfs.
> 
> mkdir A
> mkdir A/B
> ln A A/B/C
> rm A/B/C/A &
> rm A/B/C &
> rm A/B
> 
> Every rm already takes the hash lock of the parent and then I can't
> simply also take the hash lock of the dir itself. What I actually want
> to do is to insert a reverse is_subdir() check before taking the lock.
> On the other hand I was thinking whether I should allow links to dirs at
> all and just show them as empty/readonly dirs. For 2.4 that's probably
> safer, as it would require a lot of locking changes in vfs and the other
> fs to support this properly, particularly moving most of the locking
> from vfs into the fs.

And all that to support a misfeature present in one legacy filesystem?
Don't forget that find et.al. are going to die on loops in directory
tree, so you'd also need to change large chunk of userland code.

By the way, how would you detect the attempts to detach a subtree by
rmdir()/rename() with the multiple links on directories? Again, forget about
the VFS side of that business, the question is how to check that
required change doesn't make on-disk data structures inconsistent.

As far I know even native (AmigaOS) implementation doesn't handle
directory links correctly. So I don't see much point in allowing them
even for compatibility purposes.

Seriously, screw the directory links - getting the thing work correctly
without them has much higher priority.

