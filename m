Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWCYSvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWCYSvO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 13:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWCYStM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 13:49:12 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:57473 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932237AbWCYSs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 13:48:58 -0500
Date: Sat, 25 Mar 2006 19:46:20 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Subject: [patch 06/10] PI-futex: rt-mutex docs
Message-ID: <20060325184620.GG16724@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

add rt-mutex documentation.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

----

 Documentation/rtmutex.txt |   60 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+)

Index: linux-pi-futex.mm.q/Documentation/rtmutex.txt
===================================================================
--- /dev/null
+++ linux-pi-futex.mm.q/Documentation/rtmutex.txt
@@ -0,0 +1,60 @@
+RT Mutex Subsystem with PI support
+
+RT Mutexes with priority inheritance are used to support pthread_mutexes
+with priority inheritance attributes.
+
+The basic technology was developed in the preempt-rt tree and
+streamlined for the pthread_mutex support.
+
+RT Mutexes extend the semantics of Mutexes by the priority inheritance
+protocol. Sharing code and data structures with the Mutex code is not
+feasible due to the extended requirements of RT Mutexes.
+
+Basic operation principle:
+
+A low priority owner of a rt_mutex inherits the priority of a higher
+priority waiter until the mutex is released. Is the temporary priority
+boosted owner blocked on a rt_mutex itself it propagates the priority
+boosting to the owner of the rt_mutex it is blocked on. The priority
+boosting is immidiately removed once the rt_mutex has been unlocked.
+This technology allows to shorten the blocking on mutexes which
+protect shared resources. Priority inheritance is not a magic bullet
+for poorly designed applications, but allows optimizations in cases
+where the protection of shared resources might affect critical parts
+of an high priority thread.
+
+The enqueueing of the waiters into the rtmutex waiter list is done in
+priority order. In case of the same priority FIFO order is chosen. Per
+rtmutex only the top priority waiter is enqueued into the owners
+priority waiters list. Also this list enqueues in priority
+order. Whenever the top priority waiter of a task is changed the
+priority of the task is readjusted. The priority enqueueing is handled
+by plists, see also include/linux/plist.h for further explanation.
+
+RT Mutexes are optimized for fastpath operations and have no runtime
+overhead in case of locking an uncontended mutex or unlocking a mutex
+without waiters. The optimized fathpath operations require cmpxchg
+support.
+
+The state of the rtmutex is tracked via the owner field of the
+rt_mutex structure:
+
+rt_mutex->owner holds the task_struct pointer of the owner. Bit 0 and
+1 are used to keep track of the "owner is pending" and "rtmutex has
+waiters" state.
+
+owner		bit1	bit0
+NULL		0	0	mutex is free (fast acquire possible)
+NULL		0	1	invalid state
+NULL		1	0	invalid state
+NULL		1	1	invalid state
+taskpointer	0	0	mutex is held (fast release possible)
+taskpointer	0	1	task is pending owner
+taskpointer	1	0	mutex is held and has waiters
+taskpointer	1	1	task is pending owner and mutex has more waiters
+
+Pending ownership is assigned to the first (highest priority) waiter
+of the mutex, when the mutex is released. The thread is woken up and
+can now acquire the mutex. Until the mutex is taken (bit 0 cleared) a
+competing higher priority thread can steal the mutex which puts the
+woken up thread back on the waiters list.
