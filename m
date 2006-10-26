Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423513AbWJZNZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423513AbWJZNZS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 09:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161129AbWJZNZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 09:25:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58066 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161090AbWJZNZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 09:25:15 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <4540A0C5.60700@sw.ru> 
References: <4540A0C5.60700@sw.ru>  <453F58FB.4050407@sw.ru> 
To: Vasily Averin <vvs@sw.ru>, aviro@redhat.com
Cc: Neil Brown <neilb@suse.de>, Jan Blunck <jblunck@suse.de>,
       Olaf Hering <olh@suse.de>, Balbir Singh <balbir@in.ibm.com>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [Q] missing unused dentry in prune_dcache()? 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 26 Oct 2006 14:23:35 +0100
Message-ID: <19857.1161869015@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin <vvs@sw.ru> wrote:

> I've noticed one more minor issue in your patch: in
> shrink_dcache_for_umount_subtree() function you decrement
> dentry_stat.nr_dentry without dcache_lock.

How about the attached patch?

David
---
VFS: Fix an error in unused dentry counting

From: David Howells <dhowells@redhat.com>

Fix an error in unused dentry counting in shrink_dcache_for_umount_subtree() in
which the count is modified without the dcache_lock held.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/dcache.c |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index a1ff91e..eab1bf4 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -553,16 +553,17 @@ repeat:
  * - see the comments on shrink_dcache_for_umount() for a description of the
  *   locking
  */
-static void shrink_dcache_for_umount_subtree(struct dentry *dentry)
+static unsigned shrink_dcache_for_umount_subtree(struct dentry *dentry)
 {
 	struct dentry *parent;
+	unsigned detached = 0;
 
 	BUG_ON(!IS_ROOT(dentry));
 
 	/* detach this root from the system */
 	spin_lock(&dcache_lock);
 	if (!list_empty(&dentry->d_lru)) {
-		dentry_stat.nr_unused--;
+		detached++;
 		list_del_init(&dentry->d_lru);
 	}
 	__d_drop(dentry);
@@ -579,7 +580,7 @@ static void shrink_dcache_for_umount_sub
 			list_for_each_entry(loop, &dentry->d_subdirs,
 					    d_u.d_child) {
 				if (!list_empty(&loop->d_lru)) {
-					dentry_stat.nr_unused--;
+					detached++;
 					list_del_init(&loop->d_lru);
 				}
 
@@ -620,7 +621,7 @@ static void shrink_dcache_for_umount_sub
 				atomic_dec(&parent->d_count);
 
 			list_del(&dentry->d_u.d_child);
-			dentry_stat.nr_dentry--;	/* For d_free, below */
+			detached++;	/* For d_free, below */
 
 			inode = dentry->d_inode;
 			if (inode) {
@@ -638,7 +639,7 @@ static void shrink_dcache_for_umount_sub
 			 * otherwise we ascend to the parent and move to the
 			 * next sibling if there is one */
 			if (!parent)
-				return;
+				return detached;
 
 			dentry = parent;
 
@@ -663,6 +664,7 @@ static void shrink_dcache_for_umount_sub
 void shrink_dcache_for_umount(struct super_block *sb)
 {
 	struct dentry *dentry;
+	unsigned detached = 0;
 
 	if (down_read_trylock(&sb->s_umount))
 		BUG();
@@ -670,11 +672,17 @@ void shrink_dcache_for_umount(struct sup
 	dentry = sb->s_root;
 	sb->s_root = NULL;
 	atomic_dec(&dentry->d_count);
-	shrink_dcache_for_umount_subtree(dentry);
+	detached = shrink_dcache_for_umount_subtree(dentry);
 
 	while (!hlist_empty(&sb->s_anon)) {
 		dentry = hlist_entry(sb->s_anon.first, struct dentry, d_hash);
-		shrink_dcache_for_umount_subtree(dentry);
+		detached += shrink_dcache_for_umount_subtree(dentry);
+	}
+
+	if (detached) {
+		spin_lock(&dcache_lock);
+		dentry_stat.nr_unused -= detached;
+		spin_unlock(&dcache_lock);
 	}
 }
 
