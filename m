Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267237AbUIAQqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267237AbUIAQqO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267341AbUIAQqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 12:46:02 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:4233 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267344AbUIAQoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 12:44:07 -0400
Date: Wed, 1 Sep 2004 09:43:54 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@osdl.org>, William Lee Irwin III <wli@holomorphy.com>,
       "David S. Miller" <davem@redhat.com>, raybry@sgi.com, ak@muc.de,
       manfred@colorfullife.com, linux-ia64@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>, vrajesh@umich.edu,
       hugh@veritas.com
Subject: Re: page fault scalability patch final : i386 tested, x86_64 support
 added
In-Reply-To: <1094012689.6538.330.camel@gaston>
Message-ID: <Pine.LNX.4.58.0409010938200.9907@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com> 
 <20040815130919.44769735.davem@redhat.com>  <Pine.LNX.4.58.0408151552280.3370@schroedinger.engr.sgi.com>
  <20040815165827.0c0c8844.davem@redhat.com> 
 <Pine.LNX.4.58.0408151703580.3751@schroedinger.engr.sgi.com> 
 <20040815185644.24ecb247.davem@redhat.com>  <Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com>
  <20040816143903.GY11200@holomorphy.com> 
 <B6E8046E1E28D34EB815A11AC8CA3129027B679F@mtv-atc-605e--n.corp.sgi.com> 
 <B6E8046E1E28D34EB815A11AC8CA3129027B67A9@mtv-atc-605e--n.corp.sgi.com> 
 <B6E8046E1E28D34EB815A11AC8CA3129027B67B4@mtv-atc-605e--n.corp.sgi.com> 
 <Pine.LNX.4.58.0408271616001.14712@schroedinger.engr.sgi.com>
 <1094012689.6538.330.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Sep 2004, Benjamin Herrenschmidt wrote:

> The removal of the page table lock has other more subtle side effects
> on ppc64 (and ppc32 too) that aren't trivial to solve. Typically, due
> to the way we use the hash table as a TLB cache.
>
> For example, out ptep_test_and_clear will first clear the PTE and then
> flush the hash table entry. If in the meantime another CPU gets in,
> takes a fault, re-populates the PTE and fills the hash table via
> update_mmu_cache, we may end up with 2 hash PTEs for the same linux
> PTE at least for a short while. This is a potential cause of checkstop
> on ppc CPUs.
>
> There may be other subtle races of that sort I haven't encovered yet.
>
> We need to spend more time on our (ppc/ppc64) side to figure out what
> is the extent of the problem. We may have a cheap way to fix most of the
> issues using the PAGE_BUSY bit we have in the PTEs as a lock, but we
> don't have that facility on ppc32.
>
> I think there wouldn't be a problem if we could guarantee exclusion
> between page fault and clearing of a PTE (that is basically having the
> swapper take the mm write sem) but I don't think that's realistic, oh
> well, not that I understand anything about the swap code anyways...

We may be able to accomplish that by generic routines for
ptep_cmpxchg and so on that would use the page table lock for platforms
that do not support atomic pte operations.

Something along the lines of:

pte_t ptep_xchg(struct mm_struct *mm, pte_t *ptep, pte_t new) {
	pte_t old;

	spin_lock(&mm->page_table_lock);
	old = *ptep
	set_pte(ptep, new_pte);
	/* Do rehashing */
	spin_unlock(&mm->page_table_lock);
	return old;
}

This would limit the time that the page_table_lock is held to a minimum
and may still offer some of the performance improvements.

Would that be acceptable?
