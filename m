Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWFPSnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWFPSnw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 14:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWFPSnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 14:43:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:36994 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751378AbWFPSns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 14:43:48 -0400
Message-Id: <20060616104322.204073000@hasse.suse.de>
References: <20060616104321.778718000@hasse.suse.de>
User-Agent: quilt/0.44-17
Date: Fri, 16 Jun 2006 12:43:23 +0200
From: jblunck@suse.de
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       dgc@sgi.com, balbir@in.ibm.com, neilb@suse.de
Subject: [PATCH 2/5] vfs: d_genocide() doesnt add dentries to unused list
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

