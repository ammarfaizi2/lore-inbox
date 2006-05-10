Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbWEJQD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbWEJQD7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 12:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbWEJQCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 12:02:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26025 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964924AbWEJQB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 12:01:59 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 13/14] FS-Cache: Release page->private in failed readahead [try #8]
Date: Wed, 10 May 2006 17:01:48 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060510160148.9058.81776.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060510160111.9058.55026.stgit@warthog.cambridge.redhat.com>
References: <20060510160111.9058.55026.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch causes read_cache_pages() to release page-private data on a
page for which add_to_page_cache() fails or the filler function fails. This
permits pages with caching references associated with them to be cleaned up.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 mm/readahead.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 0f142a4..82deb7f 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -141,6 +141,12 @@ int read_cache_pages(struct address_spac
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
@@ -153,6 +159,16 @@ int read_cache_pages(struct address_spac
 
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

