Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWCaUf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWCaUf5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 15:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWCaUfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 15:35:50 -0500
Received: from isilmar.linta.de ([213.239.214.66]:33239 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932271AbWCaUfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 15:35:25 -0500
Date: Fri, 31 Mar 2006 22:19:30 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux@dominikbrodowski.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 19/33] pcmcia: default suspend and resume handling
Message-ID: <20060331201930.GH28037@dominikbrodowski.de>
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

In all but one case, the suspend and resume functions of PCMCIA drivers
contain mostly of calls to pcmcia_release_configuration() and
pcmcia_request_configuration(). Therefore, move this code out of the
drivers and into the core.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

---

 drivers/bluetooth/bluecard_cs.c         |   24 --------------------
 drivers/bluetooth/bt3c_cs.c             |   24 --------------------
 drivers/bluetooth/btuart_cs.c           |   25 --------------------
 drivers/bluetooth/dtl1_cs.c             |   24 --------------------
 drivers/char/pcmcia/cm4000_cs.c         |    9 -------
 drivers/char/pcmcia/cm4040_cs.c         |   24 --------------------
 drivers/char/pcmcia/synclink_cs.c       |    6 -----
 drivers/ide/legacy/ide-cs.c             |   23 -------------------
 drivers/isdn/hardware/avm/avm_cs.c      |   38 -------------------------------
 drivers/isdn/hisax/avma1_cs.c           |   26 +--------------------
 drivers/isdn/hisax/elsa_cs.c            |    6 -----
 drivers/isdn/hisax/sedlbauer_cs.c       |    6 -----
 drivers/isdn/hisax/teles_cs.c           |    6 -----
 drivers/net/pcmcia/3c574_cs.c           |   18 ++++-----------
 drivers/net/pcmcia/3c589_cs.c           |   18 ++++-----------
 drivers/net/pcmcia/axnet_cs.c           |   18 ++++-----------
 drivers/net/pcmcia/com20020_cs.c        |   23 ++++++-------------
 drivers/net/pcmcia/fmvj18x_cs.c         |   19 ++++------------
 drivers/net/pcmcia/ibmtr_cs.c           |   20 +++++-----------
 drivers/net/pcmcia/nmclan_cs.c          |   19 ++++------------
 drivers/net/pcmcia/pcnet_cs.c           |   20 +++++-----------
 drivers/net/pcmcia/smc91c92_cs.c        |    2 --
 drivers/net/pcmcia/xirc2ps_cs.c         |   16 +++----------
 drivers/net/wireless/airo_cs.c          |    9 ++-----
 drivers/net/wireless/atmel_cs.c         |    7 +-----
 drivers/net/wireless/hostap/hostap_cs.c |    6 -----
 drivers/net/wireless/netwave_cs.c       |   18 ++++-----------
 drivers/net/wireless/orinoco_cs.c       |    8 -------
 drivers/net/wireless/ray_cs.c           |   22 +++++-------------
 drivers/net/wireless/spectrum_cs.c      |    7 ------
 drivers/net/wireless/wavelan_cs.c       |   24 +++++---------------
 drivers/net/wireless/wl3501_cs.c        |   18 ++++-----------
 drivers/parport/parport_cs.c            |   23 -------------------
 drivers/pcmcia/ds.c                     |   30 +++++++++++++++++++++---
 drivers/scsi/pcmcia/aha152x_stub.c      |   18 +--------------
 drivers/scsi/pcmcia/fdomain_stub.c      |   17 +-------------
 drivers/scsi/pcmcia/nsp_cs.c            |   10 --------
 drivers/scsi/pcmcia/qlogic_stub.c       |   13 -----------
 drivers/scsi/pcmcia/sym53c500_cs.c      |   15 ------------
 drivers/serial/serial_cs.c              |    9 ++-----
 drivers/telephony/ixj_pcmcia.c          |   24 --------------------
 drivers/usb/host/sl811_cs.c             |   24 --------------------
 include/pcmcia/ds.h                     |    3 +-
 sound/pcmcia/pdaudiocf/pdaudiocf.c      |   10 --------
 sound/pcmcia/vx/vxpocket.c              |    9 -------
 45 files changed, 105 insertions(+), 633 deletions(-)

8661bb5b4af1849c1f5a4e80c4e275fd13c155d6
diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index 128e416..bb833b2 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -1005,28 +1005,6 @@ static void bluecard_release(dev_link_t 
 	pcmcia_disable_device(link->handle);
 }
 
-static int bluecard_suspend(struct pcmcia_device *dev)
-{
-	dev_link_t *link = dev_to_instance(dev);
-
-	link->state |= DEV_SUSPEND;
-	if (link->state & DEV_CONFIG)
-		pcmcia_release_configuration(link->handle);
-
-	return 0;
-}
-
-static int bluecard_resume(struct pcmcia_device *dev)
-{
-	dev_link_t *link = dev_to_instance(dev);
-
-	link->state &= ~DEV_SUSPEND;
-	if (DEV_OK(link))
-		pcmcia_request_configuration(link->handle, &link->conf);
-
-	return 0;
-}
-
 static struct pcmcia_device_id bluecard_ids[] = {
 	PCMCIA_DEVICE_PROD_ID12("BlueCard", "LSE041", 0xbaf16fbf, 0x657cc15e),
 	PCMCIA_DEVICE_PROD_ID12("BTCFCARD", "LSE139", 0xe3987764, 0x2524b59c),
@@ -1043,8 +1021,6 @@ static struct pcmcia_driver bluecard_dri
 	.probe		= bluecard_attach,
 	.remove		= bluecard_detach,
 	.id_table	= bluecard_ids,
-	.suspend	= bluecard_suspend,
-	.resume		= bluecard_resume,
 };
 
 static int __init init_bluecard_cs(void)
diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index ac1410c..7b0f4f0 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -842,28 +842,6 @@ static void bt3c_release(dev_link_t *lin
 	pcmcia_disable_device(link->handle);
 }
 
-static int bt3c_suspend(struct pcmcia_device *dev)
-{
-	dev_link_t *link = dev_to_instance(dev);
-
-	link->state |= DEV_SUSPEND;
-	if (link->state & DEV_CONFIG)
-		pcmcia_release_configuration(link->handle);
-
-	return 0;
-}
-
-static int bt3c_resume(struct pcmcia_device *dev)
-{
-	dev_link_t *link = dev_to_instance(dev);
-
-	link->state &= ~DEV_SUSPEND;
-	if (DEV_OK(link))
-		pcmcia_request_configuration(link->handle, &link->conf);
-
-	return 0;
-}
-
 
 static struct pcmcia_device_id bt3c_ids[] = {
 	PCMCIA_DEVICE_PROD_ID13("3COM", "Bluetooth PC Card", 0xefce0a31, 0xd4ce9b02),
@@ -879,8 +857,6 @@ static struct pcmcia_driver bt3c_driver 
 	.probe		= bt3c_attach,
 	.remove		= bt3c_detach,
 	.id_table	= bt3c_ids,
-	.suspend	= bt3c_suspend,
-	.resume		= bt3c_resume,
 };
 
 static int __init init_bt3c_cs(void)
diff --git a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
index 8cd54bb..9a507bd 100644
--- a/drivers/bluetooth/btuart_cs.c
+++ b/drivers/bluetooth/btuart_cs.c
@@ -771,29 +771,6 @@ static void btuart_release(dev_link_t *l
 	pcmcia_disable_device(link->handle);
 }
 
-static int btuart_suspend(struct pcmcia_device *dev)
-{
-	dev_link_t *link = dev_to_instance(dev);
-
-	link->state |= DEV_SUSPEND;
-	if (link->state & DEV_CONFIG)
-		pcmcia_release_configuration(link->handle);
-
-	return 0;
-}
-
-static int btuart_resume(struct pcmcia_device *dev)
-{
-	dev_link_t *link = dev_to_instance(dev);
-
-	link->state &= ~DEV_SUSPEND;
-	if (DEV_OK(link))
-		pcmcia_request_configuration(link->handle, &link->conf);
-
-	return 0;
-}
-
-
 static struct pcmcia_device_id btuart_ids[] = {
 	/* don't use this driver. Use serial_cs + hci_uart instead */
 	PCMCIA_DEVICE_NULL
@@ -808,8 +785,6 @@ static struct pcmcia_driver btuart_drive
 	.probe		= btuart_attach,
 	.remove		= btuart_detach,
 	.id_table	= btuart_ids,
-	.suspend	= btuart_suspend,
-	.resume		= btuart_resume,
 };
 
 static int __init init_btuart_cs(void)
diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index efbc8a5..39dbe73 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -723,28 +723,6 @@ static void dtl1_release(dev_link_t *lin
 	pcmcia_disable_device(link->handle);
 }
 
-static int dtl1_suspend(struct pcmcia_device *dev)
-{
-	dev_link_t *link = dev_to_instance(dev);
-
-	link->state |= DEV_SUSPEND;
-	if (link->state & DEV_CONFIG)
-		pcmcia_release_configuration(link->handle);
-
-	return 0;
-}
-
-static int dtl1_resume(struct pcmcia_device *dev)
-{
-	dev_link_t *link = dev_to_instance(dev);
-
-	link->state &= ~DEV_SUSPEND;
-	if (DEV_OK(link))
-		pcmcia_request_configuration(link->handle, &link->conf);
-
-	return 0;
-}
-
 
 static struct pcmcia_device_id dtl1_ids[] = {
 	PCMCIA_DEVICE_PROD_ID12("Nokia Mobile Phones", "DTL-1", 0xe1bfdd64, 0xe168480d),
@@ -762,8 +740,6 @@ static struct pcmcia_driver dtl1_driver 
 	.probe		= dtl1_attach,
 	.remove		= dtl1_detach,
 	.id_table	= dtl1_ids,
-	.suspend	= dtl1_suspend,
-	.resume		= dtl1_resume,
 };
 
 static int __init init_dtl1_cs(void)
diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index 3ddd3da..870decb 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -1870,10 +1870,6 @@ static int cm4000_suspend(struct pcmcia_
 	struct cm4000_dev *dev;
 
 	dev = link->priv;
-
-	link->state |= DEV_SUSPEND;
-	if (link->state & DEV_CONFIG)
-		pcmcia_release_configuration(link->handle);
 	stop_monitor(dev);
 
 	return 0;
@@ -1885,11 +1881,6 @@ static int cm4000_resume(struct pcmcia_d
 	struct cm4000_dev *dev;
 
 	dev = link->priv;
-
-	link->state &= ~DEV_SUSPEND;
-	if (link->state & DEV_CONFIG)
-		pcmcia_request_configuration(link->handle, &link->conf);
-
 	if (link->open)
 		start_monitor(dev);
 
diff --git a/drivers/char/pcmcia/cm4040_cs.c b/drivers/char/pcmcia/cm4040_cs.c
index 1c355bd..47f10c8 100644
--- a/drivers/char/pcmcia/cm4040_cs.c
+++ b/drivers/char/pcmcia/cm4040_cs.c
@@ -629,28 +629,6 @@ cs_release:
 	link->state &= ~DEV_CONFIG_PENDING;
 }
 
-static int reader_suspend(struct pcmcia_device *p_dev)
-{
-	dev_link_t *link = dev_to_instance(p_dev);
-
-	link->state |= DEV_SUSPEND;
-	if (link->state & DEV_CONFIG)
-		pcmcia_release_configuration(link->handle);
-
-	return 0;
-}
-
-static int reader_resume(struct pcmcia_device *p_dev)
-{
-	dev_link_t *link = dev_to_instance(p_dev);
-
-	link->state &= ~DEV_SUSPEND;
-	if (link->state & DEV_CONFIG)
-		pcmcia_request_configuration(link->handle, &link->conf);
-
-	return 0;
-}
-
 static void reader_release(dev_link_t *link)
 {
 	cm4040_reader_release(link->priv);
@@ -754,8 +732,6 @@ static struct pcmcia_driver reader_drive
 	},
 	.probe		= reader_attach,
 	.remove		= reader_detach,
-	.suspend	= reader_suspend,
-	.resume		= reader_resume,
 	.id_table	= cm4040_ids,
 };
 
diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 371d10b..d3ea53a 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -733,10 +733,7 @@ static int mgslpc_suspend(struct pcmcia_
 	dev_link_t *link = dev_to_instance(dev);
 	MGSLPC_INFO *info = link->priv;
 
-	link->state |= DEV_SUSPEND;
 	info->stop = 1;
-	if (link->state & DEV_CONFIG)
-		pcmcia_release_configuration(link->handle);
 
 	return 0;
 }
@@ -746,9 +743,6 @@ static int mgslpc_resume(struct pcmcia_d
 	dev_link_t *link = dev_to_instance(dev);
 	MGSLPC_INFO *info = link->priv;
 
-	link->state &= ~DEV_SUSPEND;
-	if (link->state & DEV_CONFIG)
-		pcmcia_request_configuration(link->handle, &link->conf);
 	info->stop = 0;
 
 	return 0;
diff --git a/drivers/ide/legacy/ide-cs.c b/drivers/ide/legacy/ide-cs.c
index 024aad6..7ad8a95 100644
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
@@ -373,27 +373,6 @@ void ide_release(dev_link_t *link)
     pcmcia_disable_device(link->handle);
 } /* ide_release */
 
-static int ide_suspend(struct pcmcia_device *dev)
-{
-	dev_link_t *link = dev_to_instance(dev);
-
-	link->state |= DEV_SUSPEND;
-	if (link->state & DEV_CONFIG)
-		pcmcia_release_configuration(link->handle);
-
-	return 0;
-}
-
-static int ide_resume(struct pcmcia_device *dev)
-{
-	dev_link_t *link = dev_to_instance(dev);
-
-	link->state &= ~DEV_SUSPEND;
-	if (DEV_OK(link))
-		pcmcia_request_configuration(link->handle, &link->conf);
-
-	return 0;
-}
 
 /*======================================================================
 
@@ -456,8 +435,6 @@ static struct pcmcia_driver ide_cs_drive
 	.probe		= ide_attach,
 	.remove		= ide_detach,
 	.id_table       = ide_ids,
-	.suspend	= ide_suspend,
-	.resume		= ide_resume,
 };
 
 static int __init init_ide_cs(void)
diff --git a/drivers/isdn/hardware/avm/avm_cs.c b/drivers/isdn/hardware/avm/avm_cs.c
index 5f70661..ae70247 100644
--- a/drivers/isdn/hardware/avm/avm_cs.c
+++ b/drivers/isdn/hardware/avm/avm_cs.c
@@ -371,42 +371,6 @@ static void avmcs_release(dev_link_t *li
 	pcmcia_disable_device(link->handle);
 } /* avmcs_release */
 
-static int avmcs_suspend(struct pcmcia_device *dev)
-{
-	dev_link_t *link = dev_to_instance(dev);
-
-	link->state |= DEV_SUSPEND;
-	if (link->state & DEV_CONFIG)
-		pcmcia_release_configuration(link->handle);
-
-	return 0;
-}
-
-static int avmcs_resume(struct pcmcia_device *dev)
-{
-	dev_link_t *link = dev_to_instance(dev);
-
-	link->state &= ~DEV_SUSPEND;
-	if (link->state & DEV_CONFIG)
-		pcmcia_request_configuration(link->handle, &link->conf);
-
-	return 0;
-}
-
-/*======================================================================
-
-    The card status event handler.  Mostly, this schedules other
-    stuff to run after an event is received.  A CARD_REMOVAL event
-    also sets some flags to discourage the net drivers from trying
-    to talk to the card any more.
-
-    When a CARD_REMOVAL event is received, we immediately set a flag
-    to block future accesses to this device.  All the functions that
-    actually access the device should check this flag to make sure
-    the card is still present.
-    
-======================================================================*/
-
 
 static struct pcmcia_device_id avmcs_ids[] = {
 	PCMCIA_DEVICE_PROD_ID12("AVM", "ISDN-Controller B1", 0x95d42008, 0x845dc335),
@@ -424,8 +388,6 @@ static struct pcmcia_driver avmcs_driver
 	.probe = avmcs_attach,
 	.remove	= avmcs_detach,
 	.id_table = avmcs_ids,
-	.suspend= avmcs_suspend,
-	.resume = avmcs_resume,
 };
 
 static int __init avmcs_init(void)
diff --git a/drivers/isdn/hisax/avma1_cs.c b/drivers/isdn/hisax/avma1_cs.c
index 845fa14..5e847cf 100644
--- a/drivers/isdn/hisax/avma1_cs.c
+++ b/drivers/isdn/hisax/avma1_cs.c
@@ -383,28 +383,6 @@ static void avma1cs_release(dev_link_t *
 	pcmcia_disable_device(link->handle);
 } /* avma1cs_release */
 
