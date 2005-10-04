Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbVJDQJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbVJDQJo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 12:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbVJDQJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 12:09:44 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:49661 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S964844AbVJDQJn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 12:09:43 -0400
Subject: Re: 2.6.14-rc3-rt2
From: Daniel Walker <dwalker@mvista.com>
To: dino@in.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>, Todd.Kneisel@bull.com,
       Felix Oxley <lkml@oxley.org>
In-Reply-To: <20051004151635.GA8866@in.ibm.com>
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com>
	 <20051004130009.GB31466@elte.hu>
	 <Pine.LNX.4.58.0510040943540.13294@localhost.localdomain>
	 <20051004142718.GA3195@elte.hu>  <20051004151635.GA8866@in.ibm.com>
Content-Type: text/plain
Date: Tue, 04 Oct 2005 09:09:40 -0700
Message-Id: <1128442180.4252.0.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-04 at 20:46 +0530, Dinakar Guniguntala wrote:
> On Tue, Oct 04, 2005 at 04:27:18PM +0200, Ingo Molnar wrote:
> > 
> > > Hmm Ingo,
> > > 
> > > Looks like -rt6 got rid of all the _nort defines, but it's still used 
> > > throughout the kernel.
> > 
> > yeah, -rt7 should fix this.
> > 
> 
> 
> I get a lot of these with -rt7 (One every minute)
> 
> BUG: auditd:3596, possible softlockup detected on CPU#3!
>  [<c0144c48>] softlockup_detected+0x39/0x46 (8)
>  [<c0144d26>] softlockup_tick+0xd1/0xd3 (20)
>  [<c0111252>] smp_apic_timer_ipi_interrupt+0x4d/0x56 (24)
>  [<c010396c>] apic_timer_ipi_interrupt+0x1c/0x24 (12)
>  [<c0102e7f>] sysenter_past_esp+0x24/0x75 (44)


Woops, forgot to CC LKML .. 

Index: linux-2.6.13/arch/i386/kernel/apic.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/apic.c
+++ linux-2.6.13/arch/i386/kernel/apic.c
@@ -1153,6 +1153,16 @@ fastcall notrace void smp_apic_timer_ipi
 #if 0
 	profile_tick(CPU_PROFILING, regs);
 #endif
+
+        /*
+         * If the task is currently running in user mode, don't
+         * detect soft lockups.  If CONFIG_DETECT_SOFTLOCKUP is not
+         * configured, this should be optimized out.
+         */
+        if (user_mode(regs))
+                touch_light_softlockup_watchdog();
+
+
 	update_process_times(user_mode_vm(regs));
 	irq_exit();
 


