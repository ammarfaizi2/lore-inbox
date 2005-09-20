Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbVITB7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbVITB7d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 21:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbVITB7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 21:59:33 -0400
Received: from smtp100.rog.mail.re2.yahoo.com ([206.190.36.78]:46247 "HELO
	smtp100.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964832AbVITB7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 21:59:32 -0400
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event
	under load
From: John McCutchan <ttb@tentacle.dhs.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
In-Reply-To: <Pine.LNX.4.58.0509191821220.2553@g5.osdl.org>
References: <1127177337.15262.6.camel@vertex>
	 <Pine.LNX.4.58.0509191821220.2553@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Sep 2005 22:00:41 -0400
Message-Id: <1127181641.16372.10.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 18:37 -0700, Linus Torvalds wrote:
> 
> On Mon, 19 Sep 2005, John McCutchan wrote:
> > 
> > Below is a patch that fixes the random DELETE_SELF events when the
> > system is under load. The problem is that the DELETE_SELF event is sent
> > from dentry_iput, which is called in two code paths,
> > 
> > 1) When a dentry is being deleted
> > 2) When the dcache is being pruned.
> 
> No no.
> 
> The problem is that you put the "fsnotify_inoderemove(inode);" in the 
> wrong place, and I and Al never noticed.
> 

To quote you:

Instead of the broken fsnotify_unlink/fsnotify_rmdir functions, you can 
split this into two logically _different_ functions:

 - fsnotify_nameremove(dentry) - called when the dentry goes away
 - fsnotify_inoderemove(dentry) - called when the inode goes away

...

The fsnotify_inoderemove() is called from dentry_iput(), and that's the 
one that specifies that an actual inode no longer exists.


;)

> iput() doesn't have anything to do with delete at all, and adding a flag 
> to it would be wrong. The inode may stay around _after_ the unlink() for 
> as long as it has users (or much longer, if you have hardlinks ;). 
> 
> You should probably move the "fsnotify_inoderemove(inode);" call into
> generic_delete_inode() instead, just after "security_inode_delete()".  No
> new flags, just a new place.
> 
> (Oh, I think you need to add it to "hugetlbfs_delete_inode()" too).
> 
> There's still a potential problem there: some network filesystems seem to
> use "generic_delete_inode()" as their "drop_inode" thing. Which may mean 
> that you get spurious delete messages when the reference is dropped. I 
> don't see how to avoid that, though - we fundamentally don't _know_ when 
> the inode actually gets deleted.
> 


I don't think moving it to generic_delete_inode is the right place. 
Anyways, generic_delete_inode is called when the final reference on the
inode is released, but inotify keeps a reference on the inode, so I
don't think it would work.

fsnotify_inoderemove should be called after the dentry for the file is
removed, not when the inode actually goes away. The behaviour inotify
users expect is:

$ watch /tmp/foo (wd = 0)
$ rm /tmp/foo
event sent: DELETE_SELF (wd = 0)

Inotify doesn't care if the inode for /tmp/foo is sticking around for
whatever reason. As far as inotify is concerned, the file is deleted.

-- 
John McCutchan <ttb@tentacle.dhs.org>
