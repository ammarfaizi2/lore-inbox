Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269001AbUIMWGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269001AbUIMWGv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 18:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268993AbUIMWGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 18:06:51 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:52700 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S269008AbUIMWGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 18:06:35 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Kevin Fenzi <kevin-linux-kernel@scrye.com>
Subject: Re: FYI: my current bigdiff
Date: Mon, 13 Sep 2004 16:06:32 -0600
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz
References: <20040909134421.GA12204@elf.ucw.cz> <20040910041320.DF700E7504@voldemort.scrye.com>
In-Reply-To: <20040910041320.DF700E7504@voldemort.scrye.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409131606.32741.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 September 2004 10:13 pm, Kevin Fenzi wrote:
> After booting with the pci=routeirq as suggested wireless and usb
> played nice on suspend resume again.

Kevin, can you try the attached patch, please?

===== drivers/pcmcia/yenta_socket.c 1.59 vs edited =====
--- 1.59/drivers/pcmcia/yenta_socket.c	2004-08-22 08:39:15 -06:00
+++ edited/drivers/pcmcia/yenta_socket.c	2004-09-13 16:01:48 -06:00
@@ -1036,11 +1036,17 @@
 static int yenta_dev_resume (struct pci_dev *dev)
 {
 	struct yenta_socket *socket = pci_get_drvdata(dev);
+	int ret;
 
 	if (socket) {
-		pci_set_power_state(dev, 0);
 		/* FIXME: pci_restore_state needs to have a better interface */
 		pci_restore_state(dev, socket->saved_state);
+		ret = pci_enable_device(dev);
+		if (ret < 0) {
+			printk(KERN_ERR "yenta %s: couldn't enable device (%d)\n",
+				pci_name(dev), ret);
+			return ret;
+		}
 		pci_write_config_dword(dev, 16*4, socket->saved_state[16]);
 		pci_write_config_dword(dev, 17*4, socket->saved_state[17]);
 
===== drivers/usb/core/hcd-pci.c 1.33 vs edited =====
--- 1.33/drivers/usb/core/hcd-pci.c	2004-06-30 11:06:30 -06:00
+++ edited/drivers/usb/core/hcd-pci.c	2004-09-13 15:54:54 -06:00
@@ -354,8 +354,14 @@
 	}
 	hcd->state = USB_STATE_RESUMING;
 
-	if (has_pci_pm)
-		pci_set_power_state (dev, 0);
+	pci_restore_state (dev, hcd->pci_state);
+	retval = pci_enable_device (dev);
+	if (retval < 0) {
+		dev_err (hcd->self.controller, "can't enable device! (%d)\n",
+				retval);
+		return retval;
+	}
+
 	dev->dev.power.power_state = 0;
 	retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
 				hcd->description, hcd);
@@ -365,7 +371,6 @@
 		return retval;
 	}
 	pci_set_master (dev);
-	pci_restore_state (dev, hcd->pci_state);
 #ifdef	CONFIG_USB_SUSPEND
 	pci_enable_wake (dev, dev->current_state, 0);
 	pci_enable_wake (dev, 4, 0);
