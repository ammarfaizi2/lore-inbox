Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbSLIARG>; Sun, 8 Dec 2002 19:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261973AbSLIARG>; Sun, 8 Dec 2002 19:17:06 -0500
Received: from [129.63.8.2] ([129.63.8.2]:30737 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S261934AbSLIARF>;
	Sun, 8 Dec 2002 19:17:05 -0500
Date: Sun, 8 Dec 2002 19:24:29 -0500 (EST)
Message-Id: <200212090024.gB90OTN25818@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.kernel.org
Cc: nleroy@cs.wisc.edu, acahalan@cs.uml.edu
Subject: Re: Detecting threads vs processes with ps or /proc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Robert Love writes:
> On Fri, 2002-12-06 at 14:56, Nick LeRoy wrote:
>
>> I was considerring doing something like this as well.  From your
>> experience,  does it work reliably?
>
> It never fails to detect threads (no false negatives).

Testing the algorithm on idle test processes won't show
this damn-obvious race condition:

1. you read the first thread's info
2. the second thread calls mmap() and/or takes a page fault
3. you read the second thread's info

> It does sometimes detect child processes that forked but did not exec as
> threads (false positives).  The failure case is when a program forks,
> does not call exec, and the children go on to execute the exact same
> code (so they look and act just like threads, but they have unique
> addresses spaces).
>
> One thing to note: if you can modify the kernel and procps, you can just
> export the value of task->mm out of /proc.  It is a gross hack, and
> perhaps a security issue, but that will work 100%.  Same ->mm implies
> thread.

This forces sorting, which is slow and eats memory.
It's better to list the ->mm peers in a proc file.
For example, a /proc/42/mm-peers file containing
a simple list of the peers.

There's still a race condition, but at least it only
involves threads that get created during the /proc scan.

There's also the problem with new-style threads simply not
being listed anywhere. Crackers are going to love it if
the Linux 2.6 kernel has a built-in way to hide things.
