Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVDDWN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVDDWN4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 18:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVDDWNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 18:13:01 -0400
Received: from fire.osdl.org ([65.172.181.4]:55953 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261373AbVDDWKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 18:10:42 -0400
Date: Mon, 4 Apr 2005 15:10:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Hicks <mort@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] meminfo: add Cached underflow check
Message-Id: <20050404151049.53a30133.akpm@osdl.org>
In-Reply-To: <20050404151105.GG10693@localhost>
References: <20050404151105.GG10693@localhost>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Hicks <mort@sgi.com> wrote:
>
> Working on some code lately I've been getting huge values
> for "Cached".  The cause is that get_page_cache_size() is an
> approximate value, and for a sufficiently small returned value
> of get_page_cache_size() the value underflows.

OK..

I think I'd prefer to do it this way - it's simpler and the original patch
had a teeny race wrt changes in total_swapcache_pages.


diff -puN fs/proc/proc_misc.c~meminfo-add-cached-underflow-check fs/proc/proc_misc.c
--- 25/fs/proc/proc_misc.c~meminfo-add-cached-underflow-check	Mon Apr  4 15:06:38 2005
+++ 25-akpm/fs/proc/proc_misc.c	Mon Apr  4 15:10:24 2005
@@ -126,6 +126,7 @@ static int meminfo_read_proc(char *page,
 	unsigned long committed;
 	unsigned long allowed;
 	struct vmalloc_info vmi;
+	long cached;
 
 	get_page_state(&ps);
 	get_zone_counts(&active, &inactive, &free);
@@ -140,6 +141,10 @@ static int meminfo_read_proc(char *page,
 	allowed = ((totalram_pages - hugetlb_total_pages())
 		* sysctl_overcommit_ratio / 100) + total_swap_pages;
 
+	cached = get_page_cache_size() - total_swapcache_pages - i.bufferram;
+	if (cached < 0)
+		cached = 0;
+
 	get_vmalloc_info(&vmi);
 
 	/*
@@ -172,7 +177,7 @@ static int meminfo_read_proc(char *page,
 		K(i.totalram),
 		K(i.freeram),
 		K(i.bufferram),
-		K(get_page_cache_size()-total_swapcache_pages-i.bufferram),
+		K(cached),
 		K(total_swapcache_pages),
 		K(active),
 		K(inactive),
_

