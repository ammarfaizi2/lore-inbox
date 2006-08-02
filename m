Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWHBTvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWHBTvg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 15:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWHBTvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 15:51:35 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:13701 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932171AbWHBTve
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 15:51:34 -0400
Subject: Re: [PATCH 1/3] swsusp: Fix mark_free_pages
From: Dave Hansen <haveblue@us.ibm.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <200608021848.54374.rjw@sisk.pl>
References: <200608021842.21774.rjw@sisk.pl>
	 <200608021848.54374.rjw@sisk.pl>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 12:51:18 -0700
Message-Id: <1154548279.7232.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-02 at 18:48 +0200, Rafael J. Wysocki wrote:
> +       max_zone_pfn = zone->zone_start_pfn + zone->spanned_pages;
> +       for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++) {
> +               struct page *page = pfn_to_page(pfn);
> +
> +               if (!PageNosave(page))
> +                       ClearPageNosaveFree(page);
> +       } 

This is certainly not the only place in swsusp where there is a bug like
this, but it is not correct to assume that each page inside of a zone is
valid.  With sparsemem, you need to do pfn_valid() on each pfn before
calling pfn_to_page().

Something like:

       max_zone_pfn = zone->zone_start_pfn + zone->spanned_pages;
       for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++) {
		struct page *page;
		if (!pfn_valid(pfn))
			continue;

		page = pfn_to_page(pfn);
		if (!PageNosave(page))
                       ClearPageNosaveFree(page);
       } 


-- Dave

