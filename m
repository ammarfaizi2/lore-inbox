Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWAWGZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWAWGZP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 01:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWAWGZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 01:25:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52203 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751027AbWAWGZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 01:25:13 -0500
Date: Sun, 22 Jan 2006 22:24:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arnaud Giersch <arnaud.giersch@free.fr>
Cc: philb@gnu.org, tim@cyberelk.net, campbell@torque.net, andrea@suse.de,
       linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] parport: add parallel port support for SGI O2
Message-Id: <20060122222425.6907656f.akpm@osdl.org>
In-Reply-To: <87mzhqfq5y.fsf@groumpf.homeip.net>
References: <87mzhqfq5y.fsf@groumpf.homeip.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaud Giersch <arnaud.giersch@free.fr> wrote:
>
> From: Arnaud Giersch <arnaud.giersch@free.fr>
> 
> Add support for the built-in parallel port on SGI O2 (a.k.a. IP32).
> Define a new configuration option: PARPORT_IP32.  The module is named
> parport_ip32.
> 
> Hardware support for SPP, EPP and ECP modes along with DMA support
> when available are currently implemented.

Nice looking driver.  Big.

It does rather a lot of

	if (foo)	do_something();

whereas we prefer

	if (foo)
		do_something();

but if that was a blocker, we wouldn't have any drivers.

> +static void parport_ip32_dma_setup_context(unsigned int limit)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&parport_ip32_dma.lock, flags);
> +	if (parport_ip32_dma.left > 0) {
> +		volatile u64 __iomem *ctxreg = (parport_ip32_dma.ctx == 0) ?
> +			&mace->perif.ctrl.parport.context_a :
> +			&mace->perif.ctrl.parport.context_b;

Does this need to be volatile?   writeq() should do the right thing.

> +static size_t parport_ip32_epp_read(void __iomem *eppreg,
> +				    struct parport *p, void *buf,
> +				    size_t len, int flags)
> +{
> +	struct parport_ip32_private * const priv = p->physport->private_data;
> +	size_t got;
> +	parport_ip32_set_mode(p, ECR_MODE_EPP);
> +	parport_ip32_data_reverse(p);
> +	parport_ip32_write_control(p, DCR_nINIT);
> +	if ((flags & PARPORT_EPP_FAST) && (len > 1)) {
> +		readsb(eppreg, buf, len);

readsb() is a mips thing, and doesn't seem to be documented.  What does it
do, and why does the driver use it (only) here?

> +		writesb(eppreg, buf, len);

> +static unsigned int parport_ip32_fifo_wait_break(struct parport *p,
> +						 unsigned long expire)
> +{
> +	cond_resched();
> +	if (time_after(jiffies, expire)) {
> +		printk(KERN_DEBUG PPIP32
> +		       "%s: FIFO write timed out\n", p->name);
> +		return 1;
> +	}
> +	if (signal_pending(current)) {
> +		printk(KERN_DEBUG PPIP32
> +		       "%s: Signal pending\n", p->name);
> +		return 1;
> +	}

This printk could be a bit noisy, if someone hoses a signal stream at a
printing program.

