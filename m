Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030745AbWKORrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030745AbWKORrX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030755AbWKORrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:47:23 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:44268 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030745AbWKORrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:47:22 -0500
Date: Wed, 15 Nov 2006 18:46:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Komuro <komurojun-mbn@nifty.com>, tglx@linutronix.de,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] genirq: do not mask interrupts by default
Message-ID: <20061115174604.GA24429@elte.hu>
References: <7813413.118221162987983254.komurojun-mbn@nifty.com> <11940937.327381163162570124.komurojun-mbn@nifty.com> <Pine.LNX.4.64.0611130742440.22714@g5.osdl.org> <m13b8ns24j.fsf@ebiederm.dsl.xmission.com> <1163450677.7473.86.camel@earth> <m1bqnboxv5.fsf@ebiederm.dsl.xmission.com> <1163492040.28401.76.camel@earth> <Pine.LNX.4.64.0611140757040.31445@g5.osdl.org> <20061115090427.GA16173@elte.hu> <Pine.LNX.4.64.0611150808350.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611150808350.3349@woody.osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -3.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.3 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_05 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-0.4 BAYES_05               BODY: Bayesian spam probability is 1 to 5%
	[score: 0.0373]
	0.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> On Wed, 15 Nov 2006, Ingo Molnar wrote:
> > 
> > problem is, we dont know /for a fact/ that something is "APIC-edge". 
> > We only know that the BIOS claims it that it's so.
> 
> This is incorrect. We will have _programmed_ the APIC with whatever 
> the BIOS said in the MP tables, so if we think it's level triggered, 
> it _is_ level triggered.

yeah. I was thinking about the low 16 irqs (those are really the problem 
spots most of the time, not the normal IO-APIC irqs) - which are routed 
all across the southbridge and might end up being handled by a 
i8259A-lookalike entity. Right now we default to level-triggered IRQ 
flow handling:

                if (i < 16) {
                        /*
                         * 16 old-style INTA-cycle interrupts:
                         */
                        set_irq_chip_and_handler_name(i, &i8259A_chip,
                                                      handle_level_irq, "XT");

because that's the best we can do (it's also what our i8259 code did 
historically). But it would be one step safer to also do the 
lazy-disable. Just in case things might get lost while masked. Or is 
that an absolutely horrible hardware breakage that i shouldnt worry 
about?

> So I really think that all the arguments for i8259 not wanting replay 
> weigh equally on level-triggered PCI irq's too.
> 
> Now, the one thing that makes me think your approach is the right one 
> is that it's potentially going to be better performance - if people 
> disable irq's and the normal case is that no irq will actually happen, 
> then optimistically not doing anything at all (except marking the irq 
> disabled, of course) is always good.
> 
> However, because it's a semantic change, I _really_ don't want to do 
> it right now. We're maybe a week away from 2.6.19, and the "ISA irq's 
> don't work" report is one of the things that is holding things up 
> right now.
>
> So that's why I'd much rather go with Eric's patch for now - because 
> it keeps the semantics that we've always had.

ok, i'm fine with Eric's patch too, if it solves Komuro's problem:

  Acked-by: Ingo Molnar <mingo@elte.hu>

and we dont have to worry about the present ugliness of the 
delayed-disabled flag either, as it would just go away in 2.6.20.

	Ingo
