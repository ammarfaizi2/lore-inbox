Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbTI3AVi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 20:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbTI3AVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 20:21:38 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:27013 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263077AbTI3AVg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 20:21:36 -0400
Date: Tue, 30 Sep 2003 01:19:30 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@colin2.muc.de>
Cc: Andi Kleen <ak@muc.de>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, richard.brunner@amd.com
Subject: Re: [PATCH] Athlon Prefetch workaround for 2.6.0test6
Message-ID: <20030930001930.GB25485@mail.jlokier.co.uk>
References: <20030929125629.GA1746@averell> <20030929170323.GC21798@mail.jlokier.co.uk> <20030929174910.GA90905@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030929174910.GA90905@colin2.muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> +	/* 
> +	 * Avoid recursive faults. This catches the kernel jumping to nirvana.
> +	 * More complicated races with unmapped EIP are handled elsewhere for 
> +	 * user space.
> +	 */
> +	if (regs->eip == addr)
> +		return 0; 

I'm curious - how does this help?

If the kernel jumps into nirvana, it will page fault.  is_prefetch()
will do a __get_user which will fault - recursion, ok.  The inner
fault handler will reach fixup_exception(), fixup the __get_user, and
return without recursing further.  is_prefetch() will simply return.

So how does the above test help?

> +	if (seg & (1<<2))
> +		desc = current->mm->context.ldt;
> +	else
> +		desc = (u32 *)&cpu_gdt_table[smp_processor_id()];
> +	desc = (void *)desc + (seg & ~7); 	
> +	return  (desc[0] >> 16) | 
> +	       ((desc[1] & 0xFF) << 16) | 
> +	        (desc[1] & 0xFF000000);

In addition to needing get_cpu() to protect the GDT access, this code
needs to take down(&current->mm->context.sem) for the LDT access.

Otherwise, context.ldt may have been vfree()'d by the time you use it,
and the desc[0..1] accesses will panic.

Thanks,
-- Jamie

