Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269148AbUJKQdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269148AbUJKQdV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 12:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269101AbUJKQc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 12:32:29 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5137 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S269057AbUJKQZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 12:25:35 -0400
Date: Mon, 11 Oct 2004 18:24:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: [patch] 2.6.9-rc4: SCSI qla2xxx gcc 3.4 compile errors
Message-ID: <20041011162457.GA3485@stusta.de>
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Compiling with gcc 3.4 results in the following compile errors:


<--  snip  -->

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


Please apply my patch below which is already for some time in James' 
SCSI tree.

diffstat output:
 drivers/scsi/qla2xxx/qla_os.c   |  122 ++++++++++++++++----------------
 drivers/scsi/qla2xxx/qla_rscn.c |   28 +++----
 2 files changed, 75 insertions(+), 75 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- a/drivers/scsi/qla2xxx/qla_os.c	2004-10-10 22:27:31 -07:00
+++ b/drivers/scsi/qla2xxx/qla_os.c	2004-10-10 22:27:31 -07:00
@@ -235,67 +236,6 @@
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
@@ -366,6 +306,67 @@
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
--- a/drivers/scsi/qla2xxx/qla_rscn.c	2004-10-10 22:27:29 -07:00
+++ b/drivers/scsi/qla2xxx/qla_rscn.c	2004-10-10 22:27:29 -07:00
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
@@ -309,20 +323,6 @@
 	iodesc->timer.function =
 	    (void (*) (unsigned long)) qla2x00_iodesc_timeout;
 	add_timer(&iodesc->timer);
-}
-
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
 }
 
 /** 
