Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWCaUfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWCaUfJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 15:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWCaUfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 15:35:09 -0500
Received: from isilmar.linta.de ([213.239.214.66]:21719 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1751333AbWCaUfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 15:35:02 -0500
Date: Fri, 31 Mar 2006 22:16:39 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-pcmcia@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 17/33] pcmcia: add pcmcia_disable_device
Message-ID: <20060331201639.GF28037@dominikbrodowski.de>
Mail-Followup-To: linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20060331195852.GB27888@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331195852.GB27888@dominikbrodowski.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pcmcia_disable_device(struct pcmcia_device *p_dev) performs the necessary
cleanups upon device or driver removal: it calls the appropriate
pcmcia_release_* functions, and can replace (most) of the current drivers'
_release() functions.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

---

 Documentation/pcmcia/driver-changes.txt |    6 +++
 drivers/bluetooth/bluecard_cs.c         |    8 ---
 drivers/bluetooth/bt3c_cs.c             |    8 ---
 drivers/bluetooth/btuart_cs.c           |    8 ---
 drivers/bluetooth/dtl1_cs.c             |    8 ---
 drivers/char/pcmcia/cm4000_cs.c         |    3 -
 drivers/char/pcmcia/cm4040_cs.c         |    3 -
 drivers/char/pcmcia/synclink_cs.c       |   10 ----
 drivers/ide/legacy/ide-cs.c             |    8 ---
 drivers/isdn/hardware/avm/avm_cs.c      |   12 +----
 drivers/isdn/hisax/avma1_cs.c           |   17 ++-----
 drivers/isdn/hisax/elsa_cs.c            |   10 ----
 drivers/isdn/hisax/sedlbauer_cs.c       |   17 -------
 drivers/isdn/hisax/teles_cs.c           |   10 ----
 drivers/net/pcmcia/3c574_cs.c           |    8 ---
 drivers/net/pcmcia/3c589_cs.c           |    8 ---
 drivers/net/pcmcia/axnet_cs.c           |    8 ---
 drivers/net/pcmcia/com20020_cs.c        |   12 +----
 drivers/net/pcmcia/fmvj18x_cs.c         |   12 +----
 drivers/net/pcmcia/ibmtr_cs.c           |   23 ++++------
 drivers/net/pcmcia/nmclan_cs.c          |   10 +---
 drivers/net/pcmcia/pcnet_cs.c           |   15 ++-----
 drivers/net/pcmcia/smc91c92_cs.c        |   21 +++------
 drivers/net/pcmcia/xirc2ps_cs.c         |   22 +++-------
 drivers/net/wireless/airo_cs.c          |   19 --------
 drivers/net/wireless/atmel_cs.c         |   21 +++------
 drivers/net/wireless/hostap/hostap_cs.c |   11 -----
 drivers/net/wireless/netwave_cs.c       |   19 +++-----
 drivers/net/wireless/orinoco_cs.c       |    8 ---
 drivers/net/wireless/spectrum_cs.c      |    8 ---
 drivers/net/wireless/wavelan_cs.c       |   18 +++-----
 drivers/net/wireless/wl3501_cs.c        |   10 +---
 drivers/parport/parport_cs.c            |   26 ++++-------
 drivers/pcmcia/pcmcia_resource.c        |   71 ++++++++++++++++++-------------
 drivers/scsi/pcmcia/aha152x_stub.c      |    8 ---
 drivers/scsi/pcmcia/fdomain_stub.c      |   17 ++-----
 drivers/scsi/pcmcia/nsp_cs.c            |   11 +----
 drivers/scsi/pcmcia/qlogic_stub.c       |    9 +---
 drivers/scsi/pcmcia/sym53c500_cs.c      |    8 ---
 drivers/serial/serial_cs.c              |    7 +--
 include/pcmcia/cs.h                     |    2 +
 sound/pcmcia/pdaudiocf/pdaudiocf.c      |    8 ---
 sound/pcmcia/vx/vxpocket.c              |    8 ---
 43 files changed, 154 insertions(+), 402 deletions(-)

5f2a71fcb7995633b335a1e380ac63a968e61320
diff --git a/Documentation/pcmcia/driver-changes.txt b/Documentation/pcmcia/driver-changes.txt
index 97420f0..c89a5e2 100644
--- a/Documentation/pcmcia/driver-changes.txt
+++ b/Documentation/pcmcia/driver-changes.txt
@@ -1,5 +1,11 @@
 This file details changes in 2.6 which affect PCMCIA card driver authors:
 
+* New release helper (as of 2.6.17)
+   Instead of calling pcmcia_release_{configuration,io,irq,win}, all that's
+   necessary now is calling pcmcia_disable_device. As there is no valid
+   reason left to call pcmcia_release_io and pcmcia_release_irq, they will
+   be removed soon.
+
 * Unify detach and REMOVAL event code, as well as attach and INSERTION
   code (as of 2.6.16)
        void (*remove)          (struct pcmcia_device *dev);
diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index 9888bc1..128e416 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -1002,13 +1002,7 @@ static void bluecard_release(dev_link_t 
 
 	del_timer(&(info->timer));
 
-	link->dev = NULL;
-
-	pcmcia_release_configuration(link->handle);
-	pcmcia_release_io(link->handle, &link->io);
-	pcmcia_release_irq(link->handle, &link->irq);
-
-	link->state &= ~DEV_CONFIG;
+	pcmcia_disable_device(link->handle);
 }
 
 static int bluecard_suspend(struct pcmcia_device *dev)
diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index 7e21b1f..ac1410c 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -839,13 +839,7 @@ static void bt3c_release(dev_link_t *lin
 	if (link->state & DEV_PRESENT)
 		bt3c_close(info);
 
-	link->dev = NULL;
-
-	pcmcia_release_configuration(link->handle);
-	pcmcia_release_io(link->handle, &link->io);
-	pcmcia_release_irq(link->handle, &link->irq);
-
-	link->state &= ~DEV_CONFIG;
+	pcmcia_disable_device(link->handle);
 }
 
 static int bt3c_suspend(struct pcmcia_device *dev)
diff --git a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
index 7b4bff4..8cd54bb 100644
--- a/drivers/bluetooth/btuart_cs.c
+++ b/drivers/bluetooth/btuart_cs.c
@@ -768,13 +768,7 @@ static void btuart_release(dev_link_t *l
 	if (link->state & DEV_PRESENT)
 		btuart_close(info);
 
-	link->dev = NULL;
-
-	pcmcia_release_configuration(link->handle);
-	pcmcia_release_io(link->handle, &link->io);
-	pcmcia_release_irq(link->handle, &link->irq);
-
-	link->state &= ~DEV_CONFIG;
+	pcmcia_disable_device(link->handle);
 }
 
 static int btuart_suspend(struct pcmcia_device *dev)
diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index 0449bc4..efbc8a5 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -720,13 +720,7 @@ static void dtl1_release(dev_link_t *lin
 	if (link->state & DEV_PRESENT)
 		dtl1_close(info);
 
-	link->dev = NULL;
-
-	pcmcia_release_configuration(link->handle);
-	pcmcia_release_io(link->handle, &link->io);
-	pcmcia_release_irq(link->handle, &link->irq);
-
-	link->state &= ~DEV_CONFIG;
+	pcmcia_disable_device(link->handle);
 }
 
 static int dtl1_suspend(struct pcmcia_device *dev)
diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index 5fdf185..3ddd3da 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -1899,8 +1899,7 @@ static int cm4000_resume(struct pcmcia_d
 static void cm4000_release(dev_link_t *link)
 {
 	cmm_cm4000_release(link->priv);	/* delay release until device closed */
-	pcmcia_release_configuration(link->handle);
-	pcmcia_release_io(link->handle, &link->io);
+	pcmcia_disable_device(link->handle);
 }
 
 static int cm4000_attach(struct pcmcia_device *p_dev)
diff --git a/drivers/char/pcmcia/cm4040_cs.c b/drivers/char/pcmcia/cm4040_cs.c
index 466e33b..1c355bd 100644
--- a/drivers/char/pcmcia/cm4040_cs.c
+++ b/drivers/char/pcmcia/cm4040_cs.c
@@ -654,8 +654,7 @@ static int reader_resume(struct pcmcia_d
 static void reader_release(dev_link_t *link)
 {
 	cm4040_reader_release(link->priv);
-	pcmcia_release_configuration(link->handle);
-	pcmcia_release_io(link->handle, &link->io);
+	pcmcia_disable_device(link->handle);
 }
 
 static int reader_attach(struct pcmcia_device *p_dev)
diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index e6b714b..371d10b 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -710,15 +710,7 @@ static void mgslpc_release(u_long arg)
     if (debug_level >= DEBUG_LEVEL_INFO)
 	    printk("mgslpc_release(0x%p)\n", link);
 
-    /* Unlink the device chain */
-    link->dev = NULL;
-    link->state &= ~DEV_CONFIG;
-
-    pcmcia_release_configuration(link->handle);
-    if (link->io.NumPorts1)
-	    pcmcia_release_io(link->handle, &link->io);
-    if (link->irq.AssignedIRQ)
-	    pcmcia_release_irq(link->handle, &link->irq);
+    pcmcia_disable_device(link->handle);
 }
 
 static void mgslpc_detach(struct pcmcia_device *p_dev)
diff --git a/drivers/ide/legacy/ide-cs.c b/drivers/ide/legacy/ide-cs.c
index 6213bd3..024aad6 100644
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
@@ -369,14 +369,8 @@ void ide_release(dev_link_t *link)
 	ide_unregister(info->hd);
     }
     info->ndev = 0;
-    link->dev = NULL;
-    
-    pcmcia_release_configuration(link->handle);
-    pcmcia_release_io(link->handle, &link->io);
-    pcmcia_release_irq(link->handle, &link->irq);
-    
-    link->state &= ~DEV_CONFIG;
 
+    pcmcia_disable_device(link->handle);
 } /* ide_release */
 
 static int ide_suspend(struct pcmcia_device *dev)
diff --git a/drivers/isdn/hardware/avm/avm_cs.c b/drivers/isdn/hardware/avm/avm_cs.c
index 2a2b03f..f3889bd 100644
--- a/drivers/isdn/hardware/avm/avm_cs.c
+++ b/drivers/isdn/hardware/avm/avm_cs.c
@@ -367,16 +367,8 @@ found_port:
 
 static void avmcs_release(dev_link_t *link)
 {
-    b1pcmcia_delcard(link->io.BasePort1, link->irq.AssignedIRQ);
-
-    /* Unlink the device chain */
-    link->dev = NULL;
-    
-    /* Don't bother checking to see if these succeed or not */
-    pcmcia_release_configuration(link->handle);
-    pcmcia_release_io(link->handle, &link->io);
-    pcmcia_release_irq(link->handle, &link->irq);
-    link->state &= ~DEV_CONFIG;
+	b1pcmcia_delcard(link->io.BasePort1, link->irq.AssignedIRQ);
+	pcmcia_disable_device(link->handle);
 } /* avmcs_release */
 
 static int avmcs_suspend(struct pcmcia_device *dev)
diff --git a/drivers/isdn/hisax/avma1_cs.c b/drivers/isdn/hisax/avma1_cs.c
index 969da40..729c2de 100644
--- a/drivers/isdn/hisax/avma1_cs.c
+++ b/drivers/isdn/hisax/avma1_cs.c
@@ -373,21 +373,14 @@ found_port:
 
 static void avma1cs_release(dev_link_t *link)
 {
-    local_info_t *local = link->priv;
+	local_info_t *local = link->priv;
 
-    DEBUG(0, "avma1cs_release(0x%p)\n", link);
+	DEBUG(0, "avma1cs_release(0x%p)\n", link);
 
-    /* no unregister function with hisax */
-    HiSax_closecard(local->node.minor);
+	/* now unregister function with hisax */
+	HiSax_closecard(local->node.minor);
 
-    /* Unlink the device chain */
-    link->dev = NULL;
-    
-    /* Don't bother checking to see if these succeed or not */
-    pcmcia_release_configuration(link->handle);
-    pcmcia_release_io(link->handle, &link->io);
-    pcmcia_release_irq(link->handle, &link->irq);
-    link->state &= ~DEV_CONFIG;
+	pcmcia_disable_device(link->handle);
 } /* avma1cs_release */
 
 static int avma1cs_suspend(struct pcmcia_device *dev)
diff --git a/drivers/isdn/hisax/elsa_cs.c b/drivers/isdn/hisax/elsa_cs.c
index 062fb8f..60c75c7 100644
--- a/drivers/isdn/hisax/elsa_cs.c
+++ b/drivers/isdn/hisax/elsa_cs.c
@@ -380,16 +380,8 @@ static void elsa_cs_release(dev_link_t *
 	    HiSax_closecard(local->cardnr);
 	}
     }
-    /* Unlink the device chain */
-    link->dev = NULL;
 
