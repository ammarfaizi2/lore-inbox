Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbVAOHf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVAOHf4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 02:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbVAOHf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 02:35:56 -0500
Received: from ozlabs.org ([203.10.76.45]:10887 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262218AbVAOHfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 02:35:39 -0500
Subject: Re: [PATCH] i386/x86-64: Fix timer SMP bootup race
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, manpreet@fabric7.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
In-Reply-To: <20050115052311.GC22863@wotan.suse.de>
References: <20050115040951.GC13525@wotan.suse.de>
	 <1105765760.12263.12.camel@localhost.localdomain>
	 <20050115052311.GC22863@wotan.suse.de>
Content-Type: text/plain
Date: Sat, 15 Jan 2005 18:34:54 +1100
Message-Id: <1105774495.12263.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-15 at 06:23 +0100, Andi Kleen wrote:
> I shortly considered redoing the boot process, but then it looked 
> too risky to me. 
> 
> e.g. I guess on x86-64 it wouldn't be that difficult, just a bit of work,
> but on i386 with all the weird hardware it could be quite destabilizing.
> But doing it on x86-64 only is not a good solution.

Well, architectures which support CPU hotplug have had to fix their boot
process anyway, and most are fairly trivial.

> > The cause of this bug is that (1) i386 and x86_64 actually bring the
> > secondary CPUs up at boot before the core code officially brings them up
> > using cpu_up(), after the appropriate callbacks, and (2) they call into
> > core code tp process timer interrupts before they've been officially
> > brought up.
> > 
> > The former is because I just added a shim rather than rewriting the x86
> > boot process, because it would have broken too much.  The fix is do the
> > boot process properly, or to suppress the call to do_timer before the
> > CPU is actually "up".
> 
> I don't see a better short term solution.

Ick, see patch.

> If you had done it properly in 2.5 it would be working and tested
> by now ;-) , but doing it in the middle of 2.6 would seem a bit misplaced
> to me.

Linus would not have taken the patch, because it would have broken too
much.  Cleaning up the x86 boot sequence is a project in itself, which
needs to be done, but not by me 8)

Rusty.

Name: Fix x86 calling timers before CPU is supposed to be up
Status: Untested
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

>From Andi Kleen:
	The per CPU timers would only get initialized after an secondary
	CPU was running. But during initialization the secondary CPU would
	already enable interrupts to compute the jiffies. When a per 
	CPU timer fired in this window it would run into a BUG in timer.c
	because the timer heap for that CPU wasn't fully initialized.

	The race only happens when a CPU takes a long time to boot
	(e.g. very slow console output with debugging enabled).

The reason is that the x86 boot code actually bring up all CPUs
immediately, then simply unleashes them when the core code calls
__cpu_up().  Unfortunately, they enable interrupts to call
calibrate_delay(): if they get a timer interrupt during that, they
call into the core timer code which isn't set up for it yet.

Index: linux-2.6.11-rc1-bk2-Misc/include/asm-i386/mach-voyager/do_timer.h
===================================================================
--- linux-2.6.11-rc1-bk2-Misc.orig/include/asm-i386/mach-voyager/do_timer.h	2004-12-28 12:30:58.000000000 +1100
+++ linux-2.6.11-rc1-bk2-Misc/include/asm-i386/mach-voyager/do_timer.h	2005-01-15 18:29:23.889700456 +1100
@@ -3,7 +3,11 @@
 
 static inline void do_timer_interrupt_hook(struct pt_regs *regs)
 {
-	do_timer(regs);
+	/* i386 brings up CPU before core is setup. */
+	if (unlikely(!cpu_online(smp_processor_id())))
+		jiffies64++;
+	else
+		do_timer(regs);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
Index: linux-2.6.11-rc1-bk2-Misc/include/asm-i386/mach-default/do_timer.h
===================================================================
--- linux-2.6.11-rc1-bk2-Misc.orig/include/asm-i386/mach-default/do_timer.h	2004-12-28 12:30:58.000000000 +1100
+++ linux-2.6.11-rc1-bk2-Misc/include/asm-i386/mach-default/do_timer.h	2005-01-15 18:28:15.021170064 +1100
@@ -15,7 +15,11 @@
 
 static inline void do_timer_interrupt_hook(struct pt_regs *regs)
 {
-	do_timer(regs);
+	/* i386 brings up CPU before core is setup. */
+	if (unlikely(!cpu_online(smp_processor_id())))
+		jiffies64++;
+	else
+		do_timer(regs);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
Index: linux-2.6.11-rc1-bk2-Misc/include/asm-i386/mach-visws/do_timer.h
===================================================================
--- linux-2.6.11-rc1-bk2-Misc.orig/include/asm-i386/mach-visws/do_timer.h	2004-12-28 12:30:58.000000000 +1100
+++ linux-2.6.11-rc1-bk2-Misc/include/asm-i386/mach-visws/do_timer.h	2005-01-15 18:29:02.851898688 +1100
@@ -8,7 +8,11 @@
 	/* Clear the interrupt */
 	co_cpu_write(CO_CPU_STAT,co_cpu_read(CO_CPU_STAT) & ~CO_STAT_TIMEINTR);
 
-	do_timer(regs);
+	/* i386 brings up CPU before core is setup. */
+	if (unlikely(!cpu_online(smp_processor_id())))
+		jiffies64++;
+	else
+		do_timer(regs);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif

-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

