Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267209AbUIIVJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267209AbUIIVJJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 17:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267189AbUIIVHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 17:07:24 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:13814 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266854AbUIIVD2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 17:03:28 -0400
Subject: [PATCH] HVCS fix to replace yield with tty_wait_until_sent in
	hvcs_close
From: Ryan Arnold <rsa@us.ibm.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-mGkY+hMeNWjabDu0iT20"
Organization: IBM
Message-Id: <1094764078.19722.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 09 Sep 2004 16:07:59 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mGkY+hMeNWjabDu0iT20
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

Following the same advice you gave in a recent hvc_console patch I have
modified HVCS to remove a while() { yield(); } from hvcs_close() which
may cause problems where real time scheduling is concerned and replaced
it with tty_wait_until_sent() which uses a real wait queue and is the
proper method for blocking a tty operation while waiting for data to be
sent.  This patch has been tested to verify that all the paths of code
that were changed were hit during the code run and performed as expected
including hotplug remove of hvcs adapters and hangup of ttys.

Changelog:

drivers/char/hvcs.c
-----------------------------------------------------------------------
Replaced yield() in hvcs_close() with tty_wait_until_sent() to prevent
possible lockup with realtime scheduling.

Removed hvcs_final_close() and reordered cleanup operations to prevent
discarding of pending data during an hvcs_close() call.

Removed spinlock protection of hvcs_struct data members in
hvcs_write_room() and hvcs_chars_in_buffer() because they aren't needed.

Thanks,

Ryan S. Arnold
IBM Linux Technology Center

--=-mGkY+hMeNWjabDu0iT20
Content-Disposition: attachment; filename=hvcs_close_draft1.patch
Content-Type: text/x-patch; name=hvcs_close_draft1.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Signed-off-by: Ryan S. Arnold <rsa@us.ibm.com>
--- linux-2.6.9-rc1/drivers/char/hvcs.c	Wed Sep  8 16:40:50 2004
+++ hvcs_linux-2.6.9-rc1/drivers/char/hvcs.c	Wed Sep  8 16:55:41 2004
@@ -119,8 +119,16 @@
  * Rearranged hvcs_close().  Cleaned up some printks and did some housekeeping
  * on the changelog.  Removed local CLC_LENGTH and used HVCS_CLC_LENGTH from
  * arch/ppc64/hvcserver.h.
+ *
+ * 1.3.2 -> 1.3.3 Replaced yield() in hvcs_close() with tty_wait_until_sent() to
+ * prevent possible lockup with realtime scheduling as similarily pointed out by
+ * akpm in hvc_console.  Changed resulted in the removal of hvcs_final_close()
+ * to reorder cleanup operations and prevent discarding of pending data during
+ * an hvcs_close().  Removed spinlock protection of hvcs_struct data members in
+ * hvcs_write_room() and hvcs_chars_in_buffer() because they aren't needed.
  */
-#define HVCS_DRIVER_VERSION "1.3.2"
+
+#define HVCS_DRIVER_VERSION "1.3.3"
 
 MODULE_AUTHOR("Ryan S. Arnold <rsa@us.ibm.com>");
 MODULE_DESCRIPTION("IBM hvcs (Hypervisor Virtual Console Server) Driver");
@@ -128,6 +136,12 @@
 MODULE_VERSION(HVCS_DRIVER_VERSION);
 
 /*
+ * Wait this long per iteration while trying to push buffered data to the
+ * hypervisor before allowing the tty to complete a close operation.
+ */
+#define HVCS_CLOSE_WAIT (HZ/100) /* 1/10 of a second */
+
+/*
  * Since the Linux TTY code does not currently (2-04-2004) support dynamic
  * addition of tty derived devices and we shouldn't allocate thousands of
  * tty_device pointers when the number of vty-server & vty partner connections
@@ -317,7 +331,6 @@
 
 static int hvcs_enable_device(struct hvcs_struct *hvcsd,
 		uint32_t unit_address, unsigned int irq, struct vio_dev *dev);
-static void hvcs_final_close(struct hvcs_struct *hvcsd);
 
 static void destroy_hvcs_struct(struct kobject *kobj);
 static int hvcs_open(struct tty_struct *tty, struct file *filp);
@@ -574,28 +587,6 @@
 	kfree(hvcsd);
 }
 
-/*
- * This function must be called with hvcsd->lock held.  Do not free the irq in
- * this function since it is called with the spinlock held.
- */
-static void hvcs_final_close(struct hvcs_struct *hvcsd)
-{
-	vio_disable_interrupts(hvcsd->vdev);
-
-	hvcsd->todo_mask = 0;
-
-	/* These two may be redundant if the operation was a close. */
-	if (hvcsd->tty) {
-		hvcsd->tty->driver_data = NULL;
-		hvcsd->tty = NULL;
-	}
-
-	hvcsd->open_count = 0;
-
-	memset(&hvcsd->buffer[0], 0x00, HVCS_BUFF_LEN);
-	hvcsd->chars_in_buffer = 0;
-}
-
 static struct kobj_type hvcs_kobj_type = {
 	.release = destroy_hvcs_struct,
 };
