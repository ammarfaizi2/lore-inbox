Return-Path: <linux-kernel-owner+w=401wt.eu-S1763021AbWLKTib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763021AbWLKTib (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763025AbWLKTib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:38:31 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:45683 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763018AbWLKTia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:38:30 -0500
Subject: Re: [PATCH -rt][RESEND] fix preempt hardirqs on OMAP
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20061211190554.GA26392@elte.hu>
References: <20061210163545.488430000@mvista.com>
	 <20061211190554.GA26392@elte.hu>
Content-Type: text/plain
Date: Mon, 11 Dec 2006 11:38:28 -0800
Message-Id: <1165865908.8103.30.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-11 at 20:05 +0100, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > +	/*
> > +	 * Some boards will disable an interrupt when it
> > +	 * sets IRQ_PENDING . So we have to remove the flag
> > +	 * and re-enable to handle it.
> > +	 */
> > +	if (desc->status & IRQ_PENDING) {
> > +		desc->status &= ~IRQ_PENDING;
> > +		if (desc->chip)
> > +			desc->chip->enable(irq);
> > +		goto restart;
> > +	}
> 
> what if the irq got disabled meanwhile? Also, chip->enable is a 
> compatibility method, not something we should use in a flow handler.

I don't know how other arches deal with IRQ_PENDING, but ARM (OMAP at
least) disables the IRQ on IRQ_PENDING. The problem is that by threading
the IRQ we take some control away from the low level code, which needs
to be replaced.

I'm open to potentially removing the irq disable()->enable() cycle on
IRQ_PENDING if it's only done on OMAP. My feeling is that it's in other
ARM's which would make that change more invasive, but I haven't actually
researched that.

Daniel


