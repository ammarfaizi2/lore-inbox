Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133087AbRDRRKD>; Wed, 18 Apr 2001 13:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133113AbRDRRJy>; Wed, 18 Apr 2001 13:09:54 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:35596 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S133087AbRDRRJj>; Wed, 18 Apr 2001 13:09:39 -0400
Date: Tue, 17 Apr 2001 12:48:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mike Kravetz <mkravetz@sequent.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: light weight user level semaphores
In-Reply-To: <20010417114433.D1108@w-mikek2.sequent.com>
Message-ID: <Pine.LNX.4.31.0104171200220.933-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Cc'd to linux-kernel, to get feedback etc. I've already talked this over
  with some people a long time ago, but more people might get interested ]

On Tue, 17 Apr 2001, Mike Kravetz wrote:
>
> In the near future, I should have some time to begin
> working on a prototype implementation.  One thing that
> I don't remember too clearly is a reference you made to
> the System V semaphore implementation.  I'm pretty sure
> you indicated any new light weight implementation should
> not be based on the System V APIs.  Is this correct, or
> did I remember incorrectly?

It's correct. I don't see any way the kernel can do the SysV semantics for
"cleanup" for a semaphore when a process dies in an uncontrolled manner
(or do it fast enough even when it can use at_exit() etc). The whole point
of fast semaphores would be to avoid the kernel entry entirely for the
non-contention case, which basically means that the kernel doesn't even
_know_ who holds the semaphore at any given moment. So the kernel cannot
do the cleanups on process exit that are part of the SysV semantics.

My personal absolute favourite "fast semaphore" implementation is as
follows. First the user interface, just to make it clear that the
implementation is very far from the interface:

	/*
	 * a fast semaphore is a 128-byte opaque thing,
	 * aligned on a 128-byte boundary. This is partly
	 * to minimize false sharing in the L1 (we assume
	 * that 128-byte cache-lines are going to be fairly
	 * common), but also to allow the kernel to hide
	 * data there
	 */
	struct fast_semaphore {
		unsigned int opaque[32];
	} __attribute__((aligned, 64));

	struct fast_semaphore *FS_create(char *ID);
	int FS_down(struct fast_semaphore *, unsigned long timeout);
	void FS_up(struct fast_semaphore *);

would basically be the interface. People would not need to know what the
implementation is like. Add to taste (ie make rw-semaphores, etc), but the
above is a kind of "fairly minimal thing". So "trydown()" would just be a
FS_down() with a zero timeout, for example.

Anyway, the implementation would be roughly:

 - FS_create is responsible for allocating a shared memory region
   at "FS_create()" time. This is what the ID is there for: a "anonymous"
   semaphore would have an ID of NULL, and could only be used by threads
   or across a fork(): it would basically be done with a MAP_ANON |
   MAP_SHARED, and the pointer returned would just be a pointer to that
   memory.

   So FS_create() starts out by allocating the backing store for the
   semaphore. This can basically be done in user space, although the
   kernel does need to get involved for the second part of it, which
   is to (a) allocate a kernel "backing store" thing that contains the
   waiters and the wait-queues for other processes and (b) fill in the
   opaque 128-bit area with the initial count AND the magic to make it
   fly. More on the magic later.

   So the second part of FS_create needs a new system call.

 - FS_down() and FS_up() would be two parts: the fast case (no
   contention), very similar to what the Linux kernel itself uses. And the
   slow case (contention), which ends up being a system call. You'd have
   something like this on x86 in user space:

	extern void FS_down(struct fast_semahore *fs,
		unsigned long timeout) __attribute__((regparm(3)));

	/* Four-instruction fast-path: the call plus these ones */
	FS_down:
		lock ; decl (%edx)
		js FS_down_contention
		ret
	FS_down_contention:
		movl $FS_down_contention_syscall,%eax
		int 80
		ret

   (Note: the regparm(3) thing makes the arguments be passed in %edx and
   %ecx - check me on details in which order, and realize that they will
   show up as arguments to the system call too because the x86 system call
   interface is already register-based)

   FS_up() does the same - see how the kernel already knows to avoid doing
   the wakup if there has been no contention, and has a fast-path that
   never goes out-of-line (ie the kernel semaphore out-of-line case is the
   user-level system call case).

