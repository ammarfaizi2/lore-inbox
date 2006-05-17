Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWEQWQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWEQWQp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWEQWQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:16:05 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:128 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751252AbWEQWMJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:12:09 -0400
Message-Id: <20060517221413.495583000@sous-sol.org>
References: <20060517221312.227391000@sous-sol.org>
Date: Wed, 17 May 2006 00:00:19 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Lee Schermerhorn <Lee.Schermerhorn@hp.com>,
       Lee Schermerhorn <lee.schermerhorn@hp.com>,
       Christoph Lameter <clameter@sgi.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 19/22] [PATCH] add migratepage address space op to shmem
Content-Disposition: inline; filename=add-migratepage-address-space-op-to-shmem.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Basic problem: pages of a shared memory segment can only be migrated once.

In 2.6.16 through 2.6.17-rc1, shared memory mappings do not have a
migratepage address space op.  Therefore, migrate_pages() falls back to
default processing.  In this path, it will try to pageout() dirty pages.
Once a shared memory page has been migrated it becomes dirty, so
migrate_pages() will try to page it out.  However, because the page count
is 3 [cache + current + pte], pageout() will return PAGE_KEEP because
is_page_cache_freeable() returns false.  This will abort all subsequent
migrations.

This patch adds a migratepage address space op to shared memory segments to
avoid taking the default path.  We use the "migrate_page()" function
because it knows how to migrate dirty pages.  This allows shared memory
segment pages to migrate, subject to other conditions such as # pte's
referencing the page [page_mapcount(page)], when requested.

I think this is safe.  If we're migrating a shared memory page, then we
found the page via a page table, so it must be in memory.

Can be verified with memtoy and the shmem-mbind-test script, both
available at:  http://free.linux.hp.com/~lts/Tools/

Signed-off-by: Lee Schermerhorn <lee.schermerhorn@hp.com>
Acked-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 mm/shmem.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.16.16.orig/mm/shmem.c
+++ linux-2.6.16.16/mm/shmem.c
@@ -2172,6 +2172,7 @@ static struct address_space_operations s
 	.prepare_write	= shmem_prepare_write,
 	.commit_write	= simple_commit_write,
 #endif
+	.migratepage	= migrate_page,
 };
 
 static struct file_operations shmem_file_operations = {

--
