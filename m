Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbULWRiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbULWRiR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 12:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbULWRiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 12:38:17 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:55998 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261276AbULWRhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 12:37:55 -0500
Date: Thu, 23 Dec 2004 11:37:49 -0600
From: Robin Holt <holt@sgi.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] AB-BA deadlock between uidhash_lock and tasklist_lock.
Message-ID: <20041223173749.GA18887@lnx-holt.americas.sgi.com>
References: <20041222220800.GB6213@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041222220800.GB6213@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a replacement patch to one I sent yesterday.  I missed a
couple instances of the uidhash_lock and was also told I should
have sent it directly to Linus instead of Andrew.

We have uncovered a very difficult to trip AB-BA deadlock between the
uidhash_lock and tasklist_lock.

reparent_to_init() does write_lock_irq(&tasklist_lock) then calls
switch_uid() which calls free_uid() which grabs the uidhash_lock.

Independent of that, we have seen a different cpu call free_uid as a
result of sys_wait4 and, immediately after acquiring the uidhash_lock,
receive a timer interrupt which eventually leads to an attempt to grab
the tasklist_lock.


Signed-off-by: Robin Holt <holt@sgi.com>


Index: linux/kernel/user.c
===================================================================
--- linux.orig/kernel/user.c	2004-12-22 13:10:49.000000000 -0600
+++ linux/kernel/user.c	2004-12-23 11:07:21.100577562 -0600
@@ -90,6 +90,9 @@
 
 void free_uid(struct user_struct *up)
 {
+	unsigned long flags;
+
+	local_irq_save(flags);
 	if (up && atomic_dec_and_lock(&up->__count, &uidhash_lock)) {
 		uid_hash_remove(up);
 		key_put(up->uid_keyring);
@@ -97,16 +100,18 @@
 		kmem_cache_free(uid_cachep, up);
 		spin_unlock(&uidhash_lock);
 	}
+	local_irq_restore(flags);
 }
 
 struct user_struct * alloc_uid(uid_t uid)
 {
 	struct list_head *hashent = uidhashentry(uid);
 	struct user_struct *up;
+	unsigned long flags;
 
-	spin_lock(&uidhash_lock);
+	spin_lock_irqsave(&uidhash_lock, flags);
 	up = uid_hash_find(uid, hashent);
-	spin_unlock(&uidhash_lock);
+	spin_unlock_irqrestore(&uidhash_lock, flags);
 
 	if (!up) {
 		struct user_struct *new;
@@ -132,7 +137,7 @@
 		 * Before adding this, check whether we raced
 		 * on adding the same user already..
 		 */
-		spin_lock(&uidhash_lock);
+		spin_lock_irqsave(&uidhash_lock, flags);
 		up = uid_hash_find(uid, hashent);
 		if (up) {
 			key_put(new->uid_keyring);
@@ -142,7 +147,7 @@
 			uid_hash_insert(new, hashent);
 			up = new;
 		}
-		spin_unlock(&uidhash_lock);
+		spin_unlock_irqrestore(&uidhash_lock, flags);
 
 	}
 	return up;
@@ -170,6 +175,7 @@
 static int __init uid_cache_init(void)
 {
 	int n;
+	unsigned long flags;
 
 	uid_cachep = kmem_cache_create("uid_cache", sizeof(struct user_struct),
 			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
@@ -178,9 +184,9 @@
 		INIT_LIST_HEAD(uidhash_table + n);
 
 	/* Insert the root user immediately (init already runs as root) */
-	spin_lock(&uidhash_lock);
+	spin_lock_irqsave(&uidhash_lock, flags);
 	uid_hash_insert(&root_user, uidhashentry(0));
-	spin_unlock(&uidhash_lock);
+	spin_unlock_irqrestore(&uidhash_lock, flags);
 
 	return 0;
 }
