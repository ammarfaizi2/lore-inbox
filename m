Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263876AbTDHCXL (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 22:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263882AbTDHCXL (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 22:23:11 -0400
Received: from franka.aracnet.com ([216.99.193.44]:52889 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263876AbTDHCXI (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 22:23:08 -0400
Date: Mon, 07 Apr 2003 19:31:39 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] avoid scribbling in IDT with high interrupt count.
Message-ID: <7110000.1049769098@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.50.0304071958360.21025-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0304070818340.26364-100000@home.transmeta.com> <Pine.LNX.4.50.0304071958360.21025-100000@montezuma.mastecende.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My patch skips irq numbers > NR_IRQS and simply return error when we run 
> out of vectors, although mainline doesn't assign duplicates and cause 
> collisions, it does waste vector space. e.g. for a system with 
> NR_IRQS = 224 we have 23 vectors free, 0 collisions and 167 useable irqs 
> and assign_irq_vectors states that we're out of vectors.
> 
>> In other words, I'm wondering if this simpler patch wouldn't be sufficient 
>> instead?
>> 
>> Can you please test this, and re-submit (and if you can explain why your 
>> patch is better, please do so - I have nothing fundamentally against it, I 
>> just want to understand _why_ the complexity is needed).
> 
> Your patch booted the system but there are vector collisions resulting in 
> lost irq routing when we program the IOAPIC with the duplicated vector. So 
> with your patch and NR_IRQS = 224 we have 1 vectors free (0x80), 34 collisions 
> and 225 irqs. However that isn't a fault of your patch but a fault with 
> the NR_IRQS definition. This is what the vector space looks like on i386 
> at present.
> 
> 0________0x31__________________________0xef____________0xff
>   system	   io interrupts            resvd vectors
> 
> 0xef - 0x31 = 190 useable io interrupt vectors
> 
> So perhaps we should, apply your patch, add a NR_IRQ_VECTORS define 
> and also add commentary in irq_vectors.h how does the following look? I 
> had to readd the NR_IRQS checks to protect against overrunning NR_IRQS sized 
> arrays and i added nr_assigned to track how many vectors were allocated so 
> taht we can bail out when we're out.
> 
> Patch has been tested on a 320 interrupt system and had a maximum useable 
> irq line of 211 (ethernet).

We're still allocating interrupts to a bunch 'o stuff that isn't actually
being used ... I'd prefer it if we could change that, and allocate them
as they're actually used, rather than (what I believe is) still a fixed
number per IO-APIC. Is there some smart way to do that?

If not, the overflow protection is still (obviously) a good thing to do.

M.

