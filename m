Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWGDLyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWGDLyg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 07:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWGDLyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 07:54:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27293 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932220AbWGDLyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 07:54:35 -0400
Date: Tue, 4 Jul 2006 12:54:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] genirq: ARM dyntick cleanup
Message-ID: <20060704115425.GA2313@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
References: <1151885928.24611.24.camel@localhost.localdomain> <20060702173527.cbdbf0e1.akpm@osdl.org> <1151908178.24611.39.camel@localhost.localdomain> <20060703065735.GA19780@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060703065735.GA19780@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 08:57:35AM +0200, Ingo Molnar wrote:
> Christoph has had ideas for cleanups in the irq-header-files area for a 
> long time. My rough battleplan would be this:
> 
> - linux/interrupt.h should remain the highlevel driver API [which can be
>   used by both physical (genirq or non-genirq) or virtual platforms].
>   Only this file should be included by drivers.

Yes.  Note that it's not quite there yet.  Non-genirq architectures currently
have things like enable_irq/disable_irq in asm/irq.h  We really need to have
those prototypes only in linux/interrupt.h.  Unfortunately at least m68k and
sparc had those as macros so they'll need some tweaking first.

> - rename linux/irq.h to linux/irqchips.h, to make it less likely for
>   drivers to include it accidentally.

I find the name rather odd, how bout linux/genirq.h instead?

> 
> - rename asm/irq.h to asm/irqchips.h

Note that currently asm/irq.h is included all over.  

> - most of linux/hardirq.h should merge into interrupt.h [the rest into
>   linux/irqchips.h] and hardirq.h should be eliminated.

Yes.

> - merge asm/hardirq.h and asm/hw_irq.h into asm/irqchips.h.

I'm not sure we can get away with just one asm/*irq.h.  We need arch
bits for genirq and we need arch bits for what was in linux/hardirq.h
and I don't think we want to mix those up.  The latter is just irq_cpustat_t
which needs a big rework anyway to remove the arch independent use of a arch-
defined struct and use DECLARE_PERCPU for each field in each architecture
or a suitable per-arch meachnism.  The only irq_cpustat_t field that the
generic code uses is __softirq_pending and we should rather have a function
abstraction for that.

