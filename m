Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbVCZPDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbVCZPDc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 10:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbVCZPDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 10:03:32 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44043 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262113AbVCZPDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 10:03:30 -0500
Date: Sat, 26 Mar 2005 15:03:21 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org, davem@davemloft.net,
       tony.luck@intel.com, benh@kernel.crashing.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] freepgt: free_pgtables shakeup
Message-ID: <20050326150321.C12809@flint.arm.linux.org.uk>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	Hugh Dickins <hugh@veritas.com>, akpm@osdl.org, davem@davemloft.net,
	tony.luck@intel.com, benh@kernel.crashing.org, ak@suse.de,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com> <20050325212234.F12715@flint.arm.linux.org.uk> <4244C3B7.4020409@yahoo.com.au> <20050326113530.A12809@flint.arm.linux.org.uk> <20050326133720.B12809@flint.arm.linux.org.uk> <424568D2.7090701@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <424568D2.7090701@yahoo.com.au>; from nickpiggin@yahoo.com.au on Sun, Mar 27, 2005 at 12:51:14AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 12:51:14AM +1100, Nick Piggin wrote:
> Hmm, in that case it could be just a problem with that BUG_ON() -
> it wasn't there before... but it seems like a very useful test,
> especially with all this new work going on, so it would be a shame
> not to run it in releases.

Indeed.

> But I don't quite understand (should really look at the code more),
> how come you aren't leaking memory?

The ARM free_pgd_slow() knows about this special first L1 page table, and
knows to free it if it exists when its called.

> Do _all_ processes share this same first L1 page table?

No.  It has to be specific to each process.  Each L1 page table entry
covers 2MB, but executables start at virtual 0x8000.

I guess we could open-code pte_alloc_map() in get_pgd_slow() which
could solve this problem by omitting the mm->nr_ptes accounting; it
may also reduce the complexity as well.

I'm just slightly concerned that this may be rather fragile in terms
of future development.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
