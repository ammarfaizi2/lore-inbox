Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318782AbSICOs1>; Tue, 3 Sep 2002 10:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318783AbSICOs1>; Tue, 3 Sep 2002 10:48:27 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:64004
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S318782AbSICOs0>; Tue, 3 Sep 2002 10:48:26 -0400
Subject: [PATCH] bad: schedule() with irqs disabled!
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, morten.helgesen@nextframe.net
In-Reply-To: <20020903153636.A1415@sexything>
References: <20020903153636.A1415@sexything>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 03 Sep 2002 10:52:55 -0400
Message-Id: <1031064775.979.3205.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-03 at 09:36, Morten Helgesen wrote:

> bad: schedule() with irqs disabled!

OK, Linus, you are right... there are enough instances of this we are
not going to find them all (although I suspect Andrew's slab.c fixes
will cover most of the cases).  Further, I think we can should actually
purposely call preempt_schedule() in certain cases after interrupt
reenable to check for reschedules...

Let's just make it a rule "no preemption if interrupts are off" and
enforce that.

Patch is against 2.5.33-BK, please apply.

	Robert Love

diff -urN linux-2.5.33/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.33/kernel/sched.c	Sat Aug 31 18:04:53 2002
+++ linux/kernel/sched.c	Tue Sep  3 10:48:56 2002
@@ -1032,15 +1032,12 @@
 {
 	struct thread_info *ti = current_thread_info();
 
-	if (unlikely(ti->preempt_count))
+	/*
+	 * If there is a non-zero preempt_count or interrupts are disabled,
+	 * we do not want to preempt the current task.  Just return..
+	 */
+	if (unlikely(ti->preempt_count || irqs_disabled()))
 		return;
-	if (unlikely(irqs_disabled())) {
-		preempt_disable();
-		printk("bad: schedule() with irqs disabled!\n");
-		show_stack(NULL);
-		preempt_enable_no_resched();
-		return;
-	}
 
 need_resched:
 	ti->preempt_count = PREEMPT_ACTIVE;

