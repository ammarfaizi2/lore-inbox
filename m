Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWDUO70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWDUO70 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 10:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWDUO70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 10:59:26 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:63440 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932344AbWDUO7Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 10:59:25 -0400
Subject: [PATCH 1/2] ext3 percpu counter fixes to suppport for more than
	2**31 ext3 free blocks counter
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: akpm@osdl.org
Cc: kiran@scalex86.org, LaurentVivier@wanadoo.fr, sct@redhat.com,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1144691929.3964.53.camel@dyn9047017067.beaverton.ibm.com>
References: <1144691929.3964.53.camel@dyn9047017067.beaverton.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Fri, 21 Apr 2006 07:59:06 -0700
Message-Id: <1145631546.4478.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches are to fix the percpu counter issue support more
than 2**31 blocks for ext3, i.e. allow the ext3 free block accounting
works with more than 8TB storage.

[PATCH 1] - Generic perpcu longlong type counter support: global counter
type changed from long to long long. The local counter is still remains
32 bit (long type), so we could avoid doing 64 bit update in most cases.
Fixed the percpu_counter_read_positive() to handle the  0 value counter
correctly;Add support to initialize the global counter to a value that
are greater than 2**32.

[PATCH 2] - ext3 part of the changes: make use of the new support to
initialize the free blocks counter, instead of using percpu_counter_mod
() indirectly.

Patches against 2.6.17-rc1-mm2. Tested on a freshly created 10TB ext3. 

Here is Patch 1.

Signed-Off-By: Mingming Cao <cmm@us.ibm.com>

---

 linux-2.6.16-cmm/include/linux/percpu_counter.h |   42 +++++++++++++++++-------
 linux-2.6.16-cmm/lib/percpu_counter.c           |    8 ++--
 2 files changed, 34 insertions(+), 16 deletions(-)

diff -puN include/linux/percpu_counter.h~percpu_longlong_counter include/linux/percpu_counter.h
--- linux-2.6.16/include/linux/percpu_counter.h~percpu_longlong_counter	2006-04-21 00:01:57.000000000 -0700
+++ linux-2.6.16-cmm/include/linux/percpu_counter.h	2006-04-21 00:02:39.000000000 -0700
@@ -17,7 +17,7 @@
 
 struct percpu_counter {
 	spinlock_t lock;
-	long count;
+	long long count;
 	long *counters;
 };
 
@@ -34,17 +34,25 @@ static inline void percpu_counter_init(s
 	fbc->counters = alloc_percpu(long);
 }
 
+static inline void
+percpu_counter_ll_init(struct percpu_counter *fbc, long long amount)
+{
+	spin_lock_init(&fbc->lock);
+	fbc->count = amount;
+	fbc->counters = alloc_percpu(long);
+}
+
 static inline void percpu_counter_destroy(struct percpu_counter *fbc)
 {
 	free_percpu(fbc->counters);
 }
 
 void percpu_counter_mod(struct percpu_counter *fbc, long amount);
-long percpu_counter_sum(struct percpu_counter *fbc);
+long long percpu_counter_sum(struct percpu_counter *fbc);
 void percpu_counter_mod_bh(struct percpu_counter *fbc, long amount);
-int percpu_counter_exceeds(struct percpu_counter *fbc, long limit);
+int percpu_counter_exceeds(struct percpu_counter *fbc, long long limit);
 
-static inline long percpu_counter_read(struct percpu_counter *fbc)
+static inline long long percpu_counter_read(struct percpu_counter *fbc)
 {
 	return fbc->count;
 }
@@ -52,13 +60,14 @@ static inline long percpu_counter_read(s
 /*
  * It is possible for the percpu_counter_read() to return a small negative
  * number for some counter which should never be negative.
+ *
  */
-static inline long percpu_counter_read_positive(struct percpu_counter *fbc)
+static inline long long percpu_counter_read_positive(struct percpu_counter *fbc)
 {
-	long ret = fbc->count;
+	long long ret = fbc->count;
 
 	barrier();		/* Prevent reloads of fbc->count */
-	if (ret > 0)
+	if (ret >= 0)
 		return ret;
 	return 1;
 }
@@ -66,7 +75,7 @@ static inline long percpu_counter_read_p
 #else
 
 struct percpu_counter {
-	long count;
+	long long count;
 };
 
 static inline void percpu_counter_init(struct percpu_counter *fbc)
@@ -74,6 +83,13 @@ static inline void percpu_counter_init(s
 	fbc->count = 0;
 }
 
+static inline void
+percpu_counter_ll_init(struct percpu_counter *fbc, long long amount)
+{
+	fbc->count = amount;
+}
+
+
 static inline void percpu_counter_destroy(struct percpu_counter *fbc)
 {
 }
@@ -86,17 +102,18 @@ percpu_counter_mod(struct percpu_counter
 	preempt_enable();
 }
 
-static inline long percpu_counter_read(struct percpu_counter *fbc)
+static inline long long percpu_counter_read(struct percpu_counter *fbc)
 {
 	return fbc->count;
 }
 
-static inline long percpu_counter_read_positive(struct percpu_counter *fbc)
+static inline long long percpu_counter_read_positive(struct percpu_counter *fbc)
 {
 	return fbc->count;
 }
 
-static inline long percpu_counter_sum(struct percpu_counter *fbc)
+static inline
+unsigned long long percpu_counter_sum(struct percpu_counter *fbc)
 {
 	return percpu_counter_read_positive(fbc);
 }
@@ -108,7 +125,8 @@ static inline void percpu_counter_mod_bh
 	local_bh_enable();
 }
 
-static inline int percpu_counter_exceeds(struct percpu_counter *fbc, long limit)
+static inline int
+percpu_counter_exceeds(struct percpu_counter *fbc, long long limit)
 {
 	return percpu_counter_read(fbc) > limit;
 }
diff -puN lib/percpu_counter.c~percpu_longlong_counter lib/percpu_counter.c
--- linux-2.6.16/lib/percpu_counter.c~percpu_longlong_counter	2006-04-21 00:01:57.000000000 -0700
+++ linux-2.6.16-cmm/lib/percpu_counter.c	2006-04-21 00:01:57.000000000 -0700
@@ -7,7 +7,7 @@
 
 static void __percpu_counter_mod(struct percpu_counter *fbc, long amount)
 {
-	long count;
+	long long count;
 	long *pcount;
 	int cpu = smp_processor_id();
 
@@ -43,9 +43,9 @@ EXPORT_SYMBOL(percpu_counter_mod_bh);
  * Add up all the per-cpu counts, return the result.  This is a more accurate
  * but much slower version of percpu_counter_read_positive()
  */
-long percpu_counter_sum(struct percpu_counter *fbc)
+long long percpu_counter_sum(struct percpu_counter *fbc)
 {
-	long ret;
+	long long ret;
 	int cpu;
 
 	spin_lock(&fbc->lock);
@@ -69,7 +69,7 @@ EXPORT_SYMBOL(percpu_counter_sum);
  * it turns out that the limit wasn't exceeded, there will be no more calls to
  * percpu_counter_sum() until significant counter skew has reoccurred.
  */
-int percpu_counter_exceeds(struct percpu_counter *fbc, long limit)
+int percpu_counter_exceeds(struct percpu_counter *fbc, long long limit)
 {
 	if (percpu_counter_read(fbc) > limit)
 		if (percpu_counter_sum(fbc) > limit)

_


