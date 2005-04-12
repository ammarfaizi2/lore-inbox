Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbVDLSC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbVDLSC2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbVDLKcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:32:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:61895 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262113AbVDLKbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:02 -0400
Message-Id: <200504121030.j3CAUuSd005187@shell0.pdx.osdl.net>
Subject: [patch 019/198] meminfo: add Cached underflow check
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mort@sgi.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Martin Hicks <mort@sgi.com>

Working on some code lately I've been getting huge values for "Cached". 
The cause is that get_page_cache_size() is an approximate value, and for a
sufficiently small returned value of get_page_cache_size() the value
underflows.

Signed-off-by:  Martin Hicks <mort@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/fs/proc/proc_misc.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

diff -puN fs/proc/proc_misc.c~meminfo-add-cached-underflow-check fs/proc/proc_misc.c
--- 25/fs/proc/proc_misc.c~meminfo-add-cached-underflow-check	2005-04-12 03:21:07.910934256 -0700
+++ 25-akpm/fs/proc/proc_misc.c	2005-04-12 03:21:07.914933648 -0700
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
