Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbWFAKCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbWFAKCu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 06:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbWFAKCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 06:02:49 -0400
Received: from ns.suse.de ([195.135.220.2]:53903 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964909AbWFAKCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 06:02:47 -0400
Message-Id: <20060601100134.880064000@hasse.suse.de>
References: <20060601095125.773684000@hasse.suse.de>
User-Agent: quilt/0.44-16
Date: Thu, 01 Jun 2006 11:51:27 +0200
From: jblunck@suse.de
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       dgc@sgi.com, balbir@in.ibm.com
Subject: [patch 2/5] vfs: d_genocide() doesnt add dentries to unused list
Content-Disposition: inline; filename=patches.jbl/vfs-d_genocide-fix.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Calling d_genocide() is only lowering the reference count of the dentries but
doesn't add them to the unused list.

Signed-off-by: Jan Blunck <jblunck@suse.de>
---
 fs/dcache.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

Index: work-2.6/fs/dcache.c
===================================================================
--- work-2.6.orig/fs/dcache.c
+++ work-2.6/fs/dcache.c
@@ -1612,11 +1612,25 @@ resume:
 			this_parent = dentry;
 			goto repeat;
 		}
-		atomic_dec(&dentry->d_count);
+		if (!list_empty(&dentry->d_lru)) {
+			dentry_stat.nr_unused--;
+			list_del_init(&dentry->d_lru);
+		}
+		if (atomic_dec_and_test(&dentry->d_count)) {
+			list_add(&dentry->d_lru, dentry_unused.prev);
+			dentry_stat.nr_unused++;
+		}
 	}
 	if (this_parent != root) {
 		next = this_parent->d_u.d_child.next;
-		atomic_dec(&this_parent->d_count);
+		if (!list_empty(&this_parent->d_lru)) {
+			dentry_stat.nr_unused--;
+			list_del_init(&this_parent->d_lru);
+		}
+		if (atomic_dec_and_test(&this_parent->d_count)) {
+			list_add(&this_parent->d_lru, dentry_unused.prev);
+			dentry_stat.nr_unused++;
+		}
 		this_parent = this_parent->d_parent;
 		goto resume;
 	}

