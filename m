Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTJAH4C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 03:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbTJAH4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 03:56:02 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:44934 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261967AbTJAH4A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 03:56:00 -0400
Date: Wed, 1 Oct 2003 08:55:51 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Message-ID: <20031001075551.GL1131@mail.shareable.org>
References: <7F740D512C7C1046AB53446D3720017304AFCF@scsmsx402.sc.intel.com.suse.lists.linux.kernel> <20031001053833.GB1131@mail.shareable.org.suse.lists.linux.kernel> <20030930224853.15073447.akpm@osdl.org.suse.lists.linux.kernel> <20031001061348.GE1131@mail.shareable.org.suse.lists.linux.kernel> <20030930233258.37ed9f7f.akpm@osdl.org.suse.lists.linux.kernel> <20031001065705.GI1131@mail.shareable.org.suse.lists.linux.kernel> <p73brt1zahk.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73brt1zahk.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Jamie Lokier <jamie@shareable.org> writes:
> > It is easy enough to fix by making the fault handler not take
> > mmap_sem if the fault's in the kernel address range.  (With apologies
> > to the folk running kernel mode userspace...)
> 
> It won't work because kernel can cause user space faults
> (think get_user). And handling these must be protected.

Are we mis-communicating?  By "fault in the kernel address range", I
mean that the faulting address is in that range, not where the
instruction is located.

get_user faults are obviously not in the kernel address range (except
when set_fs has been used, which is rare and not a problem here).

When __get_user faults in __is_prefetch, while decoding an instruction
in kernel space, it is good for do_page_fault to take the short-cut I
suggested, skip locks, and reach the exception table fixup.  It will
turn out to be a bad address, __is_prefetch will report that it isn't
a prefetch, and carry on to bust_spinlocks(), oops etc.

When __get_user faults in __is_prefetch, while decoding a userspace
instruction, then it won't take that short-cut because the (inner)
faulting address won't be in the kernel address range.  The normal vma
lookup will take place, install a user page, and the userspace
instruction is decoded just fine.

What have I missed?

-- Jamie