-    /* Don't bother checking to see if these succeed or not */
-    if (link->win)
-        pcmcia_release_window(link->win);
-    pcmcia_release_configuration(link->handle);
-    pcmcia_release_io(link->handle, &link->io);
-    pcmcia_release_irq(link->handle, &link->irq);
-    link->state &= ~DEV_CONFIG;
+    pcmcia_disable_device(link->handle);
 } /* elsa_cs_release */
 
 static int elsa_suspend(struct pcmcia_device *p_dev)
diff --git a/drivers/isdn/hisax/sedlbauer_cs.c b/drivers/isdn/hisax/sedlbauer_cs.c
index 6f5213a..e595391 100644
--- a/drivers/isdn/hisax/sedlbauer_cs.c
+++ b/drivers/isdn/hisax/sedlbauer_cs.c
@@ -467,23 +467,8 @@ static void sedlbauer_release(dev_link_t
 	    HiSax_closecard(local->cardnr);
 	}
     }
-    /* Unlink the device chain */
-    link->dev = NULL;
 
-    /*
-      In a normal driver, additional code may be needed to release
-      other kernel data structures associated with this device. 
-    */
-    
-    /* Don't bother checking to see if these succeed or not */
-    if (link->win)
-	pcmcia_release_window(link->win);
-    pcmcia_release_configuration(link->handle);
-    if (link->io.NumPorts1)
-	pcmcia_release_io(link->handle, &link->io);
-    if (link->irq.AssignedIRQ)
-	pcmcia_release_irq(link->handle, &link->irq);
-    link->state &= ~DEV_CONFIG;
+    pcmcia_disable_device(link->handle);
 } /* sedlbauer_release */
 
 static int sedlbauer_suspend(struct pcmcia_device *p_dev)
diff --git a/drivers/isdn/hisax/teles_cs.c b/drivers/isdn/hisax/teles_cs.c
index 4e5c14c..7945fd6 100644
--- a/drivers/isdn/hisax/teles_cs.c
+++ b/drivers/isdn/hisax/teles_cs.c
@@ -371,16 +371,8 @@ static void teles_cs_release(dev_link_t 
 	    HiSax_closecard(local->cardnr);
 	}
     }
-    /* Unlink the device chain */
-    link->dev = NULL;
 
-    /* Don't bother checking to see if these succeed or not */
-    if (link->win)
-        pcmcia_release_window(link->win);
-    pcmcia_release_configuration(link->handle);
-    pcmcia_release_io(link->handle, &link->io);
-    pcmcia_release_irq(link->handle, &link->irq);
-    link->state &= ~DEV_CONFIG;
+    pcmcia_disable_device(link->handle);
 } /* teles_cs_release */
 
 static int teles_suspend(struct pcmcia_device *p_dev)
diff --git a/drivers/net/pcmcia/3c574_cs.c b/drivers/net/pcmcia/3c574_cs.c
index ce90bec..1799660 100644
--- a/drivers/net/pcmcia/3c574_cs.c
+++ b/drivers/net/pcmcia/3c574_cs.c
@@ -511,13 +511,7 @@ failed:
 
 static void tc574_release(dev_link_t *link)
 {
-	DEBUG(0, "3c574_release(0x%p)\n", link);
-
-	pcmcia_release_configuration(link->handle);
-	pcmcia_release_io(link->handle, &link->io);
-	pcmcia_release_irq(link->handle, &link->irq);
-
-	link->state &= ~DEV_CONFIG;
+	pcmcia_disable_device(link->handle);
 }
 
 static int tc574_suspend(struct pcmcia_device *p_dev)
diff --git a/drivers/net/pcmcia/3c589_cs.c b/drivers/net/pcmcia/3c589_cs.c
index 3dba508..e361538 100644
--- a/drivers/net/pcmcia/3c589_cs.c
+++ b/drivers/net/pcmcia/3c589_cs.c
@@ -386,13 +386,7 @@ failed:
 
 static void tc589_release(dev_link_t *link)
 {
-    DEBUG(0, "3c589_release(0x%p)\n", link);
-    
-    pcmcia_release_configuration(link->handle);
-    pcmcia_release_io(link->handle, &link->io);
-    pcmcia_release_irq(link->handle, &link->irq);
-    
-    link->state &= ~DEV_CONFIG;
+	pcmcia_disable_device(link->handle);
 }
 
 static int tc589_suspend(struct pcmcia_device *p_dev)
diff --git a/drivers/net/pcmcia/axnet_cs.c b/drivers/net/pcmcia/axnet_cs.c
index 1cc94b2..9b9c0f1 100644
--- a/drivers/net/pcmcia/axnet_cs.c
+++ b/drivers/net/pcmcia/axnet_cs.c
@@ -456,13 +456,7 @@ failed:
 
 static void axnet_release(dev_link_t *link)
 {
-    DEBUG(0, "axnet_release(0x%p)\n", link);
-
-    pcmcia_release_configuration(link->handle);
-    pcmcia_release_io(link->handle, &link->io);
-    pcmcia_release_irq(link->handle, &link->irq);
-
-    link->state &= ~DEV_CONFIG;
+	pcmcia_disable_device(link->handle);
 }
 
 static int axnet_suspend(struct pcmcia_device *p_dev)
diff --git a/drivers/net/pcmcia/com20020_cs.c b/drivers/net/pcmcia/com20020_cs.c
index 2827a48..a0ec5e7 100644
--- a/drivers/net/pcmcia/com20020_cs.c
+++ b/drivers/net/pcmcia/com20020_cs.c
@@ -377,16 +377,8 @@ failed:
 
 static void com20020_release(dev_link_t *link)
 {
-
-    DEBUG(1,"release...\n");
-
-    DEBUG(0, "com20020_release(0x%p)\n", link);
-
-    pcmcia_release_configuration(link->handle);
-    pcmcia_release_io(link->handle, &link->io);
-    pcmcia_release_irq(link->handle, &link->irq);
-
-    link->state &= ~(DEV_CONFIG | DEV_RELEASE_PENDING);
+	DEBUG(0, "com20020_release(0x%p)\n", link);
+	pcmcia_disable_device(link->handle);
 }
 
 static int com20020_suspend(struct pcmcia_device *p_dev)
