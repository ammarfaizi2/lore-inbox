Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264112AbUCZS2n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 13:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264115AbUCZS2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 13:28:43 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:17554 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S264112AbUCZSVH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 13:21:07 -0500
Date: Fri, 26 Mar 2004 19:20:49 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (4/7): network driver.
Message-ID: <20040326182049.GE2523@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s390 network driver changes:
 - ctc/lcs/qeth: prevent a ccw-device to be grouped multiple times.
 - icuv: clear correct field in iucv_register_program if no userid is specified.
 - lcs: fix online/offline cycle again.
 - lcs: fix ungrouping of lcs group device. The channels of the lcs card
   should be offline afterwards.
 - lcs: don't do netif_stop_queue if no tx buffer is available, just
   return -EBUSY and drop the packets.

diffstat:
 drivers/s390/cio/ccwgroup.c |   60 +++----
 drivers/s390/net/ctcmain.c  |   11 -
 drivers/s390/net/iucv.c     |   14 -
 drivers/s390/net/lcs.c      |  338 ++++++++++++++++++++++++++------------------
 drivers/s390/net/lcs.h      |   21 ++
 drivers/s390/net/netiucv.c  |   11 -
 drivers/s390/net/qeth.c     |   11 -
 drivers/s390/net/qeth.h     |    2 
 8 files changed, 270 insertions(+), 198 deletions(-)

diff -urN linux-2.6/drivers/s390/cio/ccwgroup.c linux-2.6-s390/drivers/s390/cio/ccwgroup.c
--- linux-2.6/drivers/s390/cio/ccwgroup.c	Thu Mar 11 03:55:28 2004
+++ linux-2.6-s390/drivers/s390/cio/ccwgroup.c	Fri Mar 26 18:25:57 2004
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/ccwgroup.c
  *  bus driver for ccwgroup
- *   $Revision: 1.24 $
+ *   $Revision: 1.25 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *                       IBM Corporation
@@ -102,8 +102,10 @@
 
 	gdev = to_ccwgroupdev(dev);
 
-	for (i = 0; i < gdev->count; i++)
+	for (i = 0; i < gdev->count; i++) {
+		gdev->cdev[i]->dev.driver_data = NULL;
 		put_device(&gdev->cdev[i]->dev);
+	}
 	kfree(gdev);
 }
 
@@ -155,6 +157,7 @@
 	struct ccwgroup_device *gdev;
 	int i;
 	int rc;
+	int del_drvdata;
 
 	if (argc > 256) /* disallow dumb users */
 		return -EINVAL;
@@ -166,6 +169,7 @@
 	memset(gdev, 0, sizeof(*gdev) + argc*sizeof(gdev->cdev[0]));
 	atomic_set(&gdev->onoff, 0);
 
+	del_drvdata = 0;
 	for (i = 0; i < argc; i++) {
 		gdev->cdev[i] = get_ccwdev_by_busid(cdrv, argv[i]);
 
@@ -177,7 +181,15 @@
 			rc = -EINVAL;
 			goto error;
 		}
+		/* Don't allow a device to belong to more than one group. */
+		if (gdev->cdev[i]->dev.driver_data) {
+			rc = -EINVAL;
+			goto error;
+		}
 	}
