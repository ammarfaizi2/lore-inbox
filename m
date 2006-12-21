Return-Path: <linux-kernel-owner+w=401wt.eu-S1422765AbWLUG4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422765AbWLUG4f (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 01:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422773AbWLUG4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 01:56:35 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43883 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422765AbWLUG4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 01:56:34 -0500
Date: Wed, 20 Dec 2006 22:56:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, tglx@linutronix.de,
       mingo@elte.hu, Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH -mm 3/5][time][x86_64] Split x86_64/kernel/time.c up
Message-Id: <20061220225602.0ff3f49e.akpm@osdl.org>
In-Reply-To: <20061220221003.15178.60219.sendpatchset@localhost>
References: <20061220220945.15178.2669.sendpatchset@localhost>
	<20061220221003.15178.60219.sendpatchset@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006 17:13:37 -0500
john stultz <johnstul@us.ibm.com> wrote:

> +
> +unsigned int __init hpet_calibrate_tsc(void)
> +{
> +	int tsc_start, hpet_start;
> +	int tsc_now, hpet_now;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	local_irq_disable();
> +
> +	hpet_start = hpet_readl(HPET_COUNTER);
> +	rdtscl(tsc_start);
> +
> +	do {
> +		local_irq_disable();
> +		hpet_now = hpet_readl(HPET_COUNTER);
> +		tsc_now = get_cycles_sync();
> +		local_irq_restore(flags);
> +	} while ((tsc_now - tsc_start) < TICK_COUNT &&
> +		(hpet_now - hpet_start) < TICK_COUNT);
> +
> +	return (tsc_now - tsc_start) * 1000000000L
> +		/ ((hpet_now - hpet_start) * hpet_period / 1000);
> +}

What a confused function.  If called with local irqs disabled it'll fail to
enable interrupts in that loop.  Perhaps that's deliberate, dunno.

Plus local_irq_save() disables interrupts, so the first local_irq_disable()
is not needed.

I will kill the unneeded local_irq_disable() and then shall back slowly away
from it.
