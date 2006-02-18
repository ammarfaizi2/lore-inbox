Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWBRCEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWBRCEF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 21:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWBRCEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 21:04:02 -0500
Received: from digitalimplant.org ([64.62.235.95]:7364 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S1750723AbWBRCDz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 21:03:55 -0500
Date: Fri, 17 Feb 2006 18:03:49 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: greg@kroah.com, "" <torvalds@osdl.org>, "" <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, "" <linux-pm@osdl.org>
Subject: [PATCH 5/5] [pci pm] Make pci_choose_state() use the real device
 state requested
Message-ID: <Pine.LNX.4.50.0602171759190.30811-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- Look at pm_message_t::state (along with the message event type) to
determine the PCI power state to return. This allows all of the PCI
power states to be used with this helper (and with the sysfs runtime
PM interface).

[ Previously, the returned value was limited to PCI_D0 or PCI_D3hot
depending on whether PM_EVENT_ON or PM_EVENT_{FREEZE,SUSPEND} were
specified. ]

- Print an error w/ device info when we get an invalid state; use
  WARN_ON() instead of BUG(), so we don't needlessly crash a machine.

- Print state translation when debug is enabled.

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/pci/pci.c |   29 +++++++++++++++++++----------
 1 files changed, 19 insertions(+), 10 deletions(-)

applies-to: 7b4d08b2816a4aefc2b9891091e6a790526ea15e
8a658ba724d1f1e71fc951745e091aa1afa4ff6f
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d2d1879..2f160aa 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -404,30 +404,39 @@ int (*platform_pci_choose_state)(struct
  * message.
  */

-pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
+pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t msg)
 {
+	pci_power_t state = PCI_D3hot;
 	int ret;

 	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
 		return PCI_D0;

 	if (platform_pci_choose_state) {
-		ret = platform_pci_choose_state(dev, state);
+		ret = platform_pci_choose_state(dev, msg);
 		if (ret >= 0)
-			state.event = ret;
+			msg.state = ret;
 	}

-	switch (state.event) {
+	switch (msg.event) {
 	case PM_EVENT_ON:
-		return PCI_D0;
+		state = PCI_D0;
+		break;
 	case PM_EVENT_FREEZE:
 	case PM_EVENT_SUSPEND:
-		return PCI_D3hot;
+		if (msg.state && msg.state <= PCI_D3hot)
+			state = msg.state;
+		break;
 	default:
-		printk("They asked me for state %d\n", state.event);
-		BUG();
-	}
-	return PCI_D0;
+		dev_err(&dev->dev, "PCI: Invalid PM Event [Event %d] [State %u]\n",
+			msg.event, msg.state);
+		WARN_ON(1);
+		state = PCI_D0;
+		break;
+	}
+	dev_dbg(&dev->dev, "PCI: Translated Power Message %d/%u -> %u\n",
+		msg.event, msg.state, state);
+	return state;
 }

 EXPORT_SYMBOL(pci_choose_state);
---
0.99.9.GIT