diff --git a/drivers/net/pcmcia/fmvj18x_cs.c b/drivers/net/pcmcia/fmvj18x_cs.c
index b7ac14b..6b435e9 100644
--- a/drivers/net/pcmcia/fmvj18x_cs.c
+++ b/drivers/net/pcmcia/fmvj18x_cs.c
@@ -674,16 +674,8 @@ static int fmvj18x_setup_mfc(dev_link_t 
 
 static void fmvj18x_release(dev_link_t *link)
 {
-
-    DEBUG(0, "fmvj18x_release(0x%p)\n", link);
-
-    /* Don't bother checking to see if these succeed or not */
-    pcmcia_release_window(link->win);
-    pcmcia_release_configuration(link->handle);
-    pcmcia_release_io(link->handle, &link->io);
-    pcmcia_release_irq(link->handle, &link->irq);
-    
-    link->state &= ~DEV_CONFIG;
+	DEBUG(0, "fmvj18x_release(0x%p)\n", link);
+	pcmcia_disable_device(link->handle);
 }
 
 static int fmvj18x_suspend(struct pcmcia_device *p_dev)
diff --git a/drivers/net/pcmcia/ibmtr_cs.c b/drivers/net/pcmcia/ibmtr_cs.c
index b9c7e39..1948a0b 100644
--- a/drivers/net/pcmcia/ibmtr_cs.c
+++ b/drivers/net/pcmcia/ibmtr_cs.c
@@ -348,22 +348,17 @@ failed:
 
 static void ibmtr_release(dev_link_t *link)
 {
-    ibmtr_dev_t *info = link->priv;
-    struct net_device *dev = info->dev;
-
-    DEBUG(0, "ibmtr_release(0x%p)\n", link);
+	ibmtr_dev_t *info = link->priv;
+	struct net_device *dev = info->dev;
 
-    pcmcia_release_configuration(link->handle);
-    pcmcia_release_io(link->handle, &link->io);
-    pcmcia_release_irq(link->handle, &link->irq);
-    if (link->win) {
-	struct tok_info *ti = netdev_priv(dev);
-	iounmap(ti->mmio);
-	pcmcia_release_window(link->win);
-	pcmcia_release_window(info->sram_win_handle);
-    }
+	DEBUG(0, "ibmtr_release(0x%p)\n", link);
 
-    link->state &= ~DEV_CONFIG;
+	if (link->win) {
+		struct tok_info *ti = netdev_priv(dev);
+		iounmap(ti->mmio);
+		pcmcia_release_window(info->sram_win_handle);
+	}
+	pcmcia_disable_device(link->handle);
 }
 
 static int ibmtr_suspend(struct pcmcia_device *p_dev)
diff --git a/drivers/net/pcmcia/nmclan_cs.c b/drivers/net/pcmcia/nmclan_cs.c
index 787176c..76ef453 100644
--- a/drivers/net/pcmcia/nmclan_cs.c
+++ b/drivers/net/pcmcia/nmclan_cs.c
@@ -765,14 +765,8 @@ nmclan_release
 ---------------------------------------------------------------------------- */
 static void nmclan_release(dev_link_t *link)
 {
-
-  DEBUG(0, "nmclan_release(0x%p)\n", link);
-
-  pcmcia_release_configuration(link->handle);
-  pcmcia_release_io(link->handle, &link->io);
-  pcmcia_release_irq(link->handle, &link->irq);
-
-  link->state &= ~DEV_CONFIG;
+	DEBUG(0, "nmclan_release(0x%p)\n", link);
+	pcmcia_disable_device(link->handle);
 }
 
 static int nmclan_suspend(struct pcmcia_device *p_dev)
diff --git a/drivers/net/pcmcia/pcnet_cs.c b/drivers/net/pcmcia/pcnet_cs.c
index b46e5f7..52f44bd 100644
--- a/drivers/net/pcmcia/pcnet_cs.c
+++ b/drivers/net/pcmcia/pcnet_cs.c
@@ -732,19 +732,14 @@ failed:
 
 static void pcnet_release(dev_link_t *link)
 {
-    pcnet_dev_t *info = PRIV(link->priv);
+	pcnet_dev_t *info = PRIV(link->priv);
 
-    DEBUG(0, "pcnet_release(0x%p)\n", link);
+	DEBUG(0, "pcnet_release(0x%p)\n", link);
 
-    if (info->flags & USE_SHMEM) {
-	iounmap(info->base);
-	pcmcia_release_window(link->win);
-    }
-    pcmcia_release_configuration(link->handle);
-    pcmcia_release_io(link->handle, &link->io);
-    pcmcia_release_irq(link->handle, &link->irq);
+	if (info->flags & USE_SHMEM)
+		iounmap(info->base);
 
-    link->state &= ~DEV_CONFIG;
+	pcmcia_disable_device(link->handle);
 }
 
 /*======================================================================
diff --git a/drivers/net/pcmcia/smc91c92_cs.c b/drivers/net/pcmcia/smc91c92_cs.c
index 8839c4f..56700b1 100644
--- a/drivers/net/pcmcia/smc91c92_cs.c
+++ b/drivers/net/pcmcia/smc91c92_cs.c
@@ -1181,20 +1181,13 @@ config_failed:			/* CS_EXIT_TEST() calls
 
 static void smc91c92_release(dev_link_t *link)
 {
-
-    DEBUG(0, "smc91c92_release(0x%p)\n", link);
-
-    pcmcia_release_configuration(link->handle);
-    pcmcia_release_io(link->handle, &link->io);
-    pcmcia_release_irq(link->handle, &link->irq);
-    if (link->win) {
-	struct net_device *dev = link->priv;
-	struct smc_private *smc = netdev_priv(dev);
-	iounmap(smc->base);
-	pcmcia_release_window(link->win);
-    }
-
-    link->state &= ~DEV_CONFIG;
+	DEBUG(0, "smc91c92_release(0x%p)\n", link);
+	if (link->win) {
+		struct net_device *dev = link->priv;
+		struct smc_private *smc = netdev_priv(dev);
+		iounmap(smc->base);
+	}
+	pcmcia_disable_device(link->handle);
 }
 
 /*======================================================================
diff --git a/drivers/net/pcmcia/xirc2ps_cs.c b/drivers/net/pcmcia/xirc2ps_cs.c
index eed4968..2b57a87 100644
--- a/drivers/net/pcmcia/xirc2ps_cs.c
+++ b/drivers/net/pcmcia/xirc2ps_cs.c
@@ -1090,21 +1090,15 @@ xirc2ps_config(dev_link_t * link)
 static void
 xirc2ps_release(dev_link_t *link)
 {
+	DEBUG(0, "release(0x%p)\n", link);
 
-    DEBUG(0, "release(0x%p)\n", link);
-
-    if (link->win) {
-	struct net_device *dev = link->priv;
-	local_info_t *local = netdev_priv(dev);
-	if (local->dingo)
-	    iounmap(local->dingo_ccr - 0x0800);
-	pcmcia_release_window(link->win);
-    }
-    pcmcia_release_configuration(link->handle);
-    pcmcia_release_io(link->handle, &link->io);
-    pcmcia_release_irq(link->handle, &link->irq);
-    link->state &= ~DEV_CONFIG;
-
+	if (link->win) {
+		struct net_device *dev = link->priv;
+		local_info_t *local = netdev_priv(dev);
+		if (local->dingo)
+			iounmap(local->dingo_ccr - 0x0800);
+	}
+	pcmcia_disable_device(link->handle);
 } /* xirc2ps_release */
 
 /*====================================================================*/
diff --git a/drivers/net/wireless/airo_cs.c b/drivers/net/wireless/airo_cs.c
index a496460..489ef7f 100644
--- a/drivers/net/wireless/airo_cs.c
+++ b/drivers/net/wireless/airo_cs.c
@@ -429,24 +429,7 @@ static void airo_config(dev_link_t *link
 static void airo_release(dev_link_t *link)
 {
 	DEBUG(0, "airo_release(0x%p)\n", link);
-	
-	/* Unlink the device chain */
-	link->dev = NULL;
-	
-	/*
-	  In a normal driver, additional code may be needed to release
-	  other kernel data structures associated with this device. 
-	*/
-	
-	/* Don't bother checking to see if these succeed or not */
-	if (link->win)
-		pcmcia_release_window(link->win);
-	pcmcia_release_configuration(link->handle);
-	if (link->io.NumPorts1)
-		pcmcia_release_io(link->handle, &link->io);
-	if (link->irq.AssignedIRQ)
-		pcmcia_release_irq(link->handle, &link->irq);
-	link->state &= ~DEV_CONFIG;
+	pcmcia_disable_device(link->handle);
 }
 
 static int airo_suspend(struct pcmcia_device *p_dev)
diff --git a/drivers/net/wireless/atmel_cs.c b/drivers/net/wireless/atmel_cs.c
index d6f4a5a..1da8e61 100644
--- a/drivers/net/wireless/atmel_cs.c
+++ b/drivers/net/wireless/atmel_cs.c
@@ -418,23 +418,14 @@ static void atmel_config(dev_link_t *lin
 static void atmel_release(dev_link_t *link)
 {
 	struct net_device *dev = ((local_info_t*)link->priv)->eth_dev;
-		
+
 	DEBUG(0, "atmel_release(0x%p)\n", link);
-	
-	/* Unlink the device chain */
-	link->dev = NULL;
-	
-	if (dev) 
+
+	if (dev)
 		stop_atmel_card(dev);
-	((local_info_t*)link->priv)->eth_dev = NULL; 
-	
-	/* Don't bother checking to see if these succeed or not */
-	pcmcia_release_configuration(link->handle);
-	if (link->io.NumPorts1)
-		pcmcia_release_io(link->handle, &link->io);
-	if (link->irq.AssignedIRQ)
-		pcmcia_release_irq(link->handle, &link->irq);
-	link->state &= ~DEV_CONFIG;
+	((local_info_t*)link->priv)->eth_dev = NULL;
+
+	pcmcia_disable_device(link->handle);
 }
 
 static int atmel_suspend(struct pcmcia_device *dev)
diff --git a/drivers/net/wireless/hostap/hostap_cs.c b/drivers/net/wireless/hostap/hostap_cs.c
index d335b25..7a1023f 100644
--- a/drivers/net/wireless/hostap/hostap_cs.c
+++ b/drivers/net/wireless/hostap/hostap_cs.c
@@ -804,16 +804,7 @@ static void prism2_release(u_long arg)
 		iface->local->shutdown = 1;
 	}
 
-	if (link->win)
-		pcmcia_release_window(link->win);
-	pcmcia_release_configuration(link->handle);
-	if (link->io.NumPorts1)
-		pcmcia_release_io(link->handle, &link->io);
-	if (link->irq.AssignedIRQ)
-		pcmcia_release_irq(link->handle, &link->irq);
-
-	link->state &= ~DEV_CONFIG;
-
+	pcmcia_disable_device(link->handle);
 	PDEBUG(DEBUG_FLOW, "release - done\n");
 }
 
diff --git a/drivers/net/wireless/netwave_cs.c b/drivers/net/wireless/netwave_cs.c
index 75ce6dd..dfb47ac 100644
--- a/drivers/net/wireless/netwave_cs.c
+++ b/drivers/net/wireless/netwave_cs.c
@@ -869,21 +869,14 @@ failed:
  */
 static void netwave_release(dev_link_t *link)
 {
-    struct net_device *dev = link->priv;
-    netwave_private *priv = netdev_priv(dev);
-
-    DEBUG(0, "netwave_release(0x%p)\n", link);
+	struct net_device *dev = link->priv;
+	netwave_private *priv = netdev_priv(dev);
 
-    /* Don't bother checking to see if these succeed or not */
-    if (link->win) {
-	iounmap(priv->ramBase);
-	pcmcia_release_window(link->win);
-    }
-    pcmcia_release_configuration(link->handle);
-    pcmcia_release_io(link->handle, &link->io);
-    pcmcia_release_irq(link->handle, &link->irq);
+	DEBUG(0, "netwave_release(0x%p)\n", link);
 
-    link->state &= ~DEV_CONFIG;
+	pcmcia_disable_device(link->handle);
+	if (link->win)
+		iounmap(priv->ramBase);
 }
 
 static int netwave_suspend(struct pcmcia_device *p_dev)
diff --git a/drivers/net/wireless/orinoco_cs.c b/drivers/net/wireless/orinoco_cs.c
index ec6f2a4..7fdc4ff 100644
--- a/drivers/net/wireless/orinoco_cs.c
+++ b/drivers/net/wireless/orinoco_cs.c
@@ -416,13 +416,7 @@ orinoco_cs_release(dev_link_t *link)
 	priv->hw_unavailable++;
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	/* Don't bother checking to see if these succeed or not */
-	pcmcia_release_configuration(link->handle);
-	if (link->io.NumPorts1)
-		pcmcia_release_io(link->handle, &link->io);
-	if (link->irq.AssignedIRQ)
-		pcmcia_release_irq(link->handle, &link->irq);
-	link->state &= ~DEV_CONFIG;
+	pcmcia_disable_device(link->handle);
 	if (priv->hw.iobase)
 		ioport_unmap(priv->hw.iobase);
 }				/* orinoco_cs_release */
