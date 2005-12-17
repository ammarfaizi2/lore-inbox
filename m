Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbVLQUi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbVLQUi2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 15:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964917AbVLQUi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 15:38:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31713 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964943AbVLQUiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 15:38:24 -0500
Date: Sat, 17 Dec 2005 12:37:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kmap_atomic slot collision
Message-Id: <20051217123755.aaa73edf.akpm@osdl.org>
In-Reply-To: <20051215173353.GA29402@mellanox.co.il>
References: <20051215173353.GA29402@mellanox.co.il>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael S. Tsirkin" <mst@mellanox.co.il> wrote:
>
> Hi!
> I'm trying to use kmap_atomic from both interrupt and task context.
> My idea was to do local_irq_save and then use KM_IRQ0/KM_IRQ1:
> since I'm disabling interrupts I assumed that this should be safe.
> The relevant code is here:
> https://openib.org/svn/gen2/trunk/src/linux-kernel/infiniband/ulp/sdp/sdp_iocb.c
> 
> However, under stress I see errors from arch/i386/mm/highmem.c:42
>         if (!pte_none(*(kmap_pte-idx)))
>                 BUG();
> 
> Apparently, my routine, running from a task context, races with
> some other kernel code, and so I'm trying to use a slot that was not
> yet unmapped.
> 
> Anyone has an idea on what I could be doing wrong?

kmap slots are like any other CPU-local resources - they need to be
protected from context switches and from interrupts.  The slots such as
KM_USER0 are protected by preempt_disable() to prevent this CPU from
context switching and scribbling on this CPU's kmap slot from with another
task.  kmap_atomic() does this preempt_disable() internally.

The IRQ-context per-cpu kmap slots need to be protected from another IRQ on
this CPU by taking local_irq_disable().  IOW:

	local_irq_save(flags);
	vaddr = kmap_atomic(page, KM_IRQ0);
	diddle(*vaddr);
	kunmap_atomic(vaddr, KM_IRQ0);
	local_irq_restore(flags);

Plus we should do flush_dcache_page() if the page can possibly be mapped
into process pagetables.  I forget whether flush_dcache_page() is safe from
hard IRQ context...

If your interrupt handler is using SA_SHIRQ (and most are), then the
local_irq_save() is needed even within the IRQ handler.

And lo, a bunch of places in the kernel are forgetting to disable local
interrupts.  So if your ode is correctly coded as above, you can scribble
on their kmap, but they cannot scribble on yours.

Failing to disable local IRQs while taking KM_IRQn is a ghastly bug.  I'll
fix 'em up.