-static int avma1cs_suspend(struct pcmcia_device *dev)
-{
-	dev_link_t *link = dev_to_instance(dev);
-
-	link->state |= DEV_SUSPEND;
-	if (link->state & DEV_CONFIG)
-		pcmcia_release_configuration(link->handle);
-
-	return 0;
-}
-
-static int avma1cs_resume(struct pcmcia_device *dev)
-{
-	dev_link_t *link = dev_to_instance(dev);
-
-	link->state &= ~DEV_SUSPEND;
-	if (link->state & DEV_CONFIG)
-		pcmcia_request_configuration(link->handle, &link->conf);
-
-	return 0;
-}
-
 
 static struct pcmcia_device_id avma1cs_ids[] = {
 	PCMCIA_DEVICE_PROD_ID12("AVM", "ISDN A", 0x95d42008, 0xadc9d4bb),
@@ -421,10 +399,8 @@ static struct pcmcia_driver avma1cs_driv
 	.probe		= avma1cs_attach,
 	.remove		= avma1cs_detach,
 	.id_table	= avma1cs_ids,
-	.suspend	= avma1cs_suspend,
-	.resume		= avma1cs_resume,
 };
- 
+
 /*====================================================================*/
 
 static int __init init_avma1_cs(void)
diff --git a/drivers/isdn/hisax/elsa_cs.c b/drivers/isdn/hisax/elsa_cs.c
index 60c75c7..b76b303 100644
--- a/drivers/isdn/hisax/elsa_cs.c
+++ b/drivers/isdn/hisax/elsa_cs.c
@@ -389,10 +389,7 @@ static int elsa_suspend(struct pcmcia_de
 	dev_link_t *link = dev_to_instance(p_dev);
 	local_info_t *dev = link->priv;
 
-	link->state |= DEV_SUSPEND;
         dev->busy = 1;
-	if (link->state & DEV_CONFIG)
-		pcmcia_release_configuration(link->handle);
 
 	return 0;
 }