diff --git a/drivers/net/wireless/spectrum_cs.c b/drivers/net/wireless/spectrum_cs.c
index 5fa6fbe..78320c1 100644
--- a/drivers/net/wireless/spectrum_cs.c
+++ b/drivers/net/wireless/spectrum_cs.c
@@ -894,13 +894,7 @@ spectrum_cs_release(dev_link_t *link)
 	priv->hw_unavailable++;
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	/* Don't bother checking to see if these succeed or not */
-	pcmcia_release_configuration(link->handle);
-	if (link->io.NumPorts1)
-		pcmcia_release_io(link->handle, &link->io);
-	if (link->irq.AssignedIRQ)
-		pcmcia_release_irq(link->handle, &link->irq);
-	link->state &= ~DEV_CONFIG;
+	pcmcia_disable_device(link->handle);
 	if (priv->hw.iobase)
 		ioport_unmap(priv->hw.iobase);
 }				/* spectrum_cs_release */
diff --git a/drivers/net/wireless/wavelan_cs.c b/drivers/net/wireless/wavelan_cs.c
index 98122f3..696aeb9 100644
--- a/drivers/net/wireless/wavelan_cs.c
+++ b/drivers/net/wireless/wavelan_cs.c
@@ -4098,24 +4098,18 @@ wv_pcmcia_config(dev_link_t *	link)
 static void
 wv_pcmcia_release(dev_link_t *link)
 {
-  struct net_device *	dev = (struct net_device *) link->priv;
-  net_local *		lp = netdev_priv(dev);
+	struct net_device *	dev = (struct net_device *) link->priv;
+	net_local *		lp = netdev_priv(dev);
 
 #ifdef DEBUG_CONFIG_TRACE
-  printk(KERN_DEBUG "%s: -> wv_pcmcia_release(0x%p)\n", dev->name, link);
+	printk(KERN_DEBUG "%s: -> wv_pcmcia_release(0x%p)\n", dev->name, link);
 #endif
 
-  /* Don't bother checking to see if these succeed or not */
-  iounmap(lp->mem);
-  pcmcia_release_window(link->win);
-  pcmcia_release_configuration(link->handle);
-  pcmcia_release_io(link->handle, &link->io);
-  pcmcia_release_irq(link->handle, &link->irq);
-
-  link->state &= ~DEV_CONFIG;
+	iounmap(lp->mem);
+	pcmcia_disable_device(link->handle);
 
 #ifdef DEBUG_CONFIG_TRACE
-  printk(KERN_DEBUG "%s: <- wv_pcmcia_release()\n", dev->name);
+	printk(KERN_DEBUG "%s: <- wv_pcmcia_release()\n", dev->name);
 #endif
 }
 
