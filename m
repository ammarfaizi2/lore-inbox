Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVALWvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVALWvf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVALWub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:50:31 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:33497 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S261524AbVALWsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:48:18 -0500
Date: Wed, 12 Jan 2005 23:48:09 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc1: mark-page-accessed in filemap.c not quite right
Message-ID: <20050112224807.GA24154@cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-NCC-RegID: nl.cistron
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just discovered there's a thinko in the mark-page-accessed
change in do_generic_mapping_read() in 2.6.11-rc1. ra.prev_page
is compared to index to see if we read from this page before -
except that prev_page is actually set to the recent page or
even a page in front of the current page.

So we should store ra.prev_page in a seperate variable at the
start of do_generic_mapping_read().

This patch does just that:

--- linux-2.6.11-rc1/mm/filemap.c.ORIG	2005-01-12 05:02:10.000000000 +0100
+++ linux-2.6.11-rc1/mm/filemap.c	2005-01-12 23:06:23.643039416 +0100
@@ -693,6 +693,7 @@
 	unsigned long offset;
 	unsigned long req_size;
 	unsigned long next_index;
+	unsigned long prev_index;
 	loff_t isize;
 	struct page *cached_page;
 	int error;
@@ -701,6 +702,7 @@
 	cached_page = NULL;
 	index = *ppos >> PAGE_CACHE_SHIFT;
 	next_index = index;
+	prev_index = ra.prev_page;
 	req_size = (desc->count + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 	offset = *ppos & ~PAGE_CACHE_MASK;
 
@@ -754,8 +756,9 @@
 		 * When (part of) the same page is read multiple times
 		 * in succession, only mark it as accessed the first time.
 		 */
-		if (ra.prev_page != index)
+		if (prev_index != index)
 			mark_page_accessed(page);
+		prev_index = index;
 
 		/*
 		 * Ok, we have the page, and it's up-to-date, so

