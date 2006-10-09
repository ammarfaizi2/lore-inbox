Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932958AbWJIQMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932958AbWJIQMX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 12:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932960AbWJIQMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 12:12:22 -0400
Received: from ns.suse.de ([195.135.220.2]:7638 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932958AbWJIQMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 12:12:21 -0400
From: Nick Piggin <npiggin@suse.de>
To: Hugh Dickins <hugh@veritas.com>,
       Linux Memory Management <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@sgi.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <npiggin@suse.de>, Ingo Molnar <mingo@elte.hu>
Message-Id: <20061009140404.13840.66361.sendpatchset@linux.site>
In-Reply-To: <20061009140354.13840.71273.sendpatchset@linux.site>
References: <20061009140354.13840.71273.sendpatchset@linux.site>
Subject: [patch 1/5] mm: fault vs invalidate/truncate check
Date: Mon,  9 Oct 2006 18:12:16 +0200 (CEST)
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
