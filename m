Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262740AbVAVVDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbVAVVDK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 16:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbVAVVAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 16:00:39 -0500
Received: from gprs214-39.eurotel.cz ([160.218.214.39]:18052 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262752AbVAVUxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 15:53:31 -0500
Date: Sat, 22 Jan 2005 21:53:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: driver model: more pci_choose_state()s are needed
Message-ID: <20050122205310.GA1461@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

During my conversion, I discovered two more places where
pci_choose_state is needed to preserve type information. Code should
be equivalent, because we only pass 0 or 3 in "state"
parameter. Please apply,

								Pavel

--- clean/drivers/net/tg3.c	2005-01-22 21:24:52.000000000 +0100
+++ linux-delme/drivers/net/tg3.c	2005-01-22 21:44:19.000000000 +0100
@@ -8475,7 +8475,7 @@
 	spin_unlock(&dev->xmit_lock);
 	spin_unlock_irq(&tp->lock);
 
-	err = tg3_set_power_state(tp, state);
+	err = tg3_set_power_state(tp, pci_choose_state(pdev, state));
 	if (err) {
 		spin_lock_irq(&tp->lock);
 		spin_lock(&dev->xmit_lock);
--- clean/drivers/usb/core/hcd-pci.c	2005-01-12 11:07:40.000000000 +0100
+++ linux-delme/drivers/usb/core/hcd-pci.c	2005-01-22 21:44:19.000000000 +0100
@@ -274,11 +274,12 @@
  *
  * Store this function in the HCD's struct pci_driver as suspend().
  */
-int usb_hcd_pci_suspend (struct pci_dev *dev, u32 state)
+int usb_hcd_pci_suspend (struct pci_dev *dev, pm_message_t pmsg)
 {
 	struct usb_hcd		*hcd;
 	int			retval = 0;
 	int			has_pci_pm;
+	pci_power_t		state;
 
 	hcd = pci_get_drvdata(dev);
 
@@ -287,8 +288,10 @@
 	 * PM-sensitive HCDs may already have done this.
 	 */
 	has_pci_pm = pci_find_capability(dev, PCI_CAP_ID_PM);
-	if (state > 4)
-		state = 4;
+
+	state = pci_choose_state(dev, pmsg);
+	if (state > PCI_D3cold)
+		state = PCI_D3cold;
 
 	switch (hcd->state) {
 
@@ -396,7 +399,7 @@
 
 	if (has_pci_pm)
 		pci_set_power_state (dev, 0);
-	dev->dev.power.power_state = 0;
+	dev->dev.power.power_state = PMSG_ON;
 	retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
 				hcd->driver->description, hcd);
 	if (retval < 0) {

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
