Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbTEVJJq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 05:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbTEVJJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 05:09:46 -0400
Received: from mx1.elte.hu ([157.181.1.137]:57544 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262636AbTEVJJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 05:09:44 -0400
Date: Thu, 22 May 2003 11:15:20 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3 
In-Reply-To: <20030522004714.C3A2F2C0A7@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0305221052590.4549-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 May 2003, Rusty Russell wrote:

> See, I don't think the current interface is too ugly to live. Especially
> since you don't need to introduce a new arg to implement FUTEX_REQUEUE,
> so there's no immediate problem with it.

i think overloading a completely unrelated pointer (ie. overloading the
timespec pointer with a futex pointer, depending on the value of the 'op'
flag), within an already overcrowded multiplexing syscall is a 100%
non-starter to begin with.

really, i dont see what your problem with the new syscalls are. Futexes
started out as a special, limited hack for userspace threading, but by
today they have become a first-class concept: generic, user-accessible
waitqueues identified by the piece of VM they are located at. Very
flexible, very useful and very fast.

eg. under LinuxThreads, all the pthread_* functions were assuming a shared
VM. glibc functions like pthread_mutex_lock() only worked for 'threaded'
setups - ie. threads sharing pagetables via CLONE_VM. LinuxThreads had to
use thread pointers, lists and other constructs that made the library only
useful for the limited 'threaded' case.

today, with NPTL + glibc, all these pthread APIs are 100% available for
processes as well: all that is needed are the variables to be shared
between two processes. Ie. it works for shared mmap()-ed regions, or SysV
regions. Just #include <pthread.h> and use these rich locking APIs in your
process-based applications. No need to go to threads to be able to use the
pthread locking APIs. This, as far as i know, is a 'first' amongst unices.

While doing all this stuff we found a new, generic operation needed for
these 'user-accissible hashed waitqueues': the ability to requeue waiting
threads between two waitqueues, so that userspace can implement locking
primitives more flexibly. This is a clean, generic operation nicely
extending the already existing ability to wait on a waitqueue and to wake
up a thread in a waitqueue. Glibc will happily use all the new syscalls.  
They are even slightly faster, and are much cleaner - and there's zero
slowdown for code that used the old API. Plus historically we've
constantly moved away from multiplexer syscalls. So it's precisely the
right time to do this, and it's a win-win situation all over.

all that is needed now is some actual review of the new APIs from the
conceptual angle (i've done that and i think they are okay, but more eyes
see more), so that we make sure these are good and we wont need to discard
any aspect of them anytime soon.

	Ingo

