Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbUJXPkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbUJXPkR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 11:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUJXPkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 11:40:17 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:50951 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261450AbUJXPkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 11:40:04 -0400
Date: Sun, 24 Oct 2004 16:39:42 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Mikael Starvik <mikael.starvik@axis.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] anon cris align address_space
Message-ID: <Pine.LNX.4.44.0410241638190.12023-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CRIS does not demand alignment, so PageAnon's PAGE_MAPPING_ANON bit got
mixed up with the low bit of the struct address_space *mapping pointer.

Patch based on that from Mikael Starvik, but moved the alignment to the
declaration of struct address_space itself, and align to sizeof(long)
so it's well-aligned on all architectures.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
 include/linux/fs.h |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

--- 2.6.10-rc1/include/linux/fs.h	2004-10-23 12:44:10.000000000 +0100
+++ linux/include/linux/fs.h	2004-10-23 20:43:24.000000000 +0100
@@ -348,7 +348,12 @@ struct address_space {
 	spinlock_t		private_lock;	/* for use by the address_space */
 	struct list_head	private_list;	/* ditto */
 	struct address_space	*assoc_mapping;	/* ditto */
-};
+} __attribute__((aligned(sizeof(long))));
+	/*
+	 * On most architectures that alignment is already the case; but
+	 * must be enforced here for CRIS, to let the least signficant bit
+	 * of struct page's "mapping" pointer be used for PAGE_MAPPING_ANON.
+	 */
 
 struct block_device {
 	dev_t			bd_dev;  /* not a kdev_t - it's a search key */

