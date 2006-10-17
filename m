Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422946AbWJQBsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422946AbWJQBsY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 21:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422950AbWJQBsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 21:48:24 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:23748 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1422946AbWJQBsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 21:48:23 -0400
Subject: Re: [PATCH] fix i386 NMI watchdog checking
From: Steven Rostedt <rostedt@goodmis.org>
To: minyard@acm.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061013032221.GA10816@localdomain>
References: <20061013032221.GA10816@localdomain>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 21:48:13 -0400
Message-Id: <1161049693.24364.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 22:22 -0500, Corey Minyard wrote:
> I was having a problem with the NMI testing hanging on an SMP system
> in check_nmi_watchdog() when using nmi_watchdog=2.  It doesn't seem to
> happen on a stock kernel, but I was working on something else and it
> triggered this problem.
> 
> This patch solves the problem.  I'm not sure this is quite the right
> solution, but I know that the local_irq_enable() is kind of pointless
> here and it seems that having scheduling on while the other CPUs are
> locked up with interrupts off is a bad idea.  And you can't call
> smp_call_function() with interrupts off.  But adding the preempt
> disable around this operation seems to solve the problem.

The patch makes sense. And you're right about the local_irq_enable.
Either it should be matched with a local_irq_disable (knowing that this
function is called with interrupts disabled), or it isn't needed.  The
later seems to be correct.

But this also shows something that bothers me.

> 
> Signed-off-by: Corey Minyard <minyard@acm.org>
> 
> Index: linux-2.6.18/arch/i386/kernel/nmi.c
> ===================================================================
> --- linux-2.6.18.orig/arch/i386/kernel/nmi.c
> +++ linux-2.6.18/arch/i386/kernel/nmi.c
> @@ -134,12 +134,18 @@ static int __init check_nmi_watchdog(voi
>  
>  	printk(KERN_INFO "Testing NMI watchdog ... ");
>  
> +	/*
> +	 * We must have preempt off while testing the local APIC
> +	 * watchdog.  If we have an interrupt on this CPU while the
> +	 * other CPUs are wedged, and that interrupt tries to schedule
> +	 * (and possibly do an IPC), we would be hung.
> +	 */
> +	preempt_disable();
>  	if (nmi_watchdog == NMI_LOCAL_APIC)
>  		smp_call_function(nmi_cpu_busy, (void *)&endflag, 0, 0);
>  
>  	for_each_possible_cpu(cpu)
>  		prev_nmi_count[cpu] = per_cpu(irq_stat, cpu).__nmi_count;
> -	local_irq_enable();
>  	mdelay((10*1000)/nmi_hz); // wait 10 ticks
>  
>  	for_each_possible_cpu(cpu) {
> @@ -151,6 +157,7 @@ static int __init check_nmi_watchdog(voi
>  #endif
>  		if (nmi_count(cpu) - prev_nmi_count[cpu] <= 5) {
>  			endflag = 1;
> +			preempt_enable();
>  			printk("CPU#%d: NMI appears to be stuck (%d->%d)!\n",
>  				cpu,
>  				prev_nmi_count[cpu],
> @@ -162,6 +169,7 @@ static int __init check_nmi_watchdog(voi
>  		}
>  	}
>  	endflag = 1;

endflag is a local variable!!!

Yes there's a printk and a kfree after it, but say we have printk turned
off (which is a possibility) and kfree happens to be quick. At that same
time, we have the other CPU (for a two CPU system) running.  If the
other CPU takes an interrupt (which is possible since interrupts are
turned on), it can miss the endflag set to one.  That is, this function
could return and call another function that resets the location on the
stack where endflag was, to zero.

This race is very unlikely, since the system will continue with one CPU,
and eventually that location will probably be set.  I don't know if this
can cause a dead lock or not, but it just seems like bad practice to use
a local variable to share across CPUS.  Why not just convert this to a
global static?  This function is only called once.

Ah what the heck, patch below (on top of this patch).  Only compiled
tested (trivial enough).

-- Steve

> +	preempt_enable();
>  	printk("OK.\n");
>  
>  	/* now that we know it works we can reduce NMI frequency to


Description:

Don't use a local stack variable to share across CPUS, even if it most
likely wont break anything.  It's just wrong.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.18/arch/i386/kernel/nmi.c
===================================================================
--- linux-2.6.18.orig/arch/i386/kernel/nmi.c	2006-10-16 21:34:08.000000000 -0400
+++ linux-2.6.18/arch/i386/kernel/nmi.c	2006-10-16 21:45:13.000000000 -0400
@@ -119,9 +119,10 @@ static __init void nmi_cpu_busy(void *da
 }
 #endif
 
+static volatile int end_flag __initdata = 0;
+
 static int __init check_nmi_watchdog(void)
 {
-	volatile int endflag = 0;
 	unsigned int *prev_nmi_count;
 	int cpu;
 
@@ -142,7 +143,7 @@ static int __init check_nmi_watchdog(voi
 	 */
 	preempt_disable();
 	if (nmi_watchdog == NMI_LOCAL_APIC)
-		smp_call_function(nmi_cpu_busy, (void *)&endflag, 0, 0);
+		smp_call_function(nmi_cpu_busy, (void *)&end_flag, 0, 0);
 
 	for_each_possible_cpu(cpu)
 		prev_nmi_count[cpu] = per_cpu(irq_stat, cpu).__nmi_count;
@@ -156,7 +157,7 @@ static int __init check_nmi_watchdog(voi
 			continue;
 #endif
 		if (nmi_count(cpu) - prev_nmi_count[cpu] <= 5) {
-			endflag = 1;
+			end_flag = 1;
 			preempt_enable();
 			printk("CPU#%d: NMI appears to be stuck (%d->%d)!\n",
 				cpu,
@@ -168,7 +169,7 @@ static int __init check_nmi_watchdog(voi
 			return -1;
 		}
 	}
-	endflag = 1;
+	end_flag = 1;
 	preempt_enable();
 	printk("OK.\n");
 


