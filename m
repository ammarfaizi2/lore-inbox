Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWEQWMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWEQWMj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWEQWMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:12:14 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:32387 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751244AbWEQWMF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:12:05 -0400
Message-Id: <20060517221414.234821000@sous-sol.org>
References: <20060517221312.227391000@sous-sol.org>
Date: Wed, 17 May 2006 00:00:20 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Christoph Lameter <clameter@sgi.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 20/22] [PATCH] page migration: Fix fallback behavior for dirty pages
Content-Disposition: inline; filename=page-migration-Fix-fallback-behavior-for-dirty-pages.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Currently we check PageDirty() in order to make the decision to swap out
the page.  However, the dirty information may be only be contained in the
ptes pointing to the page.  We need to first unmap the ptes before checking
for PageDirty().  If unmap is successful then the page count of the page
will also be decreased so that pageout() works properly.

This is a fix necessary for 2.6.17.  Without this fix we may migrate dirty
pages for filesystems without migration functions.  Filesystems may keep
pointers to dirty pages.  Migration of dirty pages can result in the
filesystem keeping pointers to freed pages.

Unmapping is currently not be separated out from removing all the
references to a page and moving the mapping.  Therefore try_to_unmap will
be called again in migrate_page() if the writeout is successful.  However,
it wont do anything since the ptes are already removed.

The coming updates to the page migration code will restructure the code
so that this is no longer necessary.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 mm/vmscan.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- linux-2.6.16.16.orig/mm/vmscan.c
+++ linux-2.6.16.16/mm/vmscan.c
@@ -949,6 +949,17 @@ redo:
 			goto unlock_both;
                 }
 
+		/* Make sure the dirty bit is up to date */
+		if (try_to_unmap(page, 1) == SWAP_FAIL) {
+			rc = -EPERM;
+			goto unlock_both;
+		}
+
+		if (page_mapcount(page)) {
+			rc = -EAGAIN;
+			goto unlock_both;
+		}
+
 		/*
 		 * Default handling if a filesystem does not provide
 		 * a migration function. We can only migrate clean

--
