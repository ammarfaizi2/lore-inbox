Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268522AbUHLSRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268522AbUHLSRa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 14:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268649AbUHLSRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 14:17:30 -0400
Received: from holomorphy.com ([207.189.100.168]:31629 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268522AbUHLSRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 14:17:19 -0400
Date: Thu, 12 Aug 2004 11:17:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Marcelo Tosatti <marcelo@hera.kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.27 released
Message-ID: <20040812181712.GO11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Marcelo Tosatti <marcelo@hera.kernel.org>,
	linux-kernel@vger.kernel.org
References: <200408072328.i77NSRNi031514@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408072328.i77NSRNi031514@hera.kernel.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2004 at 04:28:27PM -0700, Marcelo Tosatti wrote:
> - 2.4.27-rc6 was released as 2.4.27 with no changes.
> Here is a list of the most important security issues fixed by this release:
> CAN-2004-0495 (Al Viro sparse fixes)
> CAN-2004-0497 (users could modify group ID of arbitrary files on the system)
> CAN-2004-0535 (e1000 minor info leak)
> CAN-2004-0685 (backported Conectiva usb sparse fixes)
> CAN-2004-0415 (file offset pointer handling race)
> CAN-2004-0565 (information leak ia64)

This patch by nature corrects two apparent bugs which are really one
bug. p->mm can become NULL while traversing the tasklist. The two
effects are first that kernel threads appear to be killed. The second
is that the OOM killing process fails to actually shoot down all threads
of the chosen process, and so fails to reclaim the memory it intended to.
oom_kill_task() consists primarily of the expansion of the 2.6 inline
function get_task_mm().

Index: linux-2.4/mm/oom_kill.c
===================================================================
--- linux-2.4.orig/mm/oom_kill.c	2004-06-23 19:30:21.000000000 -0700
+++ linux-2.4/mm/oom_kill.c	2004-06-23 19:52:25.000000000 -0700
@@ -141,7 +141,7 @@
  * CAP_SYS_RAW_IO set, send SIGTERM instead (but it's unlikely that
  * we select a process with CAP_SYS_RAW_IO set).
  */
-void oom_kill_task(struct task_struct *p)
+static void __oom_kill_task(struct task_struct *p)
 {
 	printk(KERN_ERR "Out of Memory: Killed process %d (%s).\n", p->pid, p->comm);
 
@@ -161,6 +161,26 @@
 	}
 }
 
+static struct mm_struct *oom_kill_task(struct task_struct *p)
+{
+	struct mm_struct *mm;
+
+	task_lock(p);
+	mm = p->mm;
+	if (mm) {
+		spin_lock(&mmlist_lock);
+		if (atomic_read(&mm->mm_users))
+			atomic_inc(&mm->mm_users);
+		else
+			mm = NULL;
+		spin_unlock(&mmlist_lock);
+	}
+	task_unlock(p);
+	if (mm)
+		__oom_kill_task(p);
+	return mm;
+}
+
 /**
  * oom_kill - kill the "best" process when we run out of memory
  *
@@ -172,21 +192,27 @@
 static void oom_kill(void)
 {
 	struct task_struct *p, *q;
+	struct mm_struct *mm;
 
+retry:
 	read_lock(&tasklist_lock);
 	p = select_bad_process();
 
 	/* Found nothing?!?! Either we hang forever, or we panic. */
 	if (p == NULL)
 		panic("Out of memory and no killable processes...\n");
-
+	mm = oom_kill_task(p);
+	if (!mm) {
+		read_unlock(&tasklist_lock);
+		goto retry;
+	}
 	/* kill all processes that share the ->mm (i.e. all threads) */
 	for_each_task(q) {
-		if (q->mm == p->mm)
-			oom_kill_task(q);
+		if (q->mm == mm)
+			__oom_kill_task(q);
 	}
 	read_unlock(&tasklist_lock);
-
+	mmput(mm);
 	/*
 	 * Make kswapd go out of the way, so "p" has a good chance of
 	 * killing itself before someone else gets the chance to ask
