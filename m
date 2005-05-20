Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVETImm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVETImm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 04:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVETImm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 04:42:42 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:1542 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261377AbVETImb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 04:42:31 -0400
To: akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk
CC: linuxram@us.ibm.com, dhowells@redhat.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: [PATCH] namespace.c: fix race in mark_mounts_for_expiry()
Message-Id: <E1DZ34O-0003RL-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 20 May 2005 10:41:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

The solution is to make the atomic_read() and the get_namespace() into
a single atomic operation.  The patch does this in a fairly ugly way
(see comment above fix), which should be safe regardless.

This is a mininal fix, really only serving as a reminder, that this
usage of mnt_namespace is ugly and needs to be properly cleaned up.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/namespace.c
===================================================================
--- linux.orig/fs/namespace.c	2005-05-19 15:48:21.000000000 +0200
+++ linux/fs/namespace.c	2005-05-19 16:31:35.000000000 +0200
@@ -869,9 +869,24 @@ void mark_mounts_for_expiry(struct list_
 		/* don't do anything if the namespace is dead - all the
 		 * vfsmounts from it are going away anyway */
 		namespace = mnt->mnt_namespace;
-		if (!namespace || atomic_read(&namespace->count) <= 0)
+		if (!namespace)
 			continue;
-		get_namespace(namespace);
+		
+		/* Hack hack.  Need to get reference to namespace
+		   while ensuring that count is not already zero.
+		   There's no such atomic operation, so do the check
+		   _after_ increasing count.  If count was zero,
+		   decrease it back again, so a later instance of this
+		   will find it zero.
+
+		   This is OK, since all other uses of namespace have
+		   proper reference, so when count is zero, nobody
+		   else cares.  Race with itself is avoided by holding
+		   vfsmount_lock. */
+		if (atomic_add_return(1, &namespace->count) <= 1) {
+			atomic_dec(&namespace->count);
+			continue;
+		}
 
 		spin_unlock(&vfsmount_lock);
 		down_write(&namespace->sem);

