Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270576AbTGaXMI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 19:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274867AbTGaXMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 19:12:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:7654 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270576AbTGaXLz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 19:11:55 -0400
Date: Thu, 31 Jul 2003 15:59:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christian Vogel <vogel@skunk.physik.uni-erlangen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.0-test2: Never using pm_idle (CPU wasting power)
Message-Id: <20030731155948.1826b9c7.akpm@osdl.org>
In-Reply-To: <20030731150722.A5938@skunk.physik.uni-erlangen.de>
References: <20030731150722.A5938@skunk.physik.uni-erlangen.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Vogel <vogel@skunk.physik.uni-erlangen.de> wrote:
>
> Hi,
> 
> on a Thinkpad 600X I noticed the CPU getting very hot. It turned
> out that pm_idle was never called (which invokes the ACPI pm_idle
> call in this case) and default_idle was used instead.
> 
> 	/* arch/i386/kernel/process.c, line 723 */
> 	void cpu_idle (void)
> 	{
> 		/* endless idle loop with no priority at all */
> 		while (1) {
> 			void (*idle)(void) = pm_idle;
> 			if (!idle)
> 				idle = default_idle; /* once on bootup */
> 			irq_stat[smp_processor_id()].idle_timestamp = jiffies;
> 			while (!need_resched())
> 				idle();
> 			schedule();  /* never reached */
> 		}
> 	}
> 
> The schedule() is never reached (need_resched() is never 0) and
> so the idle-variable is not updated. pm_idle is NULL on the
> first call to cpu_idle on this thinkpad, and so I stay idling
> in the default_idle()-function.
> 
> By moving the "void *idle = pm_idle; if(!idle)..." in the inner
> while()-loop the notebook calls pm_idle (as it get's updated by ACPI)
> and stays cool.

Yes, I assume that need_resched() is always false because kernel preemption
cuts in first.  Can you please confirm that you're using CONFIG_PREEMPT,
and that the problem goes away if CONFIG_PREEMPT is disabled?

The problem which you identify will also invalidate the idle_timestamp
instrumentation so I think we should move that inside as well.


diff -puN arch/i386/kernel/process.c~acpi-idle-fix arch/i386/kernel/process.c
--- 25/arch/i386/kernel/process.c~acpi-idle-fix	Thu Jul 31 15:51:16 2003
+++ 25-akpm/arch/i386/kernel/process.c	Thu Jul 31 15:57:27 2003
@@ -139,12 +139,15 @@ void cpu_idle (void)
 {
 	/* endless idle loop with no priority at all */
 	while (1) {
-		void (*idle)(void) = pm_idle;
-		if (!idle)
-			idle = default_idle;
-		irq_stat[smp_processor_id()].idle_timestamp = jiffies;
-		while (!need_resched())
+		while (!need_resched()) {
+			void (*idle)(void) = pm_idle;
+
+			if (!idle)
+				idle = default_idle;
+
+			irq_stat[smp_processor_id()].idle_timestamp = jiffies;
 			idle();
+		}
 		schedule();
 	}
 }

_


