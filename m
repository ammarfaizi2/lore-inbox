Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUHJICc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUHJICc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 04:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUHJICc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:02:32 -0400
Received: from holomorphy.com ([207.189.100.168]:47846 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261234AbUHJICL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:02:11 -0400
Date: Tue, 10 Aug 2004 01:02:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040810080206.GF11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	Nick Piggin <nickpiggin@yahoo.com.au>
References: <20040808152936.1ce2eab8.akpm@osdl.org> <20040809112550.2ea19dbf.akpm@osdl.org> <200408091132.39752.jbarnes@engr.sgi.com> <200408091217.50786.jbarnes@engr.sgi.com> <20040809195323.GU11200@holomorphy.com> <20040809204357.GX11200@holomorphy.com> <20040809211042.GY11200@holomorphy.com> <20040809224546.GZ11200@holomorphy.com> <20040810063445.GE11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810063445.GE11200@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 03:45:46PM -0700, William Lee Irwin III wrote:
>> Adding mdelay(1000) before and after the wakeup IPI didn't help. Must
>> be something else going on in printk().

On Mon, Aug 09, 2004 at 11:34:45PM -0700, William Lee Irwin III wrote:
> None of the printk()'s in do_boot_cpu() appear essential. The following
> also boots:

Okay, it's down to one printk() and other smaller changes now. The mb()
and __init removal are both unnecessary too.


-- wli

--- mm2-2.6.8-rc3/arch/ia64/kernel/smpboot.c.orig	2004-08-10 13:42:38.000000000 -0700
+++ mm2-2.6.8-rc3/arch/ia64/kernel/smpboot.c	2004-08-10 00:46:29.628376419 -0700
@@ -356,46 +356,16 @@
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
-		panic("failed fork for CPU %d", cpu);
-	task_for_booting_cpu = c_idle.idle;
-
-	Dprintk("Sending wakeup vector %lu to AP 0x%x/0x%x.\n", ap_wakeup_vector, cpu, sapicid);
-
+	task_for_booting_cpu = fork_idle(cpu);
+	if (IS_ERR(task_for_booting_cpu))
+		 panic("failed fork for CPU %d", cpu);
 	platform_send_ipi(cpu, ap_wakeup_vector, IA64_IPI_DM_INT, 0);
 
 	/*
@@ -671,6 +641,7 @@
 		return 0;
 	}
 	/* Processor goes to start_secondary(), sets online flag */
+	printk("about to call do_boot_cpu(%d, %d)\n", sapicid, cpu);
 	ret = do_boot_cpu(sapicid, cpu);
 	if (ret < 0)
 		return ret;
