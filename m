Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTLDEMn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 23:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTLDEMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 23:12:42 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:23938 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262188AbTLDEMk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 23:12:40 -0500
Date: Thu, 4 Dec 2003 04:12:28 +0000
From: Jamie Lokier <jamie@shareable.org>
To: inaky.perez-gonzalez@intel.com
Cc: linux-kernel@vger.kernel.org, robustmutexes@lists.osdl.org
Subject: Re: [RFC/PATCH] FUSYN Realtime & Robust mutexes for Linux try 2
Message-ID: <20031204041228.GE1216@mail.shareable.org>
References: <0312030051.PbYaFa~d8c8cGbebAaFaPbibda2c0cgd25502@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0312030051.PbYaFa~d8c8cGbebAaFaPbibda2c0cgd25502@intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's my first thoughts, on reading Documentation/fusyn.txt.

  - Everything here can be implemented on top of regular futex, but
    that doesn't mean the implementation will be efficient or robust.
    (This is because, in general, any kind of futex/fuqueue/whatever
    implementation can be moved from kernel space to userspace, using
    the real kernel futexes to simulate the waitqueues and spinlocks
    that are called in futex.c).

There are some good ideas in here, for people who need the features:

  - Priority inheritence is ok _when_ you want it.

    Sometimes if task A with high priority wants a resource which is
    locked by task B with lower priority, that should be an error
    condition: it can be dangerous to promote the priority of task B,
    if task B is not safe to run at a high priority.

  - The data structures and priority callbacks which are used to
    implement priority inheritance, protection and highest-priority
    wakeup are fine.

    But highest-priority wakeup (at least) shouldn't be just for
    fuqueues: it should be implemented at a lower level, directly in
    the kernel's waitqueues.  Meaning: wake_up() should wake the
    highest priority task, not the first one queued, if that is
    appropriate for the queue or waker.

  - I like the method of detecting dead mutex holders, and the ability
    to handle recovery of inconsistent data.

  - Is there a method for passing the locked state to another task?
    Compare-and-swap old-pid -> new-pid works when there isn't any
    contention, but a kernel call is needed in any of the
    kernel-controlled states.

  - It's very unpleasant that rwlocks enter the kernel when there is
    more than one reader.  Hashed rwlocks can be implemented in
    userspace to reduce this (readers take one rwlock from a hashed
    set; writers take them all in order), but it isn't wonderful.

  - For architectures which can't do compare-and-swap, a system call
    which does the equivalent (i.e. disables preemption, does
    compare-and-swap, enables preemption again) would be quite useful.
    Not for maximum performance, but to allow architecture-independent
    locking strategies to be written portably.

  - Similarly, it would be good for the VFULOCK_ flags to depend on
    only 31 bits of the word, i.e. ignoring one of them.  Then
    architectures which don't have compare-and-swap but which do have
    test-and-set-bit can use that.

  - Does the owner field have to be the pid or can a fulock use any
    kind of key value, as long as it isn't one of the reserved values,
    that's convenient to the application.

  - It's nice that you use separate syscalls for each operation.
    Futex should do this too; multiplexing syscalls like the one in
    futex.c should be banned :)

  - It's a huge patch.  A nice thing about futex.c is that it's
    relatively small (your patch is 9 times larger).  The original
    futex design was more complicated, and written specifically for
    mutexes.  Then it was made simpler and I think smaller at the same
    time.  Perhaps putting some of the RT priority capabilities
    directly into kernel waitqueues would help with this.

-- Jamie
