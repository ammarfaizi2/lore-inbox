Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263591AbUESAP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbUESAP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 20:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbUESAP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 20:15:27 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:24529
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263591AbUESAPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 20:15:21 -0400
Date: Wed, 19 May 2004 02:15:20 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: invalidate_inode_pages2
Message-ID: <20040519001520.GO3044@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something broke in invalidate_inode_pages2 between 2.4 and 2.6, this
causes malfunctions with mapped pages in 2.6.

I guess the below untested one liner should be enough to fix it. The
only single point of invalidate_inode_pages2, is to invalidate _mapped_
pages too. Otherwise we could as well use invalidate_inode_pages.
Clearly the dirty bit doesn't mean invalidate, invalidate primarly means
clearing the uptodate bitflag.

--- sles/mm/truncate.c.~1~	2004-05-18 19:24:40.000000000 +0200
+++ sles/mm/truncate.c	2004-05-19 02:09:28.311781864 +0200
@@ -260,9 +260,10 @@ void invalidate_inode_pages2(struct addr
 			if (page->mapping == mapping) {	/* truncate race? */
 				wait_on_page_writeback(page);
 				next = page->index + 1;
-				if (page_mapped(page))
+				if (page_mapped(page)) {
+					ClearPageUptodate(page);
 					clear_page_dirty(page);
-				else
+				} else
 					invalidate_complete_page(mapping, page);
 			}
 			unlock_page(page);
