Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263888AbTJOSSs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbTJOSSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:18:48 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:3227 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S263888AbTJOSSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:18:45 -0400
Date: Wed, 15 Oct 2003 19:18:40 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 1/7 LTP ENAMETOOLONG
Message-ID: <Pine.LNX.4.44.0310151915590.5350-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of 2+3+2 tmpfs patches, based on 2.6.0-test7-mm1, total diffstat:

 fs/hugetlbfs/inode.c |   20 +++++++++++++---
 fs/libfs.c           |    2 +
 fs/ramfs/inode.c     |    7 +++++
 mm/shmem.c           |   63 +++++++++++++++++++++++++++++++++++++++++----------
 4 files changed, 77 insertions(+), 15 deletions(-)

[PATCH] tmpfs 1/7 LTP ENAMETOOLONG

LTP tests the filesystem on /tmp: many failures when tmpfs because
simple_lookup forgot to reject filenames longer than the NAME_MAX
tmpfs declares in its statfs.  This also fixes ramfs and hugetlbfs.

--- 2.6.0-test7-mm1/fs/libfs.c	2003-10-08 20:24:55.000000000 +0100
+++ tmpfs1/fs/libfs.c	2003-10-15 15:38:30.349562896 +0100
@@ -32,6 +32,8 @@
 
 struct dentry *simple_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
+	if (dentry->d_name.len > NAME_MAX)
+		return ERR_PTR(-ENAMETOOLONG);
 	d_add(dentry, NULL);
 	return NULL;
 }

