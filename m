Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315202AbSGDXu1>; Thu, 4 Jul 2002 19:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315167AbSGDXsV>; Thu, 4 Jul 2002 19:48:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44045 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315207AbSGDXqf>;
	Thu, 4 Jul 2002 19:46:35 -0400
Message-ID: <3D24E051.A222D615@zip.com.au>
Date: Thu, 04 Jul 2002 16:54:57 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 20/27] fix a writeback race
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fixes a bug in generic_writepages() and its cut-n-paste-cousin,
mpage_writepages().

The code was clearing PageDirty and then baling out if it discovered
the page was nder writeback.  Which would cause the dirty bit to be
lost.

It's a very small window, but reversing the order so PageDirty is only
cleared when we know for-sure that IO will be started fixes it up.



 fs/mpage.c          |    4 ++--
 mm/page-writeback.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- 2.5.24/fs/mpage.c~writeback-dirty-fix	Thu Jul  4 16:17:30 2002
+++ 2.5.24-akpm/fs/mpage.c	Thu Jul  4 16:22:05 2002
@@ -515,8 +515,8 @@ mpage_writepages(struct address_space *m
 
 		lock_page(page);
 
-		if (page->mapping && TestClearPageDirty(page) &&
-					!PageWriteback(page)) {
+		if (page->mapping && !PageWriteback(page) &&
+					TestClearPageDirty(page)) {
 			/* FIXME: batch this up */
 			if (!PageActive(page) && PageLRU(page)) {
 				spin_lock(&pagemap_lru_lock);
--- 2.5.24/mm/page-writeback.c~writeback-dirty-fix	Thu Jul  4 16:17:30 2002
+++ 2.5.24-akpm/mm/page-writeback.c	Thu Jul  4 16:22:05 2002
@@ -383,8 +383,8 @@ int generic_writepages(struct address_sp
 		lock_page(page);
 
 		/* It may have been removed from swapcache: check ->mapping */
-		if (page->mapping && TestClearPageDirty(page) &&
-					!PageWriteback(page)) {
+		if (page->mapping && !PageWriteback(page) &&
+					TestClearPageDirty(page)) {
 			/* FIXME: batch this up */
 			if (!PageActive(page) && PageLRU(page)) {
 				spin_lock(&pagemap_lru_lock);

-
