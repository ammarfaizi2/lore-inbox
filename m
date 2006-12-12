Return-Path: <linux-kernel-owner+w=401wt.eu-S932196AbWLLLME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWLLLME (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 06:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWLLLME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 06:12:04 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:40057 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932196AbWLLLMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 06:12:01 -0500
Date: Tue, 12 Dec 2006 12:10:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch] lockdep: fix seqlock_init()
Message-ID: <20061212111028.GA13908@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] lockdep: fix seqlock_init()
From: Ingo Molnar <mingo@elte.hu>

seqlock_init() needs to use spin_lock_init() for dynamic locks, so that 
lockdep is notified about the presence of a new lock.

(this is a fallout of the recent networking merge, which started using 
the so-far unused seqlock_init() API.)

This fix solves the following lockdep-internal warning on current -git:

 INFO: trying to register non-static key.
 the code is fine but needs lockdep annotation.
 turning off the locking correctness validator.
  [<c0104fd9>] dump_trace+0x63/0x1e8
  [<c0105177>] show_trace_log_lvl+0x19/0x2e
  [<c010557e>] show_trace+0x12/0x14
  [<c0105594>] dump_stack+0x14/0x16
  [<c0142992>] __lock_acquire+0x10c/0x9f9
  [<c0143564>] lock_acquire+0x56/0x72
  [<c03c514f>] _spin_lock+0x35/0x42
  [<c0369875>] neigh_destroy+0x9d/0x12e
  [<c036a1d5>] neigh_periodic_timer+0x10a/0x15c
  [<c01302a5>] run_timer_softirq+0x126/0x18e
  [<c012c530>] __do_softirq+0x6b/0xe6
  [<c0106404>] do_softirq+0x64/0xd2
  [<c012c249>] ksoftirqd+0x82/0x138
  [<c01398f1>] kthread+0xb2/0xd7
  [<c0104c1b>] kernel_thread_helper+0x7/0x10

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/seqlock.h |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Index: linux-hres-timers.q/include/linux/seqlock.h
===================================================================
--- linux-hres-timers.q.orig/include/linux/seqlock.h
+++ linux-hres-timers.q/include/linux/seqlock.h
@@ -44,8 +44,11 @@ typedef struct {
 #define SEQLOCK_UNLOCKED \
 		 __SEQLOCK_UNLOCKED(old_style_seqlock_init)
 
-#define seqlock_init(x) \
-		do { *(x) = (seqlock_t) __SEQLOCK_UNLOCKED(x); } while (0)
+#define seqlock_init(x)					\
+	do {						\
+		(x)->sequence = 0;			\
+		spin_lock_init(&(x)->lock);		\
+	} while (0)
 
 #define DEFINE_SEQLOCK(x) \
 		seqlock_t x = __SEQLOCK_UNLOCKED(x)
