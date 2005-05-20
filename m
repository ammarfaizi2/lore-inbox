Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVETSVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVETSVb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 14:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVETSVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 14:21:31 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:22541 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261529AbVETSVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 14:21:18 -0400
To: akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk
CC: dhowells@redhat.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] namespace.c: fix expiring of detached mount
Message-Id: <E1DZC76-0005pN-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 20 May 2005 20:20:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug noticed by Al Viro:

   However, we still have a problem here - just what would
   happen if vfsmount is detached while we were grabbing namespace
   semaphore?  Refcount alone is not useful here - we might be held by
   whoever had detached the vfsmount.  IOW, we should check that it's
   still attached (i.e. that mnt->mnt_parent != mnt).  If it's not -
   just leave it alone, do mntput() and let whoever holds it deal with
   the sucker.  No need to put it back on lists.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/namespace.c
===================================================================
--- linux.orig/fs/namespace.c	2005-05-20 20:01:26.000000000 +0200
+++ linux/fs/namespace.c	2005-05-20 20:04:56.000000000 +0200
@@ -829,6 +829,13 @@ static void expire_mount(struct vfsmount
 {
 	spin_lock(&vfsmount_lock);
 
+	/* check if mount is still attached, if not, let whoever holds
+	   it deal with the sucker */
+	if (mnt->mnt_parent == mnt) {
+		spin_unlock(&vfsmount_lock);
+		return;
+	}
+
 	/* check that it is still dead: the count should now be 2 - as
 	 * contributed by the vfsmount parent and the mntget above */
 	if (atomic_read(&mnt->mnt_count) == 2) {
