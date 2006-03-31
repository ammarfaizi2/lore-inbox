Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWCaUgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWCaUgZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 15:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWCaUgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 15:36:10 -0500
Received: from isilmar.linta.de ([213.239.214.66]:39639 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932272AbWCaUfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 15:35:54 -0500
Date: Fri, 31 Mar 2006 22:25:32 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux@dominikbrodowski.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 25/33] pcmcia: add return value to _config() functions
Message-ID: <20060331202532.GD28168@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20060331195852.GB27888@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331195852.GB27888@dominikbrodowski.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the driver initialization isn't done in the .probe function, but in
the internal _config() functions. Make them return a value, so that .probe
can properly report whether the probing of the device succeeded or not.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

---

 drivers/bluetooth/bluecard_cs.c         |   15 +++----
 drivers/bluetooth/bt3c_cs.c             |   15 +++----
 drivers/bluetooth/btuart_cs.c           |   15 +++----
 drivers/bluetooth/dtl1_cs.c             |   15 +++----
 drivers/char/pcmcia/cm4000_cs.c         |   15 ++++---
 drivers/char/pcmcia/cm4040_cs.c         |   15 ++++---
 drivers/char/pcmcia/synclink_cs.c       |   16 +++++--
 drivers/ide/legacy/ide-cs.c             |   15 +++----
 drivers/isdn/hardware/avm/avm_cs.c      |   21 +++++-----
 drivers/isdn/hisax/avma1_cs.c           |   19 ++++-----
 drivers/isdn/hisax/elsa_cs.c            |   15 +++----
 drivers/isdn/hisax/sedlbauer_cs.c       |   16 ++++---
 drivers/isdn/hisax/teles_cs.c           |   21 +++++-----
 drivers/mtd/maps/pcmciamtd.c            |   23 +++++------
 drivers/net/pcmcia/3c574_cs.c           |   16 +++----
 drivers/net/pcmcia/3c589_cs.c           |   17 +++-----
 drivers/net/pcmcia/axnet_cs.c           |   16 +++----
 drivers/net/pcmcia/com20020_cs.c        |   15 +++----
 drivers/net/pcmcia/fmvj18x_cs.c         |   16 +++----
 drivers/net/pcmcia/ibmtr_cs.c           |   11 ++---
 drivers/net/pcmcia/nmclan_cs.c          |   23 +++++------
 drivers/net/pcmcia/pcnet_cs.c           |   12 ++----
 drivers/net/pcmcia/smc91c92_cs.c        |   16 +++----
 drivers/net/pcmcia/xirc2ps_cs.c         |   17 ++++----
 drivers/net/wireless/airo_cs.c          |   18 ++++----
 drivers/net/wireless/atmel_cs.c         |   15 +++----
 drivers/net/wireless/hostap/hostap_cs.c |   12 ++++--
 drivers/net/wireless/netwave_cs.c       |   15 +++----
 drivers/net/wireless/orinoco_cs.c       |   15 +++----
 drivers/net/wireless/ray_cs.c           |   19 ++++-----
 drivers/net/wireless/spectrum_cs.c      |   15 +++----
 drivers/net/wireless/wavelan_cs.c       |   20 ++++++---
 drivers/net/wireless/wl3501_cs.c        |   18 ++++----
 drivers/parport/parport_cs.c            |   18 ++++----
 drivers/scsi/pcmcia/aha152x_stub.c      |   19 ++++-----
 drivers/scsi/pcmcia/fdomain_stub.c      |   67 +++++++++++++++----------------
 drivers/scsi/pcmcia/nsp_cs.c            |   21 ++++++----
 drivers/scsi/pcmcia/nsp_cs.h            |    2 -
 drivers/scsi/pcmcia/qlogic_stub.c       |   19 ++++-----
 drivers/scsi/pcmcia/sym53c500_cs.c      |   19 ++++-----
 drivers/serial/serial_cs.c              |   11 ++---
 drivers/telephony/ixj_pcmcia.c          |   15 +++----
 drivers/usb/host/sl811_cs.c             |   12 +++---
 sound/pcmcia/pdaudiocf/pdaudiocf.c      |   17 ++++----
 sound/pcmcia/vx/vxpocket.c              |   15 +++----
 45 files changed, 376 insertions(+), 401 deletions(-)

15b99ac1729503db9e6dc642a50b9b6cb3bf51f9
diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index e557f23..50174fb 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -85,7 +85,7 @@ typedef struct bluecard_info_t {
 } bluecard_info_t;
 
 
-static void bluecard_config(struct pcmcia_device *link);
+static int bluecard_config(struct pcmcia_device *link);
 static void bluecard_release(struct pcmcia_device *link);
 
 static void bluecard_detach(struct pcmcia_device *p_dev);
@@ -856,7 +856,7 @@ static int bluecard_close(bluecard_info_
 	return 0;
 }
 
-static int bluecard_attach(struct pcmcia_device *link)
+static int bluecard_probe(struct pcmcia_device *link)
 {
 	bluecard_info_t *info;
 
@@ -880,9 +880,7 @@ static int bluecard_attach(struct pcmcia
 	link->conf.IntType = INT_MEMORY_AND_IO;
 
 	link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-	bluecard_config(link);
-
-	return 0;
+	return bluecard_config(link);
 }
 
 
@@ -912,7 +910,7 @@ static int first_tuple(struct pcmcia_dev
 	return pcmcia_parse_tuple(handle, tuple, parse);
 }
 
-static void bluecard_config(struct pcmcia_device *link)
+static int bluecard_config(struct pcmcia_device *link)
 {
 	bluecard_info_t *info = link->priv;
 	tuple_t tuple;
@@ -973,13 +971,14 @@ static void bluecard_config(struct pcmci
 	link->dev_node = &info->node;
 	link->state &= ~DEV_CONFIG_PENDING;
 
-	return;
+	return 0;
 
 cs_failed:
 	cs_error(link, last_fn, last_ret);
 
 failed:
 	bluecard_release(link);
+	return -ENODEV;
 }
 
 
@@ -1008,7 +1007,7 @@ static struct pcmcia_driver bluecard_dri
 	.drv		= {
 		.name	= "bluecard_cs",
 	},
-	.probe		= bluecard_attach,
+	.probe		= bluecard_probe,
 	.remove		= bluecard_detach,
 	.id_table	= bluecard_ids,
 };
diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index 7ea8fa3..80861f4 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -88,7 +88,7 @@ typedef struct bt3c_info_t {
 } bt3c_info_t;
 
 
-static void bt3c_config(struct pcmcia_device *link);
+static int bt3c_config(struct pcmcia_device *link);
 static void bt3c_release(struct pcmcia_device *link);
 
 static void bt3c_detach(struct pcmcia_device *p_dev);
@@ -645,7 +645,7 @@ static int bt3c_close(bt3c_info_t *info)
 	return 0;
 }
 
-static int bt3c_attach(struct pcmcia_device *link)
+static int bt3c_probe(struct pcmcia_device *link)
 {
 	bt3c_info_t *info;
 
@@ -669,9 +669,7 @@ static int bt3c_attach(struct pcmcia_dev
 	link->conf.IntType = INT_MEMORY_AND_IO;
 
 	link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-	bt3c_config(link);
-
-	return 0;
+	return bt3c_config(link);
 }
 
 
@@ -710,7 +708,7 @@ static int next_tuple(struct pcmcia_devi
 	return get_tuple(handle, tuple, parse);
 }
 
-static void bt3c_config(struct pcmcia_device *link)
+static int bt3c_config(struct pcmcia_device *link)
 {
 	static kio_addr_t base[5] = { 0x3f8, 0x2f8, 0x3e8, 0x2e8, 0x0 };
 	bt3c_info_t *info = link->priv;
@@ -809,13 +807,14 @@ found_port:
 	link->dev_node = &info->node;
 	link->state &= ~DEV_CONFIG_PENDING;
 
-	return;
+	return 0;
 
 cs_failed:
 	cs_error(link, last_fn, last_ret);
 
 failed:
 	bt3c_release(link);
+	return -ENODEV;
 }
 
 
@@ -841,7 +840,7 @@ static struct pcmcia_driver bt3c_driver 
 	.drv		= {
 		.name	= "bt3c_cs",
 	},
-	.probe		= bt3c_attach,
+	.probe		= bt3c_probe,
 	.remove		= bt3c_detach,
 	.id_table	= bt3c_ids,
 };
diff --git a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
index 5948390..658a137 100644
--- a/drivers/bluetooth/btuart_cs.c
+++ b/drivers/bluetooth/btuart_cs.c
@@ -84,7 +84,7 @@ typedef struct btuart_info_t {
 } btuart_info_t;
 
 
-static void btuart_config(struct pcmcia_device *link);
+static int btuart_config(struct pcmcia_device *link);
 static void btuart_release(struct pcmcia_device *link);
 
 static void btuart_detach(struct pcmcia_device *p_dev);
@@ -576,7 +576,7 @@ static int btuart_close(btuart_info_t *i
 	return 0;
 }
 
-static int btuart_attach(struct pcmcia_device *link)
+static int btuart_probe(struct pcmcia_device *link)
 {
 	btuart_info_t *info;
 
@@ -600,9 +600,7 @@ static int btuart_attach(struct pcmcia_d
 	link->conf.IntType = INT_MEMORY_AND_IO;
 
 	link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-	btuart_config(link);
-
-	return 0;
+	return btuart_config(link);
 }
 
 
@@ -641,7 +639,7 @@ static int next_tuple(struct pcmcia_devi
 	return get_tuple(handle, tuple, parse);
 }
 
-static void btuart_config(struct pcmcia_device *link)
+static int btuart_config(struct pcmcia_device *link)
 {
 	static kio_addr_t base[5] = { 0x3f8, 0x2f8, 0x3e8, 0x2e8, 0x0 };
 	btuart_info_t *info = link->priv;
@@ -741,13 +739,14 @@ found_port:
 	link->dev_node = &info->node;
 	link->state &= ~DEV_CONFIG_PENDING;
 
-	return;
+	return 0;
 
 cs_failed:
 	cs_error(link, last_fn, last_ret);
 
 failed:
 	btuart_release(link);
+	return -ENODEV;
 }
 
 
@@ -772,7 +771,7 @@ static struct pcmcia_driver btuart_drive
 	.drv		= {
 		.name	= "btuart_cs",
 	},
-	.probe		= btuart_attach,
+	.probe		= btuart_probe,
 	.remove		= btuart_detach,
 	.id_table	= btuart_ids,
 };
diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index 416433b..0ec7fd4 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -87,7 +87,7 @@ typedef struct dtl1_info_t {
 } dtl1_info_t;
 
 
-static void dtl1_config(struct pcmcia_device *link);
+static int dtl1_config(struct pcmcia_device *link);
 static void dtl1_release(struct pcmcia_device *link);
 
 static void dtl1_detach(struct pcmcia_device *p_dev);
@@ -555,7 +555,7 @@ static int dtl1_close(dtl1_info_t *info)
 	return 0;
 }
 
