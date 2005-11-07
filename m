Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbVKGVCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVKGVCl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbVKGVCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:02:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43660 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932288AbVKGVCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:02:40 -0500
Date: Mon, 7 Nov 2005 15:02:45 -0600
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] dlm: force unlock
Message-ID: <20051107210245.GB4287@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add DLM_LKF_FORCEUNLOCK so device.c doesn't have to muck about with locks
that are in progress.

Signed-off-by: Patrick Caulfield <pcaulfie@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>

----

diff -urpN a/drivers/dlm/device.c b/drivers/dlm/device.c
--- a/drivers/dlm/device.c	2005-10-07 10:17:23.229548773 -0500
+++ b/drivers/dlm/device.c	2005-10-07 10:22:16.462037029 -0500
@@ -546,37 +546,19 @@ static int dlm_close(struct inode *inode
 
 		clear_bit(LI_FLAG_COMPLETE, &li.li_flags);
 
-		/* If it's not granted then cancel the request.
-		 * If the lock was WAITING then it will be dropped,
-		 *    if it was converting then it will be reverted to GRANTED,
-		 *    then we will unlock it.
-		 */
-
-		if (old_li->li_grmode != old_li->li_rqmode)
-			flags = DLM_LKF_CANCEL;
-
+		flags = DLM_LKF_FORCEUNLOCK;
 		if (old_li->li_grmode >= DLM_LOCK_PW)
 			flags |= DLM_LKF_IVVALBLK;
 
 		status = dlm_unlock(f->fi_ls->ls_lockspace,
 				    old_li->li_lksb.sb_lkid, flags,
 				    &li.li_lksb, &li);
+
 		/* Must wait for it to complete as the next lock could be its
 		 * parent */
 		if (status == 0)
 			wait_for_ast(&li);
 
-		/* If it was waiting for a conversion, it will
-		   now be granted so we can unlock it properly */
-		if (flags & DLM_LKF_CANCEL) {
-			flags &= ~DLM_LKF_CANCEL;
-			clear_bit(LI_FLAG_COMPLETE, &li.li_flags);
-			status = dlm_unlock(f->fi_ls->ls_lockspace,
-					    old_li->li_lksb.sb_lkid, flags,
-					    &li.li_lksb, &li);
-			if (status == 0)
-				wait_for_ast(&li);
-		}
 		/* Unlock suceeded, free the lock_info struct. */
 		if (status == 0)
 			release_lockinfo(old_li);
diff -urpN a/drivers/dlm/lock.c b/drivers/dlm/lock.c
--- a/drivers/dlm/lock.c	2005-10-07 10:17:23.236547685 -0500
+++ b/drivers/dlm/lock.c	2005-10-07 10:23:07.230170782 -0500
@@ -1603,7 +1603,8 @@ static int set_lock_args(int mode, struc
 
 static int set_unlock_args(uint32_t flags, void *astarg, struct dlm_args *args)
 {
-	if (flags & ~(DLM_LKF_CANCEL | DLM_LKF_VALBLK | DLM_LKF_IVVALBLK))
+	if (flags & ~(DLM_LKF_CANCEL | DLM_LKF_VALBLK | DLM_LKF_IVVALBLK |
+ 		      DLM_LKF_FORCEUNLOCK))
 		return -EINVAL;
 
 	args->flags = flags;
@@ -1673,6 +1674,9 @@ static int validate_unlock_args(struct d
 	if (lkb->lkb_flags & DLM_IFL_MSTCPY)
 		goto out;
 
+	if (args->flags & DLM_LKF_FORCEUNLOCK)
+		goto out_ok;
+
 	if (args->flags & DLM_LKF_CANCEL &&
 	    lkb->lkb_status == DLM_LKSTS_GRANTED)
 		goto out;
@@ -1685,9 +1689,11 @@ static int validate_unlock_args(struct d
 	if (lkb->lkb_wait_type)
 		goto out;
 
+ out_ok:
 	lkb->lkb_exflags = args->flags;
 	lkb->lkb_sbflags = 0;
 	lkb->lkb_astparam = args->astparam;
+
 	rv = 0;
  out:
 	return rv;
diff -urpN a/include/linux/dlm.h b/include/linux/dlm.h
--- a/include/linux/dlm.h	2005-10-07 10:17:24.000000000 -0500
+++ b/include/linux/dlm.h	2005-10-07 10:22:43.818797855 -0500
@@ -123,6 +123,12 @@
  * DLM_LKF_ALTCW
  *
  * The same as ALTPR, but the alternate mode is CW.
+ *
+ * DLM_LKF_FORCEUNLOCK
+ *
+ * Unlock the lock even if it is converting or waiting or has sublocks.
+ * Only really for use by the userland device.c code.
+ *
  */
 
 #define DLM_LKF_NOQUEUE		0x00000001
@@ -142,6 +148,7 @@
 #define DLM_LKF_ORPHAN		0x00004000
 #define DLM_LKF_ALTPR		0x00008000
 #define DLM_LKF_ALTCW		0x00010000
+#define DLM_LKF_FORCEUNLOCK	0x00020000
 
 /*
  * Some return codes that are not in errno.h