@@ -402,9 +399,6 @@ static int elsa_resume(struct pcmcia_dev
 	dev_link_t *link = dev_to_instance(p_dev);
 	local_info_t *dev = link->priv;
 
-	link->state &= ~DEV_SUSPEND;
-	if (link->state & DEV_CONFIG)
-		pcmcia_request_configuration(link->handle, &link->conf);
         dev->busy = 0;
 
 	return 0;
diff --git a/drivers/isdn/hisax/sedlbauer_cs.c b/drivers/isdn/hisax/sedlbauer_cs.c
index fd0f127..5745eb1 100644
--- a/drivers/isdn/hisax/sedlbauer_cs.c
+++ b/drivers/isdn/hisax/sedlbauer_cs.c
@@ -472,10 +472,7 @@ static int sedlbauer_suspend(struct pcmc
 	dev_link_t *link = dev_to_instance(p_dev);
 	local_info_t *dev = link->priv;
 
-	link->state |= DEV_SUSPEND;
 	dev->stop = 1;
-	if (link->state & DEV_CONFIG)
-		pcmcia_release_configuration(link->handle);
 
 	return 0;
 }
@@ -485,9 +482,6 @@ static int sedlbauer_resume(struct pcmci
 	dev_link_t *link = dev_to_instance(p_dev);
 	local_info_t *dev = link->priv;
 
-	link->state &= ~DEV_SUSPEND;
-	if (link->state & DEV_CONFIG)
-		pcmcia_request_configuration(link->handle, &link->conf);
 	dev->stop = 0;
 
 	return 0;
diff --git a/drivers/isdn/hisax/teles_cs.c b/drivers/isdn/hisax/teles_cs.c
index 7945fd6..929507e 100644
--- a/drivers/isdn/hisax/teles_cs.c
+++ b/drivers/isdn/hisax/teles_cs.c
@@ -380,10 +380,7 @@ static int teles_suspend(struct pcmcia_d
 	dev_link_t *link = dev_to_instance(p_dev);
 	local_info_t *dev = link->priv;
 
-	link->state |= DEV_SUSPEND;
         dev->busy = 1;
-	if (link->state & DEV_CONFIG)
-		pcmcia_release_configuration(link->handle);
 
 	return 0;
 }
@@ -393,9 +390,6 @@ static int teles_resume(struct pcmcia_de
 	dev_link_t *link = dev_to_instance(p_dev);
 	local_info_t *dev = link->priv;
 
-	link->state &= ~DEV_SUSPEND;
-	if (link->state & DEV_CONFIG)
-		pcmcia_request_configuration(link->handle, &link->conf);
         dev->busy = 0;
 
 	return 0;
diff --git a/drivers/net/pcmcia/3c574_cs.c b/drivers/net/pcmcia/3c574_cs.c
index 1799660..8dfa30b 100644
--- a/drivers/net/pcmcia/3c574_cs.c
+++ b/drivers/net/pcmcia/3c574_cs.c
@@ -519,12 +519,8 @@ static int tc574_suspend(struct pcmcia_d
 	dev_link_t *link = dev_to_instance(p_dev);
 	struct net_device *dev = link->priv;
 
-	link->state |= DEV_SUSPEND;
-	if (link->state & DEV_CONFIG) {
-		if (link->open)
-			netif_device_detach(dev);
-		pcmcia_release_configuration(link->handle);
-	}
+	if ((link->state & DEV_CONFIG) && (link->open))
+		netif_device_detach(dev);
 
 	return 0;
 }
@@ -534,13 +530,9 @@ static int tc574_resume(struct pcmcia_de
 	dev_link_t *link = dev_to_instance(p_dev);
 	struct net_device *dev = link->priv;
 
-	link->state &= ~DEV_SUSPEND;
-	if (link->state & DEV_CONFIG) {
-		pcmcia_request_configuration(link->handle, &link->conf);
-		if (link->open) {
-			tc574_reset(dev);
-			netif_device_attach(dev);
-		}
+	if ((link->state & DEV_CONFIG) && (link->open)) {
+		tc574_reset(dev);
+		netif_device_attach(dev);
 	}
 
 	return 0;
diff --git a/drivers/net/pcmcia/3c589_cs.c b/drivers/net/pcmcia/3c589_cs.c
index e361538..b15066b 100644
--- a/drivers/net/pcmcia/3c589_cs.c
+++ b/drivers/net/pcmcia/3c589_cs.c
@@ -394,12 +394,8 @@ static int tc589_suspend(struct pcmcia_d
 	dev_link_t *link = dev_to_instance(p_dev);
 	struct net_device *dev = link->priv;
 
-	link->state |= DEV_SUSPEND;
-	if (link->state & DEV_CONFIG) {
-		if (link->open)
-			netif_device_detach(dev);
-		pcmcia_release_configuration(link->handle);
-	}
+	if ((link->state & DEV_CONFIG) && (link->open))
+		netif_device_detach(dev);
 
 	return 0;
 }
@@ -409,13 +405,9 @@ static int tc589_resume(struct pcmcia_de
 	dev_link_t *link = dev_to_instance(p_dev);
 	struct net_device *dev = link->priv;
 
-	link->state &= ~DEV_SUSPEND;
-	if (link->state & DEV_CONFIG) {
-		pcmcia_request_configuration(link->handle, &link->conf);
-		if (link->open) {
-			tc589_reset(dev);
-			netif_device_attach(dev);
-		}
+	if ((link->state & DEV_CONFIG) && (link->open)) {
+		tc589_reset(dev);
+		netif_device_attach(dev);
 	}
 
 	return 0;
diff --git a/drivers/net/pcmcia/axnet_cs.c b/drivers/net/pcmcia/axnet_cs.c
index 9b9c0f1..c34547c 100644
--- a/drivers/net/pcmcia/axnet_cs.c
+++ b/drivers/net/pcmcia/axnet_cs.c
@@ -464,12 +464,8 @@ static int axnet_suspend(struct pcmcia_d
 	dev_link_t *link = dev_to_instance(p_dev);
 	struct net_device *dev = link->priv;
 
-	link->state |= DEV_SUSPEND;
-	if (link->state & DEV_CONFIG) {
-		if (link->open)
+	if ((link->state & DEV_CONFIG) && (link->open))
 			netif_device_detach(dev);
-		pcmcia_release_configuration(link->handle);
-	}
 
 	return 0;
 }
@@ -479,14 +475,10 @@ static int axnet_resume(struct pcmcia_de
 	dev_link_t *link = dev_to_instance(p_dev);
 	struct net_device *dev = link->priv;
 
-	link->state &= ~DEV_SUSPEND;
-	if (link->state & DEV_CONFIG) {
-		pcmcia_request_configuration(link->handle, &link->conf);
-		if (link->open) {
-			axnet_reset_8390(dev);
-			AX88190_init(dev, 1);
-			netif_device_attach(dev);
-		}
+	if ((link->state & DEV_CONFIG) && (link->open)) {
+		axnet_reset_8390(dev);
+		AX88190_init(dev, 1);
+		netif_device_attach(dev);
 	}
 
 	return 0;
diff --git a/drivers/net/pcmcia/com20020_cs.c b/drivers/net/pcmcia/com20020_cs.c
index a0ec5e7..0748c3d 100644
--- a/drivers/net/pcmcia/com20020_cs.c
+++ b/drivers/net/pcmcia/com20020_cs.c
@@ -387,13 +387,8 @@ static int com20020_suspend(struct pcmci
 	com20020_dev_t *info = link->priv;
 	struct net_device *dev = info->dev;
 
-	link->state |= DEV_SUSPEND;
-        if (link->state & DEV_CONFIG) {
-		if (link->open) {
-			netif_device_detach(dev);
-		}
-		pcmcia_release_configuration(link->handle);
-        }
+	if ((link->state & DEV_CONFIG) && (link->open))
+		netif_device_detach(dev);
 
 	return 0;
 }
@@ -404,15 +399,11 @@ static int com20020_resume(struct pcmcia
 	com20020_dev_t *info = link->priv;
 	struct net_device *dev = info->dev;
 
-	link->state &= ~DEV_SUSPEND;
-        if (link->state & DEV_CONFIG) {
-		pcmcia_request_configuration(link->handle, &link->conf);
-		if (link->open) {
-			int ioaddr = dev->base_addr;
-			struct arcnet_local *lp = dev->priv;
-			ARCRESET;
-		}
-        }
+	if ((link->state & DEV_CONFIG) && (link->open)) {
+		int ioaddr = dev->base_addr;
+		struct arcnet_local *lp = dev->priv;
+		ARCRESET;
+	}
 
 	return 0;
 }
diff --git a/drivers/net/pcmcia/fmvj18x_cs.c b/drivers/net/pcmcia/fmvj18x_cs.c
index 6b435e9..62efbc7 100644
--- a/drivers/net/pcmcia/fmvj18x_cs.c
+++ b/drivers/net/pcmcia/fmvj18x_cs.c
@@ -683,13 +683,8 @@ static int fmvj18x_suspend(struct pcmcia
 	dev_link_t *link = dev_to_instance(p_dev);
 	struct net_device *dev = link->priv;
 
-	link->state |= DEV_SUSPEND;
-	if (link->state & DEV_CONFIG) {
-		if (link->open)
-			netif_device_detach(dev);
-		pcmcia_release_configuration(link->handle);
-	}
-
+	if ((link->state & DEV_CONFIG) && (link->open))
+		netif_device_detach(dev);
 
 	return 0;
 }
@@ -699,13 +694,9 @@ static int fmvj18x_resume(struct pcmcia_
 	dev_link_t *link = dev_to_instance(p_dev);
 	struct net_device *dev = link->priv;
 
-	link->state &= ~DEV_SUSPEND;
-	if (link->state & DEV_CONFIG) {
-		pcmcia_request_configuration(link->handle, &link->conf);
-		if (link->open) {
-			fjn_reset(dev);
-			netif_device_attach(dev);
-		}
+	if ((link->state & DEV_CONFIG) && (link->open)) {
+		fjn_reset(dev);
+		netif_device_attach(dev);
 	}
 
 	return 0;
diff --git a/drivers/net/pcmcia/ibmtr_cs.c b/drivers/net/pcmcia/ibmtr_cs.c
index 1948a0b..6d7f8f5 100644
--- a/drivers/net/pcmcia/ibmtr_cs.c
+++ b/drivers/net/pcmcia/ibmtr_cs.c
@@ -367,12 +367,8 @@ static int ibmtr_suspend(struct pcmcia_d
 	ibmtr_dev_t *info = link->priv;
 	struct net_device *dev = info->dev;
 
-	link->state |= DEV_SUSPEND;
-        if (link->state & DEV_CONFIG) {
-		if (link->open)
-			netif_device_detach(dev);
-		pcmcia_release_configuration(link->handle);
-        }
+	if ((link->state & DEV_CONFIG) && (link->open))
+		netif_device_detach(dev);
 
 	return 0;
 }
@@ -383,14 +379,10 @@ static int ibmtr_resume(struct pcmcia_de
 	ibmtr_dev_t *info = link->priv;
 	struct net_device *dev = info->dev;
 
-	link->state &= ~DEV_SUSPEND;
-        if (link->state & DEV_CONFIG) {
-		pcmcia_request_configuration(link->handle, &link->conf);
-		if (link->open) {
-			ibmtr_probe(dev);	/* really? */
-			netif_device_attach(dev);
-		}
-        }
+	if ((link->state & DEV_CONFIG) && (link->open)) {
+		ibmtr_probe(dev);	/* really? */
+		netif_device_attach(dev);
+	}
 
 	return 0;
 }
diff --git a/drivers/net/pcmcia/nmclan_cs.c b/drivers/net/pcmcia/nmclan_cs.c
index 76ef453..cf2a50c 100644
--- a/drivers/net/pcmcia/nmclan_cs.c
+++ b/drivers/net/pcmcia/nmclan_cs.c
@@ -774,13 +774,8 @@ static int nmclan_suspend(struct pcmcia_
 	dev_link_t *link = dev_to_instance(p_dev);
 	struct net_device *dev = link->priv;
 
-	link->state |= DEV_SUSPEND;
-	if (link->state & DEV_CONFIG) {
-		if (link->open)
-			netif_device_detach(dev);
-		pcmcia_release_configuration(link->handle);
-	}
-
+	if ((link->state & DEV_CONFIG) && (link->open))
+		netif_device_detach(dev);
 
 	return 0;
 }
@@ -790,13 +785,9 @@ static int nmclan_resume(struct pcmcia_d
 	dev_link_t *link = dev_to_instance(p_dev);
 	struct net_device *dev = link->priv;
 
-	link->state &= ~DEV_SUSPEND;
-	if (link->state & DEV_CONFIG) {
-		pcmcia_request_configuration(link->handle, &link->conf);
-		if (link->open) {
-			nmclan_reset(dev);
-			netif_device_attach(dev);
-		}
+	if ((link->state & DEV_CONFIG) && (link->open)) {
+		nmclan_reset(dev);
+		netif_device_attach(dev);
 	}
 
 	return 0;
diff --git a/drivers/net/pcmcia/pcnet_cs.c b/drivers/net/pcmcia/pcnet_cs.c
index 52f44bd..3a2b731 100644
--- a/drivers/net/pcmcia/pcnet_cs.c
+++ b/drivers/net/pcmcia/pcnet_cs.c
@@ -756,12 +756,8 @@ static int pcnet_suspend(struct pcmcia_d
 	dev_link_t *link = dev_to_instance(p_dev);
 	struct net_device *dev = link->priv;
 
-	link->state |= DEV_SUSPEND;
-	if (link->state & DEV_CONFIG) {
-		if (link->open)
-			netif_device_detach(dev);
-		pcmcia_release_configuration(link->handle);
-	}
+	if ((link->state & DEV_CONFIG) && (link->open))
+		netif_device_detach(dev);
 
 	return 0;
 }
@@ -771,14 +767,10 @@ static int pcnet_resume(struct pcmcia_de
 	dev_link_t *link = dev_to_instance(p_dev);
 	struct net_device *dev = link->priv;
 
-	link->state &= ~DEV_SUSPEND;
-	if (link->state & DEV_CONFIG) {
-		pcmcia_request_configuration(link->handle, &link->conf);
-		if (link->open) {
-			pcnet_reset_8390(dev);
-			NS8390_init(dev, 1);
-			netif_device_attach(dev);
-		}
+	if ((link->state & DEV_CONFIG) && (link->open)) {
+		pcnet_reset_8390(dev);
+		NS8390_init(dev, 1);
+		netif_device_attach(dev);
 	}
 
 	return 0;
diff --git a/drivers/net/pcmcia/smc91c92_cs.c b/drivers/net/pcmcia/smc91c92_cs.c
index 03b1d8f..84e18bb 100644
--- a/drivers/net/pcmcia/smc91c92_cs.c
+++ b/drivers/net/pcmcia/smc91c92_cs.c
@@ -874,7 +874,6 @@ static int smc91c92_suspend(struct pcmci
 	dev_link_t *link = dev_to_instance(p_dev);
 	struct net_device *dev = link->priv;
 
-	link->state |= DEV_SUSPEND;
 	if (link->state & DEV_CONFIG) {
 		if (link->open)
 			netif_device_detach(dev);
@@ -891,7 +890,6 @@ static int smc91c92_resume(struct pcmcia
 	struct smc_private *smc = netdev_priv(dev);
 	int i;
 
-	link->state &= ~DEV_SUSPEND;
 	if (link->state & DEV_CONFIG) {
 		if ((smc->manfid == MANFID_MEGAHERTZ) &&
 		    (smc->cardid == PRODID_MEGAHERTZ_EM3288))
diff --git a/drivers/net/pcmcia/xirc2ps_cs.c b/drivers/net/pcmcia/xirc2ps_cs.c
index 2b57a87..19347bc 100644
--- a/drivers/net/pcmcia/xirc2ps_cs.c
+++ b/drivers/net/pcmcia/xirc2ps_cs.c
@@ -1109,13 +1109,9 @@ static int xirc2ps_suspend(struct pcmcia
 	dev_link_t *link = dev_to_instance(p_dev);
 	struct net_device *dev = link->priv;
 
-	link->state |= DEV_SUSPEND;
-	if (link->state & DEV_CONFIG) {
-		if (link->open) {
+	if ((link->state & DEV_CONFIG) && (link->open)) {
 			netif_device_detach(dev);
 			do_powerdown(dev);
-		}
-		pcmcia_release_configuration(link->handle);
 	}
 
 	return 0;
@@ -1126,13 +1122,9 @@ static int xirc2ps_resume(struct pcmcia_
 	dev_link_t *link = dev_to_instance(p_dev);
 	struct net_device *dev = link->priv;
 
-	link->state &= ~DEV_SUSPEND;
-	if (link->state & DEV_CONFIG) {
-		pcmcia_request_configuration(link->handle, &link->conf);
-		if (link->open) {
-			do_reset(dev,1);
-			netif_device_attach(dev);
-		}
+	if ((link->state & DEV_CONFIG) && (link->open)) {
+		do_reset(dev,1);
+		netif_device_attach(dev);
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/airo_cs.c b/drivers/net/wireless/airo_cs.c
index 489ef7f..adb90b6 100644
--- a/drivers/net/wireless/airo_cs.c
+++ b/drivers/net/wireless/airo_cs.c
@@ -437,11 +437,8 @@ static int airo_suspend(struct pcmcia_de
 	dev_link_t *link = dev_to_instance(p_dev);
 	local_info_t *local = link->priv;
 
-	link->state |= DEV_SUSPEND;
-	if (link->state & DEV_CONFIG) {
+	if (link->state & DEV_CONFIG)
 		netif_device_detach(local->eth_dev);
-		pcmcia_release_configuration(link->handle);
-	}
 
 	return 0;
 }
@@ -451,9 +448,7 @@ static int airo_resume(struct pcmcia_dev
 	dev_link_t *link = dev_to_instance(p_dev);
 	local_info_t *local = link->priv;
 
-	link->state &= ~DEV_SUSPEND;
-	if (link->state & DEV_CONFIG) {
-		pcmcia_request_configuration(link->handle, &link->conf);
+	if ((link->state & DEV_CONFIG) && (link->open)) {
 		reset_airo_card(local->eth_dev);
 		netif_device_attach(local->eth_dev);
 	}
diff --git a/drivers/net/wireless/atmel_cs.c b/drivers/net/wireless/atmel_cs.c
index 1da8e61..89dbc78 100644
--- a/drivers/net/wireless/atmel_cs.c
+++ b/drivers/net/wireless/atmel_cs.c
@@ -433,11 +433,8 @@ static int atmel_suspend(struct pcmcia_d
 	dev_link_t *link = dev_to_instance(dev);
 	local_info_t *local = link->priv;
 
-	link->state |= DEV_SUSPEND;
-	if (link->state & DEV_CONFIG) {
+	if (link->state & DEV_CONFIG)
 		netif_device_detach(local->eth_dev);
-		pcmcia_release_configuration(link->handle);
-	}
 
 	return 0;
 }
@@ -447,9 +444,7 @@ static int atmel_resume(struct pcmcia_de
 	dev_link_t *link = dev_to_instance(dev);
 	local_info_t *local = link->priv;
 
-	link->state &= ~DEV_SUSPEND;
 	if (link->state & DEV_CONFIG) {
-		pcmcia_request_configuration(link->handle, &link->conf);
 		atmel_open(local->eth_dev);
 		netif_device_attach(local->eth_dev);
 	}
diff --git a/drivers/net/wireless/hostap/hostap_cs.c b/drivers/net/wireless/hostap/hostap_cs.c
index 7a1023f..0fb6251 100644
--- a/drivers/net/wireless/hostap/hostap_cs.c
+++ b/drivers/net/wireless/hostap/hostap_cs.c
@@ -816,8 +816,6 @@ static int hostap_cs_suspend(struct pcmc
 
 	PDEBUG(DEBUG_EXTRA, "%s: CS_EVENT_PM_SUSPEND\n", dev_info);
 
-	link->state |= DEV_SUSPEND;
-
 	if (link->state & DEV_CONFIG) {
 		struct hostap_interface *iface = netdev_priv(dev);
 		if (iface && iface->local)
@@ -827,7 +825,6 @@ static int hostap_cs_suspend(struct pcmc
 			netif_device_detach(dev);
 		}
 		prism2_suspend(dev);
-		pcmcia_release_configuration(link->handle);
 	}
 
 	return 0;
@@ -841,14 +838,11 @@ static int hostap_cs_resume(struct pcmci
 
 	PDEBUG(DEBUG_EXTRA, "%s: CS_EVENT_PM_RESUME\n", dev_info);
 
-	link->state &= ~DEV_SUSPEND;
 	if (link->state & DEV_CONFIG) {
 		struct hostap_interface *iface = netdev_priv(dev);
 		if (iface && iface->local)
 			dev_open = iface->local->num_dev_open > 0;
 
-		pcmcia_request_configuration(link->handle, &link->conf);
-
 		prism2_hw_shutdown(dev, 1);
 		prism2_hw_config(dev, dev_open ? 0 : 1);
 		if (dev_open) {
diff --git a/drivers/net/wireless/netwave_cs.c b/drivers/net/wireless/netwave_cs.c
index dfb47ac..545717b 100644
--- a/drivers/net/wireless/netwave_cs.c
+++ b/drivers/net/wireless/netwave_cs.c
@@ -884,12 +884,8 @@ static int netwave_suspend(struct pcmcia
 	dev_link_t *link = dev_to_instance(p_dev);
 	struct net_device *dev = link->priv;
 
-	link->state |= DEV_SUSPEND;
-	if (link->state & DEV_CONFIG) {
-		if (link->open)
-			netif_device_detach(dev);
-		pcmcia_release_configuration(link->handle);
-	}
+	if ((link->state & DEV_CONFIG) && (link->open))
+		netif_device_detach(dev);
 
 	return 0;
 }
@@ -899,13 +895,9 @@ static int netwave_resume(struct pcmcia_
 	dev_link_t *link = dev_to_instance(p_dev);
 	struct net_device *dev = link->priv;
 
-	link->state &= ~DEV_SUSPEND;
-	if (link->state & DEV_CONFIG) {
-		pcmcia_request_configuration(link->handle, &link->conf);
-		if (link->open) {
-			netwave_reset(dev);
-			netif_device_attach(dev);
-		}
+	if ((link->state & DEV_CONFIG) && (link->open)) {
+		netwave_reset(dev);
+		netif_device_attach(dev);
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/orinoco_cs.c b/drivers/net/wireless/orinoco_cs.c
index 0ce4165..89e16cd 100644
--- a/drivers/net/wireless/orinoco_cs.c
+++ b/drivers/net/wireless/orinoco_cs.c
@@ -429,7 +429,6 @@ static int orinoco_cs_suspend(struct pcm
 	int err = 0;
 	unsigned long flags;
 
-	link->state |= DEV_SUSPEND;
 	if (link->state & DEV_CONFIG) {
 		/* This is probably racy, but I can't think of
 		   a better way, short of rewriting the PCMCIA
@@ -447,8 +446,6 @@ static int orinoco_cs_suspend(struct pcm
 
 			spin_unlock_irqrestore(&priv->lock, flags);
 		}
-
-		pcmcia_release_configuration(link->handle);
 	}
 
 	return 0;
@@ -463,12 +460,7 @@ static int orinoco_cs_resume(struct pcmc
 	int err = 0;
 	unsigned long flags;
 
-	link->state &= ~DEV_SUSPEND;
 	if (link->state & DEV_CONFIG) {
-		/* FIXME: should we double check that this is
-		 * the same card as we had before */
-		pcmcia_request_configuration(link->handle, &link->conf);
-
 		if (! test_bit(0, &card->hard_reset_in_progress)) {
 			err = orinoco_reinit_firmware(dev);
 			if (err) {
diff --git a/drivers/net/wireless/ray_cs.c b/drivers/net/wireless/ray_cs.c
index fc81ac6..ed4bf50 100644
--- a/drivers/net/wireless/ray_cs.c
+++ b/drivers/net/wireless/ray_cs.c
@@ -868,14 +868,8 @@ static int ray_suspend(struct pcmcia_dev
 	dev_link_t *link = dev_to_instance(p_dev);
 	struct net_device *dev = link->priv;
 
-	link->state |= DEV_SUSPEND;
-        if (link->state & DEV_CONFIG) {
-		if (link->open)
-			netif_device_detach(dev);
-
-		pcmcia_release_configuration(link->handle);
-        }
-
+	if ((link->state & DEV_CONFIG) && (link->open))
+		netif_device_detach(dev);
 
 	return 0;
 }
@@ -885,14 +879,10 @@ static int ray_resume(struct pcmcia_devi
 	dev_link_t *link = dev_to_instance(p_dev);
 	struct net_device *dev = link->priv;
 
-	link->state &= ~DEV_SUSPEND;
-        if (link->state & DEV_CONFIG) {
-		pcmcia_request_configuration(link->handle, &link->conf);
-		if (link->open) {
-			ray_reset(dev);
-			netif_device_attach(dev);
-		}
-        }
+	if ((link->state & DEV_CONFIG) && (link->open)) {
+		ray_reset(dev);
+		netif_device_attach(dev);
+	}
 
 	return 0;
 }
diff --git a/drivers/net/wireless/spectrum_cs.c b/drivers/net/wireless/spectrum_cs.c
index b7ed99f..0429f1d 100644
--- a/drivers/net/wireless/spectrum_cs.c
+++ b/drivers/net/wireless/spectrum_cs.c
@@ -908,7 +908,6 @@ spectrum_cs_suspend(struct pcmcia_device
 	unsigned long flags;
 	int err = 0;
 
-	link->state |= DEV_SUSPEND;
 	/* Mark the device as stopped, to block IO until later */
 	if (link->state & DEV_CONFIG) {
 		spin_lock_irqsave(&priv->lock, flags);
@@ -922,8 +921,6 @@ spectrum_cs_suspend(struct pcmcia_device
 		priv->hw_unavailable++;
 
 		spin_unlock_irqrestore(&priv->lock, flags);
-
-		pcmcia_release_configuration(link->handle);
 	}
 
 	return 0;
@@ -936,11 +933,7 @@ spectrum_cs_resume(struct pcmcia_device 
 	struct net_device *dev = link->priv;
 	struct orinoco_private *priv = netdev_priv(dev);
 
-	link->state &= ~DEV_SUSPEND;
 	if (link->state & DEV_CONFIG) {
-		/* FIXME: should we double check that this is
-		 * the same card as we had before */
-		pcmcia_request_configuration(link->handle, &link->conf);
 		netif_device_attach(dev);
 		priv->hw_unavailable--;
 		schedule_work(&priv->reset_work);
diff --git a/drivers/net/wireless/wavelan_cs.c b/drivers/net/wireless/wavelan_cs.c
index 696aeb9..8cabcfe 100644
--- a/drivers/net/wireless/wavelan_cs.c
+++ b/drivers/net/wireless/wavelan_cs.c
@@ -4742,19 +4742,12 @@ static int wavelan_suspend(struct pcmcia
 	/* Stop receiving new messages and wait end of transmission */
 	wv_ru_stop(dev);
 
+	if ((link->state & DEV_CONFIG) && (link->open))
+		netif_device_detach(dev);
+
 	/* Power down the module */
 	hacr_write(dev->base_addr, HACR_DEFAULT & (~HACR_PWR_STAT));
 
-	/* The card is now suspended */
-	link->state |= DEV_SUSPEND;
-
-    	if(link->state & DEV_CONFIG)
-	{
-		if(link->open)
-			netif_device_detach(dev);
-		pcmcia_release_configuration(link->handle);
-	}
-
 	return 0;
 }
 
@@ -4764,14 +4757,9 @@ static int wavelan_resume(struct pcmcia_
 	struct net_device *	dev = (struct net_device *) link->priv;
 
 	link->state &= ~DEV_SUSPEND;
-	if(link->state & DEV_CONFIG)
-	{
-		pcmcia_request_configuration(link->handle, &link->conf);
-		if(link->open)	/* If RESET -> True, If RESUME -> False ? */
-		{
-			wv_hw_reset(dev);
-			netif_device_attach(dev);
-		}
+	if ((link->state & DEV_CONFIG) && (link->open))	{
+		wv_hw_reset(dev);
+		netif_device_attach(dev);
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/wl3501_cs.c b/drivers/net/wireless/wl3501_cs.c
index 0c81b3e..3a93a8b 100644
--- a/drivers/net/wireless/wl3501_cs.c
+++ b/drivers/net/wireless/wl3501_cs.c
@@ -2160,14 +2160,9 @@ static int wl3501_suspend(struct pcmcia_
 	dev_link_t *link = dev_to_instance(p_dev);
 	struct net_device *dev = link->priv;
 
-	link->state |= DEV_SUSPEND;
-
 	wl3501_pwr_mgmt(dev->priv, WL3501_SUSPEND);
-	if (link->state & DEV_CONFIG) {
-		if (link->open)
-			netif_device_detach(dev);
-		pcmcia_release_configuration(link->handle);
-	}
+	if ((link->state & DEV_CONFIG) && (link->open))
+		netif_device_detach(dev);
 
 	return 0;
 }
@@ -2178,12 +2173,9 @@ static int wl3501_resume(struct pcmcia_d
 	struct net_device *dev = link->priv;
 
 	wl3501_pwr_mgmt(dev->priv, WL3501_RESUME);
-	if (link->state & DEV_CONFIG) {
-		pcmcia_request_configuration(link->handle, &link->conf);
-		if (link->open) {
-			wl3501_reset(dev);
-			netif_device_attach(dev);
-		}
+	if ((link->state & DEV_CONFIG) && (link->open)) {
+		wl3501_reset(dev);
+		netif_device_attach(dev);
 	}
 
 	return 0;
diff --git a/drivers/parport/parport_cs.c b/drivers/parport/parport_cs.c
index 7edd7ef..5e12ed2 100644
--- a/drivers/parport/parport_cs.c
+++ b/drivers/parport/parport_cs.c
@@ -280,27 +280,6 @@ void parport_cs_release(dev_link_t *link
 	pcmcia_disable_device(link->handle);
 } /* parport_cs_release */
 
-static int parport_suspend(struct pcmcia_device *dev)
-{
-	dev_link_t *link = dev_to_instance(dev);
-
-	link->state |= DEV_SUSPEND;
-	if (link->state & DEV_CONFIG)
-		pcmcia_release_configuration(link->handle);
-
-	return 0;
-}
-
-static int parport_resume(struct pcmcia_device *dev)
-{
-	dev_link_t *link = dev_to_instance(dev);
-
-	link->state &= ~DEV_SUSPEND;
-	if (DEV_OK(link))
-		pcmcia_request_configuration(link->handle, &link->conf);
-
-	return 0;
-}
 
 static struct pcmcia_device_id parport_ids[] = {
 	PCMCIA_DEVICE_FUNC_ID(3),
@@ -317,8 +296,6 @@ static struct pcmcia_driver parport_cs_d
 	.probe		= parport_attach,
 	.remove		= parport_detach,
 	.id_table	= parport_ids,
-	.suspend	= parport_suspend,
-	.resume		= parport_resume,
 };
 
 static int __init init_parport_cs(void)
diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index 16159e9..ec2d416 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -10,7 +10,7 @@
  * are Copyright (C) 1999 David A. Hinds.  All Rights Reserved.
  *
  * (C) 1999		David A. Hinds
- * (C) 2003 - 2005	Dominik Brodowski
+ * (C) 2003 - 2006	Dominik Brodowski
  */
 
 #include <linux/kernel.h>
@@ -1030,12 +1030,22 @@ static int pcmcia_dev_suspend(struct dev
 {
 	struct pcmcia_device *p_dev = to_pcmcia_dev(dev);
 	struct pcmcia_driver *p_drv = NULL;
+	int ret;
 
 	if (dev->driver)
 		p_drv = to_pcmcia_drv(dev->driver);
 
-	if (p_drv && p_drv->suspend)
-		return p_drv->suspend(p_dev);
+	if (p_drv && p_drv->suspend) {
+		ret = p_drv->suspend(p_dev);
+		if (ret)
+			return ret;
+		if (p_dev->instance) {
+			p_dev->instance->state |= DEV_SUSPEND;
+			if ((p_dev->instance->state & DEV_CONFIG) &&
+			    !(p_dev->instance->state & DEV_SUSPEND_NORELEASE))
+				pcmcia_release_configuration(p_dev);
+		}
+	}
 
 	return 0;
 }
@@ -1045,12 +1055,24 @@ static int pcmcia_dev_resume(struct devi
 {
 	struct pcmcia_device *p_dev = to_pcmcia_dev(dev);
         struct pcmcia_driver *p_drv = NULL;
+	int ret;
 
 	if (dev->driver)
 		p_drv = to_pcmcia_drv(dev->driver);
 
-	if (p_drv && p_drv->resume)
+	if (p_drv && p_drv->resume) {
+		if (p_dev->instance) {
+			p_dev->instance->state &= ~DEV_SUSPEND;
+			if ((p_dev->instance->state & DEV_CONFIG) &&
+			    !(p_dev->instance->state & DEV_SUSPEND_NORELEASE)){
+				ret = pcmcia_request_configuration(p_dev,
+						 &p_dev->instance->conf);
+				if (ret)
+					return ret;
+			}
+		}
 		return p_drv->resume(p_dev);
+	}
 
 	return 0;
 }
diff --git a/drivers/scsi/pcmcia/aha152x_stub.c b/drivers/scsi/pcmcia/aha152x_stub.c
index e7f9d26..7fbef1e 100644
--- a/drivers/scsi/pcmcia/aha152x_stub.c
+++ b/drivers/scsi/pcmcia/aha152x_stub.c
@@ -251,27 +251,12 @@ static void aha152x_release_cs(dev_link_
 	pcmcia_disable_device(link->handle);
 }
 
-static int aha152x_suspend(struct pcmcia_device *dev)
-{
-	dev_link_t *link = dev_to_instance(dev);
-
-	link->state |= DEV_SUSPEND;
-	if (link->state & DEV_CONFIG)
-		pcmcia_release_configuration(link->handle);
-
-	return 0;
-}
-
 static int aha152x_resume(struct pcmcia_device *dev)
 {
 	dev_link_t *link = dev_to_instance(dev);
 	scsi_info_t *info = link->priv;
 
-	link->state &= ~DEV_SUSPEND;
-	if (link->state & DEV_CONFIG) {
-		pcmcia_request_configuration(link->handle, &link->conf);
-		aha152x_host_reset_host(info->host);
-	}
+	aha152x_host_reset_host(info->host);
 
 	return 0;
 }
@@ -294,7 +279,6 @@ static struct pcmcia_driver aha152x_cs_d
 	.probe		= aha152x_attach,
 	.remove		= aha152x_detach,
 	.id_table       = aha152x_ids,
-	.suspend	= aha152x_suspend,
 	.resume		= aha152x_resume,
 };
 
diff --git a/drivers/scsi/pcmcia/fdomain_stub.c b/drivers/scsi/pcmcia/fdomain_stub.c
index fb7221c..20b9b27 100644
--- a/drivers/scsi/pcmcia/fdomain_stub.c
+++ b/drivers/scsi/pcmcia/fdomain_stub.c
@@ -220,26 +220,12 @@ static void fdomain_release(dev_link_t *
 
 /*====================================================================*/
 
-static int fdomain_suspend(struct pcmcia_device *dev)
-{
-	dev_link_t *link = dev_to_instance(dev);
-
-	link->state |= DEV_SUSPEND;
-	if (link->state & DEV_CONFIG)
-		pcmcia_release_configuration(link->handle);
-
-	return 0;
-}
-
 static int fdomain_resume(struct pcmcia_device *dev)
 {
 	dev_link_t *link = dev_to_instance(dev);
 
-	link->state &= ~DEV_SUSPEND;
-	if (link->state & DEV_CONFIG) {
-		pcmcia_request_configuration(link->handle, &link->conf);
+	if (link->state & DEV_CONFIG)
 		fdomain_16x0_bus_reset(NULL);
-	}
 
 	return 0;
 }
@@ -260,7 +246,6 @@ static struct pcmcia_driver fdomain_cs_d
 	.probe		= fdomain_attach,
 	.remove		= fdomain_detach,
 	.id_table       = fdomain_ids,
-	.suspend	= fdomain_suspend,
 	.resume		= fdomain_resume,
 };
 
diff --git a/drivers/scsi/pcmcia/nsp_cs.c b/drivers/scsi/pcmcia/nsp_cs.c
index d469e0d..e313b40 100644
--- a/drivers/scsi/pcmcia/nsp_cs.c
+++ b/drivers/scsi/pcmcia/nsp_cs.c
@@ -1987,8 +1987,6 @@ static int nsp_cs_suspend(struct pcmcia_
 	scsi_info_t *info = link->priv;
 	nsp_hw_data *data;
 
-	link->state |= DEV_SUSPEND;
-
 	nsp_dbg(NSP_DEBUG_INIT, "event: suspend");
 
 	if (info->host != NULL) {
@@ -2001,9 +1999,6 @@ static int nsp_cs_suspend(struct pcmcia_
 
 	info->stop = 1;
 
-	if (link->state & DEV_CONFIG)
-		pcmcia_release_configuration(link->handle);
-
 	return 0;
 }
 
@@ -2015,11 +2010,6 @@ static int nsp_cs_resume(struct pcmcia_d
 
 	nsp_dbg(NSP_DEBUG_INIT, "event: resume");
 
-	link->state &= ~DEV_SUSPEND;
-
-	if (link->state & DEV_CONFIG)
-		pcmcia_request_configuration(link->handle, &link->conf);
-
 	info->stop = 0;
 
 	if (info->host != NULL) {
diff --git a/drivers/scsi/pcmcia/qlogic_stub.c b/drivers/scsi/pcmcia/qlogic_stub.c
index 1e27059..5a8da51 100644
--- a/drivers/scsi/pcmcia/qlogic_stub.c
+++ b/drivers/scsi/pcmcia/qlogic_stub.c
@@ -311,22 +311,10 @@ static void qlogic_release(dev_link_t *l
 
 /*====================================================================*/
 
-static int qlogic_suspend(struct pcmcia_device *dev)
-{
-	dev_link_t *link = dev_to_instance(dev);
-
-	link->state |= DEV_SUSPEND;
-	if (link->state & DEV_CONFIG)
-		pcmcia_release_configuration(link->handle);
-
-	return 0;
-}
-
 static int qlogic_resume(struct pcmcia_device *dev)
 {
 	dev_link_t *link = dev_to_instance(dev);
 
-	link->state &= ~DEV_SUSPEND;
 	if (link->state & DEV_CONFIG) {
 		scsi_info_t *info = link->priv;
 
@@ -375,7 +363,6 @@ static struct pcmcia_driver qlogic_cs_dr
 	.probe		= qlogic_attach,
 	.remove		= qlogic_detach,
 	.id_table       = qlogic_ids,
-	.suspend	= qlogic_suspend,
 	.resume		= qlogic_resume,
 };
 
diff --git a/drivers/scsi/pcmcia/sym53c500_cs.c b/drivers/scsi/pcmcia/sym53c500_cs.c
index 42d002b..4a69885 100644
--- a/drivers/scsi/pcmcia/sym53c500_cs.c
+++ b/drivers/scsi/pcmcia/sym53c500_cs.c
@@ -857,26 +857,12 @@ cs_failed:
 	return;
 } /* SYM53C500_config */
 
-static int sym53c500_suspend(struct pcmcia_device *dev)
-{
-	dev_link_t *link = dev_to_instance(dev);
-
-	link->state |= DEV_SUSPEND;
-	if (link->state & DEV_CONFIG)
-		pcmcia_release_configuration(link->handle);
-
-	return 0;
-}
-
 static int sym53c500_resume(struct pcmcia_device *dev)
 {
 	dev_link_t *link = dev_to_instance(dev);
 	struct scsi_info_t *info = link->priv;
 
-	link->state &= ~DEV_SUSPEND;
 	if (link->state & DEV_CONFIG) {
-		pcmcia_request_configuration(link->handle, &link->conf);
-
 		/* See earlier comment about manufacturer IDs. */
 		if ((info->manf_id == MANFID_MACNICA) ||
 		    (info->manf_id == MANFID_PIONEER) ||
@@ -963,7 +949,6 @@ static struct pcmcia_driver sym53c500_cs
 	.probe		= SYM53C500_attach,
 	.remove		= SYM53C500_detach,
 	.id_table       = sym53c500_ids,
-	.suspend	= sym53c500_suspend,
 	.resume		= sym53c500_resume,
 };
 
diff --git a/drivers/serial/serial_cs.c b/drivers/serial/serial_cs.c
index ff38820..b6b460f 100644
--- a/drivers/serial/serial_cs.c
+++ b/drivers/serial/serial_cs.c
@@ -151,7 +151,6 @@ static void serial_remove(dev_link_t *li
 static int serial_suspend(struct pcmcia_device *dev)
 {
 	dev_link_t *link = dev_to_instance(dev);
-	link->state |= DEV_SUSPEND;
 
 	if (link->state & DEV_CONFIG) {
 		struct serial_info *info = link->priv;
@@ -160,8 +159,8 @@ static int serial_suspend(struct pcmcia_
 		for (i = 0; i < info->ndev; i++)
 			serial8250_suspend_port(info->line[i]);
 
-		if (!info->slave)
-			pcmcia_release_configuration(link->handle);
+		if (info->slave)
+			link->state &= DEV_SUSPEND_NORELEASE;
 	}
 
 	return 0;
@@ -170,15 +169,11 @@ static int serial_suspend(struct pcmcia_
 static int serial_resume(struct pcmcia_device *dev)
 {
 	dev_link_t *link = dev_to_instance(dev);
-	link->state &= ~DEV_SUSPEND;
 
 	if (DEV_OK(link)) {
 		struct serial_info *info = link->priv;
 		int i;
 
-		if (!info->slave)
-			pcmcia_request_configuration(link->handle, &link->conf);
-
 		for (i = 0; i < info->ndev; i++)
 			serial8250_resume_port(info->line[i]);
 	}
diff --git a/drivers/telephony/ixj_pcmcia.c b/drivers/telephony/ixj_pcmcia.c
index fe3cde0..5094655 100644
--- a/drivers/telephony/ixj_pcmcia.c
+++ b/drivers/telephony/ixj_pcmcia.c
@@ -232,28 +232,6 @@ static void ixj_cs_release(dev_link_t *l
 	pcmcia_disable_device(link->handle);
 }
 
-static int ixj_suspend(struct pcmcia_device *dev)
-{
-	dev_link_t *link = dev_to_instance(dev);
-
-	link->state |= DEV_SUSPEND;
-	if (link->state & DEV_CONFIG)
-		pcmcia_release_configuration(link->handle);
-
-	return 0;
-}
-
-static int ixj_resume(struct pcmcia_device *dev)
-{
-	dev_link_t *link = dev_to_instance(dev);
-
-	link->state &= ~DEV_SUSPEND;
-	if (DEV_OK(link))
-		pcmcia_request_configuration(link->handle, &link->conf);
-
-	return 0;
-}
-
 static struct pcmcia_device_id ixj_ids[] = {
 	PCMCIA_DEVICE_MANF_CARD(0x0257, 0x0600),
 	PCMCIA_DEVICE_NULL
@@ -268,8 +246,6 @@ static struct pcmcia_driver ixj_driver =
 	.probe		= ixj_attach,
 	.remove		= ixj_detach,
 	.id_table	= ixj_ids,
-	.suspend	= ixj_suspend,
-	.resume		= ixj_resume,
 };
 
 static int __init ixj_pcmcia_init(void)
diff --git a/drivers/usb/host/sl811_cs.c b/drivers/usb/host/sl811_cs.c
index ee81167..ca3fc33 100644
--- a/drivers/usb/host/sl811_cs.c
+++ b/drivers/usb/host/sl811_cs.c
@@ -293,28 +293,6 @@ cs_failed:
 	}
 }
 
-static int sl811_suspend(struct pcmcia_device *dev)
-{
-	dev_link_t *link = dev_to_instance(dev);
-
-	link->state |= DEV_SUSPEND;
-	if (link->state & DEV_CONFIG)
-		pcmcia_release_configuration(link->handle);
-
-	return 0;
-}
-
-static int sl811_resume(struct pcmcia_device *dev)
-{
-	dev_link_t *link = dev_to_instance(dev);
-
-	link->state &= ~DEV_SUSPEND;
-	if (link->state & DEV_CONFIG)
-		pcmcia_request_configuration(link->handle, &link->conf);
-
-	return 0;
-}
-
 static int sl811_cs_attach(struct pcmcia_device *p_dev)
 {
 	local_info_t *local;
@@ -359,8 +337,6 @@ static struct pcmcia_driver sl811_cs_dri
 	.probe		= sl811_cs_attach,
 	.remove		= sl811_cs_detach,
 	.id_table	= sl811_ids,
-	.suspend	= sl811_suspend,
-	.resume		= sl811_resume,
 };
 
 /*====================================================================*/
diff --git a/include/pcmcia/ds.h b/include/pcmcia/ds.h
index ce76ab5..8a6a95e 100644
--- a/include/pcmcia/ds.h
+++ b/include/pcmcia/ds.h
@@ -118,8 +118,7 @@ typedef struct dev_link_t {
 /* Flags for device state */
 #define DEV_PRESENT		0x01
 #define DEV_CONFIG		0x02
-#define DEV_STALE_CONFIG	0x04	/* release on close */
-#define DEV_STALE_LINK		0x08	/* detach on release */
+#define DEV_SUSPEND_NORELEASE	0x04
 #define DEV_CONFIG_PENDING	0x10
 #define DEV_RELEASE_PENDING	0x20
 #define DEV_SUSPEND		0x40
diff --git a/sound/pcmcia/pdaudiocf/pdaudiocf.c b/sound/pcmcia/pdaudiocf/pdaudiocf.c
index 80c5355..31f4bdc 100644
--- a/sound/pcmcia/pdaudiocf/pdaudiocf.c
+++ b/sound/pcmcia/pdaudiocf/pdaudiocf.c
@@ -284,16 +284,11 @@ static int pdacf_suspend(struct pcmcia_d
 	struct snd_pdacf *chip = link->priv;
 
 	snd_printdd(KERN_DEBUG "SUSPEND\n");
-	link->state |= DEV_SUSPEND;
 	if (chip) {
 		snd_printdd(KERN_DEBUG "snd_pdacf_suspend calling\n");
 		snd_pdacf_suspend(chip, PMSG_SUSPEND);
 	}
 
-	snd_printdd(KERN_DEBUG "RESET_PHYSICAL\n");
-	if (link->state & DEV_CONFIG)
-		pcmcia_release_configuration(link->handle);
-
 	return 0;
 }
 
@@ -303,12 +298,7 @@ static int pdacf_resume(struct pcmcia_de
 	struct snd_pdacf *chip = link->priv;
 
 	snd_printdd(KERN_DEBUG "RESUME\n");
-	link->state &= ~DEV_SUSPEND;
-
-	snd_printdd(KERN_DEBUG "CARD_RESET\n");
 	if (DEV_OK(link)) {
-		snd_printdd(KERN_DEBUG "requestconfig...\n");
-		pcmcia_request_configuration(link->handle, &link->conf);
 		if (chip) {
 			snd_printdd(KERN_DEBUG "calling snd_pdacf_resume\n");
 			snd_pdacf_resume(chip);
diff --git a/sound/pcmcia/vx/vxpocket.c b/sound/pcmcia/vx/vxpocket.c
index 8093e50..e101e05 100644
--- a/sound/pcmcia/vx/vxpocket.c
+++ b/sound/pcmcia/vx/vxpocket.c
@@ -284,14 +284,10 @@ static int vxp_suspend(struct pcmcia_dev
 	struct vx_core *chip = link->priv;
 
 	snd_printdd(KERN_DEBUG "SUSPEND\n");
-	link->state |= DEV_SUSPEND;
 	if (chip) {
 		snd_printdd(KERN_DEBUG "snd_vx_suspend calling\n");
 		snd_vx_suspend(chip, PMSG_SUSPEND);
 	}
-	snd_printdd(KERN_DEBUG "RESET_PHYSICAL\n");
-	if (link->state & DEV_CONFIG)
-		pcmcia_release_configuration(link->handle);
 
 	return 0;
 }
@@ -302,13 +298,8 @@ static int vxp_resume(struct pcmcia_devi
 	struct vx_core *chip = link->priv;
 
 	snd_printdd(KERN_DEBUG "RESUME\n");
-	link->state &= ~DEV_SUSPEND;
-
-	snd_printdd(KERN_DEBUG "CARD_RESET\n");
 	if (DEV_OK(link)) {
 		//struct snd_vxpocket *vxp = (struct snd_vxpocket *)chip;
-		snd_printdd(KERN_DEBUG "requestconfig...\n");
-		pcmcia_request_configuration(link->handle, &link->conf);
 		if (chip) {
 			snd_printdd(KERN_DEBUG "calling snd_vx_resume\n");
 			snd_vx_resume(chip);
-- 
1.2.4

