Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWGAR40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWGAR40 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 13:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbWGAR40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 13:56:26 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:58799 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750939AbWGAR4Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 13:56:25 -0400
Subject: Re: 2.6.17-mm4
From: john stultz <johnstul@us.ibm.com>
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <4807377b0607011033s3e329d7cy1081fb6c8be41e9b@mail.gmail.com>
References: <20060629013643.4b47e8bd.akpm@osdl.org>
	 <4807377b0606291053g602f3413gb3a60d1432a62242@mail.gmail.com>
	 <20060629120518.e47e73a9.akpm@osdl.org>
	 <4807377b0606301653n68bee302t33c2cc28b8c5040@mail.gmail.com>
	 <20060630171212.50630182.akpm@osdl.org>
	 <4807377b0606301717t35d783cbgad6d67daeb163f5a@mail.gmail.com>
	 <1151713862.16221.2.camel@localhost.localdomain>
	 <4807377b0607011033s3e329d7cy1081fb6c8be41e9b@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 10:56:22 -0700
Message-Id: <1151776582.18139.51.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-01 at 10:33 -0700, Jesse Brandeburg wrote:
> On 6/30/06, john stultz <johnstul@us.ibm.com> wrote:
> > >  <IRQ> [<ffffffff8100d442>] main_timer_handler+0x1ed/0x3ad
> > >  [<ffffffff8100d614>] timer_interrupt+0x12/0x27
> > >  [<ffffffff8105076a>] handle_IRQ_event+0x29/0x5a
> > >  [<ffffffff81050837>] __do_IRQ+0x9c/0xfd
> > >  [<ffffffff8100bf27>] do_IRQ+0x63/0x71
> > >  [<ffffffff810098b8>] ret_from_intr+0x0/0xa
> > >  <EOI>
> >
> > Hmmm. From that trace I suspect something is enabling interrupts (likely
> > in time_init) before timekeeping_init() has chosen the clocksource.
> >
> > Does the following workaround the issue?
> >
> > thanks
> > -john
> >
> > diff --git a/init/main.c b/init/main.c
> > index ae04eb7..41adc97 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -497,8 +497,8 @@ asmlinkage void __init start_kernel(void
> >         init_timers();
> >         hrtimers_init();
> >         softirq_init();
> > -       time_init();
> >         timekeeping_init();
> > +       time_init();
> >
> >         /*
> >          * HACK ALERT! This is early. We're enabling the console before
> >
> 
> Yes it works, the previously failing bisect kernel boots with this
> change. I'll take a look through andrew's suggestions next.

Great! Thanks for the testing!

Andrew: While clearly there is the deeper issue of why interrupts are
enabled before they should be, I may still like to push the two-liner
above, since its a bit safer should someone accidentally enable
interrupts early again. Looking back in my patch history it was
previously in the order above until I switched it (I suspect
accidentally) in the C0 rework.

I also added a warning message so we can still detect the problem w/o
hanging.

Does the patch below look reasonable?

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

diff --git a/init/main.c b/init/main.c
index b2f3b56..2984d16 100644
--- a/init/main.c
+++ b/init/main.c
@@ -496,8 +496,8 @@ asmlinkage void __init start_kernel(void
 	init_timers();
 	hrtimers_init();
 	softirq_init();
-	time_init();
 	timekeeping_init();
+	time_init();
 
 	/*
 	 * HACK ALERT! This is early. We're enabling the console before
@@ -508,6 +508,8 @@ asmlinkage void __init start_kernel(void
 	if (panic_later)
 		panic(panic_later, panic_param);
 	profile_init();
+	if(!irqs_disabled())
+		printk("WARNING: Interrupts were enabled early.\n");
 	local_irq_enable();
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start && !initrd_below_start_ok &&