+	for (i = 0; i < argc; i++)
+		gdev->cdev[i]->dev.driver_data = gdev;
+	del_drvdata = 1;
 
 	*gdev = (struct ccwgroup_device) {
 		.creator_id = creator_id,
@@ -212,9 +224,11 @@
 	device_unregister(&gdev->dev);
 error:
 	for (i = 0; i < argc; i++)
-		if (gdev->cdev[i])
+		if (gdev->cdev[i]) {
 			put_device(&gdev->cdev[i]->dev);
-
+			if (del_drvdata)
+				gdev->cdev[i]->dev.driver_data = NULL;
+		}
 	kfree(gdev);
 
 	return rc;
@@ -399,40 +413,14 @@
 __ccwgroup_get_gdev_by_cdev(struct ccw_device *cdev)
 {
 	struct ccwgroup_device *gdev;
-	struct list_head *entry;
-	struct device *dev;
-	int i, found;
-
-	/*
-	 * Find groupdevice cdev belongs to.
-	 * Unfortunately, we can't use bus_for_each_dev() because of the
-	 * semaphore (and return value of fn() is int).
-	 */
-	if (!get_bus(&ccwgroup_bus_type))
-		return NULL;
-
-	gdev = NULL;
-	down_read(&ccwgroup_bus_type.subsys.rwsem);
 
-	list_for_each(entry, &ccwgroup_bus_type.devices.list) {
-		dev = get_device(container_of(entry, struct device, bus_list));
-		found = 0;
-		if (!dev)
-			continue;
-		gdev = to_ccwgroupdev(dev);
-		for (i = 0; i < gdev->count && (!found); i++) {
-			if (gdev->cdev[i] == cdev)
-				found = 1;
-		}
-		if (found)
-			break;
-		put_device(dev);
-		gdev = NULL;
+	if (cdev->dev.driver_data) {
+		gdev = (struct ccwgroup_device *)cdev->dev.driver_data;
+		if (get_device(&gdev->dev))
+			return gdev;
+		return NULL;
 	}
-	up_read(&ccwgroup_bus_type.subsys.rwsem);
-	put_bus(&ccwgroup_bus_type);
-
-	return gdev;
+	return NULL;
 }
 
 void
diff -urN linux-2.6/drivers/s390/net/ctcmain.c linux-2.6-s390/drivers/s390/net/ctcmain.c
--- linux-2.6/drivers/s390/net/ctcmain.c	Fri Mar 26 18:24:55 2004
+++ linux-2.6-s390/drivers/s390/net/ctcmain.c	Fri Mar 26 18:25:57 2004
@@ -1,5 +1,5 @@
 /*
- * $Id: ctcmain.c,v 1.57 2004/03/02 15:34:01 mschwide Exp $
+ * $Id: ctcmain.c,v 1.58 2004/03/24 10:51:56 ptiedem Exp $
  *
  * CTC / ESCON network driver
  *
@@ -36,7 +36,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.57 $
+ * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.58 $
  *
  */
 
@@ -319,7 +319,7 @@
 print_banner(void)
 {
 	static int printed = 0;
-	char vbuf[] = "$Revision: 1.57 $";
+	char vbuf[] = "$Revision: 1.58 $";
 	char *version = vbuf;
 
 	if (printed)
@@ -2067,7 +2067,8 @@
 		return;
 	}
 	
-	priv = cdev->dev.driver_data;
+	priv = ((struct ccwgroup_device *)cdev->dev.driver_data)
+		->dev.driver_data;
 
 	/* Try to extract channel from driver data. */
 	if (priv->channel[READ]->cdev == cdev)
@@ -2963,8 +2964,6 @@
 	cgdev->cdev[0]->handler = ctc_irq_handler;
 	cgdev->cdev[1]->handler = ctc_irq_handler;
 	cgdev->dev.driver_data = priv;
-	cgdev->cdev[0]->dev.driver_data = priv;
-	cgdev->cdev[1]->dev.driver_data = priv;
 
 	return 0;
 }
diff -urN linux-2.6/drivers/s390/net/iucv.c linux-2.6-s390/drivers/s390/net/iucv.c
--- linux-2.6/drivers/s390/net/iucv.c	Fri Mar 26 18:24:55 2004
+++ linux-2.6-s390/drivers/s390/net/iucv.c	Fri Mar 26 18:25:57 2004
@@ -1,5 +1,5 @@
 /* 
- * $Id: iucv.c,v 1.26 2004/03/10 11:55:31 braunu Exp $
+ * $Id: iucv.c,v 1.27 2004/03/22 07:43:43 braunu Exp $
  *
  * IUCV network driver
  *
@@ -29,7 +29,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.26 $
+ * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.27 $
  *
  */
 
@@ -351,7 +351,7 @@
 static void
 iucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.26 $";
+	char vbuf[] = "$Revision: 1.27 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
@@ -374,14 +374,14 @@
 {
 	int ret;
 
+	if (iucv_external_int_buffer)
+		return 0;
+
 	if (!MACHINE_IS_VM) {
 		printk(KERN_ERR "IUCV: IUCV connection needs VM as base\n");
 		return -EPROTONOSUPPORT;
 	}
 
-	if (iucv_external_int_buffer)
-		return 0;
-
 	ret = bus_register(&iucv_bus);
 	if (ret != 0) {
 		printk(KERN_ERR "IUCV: failed to register bus.\n");
@@ -830,7 +830,7 @@
 			memset (new_handler->id.mask, 0xFF,
 				sizeof (new_handler->id.mask));
 		}
-		memset (new_handler->id.mask, 0x00,
+		memset (new_handler->id.userid, 0x00,
 			sizeof (new_handler->id.userid));
 	}
 	/* fill in the rest of handler */
diff -urN linux-2.6/drivers/s390/net/lcs.c linux-2.6-s390/drivers/s390/net/lcs.c
--- linux-2.6/drivers/s390/net/lcs.c	Fri Mar 26 18:24:55 2004
+++ linux-2.6-s390/drivers/s390/net/lcs.c	Fri Mar 26 18:25:58 2004
@@ -11,7 +11,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Martin Schwidefsky <schwidefsky@de.ibm.com>
  *
- *    $Revision: 1.68 $	 $Date: 2004/03/02 15:34:01 $
+ *    $Revision: 1.72 $	 $Date: 2004/03/22 09:34:27 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -58,9 +58,10 @@
 /**
  * initialization string for output
  */
-#define VERSION_LCS_C  "$Revision: 1.68 $"
+#define VERSION_LCS_C  "$Revision: 1.72 $"
 
 static char version[] __initdata = "LCS driver ("VERSION_LCS_C "/" VERSION_LCS_H ")";
+static char debug_buffer[255];
 
 /**
  * Some prototypes.
@@ -112,7 +113,7 @@
 {
 	int cnt;
 
-	LCS_DBF_TEXT(3, setup, "ichalloc");
+	LCS_DBF_TEXT(2, setup, "ichalloc");
 	for (cnt = 0; cnt < LCS_NUM_BUFFS; cnt++) {
 		/* alloc memory fo iobuffer */
 		channel->iob[cnt].data = (void *)
@@ -124,7 +125,7 @@
 	}
 	if (cnt < LCS_NUM_BUFFS) {
 		/* Not all io buffers could be allocated. */
-		LCS_DBF_TEXT(3, setup, "echalloc");
+		LCS_DBF_TEXT(2, setup, "echalloc");
 		while (cnt-- > 0)
 			kfree(channel->iob[cnt].data);
 		return -ENOMEM;
@@ -140,7 +141,7 @@
 {
 	int cnt;
 
-	LCS_DBF_TEXT(3, setup, "ichfree");
+	LCS_DBF_TEXT(2, setup, "ichfree");
 	for (cnt = 0; cnt < LCS_NUM_BUFFS; cnt++) {
 		if (channel->iob[cnt].data != NULL)
 			kfree(channel->iob[cnt].data);
@@ -148,6 +149,30 @@
 	}
 }
 
+/*
+ * Cleanup channel.
+ */
+static void
+lcs_cleanup_channel(struct lcs_channel *channel)
+{
+	LCS_DBF_TEXT(3, setup, "cleanch");
+	/* Kill write channel tasklets. */
+	tasklet_kill(&channel->irq_tasklet);
+	/* Free channel buffers. */
+	lcs_free_channel(channel);
+}
+
+/**
+ * LCS free memory for card and channels.
+ */
+static void
+lcs_free_card(struct lcs_card *card)
+{
+	LCS_DBF_TEXT(2, setup, "remcard");
+	LCS_DBF_HEX(2, setup, &card, sizeof(void*));
+	kfree(card);
+}
+
 /**
  * LCS alloc memory for card and channels
  */
@@ -155,25 +180,34 @@
 lcs_alloc_card(void)
 {
 	struct lcs_card *card;
-
-	LCS_DBF_TEXT(3, setup, "alloclcs");
+	int rc;
+	
+	LCS_DBF_TEXT(2, setup, "alloclcs");
+	
 	card = kmalloc(sizeof(struct lcs_card), GFP_KERNEL | GFP_DMA);
 	if (card == NULL)
 		return NULL;
 	memset(card, 0, sizeof(struct lcs_card));
 	card->lan_type = LCS_FRAME_TYPE_AUTO;
 	card->lancmd_timeout = LCS_LANCMD_TIMEOUT_DEFAULT;
-	return card;
-}
+	/* Allocate io buffers for the read channel. */
+	rc = lcs_alloc_channel(&card->read);
+	if (rc){
+		LCS_DBF_TEXT(2, setup, "iccwerr");
+		lcs_free_card(card);
+		return NULL;
+	}
+	/* Allocate io buffers for the write channel. */
+	rc = lcs_alloc_channel(&card->write);
+	if (rc) {
+		LCS_DBF_TEXT(2, setup, "iccwerr");
+		lcs_cleanup_channel(&card->read);
+		lcs_free_card(card);
+		return NULL;
+	}
 
-/**
- * LCS free memory for card and channels.
- */
-static void
-lcs_free_card(struct lcs_card *card)
-{
-	LCS_DBF_TEXT(2, setup, "remcard");
-	kfree(card);
+	LCS_DBF_HEX(2, setup, &card, sizeof(void*));
+	return card;
 }
 
 /*
@@ -218,25 +252,17 @@
 	card->read.buf_idx = 0;
 }
 
-static int
+static void 
 lcs_setup_read(struct lcs_card *card)
 {
-	int rc;
+	LCS_DBF_TEXT(3, setup, "initread");
 
-	LCS_DBF_TEXT(3, setup, "readirq");
-	/* Allocate io buffers for the read channel. */
-	rc = lcs_alloc_channel(&card->read);
-	if (rc){
-		LCS_DBF_TEXT(3, setup, "iccwerr");
-		return rc;
-	}
 	lcs_setup_read_ccws(card);
 	/* Initialize read channel tasklet. */
 	card->read.irq_tasklet.data = (unsigned long) &card->read;
 	card->read.irq_tasklet.func = lcs_tasklet;
 	/* Initialize waitqueue. */
 	init_waitqueue_head(&card->read.wait_q);
-	return 0;
 }
 
 /*
@@ -247,7 +273,7 @@
 {
 	int cnt;
 
-	LCS_DBF_TEXT(2, setup, "iwritccw");
+	LCS_DBF_TEXT(3, setup, "iwritccw");
 	/* Setup write ccws. */
 	memset(card->write.ccws, 0, sizeof(struct ccw1) * LCS_NUM_BUFFS + 1);
 	for (cnt = 0; cnt < LCS_NUM_BUFFS; cnt++) {
@@ -273,61 +299,32 @@
 	card->write.buf_idx = 0;
 }
 
-static int
+static void 
 lcs_setup_write(struct lcs_card *card)
 {
-	int rc;
+	LCS_DBF_TEXT(3, setup, "initwrit");
 
-	LCS_DBF_TEXT(3, setup, "writeirq");
-	/* Allocate io buffers for the write channel. */
-	rc = lcs_alloc_channel(&card->write);
-	if (rc) {
-		LCS_DBF_TEXT(3, setup, "iccwerr");
-		return rc;
-	}
 	lcs_setup_write_ccws(card);
 	/* Initialize write channel tasklet. */
 	card->write.irq_tasklet.data = (unsigned long) &card->write;
 	card->write.irq_tasklet.func = lcs_tasklet;
 	/* Initialize waitqueue. */
 	init_waitqueue_head(&card->write.wait_q);
-	return 0;
 }
 
-/*
- * Cleanup channel.
- */
-static void
-lcs_cleanup_channel(struct lcs_channel *channel)
-{
-	LCS_DBF_TEXT(3, setup, "cleanch");
-	/* Kill write channel tasklets. */
-	tasklet_kill(&channel->irq_tasklet);
-	/* Free channel buffers. */
-	lcs_free_channel(channel);
-}
+
 
 /**
  * Initialize channels,card and state machines.
  */
-static int
+static void
 lcs_setup_card(struct lcs_card *card)
 {
-	int rc;
-
-	LCS_DBF_TEXT(3, setup, "initcard");
-
-	rc = lcs_setup_read(card);
-	if (rc) {
-		PRINT_ERR("Could not initialize read channel\n");
-		return rc;
-	}
-	rc = lcs_setup_write(card);
-	if (rc) {
-		PRINT_ERR("Could not initialize write channel\n");
-		lcs_cleanup_channel(&card->read);
-		return rc;
-	}
+	LCS_DBF_TEXT(2, setup, "initcard");
+	LCS_DBF_HEX(2, setup, &card, sizeof(void*));
+	
+	lcs_setup_read(card);
+	lcs_setup_write(card);
 	/* Set cards initial state. */
 	card->state = DEV_STATE_DOWN;
 	card->tx_buffer = NULL;
@@ -342,7 +339,6 @@
 	INIT_LIST_HEAD(&card->ipm_list);
 #endif
 	INIT_LIST_HEAD(&card->lancmd_waiters);
-	return 0;
 }
 
 /**
@@ -355,6 +351,7 @@
 	struct lcs_ipm_list *ipm_list;
 
 	LCS_DBF_TEXT(3, setup, "cleancrd");
+	LCS_DBF_HEX(2,setup,&card,sizeof(void*));
 #ifdef	CONFIG_IP_MULTICAST
 	/* Free multicast list. */
 	list_for_each_safe(l, n, &card->ipm_list) {
@@ -376,12 +373,10 @@
 static int
 lcs_start_channel(struct lcs_channel *channel)
 {
-	char dbf_text[15];
 	unsigned long flags;
 	int rc;
 
-	sprintf(dbf_text,"ssch%s", channel->ccwdev->dev.bus_id);
-	LCS_DBF_TEXT(4, trace, dbf_text);
+	LCS_DBF_TEXT_(4,trace,"ssch%s", channel->ccwdev->dev.bus_id);
 	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
 	rc = ccw_device_start(channel->ccwdev,
 			      channel->ccws + channel->io_idx, 0, 0,
@@ -390,37 +385,56 @@
 		channel->state = CH_STATE_RUNNING;
 	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
 	if (rc) {
-		sprintf(dbf_text,"essc%s", channel->ccwdev->dev.bus_id);
-		LCS_DBF_TEXT(4, trace, dbf_text);
+		LCS_DBF_TEXT_(4,trace,"essh%s", channel->ccwdev->dev.bus_id);
 		PRINT_ERR("Error in starting channel, rc=%d!\n", rc);
 	}
 	return rc;
 }
 
+static int 
+lcs_clear_channel(struct lcs_channel *channel)
+{
+	unsigned long flags;
+	int rc;
+
+	LCS_DBF_TEXT(4,trace,"clearch");
+	LCS_DBF_TEXT_(4,trace,"%s", channel->ccwdev->dev.bus_id);
+	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
+	rc = ccw_device_clear(channel->ccwdev, (addr_t) channel);
+	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
+	if (rc) {
+		LCS_DBF_TEXT_(4,trace,"ecsc%s", channel->ccwdev->dev.bus_id);
+		return rc;
+	}
+	wait_event(channel->wait_q, (channel->state == CH_STATE_CLEARED));
+	channel->state = CH_STATE_STOPPED;
+	return rc;
+}
+
+
 /**
  * Stop channel.
  */
 static int
 lcs_stop_channel(struct lcs_channel *channel)
 {
-	char dbf_text[15];
 	unsigned long flags;
 	int rc;
 
 	if (channel->state == CH_STATE_STOPPED)
 		return 0;
-	sprintf(dbf_text,"hsch%s", channel->ccwdev->dev.bus_id);
-	LCS_DBF_TEXT(4, trace, dbf_text);
+	LCS_DBF_TEXT(4,trace,"haltsch");
+	LCS_DBF_TEXT_(4,trace,"%s", channel->ccwdev->dev.bus_id);
 	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
 	rc = ccw_device_halt(channel->ccwdev, (addr_t) channel);
 	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
 	if (rc) {
-		sprintf(dbf_text,"ehsc%s", channel->ccwdev->dev.bus_id);
-		LCS_DBF_TEXT(4, trace, dbf_text);
+		LCS_DBF_TEXT_(4,trace,"ehsc%s", channel->ccwdev->dev.bus_id);
 		return rc;
 	}
 	/* Asynchronous halt initialted. Wait for its completion. */
 	wait_event(channel->wait_q, (channel->state == CH_STATE_HALTED));
+	lcs_clear_channel(channel);
 	return 0;
 }
 
@@ -464,6 +478,7 @@
 {
 	int index;
 
+	LCS_DBF_TEXT(5, trace, "_getbuff");
 	index = channel->io_idx;
 	do {
 		if (channel->iob[index].state == BUF_STATE_EMPTY) {
@@ -481,6 +496,7 @@
 	struct lcs_buffer *buffer;
 	unsigned long flags;
 
+	LCS_DBF_TEXT(5, trace, "getbuff");
 	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
 	buffer = __lcs_get_buffer(channel);
 	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
@@ -493,19 +509,16 @@
 static int
 __lcs_resume_channel(struct lcs_channel *channel)
 {
-	char dbf_text[15];
 	int rc;
 
 	if (channel->state != CH_STATE_SUSPENDED)
 		return 0;
 	if (channel->ccws[channel->io_idx].flags & CCW_FLAG_SUSPEND)
 		return 0;
-	sprintf(dbf_text,"rsch%s", channel->ccwdev->dev.bus_id);
-	LCS_DBF_TEXT(4, trace, dbf_text);
+	LCS_DBF_TEXT_(5, trace, "rsch%s", channel->ccwdev->dev.bus_id);
 	rc = ccw_device_resume(channel->ccwdev);
 	if (rc) {
-		sprintf(dbf_text,"ersc%s", channel->ccwdev->dev.bus_id);
-		LCS_DBF_TEXT(4, trace, dbf_text);
+		LCS_DBF_TEXT_(4, trace, "ersc%s", channel->ccwdev->dev.bus_id);
 		PRINT_ERR("Error in lcs_resume_channel: rc=%d\n",rc);
 	} else
 		channel->state = CH_STATE_RUNNING;
@@ -521,6 +534,7 @@
 {
 	int prev, next;
 
+	LCS_DBF_TEXT(5, trace, "rdybits");
 	prev = (index - 1) & (LCS_NUM_BUFFS - 1);
 	next = (index + 1) & (LCS_NUM_BUFFS - 1);
 	/* Check if we may clear the suspend bit of this buffer. */
@@ -540,6 +554,7 @@
 	unsigned long flags;
 	int index, rc;
 
+	LCS_DBF_TEXT(5, trace, "rdybuff");
 	if (buffer->state != BUF_STATE_LOCKED &&
 	    buffer->state != BUF_STATE_PROCESSED)
 		BUG();
@@ -565,6 +580,7 @@
 {
 	int index, prev, next;
 
+	LCS_DBF_TEXT(5, trace, "prcsbuff");
 	if (buffer->state != BUF_STATE_READY)
 		BUG();
 	buffer->state = BUF_STATE_PROCESSED;
@@ -597,6 +613,7 @@
 {
 	unsigned long flags;
 
+	LCS_DBF_TEXT(5, trace, "relbuff");
 	if (buffer->state != BUF_STATE_LOCKED &&
 	    buffer->state != BUF_STATE_PROCESSED)
 		BUG();
@@ -614,6 +631,7 @@
 	struct lcs_buffer *buffer;
 	struct lcs_cmd *cmd;
 
+	LCS_DBF_TEXT(4, trace, "getlncmd");
 	/* Get buffer and wait if none is available. */
 	wait_event(card->write.wait_q,
 		   ((buffer = lcs_get_buffer(&card->write)) != NULL));
@@ -637,6 +655,7 @@
 	struct list_head *l, *n;
 	struct lcs_reply *reply;
 
+	LCS_DBF_TEXT(4, trace, "notiwait");
 	spin_lock(&card->lock);
 	list_for_each_safe(l, n, &card->lancmd_waiters) {
 		reply = list_entry(l, struct lcs_reply, list);
@@ -661,6 +680,7 @@
 {
 	struct lcs_reply *reply;
 
+	LCS_DBF_TEXT(4, trace, "timeout");
 	reply = (struct lcs_reply *) data;
 	list_del(&reply->list);
 	reply->received = 1;
@@ -676,8 +696,8 @@
 	struct lcs_cmd *cmd;
 	struct timer_list timer;
 	int rc;
-	char buf[16];
 
+	LCS_DBF_TEXT(4, trace, "sendcmd");
 	cmd = (struct lcs_cmd *) buffer->data;
 	cmd->sequence_no = ++card->sequence_no;
 	cmd->return_code = 0;
@@ -700,9 +720,7 @@
 	add_timer(&timer);
 	wait_event(reply.wait_q, reply.received);
 	del_timer(&timer);
-	LCS_DBF_TEXT(5, trace, "sendcmd");
-	sprintf(buf, "rc:%d", reply.rc);
-	LCS_DBF_TEXT(5, trace, buf);
+	LCS_DBF_TEXT_(4, trace, "rc:%d",reply.rc);
 	return reply.rc ? -EIO : 0;
 }
 
@@ -747,6 +765,7 @@
 static void
 __lcs_lanstat_cb(struct lcs_card *card, struct lcs_cmd *cmd)
 {
+	LCS_DBF_TEXT(2, trace, "statcb");
 	memcpy(card->mac, cmd->cmd.lcs_lanstat_cmd.mac_addr, LCS_MAC_LENGTH);
 }
 
@@ -756,7 +775,7 @@
 	struct lcs_buffer *buffer;
 	struct lcs_cmd *cmd;
 
-	LCS_DBF_TEXT(2, trace, "cmdstat");
+	LCS_DBF_TEXT(2,trace, "cmdstat");
 	buffer = lcs_get_lancmd(card, LCS_STD_CMD_SIZE);
 	cmd = (struct lcs_cmd *) buffer->data;
 	/* Setup lanstat command. */
@@ -792,6 +811,7 @@
 static void
 __lcs_send_startlan_cb(struct lcs_card *card, struct lcs_cmd *cmd)
 {
+	LCS_DBF_TEXT(2, trace, "srtlancb");
 	card->lan_type = cmd->cmd.lcs_std_cmd.lan_type;
 	card->portno = cmd->cmd.lcs_std_cmd.portno;
 }
@@ -833,6 +853,7 @@
 	cmd->cmd.lcs_qipassist.num_ip_pairs = 1;
 	memcpy(cmd->cmd.lcs_qipassist.lcs_ipass_ctlmsg.ip_mac_pair,
 	       &ipm_list->ipm, sizeof (struct lcs_ip_mac_pair));
+	LCS_DBF_TEXT_(2, trace, "%x",ipm_list->ipm.ip_addr);
 	return lcs_send_lancmd(card, buffer, NULL);
 }
 
@@ -856,6 +877,7 @@
 	cmd->cmd.lcs_qipassist.num_ip_pairs = 1;
 	memcpy(cmd->cmd.lcs_qipassist.lcs_ipass_ctlmsg.ip_mac_pair,
 	       &ipm_list->ipm, sizeof (struct lcs_ip_mac_pair));
+	LCS_DBF_TEXT_(2, trace, "%x",ipm_list->ipm.ip_addr);
 	return lcs_send_lancmd(card, buffer, NULL);
 }
 
@@ -865,6 +887,7 @@
 static void
 __lcs_check_multicast_cb(struct lcs_card *card, struct lcs_cmd *cmd)
 {
+	LCS_DBF_TEXT(2, trace, "chkmccb");
 	card->ip_assists_supported =
 		cmd->cmd.lcs_qipassist.ip_assists_supported;
 	card->ip_assists_enabled =
@@ -919,7 +942,7 @@
 	card = (struct lcs_card *) data;
 
 	daemonize("fixipm");
-	LCS_DBF_TEXT(5, trace, "fixipm");
+	LCS_DBF_TEXT(4,trace, "fixipm");
 	spin_lock(&card->lock);
 	list_for_each_safe(l, n, &card->ipm_list) {
 		ipm = list_entry(l, struct lcs_ipm_list, list);
@@ -952,6 +975,7 @@
 static void
 lcs_get_mac_for_ipm(__u32 ipm, char *mac, struct net_device *dev)
 {
+	LCS_DBF_TEXT(4,trace, "getmac");
 	if (dev->type == ARPHRD_IEEE802_TR)
 		ip_tr_mc_map(ipm, mac);
 	else
@@ -971,7 +995,7 @@
 	struct lcs_ipm_list *ipm, *tmp;
 	struct lcs_card *card;
 
-	LCS_DBF_TEXT(5, trace, "setmulti");
+	LCS_DBF_TEXT(4, trace, "setmulti");
 	in4_dev = in_dev_get(dev);
 	if (in4_dev == NULL)
 		return;
@@ -1033,21 +1057,18 @@
 static void
 lcs_irq(struct ccw_device *cdev, unsigned long intparm, struct irb *irb)
 {
-	char dbf_text[15];
 	struct lcs_card *card;
 	struct lcs_channel *channel;
 	int index;
 
-	card = (struct lcs_card *)cdev->dev.driver_data;
+	card = CARD_FROM_DEV(cdev);
 	if (card->read.ccwdev == cdev)
 		channel = &card->read;
 	else
 		channel = &card->write;
 
-	sprintf(dbf_text, "Rint%s", cdev->dev.bus_id);
-	LCS_DBF_TEXT(5, trace, dbf_text);
-	sprintf(dbf_text, "%4x%4x", irb->scsw.cstat, irb->scsw.dstat);
-	LCS_DBF_TEXT(5, trace, dbf_text);
+	LCS_DBF_TEXT_(5, trace, "Rint%s",cdev->dev.bus_id);
+	LCS_DBF_TEXT_(5, trace, "%4x%4x",irb->scsw.cstat, irb->scsw.dstat);
 
 	/* How far in the ccw chain have we processed? */
 	if ((channel->state != CH_STATE_INIT) &&
@@ -1084,6 +1105,9 @@
 		channel->state = CH_STATE_HALTED;
 	}
 
+	if (irb->scsw.fctl & SCSW_FCTL_CLEAR_FUNC) {
+		channel->state = CH_STATE_CLEARED;
+	}
 	/* Do the rest in the tasklet. */
 	tasklet_schedule(&channel->irq_tasklet);
 }
@@ -1094,7 +1118,6 @@
 static void
 lcs_tasklet(unsigned long data)
 {
-	char dbf_text[15];
 	unsigned long flags;
 	struct lcs_channel *channel;
 	struct lcs_buffer *iob;
@@ -1102,8 +1125,7 @@
 	int rc;
 
 	channel = (struct lcs_channel *) data;
-	sprintf(dbf_text, "tlet%s", channel->ccwdev->dev.bus_id);
-	LCS_DBF_TEXT(5, trace, dbf_text);
+	LCS_DBF_TEXT_(5, trace, "tlet%s",channel->ccwdev->dev.bus_id);
 
 	/* Check for processed buffers. */
 	iob = channel->iob;
@@ -1137,6 +1159,7 @@
 static void
 __lcs_emit_txbuffer(struct lcs_card *card)
 {
+	LCS_DBF_TEXT(5, trace, "emittx");
 	*(__u16 *)(card->tx_buffer->data + card->tx_buffer->count) = 0;
 	card->tx_buffer->count += 2;
 	lcs_ready_buffer(&card->write, card->tx_buffer);
@@ -1152,6 +1175,7 @@
 {
 	struct lcs_card *card;
 
+	LCS_DBF_TEXT(5, trace, "txbuffcb");
 	/* Put buffer back to pool. */
 	lcs_release_buffer(channel, buffer);
 	card = (struct lcs_card *)
@@ -1176,6 +1200,7 @@
 {
 	struct lcs_header *header;
 
+	LCS_DBF_TEXT(5, trace, "hardxmit");
 	if (skb == NULL) {
 		card->stats.tx_dropped++;
 		card->stats.tx_errors++;
@@ -1201,7 +1226,6 @@
 		/* Get new tx buffer */
 		card->tx_buffer = lcs_get_buffer(&card->write);
 		if (card->tx_buffer == NULL) {
-			netif_stop_queue(dev);
 			card->stats.tx_dropped++;
 			return -EBUSY;
 		}
@@ -1246,6 +1270,7 @@
 {
 	int rc;
 
+	LCS_DBF_TEXT(2, trace, "strtauto");
 #ifdef CONFIG_NET_ETHERNET
 	card->lan_type = LCS_FRAME_TYPE_ENET;
 	rc = lcs_send_startlan(card, LCS_INITIATOR_TCPIP);
@@ -1307,7 +1332,7 @@
 {
 	int rc = 0;
 
-	LCS_DBF_TEXT(3, setup," lcsdetct");
+	LCS_DBF_TEXT(2, setup, "lcsdetct");
 	/* start/reset card */
 	if (card->dev)
 		netif_stop_queue(card->dev);
@@ -1340,7 +1365,7 @@
 {
 	int retries;
 
-	LCS_DBF_TEXT(4, trace, "rescard");
+	LCS_DBF_TEXT(2, trace, "rescard");
 	for (retries = 0; retries < 10; retries++) {
 		if (lcs_detect(card) == 0) {
 			netif_wake_queue(card->dev);
@@ -1362,15 +1387,18 @@
 lcs_stopcard(struct lcs_card *card)
 {
 	int rc;
-
+	
 	LCS_DBF_TEXT(3, setup, "stopcard");
+	
 	if (card->read.state != CH_STATE_STOPPED &&
 	    card->write.state != CH_STATE_STOPPED &&
-	    card->state == DEV_STATE_UP)
+	    card->state == DEV_STATE_UP) {
 		rc = lcs_send_stoplan(card,LCS_INITIATOR_TCPIP);
-	rc = lcs_send_shutdown(card);
+		rc = lcs_send_shutdown(card);
+	}
 	rc = lcs_stop_channels(card);
 	card->state = DEV_STATE_DOWN;
+		
 	return rc;
 }
 
@@ -1492,6 +1520,7 @@
 static void
 lcs_get_control(struct lcs_card *card, struct lcs_cmd *cmd)
 {
+	LCS_DBF_TEXT(5, trace, "getctrl");
 	if (cmd->initiator == LCS_INITIATOR_LGW) {
 		switch(cmd->cmd_code) {
 		case LCS_CMD_STARTUP:
@@ -1522,6 +1551,7 @@
 {
 	struct sk_buff *skb;
 
+	LCS_DBF_TEXT(5, trace, "getskb");
 	if (card->dev == NULL ||
 	    card->state != DEV_STATE_UP)
 		/* The card isn't up. Ignore the packet. */
@@ -1619,6 +1649,7 @@
 	LCS_DBF_TEXT(2, trace, "stopdev");
 	card   = (struct lcs_card *) dev->priv;
 	netif_stop_queue(dev);
+	dev->flags &= ~IFF_UP;
 	rc = lcs_stopcard(card);
 	if (rc)
 		PRINT_ERR("Try it again!\n ");
@@ -1643,6 +1674,7 @@
 		PRINT_ERR("LCS:Error in opening device!\n");
 
 	} else {
+		dev->flags |= IFF_UP;
 		netif_wake_queue(dev);
 		card->state = DEV_STATE_UP;
 	}
@@ -1757,7 +1789,7 @@
 	if (!get_device(&ccwgdev->dev))
 		return -ENODEV;
 
-	LCS_DBF_TEXT(3, setup, "add_dev");
+	LCS_DBF_TEXT(2, setup, "add_dev");
         card = lcs_alloc_card();
         if (!card) {
                 PRINT_ERR("Allocation of lcs card failed\n");
@@ -1772,46 +1804,62 @@
 		return ret;
         }
 	ccwgdev->dev.driver_data = card;
-	ccwgdev->cdev[0]->dev.driver_data = card;
 	ccwgdev->cdev[0]->handler = lcs_irq;
-	ccwgdev->cdev[1]->dev.driver_data = card;
 	ccwgdev->cdev[1]->handler = lcs_irq;
         return 0;
 }
 
+static int 
+lcs_register_netdev(struct ccwgroup_device *ccwgdev)
+{
+	struct lcs_card *card;
+	
+	LCS_DBF_TEXT(2, setup, "regnetdv");
+	card = (struct lcs_card *)ccwgdev->dev.driver_data;
+	if (card->dev->reg_state != NETREG_UNINITIALIZED)
+		return 0;
+	SET_NETDEV_DEV(card->dev, &ccwgdev->dev);
+	return register_netdev(card->dev);
+}
+
 /**
  * lcs_new_device will be called by setting the group device online.
  */
+
 static int
 lcs_new_device(struct ccwgroup_device *ccwgdev)
 {
 	struct  lcs_card *card;
-	struct net_device *dev;
+	struct net_device *dev=NULL;
+	enum lcs_dev_states recover_state;
 	int rc;
 
 	card = (struct lcs_card *)ccwgdev->dev.driver_data;
 	if (!card)
 		return -ENODEV;
 
+	LCS_DBF_TEXT(2, setup, "newdev");
+	LCS_DBF_HEX(3, setup, &card, sizeof(void*));
 	card->read.ccwdev  = ccwgdev->cdev[0];
 	card->write.ccwdev = ccwgdev->cdev[1];
-
+	
+	recover_state = card->state;
 	ccw_device_set_online(card->read.ccwdev);
 	ccw_device_set_online(card->write.ccwdev);
 
 	LCS_DBF_TEXT(3, setup, "lcsnewdv");
-	rc = lcs_setup_card(card);
-	if (rc) {
-		LCS_DBF_TEXT(3, setup, "errinit");
-		PRINT_ERR("LCS card Initialization failed\n");
-		return rc;
-	}
-
+	
+	lcs_setup_card(card);
 	rc = lcs_detect(card);
 	if (rc) {
 		lcs_stopcard(card);
 		lcs_cleanup_card(card);
-		return -ENODEV;
+		goto out;
+	}
+	if (card->dev) {
+		LCS_DBF_TEXT(2, setup, "samedev");
+		LCS_DBF_HEX(3, setup, &card, sizeof(void*));
+		goto netdev_out;
 	}
 	switch (card->lan_type) {
 #ifdef CONFIG_NET_ETHERNET
@@ -1840,27 +1888,34 @@
 	}
 	if (!dev)
 		goto out;
-	memcpy(dev->dev_addr, card->mac, LCS_MAC_LENGTH);
 	card->dev = dev;
-	dev->priv = card;
-	dev->open = lcs_open_device;
-	dev->stop = lcs_stop_device;
-	dev->hard_start_xmit = lcs_start_xmit;
+netdev_out:
+	card->dev->priv = card;
+	card->dev->open = lcs_open_device;
+	card->dev->stop = lcs_stop_device;
+	card->dev->hard_start_xmit = lcs_start_xmit;
+	card->dev->get_stats = lcs_getstats;
+	SET_MODULE_OWNER(dev);
+	if (lcs_register_netdev(ccwgdev) != 0)
+		goto out;
+	memcpy(card->dev->dev_addr, card->mac, LCS_MAC_LENGTH);
 #ifdef CONFIG_IP_MULTICAST
 	if (lcs_check_multicast_support(card))
-		dev->set_multicast_list = lcs_set_multicast_list;
+		card->dev->set_multicast_list = lcs_set_multicast_list;
 #endif
-	dev->get_stats = lcs_getstats;
-	SET_MODULE_OWNER(dev);
-	if (register_netdev(dev) != 0)
-		goto out;
-	/* Create symlinks. */
-	SET_NETDEV_DEV(dev, &ccwgdev->dev);
-
-	netif_stop_queue(dev);
-	lcs_stopcard(card);
+	netif_stop_queue(card->dev);
+	if (recover_state == DEV_STATE_RECOVER) {
+		card->dev->flags |= IFF_UP;
+		netif_wake_queue(card->dev);
+		card->state = DEV_STATE_UP;
+	} else
+		lcs_stopcard(card);
+	
 	return 0;
 out:
+	
+	ccw_device_set_offline(card->read.ccwdev);
+	ccw_device_set_offline(card->write.ccwdev);
 	lcs_cleanup_card(card);
 	return -ENODEV;
 }
@@ -1872,17 +1927,25 @@
 lcs_shutdown_device(struct ccwgroup_device *ccwgdev)
 {
 	struct lcs_card *card;
+	enum lcs_dev_states recover_state;
 	int ret;
 
 	LCS_DBF_TEXT(3, setup, "shtdndev");
 	card = (struct lcs_card *)ccwgdev->dev.driver_data;
 	if (!card)
 		return -ENODEV;
+	
+	LCS_DBF_HEX(3, setup, &card, sizeof(void*));
+	recover_state = card->state;
 
 	ret = lcs_stop_device(card->dev);
+	ret = ccw_device_set_offline(card->read.ccwdev);
+	ret = ccw_device_set_offline(card->write.ccwdev);	
+	if (recover_state == DEV_STATE_UP) {
+		card->state = DEV_STATE_RECOVER;
+	}
 	if (ret)
 		return ret;
-	unregister_netdev(card->dev);
 	return 0;
 }
 
@@ -1894,14 +1957,17 @@
 {
 	struct lcs_card *card;
 
-	LCS_DBF_TEXT(3, setup, "remdev");
 	card = (struct lcs_card *)ccwgdev->dev.driver_data;
 	if (!card)
 		return;
+	
+	PRINT_INFO("Removing lcs group device ....\n");
+	LCS_DBF_TEXT(3, setup, "remdev");
+	LCS_DBF_HEX(3, setup, &card, sizeof(void*));
 	if (ccwgdev->state == CCWGROUP_ONLINE) {
-		lcs_stop_device(card->dev); /* Ignore rc. */
-		unregister_netdev(card->dev);
+		lcs_shutdown_device(ccwgdev); 
 	}
+	unregister_netdev(card->dev);
 	sysfs_remove_group(&ccwgdev->dev.kobj, &lcs_attr_group);
 	lcs_cleanup_card(card);
 	lcs_free_card(card);
diff -urN linux-2.6/drivers/s390/net/lcs.h linux-2.6-s390/drivers/s390/net/lcs.h
--- linux-2.6/drivers/s390/net/lcs.h	Thu Mar 11 03:55:36 2004
+++ linux-2.6-s390/drivers/s390/net/lcs.h	Fri Mar 26 18:25:58 2004
@@ -6,19 +6,36 @@
 #include <linux/workqueue.h>
 #include <asm/ccwdev.h>
 
-#define VERSION_LCS_H "$Revision: 1.13 $"
+#define VERSION_LCS_H "$Revision: 1.15 $"
 
 #define LCS_DBF_TEXT(level, name, text) \
 	do { \
 		debug_text_event(lcs_dbf_##name, level, text); \
 	} while (0)
 
+#define LCS_DBF_HEX(level,name,addr,len) \
+do { \
+	debug_event(lcs_dbf_##name,level,(void*)(addr),len); \
+} while (0)
+
+#define LCS_DBF_TEXT_(level,name,text...) \
+do {                                       \
+	sprintf(debug_buffer, text);  \
+		debug_text_event(lcs_dbf_##name,level, debug_buffer);\
+} while (0)
+
 /**
  * some more definitions for debug or output stuff
  */
 #define PRINTK_HEADER		" lcs: "
 
 /**
+ *	sysfs related stuff
+ */
+#define CARD_FROM_DEV(cdev) \
+	(struct lcs_card *) \
+	((struct ccwgroup_device *)cdev->dev.driver_data)->dev.driver_data;
+/**
  * CCW commands used in this driver
  */
 #define LCS_CCW_WRITE		0x01
@@ -123,6 +140,7 @@
 	CH_STATE_STOPPED,
 	CH_STATE_RUNNING,
 	CH_STATE_SUSPENDED,
+	CH_STATE_CLEARED,
 };
 
 /**
@@ -131,6 +149,7 @@
 enum lcs_dev_states {
 	DEV_STATE_DOWN,
 	DEV_STATE_UP,
+	DEV_STATE_RECOVER,
 };
 
 /**
diff -urN linux-2.6/drivers/s390/net/netiucv.c linux-2.6-s390/drivers/s390/net/netiucv.c
--- linux-2.6/drivers/s390/net/netiucv.c	Fri Mar 26 18:24:55 2004
+++ linux-2.6-s390/drivers/s390/net/netiucv.c	Fri Mar 26 18:25:58 2004
@@ -1,5 +1,5 @@
 /*
- * $Id: netiucv.c,v 1.45 2004/03/15 08:48:48 braunu Exp $
+ * $Id: netiucv.c,v 1.47 2004/03/22 07:41:42 braunu Exp $
  *
  * IUCV network driver
  *
@@ -30,7 +30,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV network driver $Revision: 1.45 $
+ * RELEASE-TAG: IUCV network driver $Revision: 1.47 $
  *
  */
 
@@ -764,7 +764,7 @@
 {
 	struct iucv_event *ev = (struct iucv_event *)arg;
 	struct iucv_connection *conn = ev->conn;
-
+	__u16 msglimit;
 	int rc;
 
 	pr_debug("%s() called\n", __FUNCTION__);
@@ -793,10 +793,11 @@
 
 	fsm_newstate(fi, CONN_STATE_SETUPWAIT);
 	rc = iucv_connect(&(conn->pathid), NETIUCV_QUEUELEN_DEFAULT, iucvMagic,
-			  conn->userid, iucv_host, 0, NULL, NULL, conn->handle,
+			  conn->userid, iucv_host, 0, NULL, &msglimit, conn->handle,
 			  conn);
 	switch (rc) {
 		case 0:
+			conn->netdev->tx_queue_len = msglimit;
 			return;
 		case 11:
 			printk(KERN_NOTICE
@@ -1911,7 +1912,7 @@
 static void
 netiucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.45 $";
+	char vbuf[] = "$Revision: 1.47 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
diff -urN linux-2.6/drivers/s390/net/qeth.c linux-2.6-s390/drivers/s390/net/qeth.c
--- linux-2.6/drivers/s390/net/qeth.c	Fri Mar 26 18:24:55 2004
+++ linux-2.6-s390/drivers/s390/net/qeth.c	Fri Mar 26 18:25:58 2004
@@ -755,7 +755,7 @@
 	int problem = 0;
 	struct qeth_card *card;
 
-	card = cdev->dev.driver_data;
+	card = CARD_FROM_CDEV(cdev);
 
 	if (atomic_read(&card->shutdown_phase))
 		return 0;
@@ -6105,7 +6105,7 @@
 	sprintf(dbf_text, "%4x", rqparam);
 	QETH_DBF_TEXT4(0, trace, dbf_text);
 
-	card = cdev->dev.driver_data;
+	card = CARD_FROM_CDEV(cdev);
 	if (!card)
 		return;
 
@@ -6231,7 +6231,7 @@
 	sprintf(dbf_text, "%4x", rqparam);
 	QETH_DBF_TEXT4(0, trace, dbf_text);
 
-	card = cdev->dev.driver_data;
+	card = CARD_FROM_CDEV(cdev);
 	if (!card)
 		return;
 
@@ -6343,7 +6343,7 @@
 	sprintf(dbf_text, "%4x", rqparam);
 	QETH_DBF_TEXT4(0, trace, dbf_text);
 
-	card = cdev->dev.driver_data;
+	card = CARD_FROM_CDEV(cdev);
 	if (!card)
 		return;
 
@@ -10620,13 +10620,10 @@
 	card->gdev = gdev;
 
 	gdev->cdev[0]->handler = qeth_interrupt_handler_read;
-	gdev->cdev[0]->dev.driver_data = card;
 
 	gdev->cdev[1]->handler = qeth_interrupt_handler_write;
-	gdev->cdev[1]->dev.driver_data = card;
 
 	gdev->cdev[2]->handler = qeth_interrupt_handler_qdio;
-	gdev->cdev[2]->dev.driver_data = card;
 
 	ret = __qeth_create_attributes(&gdev->dev);
 	if (ret != 0)
diff -urN linux-2.6/drivers/s390/net/qeth.h linux-2.6-s390/drivers/s390/net/qeth.h
--- linux-2.6/drivers/s390/net/qeth.h	Thu Mar 11 03:55:21 2004
+++ linux-2.6-s390/drivers/s390/net/qeth.h	Fri Mar 26 18:25:58 2004
@@ -696,6 +696,8 @@
 #define CARD_RDEV_ID(card) card->gdev->cdev[0]->dev.bus_id
 #define CARD_WDEV_ID(card) card->gdev->cdev[1]->dev.bus_id
 #define CARD_DDEV_ID(card) card->gdev->cdev[2]->dev.bus_id
+#define CARD_FROM_CDEV(cdev) (struct qeth_card *) \
+	((struct ccwgroup_device *) cdev->dev.driver_data)->dev.driver_data
 
 #define SENSE_COMMAND_REJECT_BYTE 0
 #define SENSE_COMMAND_REJECT_FLAG 0x80
