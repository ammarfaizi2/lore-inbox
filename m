Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266535AbUGKKkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266535AbUGKKkb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 06:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266551AbUGKKkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 06:40:31 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:48071 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266535AbUGKKkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 06:40:18 -0400
Date: Sun, 11 Jul 2004 12:40:13 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: davej@codemonkey.org.uk
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [2.6 patch] cpufreq.c: reorder for inlining
Message-ID: <20040711104012.GB4701@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to compile drivers/cpufreq/cpufreq.c with gcc 3.4 and
  # define inline         __inline__ __attribute__((always_inline))
results in the following compile error:

<--  snip  -->

...
  CC      drivers/cpufreq/cpufreq.o
drivers/cpufreq/cpufreq.c: In function `cpufreq_resume':
drivers/cpufreq/cpufreq.c:39: sorry, unimplemented: inlining failed in 
call to 'adjust_jiffies': function body not available
drivers/cpufreq/cpufreq.c:628: sorry, unimplemented: called from here
make[2]: *** [drivers/cpufreq/cpufreq.o] Error 1

<--  snip  -->


The patc below reorders cpufreq.c to move adjust_jiffies before it's 
callers.


diffstat output:
 drivers/cpufreq/cpufreq.c |  160 +++++++++++++++++++-------------------
 1 files changed, 80 insertions(+), 80 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm7-full-gcc3.4/drivers/cpufreq/cpufreq.c.old	2004-07-11 12:28:33.000000000 +0200
+++ linux-2.6.7-mm7-full-gcc3.4/drivers/cpufreq/cpufreq.c	2004-07-11 12:33:28.000000000 +0200
@@ -100,6 +100,86 @@
 }
 
 /*********************************************************************
+ *            EXTERNALLY AFFECTING FREQUENCY CHANGES                 *
+ *********************************************************************/
+
+/**
+ * adjust_jiffies - adjust the system "loops_per_jiffy"
+ *
+ * This function alters the system "loops_per_jiffy" for the clock
+ * speed change. Note that loops_per_jiffy cannot be updated on SMP
+ * systems as each CPU might be scaled differently. So, use the arch 
+ * per-CPU loops_per_jiffy value wherever possible.
+ */
+#ifndef CONFIG_SMP
+static unsigned long l_p_j_ref;
+static unsigned int  l_p_j_ref_freq;
+
+static inline void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci)
+{
+	if (ci->flags & CPUFREQ_CONST_LOOPS)
+		return;
+
+	if (!l_p_j_ref_freq) {
+		l_p_j_ref = loops_per_jiffy;
+		l_p_j_ref_freq = ci->old;
+	}
+	if ((val == CPUFREQ_PRECHANGE  && ci->old < ci->new) ||
+	    (val == CPUFREQ_POSTCHANGE && ci->old > ci->new) ||
+	    (val == CPUFREQ_RESUMECHANGE))
+		loops_per_jiffy = cpufreq_scale(l_p_j_ref, l_p_j_ref_freq, ci->new);
+}
+#else
+static inline void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci) { return; }
+#endif
+
+
+/**
+ * cpufreq_notify_transition - call notifier chain and adjust_jiffies on frequency transition
+ *
+ * This function calls the transition notifiers and the "adjust_jiffies" function. It is called
+ * twice on all CPU frequency changes that have external effects. 
+ */
+void cpufreq_notify_transition(struct cpufreq_freqs *freqs, unsigned int state)
+{
+	BUG_ON(irqs_disabled());
+
+	freqs->flags = cpufreq_driver->flags;
+
+	down_read(&cpufreq_notifier_rwsem);
+	switch (state) {
+	case CPUFREQ_PRECHANGE:
+		/* detect if the driver reported a value as "old frequency" which
+		 * is not equal to what the cpufreq core thinks is "old frequency".
+		 */
+		if (!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
+			if ((likely(cpufreq_cpu_data[freqs->cpu]->cur)) &&
+			    (unlikely(freqs->old != cpufreq_cpu_data[freqs->cpu]->cur)))
+			{
+				if (cpufreq_driver->flags & CPUFREQ_PANIC_OUTOFSYNC)
+					panic("CPU Frequency is out of sync.");
+
+				printk(KERN_WARNING "Warning: CPU frequency is %u, "
+				       "cpufreq assumed %u kHz.\n", freqs->old, cpufreq_cpu_data[freqs->cpu]->cur);
+				freqs->old = cpufreq_cpu_data[freqs->cpu]->cur;
+			}
+		}
+		notifier_call_chain(&cpufreq_transition_notifier_list, CPUFREQ_PRECHANGE, freqs);
+		adjust_jiffies(CPUFREQ_PRECHANGE, freqs);
+		break;
+	case CPUFREQ_POSTCHANGE:
+		adjust_jiffies(CPUFREQ_POSTCHANGE, freqs);
+		notifier_call_chain(&cpufreq_transition_notifier_list, CPUFREQ_POSTCHANGE, freqs);
+		cpufreq_cpu_data[freqs->cpu]->cur = freqs->new;
+		break;
+	}
+	up_read(&cpufreq_notifier_rwsem);
+}
+EXPORT_SYMBOL_GPL(cpufreq_notify_transition);
+
+
+
+/*********************************************************************
  *                          SYSFS INTERFACE                          *
  *********************************************************************/
 
@@ -1008,86 +1088,6 @@
 
 
 /*********************************************************************
- *            EXTERNALLY AFFECTING FREQUENCY CHANGES                 *
- *********************************************************************/
-
-/**
- * adjust_jiffies - adjust the system "loops_per_jiffy"
- *
- * This function alters the system "loops_per_jiffy" for the clock
- * speed change. Note that loops_per_jiffy cannot be updated on SMP
- * systems as each CPU might be scaled differently. So, use the arch 
- * per-CPU loops_per_jiffy value wherever possible.
- */
-#ifndef CONFIG_SMP
-static unsigned long l_p_j_ref;
-static unsigned int  l_p_j_ref_freq;
-
-static inline void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci)
-{
-	if (ci->flags & CPUFREQ_CONST_LOOPS)
-		return;
-
-	if (!l_p_j_ref_freq) {
-		l_p_j_ref = loops_per_jiffy;
-		l_p_j_ref_freq = ci->old;
-	}
-	if ((val == CPUFREQ_PRECHANGE  && ci->old < ci->new) ||
-	    (val == CPUFREQ_POSTCHANGE && ci->old > ci->new) ||
-	    (val == CPUFREQ_RESUMECHANGE))
-		loops_per_jiffy = cpufreq_scale(l_p_j_ref, l_p_j_ref_freq, ci->new);
-}
-#else
-static inline void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci) { return; }
-#endif
-
-
-/**
- * cpufreq_notify_transition - call notifier chain and adjust_jiffies on frequency transition
- *
- * This function calls the transition notifiers and the "adjust_jiffies" function. It is called
- * twice on all CPU frequency changes that have external effects. 
- */
-void cpufreq_notify_transition(struct cpufreq_freqs *freqs, unsigned int state)
-{
-	BUG_ON(irqs_disabled());
-
-	freqs->flags = cpufreq_driver->flags;
-
-	down_read(&cpufreq_notifier_rwsem);
-	switch (state) {
-	case CPUFREQ_PRECHANGE:
-		/* detect if the driver reported a value as "old frequency" which
-		 * is not equal to what the cpufreq core thinks is "old frequency".
-		 */
-		if (!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
-			if ((likely(cpufreq_cpu_data[freqs->cpu]->cur)) &&
-			    (unlikely(freqs->old != cpufreq_cpu_data[freqs->cpu]->cur)))
-			{
-				if (cpufreq_driver->flags & CPUFREQ_PANIC_OUTOFSYNC)
-					panic("CPU Frequency is out of sync.");
-
-				printk(KERN_WARNING "Warning: CPU frequency is %u, "
-				       "cpufreq assumed %u kHz.\n", freqs->old, cpufreq_cpu_data[freqs->cpu]->cur);
-				freqs->old = cpufreq_cpu_data[freqs->cpu]->cur;
-			}
-		}
-		notifier_call_chain(&cpufreq_transition_notifier_list, CPUFREQ_PRECHANGE, freqs);
-		adjust_jiffies(CPUFREQ_PRECHANGE, freqs);
-		break;
-	case CPUFREQ_POSTCHANGE:
-		adjust_jiffies(CPUFREQ_POSTCHANGE, freqs);
-		notifier_call_chain(&cpufreq_transition_notifier_list, CPUFREQ_POSTCHANGE, freqs);
-		cpufreq_cpu_data[freqs->cpu]->cur = freqs->new;
-		break;
-	}
-	up_read(&cpufreq_notifier_rwsem);
-}
-EXPORT_SYMBOL_GPL(cpufreq_notify_transition);
-
-
-
-/*********************************************************************
  *               REGISTER / UNREGISTER CPUFREQ DRIVER                *
  *********************************************************************/
 

