Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262364AbVEYPwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbVEYPwV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 11:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbVEYPwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 11:52:20 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:42509 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261417AbVEYPwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 11:52:15 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] dcookies.c: use proper refcounting functions
Message-Id: <E1DayAn-0005rQ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 25 May 2005 17:51:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dcookies shouldn't play with the internals of dentry and vfsmnt
refcounting.  It defeats grepping, and is prone to break if
implementation details change.

In addition the function doesn't even seem to be performance critical:
it calls kmem_cache_alloc().

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/dcookies.c
===================================================================
--- linux.orig/fs/dcookies.c	2004-12-24 22:33:48.000000000 +0100
+++ linux/fs/dcookies.c	2005-05-25 17:14:08.000000000 +0200
@@ -94,12 +94,10 @@ static struct dcookie_struct * alloc_dco
 	if (!dcs)
 		return NULL;
 
-	atomic_inc(&dentry->d_count);
-	atomic_inc(&vfsmnt->mnt_count);
 	dentry->d_cookie = dcs;
 
-	dcs->dentry = dentry;
-	dcs->vfsmnt = vfsmnt;
+	dcs->dentry = dget(dentry);
+	dcs->vfsmnt = mntget(vfsmnt);
 	hash_dcookie(dcs);
 
 	return dcs;
