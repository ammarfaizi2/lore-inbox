Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267385AbTAOXUp>; Wed, 15 Jan 2003 18:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267384AbTAOXUp>; Wed, 15 Jan 2003 18:20:45 -0500
Received: from packet.digeo.com ([12.110.80.53]:49067 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267385AbTAOXTy>;
	Wed, 15 Jan 2003 18:19:54 -0500
Date: Wed, 15 Jan 2003 15:28:44 -0800
From: Andrew Morton <akpm@digeo.com>
To: Ted Phelps <phelps@dstc.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counting bug in svc_tcp_recvfrom causes panic for TCP
 NFS
Message-Id: <20030115152844.6a66cd0f.akpm@digeo.com>
In-Reply-To: <200301152254.WAA19810@tereshkova.dstc.edu.au>
References: <200301152254.WAA19810@tereshkova.dstc.edu.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jan 2003 23:28:43.0575 (UTC) FILETIME=[D7EDC470:01C2BCED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ted Phelps <phelps@dstc.edu.au> wrote:
>
> Perhaps a better solution would be to change page_address() to be
> consistently be a function for all memory layouts.

Assuredly.  How about this?

diff -puN include/linux/mm.h~page_address-fix include/linux/mm.h
--- 25/include/linux/mm.h~page_address-fix	2003-01-15 15:23:45.000000000 -0800
+++ 25-akpm/include/linux/mm.h	2003-01-15 15:25:40.000000000 -0800
@@ -296,9 +296,11 @@ static inline void set_page_zone(struct 
 	page->flags |= zone_num << ZONE_SHIFT;
 }
 
-#define lowmem_page_address(page)					\
-	__va( ( ((page) - page_zone(page)->zone_mem_map)		\
-			+ page_zone(page)->zone_start_pfn) << PAGE_SHIFT)
+static inline void *lowmem_page_address(struct page *page)
+{
+	return __va(((page - page_zone(page)->zone_mem_map)
+		+ page_zone(page)->zone_start_pfn) << PAGE_SHIFT);
+}
 
 #if defined(CONFIG_HIGHMEM) && !defined(WANT_PAGE_VIRTUAL)
 #define HASHED_PAGE_VIRTUAL

_

