Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265612AbSKTDaI>; Tue, 19 Nov 2002 22:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265628AbSKTDaI>; Tue, 19 Nov 2002 22:30:08 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:33927 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S265612AbSKTDaH>;
	Tue, 19 Nov 2002 22:30:07 -0500
Date: Wed, 20 Nov 2002 03:37:47 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Luca Barbieri <ldb@ldb.ods.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading enhancements, tid-2.5.47-C0
Message-ID: <20021120033747.GB9007@bjl1.asuk.net>
References: <Pine.LNX.4.44.0211181303240.1639-100000@localhost.localdomain> <3DDAE822.1040400@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDAE822.1040400@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> Ingo's last patch has two pointer, one for the parent and one for the
> child.  The is necessary (despite what Jamie tried to argue) if we want
> to have a cfork() implementation which works in MT applications.
> cfork() is IMO really necessary if you want to mix threads and fork().

Hi Ulrich,

This is "int cfork(pid_t * user_tid_ptr)", yes?  I've searched google for
cfork and not found anything fruitful - just references to solaris
patches about a function of the same name.

I agree with you, if you need this functionality:

    1. cfork(ptr) equivalent to { pid_t p = fork(); if (p > 0) *ptr = p; }
    2. The pid is stored in the parent before any signals can be handled.
    3. Don't want to block signals temporarily (of course).

Then yes, you need two pointers, one for the parent's cfork() argument
for SETTID in the parent, and one for the child's thread descriptor
for CLEARTID in the child.  Strictly speaking, SETTID does not need to
affect the child (because the child can store the tid itself), but it
would make a lot of sense to do it.

> Assume you have an application which forks children and assosicates
> certain actions with the termination of a child.  When SIGCHLD is
> received one of the threads of the app searches, using the PID of the
> terminated child, which action has to be performed.  It wouldn't find
> anything if the thread, which created the child, hasn't yet written the
> PID of the child in the appropriate memory location.  This can very well
> happen and can only be fixed by the kernel writing the PID values.

If the application is using cfork() and requires the pid stored
atomically at _its_ address, which is separate from the thread
libraries current_thread->tid address, then I agree with Ulrich: two
pointers are best.

It's possible to get by with one pointer, but then you're back to
blocking signals in the cfork() implementation, or making the thread
library horrendous in other ways (complicating ->tid reads everywhere).

(That said, I'm not entirely convinced that blocking signals in cfork()
is so bad, if we assume that cfork() is a relatively expensive
operation anyway...)

-- Jamie
