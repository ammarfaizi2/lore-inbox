Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVBVTgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVBVTgW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 14:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVBVTgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 14:36:22 -0500
Received: from fire.osdl.org ([65.172.181.4]:19344 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261425AbVBVTgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 14:36:10 -0500
Date: Tue, 22 Feb 2005 11:36:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Olof Johansson <olof@austin.ibm.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, jamie@shareable.org,
       rusty@rustcorp.com.au, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
In-Reply-To: <20050222190646.GA7079@austin.ibm.com>
Message-ID: <Pine.LNX.4.58.0502221123540.2378@ppc970.osdl.org>
References: <20050222190646.GA7079@austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Feb 2005, Olof Johansson wrote:
> 
> Consider a small testcase that spawns off two threads, either thread
> doing a loop of:
> 
> 	buf = mmap /dev/zero MAP_SHARED for 0x100000 bytes
> 	call sys_futex (buf+page, FUTEX_WAIT, 1, NULL, NULL) for each page in said mmap
> 	munmap(buf)
> 	repeat
> 
> This will quickly lock up, since the futex_wait code dows a
> down_read(mmap_sem), then a get_user().
> 
> The do_page_fault code on ppc64 (as well as other architectures) needs
> to take the same semaphore for reading. This is all good until the
> second thread comes into play: Its mmap call tries to take the same
> semaphore for writing which causes in the do_page_fault down_read()
> to get stuck. Classic deadlock.

It shouldn't be. If one read writer is active, another should be able to 
come in, regardless of any pending writer trying to access it. At least 
that's always been the rule for the rw-spinlocks _exactly_ for this 
reaseon.

The rwsem code tries to be fairer, maybe it has broken this case in the 
name of fairness. I personally think fairness is overrated, and would 
rather have the rwsem implementation let readers come in. But if we really 
don't want that, then:

> One attempt to fix this is included below. It works, but I'm not entirely
> happy with the fact that it's a bit messy solution. If anyone has a
> better idea for how to solve it I'd be all ears.

We have a notion of "atomic get_user()" calls, which is a lot more 
efficient, and is already used for other cases where we have _real_
deadlocks (inode semaphore for reads into shared memory mappigns).

See "__copy_to_user_inatomic()", and in particular note that it
effectively _is_ legal to do user accesses with the preempt-count elevated 
or interrupts disabled to tell the page fault handler not to delay (then 
you have to check the error return, and if it returned an error you do it 
the slow way - drop all locks and do a non-atomic access).

> Auditing other read-takers of mmap_sem, I found one more exposure that
> could be solved by just moving code around.

DavidH - what's the word on nested read-semaphores like this? Are they 
supposed to work (like nested read-spinlocks), or do we need to do the 
things Olof does?

		Linus
