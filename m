Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267212AbUHIVL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267212AbUHIVL2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 17:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267230AbUHIVL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 17:11:28 -0400
Received: from holomorphy.com ([207.189.100.168]:1507 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267212AbUHIVKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 17:10:54 -0400
Date: Mon, 9 Aug 2004 14:10:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040809211042.GY11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	Nick Piggin <nickpiggin@yahoo.com.au>
References: <20040808152936.1ce2eab8.akpm@osdl.org> <20040809112550.2ea19dbf.akpm@osdl.org> <200408091132.39752.jbarnes@engr.sgi.com> <200408091217.50786.jbarnes@engr.sgi.com> <20040809195323.GU11200@holomorphy.com> <20040809204357.GX11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040809204357.GX11200@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 12:17:50PM -0700, Jesse Barnes wrote:
>>> If I apply everything up to and including schedstat-v10.patch, it
>>> boots fine. So it might be sched-init_idle-fork_by_hand-consolidation.patch
>>> or something nearby...  Just reverting the sched-single-array.patch
>>> wasn't enough.

On Mon, Aug 09, 2004 at 12:53:23PM -0700, William Lee Irwin III wrote:
>> I can reproduce here (ia64/Altix). Fixing.

On Mon, Aug 09, 2004 at 01:43:57PM -0700, William Lee Irwin III wrote:
> It comes up with the following applied. Now distilling into a bugfix.

The following does *NOT* come up. The difference appears to be the delay
from the printk()'s.


-- wli

--- mm2-2.6.8-rc3/arch/ia64/kernel/smpboot.c.orig	2004-08-10 05:24:20.000000000 -0700
+++ mm2-2.6.8-rc3/arch/ia64/kernel/smpboot.c	2004-08-10 06:50:21.774710311 -0700
@@ -356,44 +356,17 @@
 	return cpu_idle();
 }
 
-struct create_idle {
-	struct task_struct *idle;
-	struct completion done;
-	int cpu;
-};
-
-void
-do_fork_idle(void *_c_idle)
-{
-	struct create_idle *c_idle = _c_idle;
-
-	c_idle->idle = fork_idle(c_idle->cpu);
-	complete(&c_idle->done);
-}
-
 static int __devinit
 do_boot_cpu (int sapicid, int cpu)
 {
 	int timeout;
-	struct create_idle c_idle = {
-		.cpu	= cpu,
-		.done	= COMPLETION_INITIALIZER(c_idle.done),
-	};
-	DECLARE_WORK(work, do_fork_idle, &c_idle);
 	/*
 	 * We can't use kernel_thread since we must avoid to reschedule the child.
 	 */
-	if (!keventd_up() || current_is_keventd())
-		work.func(work.data);
-	else {
-		schedule_work(&work);
-		wait_for_completion(&c_idle.done);
-	}
-
-	if (IS_ERR(c_idle.idle))
+	task_for_booting_cpu = fork_idle(cpu);
+	if (IS_ERR(task_for_booting_cpu))
 		panic("failed fork for CPU %d", cpu);
-	task_for_booting_cpu = c_idle.idle;
-
+	mb();
 	Dprintk("Sending wakeup vector %lu to AP 0x%x/0x%x.\n", ap_wakeup_vector, cpu, sapicid);
 
 	platform_send_ipi(cpu, ap_wakeup_vector, IA64_IPI_DM_INT, 0);
--- mm2-2.6.8-rc3/kernel/fork.c.orig	2004-08-10 06:02:27.000000000 -0700
+++ mm2-2.6.8-rc3/kernel/fork.c	2004-08-10 06:03:11.000000000 -0700
@@ -1190,7 +1190,7 @@
 	goto fork_out;
 }
 
-task_t * __init fork_idle(int cpu)
+task_t *fork_idle(int cpu)
 {
 	task_t *task;
 	struct pt_regs regs;
