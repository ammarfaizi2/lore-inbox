Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274828AbTGaRXx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 13:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270437AbTGaRXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 13:23:53 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:53428 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S274828AbTGaRXt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 13:23:49 -0400
Date: Thu, 31 Jul 2003 12:23:34 -0500
From: linas@austin.ibm.com
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, olof@austin.ibm.com
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
Message-ID: <20030731122334.A22900@forte.austin.ibm.com>
References: <20030730082848.GC23835@dualathlon.random> <Pine.LNX.4.44.0307301223450.13299-100000@localhost.localdomain> <20030730184317.B23750@forte.austin.ibm.com> <20030730235607.GC322@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030730235607.GC322@dualathlon.random>; from andrea@suse.de on Thu, Jul 31, 2003 at 01:56:07AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 01:56:07AM +0200, Andrea Arcangeli wrote:
> On Wed, Jul 30, 2003 at 06:43:18PM -0500, linas@austin.ibm.com wrote:
> > On Thu, Jul 31, 2003 at 12:17:17AM +0200, Andrea Arcangeli wrote:
> > > So the best fix would be to nuke the run_all_timers thing from 2.4 too.
> > Yes.
[...]
> > And so either of Andrea's fixes should fix this race.
> 
> exactly. If you want to nuke the run_all_timers from the 2.4 backport
> feel free, then we could drop the additional locking from
> add_timer/del_timer* and leave it only in mod_timer like 2.6 does, that
> will avoid cacheline bouncing in the small window when the local timer
> irq run on top of an irq handler. In the meantime the kernel is already
> solid (again ;).

OK, I looked at removing run_all_timers, it doesn't seem too hard. 

I would need to: 
-- add TIMER_SOFTIRQ to interrupts.h,
-- add open_softirq (run_timer_softirq) to timer.c init_timer()
-- move guts of run_local_timers() to run_timer_softirq()
-- remove bh locks in above, not yet sure about other locks
-- remove TIMER_BH everywhere.  Or rather, remove it for those
   arches that support cpu-local timer interupts (curently x86 & freinds, 
   soon hopefully ppc64, I attach it below, in case other arches want to 
   play with this).

Is that right?
Should I do this patch or will people loose interest in it?
Who should I send it to?  Who wants to review it?

> BTW, it's reassuring it wasn't lack of 2.6 stress testing, I apologize
> for claiming that.

Me too, sorry for making noise before figuring it all out. But then, 
I remember asking a college physics professor for a recommendation, 
and he didn't know me well.  "You sat in the back of the class and
didn't ask any questions, unlike so-n-so, (the #1 student in the class) 
who sat in front and asked a lot of questions."  I told him that that was 
because I knew the answers to all of the questions that were being asked.
(I  was trying to distance myself from the stupid people up front).
He wasn't impressed by my reply, I hurt pretty bad.

--------------------------------------------------------------------
Re the per-cpu, local timer patch, unless I'm badly mistaken, its pretty 
trivial, right:?

Index: kernel/timer.c
===================================================================
RCS file: /home/linas/cvsroot/linux24/kernel/timer.c,v
retrieving revision 1.1.1.1.4.1
diff -u -p -u -r1.1.1.1.4.1 timer.c
--- kernel/timer.c   15 Jul 2003 18:43:52 -0000 1.1.1.1.4.1
+++ kernel/timer.c   31 Jul 2003 15:30:26 -0000
@@ -764,7 +764,7 @@ void do_timer(struct pt_regs *regs)
   /* SMP process accounting uses the local APIC timer */
                                                                                
   update_process_times(user_mode(regs));
-#if defined(CONFIG_X86) || defined(CONFIG_IA64) /* x86-64 is also included by CONFIG_X86 */
+#if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(CONFIG_PPC64) /* x86-64 is also included by CONFIG_X86 */
   mark_bh(TIMER_BH);
 #endif
 #endif
@@ -772,7 +772,7 @@ void do_timer(struct pt_regs *regs)
    * Right now only x86-SMP calls run_local_timers() from a
    * per-CPU interrupt.
    */
-#if !defined(CONFIG_X86) && !defined(CONFIG_IA64) /* x86-64 is also included by CONFIG_X86 */
+#if !defined(CONFIG_X86) && !defined(CONFIG_IA64) && !defined(CONFIG_PPC64) /*
x86-64 is also included by CONFIG_X86 */
   mark_bh(TIMER_BH);
 #endif
   update_times();
Index: arch/ppc64/kernel/smp.c
===================================================================
RCS file: /home/linas/cvsroot/linux24/arch/ppc64/kernel/smp.c,v
retrieving revision 1.2.4.1
diff -u -p -u -r1.2.4.1 smp.c
--- arch/ppc64/kernel/smp.c   15 Jul 2003 18:41:56 -0000 1.2.4.1
+++ arch/ppc64/kernel/smp.c   31 Jul 2003 15:21:35 -0000
@@ -398,6 +398,8 @@ void smp_local_timer_interrupt(struct pt
      update_process_times(user_mode(regs));
      (get_paca()->prof_counter)=get_paca()->prof_multiplier;
   }
+
+  run_local_timers();
 }
                                                                                
 void smp_message_recv(int msg, struct pt_regs *regs)


