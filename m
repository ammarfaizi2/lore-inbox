Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265032AbUF3JEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265032AbUF3JEv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 05:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266593AbUF3JEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 05:04:51 -0400
Received: from cantor.suse.de ([195.135.220.2]:41653 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265032AbUF3JEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 05:04:48 -0400
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: zombie with CLONE_THREAD
References: <200406300714.i5U7E48O027579@magilla.sf.frob.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I hope the ``Eurythmics'' practice birth control...
Date: Wed, 30 Jun 2004 11:04:46 +0200
In-Reply-To: <200406300714.i5U7E48O027579@magilla.sf.frob.com> (Roland
 McGrath's message of "Wed, 30 Jun 2004 00:14:04 -0700")
Message-ID: <je8ye5ct75.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Roland McGrath <roland@redhat.com> writes:

> Are you saying that if the ptracer dies, it can leave some threads in limbo?
> I think that case is supposed to work because forget_original_parent will
> move all the threads ptrace'd by the dying tracer process to be ptrace'd by
> init, which will then clean up their zombies as previously described.

Here is the test case, run it with "strace -f ./clone".  When the bug
happens then strace is stuck waiting for it's traced child that just died,
but you may have to try a few times before it happens.


--=-=-=
Content-Disposition: inline; filename=clone.c

#include <stdio.h>
#include <signal.h>
#include <sched.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/mman.h>

extern int __clone (int (*__fn) (void *__arg), void *__child_stack,
		    int __flags, void *__arg, ...);
extern int __clone2 (int (*__fn) (void *__arg), void *__child_stack_base,
		     size_t __child_stack_size, int __flags, void *__arg, ...);

static int thread (void *arg)
{
  write (2, "thread\n", sizeof ("thread\n"));
  *(volatile int *) 0;
  return 0;
}

#define STACK_SIZE 1024 * 1024
#define CLONE_FLAGS CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM

int
main (void)
{
  void *stack = mmap (0, STACK_SIZE, PROT_READ|PROT_WRITE,
		      MAP_ANON|MAP_PRIVATE, -1, 0);
  pid_t pid;

#ifdef __ia64__
  pid = __clone2 (thread, stack, STACK_SIZE - 64, CLONE_FLAGS, 0);
#else
  pid = __clone (thread, stack + STACK_SIZE - 64, CLONE_FLAGS, 0);
#endif
  printf ("pid = %d\n", pid);
  sleep (1);
  return 0;
}

	    

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

--=-=-=--
