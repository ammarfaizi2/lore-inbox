Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbVKNV7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbVKNV7G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbVKNVzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:55:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28565 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751278AbVKNVzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:55:15 -0500
Date: Mon, 14 Nov 2005 21:54:38 GMT
Message-Id: <200511142154.jAELscQY007523@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
Fcc: outgoing
Subject: [PATCH 5/12] FS-Cache: Release page->private in failed readahead
In-Reply-To: <dhowells1132005277@warthog.cambridge.redhat.com>
References: <dhowells1132005277@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch causes read_cache_pages() to release page-private data on a
page for which add_to_page_cache() fails or the filler function fails. This
permits pages with caching references associated with them to be cleaned up.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 readahead-release-private-2614mm2.diff
 mm/readahead.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+)

diff -uNrp linux-2.6.14-mm2/mm/readahead.c linux-2.6.14-mm2-cachefs/mm/readahead.c
--- linux-2.6.14-mm2/mm/readahead.c	2005-11-14 16:18:00.000000000 +0000
+++ linux-2.6.14-mm2-cachefs/mm/readahead.c	2005-11-14 16:23:46.000000000 +0000
@@ -131,6 +131,12 @@ int read_cache_pages(struct address_spac
 		page = list_to_page(pages);
 		list_del(&page->lru);
 		if (add_to_page_cache(page, mapping, page->index, GFP_KERNEL)) {
+			if (PagePrivate(page) && mapping->a_ops->releasepage) {
+				page->mapping = mapping;
+				mapping->a_ops->releasepage(page, GFP_KERNEL);
+				page->mapping = NULL;
+			}
+				
 			page_cache_release(page);
 			continue;
 		}
@@ -143,6 +149,16 @@ int read_cache_pages(struct address_spac
 
 				victim = list_to_page(pages);
 				list_del(&victim->lru);
+
+				if (PagePrivate(victim) &&
+				    mapping->a_ops->releasepage
+				    ) {
+					victim->mapping = mapping;
+					mapping->a_ops->releasepage(
+						victim, GFP_KERNEL);
+					victim->mapping = NULL;
+				}
+
 				page_cache_release(victim);
 			}
 			break;
