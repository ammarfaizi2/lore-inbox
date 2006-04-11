Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWDKBJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWDKBJr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 21:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWDKBJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 21:09:47 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:51617 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932242AbWDKBJq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 21:09:46 -0400
Subject: Re: [RFC][PATCH 1/3] per cpu counter fixes for unsigned long type
	counter overflow
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: kiran@scalex86.org, Laurent.Vivier@bull.net, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
In-Reply-To: <20060410151817.27766565.akpm@osdl.org>
References: <1144691947.3964.54.camel@dyn9047017067.beaverton.ibm.com>
	 <20060410151817.27766565.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 10 Apr 2006 18:09:39 -0700
Message-Id: <1144717779.3964.93.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-10 at 15:18 -0700, Andrew Morton wrote:
> Mingming Cao <cmm@us.ibm.com> wrote:
> >
> > [PATCH 1/3] - Currently the"long" type counter maintained in percpu
> > counter could have issue when handling a counter that is a unsigned long
> > type. Most cases this could be easily fixed by casting the returned
> > value to "unsigned long". But for the "overflow" issue, i.e. because of
> > the percpu global counter is a approsimate value, there is a
> > possibility that at some point the global counter is close to the max
> > limit (oxffff_feee) but after updating from a local counter a positive
> > value, the global counter becomes a small value (i.e.0x 00000012). 
> > 
> > This patch tries to avoid this overflow happen. When updating from a
> > local counter to the global counter, add a check to see if the updated
> > value is less than before if we are doing an positive add, or if the
> > updated value is greater than before if we are doing an negative add.
> > Either way we should postpone the updating from this local counter to
> > the global counter.
> > 
> >  
> > -static void __percpu_counter_mod(struct percpu_counter *fbc, long amount)
> > +static void __percpu_counter_mod(struct percpu_counter *fbc, long amount,
> > +				int llcheck)
> 
> Confused.  What does "ll" stand for throughout this patch?
>
> Whatever it is, I suspect we need to choose something better ;)
> 

Probably "ul" fits better than "ll"-- this llcheck is a flag that should
only need to turn on for unsigned long type counter.

