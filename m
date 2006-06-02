Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWFBOFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWFBOFz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 10:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWFBOFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 10:05:55 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:38784 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751416AbWFBOFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 10:05:54 -0400
Date: Fri, 2 Jun 2006 16:06:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Paolo Ornati <ornati@fastwebnet.it>, linux-kernel@vger.kernel.org
Subject: [patch, -rc5-mm2] locking-API self-test fix
Message-ID: <20060602140611.GA8578@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50,UPPERCASE_25_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5016]
	0.0 UPPERCASE_25_50        message body is 25-50% uppercase
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: locking-API self-test fix
From: Ingo Molnar <mingo@elte.hu>

Paolo Ornati's config triggered a CONFIG_DEBUG_LOCKING_API_SELFTESTS
bug: if CONFIG_PROVE_SPIN_LOCKING was enabled but CONFIG_PROVE_RW_LOCKING
was disabled, then the irq-recursion test incorrectly flagged the test
failure as an unexpected failure.

the fix is to pass in a 'mask' of lock types used in a particular
testcase, so that the generic testcase code can correctly figure out
whether a test's failure is expected or not.

there were two related bugs as well: rsem_AA1 used the wrong lock type
flag, and all the mutex tests used LOCKTYPE_SPIN instead of
LOCKTYPE_MUTEX.

with all these fixes all the separate debugging variants work fine now
if enabled standalone.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 lib/locking-selftest.c |   81 +++++++++++++++++++++++++++++++------------------
 1 file changed, 52 insertions(+), 29 deletions(-)

