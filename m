Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbULVXM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbULVXM4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 18:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbULVXM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 18:12:56 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:16305 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262078AbULVXMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 18:12:49 -0500
Date: Wed, 22 Dec 2004 17:12:45 -0600
From: Robin Holt <holt@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: FW: [PATCH] AB-BA deadlock between uidhash_lock and tasklist_lock.
Message-ID: <20041222231245.GA8355@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
+++ linux/kernel/user.c	2004-12-22 16:04:40.244569776 -0600
@@ -90,6 +90,9 @@
 
 void free_uid(struct user_struct *up)
 {
+	unsigned long   flags;
+
+	local_irq_save(flags);
 	if (up && atomic_dec_and_lock(&up->__count, &uidhash_lock)) {
 		uid_hash_remove(up);
 		key_put(up->uid_keyring);
@@ -97,6 +100,7 @@
 		kmem_cache_free(uid_cachep, up);
 		spin_unlock(&uidhash_lock);
 	}
+	local_irq_restore(flags);
 }
 
 struct user_struct * alloc_uid(uid_t uid)
