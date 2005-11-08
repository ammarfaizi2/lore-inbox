Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbVKHQg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbVKHQg6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 11:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVKHQg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 11:36:58 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:30889 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932493AbVKHQg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 11:36:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=dtRRRGf1P0Qah33CeZxwzjlowE1jX4ac4xoENYJoLvp7sM8lfI7n04LJ7lg795F/1Yk+wqfvaYGppNMnhYUrP0HIY+ICINrOJQzjtrjvTnZSHon1yD+FRq53C+ffkvBZGVu1ocDBIl9wzVDDgwHyvH8VFvzS5WA9SlpsB2uMxQU=
Message-ID: <4370D423.1000405@gmail.com>
Date: Tue, 08 Nov 2005 17:36:51 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051027)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: pavel@ucw.cz
CC: shaohua.li@intel.com, "Kernel, " <linux-kernel@vger.kernel.org>,
       akpm@osdl.org, stern@rowland.harvard.edu
Subject: [FORWARED PATCH] pci-usb suspend fix (was:  2.6.14-git4 suspend fails:
 kernel NULL pointer dereference)
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry i had some problems with hd, but could recover the patch.

NOTICE:
patch is by Alan Stern and not Len Brown (as i told in previous mails)

Alan told me the problem is with usb controllorer not supporting suspend
functions.

i'm not the author, it's forwarded only.

Sorry for problems and email flood.

Patrizio Bassi 


--- a/drivers/usb/core/hcd-pci.c	Tue Sep 13 13:06:21 2005
+++ b/drivers/usb/core/hcd-pci.c	Sat Sep 24 10:30:56 2005
@@ -232,6 +232,10 @@
 		hcd->state = HC_STATE_SUSPENDED;
 		/* FALLTHROUGH */
 
+	/* entry for controllers that have died and been reset */
+	case HC_STATE_HALT:
+		/* FALLTHROUGH */
+
 	/* entry with CONFIG_USB_SUSPEND, or hcds that autosuspend: the
 	 * controller and/or root hub will already have been suspended,
 	 * but it won't be ready for a PCI resume call.
@@ -259,11 +263,20 @@
 		 */
 		retval = pci_set_power_state (dev, PCI_D3hot);
 		if (retval == 0) {
+			int	rc;
+			int	wakeup = hcd->remote_wakeup;
+
 			dev_dbg (hcd->self.controller, "--> PCI D3\n");
-			retval = pci_enable_wake (dev, PCI_D3hot, hcd->remote_wakeup);
-			if (retval)
-				break;
-			retval = pci_enable_wake (dev, PCI_D3cold, hcd->remote_wakeup);
+			rc = pci_enable_wake (dev, PCI_D3hot, wakeup);
+			if (rc && wakeup)
+				dev_warn(&dev->dev, "Unable to activate "
+						"remote wakeup from %d: %d\n",
+						PCI_D3hot, rc);
+			rc = pci_enable_wake (dev, PCI_D3cold, wakeup);
+			if (rc && wakeup)
+				dev_warn(&dev->dev, "Unable to activate "
+						"remote wakeup from %d: %d\n",
+						PCI_D3cold, rc);
 		} else if (retval < 0) {
 			dev_dbg (&dev->dev, "PCI D3 suspend fail, %d\n",
 					retval);
@@ -298,7 +311,8 @@
 	int			retval;
 
 	hcd = pci_get_drvdata(dev);
-	if (hcd->state != HC_STATE_SUSPENDED) {
+	if (hcd->state != HC_STATE_SUSPENDED &&
+			hcd->state != HC_STATE_HALT) {
 		dev_dbg (hcd->self.controller, 
 				"can't resume, not suspended!\n");
 		return 0;
@@ -312,6 +326,7 @@
 #ifdef	DEBUG
 		int	pci_pm;
 		u16	pmcr;
+		int	rc;
 
 		pci_pm = pci_find_capability(dev, PCI_CAP_ID_PM);
 		pci_read_config_word(dev, pci_pm + PCI_PM_CTRL, &pmcr);
@@ -337,19 +352,17 @@
 				dev->current_state);
 		}
 #endif
-		retval = pci_enable_wake (dev, dev->current_state, 0);
-		if (retval) {
-			dev_err(hcd->self.controller,
-				"can't enable_wake to %d, %d!\n",
-				dev->current_state, retval);
-			return retval;
-		}
-		retval = pci_enable_wake (dev, PCI_D3cold, 0);
-		if (retval) {
-			dev_err(hcd->self.controller,
-				"can't enable_wake to %d, %d!\n",
-				PCI_D3cold, retval);
-			return retval;
+		rc = pci_enable_wake (dev, dev->current_state, 0);
+		if (rc)
+			dev_warn(hcd->self.controller,
+				"can't disable wake from %d, %d!\n",
+				dev->current_state, rc);
+		if (dev->current_state != PCI_D3cold) {
+			rc = pci_enable_wake (dev, PCI_D3cold, 0);
+			if (rc)
+				dev_warn(hcd->self.controller,
+					"can't disable wake from %d, %d!\n",
+					PCI_D3cold, rc);
 		}
 	} else {
 		/* Same basic cases: clean (powered/not), dirty */
@@ -372,7 +385,8 @@
 
 	dev->dev.power.power_state = PMSG_ON;
 
-	hcd->state = HC_STATE_RESUMING;
+	if (hcd->state == HC_STATE_SUSPENDED)
+		hcd->state = HC_STATE_RESUMING;
 	hcd->saw_irq = 0;
 	retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
 				hcd->irq_descr, hcd);

