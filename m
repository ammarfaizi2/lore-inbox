Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVBVVaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVBVVaN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 16:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVBVVaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 16:30:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:52922 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261258AbVBVV3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 16:29:55 -0500
Date: Tue, 22 Feb 2005 13:30:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Andrew Morton <akpm@osdl.org>, Olof Johansson <olof@austin.ibm.com>,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
In-Reply-To: <20050222210752.GG22555@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0502221317270.2378@ppc970.osdl.org>
References: <20050222190646.GA7079@austin.ibm.com> <20050222115503.729cd17b.akpm@osdl.org>
 <20050222210752.GG22555@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Feb 2005, Jamie Lokier wrote:
> 
> A much simpler solution (and sorry for not offering it earlier,
> because Andrew Morton pointed out this bug long ago, but I was busy), is:
> 
> In futex.c:
> 
> 	down_read(&current->mm->mmap_sem);
> 	get_futex_key(...) etc.
> 	queue_me(...) etc.
> 	current->flags |= PF_MMAP_SEM;             <- new
> 	ret = get_user(...);
> 	current->flags &= PF_MMAP_SEM;             <- new
> 	/* the rest */

That is uglee. 

We really have this already, and it's called "current->preempt". It 
handles any lock at all, and doesn't add yet another special case to all 
the architectures.

Just do

	repeat:
		down_read(&current->mm->mmap_sem);
		get_futex_key(...) etc.
		queue_me(...) etc.
		inc_preempt_count();
		ret = get_user(...);
		dec_preempt_count();
		if (unlikely(ret)) {
			up_read(&current->mm->mmap_sem);
			/* Re-do the access outside the lock */
			ret = get_user(...);
			if (!ret)
				goto repeat;
			return ret;
		}
		...

and you should be ok.

No new special cases, no new abstractions. At most, we should probably 
create a "get_user_inatomic()", to 

 - make it damn obvious what we're doing, and match the explicit
   "inatomic" in the other place where we depend on this (fs/filemap.c)

 - allow the regular "get_user()" to continue to do the normal
   "might_sleep()" checks.

That's assuming we can't just make rwsem's nest nicely.

			Linus
