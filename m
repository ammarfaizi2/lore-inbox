Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWDXWvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWDXWvp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 18:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWDXWvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 18:51:45 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:18869 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750939AbWDXWvo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 18:51:44 -0400
Subject: [RESEND][PATCH 1/2] percpu counter data type changes to suppport
	for more than 2**31 ext3 free blocks counter
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: akpm@osdl.org
Cc: kiran@scalex86.org, LaurentVivier@wanadoo.fr, sct@redhat.com,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1145631546.4478.10.camel@localhost.localdomain>
References: <1144691929.3964.53.camel@dyn9047017067.beaverton.ibm.com>
	 <1145631546.4478.10.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 24 Apr 2006 15:51:41 -0700
Message-Id: <1145919101.4820.44.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The percpu counter data type are changed in this set of patches to
support more users like ext3 who need more than 32 bit to store the free
blocks total in the filesystem.

[PATCH 1] - Generic perpcu counters data type changes. The size of the global
counter and local counter were explictly specified using s64 and s32
 The global counter is changed from long to s64,  while the local counter
is changed from long to s32, so we could avoid doing 64 bit update in most cases.

[PATCH 2] - Make use of the new percpu_counter_init() in the applications
 of percpu counters, to able to pass the initial value of the global counter.


Patch 1 is included here.
Signed-Off-By: Mingming Cao <cmm@us.ibm.com>

---

 linux-2.6.16-cmm/include/linux/percpu_counter.h |   47 ++++++++++++------------
 linux-2.6.16-cmm/lib/percpu_counter.c           |   18 ++++-----
 2 files changed, 34 insertions(+), 31 deletions(-)

diff -puN include/linux/percpu_counter.h~percpu_longlong_counter include/linux/percpu_counter.h
--- linux-2.6.16/include/linux/percpu_counter.h~percpu_longlong_counter	2006-04-21 00:01:57.000000000 -0700
+++ linux-2.6.16-cmm/include/linux/percpu_counter.h	2006-04-24 13:50:26.000000000 -0700
@@ -17,8 +17,8 @@
 
 struct percpu_counter {
 	spinlock_t lock;
-	long count;
-	long *counters;
+	s64 count;
+	s32 *counters;
 };
 
 #if NR_CPUS >= 16
@@ -27,11 +27,11 @@ struct percpu_counter {
 #define FBC_BATCH	(NR_CPUS*4)
 #endif
 
-static inline void percpu_counter_init(struct percpu_counter *fbc)
+static inline void percpu_counter_init(struct percpu_counter *fbc, s64 amount)
 {
 	spin_lock_init(&fbc->lock);
-	fbc->count = 0;
-	fbc->counters = alloc_percpu(long);
+	fbc->count = amount;
+	fbc->counters = alloc_percpu(s32);
 }
 
 static inline void percpu_counter_destroy(struct percpu_counter *fbc)
@@ -39,12 +39,12 @@ static inline void percpu_counter_destro
 	free_percpu(fbc->counters);
 }
 
-void percpu_counter_mod(struct percpu_counter *fbc, long amount);
-long percpu_counter_sum(struct percpu_counter *fbc);
-void percpu_counter_mod_bh(struct percpu_counter *fbc, long amount);
-int percpu_counter_exceeds(struct percpu_counter *fbc, long limit);
+void percpu_counter_mod(struct percpu_counter *fbc, s32 amount);
+s64 percpu_counter_sum(struct percpu_counter *fbc);
+void percpu_counter_mod_bh(struct percpu_counter *fbc, s32 amount);
+int percpu_counter_exceeds(struct percpu_counter *fbc, s64 limit);
 
-static inline long percpu_counter_read(struct percpu_counter *fbc)
+static inline s64 percpu_counter_read(struct percpu_counter *fbc)
 {
 	return fbc->count;
 }
@@ -52,13 +52,14 @@ static inline long percpu_counter_read(s
 /*
  * It is possible for the percpu_counter_read() to return a small negative
  * number for some counter which should never be negative.
+ *
  */
-static inline long percpu_counter_read_positive(struct percpu_counter *fbc)
+static inline s64 percpu_counter_read_positive(struct percpu_counter *fbc)
 {
-	long ret = fbc->count;
+	s64 ret = fbc->count;
 
 	barrier();		/* Prevent reloads of fbc->count */
-	if (ret > 0)
+	if (ret >= 0)
 		return ret;
 	return 1;
 }
@@ -66,12 +67,12 @@ static inline long percpu_counter_read_p
 #else
 
 struct percpu_counter {
-	long count;
+	s64 count;
 };
 
-static inline void percpu_counter_init(struct percpu_counter *fbc)
+static inline void percpu_counter_init(struct percpu_counter *fbc, s64 amount)
 {
-	fbc->count = 0;
+	fbc->count = amount;
 }
 
 static inline void percpu_counter_destroy(struct percpu_counter *fbc)
@@ -79,36 +80,38 @@ static inline void percpu_counter_destro
 }
 
 static inline void
