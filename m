Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270243AbTHBUD5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 16:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270256AbTHBUD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 16:03:57 -0400
Received: from w197.z066088144.sjc-ca.dsl.cnc.net ([66.88.144.197]:22270 "EHLO
	kali.zeta-soft.com") by vger.kernel.org with ESMTP id S270243AbTHBUDz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 16:03:55 -0400
From: "Scott L. Burson" <gyro@zeta-soft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sat,  2 Aug 2003 13:03:53 -0700 (PDT)
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Mathieu.Malaterre@creatis.insa-lyon.fr
CC: Kanoj@sgi.com
Subject: SMP performance problem in 2.4 (was: Athlon spinlock performance)
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <16171.31418.271319.316382@kali.zeta-soft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Well, I have found the smoking gun as to what is causing the performance
problems that I have been seeing on my dual Athlon box (Tyan S2466, dual
Athlon MP 2800+, 2.5GB memory).

It doesn't, indeed, have anything to do with the Athlon.  The reason I
thought it did was that a dual Pentium box that I have access to (2.4GHz,
2GB memory) has no trace of the problem.  That machine is running Red Hat
7.2, which is 2.4.7-based.  It didn't occur to me that there might have been
a severe performance problem introduced into the kernel sometime between
2.4.7 and 2.4.18, but that, it turns out, is exactly what happened.

The problem is in `try_to_free_pages' and its associated routines,
`shrink_caches' and `shrink_cache', in `mm/vmscan.c'.  After I made some
changes to greatly reduce lock contention in the slab allocator and
`shrink_cache', and then instrumented `shrink_cache' to see what it was
doing, the problem showed up very clearly.

In one approximately 60-second period with the problematic workload running, 
`try_to_free_pages' was called 511 times.  It made 2597 calls to
`shrink_caches', which made 2592 calls to `shrink_cache' (i.e. it was very
rare for `kmem_cache_reap' to release enough pages itself).  The main loop
of `shrink_cache' was executed -- brace yourselves -- 189 million times!
During that time it called `page_cache_release' on only 31265 pages.

`shrink_cache' didn't even exist in 2.4.7.  Whatever mechanism 2.4.7 had for
releasing pages was evidently much more time-efficient, at least in the
particular situation I'm looking at.

Clearly the kernel group has been aware of the problems with `shrink_cache',
as I see that it has received quite a bit of attention in the course of 2.5
development.  I am hopeful that the problem will be substantially
ameliorated in 2.6.0.  (The comment at the top of `try_to_free_pages' --
"This is a fairly lame algorithm - it can result in excessive CPU burning"
-- suggests it won't be cured entirely.)

However, it seems the kernel group may not have been aware of just how bad
the problem can be in recent 2.4 kernels on dual-processor machines with
lots of memory.  It's bad enough that running two `find' jobs at the same
time on large filesystems can bring the machine pretty much to its knees.

There are many things about this code I don't understand, but the most
puzzling is this.  When `try_to_free_pages' is called, it sets out to free
32 pages (the value of `SWAP_CLUSTER_MAX').  It's prepared to do a very
large amount of work to accomplish this goal, and if it fails, it will call
`out_of_memory'.  Given that, what's odd is that it's being called when
memory isn't even close to being full (there's a good 800MB free, according
to `top').  It seems crazy that `out_of_memory' might be called when there
are hundreds of MB of free pages, just because `shrink_caches' couldn't find 
32 pages to free.  It suggests to me that `try_to_free_pages' is being
called in two contexts: one when a page allocation fails, and the other just 
for general cleaning, and that it's the latter context that's causing the
problem.

I will do some more instrumentation to try to verify this.  Comments
solicited.

-- Scott

