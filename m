Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWBOWQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWBOWQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 17:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWBOWQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 17:16:26 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:49099 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751258AbWBOWQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 17:16:25 -0500
Date: Wed, 15 Feb 2006 23:14:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, tglx@linutronix.de,
       arjan@infradead.org, dsingleton@mvista.com
Subject: Re: [patch 0/5] lightweight robust futexes: -V1
Message-ID: <20060215221434.GA20104@elte.hu>
References: <20060215151711.GA31569@elte.hu> <20060215134556.57cec83a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060215134556.57cec83a.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > ...
> >
> > E.g. in David Singleton's robust-futex-6.patch, there are 3 new syscall 
> > variants to sys_futex(): FUTEX_REGISTER, FUTEX_DEREGISTER and 
> > FUTEX_RECOVER. The kernel attaches such robust futexes to vmas (via 
> > vma->vm_file->f_mapping->robust_head), and at do_exit() time, all vmas 
> > are searched to see whether they have a robust_head set.
> 
> hm.  What happened if the futex was in anonymous memory 
> (vm_file==NULL)?

The primary focus of that patch AFAICT was to handle the inter-process 
robustness case - i.e. the named mapping case. Process-internal 
robustness was already offered by glibc. But there were also add-on 
patches IIRC that enabled "on-heap" robust futexes - which would be 
anonymous memory. I think the vma/address-space-based robust futex 
support patch was mainly limited by VM constraints: a new field in the 
vma was opposed, which reduced the utility of the patch.

This i think further underlines that the entire vma/address-space-based 
approach is faulty: IMO robustness should not be offered that deeply 
within the kernel - it should be attached to the real futex object 
itself - i.e. to the userspace lock.

Our patch unifies the two methods (intra-process and inter-process 
robust mutexes) in a natural way, and further improves process-internal 
robustness too: premature thread exits that happen without going though 
glibc [e.g. doing an explicit sys_exit syscall] are detected too.

> > The list is guaranteed to be private and per-thread, so it's lockless. 
> >
> 
> Why is that guaranteed?? Another thread could be scribbling on it 
> while the kernel is walking it?

Yeah, glibc guarantees that the list is private. But the kernel does not 
trust the list in any case. If the list is corrupted (accidentally or 
deliberately) then there's no harm besides the app not working: the 
kernel will abort the list walk silently [or will wake up the wrong 
futexes - which userspace could have done too] and glibc wont get the 
proper futex wakeups, apps will hang, users will moan, userspace will 
get fixed eventually.

The kernel's list walking assumptions are not affected by whatever 
userspace activity - the kernel assumes the worst case: that Kevin 
Mitnick is sitting in another thread and trying to prod the kernel into 
allow him to do long-distance calls for free.

> Why use a list and not just a sparse array? (realloc() works..)

this list is deep, deep within glibc. Glibc might even use robustness 
for some of its internal locks in the future, so i'd hate to make it 
dependent on a higher-level construct like realloc(). Nor is a sparse 
array necessary: a linked list within pthread_mutex_t is the fastest 
possible way to do this - we touch the pthread_mutex_t anyway, and the 
list head is in the Thread Control Block (TCB) - which is always 
cache-hot in these cases. All the necessary structure addresses are in 
registers already.

another problem is that the glibc-internal space at the TCB (which would 
be the primary place for such a lock-stack) is limited - so the lock 
stack would have to be allocated separately, adding extra indirection 
cost and complexity.

also, a sparse array is pretty much the same thing as a linked list - 
there's no fundamental difference between them, except that for lists 
it's easier to do circularity (which the kernel avoids too). [a sparse 
array can be circular too in theory: e.g. 32-bit userspace could map 4GB 
and the sparse index could overflow.] Pretty much the only fundamental 
difference is that such a sparse array would be in thread-local storage 
- but that would also be a disadvantage.

also, there is no guarantee that unlocking happens in the same order as 
locking, so we'd force userspace into a O(N) unlocking design. The list 
based method OTOH still allows userspace to use a double-linked list.

so both are unsafe user-space constructs the kernel must not trust: a 
sparse array might point into (or iterate into) la-la land just as much 
as a list. The fastest and most lightweight solution, considering the 
existing internals of pthread_mutex_t, is a list.

> > There is one race possible though: since adding to and removing from the 
> > list is done after the futex is acquired by glibc, there is a few 
> > instructions window for the thread (or process) to die there, leaving 
> > the futex hung. To protect against this possibility, userspace (glibc) 
> > also maintains a simple per-thread 'list_op_pending' field, to allow the 
> > kernel to clean up if the thread dies after acquiring the lock, but just 
> > before it could have added itself to the list. Glibc sets this 
> > list_op_pending field before it tries to acquire the futex, and clears 
> > it after the list-add (or list-remove) has finished.
> 
> Oh.  I'm surprised that glibc cannot just add the futex to the list 
> prior to acquiring it, then the exit-time code can work out whether 
> the futex was really taken-and-contended.  Even if the kernel makes a 
> mistake it either won't find a futex there or it won't wake anyone up.

careful: while the 'held locks list' is per-thread and private, the 
pthread_mutex_t object is very much shared between threads and between 
processes! So the list op cannot be done prior acquiring the mutex. 

after the mutex has been acquired, the list entry can be used in the 
private list - this thread is owning the lock exclusively. Similarly, at 
pthread_mutex_unlock() time, we must first remove ourselves from the 
private list, only then can we release the lock. (otherwise another 
thread could grab the lock and could corrupt the list)

but your suggestion would work with the sparse array based method: but 
having a list_op_pending field is really a non-issue - it's akin to 
having to fetch the current index of the sparse array [and having to 
search the array whether we have the right entry]. Arrays have other 
problems like size, and they are also a detached cacheline from the 
synchronization object - a list entry is more natural here.

> I think the patch breaks the build if CONFIG_FUTEX=n?

ok, i'll fix this.

> The patches are misordered - with only the first patch applied, the 
> kernel won't build.  That's a nasty little landmine for git-bisect 
> users.

ok, i'll fix this too.

> Why do we need sys_get_robust_list(other task)?

just for completeness for debuggers - when i added the TLS syscalls 
debugging people complained that there was no easy way to query the TLS 
settings of a thread. I didnt want to add yet another ptrace op - but 
maybe that's the right solution? ptrace is a bit clumsy for things like 
this - the task might not be ptrace-able, while querying the list head 
is such an easy thing.

	Ingo
