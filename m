Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVAaHp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVAaHp1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 02:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVAaHoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:44:20 -0500
Received: from waste.org ([216.27.176.166]:59628 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261949AbVAaHfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:35:01 -0500
Date: Mon, 31 Jan 2005 01:35:00 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.com>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3.416337461@selenic.com>
Message-Id: <4.416337461@selenic.com>
Subject: [PATCH 3/8] lib/sort: Replace qsort in NFS ACL code
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Switch NFS ACLs to lib/sort

Index: mm2/fs/nfsacl.c
===================================================================
--- mm2.orig/fs/nfsacl.c	2005-01-30 21:26:27.000000000 -0800
+++ mm2/fs/nfsacl.c	2005-01-30 22:06:43.000000000 -0800
@@ -25,6 +25,7 @@
 #include <linux/sunrpc/xdr.h>
 #include <linux/nfsacl.h>
 #include <linux/nfs3.h>
+#include <linux/sort.h>
 
 MODULE_LICENSE("GPL");
 
@@ -163,9 +164,10 @@
 	return 0;
 }
 
-static int
-cmp_acl_entry(const struct posix_acl_entry *a, const struct posix_acl_entry *b)
+static int cmp_acl_entry(const void *x, const void *y)
 {
+	const struct posix_acl_entry *a = x, *b = y;
+
 	if (a->e_tag != b->e_tag)
 		return a->e_tag - b->e_tag;
 	else if (a->e_id > b->e_id)
@@ -188,8 +190,8 @@
 	if (!acl)
 		return 0;
 
-	qsort(acl->a_entries, acl->a_count, sizeof(struct posix_acl_entry),
-	      (int(*)(const void *,const void *))cmp_acl_entry);
+	sort(acl->a_entries, acl->a_count, sizeof(struct posix_acl_entry),
+	     cmp_acl_entry, 0);
 
 	/* Clear undefined identifier fields and find the ACL_GROUP_OBJ
 	   and ACL_MASK entries. */
Index: mm2/fs/Kconfig
===================================================================
--- mm2.orig/fs/Kconfig	2005-01-30 21:32:26.000000000 -0800
+++ mm2/fs/Kconfig	2005-01-30 22:07:10.000000000 -0800
@@ -1428,7 +1428,6 @@
 config NFS_ACL
 	bool "NFS_ACL protocol extension"
 	depends on NFS_V3
-	select QSORT
 	select FS_POSIX_ACL
 	help
 	  Implement the NFS_ACL protocol extension for manipulating POSIX
@@ -1513,7 +1512,6 @@
 config NFSD_ACL
 	bool "NFS_ACL protocol extension"
 	depends on NFSD_V3
-	select QSORT
 	help
 	  Implement the NFS_ACL protocol extension for manipulating POSIX
 	  Access Control Lists on exported file systems.  The clients must