@@ -692,8 +683,6 @@
 	return 0;
 }
 
-
-
 static int __devexit hvcs_remove(struct vio_dev *dev)
 {
 	struct hvcs_struct *hvcsd = dev->dev.driver_data;
@@ -1099,12 +1088,7 @@
 	kobjp = &hvcsd->kobj;
 	if (--hvcsd->open_count == 0) {
 
-		/*
-		 * This line is important because it tells hvcs_open that this
-		 * device needs to be re-configured the next time hvcs_open is
-		 * called.
-		 */
-		hvcsd->tty->driver_data = NULL;
+		vio_disable_interrupts(hvcsd->vdev);
 
 		/*
 		 * NULL this early so that the kernel_thread doesn't try to
@@ -1113,26 +1097,18 @@
 		 */
 		hvcsd->tty = NULL;
 
+		irq = hvcsd->vdev->irq;
+		spin_unlock_irqrestore(&hvcsd->lock, flags);
+
+		tty_wait_until_sent(tty, HVCS_CLOSE_WAIT);
+
 		/*
-		 * Block the close until all the buffered data has been
-		 * delivered.
+		 * This line is important because it tells hvcs_open that this
+		 * device needs to be re-configured the next time hvcs_open is
+		 * called.
 		 */
-		while(hvcsd->chars_in_buffer) {
-			spin_unlock_irqrestore(&hvcsd->lock, flags);
-
-			/*
-			 * Give the kernel thread the hvcs_struct so that it can
-			 * try to deliver the remaining data but block the close
-			 * operation by spinning in this function so that other
-			 * tty operations have to wait.
-			 */
-			yield();
-			spin_lock_irqsave(&hvcsd->lock, flags);
-		}
+		tty->driver_data = NULL;
 
-		hvcs_final_close(hvcsd);
-		irq = hvcsd->vdev->irq;
-		spin_unlock_irqrestore(&hvcsd->lock, flags);
 		free_irq(irq, hvcsd);
 		kobject_put(kobjp);
 		return;
@@ -1162,12 +1138,25 @@
 	 * Don't kobject put inside the spinlock because the destruction
 	 * callback may use the spinlock and it may get called before the
 	 * spinlock has been released.  Get a pointer to the kobject and
-	 * kobject_put on that instead.
+	 * kobject_put on that after releasing the spinlock.
 	 */
 	kobjp = &hvcsd->kobj;
 
-	/* Calling this will drop any buffered data on the floor. */
-	hvcs_final_close(hvcsd);
+	vio_disable_interrupts(hvcsd->vdev);
+
+	hvcsd->todo_mask = 0;
+
+	/* I don't think the tty needs the hvcs_struct pointer after a hangup */
+	hvcsd->tty->driver_data = NULL;
+	hvcsd->tty = NULL;
+
+	hvcsd->open_count = 0;
+
+	/* This will drop any buffered data on the floor which is OK in a hangup
+	 * scenario. */
+	memset(&hvcsd->buffer[0], 0x00, HVCS_BUFF_LEN);
+	hvcsd->chars_in_buffer = 0;
+
 	irq = hvcsd->vdev->irq;
 
 	spin_unlock_irqrestore(&hvcsd->lock, flags);
@@ -1323,28 +1312,18 @@
 static int hvcs_write_room(struct tty_struct *tty)
 {
 	struct hvcs_struct *hvcsd = tty->driver_data;
-	unsigned long flags;
-	int retval;
 
 	if (!hvcsd || hvcsd->open_count <= 0)
 		return 0;
 
-	spin_lock_irqsave(&hvcsd->lock, flags);
-	retval = HVCS_BUFF_LEN - hvcsd->chars_in_buffer;
-	spin_unlock_irqrestore(&hvcsd->lock, flags);
-	return retval;
+	return HVCS_BUFF_LEN - hvcsd->chars_in_buffer;
 }
 
 static int hvcs_chars_in_buffer(struct tty_struct *tty)
 {
 	struct hvcs_struct *hvcsd = tty->driver_data;
-	unsigned long flags;
-	int retval;
 
-	spin_lock_irqsave(&hvcsd->lock, flags);
-	retval = hvcsd->chars_in_buffer;
-	spin_unlock_irqrestore(&hvcsd->lock, flags);
-	return retval;
+	return hvcsd->chars_in_buffer;
 }
 
 static struct tty_operations hvcs_ops = {

--=-mGkY+hMeNWjabDu0iT20--

