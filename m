Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVBWLZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVBWLZw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 06:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVBWLZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 06:25:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60106 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261457AbVBWLZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 06:25:33 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0502221123540.2378@ppc970.osdl.org> 
References: <Pine.LNX.4.58.0502221123540.2378@ppc970.osdl.org>  <20050222190646.GA7079@austin.ibm.com> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: Olof Johansson <olof@austin.ibm.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, jamie@shareable.org,
       rusty@rustcorp.com.au
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 23 Feb 2005 11:24:49 +0000
Message-ID: <5109.1109157889@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> It shouldn't be. If one read writer is active, another should be able to 
> come in, regardless of any pending writer trying to access it. At least 
> that's always been the rule for the rw-spinlocks _exactly_ for this 
> reaseon.

But not with rw-semaphores. I've designed them to be as fair as I can possibly
make them. This means holding reads up if there's a write pending.

> The rwsem code tries to be fairer, maybe it has broken this case in the 
> name of fairness. I personally think fairness is overrated, and would 
> rather have the rwsem implementation let readers come in.

I've seen writer starvation happening due to a continuous flow of overlapping
reads... That's one of the reasons I reimplemented rwsems.

Also, fair rwsems are easier to provide an assembly optimised form for that
doesn't involve the "thundering-herd" approach. Obviously, with the spinlock
approach, you can implement any semantics you desire once you're holding the
spinlock. With the optimised form as implemented, you can't determine how many
active readers there are. This information isn't stored anywhere.

> We have a notion of "atomic get_user()" calls, which is a lot more
> efficient, and is already used for other cases where we have _real_
> deadlocks (inode semaphore for reads into shared memory mappigns).

That's okay, provided the data you're trying to access isn't lurking on a disk
somewhere.

> > Auditing other read-takers of mmap_sem, I found one more exposure that
> > could be solved by just moving code around.
> 
> DavidH - what's the word on nested read-semaphores like this? Are they 
> supposed to work (like nested read-spinlocks), or do we need to do the 
> things Olof does?

Nesting rwsems like this is definitely on the not-recommended list.

For the special case of the mmap semaphore, I'd advocate following something
like Jamie Lokier's solution, and note when a task holds its own mmap_sem
semaphore read-locked such that page-fault can avoid taking it again.

Something like:

	struct task_struct {
		...
		unsigned mmsem_nest;
		...
	};

	static inline void lock_mm_for_read(struct mm_struct *mm) {
		if (current->mm == mm &&
		    current->mmsem_nest++ != 0)
			;
		else
			down_read(&mm->mmap_sem);
	}

	static inline void unlock_mm_for_read(struct mm_struct *mm) {
		if (current->mm == mm &&
		    --current->mmsem_nest != 0)
			;
		else
			up_read(&mm->mmap_sem);
	}

	static inline void lock_mm_for_write(struct mm_struct *mm) {
		down_write(&mm->mmap_sem);
	}

	static inline void unlock_mm_for_write(struct mm_struct *mm) {
		up_write(&mm->mmap_sem);
	}

Though I'd be tempted to say that faulting is the only case in which recursion
is permitted, and change the first two functions to reflect this and add an
extra pair specially for page-fault:

	static inline void lock_mm_for_read(struct mm_struct *mm) {
		down_read(&mm->mmap_sem);
		if (current->mm == mm &&
		    current->flags |= PF_MMAP_SEM)
	}

	static inline void unlock_mm_for_read(struct mm_struct *mm) {
		if (current->mm == mm &&
		    current->flags &= ~PF_MMAP_SEM)
		up_read(&mm->mmap_sem);
	}

	static inline void lock_mm_for_fault(struct mm_struct *mm) {
		if (!(current->flags & PF_MMAP_SEM))
			down_read(&mm->mmap_sem);
	}

	static inline void unlock_mm_for_fault(struct mm_struct *mm) {
		if (!(current->flags & PF_MMAP_SEM))
			up_read(&mm->mmap_sem);
	}

If current->mm is passed as the argument, the compiler's optimiser should
discard the first comparison in the if-statement.

Then futex.c would hold:

	lock_mm_for_read(&current->mm);
	get_futex_key(...) etc.
	queue_me(...) etc.
	ret = get_user(...);
	/* the rest */
	unlock_mm_for_read(&current->mm);

And do_page_fault() would hold:

	lock_mm_for_fault(&current->mm);
	...
	unlock_mm_for_fault(&current->mm);

David
