Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266887AbUBMKK0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 05:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266892AbUBMKK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 05:10:26 -0500
Received: from kempelen.iit.bme.hu ([152.66.241.120]:24710 "EHLO
	kempelen.iit.bme.hu") by vger.kernel.org with ESMTP id S266887AbUBMKKV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 05:10:21 -0500
Date: Fri, 13 Feb 2004 11:10:18 +0100 (MET)
Message-Id: <200402131010.i1DAAI924473@kempelen.iit.bme.hu>
From: Miklos Szeredi <mszeredi@inf.bme.hu>
To: viro@parcelfarce.linux.theplanet.co.uk
CC: linux-kernel@vger.kernel.org
In-reply-to: <200402130945.i1D9jIB19896@kempelen.iit.bme.hu> (mszeredi)
Subject: Re: [PATCH] add allocation failure check to copy_namespace()
References: <200402130945.i1D9jIB19896@kempelen.iit.bme.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch was missing a kfree.  So here it goes again:

The following patch adds a missing allocation failure check to
copy_namespace() in fs/namespace.c

Miklos

--- fs/namespace.c.orig	2003-12-18 03:59:05.000000000 +0100
+++ fs/namespace.c	2004-02-13 11:04:39.000000000 +0100
@@ -820,6 +820,8 @@
 	down_write(&tsk->namespace->sem);
 	/* First pass: copy the tree topology */
 	new_ns->root = copy_tree(namespace->root, namespace->root->mnt_root);
+	if (!new_ns->root)
+		goto out_sem;
 	spin_lock(&vfsmount_lock);
 	list_add_tail(&new_ns->list, &new_ns->root->mnt_list);
 	spin_unlock(&vfsmount_lock);
@@ -863,6 +865,9 @@
 	put_namespace(namespace);
 	return 0;
 
+out_sem:
+	up_write(&tsk->namespace->sem);
+	kfree(new_ns);
 out:
 	put_namespace(namespace);
 	return -ENOMEM;
