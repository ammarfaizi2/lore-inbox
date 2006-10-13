Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWJMQo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWJMQo6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 12:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWJMQo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:44:58 -0400
Received: from mail.suse.de ([195.135.220.2]:10202 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751352AbWJMQoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:44:46 -0400
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>
Cc: Neil Brown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
       Anton Altaparmakov <aia21@cam.ac.uk>,
       Chris Mason <chris.mason@oracle.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <npiggin@suse.de>
Message-Id: <20061013143606.15438.18462.sendpatchset@linux.site>
In-Reply-To: <20061013143516.15438.8802.sendpatchset@linux.site>
References: <20061013143516.15438.8802.sendpatchset@linux.site>
Subject: [patch 5/6] mm: debug write deadlocks
Date: Fri, 13 Oct 2006 18:44:42 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow CONFIG_DEBUG_VM to switch off the prefaulting logic, to simulate the
difficult race where the page may be unmapped before calling copy_from_user.
Makes the race much easier to hit.

This probably needn't go upstream.

Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -1895,6 +1895,7 @@ generic_file_buffered_write(struct kiocb
 		if (maxlen > bytes)
 			maxlen = bytes;
 
+#ifndef CONFIG_DEBUG_VM
 		/*
 		 * Bring in the user page that we will copy from _first_.
 		 * Otherwise there's a nasty deadlock on copying from the
@@ -1902,6 +1903,7 @@ generic_file_buffered_write(struct kiocb
 		 * up-to-date.
 		 */
 		fault_in_pages_readable(buf, maxlen);
+#endif
 
 		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
 		if (!page) {
