Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132038AbRDTTyS>; Fri, 20 Apr 2001 15:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132027AbRDTTyK>; Fri, 20 Apr 2001 15:54:10 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:19439 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132038AbRDTTxw>;
	Fri, 20 Apr 2001 15:53:52 -0400
Date: Fri, 20 Apr 2001 15:53:45 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jeremy Fitzhardinge <jeremy@goop.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>, autofs@linux.kernel.org
Subject: Re: Fix for SMP deadlock in autofs4
In-Reply-To: <Pine.LNX.4.31.0104201158290.5632-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0104201516480.21455-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Apr 2001, Linus Torvalds wrote:

> Why are we doing the mntget/dget at all? We hold the spinlock, so we know
> they are not going away. Not doing the mntget/dget means that we (a) run
> faster and (b) don't have the bug, because we don't need to put the damn
> things.
> 
> Comments?

It looks like you are right, but I wonder how the hell did that code
happen at all. Looks like somewhere around 2.4.0-test10-pre* dcache_lock
was moved out of is_tree_busy() and covered dget/dput. Hmm... Might be
my fault - I don't remember doing that, but...
 
Anyway, it looks like in that case we can forget about games with
->d_count/->mnt_count. Other cases when we do "safe" dput() under
spinlocks are done under _different_ spinlocks, so they are not
a problem.
 
Removing that will require an obvious change in is_tree_busy() (shift
count by 1). However, the real question is WTF are we trying to 
get in autofs4_expire() - it returns dentry without grabbing a
reference to it. The only thing that saves us is that we have a
ramfs-style situation (dentries are pinned until we rmdir) and
everything up to the point where we silently forget about dentry
is covered by BKL. Since ->rmdir() is under BKL too it's enough,
but... Eww... 

Jeremy, what are you really trying to do there? is_tree_busy()
seems to be written in assumption that mnt/dentry is not a
mountpoint but root of a subtree with something mounted on its
leaves. And autofs4_expire() traverses the list of root's
subdirectories, picks one that has nothing busy mounted in
_its_ subdirectories and essentially pass the name to caller.
Which sends that name (of first-level subdirectory) to
userland.

Is that what you really want there? It looks very odd - why don't we pass
the names of actual mountpoints? What's wrong with the case when foo/bar
is busy, but foo/baz is not?
								Al


