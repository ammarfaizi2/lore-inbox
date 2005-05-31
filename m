Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVEaKU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVEaKU4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 06:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVEaKUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 06:20:55 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44194 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261631AbVEaKUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 06:20:42 -0400
Date: Tue, 31 May 2005 12:13:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [RFC] Add some hooks to generic suspend code
Message-ID: <20050531101344.GB9614@elf.ucw.cz>
References: <1117524577.5826.35.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117524577.5826.35.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> While consolidating the powermac suspend to ram and suspend to disk
> implementations to properly use the new framework in kernel/power, among
> others, I ended up with the need of adding various callbacks to
> kernel/power/main.c. Here is a patch adding & documenting those.
> 
> The reasons I need them are:
> 
> 	/* Call before process freezing. If returns 0, then no freeze
> 	 * should be done, if 1, freeze, negative -> error
> 	 */
> 	int (*pre_freeze)(suspend_state_t state);
> 
> I'm using that one for calling my "old style" notifiers (they are beeing phased
> out but I still have a couple of drivers using them). The reason I do that here
> is because that's how my APM emulation hooks, and that code interacts with userland
> (to properly signal things like X of the suspend process), so I need to do that
> before we freeze processes.

This should not be needed in future, right? Could it be marked
deprecated or something?

> 	/* called after sysdevs and "irq off" devices have been
> 	 * worken up, irqs have just been restored to whatever state
> 	 * prepare_irqs() left them in.
> 	 */
> 	void (*finish_irqs)(suspend_state_t state);
> 
> This is the pending of the above callback. It gets called after sysdev's
> have been woken up but before normal devices have. It's called after the core has
> restored local interrupts to what they were upon exit of prepare_irqs(), so if
> you do nothing special in prepare_irqs(), you'll get entered with irqs re-enabled
> here, while if you exit prepare_irqs() with irqs off, you'll get here with irqs
> off as well (and thus become responsible for re-enabling them).
> 
> I want this callback to have finer control of re-enabling interrutps. The interrupt
> controller has been partially reconfigured earlier in arch code, but the CPU priority
> is only lowered here, so that it starts hitting the CPU again only now. There is
> also some code to properly wake up the CPU decrementer so it ticks right away, and
> to force taking a pseudo-interrupt (to sort-of "kick" the interrupt controller into
> life, seems to work around an issue that I think is related to a HW bug in the
> interrupt controller we use). 

Could you simply reconfigure interrupt controller fully in earlier arch code?

> 	/* called after unfreezing userland */
> 	void (*post_freeze)(suspend_state_t state);
> 
> That one is the mirror of pre-freeze, gets called after userland has been re-enabled,
> it also calls my old-style notifiers, which includes APM emulation, which is important
> for sending the APM wakeup events to things like X.

Could this be marked deprecated, too?

Alternatively, proper way of notifying X (etc) should be created, and
done from generic code....

									Pavel
