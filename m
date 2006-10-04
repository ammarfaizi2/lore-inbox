Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422638AbWJDRl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422638AbWJDRl6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422637AbWJDRl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:41:57 -0400
Received: from www.osadl.org ([213.239.205.134]:15845 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161872AbWJDRhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:37:55 -0400
Message-Id: <20061004172222.779695000@cruncher.tec.linutronix.de>
References: <20061004172217.092570000@cruncher.tec.linutronix.de>
Date: Wed, 04 Oct 2006 17:31:38 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       John Stultz <johnstul@us.ibm.com>,
       Valdis Kletnieks <valdis.kletnieks@vt.edu>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, Jim Gettys <jg@laptop.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 08/22] dynticks: extend next_timer_interrupt() to use a
	reference jiffie
Content-Disposition: inline;
	filename=dynticks-extend-next_timer_interrupt-to-use-a.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

For CONFIG_NO_HZ we need to calculate the next timer wheel event based to a
given jiffie value.  Extend the existing code to allow the extra now argument.
Provide a compability function for the existing implementations to call the
function with now = jiffies.  This also solves the racyness of the original
code vs.  jiffies changing during the iteration.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
 include/linux/timer.h |   10 +++++
 kernel/timer.c        |   97 ++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 81 insertions(+), 26 deletions(-)

Index: linux-2.6.18-mm3/include/linux/timer.h
===================================================================
--- linux-2.6.18-mm3.orig/include/linux/timer.h	2006-10-04 18:13:52.000000000 +0200
+++ linux-2.6.18-mm3/include/linux/timer.h	2006-10-04 18:13:55.000000000 +0200
@@ -61,7 +61,17 @@ extern int del_timer(struct timer_list *
 extern int __mod_timer(struct timer_list *timer, unsigned long expires);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
 
+/*
+ * Return when the next timer-wheel timeout occurs (in absolute jiffies),
+ * locks the timer base:
+ */
 extern unsigned long next_timer_interrupt(void);
+/*
+ * Return when the next timer-wheel timeout occurs (in absolute jiffies),
+ * locks the timer base and does the comparison against the given
+ * jiffie.
+ */
+extern unsigned long get_next_timer_interrupt(unsigned long now);
 
 /***
  * add_timer - start a timer
Index: linux-2.6.18-mm3/kernel/timer.c
===================================================================
--- linux-2.6.18-mm3.orig/kernel/timer.c	2006-10-04 18:13:54.000000000 +0200
+++ linux-2.6.18-mm3/kernel/timer.c	2006-10-04 18:13:55.000000000 +0200
@@ -468,29 +468,14 @@ static inline void __run_timers(tvec_bas
  * is used on S/390 to stop all activity when a cpus is idle.
  * This functions needs to be called disabled.
  */
-unsigned long next_timer_interrupt(void)
+unsigned long __next_timer_interrupt(tvec_base_t *base, unsigned long now)
 {
-	tvec_base_t *base;
 	struct list_head *list;
-	struct timer_list *nte;
+	struct timer_list *nte, *found = NULL;
 	unsigned long expires;
-	unsigned long hr_expires = MAX_JIFFY_OFFSET;
-	ktime_t hr_delta;
 	tvec_t *varray[4];
 	int i, j;
 
-	hr_delta = hrtimer_get_next_event();
-	if (hr_delta.tv64 != KTIME_MAX) {
-		struct timespec tsdelta;
-		tsdelta = ktime_to_timespec(hr_delta);
-		hr_expires = timespec_to_jiffies(&tsdelta);
-		if (hr_expires < 3)
-			return hr_expires + jiffies;
-	}
-	hr_expires += jiffies;
-
-	base = __get_cpu_var(tvec_bases);
-	spin_lock(&base->lock);
 	expires = base->timer_jiffies + (LONG_MAX >> 1);
 	list = NULL;
 
@@ -499,6 +484,7 @@ unsigned long next_timer_interrupt(void)
 	do {
 		list_for_each_entry(nte, base->tv1.vec + j, entry) {
 			expires = nte->expires;
+			found = nte;
 			if (j < (base->timer_jiffies & TVR_MASK))
 				list = base->tv2.vec + (INDEX(0));
 			goto found;
@@ -518,9 +504,12 @@ unsigned long next_timer_interrupt(void)
 				j = (j + 1) & TVN_MASK;
 				continue;
 			}
-			list_for_each_entry(nte, varray[i]->vec + j, entry)
-				if (time_before(nte->expires, expires))
+			list_for_each_entry(nte, varray[i]->vec + j, entry) {
+				if (time_before(nte->expires, expires)) {
 					expires = nte->expires;
+					found = nte;
+				}
+			}
 			if (j < (INDEX(i)) && i < 3)
 				list = varray[i + 1]->vec + (INDEX(i + 1));
 			goto found;
@@ -534,10 +523,59 @@ found:
 		 * where we found the timer element.
 		 */
 		list_for_each_entry(nte, list, entry) {
-			if (time_before(nte->expires, expires))
+			if (time_before(nte->expires, expires)) {
 				expires = nte->expires;
+				found = nte;
+			}
 		}
 	}
+	WARN_ON(!found);
+
+	return expires;
+}
+
+#ifdef CONFIG_NO_HZ
+
+unsigned long get_next_timer_interrupt(unsigned long now)
+{
+	tvec_base_t *base = __get_cpu_var(tvec_bases);
+	unsigned long expires;
+
+	spin_lock(&base->lock);
+	expires = __next_timer_interrupt(base, now);
+	spin_unlock(&base->lock);
+
+	/*
+	 * 'Timer wheel time' can lag behind 'jiffies time' due to
+	 * delayed processing, so make sure we return a value that
+	 * makes sense externally. base->timer_jiffies is unchanged,
+	 * so it is safe to access it outside the lock.
+	 */
+
+	return expires - (now - base->timer_jiffies);
+}
+
+#else
+
+unsigned long next_timer_interrupt(void)
+{
+	tvec_base_t *base = __get_cpu_var(tvec_bases);
+	unsigned long expires;
+	unsigned long now = jiffies;
+	unsigned long hr_expires = MAX_JIFFY_OFFSET;
+	ktime_t hr_delta = hrtimer_get_next_event();
+
+	if (hr_delta.tv64 != KTIME_MAX) {
+		struct timespec tsdelta;
+		tsdelta = ktime_to_timespec(hr_delta);
+		hr_expires = timespec_to_jiffies(&tsdelta);
+		if (hr_expires < 3)
+			return hr_expires + now;
+	}
+	hr_expires += now;
+
+	spin_lock(&base->lock);
+	expires = __next_timer_interrupt(base, now);
 	spin_unlock(&base->lock);
 
 	/*
@@ -553,16 +591,23 @@ found:
 	 * would falsely evaluate to true.  If that is the case, just
 	 * return jiffies so that we can immediately fire the local timer
 	 */
-	if (time_before(expires, jiffies))
-		return jiffies;
+	if (time_before(expires, now))
+		expires = now;
+	else if (time_before(hr_expires, expires))
+		expires = hr_expires;
 
-	if (time_before(hr_expires, expires))
-		return hr_expires;
-
-	return expires;
+	/*
+	 * 'Timer wheel time' can lag behind 'jiffies time' due to
+	 * delayed processing, so make sure we return a value that
+	 * makes sense externally. base->timer_jiffies is unchanged,
+	 * so it is safe to access it outside the lock.
+	 */
+	return expires - (now - base->timer_jiffies);
 }
 #endif
 
+#endif
+
 /******************************************************************/
 
 /* 

--

