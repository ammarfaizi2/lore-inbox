Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265389AbTLHPXi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 10:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265418AbTLHPXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 10:23:38 -0500
Received: from holomorphy.com ([199.26.172.102]:37851 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265389AbTLHPXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 10:23:36 -0500
Date: Mon, 8 Dec 2003 07:23:33 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: moi toi <mikemaster_f@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Physical address
Message-ID: <20031208152333.GU19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	moi toi <mikemaster_f@yahoo.fr>, linux-kernel@vger.kernel.org
References: <20031208150713.39743.qmail@web25201.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031208150713.39743.qmail@web25201.mail.ukl.yahoo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 08, 2003 at 04:07:13PM +0100, moi toi wrote:
> Does that mean that the functions virt_to_phys and
> virt_to_bus don't work on virtual addresses? Does anyone know, how to
> get the real physical address of the buffer.

Linux assumes 1:1 mapping of kernel virtual addresses, with various
exceptions.

virt_to_bus() and virt_to_phys() only work on that statically mapped
area's virtual addreses.

ioremap() dynamically establishes translations for the areas, and
the virtual addresses returned by it are not valid to resolve to
physical addresses with virt_to_bus() and virt_to_phys().

Probably the best way to find the physical address is by a direct
pagetable lookup. Something like the following (untested) may be of use:

static dma_addr_t ioremap_to_phys(unsigned long vaddr)
{
	pgd_t *pgd;
	pmd_t *pmd;
	pte_t *pte;

	pgd = pgd_offset_k(vaddr);
	if (!pgd_present(*pgd))
		return 0;
	pmd = pmd_offset(pgd, vaddr);
	if (!pmd_present(*pmd))
		return 0;
	pte = pte_offset_kernel(pmd, vaddr);
	if (!pte_present(*pte))
		return 0;
	return ((dma_addr_t)pte_pfn(*pte) << PAGE_SHIFT) | (addr & ~PAGE_MASK);
}


-- wli
