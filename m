Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWE3XQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWE3XQO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWE3XQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:16:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:61830 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964811AbWE3XQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:16:14 -0400
Subject: Re: 2.6.17-rc5-mm1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: tglx@linutronix.de
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1149030330.20582.45.camel@localhost.localdomain>
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <adawtc34364.fsf@cisco.com> <20060530154521.d737cc65.akpm@osdl.org>
	 <20060530224955.GA5500@elte.hu> <20060530225254.GA5681@elte.hu>
	 <20060530225808.GA5836@elte.hu>
	 <1149030330.20582.45.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 31 May 2006 09:15:49 +1000
Message-Id: <1149030950.9986.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-31 at 01:05 +0200, Thomas Gleixner wrote:
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
> 
> Too tired right now. I look into this tomorrow.

The only way to fix drivers/pci/msi.c is to delete it.

Honest, there is nothing salvageable in that code. I've been looking at
the issues involved in supporting MSIs on various powerpc platforms and
I came to the conclusion that there isn't a single re-useable line of
code in there. Not only it's totally specific to a given set of intel
chipsets, but it's also broken beyond imagination. I wonder how that
code got in there in the first place, especially maskqueraded as
"generic" code. Greg must have been drunk.

At this point, the only solution for us (powerpc) is to allow the arch
to have it's own implementatin of the toplevel MSI API (pci_enable_msi()
etc...). From there, depending on what we come up with, we'll look into
moving that back into generic code, but we are under some pressure for
time (stupid 2 weeks merge window thing is a pain sometimes).

Ben.


