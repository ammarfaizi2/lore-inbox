Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751774AbWJGNGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbWJGNGj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 09:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbWJGNG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 09:06:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:34994 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751774AbWJGNGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 09:06:16 -0400
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>
Message-Id: <20061007105833.14024.33775.sendpatchset@linux.site>
In-Reply-To: <20061007105758.14024.70048.sendpatchset@linux.site>
References: <20061007105758.14024.70048.sendpatchset@linux.site>
Subject: [patch 1/3] mm: fault vs invalidate/truncate check
Date: Sat,  7 Oct 2006 15:06:12 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a bugcheck for Andrea's pagefault vs invalidate race. This is triggerable
for both linear and nonlinear pages with a userspace test harness (using
direct IO and truncate, respectively).

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -120,6 +120,8 @@ void __remove_from_page_cache(struct pag
 	page->mapping = NULL;
 	mapping->nrpages--;
 	__dec_zone_page_state(page, NR_FILE_PAGES);
+
+	BUG_ON(page_mapped(page));
 }
 
 void remove_from_page_cache(struct page *page)
