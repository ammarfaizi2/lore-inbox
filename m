Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268346AbUIPQlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268346AbUIPQlT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 12:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268410AbUIPQlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 12:41:05 -0400
Received: from peabody.ximian.com ([130.57.169.10]:9931 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268346AbUIPQkH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 12:40:07 -0400
Subject: Re: [RFC][PATCH] inotify 0.9
From: Robert Love <rml@novell.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <cic9os$ibd$1@gatekeeper.tmr.com>
References: <1095263565.19906.19.camel@vertex>
	 <cic9os$ibd$1@gatekeeper.tmr.com>
Content-Type: text/plain
Date: Thu, 16 Sep 2004 12:39:02 -0400
Message-Id: <1095352742.23385.148.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-16 at 11:07 -0400, Bill Davidsen wrote:

> Did you work for Microsoft? Bloat doesn't count? And is this going to be 
>   low memory you pin? And is every file create or delete (or update of 
> atime) going to blast this mess through cache looking for people to notify?

No.  I suggest looking at the source.

We are pinning the very inodes we are using.  So,

	(a) There is no cache effects because the inodes are already
	    in use.  So when you go to, say, write to a file the kernel
	    already has the inode handy, and we just check in O(1) to
	    see if the inode has a watcher on it.  We never walk a list
	    of inodes (why would you ever do that?  how would you do
	    that?).
	(b) Many of the pinned inodes are already in memory, cached,
	    since the probability of of used inodes and watched inodes
	    is high.  Right now, on a system without inotify, I have
	    60MB of inodes in memory.
	(c) The inodes are pinned to prevent races.  Or, don't even
	    look at it like this.  Just look at it as elevating the
	    ref count on the data structure while we are using it.

But here is the kicker: I don't think this pinning behavior is any
different than dnotify.  So this is a total utter nonissue.

> > Older release notes:
> > I am resubmitting inotify for comments and review. Inotify has
> > changed drastically from the earlier proposal that Al Viro did not
> > approve of. There is no longer any use of (device number, inode number)
> > pairs. Please give this version of inotify a fresh view.
> 
> We are hacking all over the kernel to save 4k in stack size and you want 
> to pin up to 32MB?

The 4K is 4K per process, and it is done not to save 4K once (or even
4K*number of processes) but because first order allocations (8KB on x86)
become nontrivial as memory becomes fragmented.

I bet on most modern systems there is already much more than 32MB of
inodes in memory, and you have to explicitly add watches anyhow.

> If I were doing this, and I admit I may not understand all of the 
> features, I would have a bitmap per filesystem of inodes being watched, 
> and anything which did an action which might require notify would check 
> the bit. If the bit were set the filesystem and inode info would be 
> passed to user space which could do anything it wanted. Use of the 
> netlink is an example of ways to do this.

Race, race, race, if even possible to implement "a bitmap per filesystem
of inodes" in a sane way.

> Then the user program could do whatever it wanted in nice pageable 
> space, allow as many watchers as it wished, and be flexible to anything 
> a site wanted, scalable, could use semaphores, fifos, network 
> monitoring, message queues... in other words low impact, scalable, and 
> flexible.

If you assume that you have to pin the inodes while you watch them (and
you do), then inotify really is this minimum abstraction that you talk
of.

> Feel free to tell me there is some urgent need for this feature to be 
> present and fast, I learn new things every day.

You act like file notification is something new.  Every operating system
provides this feature.  Linux currently does, too: dnotify.

But dnotify sucks, and modern systems are hitting its numerous limits.
So, enter inotify.

Fondest regards,

	Robert Love


