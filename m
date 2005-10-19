Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbVJSJHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbVJSJHn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 05:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVJSJHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 05:07:42 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:58654
	"EHLO x30.random") by vger.kernel.org with ESMTP id S932464AbVJSJHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 05:07:42 -0400
Date: Wed, 19 Oct 2005 11:06:32 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, olof@austin.ibm.com
Subject: Re: [PATCH] .text page fault SMP scalability optimization
Message-ID: <20051019090632.GC30541@x30.random>
References: <20051019075255.GB30541@x30.random> <20051019011420.032ccd6d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051019011420.032ccd6d.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2005 at 01:14:20AM -0700, Andrew Morton wrote:
> How strange.  Do you mena that all CPUs were entering the pagefault handler
> on behalf of the same pte all the time?  That they're staying in lockstep?

Yes.

> If so, there must be a bunch of page_table_lock contention too?

Not really as much. Note also that with latest mainline the ppc64 kernel
was going well even without this patch, it was some older codebase
falling apart, primarly because it was still doing pte_establish there
see:

	young_entry = pte_mkyoung(entry);
	if (!pte_same(young_entry, entry)) {
		ptep_establish(vma, address, pte, young_entry);
		update_mmu_cache(vma, address, young_entry);
		lazy_mmu_prot_update(young_entry);
	}

So those flush actions were a bottleneck when executed by all cpus at
the same time. But some archs still implement it like with the old
codebase, and the patch is quite an obvious optimization that can
clearly avoid useless tlb flushes (and that fixed the problem completely
with the older codebase still dong ptep_establish even on ppc64).
