Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267444AbUHJGfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267444AbUHJGfS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 02:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267446AbUHJGfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 02:35:17 -0400
Received: from holomorphy.com ([207.189.100.168]:12006 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267444AbUHJGex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 02:34:53 -0400
Date: Mon, 9 Aug 2004 23:34:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040810063445.GE11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	Nick Piggin <nickpiggin@yahoo.com.au>
References: <20040808152936.1ce2eab8.akpm@osdl.org> <20040809112550.2ea19dbf.akpm@osdl.org> <200408091132.39752.jbarnes@engr.sgi.com> <200408091217.50786.jbarnes@engr.sgi.com> <20040809195323.GU11200@holomorphy.com> <20040809204357.GX11200@holomorphy.com> <20040809211042.GY11200@holomorphy.com> <20040809224546.GZ11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040809224546.GZ11200@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 12:53:23PM -0700, William Lee Irwin III wrote:
>>>> I can reproduce here (ia64/Altix). Fixing.

On Mon, Aug 09, 2004 at 01:43:57PM -0700, William Lee Irwin III wrote:
>>> It comes up with the following applied. Now distilling into a bugfix.

On Mon, Aug 09, 2004 at 02:10:42PM -0700, William Lee Irwin III wrote:
>> The following does *NOT* come up. The difference appears to be the delay
>> from the printk()'s.

On Mon, Aug 09, 2004 at 03:45:46PM -0700, William Lee Irwin III wrote:
> Adding mdelay(1000) before and after the wakeup IPI didn't help. Must
> be something else going on in printk().

None of the printk()'s in do_boot_cpu() appear essential. The following
also boots:


--- mm2-2.6.8-rc3/arch/ia64/kernel/smpboot.c.orig	2004-08-10 13:42:38.000000000 -0700
+++ mm2-2.6.8-rc3/arch/ia64/kernel/smpboot.c	2004-08-09 23:06:44.000000000 -0700
@@ -356,65 +356,45 @@
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
+	/* printk("entered do_boot_cpu(%d, %d)\n", sapicid, cpu); */
+	/* printk("about to fork_idle(%d)\n", cpu); */
+	task_for_booting_cpu = fork_idle(cpu);
+	/* printk("survived fork_idle(%d)\n", cpu); */
+	if (IS_ERR(task_for_booting_cpu))
+		 panic("failed fork for CPU %d", cpu);
+	mb();
+	/* printk("Sending wakeup vector %lu to AP 0x%x/0x%x.\n", ap_wakeup_vector, cpu, sapicid); */
+	/* printk("about to platform_send_ipi(%u, 0x%lx, IA64_IPI_DM_INT, 0)\n", cpu, ap_wakeup_vector); */
 	platform_send_ipi(cpu, ap_wakeup_vector, IA64_IPI_DM_INT, 0);
+	/* printk("survived platform_send_ipi(%u, 0x%lx, IA64_IPI_DM_INT, 0)\n", cpu, ap_wakeup_vector); */
 
 	/*
 	 * Wait 10s total for the AP to start
 	 */
-	Dprintk("Waiting on callin_map ...");
+	/* printk("Waiting on callin_map on cpu %d for cpu %d...", smp_processor_id(), cpu); */
 	for (timeout = 0; timeout < 100000; timeout++) {
 		if (cpu_isset(cpu, cpu_callin_map))
 			break;  /* It has booted */
 		udelay(100);
 	}
-	Dprintk("\n");
+	/* printk("\n"); */
+	/* printk("finished waiting on callin_map\n"); */
 
 	if (!cpu_isset(cpu, cpu_callin_map)) {
-		printk(KERN_ERR "Processor 0x%x/0x%x is stuck.\n", cpu, sapicid);
+		/* printk("Processor 0x%x/0x%x is stuck.\n", cpu, sapicid); */
 		ia64_cpu_to_sapicid[cpu] = -1;
 		cpu_clear(cpu, cpu_online_map);  /* was set in smp_callin() */
+		/* printk("error return from do_boot_cpu(%d, %d)\n", sapicid, cpu); */
 		return -EINVAL;
-	}
+	} /* else printk("Processor %d/%d came up\n", cpu, sapicid); */
+	/* printk("normal return from do_boot_cpu(%d, %d)\n", sapicid, cpu); */
 	return 0;
 }
 
@@ -655,26 +635,40 @@
 	int ret;
 	int sapicid;
 
+	printk("entered __cpu_up(%u)\n", cpu);
 	sapicid = ia64_cpu_to_sapicid[cpu];
-	if (sapicid == -1)
+	if (sapicid == -1) {
+		printk("invalid SAPIC ID\n");
+		printk("error return from __cpu_up(%u)\n", cpu);
 		return -EINVAL;
+	}
 
 	/*
 	 * Already booted.. just enable and get outa idle lool
 	 */
 	if (cpu_isset(cpu, cpu_callin_map))
 	{
+		printk("%u already set in cpu_callin_map\n", cpu);
+		printk("about to cpu_enable(%u)\n", cpu);
 		cpu_enable(cpu);
+		printk("survived cpu_enable(%u)\n", cpu);
 		local_irq_enable();
+		printk("looping while (!cpu_isset(%u, cpu_online_map))\n", cpu);
 		while (!cpu_isset(cpu, cpu_online_map))
 			mb();
+		printk("finished looping while (!cpu_isset(%u, cpu_online_map))\n", cpu);
+		printk("successful return from __cpu_up(%u)\n", cpu);
 		return 0;
 	}
 	/* Processor goes to start_secondary(), sets online flag */
+	printk("about to call do_boot_cpu(%d, %d)\n", sapicid, cpu);
 	ret = do_boot_cpu(sapicid, cpu);
-	if (ret < 0)
+	printk("survived call to do_boot_cpu(%d, %d)\n", sapicid, cpu);
+	if (ret < 0) {
+		printk("error return from __cpu_up(%u)\n", cpu);
 		return ret;
-
+	}
+	printk("successful return from __cpu_up(%u)\n", cpu);
 	return 0;
 }
 
--- mm2-2.6.8-rc3/kernel/fork.c.orig	2004-08-10 06:02:27.000000000 -0700
+++ mm2-2.6.8-rc3/kernel/fork.c	2004-08-10 13:37:23.000000000 -0700
@@ -1190,7 +1190,7 @@
 	goto fork_out;
 }
 
-task_t * __init fork_idle(int cpu)
+task_t *fork_idle(int cpu)
 {
 	task_t *task;
 	struct pt_regs regs;
