Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbVITBh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbVITBh4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 21:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbVITBhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 21:37:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27591 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964826AbVITBhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 21:37:55 -0400
Date: Mon, 19 Sep 2005 18:37:43 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: John McCutchan <ttb@tentacle.dhs.org>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event under
 load
In-Reply-To: <1127177337.15262.6.camel@vertex>
Message-ID: <Pine.LNX.4.58.0509191821220.2553@g5.osdl.org>
References: <1127177337.15262.6.camel@vertex>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Sep 2005, John McCutchan wrote:
> 
> Below is a patch that fixes the random DELETE_SELF events when the
> system is under load. The problem is that the DELETE_SELF event is sent
> from dentry_iput, which is called in two code paths,
> 
> 1) When a dentry is being deleted
> 2) When the dcache is being pruned.

No no.

The problem is that you put the "fsnotify_inoderemove(inode);" in the 
wrong place, and I and Al never noticed.

iput() doesn't have anything to do with delete at all, and adding a flag 
to it would be wrong. The inode may stay around _after_ the unlink() for 
as long as it has users (or much longer, if you have hardlinks ;). 

You should probably move the "fsnotify_inoderemove(inode);" call into
generic_delete_inode() instead, just after "security_inode_delete()".  No
new flags, just a new place.

(Oh, I think you need to add it to "hugetlbfs_delete_inode()" too).

There's still a potential problem there: some network filesystems seem to
use "generic_delete_inode()" as their "drop_inode" thing. Which may mean 
that you get spurious delete messages when the reference is dropped. I 
don't see how to avoid that, though - we fundamentally don't _know_ when 
the inode actually gets deleted.

Al, do you have any comments? Anything stupid I missed?

		Linus
