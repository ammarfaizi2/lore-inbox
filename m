Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbVITEwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbVITEwK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 00:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbVITEwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 00:52:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12010 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932512AbVITEwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 00:52:09 -0400
Date: Mon, 19 Sep 2005 21:52:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: John McCutchan <ttb@tentacle.dhs.org>
cc: Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event under
 load
In-Reply-To: <1127190971.18595.5.camel@vertex>
Message-ID: <Pine.LNX.4.58.0509192144150.2553@g5.osdl.org>
References: <1127177337.15262.6.camel@vertex>  <Pine.LNX.4.58.0509191821220.2553@g5.osdl.org>
  <1127181641.16372.10.camel@vertex>  <Pine.LNX.4.58.0509191909220.2553@g5.osdl.org>
  <1127188015.17794.6.camel@vertex>  <Pine.LNX.4.58.0509192054060.2553@g5.osdl.org>
  <20050920042456.GC7992@ftp.linux.org.uk> <1127190971.18595.5.camel@vertex>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Sep 2005, John McCutchan wrote:
> 
> > 	* removal of this link, at the moment when it stops being accessible
> > [ none of the above, better done from vfs_...() ]
> 
> That is the behaviour we want, how does Linus's second patch not
> accomplish this? 

My latest patch will still wait for any other process that has that _path_ 
open to release it.

The reason? It looks "easy" to do it from d_delete(), but the thing is, at
the point where we've released the d_lock spinlock, the "struct inode" is
gone, gone, gone. And we don't want to do the notification _while_ we hold
the spinlocks either.

So we can either do it the easy way - _before_ we get any spinlocks (but
that means that processes will be notified before the name is actually
gone), or we have to wait until _after_ we've unhashed the dentry and
released the spinlocks.

But waiting until after that automatically means that the inode isn't 
stable any more: it might be gone.

The "fsnotify_nameremove()" thing doesn't have this problem, because it 
simply doesn't even care about the inode - it only cares about the dentry, 
which is stable.

This is why movign the release to "dentry_iput()" helps us - it's the
point where we release the dentry spinlocks, and it's also where the inode
actually goes away. In other words, it's the _one_ point where we can
insert the notification outside of the dcache locks but before the inode
is gone.

It's a sligtly inconvenient place, though. And it does mean that if the
dentry was in use by something else when the delete happened, the "inode
is gone"  notification will be delayed until the dentry is really free'd.
However, at least at that point it's really a per-path thing, and it won't 
have any other global issues (ie hardlinks etc do not come into play with
my last patch).

If you want immediate notification when the name disappears, you'd better 
listen to the "nameremove" thing. 

I don't think we can reasonably do better than the last patch, but maybe 
Al sees something I've missed.

		Linus
