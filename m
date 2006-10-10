Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWJJRP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWJJRP6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWJJRPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:15:36 -0400
Received: from mail.kroah.org ([69.55.234.183]:50569 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964796AbWJJRPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:15:34 -0400
Date: Tue, 10 Oct 2006 10:14:51 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, hugh@veritas.com,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 07/19] invalidate_complete_page() race fix
Message-ID: <20061010171451.GH6339@kroah.com>
References: <20061010165621.394703368@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="invalidate_complete_page-race-fix.patch"
In-Reply-To: <20061010171350.GA6339@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Andrew Morton <akpm@osdl.org>

If a CPU faults this page into pagetables after invalidate_mapping_pages()
checked page_mapped(), invalidate_complete_page() will still proceed to remove
the page from pagecache.  This leaves the page-faulting process with a
detached page.  If it was MAP_SHARED then file data loss will ensue.

Fix that up by checking the page's refcount after taking tree_lock.

Cc: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hugh Dickins <hugh@veritas.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 mm/truncate.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- linux-2.6.17.13.orig/mm/truncate.c
+++ linux-2.6.17.13/mm/truncate.c
@@ -68,10 +68,10 @@ invalidate_complete_page(struct address_
 		return 0;
 
 	write_lock_irq(&mapping->tree_lock);
-	if (PageDirty(page)) {
-		write_unlock_irq(&mapping->tree_lock);
-		return 0;
-	}
+	if (PageDirty(page))
+		goto failed;
+	if (page_count(page) != 2)	/* caller's ref + pagecache ref */
+		goto failed;
 
 	BUG_ON(PagePrivate(page));
 	__remove_from_page_cache(page);
@@ -79,6 +79,9 @@ invalidate_complete_page(struct address_
 	ClearPageUptodate(page);
 	page_cache_release(page);	/* pagecache ref */
 	return 1;
+failed:
+	write_unlock_irq(&mapping->tree_lock);
+	return 0;
 }
 
 /**

--
