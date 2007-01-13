Return-Path: <linux-kernel-owner+w=401wt.eu-S1161209AbXAMDZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161209AbXAMDZn (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 22:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161227AbXAMDZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 22:25:39 -0500
Received: from cantor.suse.de ([195.135.220.2]:49574 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161209AbXAMDZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 22:25:05 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Filesystems <linux-fsdevel@vger.kernel.org>,
       Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>
Message-Id: <20070113011246.9449.54835.sendpatchset@linux.site>
In-Reply-To: <20070113011159.9449.4327.sendpatchset@linux.site>
References: <20070113011159.9449.4327.sendpatchset@linux.site>
Subject: [patch 5/10] mm: debug write deadlocks
Date: Sat, 13 Jan 2007 04:25:02 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow CONFIG_DEBUG_VM to switch off the prefaulting logic, to simulate the
difficult race where the page may be unmapped before calling copy_from_user.
Makes the race much easier to hit.

This is useful for demonstration and testing purposes, but is removed in a
subsequent patch.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -1894,6 +1894,7 @@ generic_file_buffered_write(struct kiocb
 		if (maxlen > bytes)
 			maxlen = bytes;
 
+#ifndef CONFIG_DEBUG_VM
 		/*
 		 * Bring in the user page that we will copy from _first_.
 		 * Otherwise there's a nasty deadlock on copying from the
@@ -1901,6 +1902,7 @@ generic_file_buffered_write(struct kiocb
 		 * up-to-date.
 		 */
 		fault_in_pages_readable(buf, maxlen);
+#endif
 
 		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
 		if (!page) {
