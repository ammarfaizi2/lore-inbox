Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269236AbUINJeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269236AbUINJeg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 05:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269238AbUINJef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 05:34:35 -0400
Received: from holomorphy.com ([207.189.100.168]:29842 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269236AbUINJe2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 05:34:28 -0400
Date: Tue, 14 Sep 2004 02:34:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [printk] make console_conditional_schedule() __sched and use cond_resched()
Message-ID: <20040914093415.GN9106@holomorphy.com>
References: <20040914091529.GA21553@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914091529.GA21553@elte.hu>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 11:15:29AM +0200, Ingo Molnar wrote:
> the attached patch is ontop of preempt-smp.patch. This is another
> generic fallout from the voluntary-preempt patchset: a cleanup of the
> cond_resched() infrastructure, in preparation of the latency reduction
> patches. The changes:

Relatively minor add-on (not necessarily tied to it or required to be
taken or a fix for any bug). Since cond_resched() is using
PREEMPT_ACTIVE now, it may be useful to update the open-coded instance
of cond_resched() to use the generic call. Also, it should probably be
__sched so the caller shows up in wchan.


-- wli

Index: mm5-2.6.9-rc1/kernel/printk.c
===================================================================
--- mm5-2.6.9-rc1.orig/kernel/printk.c	2004-08-24 01:13:48.000000000 -0700
+++ mm5-2.6.9-rc1/kernel/printk.c	2004-09-14 02:23:41.222204160 -0700
@@ -658,12 +658,10 @@
  *
  * Must be called within acquire_console_sem().
  */
-void console_conditional_schedule(void)
+void __sched console_conditional_schedule(void)
 {
-	if (console_may_schedule && need_resched()) {
-		set_current_state(TASK_RUNNING);
-		schedule();
-	}
+	if (console_may_schedule)
+		cond_resched();
 }
 EXPORT_SYMBOL(console_conditional_schedule);
 
