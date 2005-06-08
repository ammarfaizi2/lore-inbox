Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVFHBcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVFHBcE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 21:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbVFHBcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 21:32:04 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:60114 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262060AbVFHBby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 21:31:54 -0400
Date: Tue, 7 Jun 2005 18:31:52 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH] rapidio: core updates
Message-ID: <20050607183152.G26258@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Addresses issues raised with the 2.6.12-rc6-mm1 RIO support.
Fix dma_mask init, shrink some code, general cleanup.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/rio.h>
 #include <linux/rio_drv.h>
@@ -33,7 +34,8 @@ static LIST_HEAD(rio_switches);
 
 static void rio_enum_timeout(unsigned long);
 
-spinlock_t rio_global_list_lock = SPIN_LOCK_UNLOCKED;
+DEFINE_SPINLOCK(rio_global_list_lock);
+
 static int next_destid = 0;
 static int next_switchid = 0;
 static int next_net = 0;
@@ -55,9 +57,6 @@ static int rio_sport_phys_table[] = {
 	-1,
 };
 
-extern struct rio_route_ops __start_rio_route_ops[];
-extern struct rio_route_ops __end_rio_route_ops[];
-
 /**
  * rio_get_device_id - Get the base/extended device id for a device
  * @port: RIO master port 
@@ -85,8 +84,7 @@ static u16 rio_get_device_id(struct rio_
  *
  * Writes the base/extended device id from a device.
  */
