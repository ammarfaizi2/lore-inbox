Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbSKRD0e>; Sun, 17 Nov 2002 22:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261375AbSKRD0e>; Sun, 17 Nov 2002 22:26:34 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:37506
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S261368AbSKRD0b>; Sun, 17 Nov 2002 22:26:31 -0500
Message-ID: <3DD85F93.1000909@redhat.com>
Date: Sun, 17 Nov 2002 19:33:39 -0800
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Ingo Molnar <mingo@elte.hu>, Luca Barbieri <ldb@ldb.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
References: <Pine.LNX.4.44.0211171712360.22749-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0211171712360.22749-100000@home.transmeta.com>
X-Enigmail-Version: 0.65.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:
> On Sun, 17 Nov 2002, Ulrich Drepper wrote:

>>  sys_clone(CLONE_CHILD_SETTID | CLONE_CHILD_CLEARTID | SIGCHLD, 0,
>>	    NULL, NULL, &THREAD_SELF->tid)
>>
>>I.e., the information is stored only in the child.
> 
> 
> And the point of this is? The child has to re-initialize it's pthread 
> structures anyway after a fork,

No, that's the whole point.  The thread descriptor for the one thread in
the new process is fine with the one exception: the TID.  There is not
one change to the thread descriptor in the fork code left if this change
is available.


> since the child certainly doesn't have the 
> threads that the fork()ing parent had.

No, not all the threadsm only the one is available.  But all the memory
is still available and deallocating it requires only two list
operations.  Again, all thread descriptors are just fine.



> The thing is, I don't see the _point_. I refuse to add magic flags that
> are just some obscure implementation issue inside of glibc. A flag should
> have a _meaning_, and I seriously dislike the "meaning" behind
> CLONE_CHILD_SETTID. I dislike in particular its asynchronous behaviour, 
> which is visible in the parent if CLONE_VM isn't set.

The parent isn't affected at all if CLONE_VM and CLONE_PARENT_SETTID are
not set.



> Actually, the above interface is most easily done by just havign
> CLONE_SETTID take effect _before_ we start copying the VM space. Which may
> well make sense (and avoids any extra page dirtying and COW breakage, as
> well as all asynchronous behaviour).
> 
> So moving the CLONE_SETTID check to _before_ copy_mm() will give you
> exactly the semantics you want. I wouldn't have any issues with that
> approach (it's certainly synchronous, and in fact it has to be done there
> if we want to use this for non-CLONE_VM anyway).

But this is wrong.  This would make it impossible to use CLONE_SETTID in
the fork() replacement and it would require the extra set_tid_address
call in the child.

The memory the clone() call used to implement fork() uses points to the
very same memory location which the currently running thread uses.  It's
just in the other VM and it is therefore absolutely necessary that the
pid_t gets written into memory after the VM got cloned.

To be clear(er):

  each thread descriptor contains a field tid

  in the fork() implementation clone gets called with a parameter
pointing to the tid field of the parent's thread descriptor.

  the parent's tid field must not be modified

  the child must have the correct value from the very beginning

  after the child starts the only things it does are these:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      if (__fork_generation_pointer != NULL)
	*__fork_generation_pointer += 4;

      /* Reset the file list.  These are recursive mutexes.  */
      fresetlockfiles ();

      /* We execute this even if the 'fork' call failed.  */
      _IO_list_resetlock ();

      /* Run the handlers registered for the child.  */
      list_for_each (runp, &__fork_child_list)
	{
	  struct fork_handler *curp;

	  curp = list_entry (runp, struct fork_handler, list);

	  curp->handler ();
	}

      /* Initialize the fork lock.  */
      __fork_lock = (lll_lock_t) LLL_LOCK_INITIALIZER;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  i.e., it's bumping a magic generation counter needed to implement
pthread_once

  it re-initialized all the FILE handles which could be locked

  it executes the user-registered handlers (one of the is the cleanup
handling of the memory of all the other threads)

  finally it re-initializes the fork mutex


That's all!  Without the CLONE_CHILD_SETTID flag I'd have to add a call
to set_tid_address at the very beginning of the block.  This would
basically work but it means there is a time when the TID field is not
set correctly and in this time a signal can arrive or an external
program can access the process.  Especially the first can only be
handled by never trusting the TID field and always making gettid() syscalls.


I know that the CLONE_CHILD_SETTID interface is a bit awkward but I
cannot see a cleaner way (misusing CLONE_VM being even worse).  Because
clone() can create a new VM or not and since all four possible
combinations of writing/not writing are useful I think the two flags are
an OK solution.
                                CLONE_PARENT_SETTID
                            no                      yes

                      no   normal fork()      new thread with CLONE_VM
  CLONE_CHILD_SETTID
                      yes  fork() in MT app   cfork()


And again: not having the flag means making an additional syscall and
for a brief period the thread descriptor of the one thread in the new
process wouldn't be initialized.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE92F+T2ijCOnn/RHQRArOfAJwOco6h27qkoPxB8W6NSNLMYs4FhwCfVchk
b5+5W2/3/eitAEYpRwLc9Ok=
=Iqpl
-----END PGP SIGNATURE-----

