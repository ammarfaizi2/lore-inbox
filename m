Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423517AbWJaRxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423517AbWJaRxp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 12:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423706AbWJaRxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 12:53:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2259 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423517AbWJaRxp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 12:53:45 -0500
Date: Tue, 31 Oct 2006 09:53:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mark Lord <lkml@rtr.ca>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Takashi Iwai <tiwai@suse.de>, Frederik Deweerdt <deweerdt@free.fr>
Subject: Re: 2.6.19-rc3-git7:  BUG: mutex warning sysfs_dir_open
In-Reply-To: <454785B7.3040600@rtr.ca>
Message-ID: <Pine.LNX.4.64.0610310929090.25218@g5.osdl.org>
References: <454785B7.3040600@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Oct 2006, Mark Lord wrote:
> 
> I found this in my syslog just now:
> 
> kernel: BUG: warning at kernel/mutex.c:132/__mutex_lock_common()

That's the "spin_lock_mutex()" debugging (kernel/mutex-debug.h), and it's 
one of either

	DEBUG_LOCKS_WARN_ON(in_interrupt());
or
	DEBUG_LOCKS_WARN_ON(l->magic != l);

where the much more likely one is the "l->magic" one triggering, because 
your bug that follows is:

> kernel: BUG: unable to handle kernel paging request at virtual address 6e726574

64726574 is "tern", for whatever that's worth, and that EIP is in 
"__list_add()", which comes from list_add_tail(), and so it looks like the 
mutex "lock->lock_list" is also totally buggered (which would certainly 
fit with the lock "magic" field being crud too).

> kernel: Call Trace:
> kernel:  [<c035d76e>] __mutex_lock_slowpath+0x8e/0x260
> kernel:  [<c035d961>] mutex_lock+0x21/0x30
> kernel:  [<c01a0286>] sysfs_dir_open+0x26/0x60

This would be

	mutex_lock(&dentry->d_inode->i_mutex);

in sysfs_dir_open(), so you would seem to have an inode that is 
overwritten by crud (or it could be a dentry with a bogus d_inode 
pointer, of course).

There's a ton of stuff with "tern" in it, mostly "Internal", so sadly even 
the nice string pattern doesn't seem to be all that helpful.

Is this somewhat reproducible? 

HOWEVER, google does find a clue. We've had reports of something somewhat 
similar before: googling for "__mutex_lock_slowpath" and "sysfs_dir_open" 
shows for example

	http://lkml.org/lkml/2006/8/18/72

where the thread ended up first blaming sound, but then deciding that 
maybe it was DRM-related. However, you don't seem to have any AGP or DRM 
support at all, so maybe it really _is_ a sound problem.

Mark - can you verify that you don't have any DRM support in your kernel?

Frederic, Takashi, did that bug-report ever get resolved?

		Linus