diff --git a/drivers/net/wireless/wl3501_cs.c b/drivers/net/wireless/wl3501_cs.c
index 48e10b0..0c81b3e 100644
--- a/drivers/net/wireless/wl3501_cs.c
+++ b/drivers/net/wireless/wl3501_cs.c
@@ -2149,16 +2149,10 @@ static void wl3501_release(dev_link_t *l
 	struct net_device *dev = link->priv;
 
 	/* Unlink the device chain */
-	if (link->dev) {
+	if (link->dev)
 		unregister_netdev(dev);
-		link->dev = NULL;
-	}
 
-	/* Don't bother checking to see if these succeed or not */
-	pcmcia_release_configuration(link->handle);
-	pcmcia_release_io(link->handle, &link->io);
-	pcmcia_release_irq(link->handle, &link->irq);
-	link->state &= ~DEV_CONFIG;
+	pcmcia_disable_device(link->handle);
 }
 
 static int wl3501_suspend(struct pcmcia_device *p_dev)
diff --git a/drivers/parport/parport_cs.c b/drivers/parport/parport_cs.c
index d0fc8be..7edd7ef 100644
--- a/drivers/parport/parport_cs.c
+++ b/drivers/parport/parport_cs.c
@@ -267,23 +267,17 @@ failed:
 
 void parport_cs_release(dev_link_t *link)
 {
-    parport_info_t *info = link->priv;
-    
-    DEBUG(0, "parport_release(0x%p)\n", link);
-
-    if (info->ndev) {
-	struct parport *p = info->port;
-	parport_pc_unregister_port(p);
-    }
-    info->ndev = 0;
-    link->dev = NULL;
-    
-    pcmcia_release_configuration(link->handle);
-    pcmcia_release_io(link->handle, &link->io);
-    pcmcia_release_irq(link->handle, &link->irq);
-    
-    link->state &= ~DEV_CONFIG;
+	parport_info_t *info = link->priv;
 
+	DEBUG(0, "parport_release(0x%p)\n", link);
+
+	if (info->ndev) {
+		struct parport *p = info->port;
+		parport_pc_unregister_port(p);
+	}
+	info->ndev = 0;
+
+	pcmcia_disable_device(link->handle);
 } /* parport_cs_release */
 
 static int parport_suspend(struct pcmcia_device *dev)
