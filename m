Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbULWW7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbULWW7g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 17:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbULWWwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 17:52:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:32416 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261331AbULWWuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 17:50:11 -0500
Date: Thu, 23 Dec 2004 14:54:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Robin Holt <holt@sgi.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AB-BA deadlock between uidhash_lock and tasklist_lock.
Message-Id: <20041223145433.596db88c.akpm@osdl.org>
In-Reply-To: <20041223173749.GA18887@lnx-holt.americas.sgi.com>
References: <20041222220800.GB6213@lnx-holt.americas.sgi.com>
	<20041223173749.GA18887@lnx-holt.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt <holt@sgi.com> wrote:
>
> We have uncovered a very difficult to trip AB-BA deadlock between the
> uidhash_lock and tasklist_lock.

yup.  I made some changes to your patch - please review.

- s/spin_lock_irqsave/spin_lock_irq/ in those places where local
  interrupts are obviously always enabled.

- your second patch still missed find_user().

- add comment.


--- 25/kernel/user.c~ab-ba-deadlock-between-uidhash_lock-and-tasklist_lock	Thu Dec 23 14:45:02 2004
+++ 25-akpm/kernel/user.c	Thu Dec 23 14:52:07 2004
@@ -26,6 +26,14 @@
 
 static kmem_cache_t *uid_cachep;
 static struct list_head uidhash_table[UIDHASH_SZ];
+
+/*
+ * uidhash_lock is taken inside write_lock_irq(&tasklist_lock).  If a timer
+ * interrupt were to occur while we hold uidhash_lock, and that interrupt takes
+ * read_lock(&tasklist_lock) then we have an ab/ba deadlock scenario.  Hence
+ * uidhash_lock must always be taken in an ir-qsafe manner to hold off the
+ * timer interrupt.
+ */
 static spinlock_t uidhash_lock = SPIN_LOCK_UNLOCKED;
 
 struct user_struct root_user = {
@@ -81,15 +89,19 @@ static inline struct user_struct *uid_ha
 struct user_struct *find_user(uid_t uid)
 {
 	struct user_struct *ret;
+	unsigned long flags;
 
-	spin_lock(&uidhash_lock);
+	spin_lock_irqsave(&uidhash_lock, flags);
 	ret = uid_hash_find(uid, uidhashentry(uid));
-	spin_unlock(&uidhash_lock);
+	spin_unlock_irqrestore(&uidhash_lock, flags);
 	return ret;
 }
 
 void free_uid(struct user_struct *up)
 {
+	unsigned long flags;
+
+	local_irq_save(flags);
 	if (up && atomic_dec_and_lock(&up->__count, &uidhash_lock)) {
 		uid_hash_remove(up);
 		key_put(up->uid_keyring);
@@ -97,6 +109,7 @@ void free_uid(struct user_struct *up)
 		kmem_cache_free(uid_cachep, up);
 		spin_unlock(&uidhash_lock);
 	}
+	local_irq_restore(flags);
 }
 
 struct user_struct * alloc_uid(uid_t uid)
@@ -104,9 +117,9 @@ struct user_struct * alloc_uid(uid_t uid
 	struct list_head *hashent = uidhashentry(uid);
 	struct user_struct *up;
 
-	spin_lock(&uidhash_lock);
+	spin_lock_irq(&uidhash_lock);
 	up = uid_hash_find(uid, hashent);
-	spin_unlock(&uidhash_lock);
+	spin_unlock_irq(&uidhash_lock);
 
 	if (!up) {
 		struct user_struct *new;
@@ -132,7 +145,7 @@ struct user_struct * alloc_uid(uid_t uid
 		 * Before adding this, check whether we raced
 		 * on adding the same user already..
 		 */
-		spin_lock(&uidhash_lock);
+		spin_lock_irq(&uidhash_lock);
 		up = uid_hash_find(uid, hashent);
 		if (up) {
 			key_put(new->uid_keyring);
@@ -142,7 +155,7 @@ struct user_struct * alloc_uid(uid_t uid
 			uid_hash_insert(new, hashent);
 			up = new;
 		}
-		spin_unlock(&uidhash_lock);
+		spin_unlock_irq(&uidhash_lock);
 
 	}
 	return up;
@@ -178,9 +191,9 @@ static int __init uid_cache_init(void)
 		INIT_LIST_HEAD(uidhash_table + n);
 
 	/* Insert the root user immediately (init already runs as root) */
-	spin_lock(&uidhash_lock);
+	spin_lock_irq(&uidhash_lock);
 	uid_hash_insert(&root_user, uidhashentry(0));
-	spin_unlock(&uidhash_lock);
+	spin_unlock_irq(&uidhash_lock);
 
 	return 0;
 }
_

