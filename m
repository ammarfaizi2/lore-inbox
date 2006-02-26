Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWBZXJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWBZXJl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 18:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWBZXJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 18:09:41 -0500
Received: from ozlabs.org ([203.10.76.45]:34260 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932253AbWBZXJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 18:09:40 -0500
Date: Mon, 27 Feb 2006 10:09:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
       linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com,
       yanmin.zhang@intel.com, "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Paul Mundt <lethal@linux-sh.org>, kkojima@rr.iij4u.or.jp,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH] Enable mprotect on huge pages
Message-ID: <20060226230903.GA24422@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>,
	"Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
	linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com,
	yanmin.zhang@intel.com, "David S. Miller" <davem@davemloft.net>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	Paul Mundt <lethal@linux-sh.org>, kkojima@rr.iij4u.or.jp,
	"Luck, Tony" <tony.luck@intel.com>
References: <1140664780.12944.26.camel@ymzhang-perf.sh.intel.com> <20060224142844.77cbd484.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060224142844.77cbd484.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 02:28:44PM -0800, Andrew Morton wrote:
> "Zhang, Yanmin" <yanmin_zhang@linux.intel.com> wrote:
> >
> > From: Zhang, Yanmin <yanmin.zhang@intel.com>
> > 
> > 2.6.16-rc3 uses hugetlb on-demand paging, but it doesn_t support hugetlb
> > mprotect. My patch against 2.6.16-rc3 enables this capability.
> > 
> 
> Well I suppose that makes sense.  It does assume that the normal pte
> protection-changing APIs do the right thing on all architectures which
> implement huge pages.  That's quite possibly the case, but we should
> confirm that.

Well, it will need to be huge_ptep_get_and_clear() below, not the
normal version.  But pte_modify should be ok.  I'm not sure
pte_present() is safe, either, !pte_none() is what we use elsewhere in
hugetlb.c.

And.. looks like lazy_mmu_prot_update() is unsafe, too.  The only arch
which has something here (ia64) has a function which does icache
flushes on PAGE_SIZE only.

> > +
> > +void hugetlb_change_protection(struct vm_area_struct *vma,
> > +		unsigned long address, unsigned long end, pgprot_t newprot)
> > +{
> > +	struct mm_struct *mm = vma->vm_mm;
> > +	unsigned long start = address;
> > +	pte_t *ptep;
> > +	pte_t pte;
> > +
> > +	BUG_ON(address >= end);
> > +	flush_cache_range(vma, address, end);
> > +
> > +	spin_lock(&mm->page_table_lock);
> > +	for (; address < end; address += HPAGE_SIZE) {
> > +		ptep = huge_pte_offset(mm, address);
> > +		if (!ptep)
> > +			continue;
> > +		if (pte_present(*ptep)) {
> > +			pte = ptep_get_and_clear(mm, address, ptep);
> > +			pte = pte_modify(pte, newprot);
> > +			set_huge_pte_at(mm, addr, ptep, pte);
> > +			lazy_mmu_prot_update(pte);
> > +		}
> > +	}
> > +	spin_unlock(&mm->page_table_lock);
> > +
> > +	flush_tlb_range(vma, start, end);
> > +}
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
