Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263709AbUD0D02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbUD0D02 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 23:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUD0D02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 23:26:28 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:16118 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S263709AbUD0D0W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 23:26:22 -0400
Subject: Re: kernel/softirq.c issues under 2.6.5
From: Rusty Russell <rusty@rustcorp.com.au>
To: Zoltan Boszormenyi <zboszor@freemail.hu>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <408A48BB.9040804@freemail.hu>
References: <408A48BB.9040804@freemail.hu>
Content-Type: text/plain
Message-Id: <1083036355.2150.10.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 27 Apr 2004 13:25:56 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-04-24 at 21:00, Zoltan Boszormenyi wrote:
> Hi,
> 
> > On Tue, 2004-04-20 at 17:58, Aivils wrote:
> >> Hi all!
> >> 
> >> 	My 2.6.5 will not start until i applay patch bellow:
...
> This changes caused that the linuxconsole.sf.net patch against
> newer kernels (>2.6.3) did not boot. The .config is
> from 2.6.6-rc2-mm1 + changes from linuxconsole.sf.net patch.
> Do you want the whole patch to investigate?

No, but the bug is probably that patch submitting a softirq before it's
initialized.  This patch should find it: look for the backtrace.

Name: Debug Too-Early Use of softirqs
Status: Untested

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31025-linux-2.6.6-rc2-bk4/kernel/softirq.c .31025-linux-2.6.6-rc2-bk4.updated/kernel/softirq.c
--- .31025-linux-2.6.6-rc2-bk4/kernel/softirq.c	2004-04-22 08:04:01.000000000 +1000
+++ .31025-linux-2.6.6-rc2-bk4.updated/kernel/softirq.c	2004-04-27 13:21:57.000000000 +1000
@@ -190,14 +190,18 @@ struct tasklet_head
 
 /* Some compilers disobey section attribute on statics when not
    initialized -- RR */
-static DEFINE_PER_CPU(struct tasklet_head, tasklet_vec) = { NULL };
-static DEFINE_PER_CPU(struct tasklet_head, tasklet_hi_vec) = { NULL };
+static DEFINE_PER_CPU(struct tasklet_head, tasklet_vec) = { (void *)1 };
+static DEFINE_PER_CPU(struct tasklet_head, tasklet_hi_vec) = { (void *)1 };
 
 void fastcall __tasklet_schedule(struct tasklet_struct *t)
 {
 	unsigned long flags;
 
 	local_irq_save(flags);
+	if (__get_cpu_var(tasklet_vec).list == (void *)1) {
+		WARN_ON(1);
+		__get_cpu_var(tasklet_vec).list = NULL;
+	}
 	t->next = __get_cpu_var(tasklet_vec).list;
 	__get_cpu_var(tasklet_vec).list = t;
 	raise_softirq_irqoff(TASKLET_SOFTIRQ);
@@ -211,6 +215,10 @@ void fastcall __tasklet_hi_schedule(stru
 	unsigned long flags;
 
 	local_irq_save(flags);
+	if (__get_cpu_var(tasklet_hi_vec).list == (void *)1) {
+		WARN_ON(1);
+		__get_cpu_var(tasklet_hi_vec).list = NULL;
+	}
 	t->next = __get_cpu_var(tasklet_hi_vec).list;
 	__get_cpu_var(tasklet_hi_vec).list = t;
 	raise_softirq_irqoff(HI_SOFTIRQ);
@@ -423,8 +431,8 @@ static int __devinit cpu_callback(struct
 
 	switch (action) {
 	case CPU_UP_PREPARE:
-		BUG_ON(per_cpu(tasklet_vec, hotcpu).list);
-		BUG_ON(per_cpu(tasklet_hi_vec, hotcpu).list);
+		per_cpu(tasklet_vec, hotcpu).list = NULL;
+		per_cpu(tasklet_hi_vec, hotcpu).list = NULL;
 		p = kthread_create(ksoftirqd, hcpu, "ksoftirqd/%d", hotcpu);
 		if (IS_ERR(p)) {
 			printk("ksoftirqd for %i failed\n", hotcpu);

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