-static void
-rio_set_device_id(struct rio_mport *port, u16 destid, u8 hopcount, u16 did)
+static void rio_set_device_id(struct rio_mport *port, u16 destid, u8 hopcount, u16 did)
 {
 	rio_mport_write_config_32(port, destid, hopcount, RIO_DID_CSR,
 				  RIO_SET_DID(did));
@@ -192,23 +190,9 @@ static int rio_enum_host(struct rio_mpor
 static int rio_device_has_destid(struct rio_mport *port, int src_ops,
 				 int dst_ops)
 {
-	if (((src_ops & RIO_SRC_OPS_READ) ||
-	     (src_ops & RIO_SRC_OPS_WRITE) ||
-	     (src_ops & RIO_SRC_OPS_ATOMIC_TST_SWP) ||
-	     (src_ops & RIO_SRC_OPS_ATOMIC_INC) ||
-	     (src_ops & RIO_SRC_OPS_ATOMIC_DEC) ||
-	     (src_ops & RIO_SRC_OPS_ATOMIC_SET) ||
-	     (src_ops & RIO_SRC_OPS_ATOMIC_CLR)) &&
-	    ((dst_ops & RIO_DST_OPS_READ) ||
-	     (dst_ops & RIO_DST_OPS_WRITE) ||
-	     (dst_ops & RIO_DST_OPS_ATOMIC_TST_SWP) ||
-	     (dst_ops & RIO_DST_OPS_ATOMIC_INC) ||
-	     (dst_ops & RIO_DST_OPS_ATOMIC_DEC) ||
-	     (dst_ops & RIO_DST_OPS_ATOMIC_SET) ||
-	     (dst_ops & RIO_DST_OPS_ATOMIC_CLR))) {
-		return 1;
-	} else
-		return 0;
+	u32 mask = RIO_OPS_READ | RIO_OPS_WRITE | RIO_OPS_ATOMIC_TST_SWP | RIO_OPS_ATOMIC_INC | RIO_OPS_ATOMIC_DEC | RIO_OPS_ATOMIC_SET | RIO_OPS_ATOMIC_CLR;
+
+	return !!((src_ops | dst_ops) & mask);
 }
 
 /**
@@ -383,8 +367,9 @@ static struct rio_dev *rio_setup_device(
 	rdev->dev.release = rio_release_dev;
 	rio_dev_get(rdev);
 
-	rdev->dev.dma_mask = (u64 *) 0xffffffff;
-	rdev->dev.coherent_dma_mask = 0xffffffffULL;
+	rdev->dma_mask = DMA_32BIT_MASK;
+	rdev->dev.dma_mask = &rdev->dma_mask;
+	rdev->dev.coherent_dma_mask = DMA_32BIT_MASK;
 
 	if ((rdev->pef & RIO_PEF_INB_DOORBELL) &&
 	    (rdev->dst_ops & RIO_DST_OPS_DOORBELL))
diff --git a/drivers/rapidio/rio.h b/drivers/rapidio/rio.h
--- a/drivers/rapidio/rio.h
+++ b/drivers/rapidio/rio.h
@@ -26,6 +26,9 @@ extern int rio_disc_mport(struct rio_mpo
 extern struct device_attribute rio_dev_attrs[];
 extern spinlock_t rio_global_list_lock;
 
+extern struct rio_route_ops __start_rio_route_ops[];
+extern struct rio_route_ops __end_rio_route_ops[];
+
 /* Helpers internal to the RIO core code */
 #define DECLARE_RIO_ROUTE_SECTION(section, vid, did, add_hook, get_hook)  \
         static struct rio_route_ops __rio_route_ops __attribute_used__   \
diff --git a/include/linux/rio.h b/include/linux/rio.h
--- a/include/linux/rio.h
+++ b/include/linux/rio.h
@@ -91,6 +91,7 @@ struct rio_mport;
  * @swpinfo: Switch port info
  * @src_ops: Source operation capabilities
  * @dst_ops: Destination operation capabilities
+ * @dma_mask: Mask of bits of RIO address this device implements
  * @rswitch: Pointer to &struct rio_switch if valid for this device
  * @driver: Driver claiming this device
  * @dev: Device model device
@@ -112,6 +113,7 @@ struct rio_dev {
 	u32 swpinfo;		/* Only used for switches */
 	u32 src_ops;
 	u32 dst_ops;
+	u64 dma_mask;
 	struct rio_switch *rswitch;	/* RIO switch info */
 	struct rio_driver *driver;	/* RIO driver claiming this device */
 	struct device dev;	/* LDM device structure */
diff --git a/include/linux/rio_regs.h b/include/linux/rio_regs.h
--- a/include/linux/rio_regs.h
+++ b/include/linux/rio_regs.h
@@ -78,6 +78,19 @@
 #define  RIO_DST_OPS_ATOMIC_CLR		0x00000010	/* [I] Atomic clr op */
 #define  RIO_DST_OPS_PORT_WRITE		0x00000004	/* [I] Port-write op */
 
+#define  RIO_OPS_READ			0x00008000	/* [I] Read op */
+#define  RIO_OPS_WRITE			0x00004000	/* [I] Write op */
+#define  RIO_OPS_STREAM_WRITE		0x00002000	/* [I] Str-write op */
+#define  RIO_OPS_WRITE_RESPONSE		0x00001000	/* [I] Write/resp op */
+#define  RIO_OPS_DATA_MSG		0x00000800	/* [II] Data msg op */
+#define  RIO_OPS_DOORBELL		0x00000400	/* [II] Doorbell op */
+#define  RIO_OPS_ATOMIC_TST_SWP		0x00000100	/* [I] Atomic TAS op */
+#define  RIO_OPS_ATOMIC_INC		0x00000080	/* [I] Atomic inc op */
+#define  RIO_OPS_ATOMIC_DEC		0x00000040	/* [I] Atomic dec op */
+#define  RIO_OPS_ATOMIC_SET		0x00000020	/* [I] Atomic set op */
+#define  RIO_OPS_ATOMIC_CLR		0x00000010	/* [I] Atomic clr op */
+#define  RIO_OPS_PORT_WRITE		0x00000004	/* [I] Port-write op */
+
 					/* 0x20-0x3c *//* Reserved */
 
 #define RIO_MBOX_CSR		0x40	/* [II] Mailbox CSR */
