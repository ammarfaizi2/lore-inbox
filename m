Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbVLAADA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbVLAADA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVLAACO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 19:02:14 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:29347
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751335AbVK3X6s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:58:48 -0500
Subject: [patch 43/43] ktimeout code style cleanups
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:04:29 +0100
Message-Id: <1133395469.32542.487.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (ktimeout-tidy.patch)
- code style cleanups

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 kernel/ktimeout.c |   41 ++++++++++++++---------------------------
 1 files changed, 14 insertions(+), 27 deletions(-)

Index: linux/kernel/ktimeout.c
===================================================================
--- linux.orig/kernel/ktimeout.c
+++ linux/kernel/ktimeout.c
@@ -16,26 +16,12 @@
  *              Designed by David S. Miller, Alexey Kuznetsov and Ingo Molnar
  */
 
-#include <linux/kernel_stat.h>
+#include <linux/notifier.h>
 #include <linux/module.h>
-#include <linux/interrupt.h>
 #include <linux/percpu.h>
 #include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/swap.h>
-#include <linux/notifier.h>
-#include <linux/thread_info.h>
-#include <linux/time.h>
-#include <linux/jiffies.h>
-#include <linux/posix-timers.h>
 #include <linux/cpu.h>
-#include <linux/syscalls.h>
-
-#include <asm/uaccess.h>
-#include <asm/unistd.h>
-#include <asm/div64.h>
-#include <asm/timex.h>
-#include <asm/io.h>
+#include <linux/mm.h>
 
 /*
  * per-CPU ktimeout vector definitions:
@@ -246,9 +232,9 @@ EXPORT_SYMBOL(__ktimeout_mod);
 void ktimeout_add_on(struct ktimeout *ktimeout, int cpu)
 {
 	tvec_base_t *base = &per_cpu(tvec_bases, cpu);
-  	unsigned long flags;
+	unsigned long flags;
 
-  	BUG_ON(ktimeout_pending(ktimeout) || !ktimeout->function);
+	BUG_ON(ktimeout_pending(ktimeout) || !ktimeout->function);
 	spin_lock_irqsave(&base->t_base.lock, flags);
 	ktimeout->base = &base->t_base;
 	internal_ktimeout_add(base, ktimeout);
@@ -389,7 +375,7 @@ static int cascade(tvec_base_t *base, tv
 	head = tv->vec + index;
 	curr = head->next;
 	/*
-	 * We are removing _all_ timeouts from the list, so we don't  have to
+	 * We are removing _all_ timeouts from the list, so we don't have to
 	 * detach them individually, just clear the list afterwards.
 	 */
 	while (curr != head) {
@@ -412,7 +398,8 @@ static int cascade(tvec_base_t *base, tv
  * This function cascades all vectors and executes all expired timeout
  * vectors.
  */
-#define INDEX(N) (base->ktimeout_jiffies >> (TVR_BITS + N * TVN_BITS)) & TVN_MASK
+#define INDEX(N) \
+	(base->ktimeout_jiffies >> (TVR_BITS + N * TVN_BITS)) & TVN_MASK
 
 static inline void __run_ktimeouts(tvec_base_t *base)
 {
@@ -422,8 +409,8 @@ static inline void __run_ktimeouts(tvec_
 	while (time_after_eq(jiffies, base->ktimeout_jiffies)) {
 		struct list_head work_list = LIST_HEAD_INIT(work_list);
 		struct list_head *head = &work_list;
- 		int index = base->ktimeout_jiffies & TVR_MASK;
- 
+		int index = base->ktimeout_jiffies & TVR_MASK;
+
 		/*
 		 * Cascade timeouts:
 		 */
@@ -432,15 +419,15 @@ static inline void __run_ktimeouts(tvec_
 				(!cascade(base, &base->tv3, INDEX(1))) &&
 					!cascade(base, &base->tv4, INDEX(2)))
 			cascade(base, &base->tv5, INDEX(3));
-		++base->ktimeout_jiffies; 
+		++base->ktimeout_jiffies;
 		list_splice_init(base->tv1.vec + index, &work_list);
 		while (!list_empty(head)) {
 			void (*fn)(unsigned long);
 			unsigned long data;
 
 			ktimeout = list_entry(head->next,struct ktimeout,entry);
- 			fn = ktimeout->function;
- 			data = ktimeout->data;
+			fn = ktimeout->function;
+			data = ktimeout->data;
 
 			set_running_ktimeout(base, ktimeout);
 			detach_ktimeout(ktimeout, 1);
@@ -540,7 +527,7 @@ static void run_ktimeout_softirq(struct 
 {
 	tvec_base_t *base = &__get_cpu_var(tvec_bases);
 
- 	ktimer_run_queues();
+	ktimer_run_queues();
 	if (time_after_eq(jiffies, base->ktimeout_jiffies))
 		__run_ktimeouts(base);
 }
@@ -744,7 +731,7 @@ static void __devinit migrate_ktimeouts(
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-static int __devinit ktimeout_cpu_notify(struct notifier_block *self, 
+static int __devinit ktimeout_cpu_notify(struct notifier_block *self,
 				unsigned long action, void *hcpu)
 {
 	long cpu = (long)hcpu;

--

