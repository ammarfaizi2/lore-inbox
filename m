Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267942AbUG2PGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267942AbUG2PGz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267943AbUG2PCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:02:51 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25340 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265101AbUG2OK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:10:56 -0400
Date: Thu, 29 Jul 2004 16:10:50 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: James.Bottomley@SteelEye.com, Andrew Morton <akpm@osdl.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Vasquez <praka@pobox.com>
Subject: [2.6 patch] SCSI qla2xxx: fix inline compile errors (fwd)
Message-ID: <20040729141050.GV2349@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI:
The patch forwarded below is still required in 2.6.8-rc2-mm1.


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Thu, 15 Jul 2004 21:11:31 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI qla2xxx: fix inline compile errors

Trying to compile the SCSI qla2xxx driver in 2.6.8-rc1-mm1 using gcc 3.4 
results in the following compile errors:

<--  snip  -->

...
  CC      drivers/scsi/qla2xxx/qla_os.o
drivers/scsi/qla2xxx/qla_os.c: In function `qla2x00_queuecommand':
drivers/scsi/qla2xxx/qla_os.c:315: sorry, unimplemented: inlining failed 
in call to 'qla2x00_callback': function not considered for inlining
drivers/scsi/qla2xxx/qla_os.c:269: sorry, unimplemented: called from here
drivers/scsi/qla2xxx/qla_os.c:315: sorry, unimplemented: inlining failed 
in call to 'qla2x00_callback': function not considered for inlining
drivers/scsi/qla2xxx/qla_os.c:269: sorry, unimplemented: called from here
make[3]: *** [drivers/scsi/qla2xxx/qla_os.o] Error 1
...
  CC      drivers/scsi/qla2xxx/qla_rscn.o
drivers/scsi/qla2xxx/qla_rscn.c: In function `qla2x00_cancel_io_descriptors':
drivers/scsi/qla2xxx/qla_rscn.c:320: sorry, unimplemented: inlining 
failed in call to 'qla2x00_remove_iodesc_timer': function not considered for inlining
drivers/scsi/qla2xxx/qla_rscn.c:257: sorry, unimplemented: called from here
make[3]: *** [drivers/scsi/qla2xxx/qla_rscn.o] Error 1

<--  snip  -->


The patch below moves some inlined functions above the place where they
are called the first time.

An alternative approach would be to remove the inlines.


diffstat output:
 drivers/scsi/qla2xxx/qla_os.c   |  122 ++++++++++++++++----------------
 drivers/scsi/qla2xxx/qla_rscn.c |   28 +++----
 2 files changed, 75 insertions(+), 75 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm6-full-gcc3.4/drivers/scsi/qla2xxx/qla_os.c.old	2004-07-09 01:09:28.000000000 +0200
+++ linux-2.6.7-mm6-full-gcc3.4/drivers/scsi/qla2xxx/qla_os.c	2004-07-09 01:10:10.000000000 +0200
@@ -235,67 +235,6 @@
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
@@ -366,6 +305,67 @@
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
--- linux-2.6.7-mm6-full-gcc3.4/drivers/scsi/qla2xxx/qla_rscn.c.old	2004-07-09 01:10:52.000000000 +0200
+++ linux-2.6.7-mm6-full-gcc3.4/drivers/scsi/qla2xxx/qla_rscn.c	2004-07-09 01:11:23.000000000 +0200
@@ -242,6 +242,20 @@
 }
 
 /**
+ * qla2x00_remove_iodesc_timer() - Remove an active timer from an IO descriptor.
+ * @iodesc: io descriptor
+ */
+static inline void
+qla2x00_remove_iodesc_timer(struct io_descriptor *iodesc)
+{
+	if (iodesc->timer.function != NULL) {
+		del_timer_sync(&iodesc->timer);
+		iodesc->timer.data = (unsigned long) NULL;
+		iodesc->timer.function = NULL;
+	}
+}
+
+/**
  * qla2x00_init_io_descriptors() - Initialize the pool of IO descriptors.
  * @ha: HA context
  */
@@ -311,20 +325,6 @@
 	add_timer(&iodesc->timer);
 }
 
-/**
- * qla2x00_remove_iodesc_timer() - Remove an active timer from an IO descriptor.
- * @iodesc: io descriptor
- */
-static inline void
-qla2x00_remove_iodesc_timer(struct io_descriptor *iodesc)
-{
-	if (iodesc->timer.function != NULL) {
-		del_timer_sync(&iodesc->timer);
-		iodesc->timer.data = (unsigned long) NULL;
-		iodesc->timer.function = NULL;
-	}
-}
-
 /** 
  * IO descriptor support routines.
  **/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

