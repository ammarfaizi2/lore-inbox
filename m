Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUISVxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUISVxH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 17:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbUISVxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 17:53:07 -0400
Received: from mail.dif.dk ([193.138.115.101]:58532 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S264386AbUISVv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 17:51:27 -0400
Date: Sun, 19 Sep 2004 23:58:05 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
       "James E.J. Bottomley" <James.Bottomley@SteelEye.com>
Subject: [PATCH] fix inlining trouble causing build failure in
 drivers/scsi/qla2xxx/qla_os.c
Message-ID: <Pine.LNX.4.61.0409192346490.2758@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.6.9-rc2-bk5 allyesconfig fails to build for me with gcc 3.4.1 with the 
following error : 

  CC      drivers/scsi/qla2xxx/qla_os.o
drivers/scsi/qla2xxx/qla_os.c: In function `qla2x00_queuecommand':
drivers/scsi/qla2xxx/qla_os.c:315: sorry, unimplemented: inlining failed in call to 'qla2x00_callback': function not considered for inlining
drivers/scsi/qla2xxx/qla_os.c:269: sorry, unimplemented: called from here
drivers/scsi/qla2xxx/qla_os.c:315: sorry, unimplemented: inlining failed in call to 'qla2x00_callback': function not considered for inlining
drivers/scsi/qla2xxx/qla_os.c:269: sorry, unimplemented: called from here
make[3]: *** [drivers/scsi/qla2xxx/qla_os.o] Error 1
make[2]: *** [drivers/scsi/qla2xxx] Error 2
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2
 
Here's a patch to fix this by simply moving the function. 
An alternative fix would be to uninline the function.

Since I don't have the hardware I have only been able to compile test this 
patch, but it's fairly trivial in nature so I can't imagine anything 
breaking from this small change.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


diff -up linux-2.6.9-rc2-bk5-orig/drivers/scsi/qla2xxx/qla_os.c linux-2.6.9-rc2-bk5/drivers/scsi/qla2xxx/qla_os.c
--- linux-2.6.9-rc2-bk5-orig/drivers/scsi/qla2xxx/qla_os.c	2004-09-14 23:19:38.000000000 +0200
+++ linux-2.6.9-rc2-bk5/drivers/scsi/qla2xxx/qla_os.c	2004-09-19 23:46:19.000000000 +0200
@@ -229,73 +229,11 @@ qla2x00_stop_timer(scsi_qla_host_t *ha)
 
 void qla2x00_cmd_timeout(srb_t *);
 
-static __inline__ void qla2x00_callback(scsi_qla_host_t *, struct scsi_cmnd *);
 static __inline__ void sp_put(struct scsi_qla_host * ha, srb_t *sp);
 static __inline__ void sp_get(struct scsi_qla_host * ha, srb_t *sp);
 static __inline__ void
 qla2x00_delete_from_done_queue(scsi_qla_host_t *, srb_t *); 
 
-/**************************************************************************
-* sp_put
-*
-* Description:
-*   Decrement reference count and call the callback if we're the last
-*   owner of the specified sp. Will get the host_lock before calling
-*   the callback.
-*
-* Input:
-*   ha - pointer to the scsi_qla_host_t where the callback is to occur.
-*   sp - pointer to srb_t structure to use.
-*
-* Returns:
-*
-**************************************************************************/
-static inline void
-sp_put(struct scsi_qla_host * ha, srb_t *sp)
-{
-        if (atomic_read(&sp->ref_count) == 0) {
-		qla_printk(KERN_INFO, ha,
-			"%s(): **** SP->ref_count not zero\n",
-			__func__);
-                DEBUG2(BUG();)
-
-                return;
-	}
-
-        if (!atomic_dec_and_test(&sp->ref_count)) {
-                return;
-        }
-
-        qla2x00_callback(ha, sp->cmd);
-}
-
-/**************************************************************************
-* sp_get
-*
-* Description:
-*   Increment reference count of the specified sp.
-*
-* Input:
-*   sp - pointer to srb_t structure to use.
-*
-* Returns:
-*
-**************************************************************************/
-static inline void
-sp_get(struct scsi_qla_host * ha, srb_t *sp)
-{
-        atomic_inc(&sp->ref_count);
-
-        if (atomic_read(&sp->ref_count) > 2) {
-		qla_printk(KERN_INFO, ha,
-			"%s(): **** SP->ref_count greater than two\n",
-			__func__);
-                DEBUG2(BUG();)
-
-		return;
-	}
-}
-
 /*
 * qla2x00_callback
 *      Returns the completed SCSI command to LINUX.
@@ -366,6 +304,67 @@ qla2x00_callback(scsi_qla_host_t *ha, st
 	(*(cmd)->scsi_done)(cmd);
 }
 
+/**************************************************************************
+* sp_put
+*
+* Description:
+*   Decrement reference count and call the callback if we're the last
+*   owner of the specified sp. Will get the host_lock before calling
+*   the callback.
+*
+* Input:
+*   ha - pointer to the scsi_qla_host_t where the callback is to occur.
+*   sp - pointer to srb_t structure to use.
+*
+* Returns:
+*
+**************************************************************************/
+static inline void
+sp_put(struct scsi_qla_host * ha, srb_t *sp)
+{
+        if (atomic_read(&sp->ref_count) == 0) {
+		qla_printk(KERN_INFO, ha,
+			"%s(): **** SP->ref_count not zero\n",
+			__func__);
+                DEBUG2(BUG();)
+
+                return;
+	}
+
+        if (!atomic_dec_and_test(&sp->ref_count)) {
+                return;
+        }
+
+        qla2x00_callback(ha, sp->cmd);
+}
+
+/**************************************************************************
+* sp_get
+*
+* Description:
+*   Increment reference count of the specified sp.
+*
+* Input:
+*   sp - pointer to srb_t structure to use.
+*
+* Returns:
+*
+**************************************************************************/
+static inline void
+sp_get(struct scsi_qla_host * ha, srb_t *sp)
+{
+        atomic_inc(&sp->ref_count);
+
+        if (atomic_read(&sp->ref_count) > 2) {
+		qla_printk(KERN_INFO, ha,
+			"%s(): **** SP->ref_count greater than two\n",
+			__func__);
+                DEBUG2(BUG();)
+
+		return;
+	}
+}
+
 static inline void 
 qla2x00_delete_from_done_queue(scsi_qla_host_t *dest_ha, srb_t *sp) 
 {


--
Jesper Juhl <juhl-lkml@dif.dk>


PS. I'm not subscribed to linux-scsi, so please CC me on replies from there.


