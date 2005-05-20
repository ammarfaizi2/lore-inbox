Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVETKA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVETKA6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 06:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVETKA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 06:00:58 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:1811 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261409AbVETKAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 06:00:42 -0400
To: akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk
CC: linuxram@us.ibm.com, dhowells@redhat.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: [PATCH retry] namespace.c: fix race in mark_mounts_for_expiry()
Message-Id: <E1DZ4IA-0003XJ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 20 May 2005 11:59:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One more try.  I hope everybody's happy now.

This patch fixes a race found by Ram in mark_mounts_for_expiry() in
fs/namespace.c.

The bug can only be triggered with simultaneous exiting of a process
having a private namespace, and expiry of a mount from within that
namespace.  It's practically impossible to trigger, and I haven't even
tried.  But still, a bug is a bug.

The race happens when put_namespace() is called by another task, while
mark_mounts_for_expiry() is between atomic_read() and get_namespace().
In that case get_namespace() will be called on an already dead
namespace with unforeseeable results.

The solution is to use atomic_dec_and_lock() in put_namespace() as
suggested by Al Viro.

This is a mininal fix, really only serving as a reminder, that this
usage of mnt_namespace is ugly and needs to be properly cleaned up.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/include/linux/namespace.h
===================================================================
--- linux.orig/include/linux/namespace.h	2005-05-19 12:50:49.000000000 +0200
+++ linux/include/linux/namespace.h	2005-05-20 11:52:40.000000000 +0200
@@ -14,11 +14,17 @@ struct namespace {
 
 extern int copy_namespace(int, struct task_struct *);
 extern void __put_namespace(struct namespace *namespace);
+extern spinlock_t vfsmount_lock;
 
 static inline void put_namespace(struct namespace *namespace)
 {
-	if (atomic_dec_and_test(&namespace->count))
+	/* Seemingly unnecessary taking of vfsmount_lock, needed to
+	   protect atomicity of atomic_read()/get_namespace() wrt
+	   count going to zero in mark_mounts_for_expiry() */
+	if (atomic_dec_and_lock(&namespace->count, &vfsmount_lock)) {
+		spin_unlock(&vfsmount_lock);
 		__put_namespace(namespace);
+	}
 }
 
 static inline void exit_namespace(struct task_struct *p)
