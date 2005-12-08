Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932755AbVLHXzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932755AbVLHXzG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 18:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932756AbVLHXzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 18:55:05 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:51075 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S932755AbVLHXzE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 18:55:04 -0500
Date: Fri, 9 Dec 2005 10:48:41 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Andy Whitcroft <andyw@uk.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "ADAM G. LITKE [imap]" <agl@us.ibm.com>
Subject: Re: 2.6.15-rc4 panic in __nr_to_section() with CONFIG_SPARSEMEM
Message-ID: <20051208234841.GA30254@localhost.localdomain>
Mail-Followup-To: David Gibson <dwg@au1.ibm.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Andy Whitcroft <andyw@uk.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>,
	"ADAM G. LITKE [imap]" <agl@us.ibm.com>
References: <1133995060.21841.56.camel@localhost.localdomain> <43976AA4.2060606@uk.ibm.com> <1133997772.21841.62.camel@localhost.localdomain> <1134002888.30387.82.camel@localhost> <1134058055.21841.70.camel@localhost.localdomain> <1134069335.6159.21.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134069335.6159.21.camel@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Dec 08, 2005 at 11:15:35AM -0800, Dave Hansen wrote:
> On Thu, 2005-12-08 at 08:07 -0800, Badari Pulavarty wrote:
> > No. It doesn't help. It looks like ppc pmd_huge() always returns 0.
> > Don't know why ? :(
> 
> The ppc64 hugetlb pages don't line up on PMD boundaries like they do on
> i386.  The entries are stored in regular old PTEs.  
> 
> I really don't like coding the two different hugetlb cases, but I can't
> think of a better way to do it.  Anyone care to test on ppc64?

> -		mss->resident += PAGE_SIZE;
> +		page_size = PAGE_SIZE;
> +		if (is_hugepage_only_range(vma->vm_mm, addr, end - addr))
> +			page_size = HPAGE_SIZE;

This is an incorrect usage of is_hugepage_only_range().  Although it
will get the right answer by accident here, that function should
*only* be used for testing whether a range is suitable for normal
pages, never for determining if hugepages are actually in use here.
You have the VMA here, so test its flag instead here.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
