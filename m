Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132139AbQK2Wrt>; Wed, 29 Nov 2000 17:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132179AbQK2Wrj>; Wed, 29 Nov 2000 17:47:39 -0500
Received: from m529-mp1-cvx1c.col.ntl.com ([213.104.78.17]:5380 "EHLO
        [213.104.78.17]") by vger.kernel.org with ESMTP id <S132162AbQK2Wrd>;
        Wed, 29 Nov 2000 17:47:33 -0500
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] ISA PnP for Yamaha OPL3-SAx sound driver
From: "John Fremlin" <vii@penguinpowered.com>
Date: 29 Nov 2000 22:16:24 +0000
Message-ID: <m2hf4ql8zr.fsf@localhost.yi.org.>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Support for this card is currently broken for people whose BIOS used
to activate it with ISA PnP, as the kernel now decides to deactivate
it. On 27 Oct 2000 21:48:44 +0100, I sent the maintainer
<scott@spiteful.org> and the mailing list
<linux-sound@vger.kernel.org> this patch, but I didn't get any
replies.  Other people have written (no doubt better) patches to
accomplish the same thing, but somehow none have appeared in the Linus
tree.

This patch implements ISA PnP probe and activate/deactivate for the
OPL3-SAx. As I don't have the specs for this card, I only know that it
works for me; nevertheless, it should not break any configurations as
the PnP probe only kicks in if the resource parameters are not given
as module arguments.  

It should now be possible to compile the driver directly into the
kernel.

The patch is against 2.4.0-test10-pre6, but still applies cleanly to
test12-pre3.

--- linux-orig/drivers/sound/opl3sa2.c	Fri Aug 11 16:26:43 2000
+++ linux/drivers/sound/opl3sa2.c	Fri Oct 27 21:27:16 2000
@@ -33,13 +33,15 @@
  *                         (with thanks to Ben Hutchings for the heuristic),
  *                         removed now unnecessary force option. (Jan 5, 1999)
  * Christoph Hellwig	   Adapted to module_init/module_exit (Mar 4, 2000)
- *
+ * John Fremlin	Do ISA PnP (Oct 27, 2000)
  */
 
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/module.h>
 
+#include <linux/isapnp.h>
+
 #include "sound_config.h"
 
 #include "ad1848.h"
@@ -92,6 +94,10 @@
 	unsigned int   treble;
 } opl3sa2_mixerdata;
 
+#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+static struct pci_dev *pnp_dev;
+#endif
+
 #ifdef CONFIG_OPL3SA2_CTRL_BASE
 /* Set control port if compiled into the kernel */
 static opl3sa2_mixerdata opl3sa2_data = { CONFIG_OPL3SA2_CTRL_BASE, };
@@ -517,11 +523,63 @@
 }
 
 
+static inline void opl3sa2_pnp_deactivate()
+{
+#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE	
+	if(pnp_dev){
+		pnp_dev->deactivate(pnp_dev);
+		pnp_dev=0;
+	}
+#endif	
+}
+
+
+static inline int opl3sa2_pnp_activate(struct address_info *sa2_cfg,
+				       struct address_info *mss_cfg,
+				       struct address_info *mpu_cfg)
+{
+#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE	
+	int ret;
+	
+	opl3sa2_pnp_deactivate();
+	
+	pnp_dev = isapnp_find_dev(NULL,
+			      ISAPNP_VENDOR('Y','M','H'),
+			      ISAPNP_FUNCTION(0x0021),
+			      NULL);
+	if (!pnp_dev)
+		return -ENODEV;
+	if (pnp_dev->active)
+		return -EBUSY;
+	if (pnp_dev->prepare(pnp_dev)<0)
+		return -EAGAIN;
+	if ((ret = pnp_dev->activate(pnp_dev))) {
+		if(ret == -EBUSY){
+			/*already activated*/
+		} else {
+			printk(KERN_ERR "opl3sa2: isapnp configure failed (out of resources?)\n");
+			return -ENOMEM;
+		}
+	}
+
+	sa2_cfg->io_base = pnp_dev->resource[0].start;
+	mss_cfg->io_base = pnp_dev->resource[1].start;
+	/* pnp_dev->resource[2].start is for OPL3 FM*/
+	mpu_cfg->io_base = pnp_dev->resource[3].start;
+	
+	mss_cfg->irq = sa2_cfg->irq = pnp_dev->irq_resource[0].start;
+	mss_cfg->dma = sa2_cfg->dma = pnp_dev->dma_resource[0].start;
+	mss_cfg->dma2 = sa2_cfg->dma2 = pnp_dev->dma_resource[1].start;
+#endif /* defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE	*/
+	return 0;
+}
+
+
 static int __init probe_opl3sa2(struct address_info *hw_config)
 {
 	unsigned char version = 0;
 	char tag;
-
+	
 	/*
 	 * Verify that the I/O port range is free.
 	 */
@@ -605,6 +663,7 @@
 {
         /* Release control ports */
 	release_region(hw_config->io_base, 2);
+	opl3sa2_pnp_deactivate();
 
 	/* Unload mixer */
 	if(opl3sa2_mixer >= 0)
@@ -671,8 +730,8 @@
 	cfg_mpu.always_detect = 1;  /* It's there, so use shared IRQs */
 
 	if(cfg.io_base == -1 || cfg.irq == -1 || cfg.dma == -1 || cfg.dma2 == -1 || cfg2.io_base == -1) {
-		printk(KERN_ERR "opl3sa2: io, mss_io, irq, dma, and dma2 must be set.\n");
-		return -EINVAL;
+		if(opl3sa2_pnp_activate(&cfg,&cfg2,&cfg_mpu)) /* Have a bash at PnP */
+			return -EINVAL;
 	}
 
 	/* Call me paranoid: */


-- 

	http://www.penguinpowered.com/~vii
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
