Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUCYX6V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 18:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbUCYX6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 18:58:20 -0500
Received: from waste.org ([209.173.204.2]:46489 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263775AbUCYX54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:57:56 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4.524465763@selenic.com>
Message-Id: <5.524465763@selenic.com>
Subject: [PATCH 4/22] /dev/random: remove outdated RNDGETPOOL ioctl
Date: Thu, 25 Mar 2004 17:57:42 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/dev/random  remove outdated RNDGETPOOL ioctl

Remove RNDGETPOOL ioctl, which has outlived its usefulness for
debugging as it only atomically captures the state of one pool.
There's no other value (except to attackers) of direct access to the
input pool from userspace.


 tiny-mpm/drivers/char/random.c        |   40 +---------------------------------
 tiny-mpm/include/linux/compat_ioctl.h |    1 
 tiny-mpm/include/linux/random.h       |    5 ----
 3 files changed, 3 insertions(+), 43 deletions(-)

diff -puN drivers/char/random.c~kill-getstate drivers/char/random.c
--- tiny/drivers/char/random.c~kill-getstate	2004-03-20 13:38:12.000000000 -0600
+++ tiny-mpm/drivers/char/random.c	2004-03-20 13:38:12.000000000 -0600
@@ -1671,10 +1671,9 @@ static int
 random_ioctl(struct inode * inode, struct file * file,
 	     unsigned int cmd, unsigned long arg)
 {
-	int *p, *tmp, size, ent_count;
+	int *p, size, ent_count;
 	int retval;
-	unsigned long flags;
-	
+
 	switch (cmd) {
 	case RNDGETENTCNT:
 		ent_count = random_state->entropy_count;
@@ -1694,41 +1693,6 @@ random_ioctl(struct inode * inode, struc
 		if (random_state->entropy_count >= random_read_wakeup_thresh)
 			wake_up_interruptible(&random_read_wait);
 		return 0;
-	case RNDGETPOOL:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
-		p = (int *) arg;
-		if (get_user(size, p) ||
-		    put_user(random_state->poolinfo.poolwords, p++))
-			return -EFAULT;
-		if (size < 0)
-			return -EFAULT;
-		if (size > random_state->poolinfo.poolwords)
-			size = random_state->poolinfo.poolwords;
-
-		/* prepare to atomically snapshot pool */
-
-		tmp = kmalloc(size * sizeof(__u32), GFP_KERNEL);
-
-		if (!tmp)
-			return -ENOMEM;
-
-		spin_lock_irqsave(&random_state->lock, flags);
-		ent_count = random_state->entropy_count;
-		memcpy(tmp, random_state->pool, size * sizeof(__u32));
-		spin_unlock_irqrestore(&random_state->lock, flags);
-
-		if (!copy_to_user(p, tmp, size * sizeof(__u32))) {
-			kfree(tmp);
-			return -EFAULT;
-		}
-
-		kfree(tmp);
-
-		if(put_user(ent_count, p++))
-			return -EFAULT;
-
-		return 0;
 	case RNDADDENTROPY:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
diff -puN include/linux/compat_ioctl.h~kill-getstate include/linux/compat_ioctl.h
--- tiny/include/linux/compat_ioctl.h~kill-getstate	2004-03-20 13:38:12.000000000 -0600
+++ tiny-mpm/include/linux/compat_ioctl.h	2004-03-20 13:38:12.000000000 -0600
@@ -584,7 +584,6 @@ COMPATIBLE_IOCTL(WDIOC_KEEPALIVE)
 /* Big R */
 COMPATIBLE_IOCTL(RNDGETENTCNT)
 COMPATIBLE_IOCTL(RNDADDTOENTCNT)
-COMPATIBLE_IOCTL(RNDGETPOOL)
 COMPATIBLE_IOCTL(RNDADDENTROPY)
 COMPATIBLE_IOCTL(RNDZAPENTCNT)
 COMPATIBLE_IOCTL(RNDCLEARPOOL)
diff -puN include/linux/random.h~kill-getstate include/linux/random.h
--- tiny/include/linux/random.h~kill-getstate	2004-03-20 13:38:12.000000000 -0600
+++ tiny-mpm/include/linux/random.h	2004-03-20 13:38:12.000000000 -0600
@@ -17,10 +17,7 @@
 /* Add to (or subtract from) the entropy count.  (Superuser only.) */
 #define RNDADDTOENTCNT	_IOW( 'R', 0x01, int )
 
-/* Get the contents of the entropy pool.  (Superuser only.) */
-#define RNDGETPOOL	_IOR( 'R', 0x02, int [2] )
-
-/* 
+/*
  * Write bytes into the entropy pool and add to the entropy count.
  * (Superuser only.)
  */

_