-percpu_counter_mod(struct percpu_counter *fbc, long amount)
+percpu_counter_mod(struct percpu_counter *fbc, s32 amount)
 {
 	preempt_disable();
 	fbc->count += amount;
 	preempt_enable();
 }
 
-static inline long percpu_counter_read(struct percpu_counter *fbc)
+static inline s64 percpu_counter_read(struct percpu_counter *fbc)
 {
 	return fbc->count;
 }
 
-static inline long percpu_counter_read_positive(struct percpu_counter *fbc)
+static inline s64 percpu_counter_read_positive(struct percpu_counter *fbc)
 {
 	return fbc->count;
 }
 
-static inline long percpu_counter_sum(struct percpu_counter *fbc)
+static inline
+unsigned s64 percpu_counter_sum(struct percpu_counter *fbc)
 {
 	return percpu_counter_read_positive(fbc);
 }
 
-static inline void percpu_counter_mod_bh(struct percpu_counter *fbc, long amount)
+static inline void percpu_counter_mod_bh(struct percpu_counter *fbc, s32 amount)
 {
 	local_bh_disable();
 	fbc->count += amount;
 	local_bh_enable();
 }
 
-static inline int percpu_counter_exceeds(struct percpu_counter *fbc, long limit)
+static inline int
+percpu_counter_exceeds(struct percpu_counter *fbc, s64 limit)
 {
 	return percpu_counter_read(fbc) > limit;
 }
diff -puN lib/percpu_counter.c~percpu_longlong_counter lib/percpu_counter.c
--- linux-2.6.16/lib/percpu_counter.c~percpu_longlong_counter	2006-04-21 00:01:57.000000000 -0700
+++ linux-2.6.16-cmm/lib/percpu_counter.c	2006-04-24 13:52:09.000000000 -0700
@@ -5,10 +5,10 @@
 #include <linux/percpu_counter.h>
 #include <linux/module.h>
 
-static void __percpu_counter_mod(struct percpu_counter *fbc, long amount)
+static void __percpu_counter_mod(struct percpu_counter *fbc, s32 amount)
 {
-	long count;
-	long *pcount;
+	s64 count;
+	s32 *pcount;
 	int cpu = smp_processor_id();
 
 	pcount = per_cpu_ptr(fbc->counters, cpu);
@@ -23,7 +23,7 @@ static void __percpu_counter_mod(struct 
 	}
 }
 
-void percpu_counter_mod(struct percpu_counter *fbc, long amount)
+void percpu_counter_mod(struct percpu_counter *fbc, s32 amount)
 {
 	preempt_disable();
 	__percpu_counter_mod(fbc, amount);
@@ -31,7 +31,7 @@ void percpu_counter_mod(struct percpu_co
 }
 EXPORT_SYMBOL(percpu_counter_mod);
 
-void percpu_counter_mod_bh(struct percpu_counter *fbc, long amount)
+void percpu_counter_mod_bh(struct percpu_counter *fbc, s32 amount)
 {
 	local_bh_disable();
 	__percpu_counter_mod(fbc, amount);
@@ -43,15 +43,15 @@ EXPORT_SYMBOL(percpu_counter_mod_bh);
  * Add up all the per-cpu counts, return the result.  This is a more accurate
  * but much slower version of percpu_counter_read_positive()
  */
-long percpu_counter_sum(struct percpu_counter *fbc)
+s64 percpu_counter_sum(struct percpu_counter *fbc)
 {
-	long ret;
+	s64 ret;
 	int cpu;
 
 	spin_lock(&fbc->lock);
 	ret = fbc->count;
 	for_each_possible_cpu(cpu) {
-		long *pcount = per_cpu_ptr(fbc->counters, cpu);
+		s32 *pcount = per_cpu_ptr(fbc->counters, cpu);
 		ret += *pcount;
 	}
 	spin_unlock(&fbc->lock);
@@ -69,7 +69,7 @@ EXPORT_SYMBOL(percpu_counter_sum);
  * it turns out that the limit wasn't exceeded, there will be no more calls to
  * percpu_counter_sum() until significant counter skew has reoccurred.
  */
-int percpu_counter_exceeds(struct percpu_counter *fbc, long limit)
+int percpu_counter_exceeds(struct percpu_counter *fbc, s64 limit)
 {
 	if (percpu_counter_read(fbc) > limit)
 		if (percpu_counter_sum(fbc) > limit)

_


