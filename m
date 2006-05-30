Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWE3XO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWE3XO2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWE3XO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:14:27 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:36280 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964805AbWE3XO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:14:27 -0400
Date: Wed, 31 May 2006 01:14:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060530231446.GA6504@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <adawtc34364.fsf@cisco.com> <20060530154521.d737cc65.akpm@osdl.org> <20060530224955.GA5500@elte.hu> <20060530225254.GA5681@elte.hu> <20060530225808.GA5836@elte.hu> <1149030330.20582.45.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149030330.20582.45.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> CC'ed Ben, who is hacking on msi, IIRC
> 
> On Wed, 2006-05-31 at 00:58 +0200, Ingo Molnar wrote:
> > > > 
> > > > does MSI much with the irq_desc[] separately perhaps, clearing 
> > > > handle_irq in the process perhaps?
> > > 
> > > aha - drivers/pci/msi.c sets msix_irq_type, which has no handle_irq 
> > > entry. This needs to be converted to irqchips.
> > 
> > still ... that doesnt explain how the irq_desc[].irq_handler got NULL. 
> 
> It has it's own irq_desc array
> 
> static struct msi_desc* msi_desc[NR_IRQS] = { [0 ... NR_IRQS-1] = NULL };

ah ...

then i guess a quick solution would be to do:

	if (!irq_desc[irq].irq_handler)
		__do_IRQ(irq, regs);
	else
		generic_handle_irq(irq, regs);

in arch/x86_64/kernel/irq.c [and in arch/i386/kernel/irq.c], and 
__do_IRQ() should handle the old-style irq-type MSI code just fine.

	Ingo
