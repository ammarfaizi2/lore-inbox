Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbVIUVMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbVIUVMc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 17:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbVIUVMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 17:12:32 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:22934 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751415AbVIUVMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 17:12:31 -0400
Subject: Re: [swsusp] Rework image freeing
From: Dave Hansen <haveblue@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050921205132.GA4249@elf.ucw.cz>
References: <20050921205132.GA4249@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 21 Sep 2005 14:11:50 -0700
Message-Id: <1127337110.10664.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-21 at 22:51 +0200, Pavel Machek wrote:
> +void swsusp_free(void)
...
> +       for_each_zone(zone) {
> +               for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
> +                       struct page * page;
> +                       page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
> +                       if (PageNosave(page) && PageNosaveFree(page)) {
> +                               ClearPageNosave(page);
> +                               ClearPageNosaveFree(page);
> +                               free_page((long) page_address(page));
> +                       }
>                 }
>         }

This won't work with discontiguous page ranges.  Due to sparsemem you
can run into pages in the middle of a zone where pfn_to_page() doesn't
work.  I'd suggest adding a pfn_valid() check in there.  

-- Dave

