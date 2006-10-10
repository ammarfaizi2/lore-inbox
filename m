Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWJJQEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWJJQEt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 12:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWJJQEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 12:04:49 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:9345 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S932179AbWJJQEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 12:04:48 -0400
Subject: [patch 1/2] round_jiffies infrastructure
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, akpm@osdl.org
In-Reply-To: <1160496165.3000.308.camel@laptopd505.fenrus.org>
References: <1160496165.3000.308.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 10 Oct 2006 18:03:30 +0200
Message-Id: <1160496210.3000.310.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>
Subject: round_jiffies infrastructure

This patch introduces a round_jiffies() function as well as a
round_jiffies_relative() function. These functions round a jiffies value
to the next whole second. The primary purpose of this rounding is to
cause all "we don't care exactly when" timers to happen at the same jiffy.
This avoids multiple timers to fire within the second for no real reason;
with dynamic ticks these extra timers cause wakeups from deep sleep
CPU sleep states and thus waste power. 

The exact wakeup moment is skewed by the cpu number, to avoid all
cpus from waking up at the exact same time (and hitting the same 
lock/cachelines there)

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>



Index: linux-2.6.19-rc1-git6/include/linux/timer.h
===================================================================
--- linux-2.6.19-rc1-git6.orig/include/linux/timer.h
+++ linux-2.6.19-rc1-git6/include/linux/timer.h
@@ -98,4 +98,10 @@ extern void run_local_timers(void);
 struct hrtimer;
 extern int it_real_fn(struct hrtimer *);
 
+unsigned long __round_jiffies(unsigned long T, int CPU);
+unsigned long __round_jiffies_relative(unsigned long T, int CPU);
+unsigned long round_jiffies(unsigned long T);
+unsigned long round_jiffies_relative(unsigned long T);
+
+
 #endif
Index: linux-2.6.19-rc1-git6/kernel/timer.c
===================================================================
--- linux-2.6.19-rc1-git6.orig/kernel/timer.c
+++ linux-2.6.19-rc1-git6/kernel/timer.c
@@ -80,6 +80,56 @@ tvec_base_t boot_tvec_bases;
 EXPORT_SYMBOL(boot_tvec_bases);
 static DEFINE_PER_CPU(tvec_base_t *, tvec_bases) = &boot_tvec_bases;
 
+unsigned long __round_jiffies(unsigned long T, int CPU)
+{
+	int rem;
+	int original  = T;
+	rem = T % HZ;
+	if (rem < HZ/4)
+		T = T - rem;
+	else
+		T = T - rem + HZ;
+	/* we don't want all cpus firing at once hitting the same lock/memory */
+	T += CPU * 3;
+	if (T <= jiffies) /* rounding ate our timeout entirely */
+		return original;
+	return T;
+}
+EXPORT_SYMBOL_GPL(__round_jiffies);
+
+unsigned long __round_jiffies_relative(unsigned long T, int CPU)
+{
+	int rem;
+	int original = T;
+	T=T+jiffies;
+	rem = T % HZ;
+	if (rem < HZ/4)
+		T = T - rem;
+	else
+		T = T - rem + HZ;
+	/* we don't want all cpus firing at once hitting the same lock/memory */
+	T += CPU * 3;
+	T = T-jiffies;
+	if (T<=0) /* rounding ate our delay entirely, don't round */
+		return original;
+	return T;
+}
+EXPORT_SYMBOL_GPL(__round_jiffies_relative);
+
+unsigned long round_jiffies(unsigned long T)
+{
+	return __round_jiffies(T, raw_smp_processor_id());
+}
+EXPORT_SYMBOL_GPL(round_jiffies);
+
+unsigned long round_jiffies_relative(unsigned long T)
+{
+	return __round_jiffies_relative(T, raw_smp_processor_id());
+}
+EXPORT_SYMBOL_GPL(round_jiffies_relative);
+
+
+
 static inline void set_running_timer(tvec_base_t *base,
 					struct timer_list *timer)
 {

