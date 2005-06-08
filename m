Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVFHUgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVFHUgk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 16:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVFHUgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 16:36:40 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:63740 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261598AbVFHUdo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 16:33:44 -0400
Subject: Re: [PATCH] local_irq_disable removal
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, sdietrich@mvista.com
In-Reply-To: <20050608112119.GA28703@elte.hu>
References: <1118214519.4759.17.camel@dhcp153.mvista.com>
	 <20050608112119.GA28703@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Date: Wed, 08 Jun 2005 13:33:38 -0700
Message-Id: <1118262818.30686.8.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Great.

On Wed, 2005-06-08 at 13:21 +0200, Ingo Molnar wrote:
>
> i've attached below the delta relative to your patch. The changes are:
> 
>  - fixed a soft-local_irq_restore() bug: it didnt re-disable the IRQ 
>    flag if the flags passed in had it set.
> 
>  - fixed SMP support - both the scheduler and the lowlevel SMP code was 
>    not fully converted to the soft flag assumptions. The PREEMPT_RT 
>    kernel now boots fine on a 2-way/4-way x86 box.
> 
>  - fixed the APIC code
> 
>  - fixed irq-latency tracing and other tracing assumptions
> 
>  - fixed DEBUG_RT_DEADLOCK_DETECT - we checked for the wrong irq flags
> 
>  - added debug code to find IRQ flag mismatches: mixing the CPU and soft 
>    flags is lethal, but detectable.
> 
>  - simplified the code which should thus also be faster: introduced the
>    mask_preempt_count/unmask_preempt_count primitives and made the 
>    soft-flag code use it.
> 
>  - cleaned up the interdependencies of the soft-flag functions - they 
>    now dont call each other anymore, they all use inlined code for 
>    maximum performance.

Should be macro's one day ...

>  - made the soft IRQ flag an unconditional feature of PREEMPT_RT: once 
>    it works properly there's no reason to ever disable it under 
>    PREEMPT_RT.
>
>  - renamed hard_ to raw_, to bring it in line with other constructs in 
>    PREEMPT_RT.
> 
>  - cleaned up the system.h impact by creating linux/rt_irq.h. Made the 
>    naming consistent all across.
> 
>  - cleaned up the preempt.h impact and updated the comments.
> 
>  - fixed smp_processor_id() debugging: we have to check for the CPU irq 
>    flag too.
> 


Excellent .. I have one fix related to preempt_schedule_irq() below.
There needs to be an ifdef , cause when PREEPMT_RT is off you would end
up with interrupts enabled when exiting preempt_schedule_irq() ..


Index: linux-2.6.11/kernel/sched.c
===================================================================
--- linux-2.6.11.orig/kernel/sched.c	2005-06-08 20:25:00.000000000 +0000
+++ linux-2.6.11/kernel/sched.c	2005-06-08 20:24:37.000000000 +0000
@@ -3245,7 +3245,9 @@ need_resched:
 	__schedule();
 
 	raw_local_irq_disable();
+#ifdef CONFIG_PREEMPT_RT
 	local_irq_enable_noresched();
+#endif
 
 #ifdef CONFIG_PREEMPT_BKL
 	task->lock_depth = saved_lock_depth;



