Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319522AbSIMHbk>; Fri, 13 Sep 2002 03:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319541AbSIMHbj>; Fri, 13 Sep 2002 03:31:39 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:21256
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S319522AbSIMHbj>; Fri, 13 Sep 2002 03:31:39 -0400
Subject: Re: [PATCH] kernel BUG at sched.c:944! only with CONFIG_PREEMPT=y]
From: Robert Love <rml@tech9.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Cole <elenstev@mesatop.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>, Steven Cole <scole@lanl.gov>
In-Reply-To: <Pine.LNX.4.44.0209130914190.28568-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0209130914190.28568-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 13 Sep 2002 03:36:34 -0400
Message-Id: <1031902595.4433.125.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-13 at 03:19, Ingo Molnar wrote:

> of course. And your point in making it in_interrupt() had what purpose -
> hiding that tons of code breaks preemption? [and tons of code breaks on
> SMP.] Your patch was removing precisely the tool that can be used to
> improve SMP quality on UP boxes as well.

Ingo, Attached is the latest patch I sent Linus.  I never doubted the
usefulness, just the practicality of having endusers parse so much
information.

At any rate, the approach in Linus's BK is wrong because (a) the debug
is hit way too often to just BUG() and (b) we have to take into account
PREEMPT_ACTIVE.

> yes. And we also need kallsyms and kksymoops in the kernel, so that people
> can send in meaningful traces.

Agree 100% here.

	Robert Love

iff -urN linux-2.5.34/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.34/kernel/sched.c	Thu Sep 12 16:26:23 2002
+++ linux/kernel/sched.c	Thu Sep 12 16:42:59 2002
@@ -940,8 +940,10 @@
 	struct list_head *queue;
 	int idx;
 
-	if (unlikely(in_atomic()))
-		BUG();
+	if (unlikely(in_atomic() && preempt_count() != PREEMPT_ACTIVE)) {
+		printk(KERN_ERROR "schedule() called while non-atomic!\n");
+		show_stack(NULL);
+	}
 
 #if CONFIG_DEBUG_HIGHMEM
 	check_highmem_ptes();
@@ -959,7 +961,7 @@
 	 * if entering off of a kernel preemption go straight
 	 * to picking the next task.
 	 */
-	if (unlikely(preempt_count() & PREEMPT_ACTIVE))
+	if (unlikely(preempt_count() == PREEMPT_ACTIVE))
 		goto pick_next_task;
 
 	switch (prev->state) {

