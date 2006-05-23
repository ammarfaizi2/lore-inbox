Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWEWQ2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWEWQ2d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 12:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWEWQ2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 12:28:33 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:49029 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750798AbWEWQ2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 12:28:32 -0400
Subject: Re: [Patch]Fix spanned_pages is not updated at a case of memory
	hot-add.
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060523170830.97E1.Y-GOTO@jp.fujitsu.com>
References: <20060523170830.97E1.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Tue, 23 May 2006 09:28:09 -0700
Message-Id: <1148401689.8658.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-23 at 17:29 +0900, Yasunori Goto wrote:
> Hello.
> 
> I found there is a bug in grow_zone_span() and grow_pgdat_span().
...
> @@ -95,16 +95,18 @@ EXPORT_SYMBOL_GPL(__add_pages);
>  static void grow_zone_span(struct zone *zone,
>  		unsigned long start_pfn, unsigned long end_pfn)
>  {
> -	unsigned long old_zone_end_pfn;
> +	unsigned long new_zone_end_pfn;
>  
>  	zone_span_writelock(zone);
>  
> -	old_zone_end_pfn = zone->zone_start_pfn + zone->spanned_pages;
> +	new_zone_end_pfn = zone->zone_start_pfn + zone->spanned_pages;

I really don't like the idea of having this variable called "new_"
something.  That implies that this is what the new end_pfn is going to
be.  The *new* one.  In reality, it is what it _might_ have been.  How
about "tmp_zone_end_pfn"?

This practice of dealing with spanned_pages is a real pain. 

I generally try to avoid max/min in code, but this struck me as possibly
being useful.  Do you find this easier to read, or your patch?

diff -puN mm/memory_hotplug.c~fix-spanned-pages mm/memory_hotplug.c
--- work/mm/memory_hotplug.c~fix-spanned-pages	2006-05-23 09:04:31.000000000 -0700
+++ work-dave/mm/memory_hotplug.c	2006-05-23 09:22:18.000000000 -0700
@@ -91,8 +91,8 @@ static void grow_zone_span(struct zone *
 	if (start_pfn < zone->zone_start_pfn)
 		zone->zone_start_pfn = start_pfn;
 
-	if (end_pfn > old_zone_end_pfn)
-		zone->spanned_pages = end_pfn - zone->zone_start_pfn;
+	zone->spanned_pages = max(old_zone_end_pfn, end_pfn) -
+				zone->zone_start_pfn);
 
 	zone_span_writeunlock(zone);
 }
@@ -106,8 +106,8 @@ static void grow_pgdat_span(struct pglis
 	if (start_pfn < pgdat->node_start_pfn)
 		pgdat->node_start_pfn = start_pfn;
 
-	if (end_pfn > old_pgdat_end_pfn)
-		pgdat->node_spanned_pages = end_pfn - pgdat->node_start_pfn;
+	pgdat->node_spanned_pages = max(old_pgdat_end_pfn, end_pfn) -
+					pgdat->node_start_pfn;
 }
 
 int online_pages(unsigned long pfn, unsigned long nr_pages)
_


-- Dave

