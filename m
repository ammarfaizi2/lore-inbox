Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVAIWst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVAIWst (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 17:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVAIWst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 17:48:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:44160 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261933AbVAIWsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 17:48:41 -0500
Date: Sun, 9 Jan 2005 14:48:40 -0800
From: Chris Wright <chrisw@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       clameter@sgi.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fixes for prep_zero_page
Message-ID: <20050109144840.W2357@build.pdx.osdl.net>
References: <20050108010629.M469@build.pdx.osdl.net> <20050109014519.412688f6.akpm@osdl.org> <Pine.LNX.4.61.0501090812220.13639@montezuma.fsmlabs.com> <20050109125212.330c34c1.akpm@osdl.org> <Pine.LNX.4.61.0501091409490.13639@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0501091409490.13639@montezuma.fsmlabs.com>; from zwane@arm.linux.org.uk on Sun, Jan 09, 2005 at 02:32:00PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zwane Mwaikambo (zwane@arm.linux.org.uk) wrote:
> On Sun, 9 Jan 2005, Andrew Morton wrote:
> > Can't we simply move the page zeroing to the very end of __alloc_pages()?
> 
> Ok, i've changed that bit to something like;

I did it the other way around, and moved kernel_map_pages to prep_new_page
so it's called before zeroing to keep that with the other prep bits
in buffered_rmqueue.  Made sense to me that kernel_map_pages is part of
prepping a new page, but this isn't my area, so I could be way off ;-)
It works for me with DEBUG_PAGEALLOC enabled.

===== mm/page_alloc.c 1.251 vs edited =====
--- 1.251/mm/page_alloc.c	2005-01-07 21:44:07 -08:00
+++ edited/mm/page_alloc.c	2005-01-09 14:36:38 -08:00
@@ -413,6 +413,7 @@ static void prep_new_page(struct page *p
 			1 << PG_checked | 1 << PG_mappedtodisk);
 	page->private = 0;
 	set_page_refs(page, order);
+	kernel_map_pages(page, 1 << order, 1);
 }
 
 /* 
@@ -823,7 +824,6 @@ nopage:
 	return NULL;
 got_pg:
 	zone_statistics(zonelist, z);
-	kernel_map_pages(page, 1 << order, 1);
 	return page;
 }
 
