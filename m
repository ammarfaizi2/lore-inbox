Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVCWXII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVCWXII (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 18:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbVCWXII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 18:08:08 -0500
Received: from gate.crashing.org ([63.228.1.57]:55966 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262091AbVCWXIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 18:08:00 -0500
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       nickpiggin@yahoo.com.au, davem@davemloft.net, tony.luck@intel.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0503231248510.13752@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com>
	 <20050322034053.311b10e6.akpm@osdl.org>
	 <Pine.LNX.4.61.0503221617440.8666@goblin.wat.veritas.com>
	 <1111534250.16224.22.camel@gaston>
	 <Pine.LNX.4.61.0503231248510.13752@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Thu, 24 Mar 2005 10:07:19 +1100
Message-Id: <1111619239.16224.92.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Thanks for the warning, Ben, but I don't see a problem there: that's
> in your separate ioremap_mm, which is rather like init_mm, and won't
> ever go through exit_mmap, and doesn't need its page tables freed -
> isn't that right?

Right.

> But it was worth auditing the different architectures for this: there
> seems to be just one problem, where the x86_64 32-bit vsyscall page
> is mapped into userspace by __map_syscall32 without linking a real
> vma into mm.  Which Andi has already marked with his "RED-PEN".

The ppc64 vDSO is mapped with a real VMA bot not mmap call (the vDMA is
built from scratch from binfmt_elf, or rather from an arch callback
issued by binfmt_elf, like the stack VMA). Though should be fine too
though but you may want to double check.

> That's not something I can fix up in a hurry.  Yes, as the comment
> suggests we should probably allocate a real vma for it, but that might
> have a few consequences (if only /proc/<pid>/maps showing two vdsos?).
> I'll have to let someone else deal with that.

Why 2 ? we map the 32 bits one for 32 bits processes and the 64 bits one
for 64 bits processes on ppc64 without problem ... In fact, Andi could
even re-use our hook I suppose. The way I do it allows also for free
copy-on-write semantics (with mprotect though, I don't set it writeable
by default) so that gdb can put breakpoints in it, etc...

> For the moment, I think the behaviour of x86_64 32bit-support with
> the freepgt patches will depend on personality - ADDR_LIMIT_32BIT
> should usually work fine (unless the app moves its stack elsewhere
> and munmaps the old one: that might well unmap its vdso too); but
> ADDR_LIMIT_3GB will be liable to leak tables (if get_user_pages or
> its /proc/<pid>/maps has been examined).  I don't know how common
> ADDR_LIMIT_3GB use is, but whatever: okay for testing, but not for
> including the patches in a release.
> 
> Hugh
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

