Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265087AbUFAOVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265087AbUFAOVs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 10:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUFAOVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 10:21:33 -0400
Received: from pD952C7EB.dip.t-dialin.net ([217.82.199.235]:15054 "EHLO
	router.zodiac.dnsalias.org") by vger.kernel.org with ESMTP
	id S265068AbUFAOUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 10:20:08 -0400
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: David Brownell <david-b@pacbell.net>
Subject: Re: fixing usb suspend/resuming
Date: Tue, 1 Jun 2004 16:14:32 +0200
User-Agent: KMail/1.6.2
References: <200405281406.10447@zodiac.zodiac.dnsalias.org> <40B74FC2.8000708@pacbell.net>
In-Reply-To: <40B74FC2.8000708@pacbell.net>
X-Ignorant-User: yes
MIME-Version: 1.0
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org
Message-Id: <200406011614.32726@zodiac.zodiac.dnsalias.org>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_I9IvAsBP0f3MfN+"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_I9IvAsBP0f3MfN+
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Freitag, 28. Mai 2004 16:42 schrieben Sie:
> If you have, then where's your patch?  :)

attached ;) (I hope this is correctly inlined now. If not I think I have to 
patch kmail first...)

> What kernel?

2.6.7-rc1-mm1

> > I think you'd need to include a
> > pci_save_state, pci_disable_device, pci_set_power_state
> > before suspending and
> > pci_set_state, pci_enable_device, (pci_set_power_state?)
> > while resuming.
>
> Odd, that's what I see drivers/usb/core/hcd-pci.c doing right now.

[Urgs] I didn't look there....

