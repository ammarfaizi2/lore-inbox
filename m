Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753357AbWKOC0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357AbWKOC0M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 21:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753167AbWKOC0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 21:26:11 -0500
Received: from mga05.intel.com ([192.55.52.89]:20334 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1752771AbWKOC0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 21:26:09 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,422,1157353200"; 
   d="scan'208"; a="15943794:sNHT23860746"
Subject: Re: [patch] ia64: use generic_handle_irq()
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <m14pt1lx4j.fsf@ebiederm.dsl.xmission.com>
References: <1163495289.4311.68.camel@ymzhang-perf.sh.intel.com>
	 <20061114020517.2222dd08.akpm@osdl.org> <20061114124638.GA12848@elte.hu>
	 <m14pt1lx4j.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Message-Id: <1163557596.4311.76.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 15 Nov 2006 10:26:36 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-15 at 02:08, Eric W. Biederman wrote:
> Ingo Molnar <mingo@elte.hu> writes:
> 
> > * Andrew Morton <akpm@osdl.org> wrote:
> >
> >> On Tue, 14 Nov 2006 17:08:10 +0800
> >> "Zhang, Yanmin" <yanmin_zhang@linux.intel.com> wrote:
> >> 
> >> > I got an oops when booting 2.6.19-rc5-mm1 on my ia64 machine.
> >> > 
> >> > 
> >> > The root cause is that some irq_chip variables, especially ia64_msi_chip,
> >> > initiate their memeber end to point to NULL. __do_IRQ doesn't check
> >> > if irq_chip->end is null and just calls it after processing the interrupt.
> >> > 
> >> > As irq_chip->end is called at many places, so I fix it by reinitiating
> >> > irq_chip->end to dummy_irq_chip.end, e.g., a noop function.
> >> > 
> >> > Below patch against 2.6.19-rc5-mm1 fixes it.
> >> > 
> >> > Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>
> >> > 
> >> > ---
> >> > 
> >> > --- linux-2.6.19-rc5-mm1/kernel/irq/chip.c 2006-11-14 14:16:16.000000000
> > +0800
> >> > +++ linux-2.6.19-rc5-mm1_fix/kernel/irq/chip.c 2006-11-14 14:14:25.000000000
> > +0800
> >> > @@ -233,6 +233,8 @@ void irq_chip_set_defaults(struct irq_ch
> >> >  		chip->shutdown = chip->disable;
> >> >  	if (!chip->name)
> >> >  		chip->name = chip->typename;
> >> > +	if (!chip->end)
> >> > +		chip->end = dummy_irq_chip.end;
> >> >  }
> >> >  
> >> 
> >> The same bug should be hitting in mainline, shouldn't it?
> >
> > correct.
> >
> > this bug comes from a 'mixed' IRQ setup on ia64: half of it is still 
> > old-style, half of it (the MSI stuff) is new-style irqchip code. But the 
> > ia64 lowlevel code unconditionally calls __do_IRQ(), which is a bug.
> 
> Now that we hare half converted yes it is a bug.
> 
> > the genirq code has all the right helpers for such a mixed situation: so 
> > a better fix might be the one below: use generic_handle_irq() instead of 
> > unconditionally calling into __do_IRQ(). But i have not tested it - 
> > Yanmin, can you confirm this too fixes your bug?
> >
> > similarly, any architecture that makes use of the new generic MSI 
> > infrastructure should not be calling __do_IRQ() directly. (but i'm not 
> > aware of any other besides ia64 - i386 and x86_64 is now fully irq-chip 
> > converted.)
> >
> > Eric, do you agree?
> >
> 
> This is true in practice.  It isn't necessarily true, as all of irq_chip
> structures are arch specific.  It would be silly to start using msi interrupts
> without converting to genirq though.  So I think this covers it for ia64.
> 
> Your patch only fixes 2 spots and there is a third in irq_ia64.c that
> needs to be fixed as well.  At least in linus's tree.
Based on Eric's comments, I added a new change into Ingo's patch, and tested
on my ia64 machine. It does fix the bug and works well. I still think
my original patch to initilate null end to dummy_irq_chip.end is useful, at
least to prevent potential errors.

---

--- linux-2.6.19-rc5-mm1/arch/ia64/kernel/irq.c	2006-11-14 14:16:12.000000000 +0800
+++ linux-2.6.19-rc5-mm1_fix/arch/ia64/kernel/irq.c	2006-11-15 09:56:01.000000000 +0800
@@ -197,7 +197,7 @@ void fixup_irqs(void)
 			struct pt_regs *old_regs = set_irq_regs(NULL);
 
 			vectors_in_migration[irq]=0;
-			__do_IRQ(irq);
+			generic_handle_irq(irq);
 			set_irq_regs(old_regs);
 		}
 	}
--- linux-2.6.19-rc5-mm1/arch/ia64/kernel/irq_ia64.c	2006-11-14 14:16:12.000000000 +0800
+++ linux-2.6.19-rc5-mm1_fix/arch/ia64/kernel/irq_ia64.c	2006-11-15 09:56:51.000000000 +0800
@@ -186,7 +186,7 @@ ia64_handle_irq (ia64_vector vector, str
 			ia64_setreg(_IA64_REG_CR_TPR, vector);
 			ia64_srlz_d();
 
-			__do_IRQ(local_vector_to_irq(vector));
+			generic_handle_irq(local_vector_to_irq(vector));
 
 			/*
 			 * Disable interrupts and send EOI:
@@ -242,7 +242,7 @@ void ia64_process_pending_intr(void)
 			 * Probably could shared code.
 			 */
 			vectors_in_migration[local_vector_to_irq(vector)]=0;
-			__do_IRQ(local_vector_to_irq(vector));
+			generic_handle_irq(local_vector_to_irq(vector));
 			set_irq_regs(old_regs);
 
 			/*
