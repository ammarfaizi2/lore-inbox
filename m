Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWJAP4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWJAP4q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 11:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWJAP4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 11:56:46 -0400
Received: from havoc.gtf.org ([69.61.125.42]:8172 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751211AbWJAP4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 11:56:46 -0400
Date: Sun, 1 Oct 2006 11:56:36 -0400
From: Jeff Garzik <jeff@garzik.org>
To: markus.lidel@shadowconnect.com, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] I2O: mark i2o_config broken on 64-bit
Message-ID: <20061001155636.GA6836@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Code comments, reading the code, and gcc warnings all indicate that this
module isn't safe at all on 64-bit.

Disable this one I2O module on 64-bit, and update the bug indicator
comments to be to more grep-able.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/drivers/message/i2o/Kconfig b/drivers/message/i2o/Kconfig
index 6443392..0661599 100644
--- a/drivers/message/i2o/Kconfig
+++ b/drivers/message/i2o/Kconfig
@@ -56,7 +56,7 @@ config I2O_EXT_ADAPTEC_DMA64
 
 config I2O_CONFIG
 	tristate "I2O Configuration support"
-	depends on I2O
+	depends on I2O && 32BIT
 	---help---
 	  Say Y for support of the configuration interface for the I2O adapters.
 	  If you have a RAID controller from Adaptec and you want to use the
diff --git a/drivers/message/i2o/i2o_config.c b/drivers/message/i2o/i2o_config.c
index 7d23e08..69666e8 100644
--- a/drivers/message/i2o/i2o_config.c
+++ b/drivers/message/i2o/i2o_config.c
@@ -600,7 +600,7 @@ static int i2o_cfg_passthru32(struct fil
 			rcode = -EFAULT;
 			goto cleanup;
 		}
-		// TODO 64bit fix
+		// FIXME: broken on 64-bit
 		sg = (struct sg_simple_element *)((&msg->u.head[0]) +
 						  sg_offset);
 		sg_count =
@@ -640,7 +640,7 @@ static int i2o_cfg_passthru32(struct fil
 			/* Copy in the user's SG buffer if necessary */
 			if (sg[i].
 			    flag_count & 0x04000000 /*I2O_SGL_FLAGS_DIR */ ) {
-				// TODO 64bit fix
+				// FIXME: broken on 64-bit
 				if (copy_from_user
 				    (p->virt,
 				     (void __user *)(unsigned long)sg[i].
@@ -652,7 +652,7 @@ static int i2o_cfg_passthru32(struct fil
 					goto sg_list_cleanup;
 				}
 			}
-			//TODO 64bit fix
+			//FIXME: broken on 64-bit
 			sg[i].addr_bus = (u32) p->phys;
 		}
 	}
@@ -667,7 +667,7 @@ static int i2o_cfg_passthru32(struct fil
 		u32 msg[I2O_OUTBOUND_MSG_FRAME_SIZE];
 		/* Copy back the Scatter Gather buffers back to user space */
 		u32 j;
-		// TODO 64bit fix
+		// FIXME: broken on 64-bit
 		struct sg_simple_element *sg;
 		int sg_size;
 
@@ -688,7 +688,7 @@ static int i2o_cfg_passthru32(struct fil
 		sg_count =
 		    (size - sg_offset * 4) / sizeof(struct sg_simple_element);
 
-		// TODO 64bit fix
+		// FIXME: broken on 64-bit
 		sg = (struct sg_simple_element *)(msg + sg_offset);
 		for (j = 0; j < sg_count; j++) {
 			/* Copy out the SG list to user's buffer if necessary */
@@ -696,7 +696,7 @@ static int i2o_cfg_passthru32(struct fil
 			    (sg[j].
 			     flag_count & 0x4000000 /*I2O_SGL_FLAGS_DIR */ )) {
 				sg_size = sg[j].flag_count & 0xffffff;
-				// TODO 64bit fix
+				// FIXME: broken on 64-bit
 				if (copy_to_user
 				    ((void __user *)(u64) sg[j].addr_bus,
 				     sg_list[j].virt, sg_size)) {
@@ -833,7 +833,7 @@ static int i2o_cfg_passthru(unsigned lon
 			rcode = -EFAULT;
 			goto cleanup;
 		}
-		// TODO 64bit fix
+		// FIXME: broken on 64-bit
 		sg = (struct sg_simple_element *)((&msg->u.head[0]) +
 						  sg_offset);
 		sg_count =
@@ -870,7 +870,7 @@ static int i2o_cfg_passthru(unsigned lon
 			/* Copy in the user's SG buffer if necessary */
 			if (sg[i].
 			    flag_count & 0x04000000 /*I2O_SGL_FLAGS_DIR */ ) {
-				// TODO 64bit fix
+				// FIXME: broken on 64-bit
 				if (copy_from_user
 				    (p, (void __user *)sg[i].addr_bus,
 				     sg_size)) {
@@ -881,7 +881,7 @@ static int i2o_cfg_passthru(unsigned lon
 					goto sg_list_cleanup;
 				}
 			}
-			//TODO 64bit fix
+			//FIXME: broken on 64-bit
 			sg[i].addr_bus = virt_to_bus(p);
 		}
 	}
@@ -896,7 +896,7 @@ static int i2o_cfg_passthru(unsigned lon
 		u32 msg[128];
 		/* Copy back the Scatter Gather buffers back to user space */
 		u32 j;
-		// TODO 64bit fix
+		// FIXME: broken on 64-bit
 		struct sg_simple_element *sg;
 		int sg_size;
 
@@ -917,7 +917,7 @@ static int i2o_cfg_passthru(unsigned lon
 		sg_count =
 		    (size - sg_offset * 4) / sizeof(struct sg_simple_element);
 
-		// TODO 64bit fix
+		// FIXME: broken on 64-bit
 		sg = (struct sg_simple_element *)(msg + sg_offset);
 		for (j = 0; j < sg_count; j++) {
 			/* Copy out the SG list to user's buffer if necessary */
@@ -925,7 +925,7 @@ static int i2o_cfg_passthru(unsigned lon
 			    (sg[j].
 			     flag_count & 0x4000000 /*I2O_SGL_FLAGS_DIR */ )) {
 				sg_size = sg[j].flag_count & 0xffffff;
-				// TODO 64bit fix
+				// FIXME: broken on 64-bit
 				if (copy_to_user
 				    ((void __user *)sg[j].addr_bus, sg_list[j],
 				     sg_size)) {
