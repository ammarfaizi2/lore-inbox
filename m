Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWDJR7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWDJR7V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 13:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbWDJR7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 13:59:20 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:25795 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932068AbWDJR7R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 13:59:17 -0400
Subject: [RFC][PATCH 1/3] per cpu counter fixes for unsigned long type
	counter overflow
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: akpm@osdl.org
Cc: kiran@scalex86.org, Laurent Vivier <Laurent.Vivier@bull.net>,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 10 Apr 2006 10:59:07 -0700
Message-Id: <1144691947.3964.54.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 1/3] - Currently the"long" type counter maintained in percpu
counter could have issue when handling a counter that is a unsigned long
type. Most cases this could be easily fixed by casting the returned
value to "unsigned long". But for the "overflow" issue, i.e. because of
the percpu global counter is a approsimate value, there is a
possibility that at some point the global counter is close to the max
limit (oxffff_feee) but after updating from a local counter a positive
value, the global counter becomes a small value (i.e.0x 00000012). 

This patch tries to avoid this overflow happen. When updating from a
local counter to the global counter, add a check to see if the updated
value is less than before if we are doing an positive add, or if the
updated value is greater than before if we are doing an negative add.
Either way we should postpone the updating from this local counter to
the global counter.

Signed-Off-By: Mingming Cao <cmm@us.ibm.com>

---

 linux-2.6.16-cmm/include/linux/percpu_counter.h |   12 ++++++
 linux-2.6.16-cmm/lib/percpu_counter.c           |   44 ++++++++++++++++++++----
 2 files changed, 49 insertions(+), 7 deletions(-)

diff -puN lib/percpu_counter.c~percpu_counter_unsigned_long_fix lib/percpu_counter.c
--- linux-2.6.16/lib/percpu_counter.c~percpu_counter_unsigned_long_fix	2006-04-05 10:03:07.000000000 -0700
+++ linux-2.6.16-cmm/lib/percpu_counter.c	2006-04-05 10:13:58.000000000 -0700
@@ -5,28 +5,47 @@
 #include <linux/percpu_counter.h>
 #include <linux/module.h>
 
-static void __percpu_counter_mod(struct percpu_counter *fbc, long amount)
+static void __percpu_counter_mod(struct percpu_counter *fbc, long amount,
+				int llcheck)
 {
 	long count;
 	long *pcount;
 	int cpu = smp_processor_id();
+	unsigned long before, after;
+	int update = 1;
 
 	pcount = per_cpu_ptr(fbc->counters, cpu);
 	count = *pcount + amount;
 	if (count >= FBC_BATCH || count <= -FBC_BATCH) {
 		spin_lock(&fbc->lock);
-		fbc->count += count;
-		*pcount = 0;
+		before = fbc->count;
+		after = before + count;
+		if (llcheck && ((count > 0 && after < before) ||
+				( count < 0 && after > before)))
+			update = 0;
+
+		if (update) {
+			fbc->count = after;
+			*pcount = 0;
+		}
 		spin_unlock(&fbc->lock);
 	} else {
 		*pcount = count;
 	}
 }
 
+void percpu_counter_mod_ll(struct percpu_counter *fbc, long amount)
+{
+	preempt_disable();
+	__percpu_counter_mod(fbc, amount, 1);
+	preempt_enable();
+}
+EXPORT_SYMBOL(percpu_counter_mod_ll);
+
 void percpu_counter_mod(struct percpu_counter *fbc, long amount)
 {
 	preempt_disable();
-	__percpu_counter_mod(fbc, amount);
+	__percpu_counter_mod(fbc, amount, 0);
 	preempt_enable();
 }
 EXPORT_SYMBOL(percpu_counter_mod);
@@ -34,7 +53,7 @@ EXPORT_SYMBOL(percpu_counter_mod);
 void percpu_counter_mod_bh(struct percpu_counter *fbc, long amount)
 {
 	local_bh_disable();
-	__percpu_counter_mod(fbc, amount);
+	__percpu_counter_mod(fbc, amount, 0);
 	local_bh_enable();
 }
 EXPORT_SYMBOL(percpu_counter_mod_bh);
@@ -43,7 +62,7 @@ EXPORT_SYMBOL(percpu_counter_mod_bh);
  * Add up all the per-cpu counts, return the result.  This is a more accurate
  * but much slower version of percpu_counter_read_positive()
  */
-long percpu_counter_sum(struct percpu_counter *fbc)
+long __percpu_counter_sum(struct percpu_counter *fbc, int llcheck)
 {
 	long ret;
 	int cpu;
@@ -55,9 +74,20 @@ long percpu_counter_sum(struct percpu_co
 		ret += *pcount;
 	}
 	spin_unlock(&fbc->lock);
-	return ret < 0 ? 0 : ret;
+	if (!llcheck && ret < 0)
+		ret = 0;
+	return ret;
+}
+long percpu_counter_sum(struct percpu_counter *fbc)
+{
+	return __percpu_counter_sum(fbc, 0);
 }
 EXPORT_SYMBOL(percpu_counter_sum);
+long percpu_counter_sum_ll(struct percpu_counter *fbc)
+{
+	return __percpu_counter_sum(fbc, 1);
+}
+EXPORT_SYMBOL(percpu_counter_sum_ll);
 
 /*
  * Returns zero if the counter is within limit.  Returns non zero if counter
diff -puN include/linux/percpu_counter.h~percpu_counter_unsigned_long_fix include/linux/percpu_counter.h
--- linux-2.6.16/include/linux/percpu_counter.h~percpu_counter_unsigned_long_fix	2006-04-05 10:03:07.000000000 -0700
+++ linux-2.6.16-cmm/include/linux/percpu_counter.h	2006-04-05 10:16:38.000000000 -0700
@@ -40,7 +40,9 @@ static inline void percpu_counter_destro
 }
 
 void percpu_counter_mod(struct percpu_counter *fbc, long amount);
+void percpu_counter_mod_ll(struct percpu_counter *fbc, long amount);
 long percpu_counter_sum(struct percpu_counter *fbc);
+long percpu_counter_sum_ll(struct percpu_counter *fbc);
 void percpu_counter_mod_bh(struct percpu_counter *fbc, long amount);
 int percpu_counter_exceeds(struct percpu_counter *fbc, long limit);
 
@@ -120,10 +122,20 @@ static inline void percpu_counter_inc(st
 	percpu_counter_mod(fbc, 1);
 }
 
+static inline void percpu_counter_inc_ll(struct percpu_counter *fbc)
+{
+	percpu_counter_mod_ll(fbc, 1);
+}
+
 static inline void percpu_counter_dec(struct percpu_counter *fbc)
 {
 	percpu_counter_mod(fbc, -1);
 }
 
+static inline void percpu_counter_dec_ll(struct percpu_counter *fbc)
+{
+	percpu_counter_mod_ll(fbc, -1);
+}
+
 
 #endif /* _LINUX_PERCPU_COUNTER_H */

_


