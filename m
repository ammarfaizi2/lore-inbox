Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285883AbRLHJ5L>; Sat, 8 Dec 2001 04:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285882AbRLHJ5H>; Sat, 8 Dec 2001 04:57:07 -0500
Received: from science.horizon.com ([192.35.100.1]:11837 "HELO
	science.horizon.com") by vger.kernel.org with SMTP
	id <S285880AbRLHJ4v>; Sat, 8 Dec 2001 04:56:51 -0500
Date: 8 Dec 2001 09:56:42 -0000
Message-ID: <20011208095642.27298.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: putc() locking (Was Re: horrible disk thorughput on itanium)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, fer chrissakes.

If _REENTRANT isn't defined, putc() should be the standard macro

#define putc(_ch, _fp) \
    (((_fp)->_IO_write_ptr >= (_fp)->_IO_write_end) \
     ? __overflow (_fp, (unsigned char) (_ch)) \
     : (unsigned char) (*(_fp)->_IO_write_ptr++ = (_ch)))

Anything that adds a single test to that time-honored definition without
benefit to single-threaded programs is Just Plain Broken.

If your abstraction doesn't allow that, your abstraction is Just Plain Broken.

If _REENTRANT isn't defined, you're also encouraged to

#define pthread_create _you_are_getting_a_link_error_because_you_called_pthread_create_without_defining_REENTRANT_you_moron

Now, about the Red Hat bug list hypothesis... what about an
internally-threaded library used by a single-threaded application?

Well, it can have its own internal FILE structures, and call putc_locked
on those and not bother the main application thread.  If fopen_unlocked
reserves space for and initializes the locking fields, it can also
call putc_locked on the application's FILEs while a library call is
in progress (and thus the application is not allowed to use the FILE).

For it to want to make asynchronous I/O calls on an application's FILE
structures while a library call is not in progress is Just Plain Broken.

I mean, how the hell are you supposed to know that the application hasn't
called fclose() on the descriptor for its own inscrutable reasons?
If your library's calling conventions are sufficiently intricate that
you have this sort of agreement with the application, then multithreading
shouldn't make the situation significantly hairier.

If you really desperately need to make asynchronous writes, dup() the fd
out of the user's FILE and do independent writes to *that*.  Then you're
immune to the user closing the FILE or fd.

If you need to follow freopen() calls on the FILE, then either read the
_fd member out of the FILE each time (assuming that write to that are
atomic seems pretty safe), or (better yet) make sure that freopen() uses
dup2() to keep the fd constant.  Given the frequency with which freopen()
is called, an extra dup2() and close() shouldn't be *that* big an issue.


The ugly part is functions like malloc(), where you don't have a handy
context structure like a FILE to associate locks with, and you have to
modify global variables.  In that case, you might well want to use Linus'
proposal of having a num_threads_minus_one global which gets tested at
various places:

void *
malloc_generic(size_t size)
{
	if (num_threads_minus_one == 0) {
		return malloc_unlocked(size);
	} else {
		char *p;
		do_locking_shit();
		p = malloc_unlocked(size);
		do_unlocking_shit();
		return p;
	}
}

At least malloc() is heavyweight enough that the test doesn't add *that* much.

As Linus observed, num_threads_minus_one can't increase during a
library call (unless the library call itself calls pthread_create(),
so this is always safe.  A subtle point is that it can *decrease* if the
other threads asynchronously exit.  Therefore, it is important to do a
single atomic read of the variable in the case that matched operations
are required.

I.e. it would be erroneous to do
void *
malloc_generic(size_t size)
{
	char *p;

	if (num_threads_minus_one != 0)
		do_locking_shit();
	p = malloc_unlocked(size);
	if (num_threads_minus_one != 0)
		do_unlocking_shit();
	return p;
}

rather, you would have to
void *
malloc_generic(size_t size)
{
	char *p;
	int flag = num_threads_minus_one;

	if (flag != 0)
		do_locking_shit();
	p = malloc_unlocked(size);
	if (flag != 0)
		do_unlocking_shit();
	return p;
}

Myself, I'm rather in favor of relegating all that threading overhead to a
separate libc_r which, with a bit of care, can be designed to be safe to
link to non-threaded code (so a multithreaded library can force linking
and override the non-reentrant libc symbols), but I'm also aware of how
heartily sick the glibc maintainers are of the exponential proliferation
of library versions caused by all the other people who thought their
pet cause was reason enough to make a second copy of everything.
