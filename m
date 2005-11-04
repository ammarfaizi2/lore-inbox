Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbVKDUTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbVKDUTE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 15:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbVKDUTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 15:19:04 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:20232 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1750902AbVKDUTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 15:19:02 -0500
Message-ID: <436BC20B.9070704@shadowen.org>
Date: Fri, 04 Nov 2005 20:18:19 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] powerpc: mem_init crash for sparsemem
References: <200511041631.17237.arnd@arndb.de>
In-Reply-To: <200511041631.17237.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> I have a Cell blade with some broken memory in the middle of the
> physical address space and this is correctly detected by the
> firmware, but not relocated. When I enable CONFIG_SPARSEMEM,
> the memsections for the nonexistant address space do not
> get struct page entries allocated, as expected.
> 
> However, mem_init for the non-NUMA configuration tries to
> access these pages without first looking if they are there.
> I'm currently using the hack below to work around that, but
> I have the feeling that there should be a cleaner solution
> for this.
> 
> Please comment.
> 
> Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>
> 
> --- linux-2.6.15-rc.orig/arch/powerpc/mm/mem.c
> +++ linux-2.6.15-rc/arch/powerpc/mm/mem.c
> @@ -348,6 +348,9 @@ void __init mem_init(void)
>  #endif
>  	for_each_pgdat(pgdat) {
>  		for (i = 0; i < pgdat->node_spanned_pages; i++) {
> +			if (!section_has_mem_map(__pfn_to_section
> +					(pgdat->node_start_pfn + i)))
> +				continue;
>  			page = pgdat_page_nr(pgdat, i);
>  			if (PageReserved(page))
>  				reservedpages++;

Would it not make sense to use pfn_valid(), as that is not sparsemem
specific?  Not looked at the code in question specifically, but if you
can use section_has_mem_map() it should be equivalent:

	if (!pfn_valid(pgdat->node_start_pfn + i))
		continue;

Want to spin us a patch and I'll give it some general testing.

-apw
