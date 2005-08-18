Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbVHRVJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbVHRVJJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 17:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbVHRVJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 17:09:09 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:41785 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932444AbVHRVJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 17:09:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UQdsUmZm94V9rJubHDRuv2q4VnD5Y1lXIRKiYQIN8W2/pSBGQ5SN8ggcMNaHPn55qPWyXtt19qRIf6rjIl2ixY/a2Ovk2GntEfS9FwAR7oSt83Kw2Zl6I1m44oLl+w3dZNYvRZUOPbXWRWKSWjD72BAlbb87to0tn+Kx+iclIe4=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] rename locking functions - fix a blunder in initial patches
Date: Thu, 18 Aug 2005 23:09:33 +0200
User-Agent: KMail/1.8.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508182309.35274.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,

Sorry about the blunder in the initial patches. Where I thought I'd done a 
full kernel compile to test it turned out that I'd only (by mistake) done a 
build of my regular config which of course didn't cover everything.

This time around I've done a full allyesconfig build of the kernel as well 
as read through my patches again to see if I could spot additional errors. I
believe that if you apply the patch below, on top of the ones from yesterday,
then everything should be OK and there should be no need to drop the original
patches from -mm.

I opted to keep the defines around but give them xfs specific names instead of
changing the calls to call init_sema() directly as I asume the XFS people have 
some good reason to have those defines with extra arguments around. In any case,
if getting rid of the defines is prefered, then that's something that can easily
be done later.


Fix a blunder in original patch set.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 fs/xfs/linux-2.6/sema.h  |    6 +++---
 fs/xfs/quota/xfs_dquot.c |    2 +-
 fs/xfs/xfs_iget.c        |    2 +-
 fs/xfs/xfs_mount.c       |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.13-rc6-git9/fs/xfs/linux-2.6/sema.h~	2005-08-18 21:00:35.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/xfs/linux-2.6/sema.h	2005-08-18 20:50:03.000000000 +0200
@@ -43,9 +43,9 @@
 
 typedef struct semaphore sema_t;
 
-#define init_sema(sp, val, c, d)	init_sema(sp, val)
-#define initsema(sp, val)		init_sema(sp, val)
-#define initnsema(sp, val, name)	init_sema(sp, val)
+#define xfs_init_sema(sp, val, c, d)	init_sema(sp, val)
+#define xfs_initsema(sp, val)		init_sema(sp, val)
+#define xfs_initnsema(sp, val, name)	init_sema(sp, val)
 #define psema(sp, b)			down(sp)
 #define vsema(sp)			up(sp)
 #define valusema(sp)			(atomic_read(&(sp)->count))
--- linux-2.6.13-rc6-git9/fs/xfs/quota/xfs_dquot.c~	2005-08-18 20:50:33.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/xfs/quota/xfs_dquot.c	2005-08-18 20:50:33.000000000 +0200
@@ -121,7 +121,7 @@ xfs_qm_dqinit(
 	if (brandnewdquot) {
 		dqp->dq_flnext = dqp->dq_flprev = dqp;
 		mutex_init(&dqp->q_qlock,  MUTEX_DEFAULT, "xdq");
-		initnsema(&dqp->q_flock, 1, "fdq");
+		xfs_initnsema(&dqp->q_flock, 1, "fdq");
 		sv_init(&dqp->q_pinwait, SV_DEFAULT, "pdq");
 
 #ifdef XFS_DQUOT_TRACE
--- linux-2.6.13-rc6-git9/fs/xfs/xfs_mount.c~	2005-08-18 20:53:05.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/xfs/xfs_mount.c	2005-08-18 20:53:05.000000000 +0200
@@ -133,7 +133,7 @@ xfs_mount_init(void)
 	AIL_LOCKINIT(&mp->m_ail_lock, "xfs_ail");
 	spinlock_init(&mp->m_sb_lock, "xfs_sb");
 	mutex_init(&mp->m_ilock, MUTEX_DEFAULT, "xfs_ilock");
-	initnsema(&mp->m_growlock, 1, "xfs_grow");
+	xfs_initnsema(&mp->m_growlock, 1, "xfs_grow");
 	/*
 	 * Initialize the AIL.
 	 */
--- linux-2.6.13-rc6-git9/fs/xfs/xfs_iget.c~	2005-08-18 20:49:59.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/xfs/xfs_iget.c	2005-08-18 20:49:59.000000000 +0200
@@ -575,7 +575,7 @@ xfs_inode_lock_init(
 	mrlock_init(&ip->i_iolock, MRLOCK_BARRIER, "xfsio", vp->v_number);
 	init_waitqueue_head(&ip->i_ipin_wait);
 	atomic_set(&ip->i_pincount, 0);
-	init_sema(&ip->i_flock, 1, "xfsfino", vp->v_number);
+	xfs_init_sema(&ip->i_flock, 1, "xfsfino", vp->v_number);
 }
 
 /*


