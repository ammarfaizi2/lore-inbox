Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWGBNeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWGBNeZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 09:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWGBNeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 09:34:25 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:14277 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751271AbWGBNeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 09:34:25 -0400
Date: Sun, 2 Jul 2006 15:29:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Miles Lane <miles.lane@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm4 + hostap + pcmcia + lockdep -- possible recursive locking detected -- (af_callback_keys + sk->sk_family#3){-.-?}, at: [<c119d8db>] sock_def_readable+0x15/0x69
Message-ID: <20060702132946.GA25420@elte.hu>
References: <a44ae5cd0607011804i2326c350ta6262feec1e6805e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <a44ae5cd0607011804i2326c350ta6262feec1e6805e@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Miles Lane <miles.lane@gmail.com> wrote:

> I have patches for hostap, pcmcia and lockdep applied to this kernel. 
> These patches are the ones resulting from several recent message 
> threads. I just noticed this in my kernel log:
> 
> [ INFO: possible recursive locking detected ]
> ---------------------------------------------

ok, lockdep should allow same-class read-lock recursion too, because 
it's used by real code and is being relied upon. Could you try the patch 
below? (if you have CONFIG_DEBUG_LOCKING_API_SELFTESTS enabled then 
apply the other attached patch as well, to fix two testcases.)

        Ingo

---------------->
Subject: lockdep: allow read_lock() recursion of same class
From: Ingo Molnar <mingo@elte.hu>

lockdep so far only allowed read-recursion for the same lock
instance. This is enough in the overwhelming majority of cases,
but a hostap case triggered and reported by Miles Lane relies
on same-class different-instance recursion. So we relax the
restriction on read-lock recursion.

(this change does not allow rwsem read-recursion, which is
 still forbidden.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/lockdep.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -843,10 +843,9 @@ check_deadlock(struct task_struct *curr,
 			continue;
 		/*
 		 * Allow read-after-read recursion of the same
-		 * lock instance (i.e. read_lock(lock)+read_lock(lock)):
+		 * lock class (i.e. read_lock(lock)+read_lock(lock)):
 		 */
-		if ((read == 2) && prev->read &&
-				(prev->instance == next_instance))
+		if ((read == 2) && prev->read)
 			return 2;
 		return print_deadlock_bug(curr, prev, next);
 	}

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lockdep-locking-api-self-tests-read-recursion-update.patch"

Subject: lockdep: locking API self-tests, read-recursion update
From: Ingo Molnar <mingo@elte.hu>

lockdep now allows same type (different instance) rwlock recursion
too, update the testcases accordingly.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 lib/locking-selftest.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux/lib/locking-selftest.c
===================================================================
--- linux.orig/lib/locking-selftest.c
+++ linux/lib/locking-selftest.c
@@ -248,7 +248,7 @@ GENERATE_TESTCASE(AA_rsem)
 
 /*
  * Special-case for read-locking, they are
- * allowed to recurse on the same lock instance:
+ * allowed to recurse on the same lock class:
  */
 static void rlock_AA1(void)
 {
@@ -259,7 +259,7 @@ static void rlock_AA1(void)
 static void rlock_AA1B(void)
 {
 	RL(X1);
-	RL(X2); // this one should fail
+	RL(X2); // this one should NOT fail
 }
 
 static void rsem_AA1(void)
@@ -1132,7 +1132,7 @@ void locking_selftest(void)
 	init_shared_classes();
 	debug_locks_silent = !debug_locks_verbose;
 
-	DO_TESTCASE_6("A-A deadlock", AA);
+	DO_TESTCASE_6R("A-A deadlock", AA);
 	DO_TESTCASE_6R("A-B-B-A deadlock", ABBA);
 	DO_TESTCASE_6R("A-B-B-C-C-A deadlock", ABBCCA);
 	DO_TESTCASE_6R("A-B-C-A-B-C deadlock", ABCABC);
@@ -1153,7 +1153,7 @@ void locking_selftest(void)
 
 	print_testname("recursive read-lock #2");
 	printk("             |");
-	dotest(rlock_AA1B, FAILURE, LOCKTYPE_RWLOCK);
+	dotest(rlock_AA1B, SUCCESS, LOCKTYPE_RWLOCK);
 	printk("             |");
 	dotest(rsem_AA1B, FAILURE, LOCKTYPE_RWSEM);
 	printk("\n");

--nFreZHaLTZJo0R7j--
