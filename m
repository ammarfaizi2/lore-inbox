Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbTJAHbo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 03:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbTJAHbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 03:31:44 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:43654 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262051AbTJAHbm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 03:31:42 -0400
Date: Wed, 1 Oct 2003 08:31:32 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Message-ID: <20031001073132.GK1131@mail.shareable.org>
References: <7F740D512C7C1046AB53446D3720017304AFCF@scsmsx402.sc.intel.com.suse.lists.linux.kernel> <20031001053833.GB1131@mail.shareable.org.suse.lists.linux.kernel> <20030930224853.15073447.akpm@osdl.org.suse.lists.linux.kernel> <20031001061348.GE1131@mail.shareable.org.suse.lists.linux.kernel> <20030930233258.37ed9f7f.akpm@osdl.org.suse.lists.linux.kernel> <p73k77pzc69.fsf@oldwotan.suse.de> <20031001000015.69007e85.akpm@osdl.org> <20031001070620.GK15853@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001070620.GK15853@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Hmm.   I guess that's possible, but will be somewhat intrusive in 
> do_page_fault()

See recent message from me.  All you need is a check "address >=
TASK_SIZE", which is thread already at the start of do_page_fault.  So
if you split that conditional like this, from:

	if (address >= TASK_SIZE && !(error_code & 5))
		goto vmalloc_fault;
	mm = tsk->mm;
	info.si_code = SEGV_MAPERR;
	if (in_atomic() || !mm)
		goto bad_area_nosemaphore;

to:

	if (address >= TASK_SIZE) {
		if (!(error_code & 5))
			goto vmalloc_fault;
		mm = tsk->mm;
		info.si_code = SEGV_MAPERR;
		goto bad_area_nosemaphore;
	}

doesn't that fix the problem and while also being an improvement in
lots of other ways?  The only reason it wouldn't work is if the VMA
list can contain regions >= TASK_SIZE, but I don't think that is done.

> Also you have to be very careful to avoid recursive faults (EIP unmapped) 
> recursing further. In the original patch I did that for kernel mode by always
> checking the exception table first to catch the __get_user in __is_prefetch
> early.

I'm looking at "[PATCH] Athlon Prefetch workaround for 2.6.0test6" and
it appears to check the exception table first.  That's why I was
wondering why you have the regs->eip == addr check.

search_exception_table doesn't take any locks for non-module entries,
so it can fixup the __get_user in __is_prefetch when that occurs
inside locked regions of the kernel.

-- Jamie
