Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVEPT5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVEPT5l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 15:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVEPT5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 15:57:40 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:52745 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261857AbVEPTz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 15:55:27 -0400
To: akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] namespace.c: fix mnt_namespace clearing
Message-Id: <E1DXlgJ-0005iU-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 16 May 2005 21:55:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch clears mnt_namespace on unmount.

Not clearing mnt_namespace has two effects:

   1) It is possible to attach a new mount to a detached mount,
      because check_mnt() returns true.

      This means, that when no other references to the detached mount
      remain, it still can't be freed.  This causes a resource leak,
      and possibly un-removable modules.

   2) If mnt_namespace is dereferenced (only in mark_mounts_for_expiry())
      after the namspace has been freed, it can cause an Oops, memory
      corruption, etc.

1) has been tested before and after the patch, 2) is only speculation.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/namespace.c
===================================================================
--- linux.orig/fs/namespace.c	2005-05-16 21:02:54.000000000 +0200
+++ linux/fs/namespace.c	2005-05-16 21:20:10.000000000 +0200
@@ -345,6 +345,7 @@ static void umount_tree(struct vfsmount 
 	for (p = mnt; p; p = next_mnt(p, mnt)) {
 		list_del(&p->mnt_list);
 		list_add(&p->mnt_list, &kill);
+		p->mnt_namespace = NULL;
 	}
 
 	while (!list_empty(&kill)) {
@@ -1449,15 +1450,8 @@ void __init mnt_init(unsigned long mempa
 
 void __put_namespace(struct namespace *namespace)
 {
-	struct vfsmount *mnt;
-
 	down_write(&namespace->sem);
 	spin_lock(&vfsmount_lock);
-
-	list_for_each_entry(mnt, &namespace->list, mnt_list) {
-		mnt->mnt_namespace = NULL;
-	}
-
 	umount_tree(namespace->root);
 	spin_unlock(&vfsmount_lock);
 	up_write(&namespace->sem);
