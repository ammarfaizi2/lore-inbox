Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129545AbQK0MgP>; Mon, 27 Nov 2000 07:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129588AbQK0MgF>; Mon, 27 Nov 2000 07:36:05 -0500
Received: from 213-120-138-229.btconnect.com ([213.120.138.229]:10244 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S129545AbQK0Mf4>;
        Mon, 27 Nov 2000 07:35:56 -0500
Date: Mon, 27 Nov 2000 12:07:45 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: [patch-2.4.0-test11] free_uid() optimization
Message-ID: <Pine.LNX.4.21.0011271203520.827-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Instead of having SMP-specific code and doing a sequence of (on SMP):

test if count is 0
take a spinlock
test if count is still 0

we could make use of the atomic primitive

atomic_dec_and_lock()

and do it in one go, which is cleaner, imho. 

Regards,
Tigran

--- linux.kernel/user.c	Mon Nov 27 12:01:34 2000
+++ work/kernel/user.c	Mon Nov 27 12:03:20 2000
@@ -74,27 +74,12 @@
 	}
 }
 
-/*
- * For SMP, we need to re-test the user struct counter
- * after having acquired the spinlock. This allows us to do
- * the common case (not freeing anything) without having
- * any locking.
- */
-#ifdef CONFIG_SMP
-  #define uid_hash_free(up)	(!atomic_read(&(up)->__count))
-#else
-  #define uid_hash_free(up)	(1)
-#endif
-
 void free_uid(struct user_struct *up)
 {
 	if (up) {
-		if (atomic_dec_and_test(&up->__count)) {
-			spin_lock(&uidhash_lock);
-			if (uid_hash_free(up)) {
-				uid_hash_remove(up);
-				kmem_cache_free(uid_cachep, up);
-			}
+		if (atomic_dec_and_lock(&up->__count, &uidhash_lock)) {
+			uid_hash_remove(up);
+			kmem_cache_free(uid_cachep, up);
 			spin_unlock(&uidhash_lock);
 		}
 	}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
