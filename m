Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267864AbUILLwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267864AbUILLwW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 07:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268704AbUILLtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 07:49:33 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36620 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267864AbUILLo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 07:44:58 -0400
Date: Sun, 12 Sep 2004 12:44:48 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Hellwig <hch@arm.linux.org.uk>, akpm@osdl.org, spyro@f2s.com,
       linux390@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irq_enter/irq_exit consolidation
Message-ID: <20040912124448.A13676@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@flint.arm.linux.org.uk>,
	akpm@osdl.org, spyro@f2s.com, linux390@de.ibm.com,
	linux-kernel@vger.kernel.org
References: <20040912112554.GA32550@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040912112554.GA32550@lst.de>; from hch@lst.de on Sun, Sep 12, 2004 at 01:25:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 01:25:54PM +0200, Christoph Hellwig wrote:
> Move irq_enter/irq_exit from <asm/hardirq.h> to <linux/hardirq.h>.
> There some fishy things going on with the do_softirq invokation on
> arm, arm26 and s390.
> 
> arm calls __do_softirq directly without local irq disabling which looks
> like a real bug to me.

The ARM interrupt subsystem guarantees that local IRQs are disabled
prior to irq_exit() being invoked.  This is a must for reasons other
than softirq semantics - hardware IRQ controllers may require a
nonatomic read-modify-write to update their IRQ masking state.

This guarantee must also exist on every other architecture, otherwise:

> ===== include/linux/hardirq.h 1.1 vs edited =====
> --- 1.1/include/linux/hardirq.h	2004-09-08 08:32:57 +02:00
> +++ edited/include/linux/hardirq.h	2004-09-11 21:26:28 +02:00
> +#define irq_exit()						\
> +do {								\
> +	preempt_count() -= IRQ_EXIT_OFFSET;			\

would be buggy - it's an inherently non-atomic operation.  Not only that
but the behaviour of nested interrupts would change depending on whether
they interrupted before or after preempt count has been updated.

So maybe every other architecture except ARM is buggy? 8)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
