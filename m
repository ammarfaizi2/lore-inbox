Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267223AbUGMXSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267223AbUGMXSa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 19:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267224AbUGMXSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 19:18:30 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:47017 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S267223AbUGMXSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 19:18:24 -0400
Date: Wed, 14 Jul 2004 01:18:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: paul@linuxaudiosystems.com, rlrevell@joe-job.com,
       linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040713231803.GP974@dualathlon.random>
References: <20040713162539.GD974@dualathlon.random> <20040713114829.705b9607.akpm@osdl.org> <20040713213847.GH974@dualathlon.random> <20040713145424.1217b67f.akpm@osdl.org> <20040713220103.GJ974@dualathlon.random> <20040713152532.6df4a163.akpm@osdl.org> <20040713223701.GM974@dualathlon.random> <20040713154448.4d29e004.akpm@osdl.org> <20040713225305.GO974@dualathlon.random> <20040713160628.596b96a3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040713160628.596b96a3.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 04:06:28PM -0700, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > What I'm doing is basically to replace all might_sleep with cond_resched
> 
> I cannot see a lot of point in that.  They are semantically different
> things and should look different in the source.
> 
> And it's currently OK to add a might_sleep() to (say) an inline path which
> is expended a zillion times because we know it'll go away for production
> builds.  If those things become cond_resched() calls instead, the code
> increase will be permanent.

this is exactly why I'm making this change: so you can still add
might_sleep in a inline path expected to run a zillion times. With
Ingo's change you would be doing cond_sched internally to might_sleep, I
do the other way around so might_sleep remains a debugging statement.

As Ingo basically showed (and I agree), all current might_sleep seems
suitable to be converted to cond_resched. I checked all them and there's
none that seems to be called in a loop for no good reason. the ones in
the semaphore are quite nice too since it's better to schedule right
before taking the semaphore than after getting it. The one in the
semaphore and in the copy-user are the only place where preempt seems to
be lower overhead but in most other places a spinlock is being taken
very near to the cond_resched.

> > cond_resched_lock is another story of course.
> 
> cond_resched_lock() doesn't work on SMP.  I'll probably be removing it in
> favour of unconditionally dropping the lock every N times around the loop,
> to allow the other CPU (the one with need_resched() true) to get in there
> and take it.
> 
> And please let me repeat: preemption is the way in which we wish to provide
> low-latency.  At this time, patches which sprinkle cond_resched() all over
> the place are unwelcome.  After 2.7 forks we can look at it again.

I think it's a mistake to believe people that leaves preempt off don't
care about lowlatency (this is also why I always keep this change in my
tree)

Index: linux-2.5/mm/memory.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/mm/memory.c,v
retrieving revision 1.178
diff -u -p -r1.178 memory.c
--- linux-2.5/mm/memory.c	30 Jun 2004 02:21:13 -0000	1.178
+++ linux-2.5/mm/memory.c	13 Jul 2004 03:33:45 -0000
@@ -479,20 +479,13 @@ static void unmap_page_range(struct mmu_
 }
 
 /* Dispose of an entire struct mmu_gather per rescheduling point */
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
+#if defined(CONFIG_SMP)
 #define ZAP_BLOCK_SIZE	(FREE_PTE_NR * PAGE_SIZE)
-#endif
-
+#else
 /* For UP, 256 pages at a time gives nice low latency */
-#if !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
 #define ZAP_BLOCK_SIZE	(256 * PAGE_SIZE)
 #endif
 
-/* No preempt: go for improved straight-line efficiency */
-#if !defined(CONFIG_PREEMPT)
-#define ZAP_BLOCK_SIZE	(1024 * PAGE_SIZE)
-#endif
-
 /**
  * unmap_vmas - unmap a range of memory covered by a list of vma's
  * @tlbp: address of the caller's struct mmu_gather


having a CONFIG_PREEMPT in the above code, means you believe the people
who leaves preempt off don't care about lowlatency and that's really not
true. Ingo's effort as well shows people care about lowlatency even with
preempt off.

The people who leaves preempt off simply thinks they can get the same
lowlatency but with less overhead in the locks (though there will be
cond_resched in the semaphore, but semaphore is less performance
critical than the spinlock normally, and semaphore is usually hold for a
longer period of time, short critical sections would better go with the
spinlock anyways to avoid overscheduling).

> I've yet to go through Arjan's patch - I suspect a lot of it is not needed.

Arjan's or Ingo's? I've seen Ingo's patch but maybe I missed Arjan's one.
