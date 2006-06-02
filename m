Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWFBUGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWFBUGz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 16:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWFBUGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 16:06:55 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:26548 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751479AbWFBUGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 16:06:54 -0400
Date: Fri, 2 Jun 2006 13:06:43 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Adam Litke <agl@us.ibm.com>
cc: linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
       David Gibson <david@gibson.dropbear.id.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hugetlb: powerpc: Actively close unused htlb regions on
 vma close
In-Reply-To: <1149257287.9693.6.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606021301300.5492@schroedinger.engr.sgi.com>
References: <1149257287.9693.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2006, Adam Litke wrote:

> The following patch introduces a architecture-specific vm_ops.close()
> hook.  For all architectures besides powerpc, this is a no-op.  On
> powerpc, the low and high segments are scanned to locate empty hugetlb
> segments which can be made available for normal mappings.  Comments?

IA64 has similar issues and uses the hook suggested by Hugh. However, we 
have a permanently reserved memory area. I am a bit surprised about the 
need to make address space available for normal mappings. Is this for 32 
bit powerpc support?

void hugetlb_free_pgd_range(struct mmu_gather **tlb,
                        unsigned long addr, unsigned long end,
                        unsigned long floor, unsigned long ceiling)
{
        /*
         * This is called to free hugetlb page tables.
         *
         * The offset of these addresses from the base of the hugetlb
         * region must be scaled down by HPAGE_SIZE/PAGE_SIZE so that
         * the standard free_pgd_range will free the right page tables.
         *
         * If floor and ceiling are also in the hugetlb region, they
         * must likewise be scaled down; but if outside, left unchanged.
         */

        addr = htlbpage_to_page(addr);
        end  = htlbpage_to_page(end);
        if (REGION_NUMBER(floor) == RGN_HPAGE)
                floor = htlbpage_to_page(floor);
        if (REGION_NUMBER(ceiling) == RGN_HPAGE)
                ceiling = htlbpage_to_page(ceiling);

        free_pgd_range(tlb, addr, end, floor, ceiling);
}

