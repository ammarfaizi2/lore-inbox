Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269334AbTHESjp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 14:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268702AbTHESjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 14:39:45 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:8838 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S269334AbTHESjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 14:39:44 -0400
Date: Tue, 5 Aug 2003 19:41:19 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
cc: Arjan van de Ven <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] revert to static = {0} + comment
In-Reply-To: <1060099637.5308.7.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.44.0308051931380.1827-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please revert to static zero initialization of a const: when thus
initialized it's linked into a readonly cacheline shared between cpus;
otherwise it's linked into bss, likely to be in a dirty cacheline
bouncing between cpus.

On 5 Aug 2003, Arjan van de Ven wrote:
> how about adding a big fat comment here that says this?
> Otherwise this keeps happening all the time...
and others concurred.

Okay, by popular request, here it is with a small thin comment.

--- 2.6.0-test2-bk/mm/shmem.c	Tue Aug  5 15:57:31 2003
+++ linux/mm/shmem.c	Tue Aug  5 19:29:16 2003
@@ -296,7 +296,8 @@
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	struct page *page = NULL;
 	swp_entry_t *entry;
-	static const swp_entry_t unswapped;
+	static const swp_entry_t unswapped = {0};
+	/* = {0} to go in readonly data, to avoid bss cacheline bounce */
 
 	if (sgp != SGP_WRITE &&
 	    ((loff_t) index << PAGE_CACHE_SHIFT) >= i_size_read(inode))

