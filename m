Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWF1SYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWF1SYy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 14:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWF1SYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 14:24:54 -0400
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:31641 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP
	id S1750826AbWF1SYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 14:24:53 -0400
Date: Wed, 28 Jun 2006 23:51:37 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>
Subject: [PATCH] 2.6.17-rt1 : fix x86_64 oops
Message-ID: <20060628182137.GA23979@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060627200105.GA13966@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627200105.GA13966@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 01:31:05AM +0530, Dipankar Sarma wrote:
> I used the attached patch below to work around the already known
> compilation problem and a bunch of warnings in slab.c. In my
> 4-way x86_64 box, I get a few oops and then the machine panics.
> 
> Starting udevd
> Creating devices
> BUG: scheduling while atomic: udevd/0x00000001/1875
> BUG: scheduling while atomic: swapper/0x00000001/0
> 
> Call Trace:
>        <ffffffff804fcd76>{__schedule+158}
>        <ffffffff804ffcdf>{_raw_spin_unlock_irqrestore+48}
>        <ffffffff8024998b>{task_blocks_on_rt_mutex+518}
>        <ffffffff80502986>{kprobe_flush_task+21}

Turns out that kprobe_flush_task() is called from finish_task_switch()
with preemption disabled and it uses a converted spin lock. The following
patch fixed the problem for me and I was able to boot my x86_64 box.

Thanks
Dipankar


kprobe_flush_task() is called from finish_task_switch() with
preemption disabled. This requires kretprobe_lock to be a
raw spinlock. Without this, I get a lot of scheduling while
atomic oopses and then an eventual panic in my x86_64 box.
Tested by booting my x86_64 box.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
---



diff -puN kernel/kprobes.c~fix-kprobe-atomic-sched kernel/kprobes.c
--- linux-2.6.17-rt1-rcu/kernel/kprobes.c~fix-kprobe-atomic-sched	2006-06-28 23:23:06.000000000 +0530
+++ linux-2.6.17-rt1-rcu-dipankar/kernel/kprobes.c	2006-06-28 23:24:43.000000000 +0530
@@ -49,7 +49,11 @@ static struct hlist_head kprobe_table[KP
 static struct hlist_head kretprobe_inst_table[KPROBE_TABLE_SIZE];
 
 DEFINE_MUTEX(kprobe_mutex);		/* Protects kprobe_table */
-DEFINE_SPINLOCK(kretprobe_lock);	/* Protects kretprobe_inst_table */
+/*
+ * It is acquired from finish_task_switch() with preemption disbaled.
+ * Needs to be raw.
+ */
+DEFINE_RAW_SPINLOCK(kretprobe_lock);	/* Protects kretprobe_inst_table */
 static DEFINE_PER_CPU(struct kprobe *, kprobe_instance) = NULL;
 
 #ifdef __ARCH_WANT_KPROBES_INSN_SLOT
diff -puN include/linux/kprobes.h~fix-kprobe-atomic-sched include/linux/kprobes.h
--- linux-2.6.17-rt1-rcu/include/linux/kprobes.h~fix-kprobe-atomic-sched	2006-06-28 23:30:55.000000000 +0530
+++ linux-2.6.17-rt1-rcu-dipankar/include/linux/kprobes.h	2006-06-28 23:32:20.000000000 +0530
@@ -152,7 +152,7 @@ struct kretprobe_instance {
 	struct task_struct *task;
 };
 
-extern spinlock_t kretprobe_lock;
+extern raw_spinlock_t kretprobe_lock;
 extern struct mutex kprobe_mutex;
 extern int arch_prepare_kprobe(struct kprobe *p);
 extern void arch_arm_kprobe(struct kprobe *p);

_
