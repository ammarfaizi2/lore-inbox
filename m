Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbTI2RGZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263794AbTI2REo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:04:44 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:8837 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S263792AbTI2REh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:04:37 -0400
Date: Mon, 29 Sep 2003 18:03:23 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@muc.de>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       richard.brunner@amd.com
Subject: Re: [PATCH] Athlon Prefetch workaround for 2.6.0test6
Message-ID: <20030929170323.GC21798@mail.jlokier.co.uk>
References: <20030929125629.GA1746@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030929125629.GA1746@averell>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> +/* 
> + * Find an segment base in the LDT/GDT.
> + * Don't need to do any boundary checking because the CPU did that already 
> + * when the instruction was executed 
> + */

I'm not 100% sure, but I see some possible dangerous race conditions.

  1. Userspace thread A has a page fault at CS:EIP == 0x000f:0xbffff000.

     Simultaneously, userspace thread B calls modify_ldt() to change
     the LDT descriptor base to 0x40000000.

     The LDT descriptor is changed after A enters the page fault
     handler, but before it takes mmap_sem.  This can happen on SMP or
     on a pre-empt kernel.

     __is_prefetch() calls __get_user(0xfffff000), or whatever
     address userspace wants to trick it into reading.

     Result: unpriveleged userspace causes an MMIO read and crashes
     the system, or worse.

  2. segment_base sets "desc = (u32 *)&cpu_gdt_table[smp_processor_id()]".

     Pre-empt switches CPU.

     desc now points to the _old_ CPU, where the GDT for this task is
     no longer valid, and that is read in the next few lines.

I think for completeness you should check the segment type and limit
too (because they can be changed, see 1.).  These are easier to check
than they look (w.r.t. 16 bit segments etc.): you don't have to decode
the descriptor; just use the "lar" and "lsl" instructions.

If you can't decode the instruction because of transient access
problems, just return as if it was a prefetch, so that the faulting
instruction will be retried, or access permissions will cause the
program to trap in the normal ways.

-- Jamie