-static int dtl1_attach(struct pcmcia_device *link)
+static int dtl1_probe(struct pcmcia_device *link)
 {
 	dtl1_info_t *info;
 
@@ -579,9 +579,7 @@ static int dtl1_attach(struct pcmcia_dev
 	link->conf.IntType = INT_MEMORY_AND_IO;
 
 	link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-	dtl1_config(link);
-
-	return 0;
+	return dtl1_config(link);
 }
 
 
@@ -620,7 +618,7 @@ static int next_tuple(struct pcmcia_devi
 	return get_tuple(handle, tuple, parse);
 }
 
-static void dtl1_config(struct pcmcia_device *link)
+static int dtl1_config(struct pcmcia_device *link)
 {
 	dtl1_info_t *info = link->priv;
 	tuple_t tuple;
@@ -693,13 +691,14 @@ static void dtl1_config(struct pcmcia_de
 	link->dev_node = &info->node;
 	link->state &= ~DEV_CONFIG_PENDING;
 
-	return;
+	return 0;
 
 cs_failed:
 	cs_error(link, last_fn, last_ret);
 
 failed:
 	dtl1_release(link);
+	return -ENODEV;
 }
 
 
@@ -727,7 +726,7 @@ static struct pcmcia_driver dtl1_driver 
 	.drv		= {
 		.name	= "dtl1_cs",
 	},
-	.probe		= dtl1_attach,
+	.probe		= dtl1_probe,
 	.remove		= dtl1_detach,
 	.id_table	= dtl1_ids,
 };
diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index 79b8ad0..22dce9d 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -1759,7 +1759,7 @@ static void cmm_cm4000_release(struct pc
 
 /*==== Interface to PCMCIA Layer =======================================*/
 
-static void cm4000_config(struct pcmcia_device * link, int devno)
+static int cm4000_config(struct pcmcia_device * link, int devno)
 {
 	struct cm4000_dev *dev;
 	tuple_t tuple;
@@ -1846,7 +1846,7 @@ static void cm4000_config(struct pcmcia_
 	link->dev_node = &dev->node;
 	link->state &= ~DEV_CONFIG_PENDING;
 
-	return;
+	return 0;
 
 cs_failed:
 	cs_error(link, fail_fn, fail_rc);
@@ -1854,6 +1854,7 @@ cs_release:
 	cm4000_release(link);
 
 	link->state &= ~DEV_CONFIG_PENDING;
+	return -ENODEV;
 }
 
 static int cm4000_suspend(struct pcmcia_device *link)
@@ -1883,10 +1884,10 @@ static void cm4000_release(struct pcmcia
 	pcmcia_disable_device(link);
 }
 
-static int cm4000_attach(struct pcmcia_device *link)
+static int cm4000_probe(struct pcmcia_device *link)
 {
 	struct cm4000_dev *dev;
-	int i;
+	int i, ret;
 
 	for (i = 0; i < CM4000_MAX_DEV; i++)
 		if (dev_table[i] == NULL)
@@ -1913,7 +1914,9 @@ static int cm4000_attach(struct pcmcia_d
 	init_waitqueue_head(&dev->readq);
 
 	link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-	cm4000_config(link, i);
+	ret = cm4000_config(link, i);
+	if (ret)
+		return ret;
 
 	class_device_create(cmm_class, NULL, MKDEV(major, i), NULL,
 			    "cmm%d", i);
@@ -1968,7 +1971,7 @@ static struct pcmcia_driver cm4000_drive
 	.drv	  = {
 		.name = "cm4000_cs",
 		},
-	.probe    = cm4000_attach,
+	.probe    = cm4000_probe,
 	.remove   = cm4000_detach,
 	.suspend  = cm4000_suspend,
 	.resume   = cm4000_resume,
diff --git a/drivers/char/pcmcia/cm4040_cs.c b/drivers/char/pcmcia/cm4040_cs.c
index 8334226..6ccca8c 100644
--- a/drivers/char/pcmcia/cm4040_cs.c
+++ b/drivers/char/pcmcia/cm4040_cs.c
@@ -514,7 +514,7 @@ static void cm4040_reader_release(struct
 	return;
 }
 
-static void reader_config(struct pcmcia_device *link, int devno)
+static int reader_config(struct pcmcia_device *link, int devno)
 {
 	struct reader_dev *dev;
 	tuple_t tuple;
@@ -610,13 +610,14 @@ static void reader_config(struct pcmcia_
 	      link->io.BasePort1, link->io.BasePort1+link->io.NumPorts1);
 	DEBUGP(2, dev, "<- reader_config (succ)\n");
 
-	return;
+	return 0;
 
 cs_failed:
 	cs_error(link, fail_fn, fail_rc);
 cs_release:
 	reader_release(link);
 	link->state &= ~DEV_CONFIG_PENDING;
+	return -ENODEV;
 }
 
 static void reader_release(struct pcmcia_device *link)
@@ -625,10 +626,10 @@ static void reader_release(struct pcmcia
 	pcmcia_disable_device(link);
 }
 
-static int reader_attach(struct pcmcia_device *link)
+static int reader_probe(struct pcmcia_device *link)
 {
 	struct reader_dev *dev;
-	int i;
+	int i, ret;
 
 	for (i = 0; i < CM_MAX_DEV; i++) {
 		if (dev_table[i] == NULL)
@@ -659,7 +660,9 @@ static int reader_attach(struct pcmcia_d
 	dev->poll_timer.function = &cm4040_do_poll;
 
 	link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-	reader_config(link, i);
+	ret = reader_config(link, i);
+	if (ret)
+		return ret;
 
 	class_device_create(cmx_class, NULL, MKDEV(major, i), NULL,
 			    "cmx%d", i);
@@ -715,7 +718,7 @@ static struct pcmcia_driver reader_drive
   	.drv		= {
 		.name	= "cm4040_cs",
 	},
-	.probe		= reader_attach,
+	.probe		= reader_probe,
 	.remove		= reader_detach,
 	.id_table	= cm4040_ids,
 };
diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 9bfd90e..ef7a813 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -484,7 +484,7 @@ static void mgslpc_wait_until_sent(struc
 
 /* PCMCIA prototypes */
 
-static void mgslpc_config(struct pcmcia_device *link);
+static int mgslpc_config(struct pcmcia_device *link);
 static void mgslpc_release(u_long arg);
 static void mgslpc_detach(struct pcmcia_device *p_dev);
 
@@ -533,9 +533,10 @@ static void ldisc_receive_buf(struct tty
 	}
 }
 
-static int mgslpc_attach(struct pcmcia_device *link)
+static int mgslpc_probe(struct pcmcia_device *link)
 {
     MGSLPC_INFO *info;
+    int ret;
 
     if (debug_level >= DEBUG_LEVEL_INFO)
 	    printk("mgslpc_attach\n");
@@ -578,7 +579,9 @@ static int mgslpc_attach(struct pcmcia_d
     link->conf.IntType = INT_MEMORY_AND_IO;
 
     link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-    mgslpc_config(link);
+    ret = mgslpc_config(link);
+    if (ret)
+	    return ret;
 
     mgslpc_add_device(info);
 
@@ -591,7 +594,7 @@ static int mgslpc_attach(struct pcmcia_d
 #define CS_CHECK(fn, ret) \
 do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
 
-static void mgslpc_config(struct pcmcia_device *link)
+static int mgslpc_config(struct pcmcia_device *link)
 {
     MGSLPC_INFO *info = link->priv;
     tuple_t tuple;
@@ -680,11 +683,12 @@ static void mgslpc_config(struct pcmcia_
     printk("\n");
     
     link->state &= ~DEV_CONFIG_PENDING;
-    return;
+    return 0;
 
 cs_failed:
     cs_error(link, last_fn, last_ret);
     mgslpc_release((u_long)link);
+    return -ENODEV;
 }
 
 /* Card has been removed.
@@ -3003,7 +3007,7 @@ static struct pcmcia_driver mgslpc_drive
 	.drv		= {
 		.name	= "synclink_cs",
 	},
-	.probe		= mgslpc_attach,
+	.probe		= mgslpc_probe,
 	.remove		= mgslpc_detach,
 	.id_table	= mgslpc_ids,
 	.suspend	= mgslpc_suspend,
diff --git a/drivers/ide/legacy/ide-cs.c b/drivers/ide/legacy/ide-cs.c
index 58690c1..56c8e82 100644
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
@@ -88,7 +88,7 @@ typedef struct ide_info_t {
 } ide_info_t;
 
 static void ide_release(struct pcmcia_device *);
-static void ide_config(struct pcmcia_device *);
+static int ide_config(struct pcmcia_device *);
 
 static void ide_detach(struct pcmcia_device *p_dev);
 
@@ -103,7 +103,7 @@ static void ide_detach(struct pcmcia_dev
 
 ======================================================================*/
 
-static int ide_attach(struct pcmcia_device *link)
+static int ide_probe(struct pcmcia_device *link)
 {
     ide_info_t *info;
 
@@ -126,9 +126,7 @@ static int ide_attach(struct pcmcia_devi
     link->conf.IntType = INT_MEMORY_AND_IO;
 
     link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-    ide_config(link);
-
-    return 0;
+    return ide_config(link);
 } /* ide_attach */
 
 /*======================================================================
@@ -172,7 +170,7 @@ static int idecs_register(unsigned long 
 #define CS_CHECK(fn, ret) \
 do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
 
-static void ide_config(struct pcmcia_device *link)
+static int ide_config(struct pcmcia_device *link)
 {
     ide_info_t *info = link->priv;
     tuple_t tuple;
@@ -327,7 +325,7 @@ static void ide_config(struct pcmcia_dev
 
     link->state &= ~DEV_CONFIG_PENDING;
     kfree(stk);
-    return;
+    return 0;
 
 err_mem:
     printk(KERN_NOTICE "ide-cs: ide_config failed memory allocation\n");
@@ -339,6 +337,7 @@ failed:
     kfree(stk);
     ide_release(link);
     link->state &= ~DEV_CONFIG_PENDING;
+    return -ENODEV;
 } /* ide_config */
 
 /*======================================================================
@@ -424,7 +423,7 @@ static struct pcmcia_driver ide_cs_drive
 	.drv		= {
 		.name	= "ide-cs",
 	},
-	.probe		= ide_attach,
+	.probe		= ide_probe,
 	.remove		= ide_detach,
 	.id_table       = ide_ids,
 };
diff --git a/drivers/isdn/hardware/avm/avm_cs.c b/drivers/isdn/hardware/avm/avm_cs.c
index c9c794e..28f9211 100644
--- a/drivers/isdn/hardware/avm/avm_cs.c
+++ b/drivers/isdn/hardware/avm/avm_cs.c
@@ -51,7 +51,7 @@ MODULE_LICENSE("GPL");
    handler.
 */
 
-static void avmcs_config(struct pcmcia_device *link);
+static int avmcs_config(struct pcmcia_device *link);
 static void avmcs_release(struct pcmcia_device *link);
 
 /*
@@ -99,7 +99,7 @@ typedef struct local_info_t {
     
 ======================================================================*/
 
-static int avmcs_attach(struct pcmcia_device *p_dev)
+static int avmcs_probe(struct pcmcia_device *p_dev)
 {
     local_info_t *local;
 
@@ -128,12 +128,10 @@ static int avmcs_attach(struct pcmcia_de
     p_dev->priv = local;
 
     p_dev->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-    avmcs_config(p_dev);
-
-    return 0;
+    return avmcs_config(p_dev);
 
  err:
-    return -EINVAL;
+    return -ENOMEM;
 } /* avmcs_attach */
 
 /*======================================================================
@@ -185,7 +183,7 @@ static int next_tuple(struct pcmcia_devi
     return get_tuple(handle, tuple, parse);
 }
 
-static void avmcs_config(struct pcmcia_device *link)
+static int avmcs_config(struct pcmcia_device *link)
 {
     tuple_t tuple;
     cisparse_t parse;
@@ -219,7 +217,7 @@ static void avmcs_config(struct pcmcia_d
     if (i != CS_SUCCESS) {
 	cs_error(link, ParseTuple, i);
 	link->state &= ~DEV_CONFIG_PENDING;
-	return;
+	return -ENODEV;
     }
     
     /* Configure card */
@@ -319,7 +317,7 @@ found_port:
     /* If any step failed, release any partially configured state */
     if (i != 0) {
 	avmcs_release(link);
-	return;
+	return -ENODEV;
     }
 
 
@@ -333,9 +331,10 @@ found_port:
         printk(KERN_ERR "avm_cs: failed to add AVM-%s-Controller at i/o %#x, irq %d\n",
 		dev->node.dev_name, link->io.BasePort1, link->irq.AssignedIRQ);
 	avmcs_release(link);
-	return;
+	return -ENODEV;
     }
     dev->node.minor = i;
+    return 0;
 
 } /* avmcs_config */
 
@@ -367,7 +366,7 @@ static struct pcmcia_driver avmcs_driver
 	.drv	= {
 		.name	= "avm_cs",
 	},
-	.probe = avmcs_attach,
+	.probe = avmcs_probe,
 	.remove	= avmcs_detach,
 	.id_table = avmcs_ids,
 };
diff --git a/drivers/isdn/hisax/avma1_cs.c b/drivers/isdn/hisax/avma1_cs.c
index ff6b0e1..11c7c4f 100644
--- a/drivers/isdn/hisax/avma1_cs.c
+++ b/drivers/isdn/hisax/avma1_cs.c
@@ -67,7 +67,7 @@ module_param(isdnprot, int, 0);
    handler.
 */
 
-static void avma1cs_config(struct pcmcia_device *link);
+static int avma1cs_config(struct pcmcia_device *link);
 static void avma1cs_release(struct pcmcia_device *link);
 
 /*
@@ -116,7 +116,7 @@ typedef struct local_info_t {
     
 ======================================================================*/
 
-static int avma1cs_attach(struct pcmcia_device *p_dev)
+static int avma1cs_probe(struct pcmcia_device *p_dev)
 {
     local_info_t *local;
 
@@ -150,9 +150,7 @@ static int avma1cs_attach(struct pcmcia_
     p_dev->conf.Present = PRESENT_OPTION;
 
     p_dev->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-    avma1cs_config(p_dev);
-
-    return 0;
+    return avma1cs_config(p_dev);
 } /* avma1cs_attach */
 
 /*======================================================================
@@ -206,7 +204,7 @@ static int next_tuple(struct pcmcia_devi
     return get_tuple(handle, tuple, parse);
 }
 
-static void avma1cs_config(struct pcmcia_device *link)
+static int avma1cs_config(struct pcmcia_device *link)
 {
     tuple_t tuple;
     cisparse_t parse;
@@ -242,7 +240,7 @@ static void avma1cs_config(struct pcmcia
     if (i != CS_SUCCESS) {
 	cs_error(link, ParseTuple, i);
 	link->state &= ~DEV_CONFIG_PENDING;
-	return;
+	return -ENODEV;
     }
     
     /* Configure card */
@@ -325,7 +323,7 @@ found_port:
     /* If any step failed, release any partially configured state */
     if (i != 0) {
 	avma1cs_release(link);
-	return;
+	return -ENODEV;
     }
 
     printk(KERN_NOTICE "avma1_cs: checking at i/o %#x, irq %d\n",
@@ -340,10 +338,11 @@ found_port:
     if (i < 0) {
     	printk(KERN_ERR "avma1_cs: failed to initialize AVM A1 PCMCIA %d at i/o %#x\n", i, link->io.BasePort1);
 	avma1cs_release(link);
-	return;
+	return -ENODEV;
     }
     dev->node.minor = i;
 
+    return 0;
 } /* avma1cs_config */
 
 /*======================================================================
@@ -379,7 +378,7 @@ static struct pcmcia_driver avma1cs_driv
 	.drv		= {
 		.name	= "avma1_cs",
 	},
-	.probe		= avma1cs_attach,
+	.probe		= avma1cs_probe,
 	.remove		= avma1cs_detach,
 	.id_table	= avma1cs_ids,
 };
diff --git a/drivers/isdn/hisax/elsa_cs.c b/drivers/isdn/hisax/elsa_cs.c
index 7a42bd4..4856680 100644
--- a/drivers/isdn/hisax/elsa_cs.c
+++ b/drivers/isdn/hisax/elsa_cs.c
@@ -94,7 +94,7 @@ module_param(protocol, int, 0);
    handler.
 */
 
-static void elsa_cs_config(struct pcmcia_device *link);
+static int elsa_cs_config(struct pcmcia_device *link);
 static void elsa_cs_release(struct pcmcia_device *link);
 
 /*
@@ -139,7 +139,7 @@ typedef struct local_info_t {
 
 ======================================================================*/
 
-static int elsa_cs_attach(struct pcmcia_device *link)
+static int elsa_cs_probe(struct pcmcia_device *link)
 {
     local_info_t *local;
 
@@ -175,9 +175,7 @@ static int elsa_cs_attach(struct pcmcia_
     link->conf.IntType = INT_MEMORY_AND_IO;
 
     link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-    elsa_cs_config(link);
-
-    return 0;
+    return elsa_cs_config(link);
 } /* elsa_cs_attach */
 
 /*======================================================================
@@ -235,7 +233,7 @@ static int next_tuple(struct pcmcia_devi
     return get_tuple(handle, tuple, parse);
 }
 
-static void elsa_cs_config(struct pcmcia_device *link)
+static int elsa_cs_config(struct pcmcia_device *link)
 {
     tuple_t tuple;
     cisparse_t parse;
@@ -346,10 +344,11 @@ static void elsa_cs_config(struct pcmcia
     } else
     	((local_info_t*)link->priv)->cardnr = i;
 
-    return;
+    return 0;
 cs_failed:
     cs_error(link, last_fn, i);
     elsa_cs_release(link);
+    return -ENODEV;
 } /* elsa_cs_config */
 
 /*======================================================================
@@ -406,7 +405,7 @@ static struct pcmcia_driver elsa_cs_driv
 	.drv		= {
 		.name	= "elsa_cs",
 	},
-	.probe		= elsa_cs_attach,
+	.probe		= elsa_cs_probe,
 	.remove		= elsa_cs_detach,
 	.id_table	= elsa_ids,
 	.suspend	= elsa_suspend,
diff --git a/drivers/isdn/hisax/sedlbauer_cs.c b/drivers/isdn/hisax/sedlbauer_cs.c
index 2af48a6..a35a295 100644
--- a/drivers/isdn/hisax/sedlbauer_cs.c
+++ b/drivers/isdn/hisax/sedlbauer_cs.c
@@ -95,7 +95,7 @@ module_param(protocol, int, 0);
    event handler. 
 */
 
-static void sedlbauer_config(struct pcmcia_device *link);
+static int sedlbauer_config(struct pcmcia_device *link);
 static void sedlbauer_release(struct pcmcia_device *link);
 
 /*
@@ -148,7 +148,7 @@ typedef struct local_info_t {
     
 ======================================================================*/
 
-static int sedlbauer_attach(struct pcmcia_device *link)
+static int sedlbauer_probe(struct pcmcia_device *link)
 {
     local_info_t *local;
 
@@ -187,9 +187,7 @@ static int sedlbauer_attach(struct pcmci
     link->conf.IntType = INT_MEMORY_AND_IO;
 
     link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-    sedlbauer_config(link);
-
-    return 0;
+    return sedlbauer_config(link);
 } /* sedlbauer_attach */
 
 /*======================================================================
@@ -224,7 +222,7 @@ static void sedlbauer_detach(struct pcmc
 #define CS_CHECK(fn, ret) \
 do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
 
-static void sedlbauer_config(struct pcmcia_device *link)
+static int sedlbauer_config(struct pcmcia_device *link)
 {
     local_info_t *dev = link->priv;
     tuple_t tuple;
@@ -423,14 +421,16 @@ static void sedlbauer_config(struct pcmc
     	printk(KERN_ERR "sedlbauer_cs: failed to initialize SEDLBAUER PCMCIA %d at i/o %#x\n",
     		last_ret, link->io.BasePort1);
     	sedlbauer_release(link);
+	return -ENODEV;
     } else
     	((local_info_t*)link->priv)->cardnr = last_ret;
 
-    return;
+    return 0;
 
 cs_failed:
     cs_error(link, last_fn, last_ret);
     sedlbauer_release(link);
+    return -ENODEV;
 
 } /* sedlbauer_config */
 
@@ -493,7 +493,7 @@ static struct pcmcia_driver sedlbauer_dr
 	.drv		= {
 		.name	= "sedlbauer_cs",
 	},
-	.probe		= sedlbauer_attach,
+	.probe		= sedlbauer_probe,
 	.remove		= sedlbauer_detach,
 	.id_table	= sedlbauer_ids,
 	.suspend	= sedlbauer_suspend,
diff --git a/drivers/isdn/hisax/teles_cs.c b/drivers/isdn/hisax/teles_cs.c
index 698e9ec..7b66038 100644
--- a/drivers/isdn/hisax/teles_cs.c
+++ b/drivers/isdn/hisax/teles_cs.c
@@ -75,7 +75,7 @@ module_param(protocol, int, 0);
    handler.
 */
 
-static void teles_cs_config(struct pcmcia_device *link);
+static int teles_cs_config(struct pcmcia_device *link);
 static void teles_cs_release(struct pcmcia_device *link);
 
 /*
@@ -130,7 +130,7 @@ typedef struct local_info_t {
 
 ======================================================================*/
 
-static int teles_attach(struct pcmcia_device *link)
+static int teles_probe(struct pcmcia_device *link)
 {
     local_info_t *local;
 
@@ -165,9 +165,7 @@ static int teles_attach(struct pcmcia_de
     link->conf.IntType = INT_MEMORY_AND_IO;
 
     link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-    teles_cs_config(link);
-
-    return 0;
+    return teles_cs_config(link);
 } /* teles_attach */
 
 /*======================================================================
@@ -225,7 +223,7 @@ static int next_tuple(struct pcmcia_devi
     return get_tuple(handle, tuple, parse);
 }
 
-static void teles_cs_config(struct pcmcia_device *link)
+static int teles_cs_config(struct pcmcia_device *link)
 {
     tuple_t tuple;
     cisparse_t parse;
@@ -333,13 +331,16 @@ static void teles_cs_config(struct pcmci
     	printk(KERN_ERR "teles_cs: failed to initialize Teles PCMCIA %d at i/o %#x\n",
     		i, link->io.BasePort1);
     	teles_cs_release(link);
-    } else
-    	((local_info_t*)link->priv)->cardnr = i;
+	return -ENODEV;
+    }
+
+    ((local_info_t*)link->priv)->cardnr = i;
+    return 0;
 
-    return;
 cs_failed:
     cs_error(link, last_fn, i);
     teles_cs_release(link);
+    return -ENODEV;
 } /* teles_cs_config */
 
 /*======================================================================
@@ -396,7 +397,7 @@ static struct pcmcia_driver teles_cs_dri
 	.drv		= {
 		.name	= "teles_cs",
 	},
-	.probe		= teles_attach,
+	.probe		= teles_probe,
 	.remove		= teles_detach,
 	.id_table       = teles_ids,
 	.suspend	= teles_suspend,
diff --git a/drivers/mtd/maps/pcmciamtd.c b/drivers/mtd/maps/pcmciamtd.c
index e9086f0..466f558 100644
--- a/drivers/mtd/maps/pcmciamtd.c
+++ b/drivers/mtd/maps/pcmciamtd.c
@@ -487,7 +487,7 @@ static void card_settings(struct pcmciam
 #define CS_CHECK(fn, ret) \
 do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
 
-static void pcmciamtd_config(struct pcmcia_device *link)
+static int pcmciamtd_config(struct pcmcia_device *link)
 {
 	struct pcmciamtd_dev *dev = link->priv;
 	struct mtd_info *mtd = NULL;
@@ -561,7 +561,7 @@ static void pcmciamtd_config(struct pcmc
 	if(!dev->win_size) {
 		err("Cant allocate memory window");
 		pcmciamtd_release(link);
-		return;
+		return -ENODEV;
 	}
 	DEBUG(1, "Allocated a window of %dKiB", dev->win_size >> 10);
 
@@ -573,7 +573,7 @@ static void pcmciamtd_config(struct pcmc
 	if(!dev->win_base) {
 		err("ioremap(%lu, %u) failed", req.Base, req.Size);
 		pcmciamtd_release(link);
-		return;
+		return -ENODEV;
 	}
 	DEBUG(1, "mapped window dev = %p req.base = 0x%lx base = %p size = 0x%x",
 	      dev, req.Base, dev->win_base, req.Size);
@@ -605,6 +605,7 @@ static void pcmciamtd_config(struct pcmc
 	ret = pcmcia_request_configuration(link, &link->conf);
 	if(ret != CS_SUCCESS) {
 		cs_error(link, RequestConfiguration, ret);
+		return -ENODEV;
 	}
 
 	if(mem_type == 1) {
@@ -625,7 +626,7 @@ static void pcmciamtd_config(struct pcmc
 	if(!mtd) {
 		DEBUG(1, "Cant find an MTD");
 		pcmciamtd_release(link);
-		return;
+		return -ENODEV;
 	}
 
 	dev->mtd_info = mtd;
@@ -668,19 +669,19 @@ static void pcmciamtd_config(struct pcmc
 		dev->mtd_info = NULL;
 		err("Couldnt register MTD device");
 		pcmciamtd_release(link);
-		return;
+		return -ENODEV;
 	}
 	snprintf(dev->node.dev_name, sizeof(dev->node.dev_name), "mtd%d", mtd->index);
 	info("mtd%d: %s", mtd->index, mtd->name);
 	link->state &= ~DEV_CONFIG_PENDING;
 	link->dev_node = &dev->node;
-	return;
+	return 0;
 
  cs_failed:
 	cs_error(link, last_fn, last_ret);
 	err("CS Error, exiting");
 	pcmciamtd_release(link);
-	return;
+	return -ENODEV;
 }
 
 
@@ -730,7 +731,7 @@ static void pcmciamtd_detach(struct pcmc
  * with Card Services.
  */
 
-static int pcmciamtd_attach(struct pcmcia_device *link)
+static int pcmciamtd_probe(struct pcmcia_device *link)
 {
 	struct pcmciamtd_dev *dev;
 
@@ -747,9 +748,7 @@ static int pcmciamtd_attach(struct pcmci
 	link->conf.IntType = INT_MEMORY;
 
 	link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-	pcmciamtd_config(link);
-
-	return 0;
+	return pcmciamtd_config(link);
 }
 
 static struct pcmcia_device_id pcmciamtd_ids[] = {
@@ -783,7 +782,7 @@ static struct pcmcia_driver pcmciamtd_dr
 	.drv		= {
 		.name	= "pcmciamtd"
 	},
-	.probe		= pcmciamtd_attach,
+	.probe		= pcmciamtd_probe,
 	.remove		= pcmciamtd_detach,
 	.owner		= THIS_MODULE,
 	.id_table	= pcmciamtd_ids,
diff --git a/drivers/net/pcmcia/3c574_cs.c b/drivers/net/pcmcia/3c574_cs.c
index f4e293b..4611469 100644
--- a/drivers/net/pcmcia/3c574_cs.c
+++ b/drivers/net/pcmcia/3c574_cs.c
@@ -225,7 +225,7 @@ static char mii_preamble_required = 0;
 
 /* Index of functions. */
 
-static void tc574_config(struct pcmcia_device *link);
+static int tc574_config(struct pcmcia_device *link);
 static void tc574_release(struct pcmcia_device *link);
 
 static void mdio_sync(kio_addr_t ioaddr, int bits);
@@ -256,7 +256,7 @@ static void tc574_detach(struct pcmcia_d
 	with Card Services.
 */
 
-static int tc574_attach(struct pcmcia_device *link)
+static int tc574_probe(struct pcmcia_device *link)
 {
 	struct el3_private *lp;
 	struct net_device *dev;
@@ -297,9 +297,7 @@ static int tc574_attach(struct pcmcia_de
 #endif
 
 	link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-	tc574_config(link);
-
-	return 0;
+	return tc574_config(link);
 } /* tc574_attach */
 
 /*
@@ -337,7 +335,7 @@ static void tc574_detach(struct pcmcia_d
 
 static const char *ram_split[] = {"5:3", "3:1", "1:1", "3:5"};
 
-static void tc574_config(struct pcmcia_device *link)
+static int tc574_config(struct pcmcia_device *link)
 {
 	struct net_device *dev = link->priv;
 	struct el3_private *lp = netdev_priv(dev);
@@ -486,13 +484,13 @@ static void tc574_config(struct pcmcia_d
 		   8 << config.u.ram_size, ram_split[config.u.ram_split],
 		   config.u.autoselect ? "autoselect " : "");
 
-	return;
+	return 0;
 
 cs_failed:
 	cs_error(link, last_fn, last_ret);
 failed:
 	tc574_release(link);
-	return;
+	return -ENODEV;
 
 } /* tc574_config */
 
@@ -1223,7 +1221,7 @@ static struct pcmcia_driver tc574_driver
 	.drv		= {
 		.name	= "3c574_cs",
 	},
-	.probe		= tc574_attach,
+	.probe		= tc574_probe,
 	.remove		= tc574_detach,
 	.id_table       = tc574_ids,
 	.suspend	= tc574_suspend,
diff --git a/drivers/net/pcmcia/3c589_cs.c b/drivers/net/pcmcia/3c589_cs.c
index 565063d..160d48a 100644
--- a/drivers/net/pcmcia/3c589_cs.c
+++ b/drivers/net/pcmcia/3c589_cs.c
@@ -142,7 +142,7 @@ DRV_NAME ".c " DRV_VERSION " 2001/10/13 
 
 /*====================================================================*/
 
-static void tc589_config(struct pcmcia_device *link);
+static int tc589_config(struct pcmcia_device *link);
 static void tc589_release(struct pcmcia_device *link);
 
 static u16 read_eeprom(kio_addr_t ioaddr, int index);
@@ -170,7 +170,7 @@ static void tc589_detach(struct pcmcia_d
 
 ======================================================================*/
 
-static int tc589_attach(struct pcmcia_device *link)
+static int tc589_probe(struct pcmcia_device *link)
 {
     struct el3_private *lp;
     struct net_device *dev;
@@ -212,9 +212,7 @@ static int tc589_attach(struct pcmcia_de
     SET_ETHTOOL_OPS(dev, &netdev_ethtool_ops);
 
     link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-    tc589_config(link);
-
-    return 0;
+    return tc589_config(link);
 } /* tc589_attach */
 
 /*======================================================================
@@ -252,7 +250,7 @@ static void tc589_detach(struct pcmcia_d
 #define CS_CHECK(fn, ret) \
 do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
 
-static void tc589_config(struct pcmcia_device *link)
+static int tc589_config(struct pcmcia_device *link)
 {
     struct net_device *dev = link->priv;
     struct el3_private *lp = netdev_priv(dev);
@@ -359,14 +357,13 @@ static void tc589_config(struct pcmcia_d
     printk(KERN_INFO "  %dK FIFO split %s Rx:Tx, %s xcvr\n",
 	   (fifo & 7) ? 32 : 8, ram_split[(fifo >> 16) & 3],
 	   if_names[dev->if_port]);
-    return;
+    return 0;
 
 cs_failed:
     cs_error(link, last_fn, last_ret);
 failed:
     tc589_release(link);
-    return;
-    
+    return -ENODEV;
 } /* tc589_config */
 
 /*======================================================================
@@ -997,7 +994,7 @@ static struct pcmcia_driver tc589_driver
 	.drv		= {
 		.name	= "3c589_cs",
 	},
-	.probe		= tc589_attach,
+	.probe		= tc589_probe,
 	.remove		= tc589_detach,
         .id_table       = tc589_ids,
 	.suspend	= tc589_suspend,
diff --git a/drivers/net/pcmcia/axnet_cs.c b/drivers/net/pcmcia/axnet_cs.c
index 88f180e..f6ca85d 100644
--- a/drivers/net/pcmcia/axnet_cs.c
+++ b/drivers/net/pcmcia/axnet_cs.c
@@ -86,7 +86,7 @@ static char *version =
 
 /*====================================================================*/
 
-static void axnet_config(struct pcmcia_device *link);
+static int axnet_config(struct pcmcia_device *link);
 static void axnet_release(struct pcmcia_device *link);
 static int axnet_open(struct net_device *dev);
 static int axnet_close(struct net_device *dev);
@@ -142,7 +142,7 @@ static inline axnet_dev_t *PRIV(struct n
 
 ======================================================================*/
 
-static int axnet_attach(struct pcmcia_device *link)
+static int axnet_probe(struct pcmcia_device *link)
 {
     axnet_dev_t *info;
     struct net_device *dev;
@@ -169,9 +169,7 @@ static int axnet_attach(struct pcmcia_de
     SET_ETHTOOL_OPS(dev, &netdev_ethtool_ops);
 
     link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-    axnet_config(link);
-
-    return 0;
+    return axnet_config(link);
 } /* axnet_attach */
 
 /*======================================================================
@@ -288,7 +286,7 @@ static int try_io_port(struct pcmcia_dev
     }
 }
 
-static void axnet_config(struct pcmcia_device *link)
+static int axnet_config(struct pcmcia_device *link)
 {
     struct net_device *dev = link->priv;
     axnet_dev_t *info = PRIV(dev);
@@ -425,14 +423,14 @@ static void axnet_config(struct pcmcia_d
     } else {
 	printk(KERN_NOTICE "  No MII transceivers found!\n");
     }
-    return;
+    return 0;
 
 cs_failed:
     cs_error(link, last_fn, last_ret);
 failed:
     axnet_release(link);
     link->state &= ~DEV_CONFIG_PENDING;
-    return;
+    return -ENODEV;
 } /* axnet_config */
 
 /*======================================================================
@@ -806,7 +804,7 @@ static struct pcmcia_driver axnet_cs_dri
 	.drv		= {
 		.name	= "axnet_cs",
 	},
-	.probe		= axnet_attach,
+	.probe		= axnet_probe,
 	.remove		= axnet_detach,
 	.id_table       = axnet_ids,
 	.suspend	= axnet_suspend,
diff --git a/drivers/net/pcmcia/com20020_cs.c b/drivers/net/pcmcia/com20020_cs.c
index a9bcfb4..a7d675b 100644
--- a/drivers/net/pcmcia/com20020_cs.c
+++ b/drivers/net/pcmcia/com20020_cs.c
@@ -118,7 +118,7 @@ MODULE_LICENSE("GPL");
 
 /*====================================================================*/
 
-static void com20020_config(struct pcmcia_device *link);
+static int com20020_config(struct pcmcia_device *link);
 static void com20020_release(struct pcmcia_device *link);
 
 static void com20020_detach(struct pcmcia_device *p_dev);
@@ -138,7 +138,7 @@ typedef struct com20020_dev_t {
 
 ======================================================================*/
 
-static int com20020_attach(struct pcmcia_device *p_dev)
+static int com20020_probe(struct pcmcia_device *p_dev)
 {
     com20020_dev_t *info;
     struct net_device *dev;
@@ -179,9 +179,7 @@ static int com20020_attach(struct pcmcia
     p_dev->priv = info;
 
     p_dev->state |= DEV_PRESENT;
-    com20020_config(p_dev);
-
-    return 0;
+    return com20020_config(p_dev);
 
 fail_alloc_dev:
     kfree(info);
@@ -250,7 +248,7 @@ static void com20020_detach(struct pcmci
 #define CS_CHECK(fn, ret) \
 do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
 
-static void com20020_config(struct pcmcia_device *link)
+static int com20020_config(struct pcmcia_device *link)
 {
     struct arcnet_local *lp;
     tuple_t tuple;
@@ -345,13 +343,14 @@ static void com20020_config(struct pcmci
 
     DEBUG(1,KERN_INFO "%s: port %#3lx, irq %d\n",
            dev->name, dev->base_addr, dev->irq);
-    return;
+    return 0;
 
 cs_failed:
     cs_error(link, last_fn, last_ret);
 failed:
     DEBUG(1,"com20020_config failed...\n");
     com20020_release(link);
+    return -ENODEV;
 } /* com20020_config */
 
 /*======================================================================
@@ -404,7 +403,7 @@ static struct pcmcia_driver com20020_cs_
 	.drv		= {
 		.name	= "com20020_cs",
 	},
-	.probe		= com20020_attach,
+	.probe		= com20020_probe,
 	.remove		= com20020_detach,
 	.id_table	= com20020_ids,
 	.suspend	= com20020_suspend,
diff --git a/drivers/net/pcmcia/fmvj18x_cs.c b/drivers/net/pcmcia/fmvj18x_cs.c
index ad3e490..d9c83b2 100644
--- a/drivers/net/pcmcia/fmvj18x_cs.c
+++ b/drivers/net/pcmcia/fmvj18x_cs.c
@@ -84,7 +84,7 @@ static char *version = DRV_NAME ".c " DR
 /*
     PCMCIA event handlers
  */
-static void fmvj18x_config(struct pcmcia_device *link);
+static int fmvj18x_config(struct pcmcia_device *link);
 static int fmvj18x_get_hwinfo(struct pcmcia_device *link, u_char *node_id);
 static int fmvj18x_setup_mfc(struct pcmcia_device *link);
 static void fmvj18x_release(struct pcmcia_device *link);
@@ -228,7 +228,7 @@ typedef struct local_info_t {
 #define BANK_1U              0x24 /* bank 1 (CONFIG_1) */
 #define BANK_2U              0x28 /* bank 2 (CONFIG_1) */
 
-static int fmvj18x_attach(struct pcmcia_device *link)
+static int fmvj18x_probe(struct pcmcia_device *link)
 {
     local_info_t *lp;
     struct net_device *dev;
@@ -273,9 +273,7 @@ static int fmvj18x_attach(struct pcmcia_
     SET_ETHTOOL_OPS(dev, &netdev_ethtool_ops);
 
     link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-    fmvj18x_config(link);
-
-    return 0;
+    return fmvj18x_config(link);
 } /* fmvj18x_attach */
 
 /*====================================================================*/
@@ -339,7 +337,7 @@ static int ungermann_try_io_port(struct 
     return ret;	/* RequestIO failed */
 }
 
-static void fmvj18x_config(struct pcmcia_device *link)
+static int fmvj18x_config(struct pcmcia_device *link)
 {
     struct net_device *dev = link->priv;
     local_info_t *lp = netdev_priv(dev);
@@ -552,7 +550,7 @@ static void fmvj18x_config(struct pcmcia
     for (i = 0; i < 6; i++)
 	printk("%02X%s", dev->dev_addr[i], ((i<5) ? ":" : "\n"));
 
-    return;
+    return 0;
     
 cs_failed:
     /* All Card Services errors end up here */
@@ -560,7 +558,7 @@ cs_failed:
 failed:
     fmvj18x_release(link);
     link->state &= ~DEV_CONFIG_PENDING;
-
+    return -ENODEV;
 } /* fmvj18x_config */
 /*====================================================================*/
 
@@ -720,7 +718,7 @@ static struct pcmcia_driver fmvj18x_cs_d
 	.drv		= {
 		.name	= "fmvj18x_cs",
 	},
-	.probe		= fmvj18x_attach,
+	.probe		= fmvj18x_probe,
 	.remove		= fmvj18x_detach,
 	.id_table       = fmvj18x_ids,
 	.suspend	= fmvj18x_suspend,
diff --git a/drivers/net/pcmcia/ibmtr_cs.c b/drivers/net/pcmcia/ibmtr_cs.c
index 1b8b44d..e038d92 100644
--- a/drivers/net/pcmcia/ibmtr_cs.c
+++ b/drivers/net/pcmcia/ibmtr_cs.c
@@ -105,7 +105,7 @@ MODULE_LICENSE("GPL");
 
 /*====================================================================*/
 
-static void ibmtr_config(struct pcmcia_device *link);
+static int ibmtr_config(struct pcmcia_device *link);
 static void ibmtr_hw_setup(struct net_device *dev, u_int mmiobase);
 static void ibmtr_release(struct pcmcia_device *link);
 static void ibmtr_detach(struct pcmcia_device *p_dev);
@@ -174,9 +174,7 @@ static int ibmtr_attach(struct pcmcia_de
     SET_ETHTOOL_OPS(dev, &netdev_ethtool_ops);
 
     link->state |= DEV_PRESENT;
-    ibmtr_config(link);
-
-    return 0;
+    return ibmtr_config(link);
 } /* ibmtr_attach */
 
 /*======================================================================
@@ -220,7 +218,7 @@ static void ibmtr_detach(struct pcmcia_d
 #define CS_CHECK(fn, ret) \
 do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
 
-static void ibmtr_config(struct pcmcia_device *link)
+static int ibmtr_config(struct pcmcia_device *link)
 {
     ibmtr_dev_t *info = link->priv;
     struct net_device *dev = info->dev;
@@ -323,12 +321,13 @@ static void ibmtr_config(struct pcmcia_d
     for (i = 0; i < TR_ALEN; i++)
         printk("%02X", dev->dev_addr[i]);
     printk("\n");
-    return;
+    return 0;
 
 cs_failed:
     cs_error(link, last_fn, last_ret);
 failed:
     ibmtr_release(link);
+    return -ENODEV;
 } /* ibmtr_config */
 
 /*======================================================================
diff --git a/drivers/net/pcmcia/nmclan_cs.c b/drivers/net/pcmcia/nmclan_cs.c
index 8b8e716..ea8a62e 100644
--- a/drivers/net/pcmcia/nmclan_cs.c
+++ b/drivers/net/pcmcia/nmclan_cs.c
@@ -417,7 +417,7 @@ INT_MODULE_PARM(pc_debug, PCMCIA_DEBUG);
 Function Prototypes
 ---------------------------------------------------------------------------- */
 
-static void nmclan_config(struct pcmcia_device *link);
+static int nmclan_config(struct pcmcia_device *link);
 static void nmclan_release(struct pcmcia_device *link);
 
 static void nmclan_reset(struct net_device *dev);
@@ -443,7 +443,7 @@ nmclan_attach
 	Services.
 ---------------------------------------------------------------------------- */
 
-static int nmclan_attach(struct pcmcia_device *link)
+static int nmclan_probe(struct pcmcia_device *link)
 {
     mace_private *lp;
     struct net_device *dev;
@@ -488,9 +488,7 @@ static int nmclan_attach(struct pcmcia_d
 #endif
 
     link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-    nmclan_config(link);
-
-    return 0;
+    return nmclan_config(link);
 } /* nmclan_attach */
 
 /* ----------------------------------------------------------------------------
@@ -655,7 +653,7 @@ nmclan_config
 #define CS_CHECK(fn, ret) \
   do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
 
-static void nmclan_config(struct pcmcia_device *link)
+static int nmclan_config(struct pcmcia_device *link)
 {
   struct net_device *dev = link->priv;
   mace_private *lp = netdev_priv(dev);
@@ -710,7 +708,7 @@ static void nmclan_config(struct pcmcia_
       printk(KERN_NOTICE "nmclan_cs: mace id not found: %x %x should"
 	     " be 0x40 0x?9\n", sig[0], sig[1]);
       link->state &= ~DEV_CONFIG_PENDING;
-      return;
+      return -ENODEV;
     }
   }
 
@@ -740,14 +738,13 @@ static void nmclan_config(struct pcmcia_
 	 dev->name, dev->base_addr, dev->irq, if_names[dev->if_port]);
   for (i = 0; i < 6; i++)
       printk("%02X%s", dev->dev_addr[i], ((i<5) ? ":" : "\n"));
-  return;
+  return 0;
 
 cs_failed:
-    cs_error(link, last_fn, last_ret);
+	cs_error(link, last_fn, last_ret);
 failed:
-    nmclan_release(link);
-    return;
-
+	nmclan_release(link);
+	return -ENODEV;
 } /* nmclan_config */
 
 /* ----------------------------------------------------------------------------
@@ -1611,7 +1608,7 @@ static struct pcmcia_driver nmclan_cs_dr
 	.drv		= {
 		.name	= "nmclan_cs",
 	},
-	.probe		= nmclan_attach,
+	.probe		= nmclan_probe,
 	.remove		= nmclan_detach,
 	.id_table       = nmclan_ids,
 	.suspend	= nmclan_suspend,
diff --git a/drivers/net/pcmcia/pcnet_cs.c b/drivers/net/pcmcia/pcnet_cs.c
index 9f41355..d840c0f 100644
--- a/drivers/net/pcmcia/pcnet_cs.c
+++ b/drivers/net/pcmcia/pcnet_cs.c
@@ -103,7 +103,7 @@ module_param_array(hw_addr, int, NULL, 0
 /*====================================================================*/
 
 static void mii_phy_probe(struct net_device *dev);
-static void pcnet_config(struct pcmcia_device *link);
+static int pcnet_config(struct pcmcia_device *link);
 static void pcnet_release(struct pcmcia_device *link);
 static int pcnet_open(struct net_device *dev);
 static int pcnet_close(struct net_device *dev);
@@ -265,9 +265,7 @@ static int pcnet_probe(struct pcmcia_dev
     dev->set_config = &set_config;
 
     link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-    pcnet_config(link);
-
-    return 0;
+    return pcnet_config(link);
 } /* pcnet_attach */
 
 /*======================================================================
@@ -516,7 +514,7 @@ static int try_io_port(struct pcmcia_dev
     }
 }
 
-static void pcnet_config(struct pcmcia_device *link)
+static int pcnet_config(struct pcmcia_device *link)
 {
     struct net_device *dev = link->priv;
     pcnet_dev_t *info = PRIV(dev);
@@ -701,14 +699,14 @@ static void pcnet_config(struct pcmcia_d
     printk(" hw_addr ");
     for (i = 0; i < 6; i++)
 	printk("%02X%s", dev->dev_addr[i], ((i<5) ? ":" : "\n"));
-    return;
+    return 0;
 
 cs_failed:
     cs_error(link, last_fn, last_ret);
 failed:
     pcnet_release(link);
     link->state &= ~DEV_CONFIG_PENDING;
-    return;
+    return -ENODEV;
 } /* pcnet_config */
 
 /*======================================================================
diff --git a/drivers/net/pcmcia/smc91c92_cs.c b/drivers/net/pcmcia/smc91c92_cs.c
index a4ee305..3252c1d 100644
--- a/drivers/net/pcmcia/smc91c92_cs.c
+++ b/drivers/net/pcmcia/smc91c92_cs.c
@@ -279,7 +279,7 @@ enum RxCfg { RxAllMulti = 0x0004, RxProm
 /*====================================================================*/
 
 static void smc91c92_detach(struct pcmcia_device *p_dev);
-static void smc91c92_config(struct pcmcia_device *link);
+static int smc91c92_config(struct pcmcia_device *link);
 static void smc91c92_release(struct pcmcia_device *link);
 
 static int smc_open(struct net_device *dev);
@@ -309,7 +309,7 @@ static struct ethtool_ops ethtool_ops;
 
 ======================================================================*/
 
-static int smc91c92_attach(struct pcmcia_device *link)
+static int smc91c92_probe(struct pcmcia_device *link)
 {
     struct smc_private *smc;
     struct net_device *dev;
@@ -357,9 +357,7 @@ static int smc91c92_attach(struct pcmcia
     smc->mii_if.reg_num_mask = 0x1f;
 
     link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-    smc91c92_config(link);
-
-    return 0;
+    return smc91c92_config(link);
 } /* smc91c92_attach */
 
 /*======================================================================
@@ -972,7 +970,7 @@ static int check_sig(struct pcmcia_devic
 #define CS_EXIT_TEST(ret, svc, label) \
 if (ret != CS_SUCCESS) { cs_error(link, svc, ret); goto label; }
 
-static void smc91c92_config(struct pcmcia_device *link)
+static int smc91c92_config(struct pcmcia_device *link)
 {
     struct net_device *dev = link->priv;
     struct smc_private *smc = netdev_priv(dev);
@@ -1145,7 +1143,7 @@ static void smc91c92_config(struct pcmci
 	}
     }
     kfree(cfg_mem);
-    return;
+    return 0;
 
 config_undo:
     unregister_netdev(dev);
@@ -1153,7 +1151,7 @@ config_failed:			/* CS_EXIT_TEST() calls
     smc91c92_release(link);
     link->state &= ~DEV_CONFIG_PENDING;
     kfree(cfg_mem);
-
+    return -ENODEV;
 } /* smc91c92_config */
 
 /*======================================================================
@@ -2289,7 +2287,7 @@ static struct pcmcia_driver smc91c92_cs_
 	.drv		= {
 		.name	= "smc91c92_cs",
 	},
-	.probe		= smc91c92_attach,
+	.probe		= smc91c92_probe,
 	.remove		= smc91c92_detach,
 	.id_table       = smc91c92_ids,
 	.suspend	= smc91c92_suspend,
diff --git a/drivers/net/pcmcia/xirc2ps_cs.c b/drivers/net/pcmcia/xirc2ps_cs.c
index 84328da..77bf4e3 100644
--- a/drivers/net/pcmcia/xirc2ps_cs.c
+++ b/drivers/net/pcmcia/xirc2ps_cs.c
@@ -290,7 +290,7 @@ static void mii_wr(kio_addr_t ioaddr, u_
  */
 
 static int has_ce2_string(struct pcmcia_device * link);
-static void xirc2ps_config(struct pcmcia_device * link);
+static int xirc2ps_config(struct pcmcia_device * link);
 static void xirc2ps_release(struct pcmcia_device * link);
 
 /****************
@@ -553,7 +553,7 @@ mii_wr(kio_addr_t ioaddr, u_char phyaddr
  */
 
 static int
-xirc2ps_attach(struct pcmcia_device *link)
+xirc2ps_probe(struct pcmcia_device *link)
 {
     struct net_device *dev;
     local_info_t *local;
@@ -592,9 +592,7 @@ xirc2ps_attach(struct pcmcia_device *lin
 #endif
 
     link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-    xirc2ps_config(link);
-
-    return 0;
+    return xirc2ps_config(link);
 } /* xirc2ps_attach */
 
 /****************
@@ -731,7 +729,7 @@ has_ce2_string(struct pcmcia_device * li
  * is received, to configure the PCMCIA socket, and to make the
  * ethernet device available to the system.
  */
-static void
+static int
 xirc2ps_config(struct pcmcia_device * link)
 {
     struct net_device *dev = link->priv;
@@ -1061,17 +1059,18 @@ xirc2ps_config(struct pcmcia_device * li
 	printk("%c%02X", i?':':' ', dev->dev_addr[i]);
     printk("\n");
 
-    return;
+    return 0;
 
   config_error:
     link->state &= ~DEV_CONFIG_PENDING;
     xirc2ps_release(link);
-    return;
+    return -ENODEV;
 
   cis_error:
     printk(KNOT_XIRC "unable to parse CIS\n");
   failure:
     link->state &= ~DEV_CONFIG_PENDING;
+    return -ENODEV;
 } /* xirc2ps_config */
 
 /****************
@@ -1911,7 +1910,7 @@ static struct pcmcia_driver xirc2ps_cs_d
 	.drv		= {
 		.name	= "xirc2ps_cs",
 	},
-	.probe		= xirc2ps_attach,
+	.probe		= xirc2ps_probe,
 	.remove		= xirc2ps_detach,
 	.id_table       = xirc2ps_ids,
 	.suspend	= xirc2ps_suspend,
diff --git a/drivers/net/wireless/airo_cs.c b/drivers/net/wireless/airo_cs.c
index 7697019..97f4156 100644
--- a/drivers/net/wireless/airo_cs.c
+++ b/drivers/net/wireless/airo_cs.c
@@ -80,7 +80,7 @@ MODULE_SUPPORTED_DEVICE("Aironet 4500, 4
    event handler. 
 */
 
-static void airo_config(struct pcmcia_device *link);
+static int airo_config(struct pcmcia_device *link);
 static void airo_release(struct pcmcia_device *link);
 
 /*
@@ -141,7 +141,7 @@ typedef struct local_info_t {
   
   ======================================================================*/
 
-static int airo_attach(struct pcmcia_device *p_dev)
+static int airo_probe(struct pcmcia_device *p_dev)
 {
 	local_info_t *local;
 
@@ -171,9 +171,7 @@ static int airo_attach(struct pcmcia_dev
 	p_dev->priv = local;
 
 	p_dev->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-	airo_config(p_dev);
-
-	return 0;
+	return airo_config(p_dev);
 } /* airo_attach */
 
 /*======================================================================
@@ -211,7 +209,7 @@ static void airo_detach(struct pcmcia_de
 #define CS_CHECK(fn, ret) \
 do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
 
-static void airo_config(struct pcmcia_device *link)
+static int airo_config(struct pcmcia_device *link)
 {
 	tuple_t tuple;
 	cisparse_t parse;
@@ -386,12 +384,12 @@ static void airo_config(struct pcmcia_de
 	printk("\n");
 	
 	link->state &= ~DEV_CONFIG_PENDING;
-	return;
-	
+	return 0;
+
  cs_failed:
 	cs_error(link, last_fn, last_ret);
 	airo_release(link);
-	
+	return -ENODEV;
 } /* airo_config */
 
 /*======================================================================
@@ -444,7 +442,7 @@ static struct pcmcia_driver airo_driver 
 	.drv		= {
 		.name	= "airo_cs",
 	},
-	.probe		= airo_attach,
+	.probe		= airo_probe,
 	.remove		= airo_detach,
 	.id_table       = airo_ids,
 	.suspend	= airo_suspend,
diff --git a/drivers/net/wireless/atmel_cs.c b/drivers/net/wireless/atmel_cs.c
index 843dd1a..962272c 100644
--- a/drivers/net/wireless/atmel_cs.c
+++ b/drivers/net/wireless/atmel_cs.c
@@ -91,7 +91,7 @@ MODULE_SUPPORTED_DEVICE("Atmel at76c50x 
    event handler. 
 */
 
-static void atmel_config(struct pcmcia_device *link);
+static int atmel_config(struct pcmcia_device *link);
 static void atmel_release(struct pcmcia_device *link);
 
 /*
@@ -152,7 +152,7 @@ typedef struct local_info_t {
   
   ======================================================================*/
 
-static int atmel_attach(struct pcmcia_device *p_dev)
+static int atmel_probe(struct pcmcia_device *p_dev)
 {
 	local_info_t *local;
 
@@ -182,9 +182,7 @@ static int atmel_attach(struct pcmcia_de
 	p_dev->priv = local;
 
 	p_dev->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-	atmel_config(p_dev);
-
-	return 0;
+	return atmel_config(p_dev);
 } /* atmel_attach */
 
 /*======================================================================
@@ -230,7 +228,7 @@ static int card_present(void *arg)
 	return 0;
 }
 
-static void atmel_config(struct pcmcia_device *link)
+static int atmel_config(struct pcmcia_device *link)
 {
 	tuple_t tuple;
 	cisparse_t parse;
@@ -377,11 +375,12 @@ static void atmel_config(struct pcmcia_d
 	link->dev_node = &dev->node;
 			
 	link->state &= ~DEV_CONFIG_PENDING;
-	return;
+	return 0;
 	
  cs_failed:
 	cs_error(link, last_fn, last_ret);
 	atmel_release(link);
+	return -ENODEV;
 }
 
 /*======================================================================
@@ -476,7 +475,7 @@ static struct pcmcia_driver atmel_driver
 	.drv		= {
 		.name	= "atmel_cs",
         },
-	.probe          = atmel_attach,
+	.probe          = atmel_probe,
 	.remove		= atmel_detach,
 	.id_table	= atmel_ids,
 	.suspend	= atmel_suspend,
diff --git a/drivers/net/wireless/hostap/hostap_cs.c b/drivers/net/wireless/hostap/hostap_cs.c
index 89b1781..88dc383 100644
--- a/drivers/net/wireless/hostap/hostap_cs.c
+++ b/drivers/net/wireless/hostap/hostap_cs.c
@@ -501,16 +501,20 @@ static struct prism2_helper_functions pr
 
 /* allocate local data and register with CardServices
  * initialize dev_link structure, but do not configure the card yet */
-static int prism2_attach(struct pcmcia_device *p_dev)
+static int hostap_cs_probe(struct pcmcia_device *p_dev)
 {
+	int ret;
+
 	PDEBUG(DEBUG_HW, "%s: setting Vcc=33 (constant)\n", dev_info);
 	p_dev->conf.IntType = INT_MEMORY_AND_IO;
 
 	p_dev->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-	if (prism2_config(p_dev))
+	ret = prism2_config(p_dev);
+	if (ret) {
 		PDEBUG(DEBUG_EXTRA, "prism2_config() failed\n");
+	}
 
-	return 0;
+	return ret;
 }
 
 
@@ -894,7 +898,7 @@ static struct pcmcia_driver hostap_drive
 	.drv		= {
 		.name	= "hostap_cs",
 	},
-	.probe		= prism2_attach,
+	.probe		= hostap_cs_probe,
 	.remove		= prism2_detach,
 	.owner		= THIS_MODULE,
 	.id_table	= hostap_cs_ids,
diff --git a/drivers/net/wireless/netwave_cs.c b/drivers/net/wireless/netwave_cs.c
index 2a68886..2689f3b 100644
--- a/drivers/net/wireless/netwave_cs.c
+++ b/drivers/net/wireless/netwave_cs.c
@@ -191,7 +191,7 @@ module_param(mem_speed, int, 0);
 
 /* PCMCIA (Card Services) related functions */
 static void netwave_release(struct pcmcia_device *link);     /* Card removal */
-static void netwave_pcmcia_config(struct pcmcia_device *arg); /* Runs after card
+static int netwave_pcmcia_config(struct pcmcia_device *arg); /* Runs after card
 													   insertion */
 static void netwave_detach(struct pcmcia_device *p_dev);    /* Destroy instance */
 
@@ -376,7 +376,7 @@ static struct iw_statistics *netwave_get
  *     configure the card at this point -- we wait until we receive a
  *     card insertion event.
  */
-static int netwave_attach(struct pcmcia_device *link)
+static int netwave_probe(struct pcmcia_device *link)
 {
     struct net_device *dev;
     netwave_private *priv;
@@ -429,9 +429,7 @@ static int netwave_attach(struct pcmcia_
     link->irq.Instance = dev;
 
     link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-    netwave_pcmcia_config( link);
-
-    return 0;
+    return netwave_pcmcia_config( link);
 } /* netwave_attach */
 
 /*
@@ -737,7 +735,7 @@ static const struct iw_handler_def	netwa
 #define CS_CHECK(fn, ret) \
 do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
 
-static void netwave_pcmcia_config(struct pcmcia_device *link) {
+static int netwave_pcmcia_config(struct pcmcia_device *link) {
     struct net_device *dev = link->priv;
     netwave_private *priv = netdev_priv(dev);
     tuple_t tuple;
@@ -845,12 +843,13 @@ static void netwave_pcmcia_config(struct
     printk(KERN_DEBUG "Netwave_reset: revision %04x %04x\n", 
 	   get_uint16(ramBase + NETWAVE_EREG_ARW),
 	   get_uint16(ramBase + NETWAVE_EREG_ARW+2));
-    return;
+    return 0;
 
 cs_failed:
     cs_error(link, last_fn, last_ret);
 failed:
     netwave_release(link);
+    return -ENODEV;
 } /* netwave_pcmcia_config */
 
 /*
@@ -1387,7 +1386,7 @@ static struct pcmcia_driver netwave_driv
 	.drv		= {
 		.name	= "netwave_cs",
 	},
-	.probe		= netwave_attach,
+	.probe		= netwave_probe,
 	.remove		= netwave_detach,
 	.id_table       = netwave_ids,
 	.suspend	= netwave_suspend,
diff --git a/drivers/net/wireless/orinoco_cs.c b/drivers/net/wireless/orinoco_cs.c
index 405b7ba..0e92bee 100644
--- a/drivers/net/wireless/orinoco_cs.c
+++ b/drivers/net/wireless/orinoco_cs.c
@@ -63,7 +63,7 @@ struct orinoco_pccard {
 /* Function prototypes						    */
 /********************************************************************/
 
-static void orinoco_cs_config(struct pcmcia_device *link);
+static int orinoco_cs_config(struct pcmcia_device *link);
 static void orinoco_cs_release(struct pcmcia_device *link);
 static void orinoco_cs_detach(struct pcmcia_device *p_dev);
 
@@ -104,7 +104,7 @@ orinoco_cs_hard_reset(struct orinoco_pri
  * configure the card at this point -- we wait until we receive a card
  * insertion event.  */
 static int
-orinoco_cs_attach(struct pcmcia_device *link)
+orinoco_cs_probe(struct pcmcia_device *link)
 {
 	struct net_device *dev;
 	struct orinoco_private *priv;
@@ -135,9 +135,7 @@ orinoco_cs_attach(struct pcmcia_device *
 	link->conf.IntType = INT_MEMORY_AND_IO;
 
 	link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-	orinoco_cs_config(link);
-
-	return 0;
+	return orinoco_cs_config(link);
 }				/* orinoco_cs_attach */
 
 /*
@@ -172,7 +170,7 @@ static void orinoco_cs_detach(struct pcm
 		last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; \
 	} while (0)
 
-static void
+static int
 orinoco_cs_config(struct pcmcia_device *link)
 {
 	struct net_device *dev = link->priv;
@@ -377,13 +375,14 @@ orinoco_cs_config(struct pcmcia_device *
 		       link->io.BasePort2 + link->io.NumPorts2 - 1);
 	printk("\n");
 
-	return;
+	return 0;
 
  cs_failed:
 	cs_error(link, last_fn, last_ret);
 
  failed:
 	orinoco_cs_release(link);
+	return -ENODEV;
 }				/* orinoco_cs_config */
 
 /*
@@ -576,7 +575,7 @@ static struct pcmcia_driver orinoco_driv
 	.drv		= {
 		.name	= DRIVER_NAME,
 	},
-	.probe		= orinoco_cs_attach,
+	.probe		= orinoco_cs_probe,
 	.remove		= orinoco_cs_detach,
 	.id_table       = orinoco_cs_ids,
 	.suspend	= orinoco_cs_suspend,
diff --git a/drivers/net/wireless/ray_cs.c b/drivers/net/wireless/ray_cs.c
index 415ae8b..8cfe933 100644
--- a/drivers/net/wireless/ray_cs.c
+++ b/drivers/net/wireless/ray_cs.c
@@ -90,7 +90,7 @@ module_param(pc_debug, int, 0);
 #define DEBUG(n, args...)
 #endif
 /** Prototypes based on PCMCIA skeleton driver *******************************/
-static void ray_config(struct pcmcia_device *link);
+static int ray_config(struct pcmcia_device *link);
 static void ray_release(struct pcmcia_device *link);
 static void ray_detach(struct pcmcia_device *p_dev);
 
@@ -303,7 +303,7 @@ static char rcsid[] = "Raylink/WebGear w
     configure the card at this point -- we wait until we receive a
     card insertion event.
 =============================================================================*/
-static int ray_attach(struct pcmcia_device *p_dev)
+static int ray_probe(struct pcmcia_device *p_dev)
 {
     ray_dev_t *local;
     struct net_device *dev;
@@ -368,9 +368,7 @@ static int ray_attach(struct pcmcia_devi
 
     p_dev->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
     this_device = p_dev;
-    ray_config(p_dev);
-
-    return 0;
+    return ray_config(p_dev);
 
 fail_alloc_dev:
     return -ENOMEM;
@@ -412,7 +410,7 @@ static void ray_detach(struct pcmcia_dev
 #define CS_CHECK(fn, ret) \
 do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
 #define MAX_TUPLE_SIZE 128
-static void ray_config(struct pcmcia_device *link)
+static int ray_config(struct pcmcia_device *link)
 {
     tuple_t tuple;
     cisparse_t parse;
@@ -499,7 +497,7 @@ static void ray_config(struct pcmcia_dev
     DEBUG(3,"ray_config amem=%p\n",local->amem);
     if (ray_init(dev) < 0) {
         ray_release(link);
-        return;
+        return -ENODEV;
     }
 
     SET_NETDEV_DEV(dev, &handle_to_dev(link));
@@ -507,7 +505,7 @@ static void ray_config(struct pcmcia_dev
     if (i != 0) {
         printk("ray_config register_netdev() failed\n");
         ray_release(link);
-        return;
+        return i;
     }
 
     strcpy(local->node.dev_name, dev->name);
@@ -519,12 +517,13 @@ static void ray_config(struct pcmcia_dev
     for (i = 0; i < 6; i++)
     printk("%02X%s", dev->dev_addr[i], ((i<5) ? ":" : "\n"));
 
-    return;
+    return 0;
 
 cs_failed:
     cs_error(link, last_fn, last_ret);
 
     ray_release(link);
+    return -ENODEV;
 } /* ray_config */
 
 static inline struct ccs __iomem *ccs_base(ray_dev_t *dev)
@@ -2846,7 +2845,7 @@ static struct pcmcia_driver ray_driver =
 	.drv		= {
 		.name	= "ray_cs",
 	},
-	.probe		= ray_attach,
+	.probe		= ray_probe,
 	.remove		= ray_detach,
 	.id_table       = ray_ids,
 	.suspend	= ray_suspend,
diff --git a/drivers/net/wireless/spectrum_cs.c b/drivers/net/wireless/spectrum_cs.c
index a75ea7e..118b2c6 100644
--- a/drivers/net/wireless/spectrum_cs.c
+++ b/drivers/net/wireless/spectrum_cs.c
@@ -71,7 +71,7 @@ struct orinoco_pccard {
 /* Function prototypes						    */
 /********************************************************************/
 
-static void spectrum_cs_config(struct pcmcia_device *link);
+static int spectrum_cs_config(struct pcmcia_device *link);
 static void spectrum_cs_release(struct pcmcia_device *link);
 
 /********************************************************************/
@@ -583,7 +583,7 @@ spectrum_cs_hard_reset(struct orinoco_pr
  * configure the card at this point -- we wait until we receive a card
  * insertion event.  */
 static int
-spectrum_cs_attach(struct pcmcia_device *link)
+spectrum_cs_probe(struct pcmcia_device *link)
 {
 	struct net_device *dev;
 	struct orinoco_private *priv;
@@ -614,9 +614,7 @@ spectrum_cs_attach(struct pcmcia_device 
 	link->conf.IntType = INT_MEMORY_AND_IO;
 
 	link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-	spectrum_cs_config(link);
-
-	return 0;
+	return spectrum_cs_config(link);
 }				/* spectrum_cs_attach */
 
 /*
@@ -647,7 +645,7 @@ static void spectrum_cs_detach(struct pc
  * device available to the system.
  */
 
-static void
+static int
 spectrum_cs_config(struct pcmcia_device *link)
 {
 	struct net_device *dev = link->priv;
@@ -857,13 +855,14 @@ spectrum_cs_config(struct pcmcia_device 
 		       link->io.BasePort2 + link->io.NumPorts2 - 1);
 	printk("\n");
 
-	return;
+	return 0;
 
  cs_failed:
 	cs_error(link, last_fn, last_ret);
 
  failed:
 	spectrum_cs_release(link);
+	return -ENODEV;
 }				/* spectrum_cs_config */
 
 /*
@@ -954,7 +953,7 @@ static struct pcmcia_driver orinoco_driv
 	.drv		= {
 		.name	= DRIVER_NAME,
 	},
-	.probe		= spectrum_cs_attach,
+	.probe		= spectrum_cs_probe,
 	.remove		= spectrum_cs_detach,
 	.suspend	= spectrum_cs_suspend,
 	.resume		= spectrum_cs_resume,
diff --git a/drivers/net/wireless/wavelan_cs.c b/drivers/net/wireless/wavelan_cs.c
index 352d4a5..7373caf 100644
--- a/drivers/net/wireless/wavelan_cs.c
+++ b/drivers/net/wireless/wavelan_cs.c
@@ -4580,10 +4580,11 @@ wavelan_close(struct net_device *	dev)
  * card insertion event.
  */
 static int
-wavelan_attach(struct pcmcia_device *p_dev)
+wavelan_probe(struct pcmcia_device *p_dev)
 {
   struct net_device *	dev;		/* Interface generic data */
   net_local *	lp;		/* Interface specific data */
+  int ret;
 
 #ifdef DEBUG_CALLBACK_TRACE
   printk(KERN_DEBUG "-> wavelan_attach()\n");
@@ -4651,11 +4652,18 @@ wavelan_attach(struct pcmcia_device *p_d
   dev->mtu = WAVELAN_MTU;
 
   p_dev->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-  if(wv_pcmcia_config(p_dev) &&
-     wv_hw_config(dev))
-	  wv_init_info(dev);
-  else
+  ret = wv_pcmcia_config(p_dev);
+  if (ret)
+	  return ret;
+
+  ret = wv_hw_config(dev);
+  if (ret) {
 	  dev->irq = 0;
+	  pcmcia_disable_device(p_dev);
+	  return ret;
+  }
+
+  wv_init_info(dev);
 
 #ifdef DEBUG_CALLBACK_TRACE
   printk(KERN_DEBUG "<- wavelan_attach()\n");
@@ -4760,7 +4768,7 @@ static struct pcmcia_driver wavelan_driv
 	.drv		= {
 		.name	= "wavelan_cs",
 	},
-	.probe		= wavelan_attach,
+	.probe		= wavelan_probe,
 	.remove		= wavelan_detach,
 	.id_table       = wavelan_ids,
 	.suspend	= wavelan_suspend,
diff --git a/drivers/net/wireless/wl3501_cs.c b/drivers/net/wireless/wl3501_cs.c
index 752d222..6b3a605 100644
--- a/drivers/net/wireless/wl3501_cs.c
+++ b/drivers/net/wireless/wl3501_cs.c
@@ -103,7 +103,7 @@ module_param(pc_debug, int, 0);
  * release a socket, in response to card insertion and ejection events.  They
  * are invoked from the wl24 event handler.
  */
-static void wl3501_config(struct pcmcia_device *link);
+static int wl3501_config(struct pcmcia_device *link);
 static void wl3501_release(struct pcmcia_device *link);
 
 /*
@@ -1920,7 +1920,7 @@ static const struct iw_handler_def wl350
  * The dev_link structure is initialized, but we don't actually configure the
  * card at this point -- we wait until we receive a card insertion event.
  */
-static int wl3501_attach(struct pcmcia_device *p_dev)
+static int wl3501_probe(struct pcmcia_device *p_dev)
 {
 	struct net_device *dev;
 	struct wl3501_card *this;
@@ -1960,9 +1960,7 @@ static int wl3501_attach(struct pcmcia_d
 	p_dev->priv = p_dev->irq.Instance = dev;
 
 	p_dev->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-	wl3501_config(p_dev);
-
-	return 0;
+	return wl3501_config(p_dev);
 out_link:
 	return -ENOMEM;
 }
@@ -1978,7 +1976,7 @@ do { last_fn = (fn); if ((last_ret = (re
  * received, to configure the PCMCIA socket, and to make the ethernet device
  * available to the system.
  */
-static void wl3501_config(struct pcmcia_device *link)
+static int wl3501_config(struct pcmcia_device *link)
 {
 	tuple_t tuple;
 	cisparse_t parse;
@@ -2082,13 +2080,13 @@ static void wl3501_config(struct pcmcia_
 	spin_lock_init(&this->lock);
 	init_waitqueue_head(&this->wait);
 	netif_start_queue(dev);
-	goto out;
+	return 0;
+
 cs_failed:
 	cs_error(link, last_fn, last_ret);
 failed:
 	wl3501_release(link);
-out:
-	return;
+	return -ENODEV;
 }
 
 /**
@@ -2146,7 +2144,7 @@ static struct pcmcia_driver wl3501_drive
 	.drv		= {
 		.name	= "wl3501_cs",
 	},
-	.probe		= wl3501_attach,
+	.probe		= wl3501_probe,
 	.remove		= wl3501_detach,
 	.id_table	= wl3501_ids,
 	.suspend	= wl3501_suspend,
diff --git a/drivers/parport/parport_cs.c b/drivers/parport/parport_cs.c
index 6dcaf44..e4be826 100644
--- a/drivers/parport/parport_cs.c
+++ b/drivers/parport/parport_cs.c
@@ -88,7 +88,7 @@ typedef struct parport_info_t {
 } parport_info_t;
 
 static void parport_detach(struct pcmcia_device *p_dev);
-static void parport_config(struct pcmcia_device *link);
+static int parport_config(struct pcmcia_device *link);
 static void parport_cs_release(struct pcmcia_device *);
 
 /*======================================================================
@@ -99,7 +99,7 @@ static void parport_cs_release(struct pc
 
 ======================================================================*/
 
-static int parport_attach(struct pcmcia_device *link)
+static int parport_probe(struct pcmcia_device *link)
 {
     parport_info_t *info;
 
@@ -120,9 +120,7 @@ static int parport_attach(struct pcmcia_
     link->conf.IntType = INT_MEMORY_AND_IO;
 
     link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-    parport_config(link);
-
-    return 0;
+    return parport_config(link);
 } /* parport_attach */
 
 /*======================================================================
@@ -155,7 +153,7 @@ static void parport_detach(struct pcmcia
 #define CS_CHECK(fn, ret) \
 do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
 
-void parport_config(struct pcmcia_device *link)
+static int parport_config(struct pcmcia_device *link)
 {
     parport_info_t *info = link->priv;
     tuple_t tuple;
@@ -236,14 +234,14 @@ void parport_config(struct pcmcia_device
     link->dev_node = &info->node;
 
     link->state &= ~DEV_CONFIG_PENDING;
-    return;
-    
+    return 0;
+
 cs_failed:
     cs_error(link, last_fn, last_ret);
 failed:
     parport_cs_release(link);
     link->state &= ~DEV_CONFIG_PENDING;
-
+    return -ENODEV;
 } /* parport_config */
 
 /*======================================================================
@@ -282,7 +280,7 @@ static struct pcmcia_driver parport_cs_d
 	.drv		= {
 		.name	= "parport_cs",
 	},
-	.probe		= parport_attach,
+	.probe		= parport_probe,
 	.remove		= parport_detach,
 	.id_table	= parport_ids,
 };
diff --git a/drivers/scsi/pcmcia/aha152x_stub.c b/drivers/scsi/pcmcia/aha152x_stub.c
index 21c6b10..7caa700 100644
--- a/drivers/scsi/pcmcia/aha152x_stub.c
+++ b/drivers/scsi/pcmcia/aha152x_stub.c
@@ -96,11 +96,11 @@ typedef struct scsi_info_t {
 
 static void aha152x_release_cs(struct pcmcia_device *link);
 static void aha152x_detach(struct pcmcia_device *p_dev);
-static void aha152x_config_cs(struct pcmcia_device *link);
+static int aha152x_config_cs(struct pcmcia_device *link);
 
 static struct pcmcia_device *dev_list;
 
-static int aha152x_attach(struct pcmcia_device *link)
+static int aha152x_probe(struct pcmcia_device *link)
 {
     scsi_info_t *info;
 
@@ -123,9 +123,7 @@ static int aha152x_attach(struct pcmcia_
     link->conf.Present = PRESENT_OPTION;
 
     link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-    aha152x_config_cs(link);
-
-    return 0;
+    return aha152x_config_cs(link);
 } /* aha152x_attach */
 
 /*====================================================================*/
@@ -146,7 +144,7 @@ static void aha152x_detach(struct pcmcia
 #define CS_CHECK(fn, ret) \
 do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
 
-static void aha152x_config_cs(struct pcmcia_device *link)
+static int aha152x_config_cs(struct pcmcia_device *link)
 {
     scsi_info_t *info = link->priv;
     struct aha152x_setup s;
@@ -219,12 +217,12 @@ static void aha152x_config_cs(struct pcm
     info->host = host;
 
     link->state &= ~DEV_CONFIG_PENDING;
-    return;
-    
+    return 0;
+
 cs_failed:
     cs_error(link, last_fn, last_ret);
     aha152x_release_cs(link);
-    return;
+    return -ENODEV;
 }
 
 static void aha152x_release_cs(struct pcmcia_device *link)
@@ -259,7 +257,7 @@ static struct pcmcia_driver aha152x_cs_d
 	.drv		= {
 		.name	= "aha152x_cs",
 	},
-	.probe		= aha152x_attach,
+	.probe		= aha152x_probe,
 	.remove		= aha152x_detach,
 	.id_table       = aha152x_ids,
 	.resume		= aha152x_resume,
@@ -278,4 +276,3 @@ static void __exit exit_aha152x_cs(void)
 
 module_init(init_aha152x_cs);
 module_exit(exit_aha152x_cs);
- 
diff --git a/drivers/scsi/pcmcia/fdomain_stub.c b/drivers/scsi/pcmcia/fdomain_stub.c
index 4e69271..80afd3e 100644
--- a/drivers/scsi/pcmcia/fdomain_stub.c
+++ b/drivers/scsi/pcmcia/fdomain_stub.c
@@ -81,33 +81,32 @@ typedef struct scsi_info_t {
 
 static void fdomain_release(struct pcmcia_device *link);
 static void fdomain_detach(struct pcmcia_device *p_dev);
-static void fdomain_config(struct pcmcia_device *link);
+static int fdomain_config(struct pcmcia_device *link);
 
-static int fdomain_attach(struct pcmcia_device *link)
+static int fdomain_probe(struct pcmcia_device *link)
 {
-    scsi_info_t *info;
+	scsi_info_t *info;
 
-    DEBUG(0, "fdomain_attach()\n");
+	DEBUG(0, "fdomain_attach()\n");
 
-    /* Create new SCSI device */
-    info = kmalloc(sizeof(*info), GFP_KERNEL);
-    if (!info) return -ENOMEM;
-    memset(info, 0, sizeof(*info));
-    info->p_dev = link;
-    link->priv = info;
-    link->io.NumPorts1 = 0x10;
-    link->io.Attributes1 = IO_DATA_PATH_WIDTH_AUTO;
-    link->io.IOAddrLines = 10;
-    link->irq.Attributes = IRQ_TYPE_EXCLUSIVE;
-    link->irq.IRQInfo1 = IRQ_LEVEL_ID;
-    link->conf.Attributes = CONF_ENABLE_IRQ;
-    link->conf.IntType = INT_MEMORY_AND_IO;
-    link->conf.Present = PRESENT_OPTION;
+	/* Create new SCSI device */
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->p_dev = link;
+	link->priv = info;
+	link->io.NumPorts1 = 0x10;
+	link->io.Attributes1 = IO_DATA_PATH_WIDTH_AUTO;
+	link->io.IOAddrLines = 10;
+	link->irq.Attributes = IRQ_TYPE_EXCLUSIVE;
+	link->irq.IRQInfo1 = IRQ_LEVEL_ID;
+	link->conf.Attributes = CONF_ENABLE_IRQ;
+	link->conf.IntType = INT_MEMORY_AND_IO;
+	link->conf.Present = PRESENT_OPTION;
 
-    link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-    fdomain_config(link);
-
-    return 0;
+	link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
+	return fdomain_config(link);
 } /* fdomain_attach */
 
 /*====================================================================*/
@@ -127,7 +126,7 @@ static void fdomain_detach(struct pcmcia
 #define CS_CHECK(fn, ret) \
 do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
 
-static void fdomain_config(struct pcmcia_device *link)
+static int fdomain_config(struct pcmcia_device *link)
 {
     scsi_info_t *info = link->priv;
     tuple_t tuple;
@@ -150,7 +149,7 @@ static void fdomain_config(struct pcmcia
 
     /* Configure card */
     link->state |= DEV_CONFIG;
-    
+
     tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
     CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(link, &tuple));
     while (1) {
@@ -167,35 +166,35 @@ static void fdomain_config(struct pcmcia
 
     CS_CHECK(RequestIRQ, pcmcia_request_irq(link, &link->irq));
     CS_CHECK(RequestConfiguration, pcmcia_request_configuration(link, &link->conf));
-    
+
     /* A bad hack... */
     release_region(link->io.BasePort1, link->io.NumPorts1);
 
     /* Set configuration options for the fdomain driver */
     sprintf(str, "%d,%d", link->io.BasePort1, link->irq.AssignedIRQ);
     fdomain_setup(str);
-    
+
     host = __fdomain_16x0_detect(&fdomain_driver_template);
     if (!host) {
         printk(KERN_INFO "fdomain_cs: no SCSI devices found\n");
 	goto cs_failed;
     }
- 
-    scsi_add_host(host, NULL); /* XXX handle failure */
+
+    if (scsi_add_host(host, NULL))
+	    goto cs_failed;
     scsi_scan_host(host);
 
     sprintf(info->node.dev_name, "scsi%d", host->host_no);
     link->dev_node = &info->node;
     info->host = host;
-    
+
     link->state &= ~DEV_CONFIG_PENDING;
-    return;
-    
+    return 0;
+
 cs_failed:
     cs_error(link, last_fn, last_ret);
     fdomain_release(link);
-    return;
-    
+    return -ENODEV;
 } /* fdomain_config */
 
 /*====================================================================*/
@@ -234,7 +233,7 @@ static struct pcmcia_driver fdomain_cs_d
 	.drv		= {
 		.name	= "fdomain_cs",
 	},
-	.probe		= fdomain_attach,
+	.probe		= fdomain_probe,
 	.remove		= fdomain_detach,
 	.id_table       = fdomain_ids,
 	.resume		= fdomain_resume,
diff --git a/drivers/scsi/pcmcia/nsp_cs.c b/drivers/scsi/pcmcia/nsp_cs.c
index ce4d7d8..deec1c3 100644
--- a/drivers/scsi/pcmcia/nsp_cs.c
+++ b/drivers/scsi/pcmcia/nsp_cs.c
@@ -1593,10 +1593,11 @@ static int nsp_eh_host_reset(Scsi_Cmnd *
     configure the card at this point -- we wait until we receive a
     card insertion event.
 ======================================================================*/
-static int nsp_cs_attach(struct pcmcia_device *link)
+static int nsp_cs_probe(struct pcmcia_device *link)
 {
 	scsi_info_t  *info;
 	nsp_hw_data  *data = &nsp_data_base;
+	int ret;
 
 	nsp_dbg(NSP_DEBUG_INIT, "in");
 
@@ -1630,10 +1631,10 @@ static int nsp_cs_attach(struct pcmcia_d
 	link->conf.Present	 = PRESENT_OPTION;
 
 	link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-	nsp_cs_config(link);
+	ret = nsp_cs_config(link);
 
 	nsp_dbg(NSP_DEBUG_INIT, "link=0x%p", link);
-	return 0;
+	return ret;
 } /* nsp_cs_attach */
 
 
@@ -1665,8 +1666,9 @@ static void nsp_cs_detach(struct pcmcia_
 #define CS_CHECK(fn, ret) \
 do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
 /*====================================================================*/
-static void nsp_cs_config(struct pcmcia_device *link)
+static int nsp_cs_config(struct pcmcia_device *link)
 {
+	int		  ret;
 	scsi_info_t	 *info	 = link->priv;
 	tuple_t		  tuple;
 	cisparse_t	  parse;
@@ -1842,7 +1844,10 @@ static void nsp_cs_config(struct pcmcia_
 
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,74))
-	scsi_add_host (host, NULL);
+	ret = scsi_add_host (host, NULL);
+	if (ret)
+		goto cs_failed;
+
 	scsi_scan_host(host);
 
 	snprintf(info->node.dev_name, sizeof(info->node.dev_name), "scsi%d", host->host_no);
@@ -1917,14 +1922,14 @@ static void nsp_cs_config(struct pcmcia_
 	printk("\n");
 
 	link->state &= ~DEV_CONFIG_PENDING;
-	return;
+	return 0;
 
  cs_failed:
 	nsp_dbg(NSP_DEBUG_INIT, "config fail");
 	cs_error(link, last_fn, last_ret);
 	nsp_cs_release(link);
 
-	return;
+	return -ENODEV;
 } /* nsp_cs_config */
 #undef CS_CHECK
 
@@ -2033,7 +2038,7 @@ static struct pcmcia_driver nsp_driver =
 	.drv		= {
 		.name	= "nsp_cs",
 	},
-	.probe		= nsp_cs_attach,
+	.probe		= nsp_cs_probe,
 	.remove		= nsp_cs_detach,
 	.id_table	= nsp_cs_ids,
 	.suspend	= nsp_cs_suspend,
diff --git a/drivers/scsi/pcmcia/nsp_cs.h b/drivers/scsi/pcmcia/nsp_cs.h
index ce348b3..8908b8e 100644
--- a/drivers/scsi/pcmcia/nsp_cs.h
+++ b/drivers/scsi/pcmcia/nsp_cs.h
@@ -298,7 +298,7 @@ typedef struct _nsp_hw_data {
 /* Card service functions */
 static void        nsp_cs_detach (struct pcmcia_device *p_dev);
 static void        nsp_cs_release(struct pcmcia_device *link);
-static void        nsp_cs_config (struct pcmcia_device *link);
+static int        nsp_cs_config (struct pcmcia_device *link);
 
 /* Linux SCSI subsystem specific functions */
 static struct Scsi_Host *nsp_detect     (struct scsi_host_template *sht);
diff --git a/drivers/scsi/pcmcia/qlogic_stub.c b/drivers/scsi/pcmcia/qlogic_stub.c
index a2a1c4b..61c2eb0 100644
--- a/drivers/scsi/pcmcia/qlogic_stub.c
+++ b/drivers/scsi/pcmcia/qlogic_stub.c
@@ -99,7 +99,7 @@ typedef struct scsi_info_t {
 
 static void qlogic_release(struct pcmcia_device *link);
 static void qlogic_detach(struct pcmcia_device *p_dev);
-static void qlogic_config(struct pcmcia_device * link);
+static int qlogic_config(struct pcmcia_device * link);
 
 static struct Scsi_Host *qlogic_detect(struct scsi_host_template *host,
 				struct pcmcia_device *link, int qbase, int qlirq)
@@ -156,7 +156,7 @@ free_scsi_host:
 err:
 	return NULL;
 }
-static int qlogic_attach(struct pcmcia_device *link)
+static int qlogic_probe(struct pcmcia_device *link)
 {
 	scsi_info_t *info;
 
@@ -179,9 +179,7 @@ static int qlogic_attach(struct pcmcia_d
 	link->conf.Present = PRESENT_OPTION;
 
 	link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-	qlogic_config(link);
-
-	return 0;
+	return qlogic_config(link);
 }				/* qlogic_attach */
 
 /*====================================================================*/
@@ -202,7 +200,7 @@ static void qlogic_detach(struct pcmcia_
 #define CS_CHECK(fn, ret) \
 do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
 
-static void qlogic_config(struct pcmcia_device * link)
+static int qlogic_config(struct pcmcia_device * link)
 {
 	scsi_info_t *info = link->priv;
 	tuple_t tuple;
@@ -267,21 +265,20 @@ static void qlogic_config(struct pcmcia_
 	
 	if (!host) {
 		printk(KERN_INFO "%s: no SCSI devices found\n", qlogic_name);
-		goto out;
+		goto cs_failed;
 	}
 
 	sprintf(info->node.dev_name, "scsi%d", host->host_no);
 	link->dev_node = &info->node;
 	info->host = host;
 
-out:
 	link->state &= ~DEV_CONFIG_PENDING;
-	return;
+	return 0;
 
 cs_failed:
 	cs_error(link, last_fn, last_ret);
 	pcmcia_disable_device(link);
-	return;
+	return -ENODEV;
 
 }				/* qlogic_config */
 
@@ -350,7 +347,7 @@ static struct pcmcia_driver qlogic_cs_dr
 	.drv		= {
 	.name		= "qlogic_cs",
 	},
-	.probe		= qlogic_attach,
+	.probe		= qlogic_probe,
 	.remove		= qlogic_detach,
 	.id_table       = qlogic_ids,
 	.resume		= qlogic_resume,
diff --git a/drivers/scsi/pcmcia/sym53c500_cs.c b/drivers/scsi/pcmcia/sym53c500_cs.c
index 49a37de..b443220 100644
--- a/drivers/scsi/pcmcia/sym53c500_cs.c
+++ b/drivers/scsi/pcmcia/sym53c500_cs.c
@@ -707,7 +707,7 @@ static struct scsi_host_template sym53c5
 #define CS_CHECK(fn, ret) \
 do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
 
-static void
+static int
 SYM53C500_config(struct pcmcia_device *link)
 {
 	struct scsi_info_t *info = link->priv;
@@ -836,7 +836,8 @@ next_entry:
 
 	scsi_scan_host(host);
 
-	goto out;	/* SUCCESS */
+	link->state &= ~DEV_CONFIG_PENDING;
+	return 0;
 
 err_free_irq:
 	free_irq(irq_level, host);
@@ -845,15 +846,13 @@ err_free_scsi:
 err_release:
 	release_region(port_base, 0x10);
 	printk(KERN_INFO "sym53c500_cs: no SCSI devices found\n");
-
-out:
 	link->state &= ~DEV_CONFIG_PENDING;
-	return;
+	return -ENODEV;
 
 cs_failed:
 	cs_error(link, last_fn, last_ret);
 	SYM53C500_release(link);
-	return;
+	return -ENODEV;
 } /* SYM53C500_config */
 
 static int sym53c500_resume(struct pcmcia_device *link)
@@ -892,7 +891,7 @@ SYM53C500_detach(struct pcmcia_device *l
 } /* SYM53C500_detach */
 
 static int
-SYM53C500_attach(struct pcmcia_device *link)
+SYM53C500_probe(struct pcmcia_device *link)
 {
 	struct scsi_info_t *info;
 
@@ -915,9 +914,7 @@ SYM53C500_attach(struct pcmcia_device *l
 	link->conf.Present = PRESENT_OPTION;
 
 	link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-	SYM53C500_config(link);
-
-	return 0;
+	return SYM53C500_config(link);
 } /* SYM53C500_attach */
 
 MODULE_AUTHOR("Bob Tracy <rct@frus.com>");
@@ -937,7 +934,7 @@ static struct pcmcia_driver sym53c500_cs
 	.drv		= {
 		.name	= "sym53c500_cs",
 	},
-	.probe		= SYM53C500_attach,
+	.probe		= SYM53C500_probe,
 	.remove		= SYM53C500_detach,
 	.id_table       = sym53c500_ids,
 	.resume		= sym53c500_resume,
diff --git a/drivers/serial/serial_cs.c b/drivers/serial/serial_cs.c
index 1fe8caf..e787509 100644
--- a/drivers/serial/serial_cs.c
+++ b/drivers/serial/serial_cs.c
@@ -113,7 +113,7 @@ struct serial_cfg_mem {
 };
 
 
-static void serial_config(struct pcmcia_device * link);
+static int serial_config(struct pcmcia_device * link);
 
 
 /*======================================================================
@@ -211,9 +211,7 @@ static int serial_probe(struct pcmcia_de
 	link->conf.IntType = INT_MEMORY_AND_IO;
 
 	link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-	serial_config(link);
-
-	return 0;
+	return serial_config(link);
 }
 
 /*======================================================================
@@ -553,7 +551,7 @@ free_cfg_mem:
 
 ======================================================================*/
 
-void serial_config(struct pcmcia_device * link)
+static int serial_config(struct pcmcia_device * link)
 {
 	struct serial_info *info = link->priv;
 	struct serial_cfg_mem *cfg_mem;
@@ -652,7 +650,7 @@ void serial_config(struct pcmcia_device 
 	link->dev_node = &info->node[0];
 	link->state &= ~DEV_CONFIG_PENDING;
 	kfree(cfg_mem);
-	return;
+	return 0;
 
  cs_failed:
 	cs_error(link, last_fn, last_ret);
@@ -660,6 +658,7 @@ void serial_config(struct pcmcia_device 
 	serial_remove(link);
 	link->state &= ~DEV_CONFIG_PENDING;
 	kfree(cfg_mem);
+	return -ENODEV;
 }
 
 static struct pcmcia_device_id serial_ids[] = {
diff --git a/drivers/telephony/ixj_pcmcia.c b/drivers/telephony/ixj_pcmcia.c
index bad6818..a27df61 100644
--- a/drivers/telephony/ixj_pcmcia.c
+++ b/drivers/telephony/ixj_pcmcia.c
@@ -35,10 +35,10 @@ typedef struct ixj_info_t {
 } ixj_info_t;
 
 static void ixj_detach(struct pcmcia_device *p_dev);
-static void ixj_config(struct pcmcia_device * link);
+static int ixj_config(struct pcmcia_device * link);
 static void ixj_cs_release(struct pcmcia_device * link);
 
-static int ixj_attach(struct pcmcia_device *p_dev)
+static int ixj_probe(struct pcmcia_device *p_dev)
 {
 	DEBUG(0, "ixj_attach()\n");
 	/* Create new ixj device */
@@ -53,9 +53,7 @@ static int ixj_attach(struct pcmcia_devi
 	memset(p_dev->priv, 0, sizeof(struct ixj_info_t));
 
 	p_dev->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-	ixj_config(p_dev);
-
-	return 0;
+	return ixj_config(p_dev);
 }
 
 static void ixj_detach(struct pcmcia_device *link)
@@ -133,7 +131,7 @@ static void ixj_get_serial(struct pcmcia
 	return;
 }
 
-static void ixj_config(struct pcmcia_device * link)
+static int ixj_config(struct pcmcia_device * link)
 {
 	IXJ *j;
 	ixj_info_t *info;
@@ -198,10 +196,11 @@ static void ixj_config(struct pcmcia_dev
 	link->dev_node = &info->node;
 	ixj_get_serial(link, j);
 	link->state &= ~DEV_CONFIG_PENDING;
-	return;
+	return 0;
       cs_failed:
 	cs_error(link, last_fn, last_ret);
 	ixj_cs_release(link);
+	return -ENODEV;
 }
 
 static void ixj_cs_release(struct pcmcia_device *link)
@@ -223,7 +222,7 @@ static struct pcmcia_driver ixj_driver =
 	.drv		= {
 		.name	= "ixj_cs",
 	},
-	.probe		= ixj_attach,
+	.probe		= ixj_probe,
 	.remove		= ixj_detach,
 	.id_table	= ixj_ids,
 };
diff --git a/drivers/usb/host/sl811_cs.c b/drivers/usb/host/sl811_cs.c
index bfa8b21..e8b8e9a 100644
--- a/drivers/usb/host/sl811_cs.c
+++ b/drivers/usb/host/sl811_cs.c
@@ -158,7 +158,7 @@ static void sl811_cs_release(struct pcmc
 	platform_device_unregister(&platform_dev);
 }
 
-static void sl811_cs_config(struct pcmcia_device *link)
+static int sl811_cs_config(struct pcmcia_device *link)
 {
 	struct device		*parent = &handle_to_dev(link);
 	local_info_t		*dev = link->priv;
@@ -285,10 +285,12 @@ cs_failed:
 		cs_error(link, last_fn, last_ret);
 		sl811_cs_release(link);
 		link->state &= ~DEV_CONFIG_PENDING;
+		return  -ENODEV;
 	}
+	return 0;
 }
 
-static int sl811_cs_attach(struct pcmcia_device *link)
+static int sl811_cs_probe(struct pcmcia_device *link)
 {
 	local_info_t *local;
 
@@ -308,9 +310,7 @@ static int sl811_cs_attach(struct pcmcia
 	link->conf.IntType = INT_MEMORY_AND_IO;
 
 	link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-	sl811_cs_config(link);
-
-	return 0;
+	return sl811_cs_config(link);
 }
 
 static struct pcmcia_device_id sl811_ids[] = {
@@ -324,7 +324,7 @@ static struct pcmcia_driver sl811_cs_dri
 	.drv		= {
 		.name	= (char *)driver_name,
 	},
-	.probe		= sl811_cs_attach,
+	.probe		= sl811_cs_probe,
 	.remove		= sl811_cs_detach,
 	.id_table	= sl811_ids,
 };
diff --git a/sound/pcmcia/pdaudiocf/pdaudiocf.c b/sound/pcmcia/pdaudiocf/pdaudiocf.c
index 0431b8b..923b1d0 100644
--- a/sound/pcmcia/pdaudiocf/pdaudiocf.c
+++ b/sound/pcmcia/pdaudiocf/pdaudiocf.c
@@ -57,7 +57,7 @@ static struct snd_card *card_list[SNDRV_
 /*
  * prototypes
  */
-static void pdacf_config(struct pcmcia_device *link);
+static int pdacf_config(struct pcmcia_device *link);
 static void snd_pdacf_detach(struct pcmcia_device *p_dev);
 
 static void pdacf_release(struct pcmcia_device *link)
@@ -90,7 +90,7 @@ static int snd_pdacf_dev_free(struct snd
 /*
  * snd_pdacf_attach - attach callback for cs
  */
-static int snd_pdacf_attach(struct pcmcia_device *link)
+static int snd_pdacf_probe(struct pcmcia_device *link)
 {
 	int i;
 	struct snd_pdacf *pdacf;
@@ -149,9 +149,7 @@ static int snd_pdacf_attach(struct pcmci
 	link->conf.ConfigIndex = 1;
 	link->conf.Present = PRESENT_OPTION;
 
-	pdacf_config(link);
-
-	return 0;
+	return pdacf_config(link);
 }
 
 
@@ -218,7 +216,7 @@ static void snd_pdacf_detach(struct pcmc
 #define CS_CHECK(fn, ret) \
 do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
 
-static void pdacf_config(struct pcmcia_device *link)
+static int pdacf_config(struct pcmcia_device *link)
 {
 	struct snd_pdacf *pdacf = link->priv;
 	tuple_t tuple;
@@ -230,7 +228,7 @@ static void pdacf_config(struct pcmcia_d
 	parse = kmalloc(sizeof(*parse), GFP_KERNEL);
 	if (! parse) {
 		snd_printk(KERN_ERR "pdacf_config: cannot allocate\n");
-		return;
+		return -ENOMEM;
 	}
 	tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
 	tuple.Attributes = 0;
@@ -257,12 +255,13 @@ static void pdacf_config(struct pcmcia_d
 
 	link->dev_node = &pdacf->node;
 	link->state &= ~DEV_CONFIG_PENDING;
-	return;
+	return 0;
 
 cs_failed:
 	cs_error(link, last_fn, last_ret);
 failed:
 	pcmcia_disable_device(link);
+	return -ENODEV;
 }
 
 #ifdef CONFIG_PM
@@ -312,7 +311,7 @@ static struct pcmcia_driver pdacf_cs_dri
 	.drv		= {
 		.name	= "snd-pdaudiocf",
 	},
-	.probe		= snd_pdacf_attach,
+	.probe		= snd_pdacf_probe,
 	.remove		= snd_pdacf_detach,
 	.id_table	= snd_pdacf_ids,
 #ifdef CONFIG_PM
diff --git a/sound/pcmcia/vx/vxpocket.c b/sound/pcmcia/vx/vxpocket.c
index f6eed42..4004b35 100644
--- a/sound/pcmcia/vx/vxpocket.c
+++ b/sound/pcmcia/vx/vxpocket.c
@@ -208,7 +208,7 @@ static int snd_vxpocket_assign_resources
 #define CS_CHECK(fn, ret) \
 do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
 
-static void vxpocket_config(struct pcmcia_device *link)
+static int vxpocket_config(struct pcmcia_device *link)
 {
 	struct vx_core *chip = link->priv;
 	struct snd_vxpocket *vxp = (struct snd_vxpocket *)chip;
@@ -221,7 +221,7 @@ static void vxpocket_config(struct pcmci
 	parse = kmalloc(sizeof(*parse), GFP_KERNEL);
 	if (! parse) {
 		snd_printk(KERN_ERR "vx: cannot allocate\n");
-		return;
+		return -ENOMEM;
 	}
 	tuple.Attributes = 0;
 	tuple.TupleData = (cisdata_t *)buf;
@@ -265,13 +265,14 @@ static void vxpocket_config(struct pcmci
 	link->dev_node = &vxp->node;
 	link->state &= ~DEV_CONFIG_PENDING;
 	kfree(parse);
-	return;
+	return 9;
 
 cs_failed:
 	cs_error(link, last_fn, last_ret);
 failed:
 	pcmcia_disable_device(link);
 	kfree(parse);
+	return -ENODEV;
 }
 
 #ifdef CONFIG_PM
@@ -311,7 +312,7 @@ static int vxp_resume(struct pcmcia_devi
 
 /*
  */
-static int vxpocket_attach(struct pcmcia_device *p_dev)
+static int vxpocket_probe(struct pcmcia_device *p_dev)
 {
 	struct snd_card *card;
 	struct snd_vxpocket *vxp;
@@ -349,9 +350,7 @@ static int vxpocket_attach(struct pcmcia
 	vxp->p_dev = p_dev;
 	vxp->p_dev->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
 
-	vxpocket_config(p_dev);
-
-	return 0;
+	return vxpocket_config(p_dev);
 }
 
 static void vxpocket_detach(struct pcmcia_device *link)
@@ -387,7 +386,7 @@ static struct pcmcia_driver vxp_cs_drive
 	.drv		= {
 		.name	= "snd-vxpocket",
 	},
-	.probe		= vxpocket_attach,
+	.probe		= vxpocket_probe,
 	.remove		= vxpocket_detach,
 	.id_table	= vxp_ids,
 #ifdef CONFIG_PM
-- 
1.2.4

