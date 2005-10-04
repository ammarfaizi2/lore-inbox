Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbVJDS1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbVJDS1v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 14:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbVJDS1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 14:27:50 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:52719 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S964901AbVJDS1u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 14:27:50 -0400
Subject: Re: 2.6.14-rc3-rt2
From: Daniel Walker <dwalker@mvista.com>
To: dino@in.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>, Todd.Kneisel@bull.com,
       Felix Oxley <lkml@oxley.org>
In-Reply-To: <20051004181125.GB5072@in.ibm.com>
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com>
	 <20051004130009.GB31466@elte.hu>
	 <Pine.LNX.4.58.0510040943540.13294@localhost.localdomain>
	 <20051004142718.GA3195@elte.hu> <20051004151635.GA8866@in.ibm.com>
	 <1128442180.4252.0.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <20051004175842.GA5072@in.ibm.com>
	 <1128448471.4252.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <20051004181125.GB5072@in.ibm.com>
Content-Type: text/plain
Date: Tue, 04 Oct 2005 11:27:46 -0700
Message-Id: <1128450466.4252.15.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-04 at 23:41 +0530, Dinakar Guniguntala wrote:
> On Tue, Oct 04, 2005 at 10:54:30AM -0700, Daniel Walker wrote:
> > On Tue, 2005-10-04 at 23:28 +0530, Dinakar Guniguntala wrote:
> > 
> > > Nope doesnt help. I booted with this code change and I get the
> > > same message. 
> > > 
> > > I saw that the code change is in #ifdef CONFIG_HIGH_RES_TIMERS.
> > > I have already disabled CONFIG_HIGH_RES_TIMERS as Thomas Gleixner 
> > > suggested
> > 
> > Which code is #ifdef'd ?
> 
> Your code was in function smp_apic_timer_ipi_interrupt (right?) that
> is under CONFIG_HIGH_RES_TIMERS which was disabled.

Yeah, I see what your saying now ..

> > 
> > Is there any diversity in these messages , or is it always the same? Is
> > the CPU# ever different?
> > 
> 
> Sorry I should have put this up before.
> 
> 
> BUG: auditd:3587, possible softlockup detected on CPU#2!
>  [<c0144448>] softlockup_detected+0x39/0x46 (8)
>  [<c0144526>] softlockup_tick+0xd1/0xd3 (20)
>  [<c01112c7>] smp_apic_timer_interrupt+0xc0/0xcc (24)
>  [<c010396c>] apic_timer_interrupt+0x1c/0x24 (24)
>  [<c0102e8a>] sysenter_past_esp+0x2f/0x75 (44)

This patch should handle both cases . I would think if this doesn't
silence it, then it's something else..

Index: linux-2.6.13/arch/i386/kernel/apic.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/apic.c
+++ linux-2.6.13/arch/i386/kernel/apic.c
@@ -1153,6 +1153,14 @@ fastcall notrace void smp_apic_timer_ipi
 #if 0
 	profile_tick(CPU_PROFILING, regs);
 #endif
+	/*
+	 * If the task is currently running in user mode, don't
+	 * detect soft lockups.  If CONFIG_DETECT_SOFTLOCKUP is not
+	 * configured, this should be optimized out.
+	 */
+	if (user_mode(regs))
+		touch_light_softlockup_watchdog();
+
 	update_process_times(user_mode_vm(regs));
 	irq_exit();
 
@@ -1247,6 +1255,14 @@ inline void smp_local_timer_interrupt(st
 						per_cpu(prof_counter, cpu);
 		}
 #ifdef CONFIG_SMP
+		/*
+		 * If the task is currently running in user mode, don't
+		 * detect soft lockups.  If CONFIG_DETECT_SOFTLOCKUP is not
+		 * configured, this should be optimized out.
+		 */
+		if (user_mode(regs))
+			touch_light_softlockup_watchdog();
+
 		update_process_times(user_mode_vm(regs));
 #endif
 	}


