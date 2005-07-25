Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVGYXQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVGYXQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 19:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVGYW7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 18:59:36 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:59630 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261249AbVGYW7U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 18:59:20 -0400
Message-Id: <20050725225908.621989000@localhost>
References: <20050725224417.501066000@localhost>
Date: Mon, 25 Jul 2005 15:44:23 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: akpm@osdl.org, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Avantika Mathur <mathurav@us.ibm.com>, Mike Waychison <mike@waychison.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

, miklos@szeredi.hu, Janak Desai <janak@us.ibm.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] shared subtree
Content-Type: text/x-patch; name=namespace.patch
Content-Disposition: inline; filename=namespace.patch

Adds ability to clone a namespace that has shared/private/slave/unclone
subtrees in it.

RP


Signed by Ram Pai (linuxram@us.ibm.com)

 fs/namespace.c |    9 +++++++++
 1 files changed, 9 insertions(+)

Index: 2.6.12-rc6.work1/fs/namespace.c
===================================================================
--- 2.6.12-rc6.work1.orig/fs/namespace.c
+++ 2.6.12-rc6.work1/fs/namespace.c
@@ -1894,6 +1894,13 @@ int copy_namespace(int flags, struct tas
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
@@ -2271,6 +2278,8 @@ void __put_namespace(struct namespace *n
 	spin_lock(&vfsmount_lock);
 
 	list_for_each_entry(mnt, &namespace->list, mnt_list) {
+		if (mnt->mnt_pnode)
+			pnode_disassociate_mnt(mnt);
 		mnt->mnt_namespace = NULL;
 	}
 
