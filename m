Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318212AbSGQFSt>; Wed, 17 Jul 2002 01:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318213AbSGQFSs>; Wed, 17 Jul 2002 01:18:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11788 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318212AbSGQFSj>;
	Wed, 17 Jul 2002 01:18:39 -0400
Message-ID: <3D3500B6.741ADEDD@zip.com.au>
Date: Tue, 16 Jul 2002 22:29:26 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 2/13] leave truncate's orphaned pages on the LRU
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fix to the page reclaim code from Rik.

Anonymous pages which have buffers arise when
truncate_complete_page()'s call to ->releasepage() failed.  Those pages
may still be mapped into process address spaces.

We should not remove them from the LRU, because that makes them
unswappable and they hang around until process exit.



 vmscan.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

--- 2.5.26/mm/vmscan.c~rmap-lru-fix	Tue Jul 16 21:46:28 2002
+++ 2.5.26-akpm/mm/vmscan.c	Tue Jul 16 21:59:41 2002
@@ -235,19 +235,11 @@ shrink_cache(int nr_pages, zone_t *class
 
 			if (try_to_release_page(page, gfp_mask)) {
 				if (!mapping) {
-					/*
-					 * We must not allow an anon page
-					 * with no buffers to be visible on
-					 * the LRU, so we unlock the page after
-					 * taking the lru lock
-					 */
-					spin_lock(&pagemap_lru_lock);
-					unlock_page(page);
-					__lru_cache_del(page);
-
 					/* effectively free the page here */
+					unlock_page(page);
 					page_cache_release(page);
 
+					spin_lock(&pagemap_lru_lock);
 					if (--nr_pages)
 						continue;
 					break;

.
