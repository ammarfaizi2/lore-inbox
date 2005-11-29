Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbVK2FGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVK2FGp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 00:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVK2FGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 00:06:45 -0500
Received: from ozlabs.org ([203.10.76.45]:18344 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750765AbVK2FGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 00:06:44 -0500
Date: Tue, 29 Nov 2005 16:06:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: William Lee Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Fix crash when ptrace poking hugepage areas
Message-ID: <20051129050628.GB12498@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	William Lee Irwin <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill, does this look like the correct fix for the problem to you?  If
so, please apply Andrew.

set_page_dirty() will not cope with being handed a page * which is
part of a compound page, but not the master page in that compound
page.  This case can occur via access_process_vm() if you attempt to
write to another process's hugepage memory area using ptrace()
(causing an oops or hang).

This patch fixes the bug by first resolving the page * to the compound
page's master page.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/mm/page-writeback.c
===================================================================
--- working-2.6.orig/mm/page-writeback.c	2005-11-29 15:51:11.000000000 +1100
+++ working-2.6/mm/page-writeback.c	2005-11-29 15:52:09.000000000 +1100
@@ -660,7 +660,12 @@ EXPORT_SYMBOL(redirty_page_for_writepage
  */
 int fastcall set_page_dirty(struct page *page)
 {
-	struct address_space *mapping = page_mapping(page);
+	struct address_space *mapping;
+
+	if (unlikely(PageCompound(page)))
+		page = (struct page *)page_private(page);
+
+	mapping = page_mapping(page);
 
 	if (likely(mapping)) {
 		int (*spd)(struct page *) = mapping->a_ops->set_page_dirty;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
