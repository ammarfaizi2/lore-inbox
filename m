Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVDDPLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVDDPLM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 11:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVDDPLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 11:11:12 -0400
Received: from galileo.bork.org ([134.117.69.57]:22450 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S261248AbVDDPLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 11:11:06 -0400
Date: Mon, 4 Apr 2005 11:11:05 -0400
From: Martin Hicks <mort@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] meminfo: add Cached underflow check
Message-ID: <20050404151105.GG10693@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This patch was generated against 2.6.12-rc1

Working on some code lately I've been getting huge values
for "Cached".  The cause is that get_page_cache_size() is an
approximate value, and for a sufficiently small returned value
of get_page_cache_size() the value underflows.

Signed-off-by:  Martin Hicks <mort@sgi.com>

 proc_misc.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletion(-)

Index: linux-2.6.11.cached-limit/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.11.cached-limit.orig/fs/proc/proc_misc.c	2005-03-31 11:36:46.000000000 -0800
+++ linux-2.6.11.cached-limit/fs/proc/proc_misc.c	2005-03-31 11:37:12.000000000 -0800
@@ -126,6 +126,7 @@ static int meminfo_read_proc(char *page,
 	unsigned long committed;
 	unsigned long allowed;
 	struct vmalloc_info vmi;
+	unsigned long cached;
 
 	get_page_state(&ps);
 	get_zone_counts(&active, &inactive, &free);
@@ -140,6 +141,12 @@ static int meminfo_read_proc(char *page,
 	allowed = ((totalram_pages - hugetlb_total_pages())
 		* sysctl_overcommit_ratio / 100) + total_swap_pages;
 
+	cached = get_page_cache_size();
+	if (total_swapcache_pages+i.bufferram < cached)
+		cached -= total_swapcache_pages + i.bufferram;
+	else
+		cached = 0;
+
 	get_vmalloc_info(&vmi);
 
 	/*
@@ -172,7 +179,7 @@ static int meminfo_read_proc(char *page,
 		K(i.totalram),
 		K(i.freeram),
 		K(i.bufferram),
-		K(get_page_cache_size()-total_swapcache_pages-i.bufferram),
+		K(cached),
 		K(total_swapcache_pages),
 		K(active),
 		K(inactive),
