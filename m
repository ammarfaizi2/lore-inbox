Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbVIGPNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVIGPNX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 11:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbVIGPNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 11:13:23 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:2548 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932162AbVIGPNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 11:13:22 -0400
Date: Wed, 7 Sep 2005 08:13:12 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][MM] rapidio: message interface updates
Message-ID: <20050907081312.B1925@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updates the RIO messaging interface to pass a device instance into
the event registeration and callbacks.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff --git a/arch/ppc/syslib/ppc85xx_rio.c b/arch/ppc/syslib/ppc85xx_rio.c
--- a/arch/ppc/syslib/ppc85xx_rio.c
+++ b/arch/ppc/syslib/ppc85xx_rio.c
@@ -135,6 +135,7 @@ static struct rio_msg_tx_ring {
 	dma_addr_t phys_buffer[RIO_MAX_TX_RING_SIZE];
 	int tx_slot;
 	int size;
+	void *dev_id;
 } msg_tx_ring;
 
 static struct rio_msg_rx_ring {
@@ -143,6 +144,7 @@ static struct rio_msg_rx_ring {
 	void *virt_buffer[RIO_MAX_RX_RING_SIZE];
 	int rx_slot;
 	int size;
+	void *dev_id;
 } msg_rx_ring;
 
 /**
@@ -376,7 +378,7 @@ mpc85xx_rio_tx_handler(int irq, void *de
 	if (osr & RIO_MSG_OSR_EOMI) {
 		u32 dqp = in_be32((void *)&msg_regs->odqdpar);
 		int slot = (dqp - msg_tx_ring.phys) >> 5;
-		port->outb_msg[0].mcback(port, -1, slot);
+		port->outb_msg[0].mcback(port, msg_tx_ring.dev_id, -1, slot);
 
 		/* Ack the end-of-message interrupt */
 		out_be32((void *)&msg_regs->osr, RIO_MSG_OSR_EOMI);
@@ -389,6 +391,7 @@ mpc85xx_rio_tx_handler(int irq, void *de
 /**
  * rio_open_outb_mbox - Initialize MPC85xx outbound mailbox
  * @mport: Master port implementing the outbound message unit
+ * @dev_id: Device specific pointer to pass on event
  * @mbox: Mailbox to open
  * @entries: Number of entries in the outbound mailbox ring
  *
@@ -396,7 +399,7 @@ mpc85xx_rio_tx_handler(int irq, void *de
  * and enables the outbound message unit. Returns %0 on success and
  * %-EINVAL or %-ENOMEM on failure.
  */
-int rio_open_outb_mbox(struct rio_mport *mport, int mbox, int entries)
+int rio_open_outb_mbox(struct rio_mport *mport, void *dev_id, int mbox, int entries)
 {
 	int i, j, rc = 0;
 
@@ -407,6 +410,7 @@ int rio_open_outb_mbox(struct rio_mport 
 	}
 
 	/* Initialize shadow copy ring */
+	msg_tx_ring.dev_id = dev_id;
 	msg_tx_ring.size = entries;
 
 	for (i = 0; i < msg_tx_ring.size; i++) {
@@ -541,7 +545,7 @@ mpc85xx_rio_rx_handler(int irq, void *de
 		 * make the callback with an unknown/invalid mailbox number
 		 * argument.
 		 */
-		port->inb_msg[0].mcback(port, -1, -1);
+		port->inb_msg[0].mcback(port, msg_rx_ring.dev_id, -1, -1);
 
 		/* Ack the queueing interrupt */
 		out_be32((void *)&msg_regs->isr, RIO_MSG_ISR_DIQI);
@@ -554,6 +558,7 @@ mpc85xx_rio_rx_handler(int irq, void *de
 /**
  * rio_open_inb_mbox - Initialize MPC85xx inbound mailbox
  * @mport: Master port implementing the inbound message unit
+ * @dev_id: Device specific pointer to pass on event
  * @mbox: Mailbox to open
  * @entries: Number of entries in the inbound mailbox ring
  *
@@ -561,7 +566,7 @@ mpc85xx_rio_rx_handler(int irq, void *de
  * and enables the inbound message unit. Returns %0 on success
  * and %-EINVAL or %-ENOMEM on failure.
  */
-int rio_open_inb_mbox(struct rio_mport *mport, int mbox, int entries)
+int rio_open_inb_mbox(struct rio_mport *mport, void *dev_id, int mbox, int entries)
 {
 	int i, rc = 0;
 
@@ -572,6 +577,7 @@ int rio_open_inb_mbox(struct rio_mport *
 	}
 
 	/* Initialize client buffer ring */
+	msg_rx_ring.dev_id = dev_id;
 	msg_rx_ring.size = entries;
 	msg_rx_ring.rx_slot = 0;
 	for (i = 0; i < msg_rx_ring.size; i++)
@@ -777,7 +783,7 @@ mpc85xx_rio_dbell_handler(int irq, void 
 			}
 		}
 		if (found) {
-			dbell->dinb(port, DBELL_SID(dmsg), DBELL_TID(dmsg),
+			dbell->dinb(port, dbell->dev_id, DBELL_SID(dmsg), DBELL_TID(dmsg),
 				    DBELL_INF(dmsg));
 		} else {
 			pr_debug
diff --git a/drivers/rapidio/rio-sysfs.c b/drivers/rapidio/rio-sysfs.c
--- a/drivers/rapidio/rio-sysfs.c
+++ b/drivers/rapidio/rio-sysfs.c
@@ -21,7 +21,7 @@
 /* Sysfs support */
 #define rio_config_attr(field, format_string)					\
 static ssize_t								\
-	field##_show(struct device *dev, char *buf)			\
+field##_show(struct device *dev, struct device_attribute *attr, char *buf)			\
 {									\
 	struct rio_dev *rdev = to_rio_dev(dev);				\
 									\
@@ -35,7 +35,7 @@ rio_config_attr(asm_did, "0x%04x\n");
 rio_config_attr(asm_vid, "0x%04x\n");
 rio_config_attr(asm_rev, "0x%04x\n");
 
-static ssize_t routes_show(struct device *dev, char *buf)
+static ssize_t routes_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct rio_dev *rdev = to_rio_dev(dev);
 	char *str = buf;
diff --git a/drivers/rapidio/rio.c b/drivers/rapidio/rio.c
--- a/drivers/rapidio/rio.c
+++ b/drivers/rapidio/rio.c
@@ -48,6 +48,7 @@ u16 rio_local_get_device_id(struct rio_m
 /**
  * rio_request_inb_mbox - request inbound mailbox service
  * @mport: RIO master port from which to allocate the mailbox resource
+ * @dev_id: Device specific pointer to pass on event
  * @mbox: Mailbox number to claim
  * @entries: Number of entries in inbound mailbox queue
  * @minb: Callback to execute when inbound message is received
@@ -56,9 +57,10 @@ u16 rio_local_get_device_id(struct rio_m
  * a callback function to the resource. Returns %0 on success.
  */
 int rio_request_inb_mbox(struct rio_mport *mport,
+			 void *dev_id,
 			 int mbox,
 			 int entries,
-			 void (*minb) (struct rio_mport * mport, int mbox,
+			 void (*minb) (struct rio_mport * mport, void *dev_id, int mbox,
 				       int slot))
 {
 	int rc = 0;
@@ -81,7 +83,7 @@ int rio_request_inb_mbox(struct rio_mpor
 		/* Hook the inbound message callback */
 		mport->inb_msg[mbox].mcback = minb;
 
-		rc = rio_open_inb_mbox(mport, mbox, entries);
+		rc = rio_open_inb_mbox(mport, dev_id, mbox, entries);
 	} else
 		rc = -ENOMEM;
 
@@ -108,6 +110,7 @@ int rio_release_inb_mbox(struct rio_mpor
 /**
  * rio_request_outb_mbox - request outbound mailbox service
  * @mport: RIO master port from which to allocate the mailbox resource
+ * @dev_id: Device specific pointer to pass on event
  * @mbox: Mailbox number to claim
  * @entries: Number of entries in outbound mailbox queue
  * @moutb: Callback to execute when outbound message is sent
@@ -116,10 +119,10 @@ int rio_release_inb_mbox(struct rio_mpor
  * a callback function to the resource. Returns 0 on success.
  */
 int rio_request_outb_mbox(struct rio_mport *mport,
+			  void *dev_id,
 			  int mbox,
 			  int entries,
-			  void (*moutb) (struct rio_mport * mport, int mbox,
-					 int slot))
+			  void (*moutb) (struct rio_mport * mport, void *dev_id, int mbox, int slot))
 {
 	int rc = 0;
 
@@ -141,7 +144,7 @@ int rio_request_outb_mbox(struct rio_mpo
 		/* Hook the inbound message callback */
 		mport->outb_msg[mbox].mcback = moutb;
 
-		rc = rio_open_outb_mbox(mport, mbox, entries);
+		rc = rio_open_outb_mbox(mport, dev_id, mbox, entries);
 	} else
 		rc = -ENOMEM;
 
@@ -168,6 +171,7 @@ int rio_release_outb_mbox(struct rio_mpo
 /**
  * rio_setup_inb_dbell - bind inbound doorbell callback
  * @mport: RIO master port to bind the doorbell callback
+ * @dev_id: Device specific pointer to pass on event
  * @res: Doorbell message resource
  * @dinb: Callback to execute when doorbell is received
  *
@@ -176,8 +180,8 @@ int rio_release_outb_mbox(struct rio_mpo
  * satisfied.
  */
 static int
-rio_setup_inb_dbell(struct rio_mport *mport, struct resource *res,
-		    void (*dinb) (struct rio_mport * mport, u16 src, u16 dst,
+rio_setup_inb_dbell(struct rio_mport *mport, void *dev_id, struct resource *res,
+		    void (*dinb) (struct rio_mport * mport, void *dev_id, u16 src, u16 dst,
 				  u16 info))
 {
 	int rc = 0;
@@ -190,6 +194,7 @@ rio_setup_inb_dbell(struct rio_mport *mp
 
 	dbell->res = res;
 	dbell->dinb = dinb;
+	dbell->dev_id = dev_id;
 
 	list_add_tail(&dbell->node, &mport->dbells);
 
@@ -200,6 +205,7 @@ rio_setup_inb_dbell(struct rio_mport *mp
 /**
  * rio_request_inb_dbell - request inbound doorbell message service
  * @mport: RIO master port from which to allocate the doorbell resource
+ * @dev_id: Device specific pointer to pass on event
  * @start: Doorbell info range start
  * @end: Doorbell info range end
  * @dinb: Callback to execute when doorbell is received
@@ -209,9 +215,10 @@ rio_setup_inb_dbell(struct rio_mport *mp
  * has been satisfied.
  */
 int rio_request_inb_dbell(struct rio_mport *mport,
+			  void *dev_id,
 			  u16 start,
 			  u16 end,
-			  void (*dinb) (struct rio_mport * mport, u16 src,
+			  void (*dinb) (struct rio_mport * mport, void *dev_id, u16 src,
 					u16 dst, u16 info))
 {
 	int rc = 0;
@@ -230,7 +237,7 @@ int rio_request_inb_dbell(struct rio_mpo
 		}
 
 		/* Hook the doorbell callback */
-		rc = rio_setup_inb_dbell(mport, res, dinb);
+		rc = rio_setup_inb_dbell(mport, dev_id, res, dinb);
 	} else
 		rc = -ENOMEM;
 
diff --git a/include/linux/rio.h b/include/linux/rio.h
--- a/include/linux/rio.h
+++ b/include/linux/rio.h
@@ -132,7 +132,7 @@ struct rio_dev {
  */
 struct rio_msg {
 	struct resource *res;
-	void (*mcback) (struct rio_mport * mport, int mbox, int slot);
+	void (*mcback) (struct rio_mport * mport, void *dev_id, int mbox, int slot);
 };
 
 /**
@@ -140,11 +140,13 @@ struct rio_msg {
  * @node: Node in list of doorbell events
  * @res: Doorbell resource
  * @dinb: Doorbell event callback
+ * @dev_id: Device specific pointer to pass on event
  */
 struct rio_dbell {
 	struct list_head node;
 	struct resource *res;
-	void (*dinb) (struct rio_mport * mport, u16 src, u16 dst, u16 info);
+	void (*dinb) (struct rio_mport *mport, void *dev_id, u16 src, u16 dst, u16 info);
+	void *dev_id;
 };
 
 /**
@@ -314,9 +316,9 @@ extern int rio_hw_add_outb_message(struc
 				   void *, size_t);
 extern int rio_hw_add_inb_buffer(struct rio_mport *, int, void *);
 extern void *rio_hw_get_inb_message(struct rio_mport *, int);
-extern int rio_open_inb_mbox(struct rio_mport *, int, int);
+extern int rio_open_inb_mbox(struct rio_mport *, void *, int, int);
 extern void rio_close_inb_mbox(struct rio_mport *, int);
-extern int rio_open_outb_mbox(struct rio_mport *, int, int);
+extern int rio_open_outb_mbox(struct rio_mport *, void *, int, int);
 extern void rio_close_outb_mbox(struct rio_mport *, int);
 
 #endif				/* __KERNEL__ */
diff --git a/include/linux/rio_drv.h b/include/linux/rio_drv.h
--- a/include/linux/rio_drv.h
+++ b/include/linux/rio_drv.h
@@ -348,8 +348,8 @@ static inline void rio_init_dbell_res(st
 	.asm_did = RIO_ANY_ID, .asm_vid = RIO_ANY_ID
 
 /* Mailbox management */
-extern int rio_request_outb_mbox(struct rio_mport *, int, int,
-				 void (*)(struct rio_mport *, int, int));
+extern int rio_request_outb_mbox(struct rio_mport *, void *, int, int,
+				 void (*)(struct rio_mport *, void *,int, int));
 extern int rio_release_outb_mbox(struct rio_mport *, int);
 
 /**
@@ -370,8 +370,8 @@ static inline int rio_add_outb_message(s
 	return rio_hw_add_outb_message(mport, rdev, mbox, buffer, len);
 }
 
-extern int rio_request_inb_mbox(struct rio_mport *, int, int,
-				void (*)(struct rio_mport *, int, int));
+extern int rio_request_inb_mbox(struct rio_mport *, void *, int, int,
+				void (*)(struct rio_mport *, void *, int, int));
 extern int rio_release_inb_mbox(struct rio_mport *, int);
 
 /**
@@ -403,8 +403,8 @@ static inline void *rio_get_inb_message(
 }
 
 /* Doorbell management */
-extern int rio_request_inb_dbell(struct rio_mport *, u16, u16,
-				 void (*)(struct rio_mport *, u16, u16, u16));
+extern int rio_request_inb_dbell(struct rio_mport *, void *, u16, u16,
+				 void (*)(struct rio_mport *, void *, u16, u16, u16));
 extern int rio_release_inb_dbell(struct rio_mport *, u16, u16);
 extern struct resource *rio_request_outb_dbell(struct rio_dev *, u16, u16);
 extern int rio_release_outb_dbell(struct rio_dev *, struct resource *);
