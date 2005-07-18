Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVGRHS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVGRHS7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 03:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVGRHJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 03:09:56 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:29391 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261571AbVGRHHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 03:07:14 -0400
Message-Id: <20050718070702.002044000@localhost>
References: <20050718065311.210001000@localhost>
Date: Sun, 17 Jul 2005 23:53:17 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       mike@waychison.com, Miklos Szeredi <miklos@szeredi.hu>,
       bfields@fieldses.org, Andrew Morton <akpm@osdl.org>,
       penberg@cs.helsinki.fi
Subject: [RFC-2 PATCH 6/8] shared subtree
Content-Type: text/x-patch; name=namespace.patch
Content-Disposition: inline; filename=namespace.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds ability to clone a namespace that has shared/private/slave/unclone
subtrees in it.

RP


Signed by Ram Pai (linuxram@us.ibm.com)

 fs/namespace.c |    9 +++++++++
 1 files changed, 9 insertions(+)

Index: 2.6.12.work1/fs/namespace.c
===================================================================
--- 2.6.12.work1.orig/fs/namespace.c
+++ 2.6.12.work1/fs/namespace.c
@@ -1763,6 +1763,13 @@ int copy_namespace(int flags, struct tas
 	q = new_ns->root;
 	while (p) {
 		q->mnt_namespace = new_ns;
+
+		if (IS_MNT_SHARED(q))
+			pnode_add_member_mnt(q->mnt_pnode, q);
+		else if (IS_MNT_SLAVE(q))
+			pnode_add_slave_mnt(q->mnt_pnode, q);
+		put_pnode(q->mnt_pnode);
+
 		if (fs) {
 			if (p == fs->rootmnt) {
 				rootmnt = p;
@@ -2129,6 +2136,8 @@ void __put_namespace(struct namespace *n
 	spin_lock(&vfsmount_lock);
 
 	list_for_each_entry(mnt, &namespace->list, mnt_list) {
+		if (mnt->mnt_pnode)
+			pnode_disassociate_mnt(mnt);
 		mnt->mnt_namespace = NULL;
 	}
 
