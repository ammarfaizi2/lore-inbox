Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWJJOVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWJJOVp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 10:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWJJOVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 10:21:45 -0400
Received: from ns.suse.de ([195.135.220.2]:62128 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750796AbWJJOVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 10:21:44 -0400
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>
Message-Id: <20061010121323.19693.99051.sendpatchset@linux.site>
In-Reply-To: <20061010121314.19693.75503.sendpatchset@linux.site>
References: <20061010121314.19693.75503.sendpatchset@linux.site>
Subject: [patch 1/5] mm: fault vs invalidate/truncate check
Date: Tue, 10 Oct 2006 16:21:41 +0200 (CEST)
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