> >  {
> >  	long count;
> >  	long *pcount;
> >  	int cpu = smp_processor_id();
> > +	unsigned long before, after;
> > +	int update = 1;
> >  
> >  	pcount = per_cpu_ptr(fbc->counters, cpu);
> >  	count = *pcount + amount;
> >  	if (count >= FBC_BATCH || count <= -FBC_BATCH) {
> >  		spin_lock(&fbc->lock);
> > -		fbc->count += count;
> > -		*pcount = 0;
> > +		before = fbc->count;
> > +		after = before + count;
> > +		if (llcheck && ((count > 0 && after < before) ||
> > +				( count < 0 && after > before)))
> > +			update = 0;
> > +
> > +		if (update) {
> > +			fbc->count = after;
> > +			*pcount = 0;
> > +		}
> 
> The above bit of magic deserves an explanatory comment.
> 

Certainly. How about this? Does this look still confusing?

Signed-Off-By: Mingming Cao <cmm@us.ibm.com>
---

 linux-2.6.16-cmm/include/linux/percpu_counter.h |   12 ++
 linux-2.6.16-cmm/lib/percpu_counter.c           |  103 ++++++++++++++++++++++--
 2 files changed, 108 insertions(+), 7 deletions(-)

diff -puN lib/percpu_counter.c~percpu_counter_unsigned_long_fix lib/percpu_counter.c
--- linux-2.6.16/lib/percpu_counter.c~percpu_counter_unsigned_long_fix	2006-04-10 17:10:36.000000000 -0700
+++ linux-2.6.16-cmm/lib/percpu_counter.c	2006-04-10 17:59:50.000000000 -0700
@@ -5,28 +5,89 @@
 #include <linux/percpu_counter.h>
 #include <linux/module.h>
 
-static void __percpu_counter_mod(struct percpu_counter *fbc, long amount)
+static void __percpu_counter_mod(struct percpu_counter *fbc, long amount,
+				int ul_overflow_check)
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
+		/*
+		 * Since the percpu counter need a signed value for the
+		 * global counter, and we are using percpu counter in some
+		 * places to support unsigned long type of counter,
+		 * we need to check whether the update will cause overflow
+		 * (i.e. before the global counter (fbc->count) is 0xfffffeee
+		 *  and the local counter (*pcount +amount) value is 290
+		 *  then we will end up with a bogus small global counter value
+		 *  0x00000123.) That's why we introduce a extra check here
+		 *  to support unsigned long type of counter.
+		 *
+		 *  Before updating the global counter, if we detect the
+		 *  updated new value will cause overflow, then we should not
+		 *  do the update from this local counter at this moment. (i.e.
+		 *  the local counter will not be cleared right now). The update
+		 *  will be deferred at some point until either other local
+		 *  counter updated the global counter first, or the local
+		 *  counter's value will not cause global counter overflow.
+		 *
+		 *  To check whether an update will cause overflow:
+		 *  if we see the new value for the global counter is less than
+		 *  before, and the update is intend to increase the
+		 *  global counter(positive add), then this is an overflow case.
+		 *
+		 *  Or if we see the new value is greater than before but we
+		 *  were intend to decrease the global counter (negative add),
+		 *  then this is an overflow.
+		 */
+
+		if (ul_overflow_check && ((count > 0 && after < before) ||
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
+/*
+ * percpu_counter_mod_ul() turns on the flag to check
+ * the possible overflow update for unsigned long type
+ * counter.  This function is added to support unsigned long
+ * type of counter.
+ *
+ * If the user of percpu counter is a type of unsigned long
+ * and is possible to reach the maximum of the data type allowed,
+ * and the changed amount is less than, say, 0x8000_0000 on 32 bit (i.e. there is
+ * no question about the updated value is -1 or a big number positive
+ * value), then it should use this function to update the
+ * counter instead of using percpu_counter_mod().
+ *
+ */
+void percpu_counter_mod_ul(struct percpu_counter *fbc, long amount)
+{
+	preempt_disable();
+	__percpu_counter_mod(fbc, amount, 1);
+	preempt_enable();
+}
+EXPORT_SYMBOL(percpu_counter_mod_ul);
 
 void percpu_counter_mod(struct percpu_counter *fbc, long amount)
 {
 	preempt_disable();
-	__percpu_counter_mod(fbc, amount);
+	__percpu_counter_mod(fbc, amount, 0);
 	preempt_enable();
 }
 EXPORT_SYMBOL(percpu_counter_mod);
@@ -34,7 +95,7 @@ EXPORT_SYMBOL(percpu_counter_mod);
 void percpu_counter_mod_bh(struct percpu_counter *fbc, long amount)
 {
 	local_bh_disable();
-	__percpu_counter_mod(fbc, amount);
+	__percpu_counter_mod(fbc, amount, 0);
 	local_bh_enable();
 }
 EXPORT_SYMBOL(percpu_counter_mod_bh);
@@ -42,8 +103,12 @@ EXPORT_SYMBOL(percpu_counter_mod_bh);
 /*
  * Add up all the per-cpu counts, return the result.  This is a more accurate
  * but much slower version of percpu_counter_read_positive()
+ *
+ * There are users of the percpu counter that are unsigned long type value
+ * so a real value of very large number is possible seems a negative value here.
+ * Add a check for that case.
  */
-long percpu_counter_sum(struct percpu_counter *fbc)
+long __percpu_counter_sum(struct percpu_counter *fbc, int ul_check)
 {
 	long ret;
 	int cpu;
@@ -55,9 +120,33 @@ long percpu_counter_sum(struct percpu_co
 		ret += *pcount;
 	}
 	spin_unlock(&fbc->lock);
-	return ret < 0 ? 0 : ret;
+	if (!ul_check && ret < 0)
+		ret = 0;
+	return ret;
+}
+long percpu_counter_sum(struct percpu_counter *fbc)
+{
+	return __percpu_counter_sum(fbc, 0);
 }
 EXPORT_SYMBOL(percpu_counter_sum);
+/*
+ * percpu_counter_sum_ul() turns on the flag to check
+ * the possible case where a real value is a large positive value
+ * but shows up as a negative value. This function is added as part of
+ * of support for unsigned long type counter.
+ *
+ * If the user of percpu counter is a type of unsigned long
+ * and is possible to greater than 0x8000_0000 and unlikely to be
+ * a negative value (i.e. free ext3 block counters),
+ * then it should use this function to sum up the
+ * counter instead of using percpu_counter_sum().
+ *
+ */
+long percpu_counter_sum_ul(struct percpu_counter *fbc)
+{
+	return __percpu_counter_sum(fbc, 1);
+}
+EXPORT_SYMBOL(percpu_counter_sum_ul);
 
 /*
  * Returns zero if the counter is within limit.  Returns non zero if counter
diff -puN include/linux/percpu_counter.h~percpu_counter_unsigned_long_fix include/linux/percpu_counter.h
--- linux-2.6.16/include/linux/percpu_counter.h~percpu_counter_unsigned_long_fix	2006-04-10 17:10:36.000000000 -0700
+++ linux-2.6.16-cmm/include/linux/percpu_counter.h	2006-04-10 18:05:00.000000000 -0700
@@ -40,7 +40,9 @@ static inline void percpu_counter_destro
 }
 
 void percpu_counter_mod(struct percpu_counter *fbc, long amount);
+void percpu_counter_mod_ul(struct percpu_counter *fbc, long amount);
 long percpu_counter_sum(struct percpu_counter *fbc);
+long percpu_counter_sum_ul(struct percpu_counter *fbc);
 void percpu_counter_mod_bh(struct percpu_counter *fbc, long amount);
 int percpu_counter_exceeds(struct percpu_counter *fbc, long limit);
 
@@ -120,10 +122,20 @@ static inline void percpu_counter_inc(st
 	percpu_counter_mod(fbc, 1);
 }
 
+static inline void percpu_counter_inc_ul(struct percpu_counter *fbc)
+{
+	percpu_counter_mod_ul(fbc, 1);
+}
+
 static inline void percpu_counter_dec(struct percpu_counter *fbc)
 {
 	percpu_counter_mod(fbc, -1);
 }
 
+static inline void percpu_counter_dec_ul(struct percpu_counter *fbc)
+{
+	percpu_counter_mod_ul(fbc, -1);
+}
+
 
 #endif /* _LINUX_PERCPU_COUNTER_H */

_