So now we get to the "subtle" part. Getting contention right. The above
causes us to get to the kernel when we have contention, and the kernel
gets only a pointer to user space. In particular, it gets a pointer to
memory that it cannot trust, and from that _untrusted_ pointer it needs to
quickly get to the _trusted_ part, ie the part that only the kernel itself
controls (the stuff with the wait-queues etc). This is where subtlety is
needed.

The speed concerns are paramount: I am convinced that the non-contention
case is the important one, but at the same time we can't allow contention
to be _too_ costly either. The system call is fairly cheap (and already
acts as a first-level back-off, so that's ok), but we can't afford to
spend more time than we need here.

So in my opinion the only reasonable approach is to have a kernel pointer
in the untrusted memory, and then have ways to quickyl validate the
pointer. My preferred approach:

 - the first word of the "opaque" semaphore is obviously the semaphore
   count (we already used it that way in the user-space thing).
 - the second word of the semaphore is the pointer to kernel space that
   was set up at kernel portion of FS_create.
 - an arbitrary part (say 256 bits) of the rest of the semaphore are a
   secure hash that the kernel did at FS_create time.

The validation boils down to:

	unsigned long FS_down_system_call(
		unsigned long unused,		/* %ebx */
		unsigned long timeout,		/* %ecx */
		struct fast_semaphore *fs)	/* %edx */
	{
		struct kernel_fast_sem *kfs;

		if ((unsigned long) fs & 127)
			goto bad_sem;
		if (!access_ok(VERIFY_READ, fs, 128))
			goto bad_sem;

		/*
		 * See if the system call already caused
		 * us to become un-contended. We don't need
		 * the kernel pointer for this, and thus
		 * we don't need the verification overhead.
		 */
		if (FS_trydown(fs))
			return 0;

		kfs = __get_user(fs->opaque+1);

		/*
		 * Verify that it might be a valid kernel pointer
		 * before we even try to dereference it
		 */
		if ((unsigned long) kfs & 7)
			goto bad_sem;
		if (kfs < TASK_SIZE)
			goto bad_sem;
		if (kfs > TASK_SIZE+640k && kfs < TASK_SIZE + 1M)
			goto bad_sem;
		if (kfs > high_mem)
			goto bad_sem;

		/*
		 * Simple first-level check, so that user space
		 * cannot just try to make the signature match
		 * whatever is in kernel memory at the time. There
		 * are some common kernel patterns (like all zero),
		 * which might otherwise allow users to pass in a
		 * bogus kernel pointer.
		 */
		if (kfs->magic != FS_SIGNATURE_MAGIC)
			goto bad_sem;
		if (kfs->user_address != fs)
			goto bad_sem;

		/*
		 * Ok, we know we can dereference it, and that it _looks_
		 * like a valid semaphore. Make sure by verify secure
		 * signature
		 */
		for (i = 0; i < FS_SIGNATURE_WORDS; i++)
			if (__get_user(fs->opaque+2+i) !=  kfs->signature[i])
				goto bad_sem;

		/*
		 * Ok, we now have the counter (in user space in "fs")
		 * and the kernel part (wait queues, waiter info etc).
		 * Do the slow path, return success/failure.
		return do_fs_down(fs, kfs, timeout);

	bad_sem:
		/*
		 * EXIT. Don't let the process try billions of bad
		 * combinations fast. Make him fork() for each one.
		 */
		do_exit(11);
	}


See? The only important part is that when you create the fast semaphore in
FS_create() (and that is going to be the slow part), the signature has to
be a cryptographically secure random number so that user space cannot
spoof kernel pointers.

So the overhead for the above is

 - non-contention:
	zero overhead (but semaphore creation is not free)

 - contention:
	kernel entry (unavoidable anyway)
	verification

The verification boils down to a few range checks and a (cached - we've
already looked at, or will need to look at, the other fields in the same
structures) memcmp(), so the overhead there is on the order of 30 cycles.

Security issues:

 - the user could create a non-shared user-mode "fs" pointer that has the
   right signature, and thus fool the kernel into using the wrong
   user-mode pointer.

   Note that this is OK. The kernel won't mess up its own integrity, it
   will just get the wrong answer. Who cares if the kernel allows multiple
   users to enter if they are bad users?

 - The user must _not_ be able to fool the kernel into using a completely
   non-existing semaphore.

Comments?

		Linus

