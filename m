Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277047AbRJKXMx>; Thu, 11 Oct 2001 19:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277046AbRJKXMo>; Thu, 11 Oct 2001 19:12:44 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:35089 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S277047AbRJKXMa>; Thu, 11 Oct 2001 19:12:30 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: linux-kernel@vger.kernel.org
cc: pmenage@ensim.com
Subject: Race conditions accessing sig->action?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Oct 2001 16:11:24 -0700
Message-Id: <E15roz6-0002Hz-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The task->sig->siglock spinlock is only used in do_sigaction(), and not
in the arch-specific signal dispatch code nor the signal copying code
in fs/exec.c and kernel/fork.c. While this is fine if the signal
structures aren't shared between processes, if they are then it seems as
though some race conditions can creep in, e.g.

- one thread changes the SIGCHLD handler from a handler to SIG_IGN just
as a different thread on a different CPU receives a SIGCHLD. The second
thread can end up segfaulting, as by the time we get to setting up the
signal frame, sa_handler for SIGCHLD has changed from a valid pointer to
SIG_IGN.

- one thread fork()s just as another thread changes the signal handler
for a signal, and copy_sighand() catches the handler structure in an
inconsistent state. 

These are pretty unlikely races, and it could be regarded as an error 
for user-space to change a shared signal handler anyway. If that's the 
case, shouldn't we return an error from sigaction() if the sig->count 
structure is not 1.

If changing shared signal handlers is really required (e.g. for
pthreads?) then - unless I'm missing something fundamental -
copy_sighand() and the signal dispatch code ought to take siglock. The
dispatch code would probably need to copy the relevant parts of the
signal action within the spinlock, and use the copy, since setting up
the signal frame can block on page faults.

On a separate note, there seems to be a lot of duplication of code in
the various arch-specific signal dispatch code. Would there be
objections to a patch to bring some of this functionality (for those
architectures that are fairly similar) back into the arch-independent
signal code?

Paul


