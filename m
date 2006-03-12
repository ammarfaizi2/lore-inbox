Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWCLXyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWCLXyq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 18:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWCLXyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 18:54:44 -0500
Received: from ns2.suse.de ([195.135.220.15]:32187 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932262AbWCLXyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 18:54:31 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 13 Mar 2006 10:53:22 +1100
Message-Id: <1060312235322.15954@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 002 of 4] Honour AOP_TRUNCATE_PAGE returns in page_symlink
References: <20060313104910.15881.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As prepare_write, commit_write and readpage are allowed to return
AOP_TRUNCATE_PAGE, page_symlink should respond to them.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/namei.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff ./fs/namei.c~current~ ./fs/namei.c
--- ./fs/namei.c~current~	2006-03-09 17:29:35.000000000 +1100
+++ ./fs/namei.c	2006-03-13 10:43:40.000000000 +1100
@@ -2628,19 +2628,31 @@ void page_put_link(struct dentry *dentry
 int page_symlink(struct inode *inode, const char *symname, int len)
 {
 	struct address_space *mapping = inode->i_mapping;
-	struct page *page = grab_cache_page(mapping, 0);
+	struct page *page;
 	int err = -ENOMEM;
 	char *kaddr;
 
+ retry:
+	page = grab_cache_page(mapping, 0);
 	if (!page)
 		goto fail;
 	err = mapping->a_ops->prepare_write(NULL, page, 0, len-1);
+	if (err == AOP_TRUNCATED_PAGE) {
+		page_cache_release(page);
+		goto retry;
+	}
 	if (err)
 		goto fail_map;
 	kaddr = kmap_atomic(page, KM_USER0);
 	memcpy(kaddr, symname, len-1);
 	kunmap_atomic(kaddr, KM_USER0);
-	mapping->a_ops->commit_write(NULL, page, 0, len-1);
+	err = mapping->a_ops->commit_write(NULL, page, 0, len-1);
+	if (err == AOP_TRUNCATED_PAGE) {
+		page_cache_release(page);
+		goto retry;
+	}
+	if (err)
+		goto fail_map;
 	/*
 	 * Notice that we are _not_ going to block here - end of page is
 	 * unmapped, so this will only try to map the rest of page, see
@@ -2650,7 +2662,8 @@ int page_symlink(struct inode *inode, co
 	 */
 	if (!PageUptodate(page)) {
 		err = mapping->a_ops->readpage(NULL, page);
-		wait_on_page_locked(page);
+		if (err != AOP_TRUNCATED_PAGE)
+			wait_on_page_locked(page);
 	} else {
 		unlock_page(page);
 	}
