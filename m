Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWFYOYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWFYOYh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 10:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWFYOYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 10:24:37 -0400
Received: from mail.gmx.de ([213.165.64.21]:41927 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751430AbWFYOYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 10:24:36 -0400
X-Authenticated: #5039886
Date: Sun, 25 Jun 2006 16:24:40 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: Mike Galbraith <efault@gmx.de>, danial_thom@yahoo.com,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] i386: Fix softirq accounting with 4K stacks
Message-ID: <20060625142440.GD8223@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
	danial_thom@yahoo.com, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>
References: <1151128763.7795.9.camel@Homer.TheSimpsons.net> <1151130383.7545.1.camel@Homer.TheSimpsons.net> <20060624092156.GA13142@atjola.homenet> <1151142716.7797.10.camel@Homer.TheSimpsons.net> <1151149317.7646.14.camel@Homer.TheSimpsons.net> <20060624154037.GA2946@atjola.homenet> <1151166193.8516.8.camel@Homer.TheSimpsons.net> <20060624192523.GA3231@atjola.homenet> <1151211993.8519.6.camel@Homer.TheSimpsons.net> <20060625111238.GB8223@atjola.homenet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060625111238.GB8223@atjola.homenet>
User-Agent: Mutt/1.5.11+cvs20060403
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.06.25 13:12:38 +0200, Björn Steinbrink wrote:
> On 2006.06.25 07:06:33 +0200, Mike Galbraith wrote:
> > On Sat, 2006-06-24 at 21:25 +0200, Björn Steinbrink wrote:
> > > OK, it also depends on IO APIC being enabled and active, ie. noapic on
> > > the kernel command line will fix it as well as disabling
> > > CONFIG_X86_IO_APIC. That doesn't help me at all to understand why it
> > > happens though.
> > 
> > Ditto.
> > 
> > > The only difference with IO APIC disabled seems to be that the irq
> > > doesn't get ACKed before update_process_times() gets called.
> > > And your "fix" makes it being called outside of the xtime_lock spinlock
> > > and with a slightly different stack usage AFAICT.
> > 
> > (it's still under the xtime lock)
> 
> No, with IO-APIC enabled, it's using the local APIC timer, thus
> using_apic_timer is 1 and the path right after unlocking in
> timer_interrupt() is taken towards update_process_times().
> 
> > > But none of these should make a difference, right?
> > 
> > Not that I can see, but then it's pretty dark down here.  Anybody got a
> > flashlight I can borrow? ;-)
> 
> Guess I found one, not sure if it works correctly though ;)
> 
> Using 4K stacks, we have one stack for hard irqs and one for soft irqs,
> both having their own threadinfo and thus preemptcount. Thus the call to
> softirq_count() in account_system_time() will always return 0 when
> called in hard irq context. Additionally preemptcount is always set to
> HARDIRQ_OFFSET in hard irq context, so
> hardirq_count() - hardirq_offset is 0 all the time as well.
> 
> But that doesn't fit the fact that I at least get hard irq accounting
> when booting with noapic. And it also doesn't explain why your fix
> works, fixing both, soft and hard irq accounting. Am I missing some
> code path that calls smp_local_timer_interrupt? There's
> smp_apic_timer_interrupt(), but that seems to be unused on i386.

OK, the hardirq_count() thing is not HARDIRQ_OFFSET all the time. When
we interrupt a hard irq, we are already using the hard irq stack and
thus irq_enter() in do_IRQ() works as it should. The zero value for hi
is there with IO-APIC and 8K stacks as well, so that's either right or
an other bug.

Still no idea why your "fix" works, but the following patch also fixes
the problem and is at least a little more like the RightThing.


---

Copy the softirq bits in preempt_count from the current context into the
hardirq context when using 4K stacks to make the softirq_count macro work
correctly and thereby fix softirq cpu time accounting.

Signed-off-by: Björn Steinbrink <B.Steinbrink@gmx.de>

diff -Nurp a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	2006-03-20 06:53:29.000000000 +0100
+++ b/arch/i386/kernel/irq.c	2006-06-25 15:49:52.000000000 +0200
@@ -95,6 +95,14 @@ fastcall unsigned int do_IRQ(struct pt_r
 		irqctx->tinfo.task = curctx->tinfo.task;
 		irqctx->tinfo.previous_esp = current_stack_pointer;
 
+		/*
+		 * Copy the softirq bits in preempt_count so that the
+		 * softirq checks work in the hardirq context.
+		 */
+		irqctx->tinfo.preempt_count =
+			irqctx->tinfo.preempt_count & ~SOFTIRQ_MASK |
+			curctx->tinfo.preempt_count & SOFTIRQ_MASK;
+
 		asm volatile(
 			"       xchgl   %%ebx,%%esp      \n"
 			"       call    __do_IRQ         \n"
