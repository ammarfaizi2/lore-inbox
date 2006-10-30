Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWJ3MEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWJ3MEN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 07:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWJ3MEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 07:04:13 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:51080 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1750862AbWJ3MEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 07:04:12 -0500
From: "Peter Pearse" <peter.pearse@arm.com>
To: <linux-kernel@vger.kernel.org>
Subject: [RFC 5/7][PATCH] AMBA DMA: Check the result of a probe of the pl080. 
Date: Mon, 30 Oct 2006 12:04:08 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: Acb8G4Cs/ZKrDMj4Qz6w0ChIR8PTDw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Message-ID: <CAM-OWA1bJpdTsj8BH000000006@cam-owa1.Emea.Arm.com>
X-OriginalArrivalTime: 30 Oct 2006 12:04:11.0143 (UTC) FILETIME=[82900170:01C6FC1B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a general rule, the kernel must allow probes to fail,
but we should not insert the PL080 driver if it's probe fails.

Signed-off-by: Peter M Pearse <peter.pearse@arm.com> 

---

diff -purN arm_amba_pl080/drivers/amba/dma.c
arm_amba_pl080err/drivers/amba/dma.c
--- arm_amba_pl080/drivers/amba/dma.c	2006-10-17 17:14:06.000000000 +0100
+++ arm_amba_pl080err/drivers/amba/dma.c	2006-10-18
08:24:03.000000000 +0100
@@ -116,7 +116,7 @@ static struct dma_ops amba_dma_ops = {
 /*
  * Initialize the dma channels, as far as we can
  */
-void amba_init_dma(dma_t *channels)
+int amba_init_dma(dma_t *channels)
 {
 	int i;
 
@@ -135,6 +135,7 @@ void amba_init_dma(dma_t *channels)
 		channels[i].state = 0;
 		channels[i].d_ops = &amba_dma_ops;
 	}
+	return 1;
 }
 EXPORT_SYMBOL(amba_init_dma);
 
diff -purN arm_amba_pl080/drivers/amba/pl080.c
arm_amba_pl080err/drivers/amba/pl080.c
--- arm_amba_pl080/drivers/amba/pl080.c	2006-10-17 17:14:20.000000000 +0100
+++ arm_amba_pl080err/drivers/amba/pl080.c	2006-10-18
08:24:03.000000000 +0100
@@ -237,7 +237,11 @@ pl080_extra_ops pl080_ops = {
  * Complete the DMA channel initialization
  * started by the AMBA DMA code
  * - Set the dma ops for the board to call
+ * Since driver registration disregards any probe errors we 
+ * store the result to prevent registration of an invalid driver
+ * and possible insertion of an invalid module
  */
+static int probe_err = 0;	/* Protected by the device lock */
 static int __devinit pl080_probe(struct amba_device *dev, void *id)
 {
 	int ret,i;
@@ -271,19 +275,25 @@ static int __devinit pl080_probe(struct 
 	if(!(pl080.pool = dma_pool_create(pl080_driver.drv.name, (struct
device *)dev,
 			PL080_MAX_LLIS_SIZE, PL080_ALIGN, PL080_ALLOC))){
 
-		kfree(pl080.chanllis);
 		ret = -ENOMEM;
-		goto out;
+		goto out2;
+	}
+	/* TODO:: Get the parameters from amba_device */
+	if(!pl080_init_dma(dev->chans, dev->dmac_ops)){
+		ret = -EPERM;
+		goto out2;
 	}
-	/* TODO:: Get the parameters from amb_device */
-	pl080_init_dma(dev->chans, dev->dmac_ops);
+
 	pl080_driver.drv.owner = try_find_module(MODULE_NAME);
 	
-	return ret;
+	return (probe_err = ret);
+
+ out2:
+      	kfree(pl080.chanllis);
 
  out:
 	amba_release_regions(dev);
-	return ret;
+	return (probe_err = ret);
 }
 
 static struct amba_id pl080_ids[] = {
@@ -309,26 +319,32 @@ static struct amba_driver pl080_driver =
 
 int pl080_init_dma(dma_t * dma_chan, struct dma_ops * ops){
 	int i;
+	int retval = 0;
 
-	for(i = 0; i < MAX_DMA_CHANNELS; i++){
-		dma_chan[i].dma_base = (unsigned int)pl080.base;
-	}
-	ops->request 	= pl080_request;
-	ops->free	= pl080_free;
-	ops->enable	= pl080_enable ;
-	ops->disable 	= pl080_disable;
-	ops->residue 	= pl080_residue;
-	ops->setspeed 	= pl080_setspeed;
-	ops->type 	= pl080_type;
+	if(ops){
+
+		for(i = 0; i < MAX_DMA_CHANNELS; i++){
+			dma_chan[i].dma_base = (unsigned int)pl080.base;
+		}
+		ops->request 	= pl080_request;
+		ops->free	= pl080_free;
+		ops->enable	= pl080_enable ;
+		ops->disable 	= pl080_disable;
+		ops->residue 	= pl080_residue;
+		ops->setspeed 	= pl080_setspeed;
+		ops->type 	= pl080_type;
 	
-	/* PL080 specific */
-	ops->extra_ops = &pl080_ops;
+		/* PL080 specific */
+		ops->extra_ops = &pl080_ops;
 
-	pl080_driver.dmac_ops = ops;
+		pl080_driver.dmac_ops = ops;
 
-	amba_init_dma(dma_chan);
+		retval = amba_init_dma(dma_chan);
+	} else {
+		printk(KERN_ERR "pl080_init_dma() board has not supplied
operations\n"); 
+	}
 
-	return 0;
+	return retval;
 }
 
 /*
@@ -355,14 +371,20 @@ static int __devexit pl080_remove(struct
 
 /*
  * Module initialization
+ * - probe errors are ignored by driver registration
+ * - force the initialization to fail if the probe fails
  */
 static int __init pl080_init(void)
 {
 	pl080.base = NULL;
 	pl080.chanllis = NULL; /* LLI details for each DMA channel */
 	pl080.pool = NULL;
-	
-	return amba_driver_register(&pl080_driver);
+
+	probe_err = 0;
+
+	amba_driver_register(&pl080_driver);
+
+	return probe_err;
 }
 /*
  * Module destruction
diff -purN arm_amba_pl080/include/linux/amba/dma.h
arm_amba_pl080err/include/linux/amba/dma.h
--- arm_amba_pl080/include/linux/amba/dma.h	2006-10-17
17:14:06.000000000 +0100
+++ arm_amba_pl080err/include/linux/amba/dma.h	2006-10-18
08:24:03.000000000 +0100
@@ -26,7 +26,7 @@ struct amba_dma_data {
 };
 
 extern dma_t *		amba_get_chans	(void);
-extern void		amba_init_dma	(dma_t *channels);
+extern int		amba_init_dma	(dma_t *channels);
 struct amba_device *	amba_get_device_with_name(char * name);
 void			amba_set_ops	(struct dma_ops * ops);