Index: linux/lib/locking-selftest.c
===================================================================
--- linux.orig/lib/locking-selftest.c
+++ linux/lib/locking-selftest.c
@@ -39,12 +39,10 @@ __setup("debug_locks_verbose=", setup_de
 #define FAILURE		0
 #define SUCCESS		1
 
-enum {
-	LOCKTYPE_SPIN,
-	LOCKTYPE_RWLOCK,
-	LOCKTYPE_MUTEX,
-	LOCKTYPE_RWSEM,
-};
+#define LOCKTYPE_SPIN	0x1
+#define LOCKTYPE_RWLOCK	0x2
+#define LOCKTYPE_MUTEX	0x4
+#define LOCKTYPE_RWSEM	0x8
 
 /*
  * Normal standalone locks, for the circular and irq-context
@@ -931,37 +929,40 @@ static int testcase_successes;
 static int expected_testcase_failures;
 static int unexpected_testcase_failures;
 
-static void dotest(void (*testcase_fn)(void), int expected, int locktype)
+static void dotest(void (*testcase_fn)(void), int expected, int locktype_mask)
 {
 	unsigned long saved_preempt_count = preempt_count();
-	int unexpected_failure = 0;
+	int expected_failure = 0;
 
 	WARN_ON(irqs_disabled());
 
 	testcase_fn();
-#ifdef CONFIG_PROVE_SPIN_LOCKING
-	if (locktype == LOCKTYPE_SPIN && debug_locks != expected)
-		unexpected_failure = 1;
+	/*
+	 * Filter out expected failures:
+	 */
+#ifndef CONFIG_PROVE_SPIN_LOCKING
+	if ((locktype_mask & LOCKTYPE_SPIN) && debug_locks != expected)
+		expected_failure = 1;
 #endif
-#ifdef CONFIG_PROVE_RW_LOCKING
-	if (locktype == LOCKTYPE_RWLOCK && debug_locks != expected)
-		unexpected_failure = 1;
+#ifndef CONFIG_PROVE_RW_LOCKING
+	if ((locktype_mask & LOCKTYPE_RWLOCK) && debug_locks != expected)
+		expected_failure = 1;
 #endif
-#ifdef CONFIG_PROVE_MUTEX_LOCKING
-	if (locktype == LOCKTYPE_MUTEX && debug_locks != expected)
-		unexpected_failure = 1;
+#ifndef CONFIG_PROVE_MUTEX_LOCKING
+	if ((locktype_mask & LOCKTYPE_MUTEX) && debug_locks != expected)
+		expected_failure = 1;
 #endif
-#ifdef CONFIG_PROVE_RWSEM_LOCKING
-	if (locktype == LOCKTYPE_RWSEM && debug_locks != expected)
-		unexpected_failure = 1;
+#ifndef CONFIG_PROVE_RWSEM_LOCKING
+	if ((locktype_mask & LOCKTYPE_RWSEM) && debug_locks != expected)
+		expected_failure = 1;
 #endif
 	if (debug_locks != expected) {
-		if (unexpected_failure) {
-			unexpected_testcase_failures++;
-			printk("FAILED|");
-		} else {
+		if (expected_failure) {
 			expected_testcase_failures++;
 			printk("failed|");
+		} else {
+			unexpected_testcase_failures++;
+			printk("FAILED|");
 		}
 	} else {
 		testcase_successes++;
@@ -969,6 +970,9 @@ static void dotest(void (*testcase_fn)(v
 	}
 	testcase_total++;
 
+	if (debug_locks_verbose)
+		printk(" locktype mask: %x, debug_locks: %d, expected: %d\n",
+			locktype_mask, debug_locks, expected);
 	/*
 	 * Some tests (e.g. double-unlock) might corrupt the preemption
 	 * count, so restore it:
@@ -1006,12 +1010,19 @@ static inline void print_testname(const 
 	dotest(name##_rlock_##nr, SUCCESS, LOCKTYPE_RWLOCK);	\
 	printk("\n");
 
+#define DO_TESTCASE_3RW(desc, name, nr)				\
+	print_testname(desc"/"#nr);				\
+	dotest(name##_spin_##nr, FAILURE, LOCKTYPE_SPIN|LOCKTYPE_RWLOCK);\
+	dotest(name##_wlock_##nr, FAILURE, LOCKTYPE_RWLOCK);	\
+	dotest(name##_rlock_##nr, SUCCESS, LOCKTYPE_RWLOCK);	\
+	printk("\n");
+
 #define DO_TESTCASE_6(desc, name)				\
 	print_testname(desc);					\
 	dotest(name##_spin, FAILURE, LOCKTYPE_SPIN);		\
 	dotest(name##_wlock, FAILURE, LOCKTYPE_RWLOCK);		\
 	dotest(name##_rlock, FAILURE, LOCKTYPE_RWLOCK);		\
-	dotest(name##_mutex, FAILURE, LOCKTYPE_SPIN);		\
+	dotest(name##_mutex, FAILURE, LOCKTYPE_MUTEX);		\
 	dotest(name##_wsem, FAILURE, LOCKTYPE_RWSEM);		\
 	dotest(name##_rsem, FAILURE, LOCKTYPE_RWSEM);		\
 	printk("\n");
@@ -1024,7 +1035,7 @@ static inline void print_testname(const 
 	dotest(name##_spin, FAILURE, LOCKTYPE_SPIN);		\
 	dotest(name##_wlock, FAILURE, LOCKTYPE_RWLOCK);		\
 	dotest(name##_rlock, SUCCESS, LOCKTYPE_RWLOCK);		\
-	dotest(name##_mutex, FAILURE, LOCKTYPE_SPIN);		\
+	dotest(name##_mutex, FAILURE, LOCKTYPE_MUTEX);		\
 	dotest(name##_wsem, FAILURE, LOCKTYPE_RWSEM);		\
 	dotest(name##_rsem, FAILURE, LOCKTYPE_RWSEM);		\
 	printk("\n");
@@ -1041,6 +1052,10 @@ static inline void print_testname(const 
 	DO_TESTCASE_3("hard-"desc, name##_hard, nr);		\
 	DO_TESTCASE_3("soft-"desc, name##_soft, nr);
 
+#define DO_TESTCASE_6IRW(desc, name, nr)			\
+	DO_TESTCASE_3RW("hard-"desc, name##_hard, nr);		\
+	DO_TESTCASE_3RW("soft-"desc, name##_soft, nr);
+
 #define DO_TESTCASE_2x3(desc, name)				\
 	DO_TESTCASE_3(desc, name, 12);				\
 	DO_TESTCASE_3(desc, name, 21);
@@ -1065,7 +1080,6 @@ static inline void print_testname(const 
 	DO_TESTCASE_2IB(desc, name, 312);			\
 	DO_TESTCASE_2IB(desc, name, 321);
 
-
 #define DO_TESTCASE_6x6(desc, name)				\
 	DO_TESTCASE_6I(desc, name, 123);			\
 	DO_TESTCASE_6I(desc, name, 132);			\
@@ -1074,6 +1088,15 @@ static inline void print_testname(const 
 	DO_TESTCASE_6I(desc, name, 312);			\
 	DO_TESTCASE_6I(desc, name, 321);
 
+#define DO_TESTCASE_6x6RW(desc, name)				\
+	DO_TESTCASE_6IRW(desc, name, 123);			\
+	DO_TESTCASE_6IRW(desc, name, 132);			\
+	DO_TESTCASE_6IRW(desc, name, 213);			\
+	DO_TESTCASE_6IRW(desc, name, 231);			\
+	DO_TESTCASE_6IRW(desc, name, 312);			\
+	DO_TESTCASE_6IRW(desc, name, 321);
+
+
 void locking_selftest(void)
 {
 	/*
@@ -1113,7 +1136,7 @@ void locking_selftest(void)
 	printk("             |");
 	dotest(rlock_AA1, SUCCESS, LOCKTYPE_RWLOCK);
 	printk("             |");
-	dotest(rsem_AA1, FAILURE, LOCKTYPE_RWLOCK);
+	dotest(rsem_AA1, FAILURE, LOCKTYPE_RWSEM);
 	printk("\n");
 
 	printk("  --------------------------------------------------------------------------\n");
@@ -1135,7 +1158,7 @@ void locking_selftest(void)
 	DO_TESTCASE_2x6("safe-A + irqs-on", irqsafe2B);
 	DO_TESTCASE_6x6("safe-A + unsafe-B #1", irqsafe3);
 	DO_TESTCASE_6x6("safe-A + unsafe-B #2", irqsafe4);
-	DO_TESTCASE_6x6("irq lock-inversion", irq_inversion);
+	DO_TESTCASE_6x6RW("irq lock-inversion", irq_inversion);
 
 	DO_TESTCASE_6x2("irq read-recursion", irq_read_recursion);
 //	DO_TESTCASE_6x2B("irq read-recursion #2", irq_read_recursion2);