However I just debugged a bit more:
My uhci's do not support PM at all, so i disabled the uhci driver.
(The ehci does, however I don't know how windows handles suspend then...).
When I want acpi to go to S3 (echo 3 > /proc/acpi/sleep), the driver want's to 
enter S2, which the device does not support:
Stopping tasks: 
===================================================================|
radeonfb: suspending to state: 2...
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 0x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 0x mode
ehci_hcd 0000:00:1d.7: suspend D0 --> D2
ehci_hcd 0000:00:1d.7: PCI suspend fail, -5
ehci_hcd 0000:00:1d.7: resume from state D0

This seems to be an acpi problem. I'm no acpi god, and no idea how it works. I 
found that every call before acpi has state 3, every afterwards has state 2.

However, even when the driver is put to S3, it is not resumed afterwards, as 
it fiddles around with dev->power.power_state. 
drivers/base/power/resume.c:dpm_resume doe not resume it, then.
Additionally I suppose, there is a pci_enable_device missing in the resume 
code (See patch below).
I removed the power_state code, and added pci_enable_device. The driver 
survives a resume now, but the handshakes fail afterwards (even after reload 
the module). Dunno why ;( ?
At Least suspend-to-disk (pmdisk) works.



-- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291



--Boundary-00=_I9IvAsBP0f3MfN+
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="usb_suspend-resume.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="usb_suspend-resume.patch"

diff -rpu linux-2.6.7-rc1-mm1/drivers/usb/core/hcd-pci.c linux-2.6.7-rc1-ag1/drivers/usb/core/hcd-pci.c
--- linux-2.6.7-rc1-mm1/drivers/usb/core/hcd-pci.c	2004-05-23 07:54:17.000000000 +0200
+++ linux-2.6.7-rc1-ag1/drivers/usb/core/hcd-pci.c	2004-05-29 18:08:32.000000000 +0200
@@ -318,7 +318,7 @@ int usb_hcd_pci_suspend (struct pci_dev 
 			
 			if (has_pci_pm)
 				retval = pci_set_power_state (dev, state);
-			dev->dev.power.power_state = state;
+			
 			if (retval < 0) {
 				dev_dbg (&dev->dev,
 						"PCI suspend fail, %d\n",
@@ -344,6 +344,7 @@ int usb_hcd_pci_resume (struct pci_dev *
 	int			has_pci_pm;
 
 	hcd = pci_get_drvdata(dev);
+	pci_restore_state(dev,hcd->pci_state);
 	has_pci_pm = pci_find_capability(dev, PCI_CAP_ID_PM);
 	if (has_pci_pm)
 		dev_dbg(hcd->self.controller, "resume from state D%d\n",
@@ -357,8 +358,8 @@ int usb_hcd_pci_resume (struct pci_dev *
 	hcd->state = USB_STATE_RESUMING;
 
 	if (has_pci_pm)
-		pci_set_power_state (dev, 0);
-	dev->dev.power.power_state = 0;
+		pci_enable_device(dev);
+
 	retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
 				hcd->description, hcd);
 	if (retval < 0) {
@@ -367,7 +368,6 @@ int usb_hcd_pci_resume (struct pci_dev *
 		return retval;
 	}
 	pci_set_master (dev);
-	pci_restore_state (dev, hcd->pci_state);
 #ifdef	CONFIG_USB_SUSPEND
 	pci_enable_wake (dev, dev->current_state, 0);
 	pci_enable_wake (dev, 4, 0);
diff -rpu linux-2.6.7-rc1-mm1/drivers/usb/host/ehci-hcd.c linux-2.6.7-rc1-ag1/drivers/usb/host/ehci-hcd.c
--- linux-2.6.7-rc1-mm1/drivers/usb/host/ehci-hcd.c	2004-05-23 07:54:22.000000000 +0200
+++ linux-2.6.7-rc1-ag1/drivers/usb/host/ehci-hcd.c	2004-05-29 18:08:59.000000000 +0200
@@ -662,8 +662,6 @@ static int ehci_resume (struct usb_hcd *
 	/* FIXME lock root hub */
 	retval = ehci_hub_resume (hcd);
 #endif
-	if (retval == 0)
-		hcd->self.controller->power.power_state = 0;
 	return retval;
 }
 
diff -rpu linux-2.6.7-rc1-mm1/drivers/usb/host/ehci-hub.c linux-2.6.7-rc1-ag1/drivers/usb/host/ehci-hub.c
--- linux-2.6.7-rc1-mm1/drivers/usb/host/ehci-hub.c	2004-05-23 07:55:01.000000000 +0200
+++ linux-2.6.7-rc1-ag1/drivers/usb/host/ehci-hub.c	2004-05-29 18:10:37.000000000 +0200
@@ -33,12 +33,9 @@
 static int ehci_hub_suspend (struct usb_hcd *hcd)
 {
 	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
-	struct usb_device	*root = hcd_to_bus (&ehci->hcd)->root_hub;
 	int			port;
 	int			status = 0;
 
-	if (root->dev.power.power_state != 0)
-		return 0;
 	if (time_before (jiffies, ehci->next_statechange))
 		return -EAGAIN;
 
@@ -74,7 +71,6 @@ static int ehci_hub_suspend (struct usb_
 	ehci_work (ehci, 0);
 	(void) handshake (&ehci->regs->status, STS_HALT, STS_HALT, 2000);
 
-	root->dev.power.power_state = 3;
 	ehci->next_statechange = jiffies + msecs_to_jiffies(10);
 	spin_unlock_irq (&ehci->lock);
 	return status;
@@ -89,8 +85,6 @@ static int ehci_hub_resume (struct usb_h
 	u32			temp;
 	int			i;
 
-	if (!root->dev.power.power_state)
-		return 0;
 	if (time_before (jiffies, ehci->next_statechange))
 		return -EAGAIN;
 
@@ -138,7 +132,6 @@ static int ehci_hub_resume (struct usb_h
 	if (temp)
 		writel (ehci->command | temp, &ehci->regs->command);
 
-	root->dev.power.power_state = 0;
 	ehci->next_statechange = jiffies + msecs_to_jiffies(5);
 	ehci->hcd.state = USB_STATE_RUNNING;
 	return 0;

--Boundary-00=_I9IvAsBP0f3MfN+--
