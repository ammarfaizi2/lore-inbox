Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291401AbSBHEZa>; Thu, 7 Feb 2002 23:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291402AbSBHEZL>; Thu, 7 Feb 2002 23:25:11 -0500
Received: from topic-gw2.topic.com.au ([203.37.31.2]:30712 "EHLO
	mailhost.topic.com.au") by vger.kernel.org with ESMTP
	id <S291401AbSBHEZH>; Thu, 7 Feb 2002 23:25:07 -0500
Date: Fri, 8 Feb 2002 15:25:02 +1100
From: Jason Thomas <jason@topic.com.au>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Linux-kernel] Re: Linux 2.4.18-pre9
Message-ID: <20020208042502.GA1797@topic.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jeff Garzik wrote:
> Simon Turvey wrote:
> > > Can you tell me if the final 2.4.18 will solve the problems with recent
> > binutils?  Or is the onus on the binutils maintainer to fix this?
>
> What driver are you having problems with?

how about bttv and usb-uhci, both of which I've sent patches for multiple times.

> 
> Typically this problem is solved by a one-line fix to a specific driver,
> in 2.4.x.
> 
> 	Jeff


diff -Naur linux-2.4.18-pre7-ac1.orig/drivers/media/video/bttv-driver.c linux-2.4.18-pre7-ac1/drivers/media/video/bttv-driver.c
--- linux-2.4.18-pre7-ac1.orig/drivers/media/video/bttv-driver.c	Sat Dec 22 13:39:39 2001
+++ linux-2.4.18-pre7-ac1/drivers/media/video/bttv-driver.c	Wed Jan 30 15:23:48 2002
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
diff -Naur linux-2.4.18-pre7-ac1.orig/drivers/usb/usb-uhci.c linux-2.4.18-pre7-ac1/drivers/usb/usb-uhci.c
--- linux-2.4.18-pre7-ac1.orig/drivers/usb/usb-uhci.c	Sat Dec 22 13:39:39 2001
+++ linux-2.4.18-pre7-ac1/drivers/usb/usb-uhci.c	Wed Jan 30 15:23:48 2002
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
 