diff --git a/drivers/pcmcia/pcmcia_resource.c b/drivers/pcmcia/pcmcia_resource.c
index dbd5571..555c869 100644
--- a/drivers/pcmcia/pcmcia_resource.c
+++ b/drivers/pcmcia/pcmcia_resource.c
@@ -451,20 +451,20 @@ int pcmcia_release_configuration(struct 
 {
 	pccard_io_map io = { 0, 0, 0, 0, 1 };
 	struct pcmcia_socket *s = p_dev->socket;
+	config_t *c = p_dev->function_config;
 	int i;
 
-	if (!(p_dev->state & CLIENT_CONFIG_LOCKED))
-		return CS_BAD_HANDLE;
-	p_dev->state &= ~CLIENT_CONFIG_LOCKED;
-
-	if (!(p_dev->state & CLIENT_STALE)) {
-		config_t *c = p_dev->function_config;
+	if (p_dev->state & CLIENT_CONFIG_LOCKED) {
+		p_dev->state &= ~CLIENT_CONFIG_LOCKED;
 		if (--(s->lock_count) == 0) {
 			s->socket.flags = SS_OUTPUT_ENA;   /* Is this correct? */
 			s->socket.Vpp = 0;
 			s->socket.io_irq = 0;
 			s->ops->set_socket(s, &s->socket);
 		}
+	}
+	if (c->state & CONFIG_LOCKED) {
+		c->state &= ~CONFIG_LOCKED;
 		if (c->state & CONFIG_IO_REQ)
 			for (i = 0; i < MAX_IO_WIN; i++) {
 				if (!s->io[i].res)
@@ -475,7 +475,6 @@ int pcmcia_release_configuration(struct 
 				io.map = i;
 				s->ops->set_io_map(s, &io);
 			}
-		c->state &= ~CONFIG_LOCKED;
 	}
 
 	return CS_SUCCESS;
@@ -494,22 +493,20 @@ EXPORT_SYMBOL(pcmcia_release_configurati
 int pcmcia_release_io(struct pcmcia_device *p_dev, io_req_t *req)
 {
 	struct pcmcia_socket *s = p_dev->socket;
+	config_t *c = p_dev->function_config;
 
 	if (!(p_dev->state & CLIENT_IO_REQ))
 		return CS_BAD_HANDLE;
+
 	p_dev->state &= ~CLIENT_IO_REQ;
 
-	if (!(p_dev->state & CLIENT_STALE)) {
-		config_t *c = p_dev->function_config;
-		if (c->state & CONFIG_LOCKED)
-			return CS_CONFIGURATION_LOCKED;
-		if ((c->io.BasePort1 != req->BasePort1) ||
-		    (c->io.NumPorts1 != req->NumPorts1) ||
-		    (c->io.BasePort2 != req->BasePort2) ||
-		    (c->io.NumPorts2 != req->NumPorts2))
-			return CS_BAD_ARGS;
-		c->state &= ~CONFIG_IO_REQ;
-	}
+	if ((c->io.BasePort1 != req->BasePort1) ||
+	    (c->io.NumPorts1 != req->NumPorts1) ||
+	    (c->io.BasePort2 != req->BasePort2) ||
+	    (c->io.NumPorts2 != req->NumPorts2))
+		return CS_BAD_ARGS;
+
+	c->state &= ~CONFIG_IO_REQ;
 
 	release_io_space(s, req->BasePort1, req->NumPorts1);
 	if (req->NumPorts2)
@@ -523,22 +520,21 @@ EXPORT_SYMBOL(pcmcia_release_io);
 int pcmcia_release_irq(struct pcmcia_device *p_dev, irq_req_t *req)
 {
 	struct pcmcia_socket *s = p_dev->socket;
+	config_t *c= p_dev->function_config;
+
 	if (!(p_dev->state & CLIENT_IRQ_REQ))
 		return CS_BAD_HANDLE;
 	p_dev->state &= ~CLIENT_IRQ_REQ;
 
-	if (!(p_dev->state & CLIENT_STALE)) {
-		config_t *c= p_dev->function_config;
-		if (c->state & CONFIG_LOCKED)
-			return CS_CONFIGURATION_LOCKED;
-		if (c->irq.Attributes != req->Attributes)
-			return CS_BAD_ATTRIBUTE;
-		if (s->irq.AssignedIRQ != req->AssignedIRQ)
-			return CS_BAD_IRQ;
-		if (--s->irq.Config == 0) {
-			c->state &= ~CONFIG_IRQ_REQ;
-			s->irq.AssignedIRQ = 0;
-		}
+	if (c->state & CONFIG_LOCKED)
+		return CS_CONFIGURATION_LOCKED;
+	if (c->irq.Attributes != req->Attributes)
+		return CS_BAD_ATTRIBUTE;
+	if (s->irq.AssignedIRQ != req->AssignedIRQ)
+		return CS_BAD_IRQ;
+	if (--s->irq.Config == 0) {
+		c->state &= ~CONFIG_IRQ_REQ;
+		s->irq.AssignedIRQ = 0;
 	}
 
 	if (req->Attributes & IRQ_HANDLE_PRESENT) {
@@ -929,3 +925,18 @@ int pcmcia_request_window(struct pcmcia_
 	return CS_SUCCESS;
 } /* pcmcia_request_window */
 EXPORT_SYMBOL(pcmcia_request_window);
+
+void pcmcia_disable_device(struct pcmcia_device *p_dev) {
+	if (!p_dev->instance)
+		return;
+
+	pcmcia_release_configuration(p_dev);
+	pcmcia_release_io(p_dev, &p_dev->instance->io);
+	pcmcia_release_irq(p_dev, &p_dev->instance->irq);
+	if (&p_dev->instance->win)
+		pcmcia_release_window(p_dev->instance->win);
+
+	p_dev->instance->dev = NULL;
+	p_dev->instance->state &= ~DEV_CONFIG;
+}
+EXPORT_SYMBOL(pcmcia_disable_device);
diff --git a/drivers/scsi/pcmcia/aha152x_stub.c b/drivers/scsi/pcmcia/aha152x_stub.c
index 5609847..e7f9d26 100644
--- a/drivers/scsi/pcmcia/aha152x_stub.c
+++ b/drivers/scsi/pcmcia/aha152x_stub.c
@@ -248,13 +248,7 @@ static void aha152x_release_cs(dev_link_
 	scsi_info_t *info = link->priv;
 
 	aha152x_release(info->host);
-	link->dev = NULL;
-    
-	pcmcia_release_configuration(link->handle);
-	pcmcia_release_io(link->handle, &link->io);
-	pcmcia_release_irq(link->handle, &link->irq);
-    
-	link->state &= ~DEV_CONFIG;
+	pcmcia_disable_device(link->handle);
 }
 
 static int aha152x_suspend(struct pcmcia_device *dev)
diff --git a/drivers/scsi/pcmcia/fdomain_stub.c b/drivers/scsi/pcmcia/fdomain_stub.c
index 788c58d..fb7221c 100644
--- a/drivers/scsi/pcmcia/fdomain_stub.c
+++ b/drivers/scsi/pcmcia/fdomain_stub.c
@@ -209,20 +209,13 @@ cs_failed:
 
 static void fdomain_release(dev_link_t *link)
 {
-    scsi_info_t *info = link->priv;
+	scsi_info_t *info = link->priv;
 
-    DEBUG(0, "fdomain_release(0x%p)\n", link);
+	DEBUG(0, "fdomain_release(0x%p)\n", link);
 
-    scsi_remove_host(info->host);
-    link->dev = NULL;
-    
-    pcmcia_release_configuration(link->handle);
-    pcmcia_release_io(link->handle, &link->io);
-    pcmcia_release_irq(link->handle, &link->irq);
-
-    scsi_unregister(info->host);
-
-    link->state &= ~DEV_CONFIG;
+	scsi_remove_host(info->host);
+	pcmcia_disable_device(link->handle);
+	scsi_unregister(info->host);
 }
 
 /*====================================================================*/
diff --git a/drivers/scsi/pcmcia/nsp_cs.c b/drivers/scsi/pcmcia/nsp_cs.c
index 9e3ab3f..dd383c5 100644
--- a/drivers/scsi/pcmcia/nsp_cs.c
+++ b/drivers/scsi/pcmcia/nsp_cs.c
@@ -1974,16 +1974,9 @@ static void nsp_cs_release(dev_link_t *l
 		if (data != NULL) {
 			iounmap((void *)(data->MmioAddress));
 		}
-		pcmcia_release_window(link->win);
 	}
-	pcmcia_release_configuration(link->handle);
-	if (link->io.NumPorts1) {
-		pcmcia_release_io(link->handle, &link->io);
-	}
-	if (link->irq.AssignedIRQ) {
-		pcmcia_release_irq(link->handle, &link->irq);
-	}
-	link->state &= ~DEV_CONFIG;
+	pcmcia_disable_device(link->handle);
+
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,2))
 	if (info->host != NULL) {
 		scsi_host_put(info->host);
diff --git a/drivers/scsi/pcmcia/qlogic_stub.c b/drivers/scsi/pcmcia/qlogic_stub.c
index dce7e68..70269fc 100644
--- a/drivers/scsi/pcmcia/qlogic_stub.c
+++ b/drivers/scsi/pcmcia/qlogic_stub.c
@@ -289,6 +289,7 @@ out:
 cs_failed:
 	cs_error(link->handle, last_fn, last_ret);
 	link->dev = NULL;
+
 	pcmcia_release_configuration(link->handle);
 	pcmcia_release_io(link->handle, &link->io);
 	pcmcia_release_irq(link->handle, &link->irq);
@@ -306,17 +307,11 @@ static void qlogic_release(dev_link_t *l
 	DEBUG(0, "qlogic_release(0x%p)\n", link);
 
 	scsi_remove_host(info->host);
-	link->dev = NULL;
 
 	free_irq(link->irq.AssignedIRQ, info->host);
-
-	pcmcia_release_configuration(link->handle);
-	pcmcia_release_io(link->handle, &link->io);
-	pcmcia_release_irq(link->handle, &link->irq);
+	pcmcia_disable_device(link->handle);
 
 	scsi_host_put(info->host);
-
-	link->state &= ~DEV_CONFIG;
 }
 
 /*====================================================================*/
diff --git a/drivers/scsi/pcmcia/sym53c500_cs.c b/drivers/scsi/pcmcia/sym53c500_cs.c
index 3a4dd6f..42d002b 100644
--- a/drivers/scsi/pcmcia/sym53c500_cs.c
+++ b/drivers/scsi/pcmcia/sym53c500_cs.c
@@ -550,13 +550,7 @@ SYM53C500_release(dev_link_t *link)
 	if (shost->io_port && shost->n_io_port)
 		release_region(shost->io_port, shost->n_io_port);
 
-	link->dev = NULL;
-
-	pcmcia_release_configuration(link->handle);
-	pcmcia_release_io(link->handle, &link->io);
-	pcmcia_release_irq(link->handle, &link->irq);
-
-	link->state &= ~DEV_CONFIG;
+	pcmcia_disable_device(link->handle);
 
 	scsi_host_put(shost);
 } /* SYM53C500_release */
diff --git a/drivers/serial/serial_cs.c b/drivers/serial/serial_cs.c
index 2307d94..ff38820 100644
--- a/drivers/serial/serial_cs.c
+++ b/drivers/serial/serial_cs.c
@@ -141,11 +141,8 @@ static void serial_remove(dev_link_t *li
 
 		info->link.dev = NULL;
 
-		if (!info->slave) {
-			pcmcia_release_configuration(info->link.handle);
-			pcmcia_release_io(info->link.handle, &info->link.io);
-			pcmcia_release_irq(info->link.handle, &info->link.irq);
-		}
+		if (!info->slave)
+			pcmcia_disable_device(link->handle);
 
 		info->link.state &= ~DEV_CONFIG;
 	}
diff --git a/include/pcmcia/cs.h b/include/pcmcia/cs.h
index eda32a5..a5d8df2 100644
--- a/include/pcmcia/cs.h
+++ b/include/pcmcia/cs.h
@@ -392,6 +392,8 @@ int pcmcia_eject_card(struct pcmcia_sock
 int pcmcia_insert_card(struct pcmcia_socket *skt);
 int pccard_reset_card(struct pcmcia_socket *skt);
 
+void pcmcia_disable_device(struct pcmcia_device *p_dev);
+
 struct pcmcia_socket * pcmcia_get_socket(struct pcmcia_socket *skt);
 void pcmcia_put_socket(struct pcmcia_socket *skt);
 
diff --git a/sound/pcmcia/pdaudiocf/pdaudiocf.c b/sound/pcmcia/pdaudiocf/pdaudiocf.c
index 77caf43..a2d3eb4 100644
--- a/sound/pcmcia/pdaudiocf/pdaudiocf.c
+++ b/sound/pcmcia/pdaudiocf/pdaudiocf.c
@@ -62,13 +62,7 @@ static void snd_pdacf_detach(struct pcmc
 
 static void pdacf_release(dev_link_t *link)
 {
-	if (link->state & DEV_CONFIG) {
-		/* release cs resources */
-		pcmcia_release_configuration(link->handle);
-		pcmcia_release_io(link->handle, &link->io);
-		pcmcia_release_irq(link->handle, &link->irq);
-		link->state &= ~DEV_CONFIG;
-	}
+	pcmcia_disable_device(link->handle);
 }
 
 /*
diff --git a/sound/pcmcia/vx/vxpocket.c b/sound/pcmcia/vx/vxpocket.c
index 66900d2..9278874 100644
--- a/sound/pcmcia/vx/vxpocket.c
+++ b/sound/pcmcia/vx/vxpocket.c
@@ -61,13 +61,7 @@ static unsigned int card_alloc;
  */
 static void vxpocket_release(dev_link_t *link)
 {
-	if (link->state & DEV_CONFIG) {
-		/* release cs resources */
-		pcmcia_release_configuration(link->handle);
-		pcmcia_release_io(link->handle, &link->io);
-		pcmcia_release_irq(link->handle, &link->irq);
-		link->state &= ~DEV_CONFIG;
-	}
+	pcmcia_disable_device(link->handle);
 }
 
 /*
-- 
1.2.4

