Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288789AbSAIEmc>; Tue, 8 Jan 2002 23:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288790AbSAIEmX>; Tue, 8 Jan 2002 23:42:23 -0500
Received: from topic-gw2.topic.com.au ([203.37.31.2]:21500 "EHLO
	mailhost.topic.com.au") by vger.kernel.org with ESMTP
	id <S288789AbSAIEmI>; Tue, 8 Jan 2002 23:42:08 -0500
Date: Wed, 9 Jan 2002 15:40:47 +1100
From: Jason Thomas <jason@topic.com.au>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] link errors with internal calls to devexit functions
Message-ID: <20020109044047.GF699@topic.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, Heres my second attempt at a patch to fix these compile time
issues can you check it over and possibly include it in your next
release.

diff -ur linux-2.4.18-pre2.orig/drivers/media/video/bttv-driver.c linux-2.4.18-pre2/drivers/media/video/bttv-driver.c
--- linux-2.4.18-pre2.orig/drivers/media/video/bttv-driver.c	Sat Dec 22 13:39:39 2001
+++ linux-2.4.18-pre2/drivers/media/video/bttv-driver.c	Wed Jan  9 13:25:18 2002
@@ -2820,11 +2820,10 @@
  *	Scan for a Bt848 card, request the irq and map the io memory 
  */
 
-static void __devexit bttv_remove(struct pci_dev *pci_dev)
+static void bttv_remove_card(struct bttv *btv)
 {
         u8 command;
         int j;
-        struct bttv *btv = pci_get_drvdata(pci_dev);
 
 	if (bttv_verbose)
 		printk("bttv%d: unloading\n",btv->nr);
@@ -2890,10 +2889,18 @@
         btv->shutdown=1;
         wake_up(&btv->gpioq);
 
-	pci_set_drvdata(pci_dev, NULL);
         return;
 }
 
+static void __devexit bttv_remove(struct pci_dev *pci_dev)
+{
+        struct bttv *btv = pci_get_drvdata(pci_dev);
+		
+	if (btv) {
+		bttv_remove_card(btv);
+		pci_set_drvdata(pci_dev, NULL);
+	}
+}
 
 static int __devinit bttv_probe(struct pci_dev *dev, const struct pci_device_id *pci_id)
 {
@@ -2992,7 +2999,7 @@
 	pci_set_drvdata(dev,btv);
 
 	if(init_bt848(btv) < 0) {
-		bttv_remove(dev);
+		bttv_remove_card(btv);
 		return -EIO;
 	}
 	bttv_num++;
diff -ur linux-2.4.18-pre2.orig/drivers/usb/usb-uhci.c linux-2.4.18-pre2/drivers/usb/usb-uhci.c
--- linux-2.4.18-pre2.orig/drivers/usb/usb-uhci.c	Sat Dec 22 13:39:39 2001
+++ linux-2.4.18-pre2/drivers/usb/usb-uhci.c	Wed Jan  9 14:11:19 2002
@@ -2845,10 +2845,9 @@
 	s->running = 1;
 }
 
-_static void __devexit
-uhci_pci_remove (struct pci_dev *dev)
+_static void
+uhci_pci_remove_card (uhci_t *s)
 {
-	uhci_t *s = pci_get_drvdata(dev);
 	struct usb_device *root_hub = s->bus->root_hub;
 
 	s->running = 0;		    // Don't allow submit_urb
@@ -2868,7 +2867,17 @@
 	free_irq (s->irq, s);
 	usb_free_bus (s->bus);
 	cleanup_skel (s);
-	kfree (s);
+}
+
+_static void __devexit
+uhci_pci_remove (struct pci_dev *dev)
+{
+	uhci_t *s = pci_get_drvdata(dev);
+	
+	if (s) {
+		uhci_pci_remove_card(s);
+		kfree (s);
+	}
 }
 
 _static int __init uhci_start_usb (uhci_t *s)
@@ -3001,7 +3010,8 @@
 	s->irq = irq;
 
 	if(uhci_start_usb (s) < 0) {
-		uhci_pci_remove(dev);
+		uhci_pci_remove_card(s);
+		kfree(s);
 		return -1;
 	}
 
