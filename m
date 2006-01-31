Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWAaWvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWAaWvS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 17:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWAaWvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 17:51:18 -0500
Received: from uproxy.gmail.com ([66.249.92.203]:51043 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750798AbWAaWvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 17:51:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=bJPmhf109jNbj9kKBElnzwWuofXDUd/aCcJUEBj08NVMKYwkdB13P4Oan411Pwlv/aegBTEHJay83wESm+mnXk2nFO19WPET9h3DuWnUkoOfWFlP3TXZDFigD10Z/otxWIMsK6MN+JuVDV8g91DhN109mnaiUqT7gwP2m1TqBXY=
Date: Wed, 1 Feb 2006 02:09:26 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Badness in local_bh_enable by [PATCH] fix uidhash_lock <-> RCU deadlock
Message-ID: <20060131230926.GA7726@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Flooding boot logs with

Badness in local_bh_enable at kernel/softirq.c:140
 [<c0114272>] local_bh_enable+0x25/0x68
 [<c0118015>] collect_signal+0x9e/0xf4
 [<c01f3867>] drm_notifier+0x0/0x41
 [<c01180c4>] __dequeue_signal+0x59/0x70
 [<c0118108>] dequeue_signal+0x2d/0x98
 [<c01196bd>] get_signal_to_deliver+0x5b/0x256
 [<c0102226>] do_signal+0x51/0xf4
 [<c014d4d1>] __pollwait+0x0/0x94
 [<c01a8e59>] copy_to_user+0x2d/0x35
 [<c014dce4>] sys_select+0x115/0x133
 [<c01022f2>] do_notify_resume+0x29/0x37
 [<c01024ba>] work_notifysig+0x13/0x19

4021cb279a532728c3208a16b9b09b0ca8016850 is first bad commit
diff-tree 4021cb279a532728c3208a16b9b09b0ca8016850 (from d5bee775137c56ed993f1b3c9d66c268b3525d7d)
Author: Ingo Molnar <mingo@elte.hu>
Date:   Wed Jan 25 15:23:07 2006 +0100

    [PATCH] fix uidhash_lock <-> RCU deadlock

    RCU task-struct freeing can call free_uid(), which is taking
    uidhash_lock - while other users of uidhash_lock are softirq-unsafe.

    The fix is to always take the uidhash_spinlock in a softirq-safe manner.

    Signed-off-by: Ingo Molnar <mingo@elte.hu>
    Acked-by: Paul E. McKenney <paulmck@us.ibm.com>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

:040000 040000 98d3bd6cebd288defc2bee44054d252629e6c020 9319c402e05522b655c2445e9f19cf394b006e02 M	kernel
diff --git a/kernel/user.c b/kernel/user.c
index 89e562f..d1ae234 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/bitops.h>
 #include <linux/key.h>
+#include <linux/interrupt.h>
 
 /*
  * UID task count cache, to get fast user lookup in "alloc_uid"
@@ -27,6 +28,12 @@
 
 static kmem_cache_t *uid_cachep;
 static struct list_head uidhash_table[UIDHASH_SZ];
+
+/*
+ * The uidhash_lock is mostly taken from process context, but it is
+ * occasionally also taken from softirq/tasklet context, when
+ * task-structs get RCU-freed. Hence all locking must be softirq-safe.
+ */
 static DEFINE_SPINLOCK(uidhash_lock);
 
 struct user_struct root_user = {
@@ -83,14 +90,15 @@ struct user_struct *find_user(uid_t uid)
 {
 	struct user_struct *ret;
 
-	spin_lock(&uidhash_lock);
+	spin_lock_bh(&uidhash_lock);
 	ret = uid_hash_find(uid, uidhashentry(uid));
-	spin_unlock(&uidhash_lock);
+	spin_unlock_bh(&uidhash_lock);
 	return ret;
 }
 
 void free_uid(struct user_struct *up)
 {
+	local_bh_disable();
 	if (up && atomic_dec_and_lock(&up->__count, &uidhash_lock)) {
 		uid_hash_remove(up);
 		key_put(up->uid_keyring);
@@ -98,6 +106,7 @@ void free_uid(struct user_struct *up)
 		kmem_cache_free(uid_cachep, up);
 		spin_unlock(&uidhash_lock);
 	}
+	local_bh_enable();
 }
 
 struct user_struct * alloc_uid(uid_t uid)
@@ -105,9 +114,9 @@ struct user_struct * alloc_uid(uid_t uid
 	struct list_head *hashent = uidhashentry(uid);
 	struct user_struct *up;
 
-	spin_lock(&uidhash_lock);
+	spin_lock_bh(&uidhash_lock);
 	up = uid_hash_find(uid, hashent);
-	spin_unlock(&uidhash_lock);
+	spin_unlock_bh(&uidhash_lock);
 
 	if (!up) {
 		struct user_struct *new;
@@ -137,7 +146,7 @@ struct user_struct * alloc_uid(uid_t uid
 		 * Before adding this, check whether we raced
 		 * on adding the same user already..
 		 */
-		spin_lock(&uidhash_lock);
+		spin_lock_bh(&uidhash_lock);
 		up = uid_hash_find(uid, hashent);
 		if (up) {
 			key_put(new->uid_keyring);
@@ -147,7 +156,7 @@ struct user_struct * alloc_uid(uid_t uid
 			uid_hash_insert(new, hashent);
 			up = new;
 		}
-		spin_unlock(&uidhash_lock);
+		spin_unlock_bh(&uidhash_lock);
 
 	}
 	return up;
@@ -183,9 +192,9 @@ static int __init uid_cache_init(void)
 		INIT_LIST_HEAD(uidhash_table + n);
 
 	/* Insert the root user immediately (init already runs as root) */
-	spin_lock(&uidhash_lock);
+	spin_lock_bh(&uidhash_lock);
 	uid_hash_insert(&root_user, uidhashentry(0));
-	spin_unlock(&uidhash_lock);
+	spin_unlock_bh(&uidhash_lock);
 
 	return 0;
 }

