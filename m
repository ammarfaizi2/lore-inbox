Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030531AbVKWXrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030531AbVKWXrZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbVKWXqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:46:38 -0500
Received: from mail.kroah.org ([69.55.234.183]:22210 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751327AbVKWXqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:46:30 -0500
Date: Wed, 23 Nov 2005 15:45:32 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       david-b@pacbell.net
Subject: [patch 17/22] USB: EHCI updates mostly whitespace cleanups
Message-ID: <20051123234532.GR527@kroah.com>
References: <20051123225156.624397000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-ehci-updates-mostly-whitespace-cleanups.patch"
In-Reply-To: <20051123234335.GA527@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

This cleans up the recent updates to EHCI PCI support:

  - Gets rid of checks for "is this a PCI device", they're no
    longer needed since this is now all PCI-only code.

  - Reduce log spamming:  MWI is only interesting in the atypical
    case that it can actually be used.

  - Whitespace cleanup, as appropriate for a new file with no
    other pending patches.

So other than that minor logging change, no functional updates.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/usb/host/ehci-pci.c |  268 +++++++++++++++++++++-----------------------
 1 file changed, 129 insertions(+), 139 deletions(-)

--- usb-2.6.orig/drivers/usb/host/ehci-pci.c
+++ usb-2.6/drivers/usb/host/ehci-pci.c
@@ -27,7 +27,7 @@
 /* EHCI 0.96 (and later) section 5.1 says how to kick BIOS/SMM/...
  * off the controller (maybe it can boot from highspeed USB disks).
  */
-static int bios_handoff (struct ehci_hcd *ehci, int where, u32 cap)
+static int bios_handoff(struct ehci_hcd *ehci, int where, u32 cap)
 {
 	struct pci_dev *pdev = to_pci_dev(ehci_to_hcd(ehci)->self.controller);
 
@@ -48,7 +48,7 @@ static int bios_handoff (struct ehci_hcd
 				where, cap);
 			// some BIOS versions seem buggy...
 			// return 1;
-			ehci_warn (ehci, "continuing after BIOS bug...\n");
+			ehci_warn(ehci, "continuing after BIOS bug...\n");
 			/* disable all SMIs, and clear "BIOS owns" flag */
 			pci_write_config_dword(pdev, where + 4, 0);
 			pci_write_config_byte(pdev, where + 2, 0);
@@ -59,95 +59,93 @@ static int bios_handoff (struct ehci_hcd
 }
 
 /* called by khubd or root hub init threads */
-static int ehci_pci_reset (struct usb_hcd *hcd)
+static int ehci_pci_reset(struct usb_hcd *hcd)
 {
-	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
+	struct ehci_hcd		*ehci = hcd_to_ehci(hcd);
+	struct pci_dev		*pdev = to_pci_dev(hcd->self.controller);
 	u32			temp;
 	unsigned		count = 256/4;
 
 	spin_lock_init (&ehci->lock);
 
 	ehci->caps = hcd->regs;
-	ehci->regs = hcd->regs + HC_LENGTH (readl (&ehci->caps->hc_capbase));
-	dbg_hcs_params (ehci, "reset");
-	dbg_hcc_params (ehci, "reset");
+	ehci->regs = hcd->regs + HC_LENGTH(readl(&ehci->caps->hc_capbase));
+	dbg_hcs_params(ehci, "reset");
+	dbg_hcc_params(ehci, "reset");
 
 	/* cache this readonly data; minimize chip reads */
-	ehci->hcs_params = readl (&ehci->caps->hcs_params);
+	ehci->hcs_params = readl(&ehci->caps->hcs_params);
 
-	if (hcd->self.controller->bus == &pci_bus_type) {
-		struct pci_dev	*pdev = to_pci_dev(hcd->self.controller);
+	/* NOTE:  only the parts below this line are PCI-specific */
 
-		switch (pdev->vendor) {
-		case PCI_VENDOR_ID_TDI:
-			if (pdev->device == PCI_DEVICE_ID_TDI_EHCI) {
-				ehci->is_tdi_rh_tt = 1;
-				tdi_reset (ehci);
-			}
-			break;
-		case PCI_VENDOR_ID_AMD:
-			/* AMD8111 EHCI doesn't work, according to AMD errata */
-			if (pdev->device == 0x7463) {
-				ehci_info (ehci, "ignoring AMD8111 (errata)\n");
-				return -EIO;
-			}
-			break;
-		case PCI_VENDOR_ID_NVIDIA:
-			/* NVidia reports that certain chips don't handle
-			 * QH, ITD, or SITD addresses above 2GB.  (But TD,
-			 * data buffer, and periodic schedule are normal.)
-			 */
-			switch (pdev->device) {
-			case 0x003c:	/* MCP04 */
-			case 0x005b:	/* CK804 */
-			case 0x00d8:	/* CK8 */
-			case 0x00e8:	/* CK8S */
-				if (pci_set_consistent_dma_mask(pdev,
-							DMA_31BIT_MASK) < 0)
-					ehci_warn (ehci, "can't enable NVidia "
-						"workaround for >2GB RAM\n");
-				break;
-			}
+	switch (pdev->vendor) {
+	case PCI_VENDOR_ID_TDI:
+		if (pdev->device == PCI_DEVICE_ID_TDI_EHCI) {
+			ehci->is_tdi_rh_tt = 1;
+			tdi_reset(ehci);
+		}
+		break;
+	case PCI_VENDOR_ID_AMD:
+		/* AMD8111 EHCI doesn't work, according to AMD errata */
+		if (pdev->device == 0x7463) {
+			ehci_info(ehci, "ignoring AMD8111 (errata)\n");
+			return -EIO;
+		}
+		break;
+	case PCI_VENDOR_ID_NVIDIA:
+		/* NVidia reports that certain chips don't handle
+		 * QH, ITD, or SITD addresses above 2GB.  (But TD,
+		 * data buffer, and periodic schedule are normal.)
+		 */
+		switch (pdev->device) {
+		case 0x003c:	/* MCP04 */
+		case 0x005b:	/* CK804 */
+		case 0x00d8:	/* CK8 */
+		case 0x00e8:	/* CK8S */
+			if (pci_set_consistent_dma_mask(pdev,
+						DMA_31BIT_MASK) < 0)
+				ehci_warn(ehci, "can't enable NVidia "
+					"workaround for >2GB RAM\n");
 			break;
 		}
+		break;
+	}
 
-		/* optional debug port, normally in the first BAR */
-		temp = pci_find_capability (pdev, 0x0a);
-		if (temp) {
-			pci_read_config_dword(pdev, temp, &temp);
-			temp >>= 16;
-			if ((temp & (3 << 13)) == (1 << 13)) {
-				temp &= 0x1fff;
-				ehci->debug = hcd->regs + temp;
-				temp = readl (&ehci->debug->control);
-				ehci_info (ehci, "debug port %d%s\n",
-					HCS_DEBUG_PORT(ehci->hcs_params),
-					(temp & DBGP_ENABLED)
-						? " IN USE"
-						: "");
-				if (!(temp & DBGP_ENABLED))
-					ehci->debug = NULL;
-			}
+	/* optional debug port, normally in the first BAR */
+	temp = pci_find_capability(pdev, 0x0a);
+	if (temp) {
+		pci_read_config_dword(pdev, temp, &temp);
+		temp >>= 16;
+		if ((temp & (3 << 13)) == (1 << 13)) {
+			temp &= 0x1fff;
+			ehci->debug = hcd->regs + temp;
+			temp = readl(&ehci->debug->control);
+			ehci_info(ehci, "debug port %d%s\n",
+				HCS_DEBUG_PORT(ehci->hcs_params),
+				(temp & DBGP_ENABLED)
+					? " IN USE"
+					: "");
+			if (!(temp & DBGP_ENABLED))
+				ehci->debug = NULL;
 		}
+	}
 
-		temp = HCC_EXT_CAPS (readl (&ehci->caps->hcc_params));
-	} else
-		temp = 0;
+	temp = HCC_EXT_CAPS(readl(&ehci->caps->hcc_params));
 
 	/* EHCI 0.96 and later may have "extended capabilities" */
 	while (temp && count--) {
 		u32		cap;
 
-		pci_read_config_dword (to_pci_dev(hcd->self.controller),
+		pci_read_config_dword(to_pci_dev(hcd->self.controller),
 				temp, &cap);
-		ehci_dbg (ehci, "capability %04x at %02x\n", cap, temp);
+		ehci_dbg(ehci, "capability %04x at %02x\n", cap, temp);
 		switch (cap & 0xff) {
 		case 1:			/* BIOS/SMM/... handoff */
-			if (bios_handoff (ehci, temp, cap) != 0)
+			if (bios_handoff(ehci, temp, cap) != 0)
 				return -EOPNOTSUPP;
 			break;
 		case 0:			/* illegal reserved capability */
-			ehci_warn (ehci, "illegal capability!\n");
+			ehci_warn(ehci, "illegal capability!\n");
 			cap = 0;
 			/* FALLTHROUGH */
 		default:		/* unknown */
@@ -156,77 +154,69 @@ static int ehci_pci_reset (struct usb_hc
 		temp = (cap >> 8) & 0xff;
 	}
 	if (!count) {
-		ehci_err (ehci, "bogus capabilities ... PCI problems!\n");
+		ehci_err(ehci, "bogus capabilities ... PCI problems!\n");
 		return -EIO;
 	}
 	if (ehci_is_TDI(ehci))
-		ehci_reset (ehci);
+		ehci_reset(ehci);
 
-	ehci_port_power (ehci, 0);
+	ehci_port_power(ehci, 0);
 
 	/* at least the Genesys GL880S needs fixup here */
 	temp = HCS_N_CC(ehci->hcs_params) * HCS_N_PCC(ehci->hcs_params);
 	temp &= 0x0f;
 	if (temp && HCS_N_PORTS(ehci->hcs_params) > temp) {
-		ehci_dbg (ehci, "bogus port configuration: "
+		ehci_dbg(ehci, "bogus port configuration: "
 			"cc=%d x pcc=%d < ports=%d\n",
 			HCS_N_CC(ehci->hcs_params),
 			HCS_N_PCC(ehci->hcs_params),
 			HCS_N_PORTS(ehci->hcs_params));
 
-		if (hcd->self.controller->bus == &pci_bus_type) {
-			struct pci_dev	*pdev;
-
-			pdev = to_pci_dev(hcd->self.controller);
-			switch (pdev->vendor) {
-			case 0x17a0:		/* GENESYS */
-				/* GL880S: should be PORTS=2 */
-				temp |= (ehci->hcs_params & ~0xf);
-				ehci->hcs_params = temp;
-				break;
-			case PCI_VENDOR_ID_NVIDIA:
-				/* NF4: should be PCC=10 */
-				break;
-			}
+		switch (pdev->vendor) {
+		case 0x17a0:		/* GENESYS */
+			/* GL880S: should be PORTS=2 */
+			temp |= (ehci->hcs_params & ~0xf);
+			ehci->hcs_params = temp;
+			break;
+		case PCI_VENDOR_ID_NVIDIA:
+			/* NF4: should be PCC=10 */
+			break;
 		}
 	}
 
 	/* force HC to halt state */
-	return ehci_halt (ehci);
+	return ehci_halt(ehci);
 }
 
-static int ehci_pci_start (struct usb_hcd *hcd)
+static int ehci_pci_start(struct usb_hcd *hcd)
 {
-	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
-	int result = 0;
-
-	if (hcd->self.controller->bus == &pci_bus_type) {
-		struct pci_dev		*pdev;
-		u16			port_wake;
-
-		pdev = to_pci_dev(hcd->self.controller);
-
-		/* Serial Bus Release Number is at PCI 0x60 offset */
-		pci_read_config_byte(pdev, 0x60, &ehci->sbrn);
-
-		/* port wake capability, reported by boot firmware */
-		pci_read_config_word(pdev, 0x62, &port_wake);
-		hcd->can_wakeup = (port_wake & 1) != 0;
-
-		/* help hc dma work well with cachelines */
-		result = pci_set_mwi(pdev);
-		if (result)
-			ehci_dbg(ehci, "unable to enable MWI - not fatal.\n");
-	}
+	struct ehci_hcd		*ehci = hcd_to_ehci(hcd);
+	int			result = 0;
+	struct pci_dev		*pdev;
+	u16			port_wake;
+
+	pdev = to_pci_dev(hcd->self.controller);
+
+	/* Serial Bus Release Number is at PCI 0x60 offset */
+	pci_read_config_byte(pdev, 0x60, &ehci->sbrn);
+
+	/* port wake capability, reported by boot firmware */
+	pci_read_config_word(pdev, 0x62, &port_wake);
+	hcd->can_wakeup = (port_wake & 1) != 0;
+
+	/* PCI Memory-Write-Invalidate cycle support is optional (uncommon) */
+	result = pci_set_mwi(pdev);
+	if (!result)
+		ehci_dbg(ehci, "MWI active\n");
 
-	return ehci_run (hcd);
+	return ehci_run(hcd);
 }
 
 /* always called by thread; normally rmmod */
 
-static void ehci_pci_stop (struct usb_hcd *hcd)
+static void ehci_pci_stop(struct usb_hcd *hcd)
 {
-	ehci_stop (hcd);
+	ehci_stop(hcd);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -242,12 +232,12 @@ static void ehci_pci_stop (struct usb_hc
  * Also they depend on separate root hub suspend/resume.
  */
 
-static int ehci_pci_suspend (struct usb_hcd *hcd, pm_message_t message)
+static int ehci_pci_suspend(struct usb_hcd *hcd, pm_message_t message)
 {
-	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
+	struct ehci_hcd		*ehci = hcd_to_ehci(hcd);
 
-	if (time_before (jiffies, ehci->next_statechange))
-		msleep (10);
+	if (time_before(jiffies, ehci->next_statechange))
+		msleep(10);
 
 	// could save FLADJ in case of Vaux power loss
 	// ... we'd only use it to handle clock skew
@@ -255,30 +245,30 @@ static int ehci_pci_suspend (struct usb_
 	return 0;
 }
 
-static int ehci_pci_resume (struct usb_hcd *hcd)
+static int ehci_pci_resume(struct usb_hcd *hcd)
 {
-	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
+	struct ehci_hcd		*ehci = hcd_to_ehci(hcd);
 	unsigned		port;
 	struct usb_device	*root = hcd->self.root_hub;
 	int			retval = -EINVAL;
 
 	// maybe restore FLADJ
 
-	if (time_before (jiffies, ehci->next_statechange))
-		msleep (100);
+	if (time_before(jiffies, ehci->next_statechange))
+		msleep(100);
 
 	/* If CF is clear, we lost PCI Vaux power and need to restart.  */
-	if (readl (&ehci->regs->configured_flag) != cpu_to_le32(FLAG_CF))
+	if (readl(&ehci->regs->configured_flag) != cpu_to_le32(FLAG_CF))
 		goto restart;
 
 	/* If any port is suspended (or owned by the companion),
 	 * we know we can/must resume the HC (and mustn't reset it).
 	 * We just defer that to the root hub code.
 	 */
-	for (port = HCS_N_PORTS (ehci->hcs_params); port > 0; ) {
+	for (port = HCS_N_PORTS(ehci->hcs_params); port > 0; ) {
 		u32	status;
 		port--;
-		status = readl (&ehci->regs->port_status [port]);
+		status = readl(&ehci->regs->port_status [port]);
 		if (!(status & PORT_POWER))
 			continue;
 		if (status & (PORT_SUSPEND | PORT_RESUME | PORT_OWNER)) {
@@ -289,35 +279,35 @@ static int ehci_pci_resume (struct usb_h
 
 restart:
 	ehci_dbg(ehci, "lost power, restarting\n");
-	for (port = HCS_N_PORTS (ehci->hcs_params); port > 0; ) {
+	for (port = HCS_N_PORTS(ehci->hcs_params); port > 0; ) {
 		port--;
 		if (!root->children [port])
 			continue;
-		usb_set_device_state (root->children[port],
+		usb_set_device_state(root->children[port],
 					USB_STATE_NOTATTACHED);
 	}
 
 	/* Else reset, to cope with power loss or flush-to-storage
 	 * style "resume" having let BIOS kick in during reboot.
 	 */
-	(void) ehci_halt (ehci);
-	(void) ehci_reset (ehci);
-	(void) ehci_pci_reset (hcd);
+	(void) ehci_halt(ehci);
+	(void) ehci_reset(ehci);
+	(void) ehci_pci_reset(hcd);
 
 	/* emptying the schedule aborts any urbs */
-	spin_lock_irq (&ehci->lock);
+	spin_lock_irq(&ehci->lock);
 	if (ehci->reclaim)
 		ehci->reclaim_ready = 1;
-	ehci_work (ehci, NULL);
-	spin_unlock_irq (&ehci->lock);
+	ehci_work(ehci, NULL);
+	spin_unlock_irq(&ehci->lock);
 
 	/* restart; khubd will disconnect devices */
-	retval = ehci_run (hcd);
+	retval = ehci_run(hcd);
 
 	/* here we "know" root ports should always stay powered;
 	 * but some controllers may lose all power.
 	 */
-	ehci_port_power (ehci, 1);
+	ehci_port_power(ehci, 1);
 
 	return retval;
 }
@@ -376,7 +366,7 @@ static const struct pci_device_id pci_id
 	},
 	{ /* end: all zeroes */ }
 };
-MODULE_DEVICE_TABLE (pci, pci_ids);
+MODULE_DEVICE_TABLE(pci, pci_ids);
 
 /* pci driver glue; this is a "new style" PCI driver module */
 static struct pci_driver ehci_pci_driver = {
@@ -392,22 +382,22 @@ static struct pci_driver ehci_pci_driver
 #endif
 };
 
-static int __init ehci_hcd_pci_init (void)
+static int __init ehci_hcd_pci_init(void)
 {
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_debug ("%s: block sizes: qh %Zd qtd %Zd itd %Zd sitd %Zd\n",
+	pr_debug("%s: block sizes: qh %Zd qtd %Zd itd %Zd sitd %Zd\n",
 		hcd_name,
-		sizeof (struct ehci_qh), sizeof (struct ehci_qtd),
-		sizeof (struct ehci_itd), sizeof (struct ehci_sitd));
+		sizeof(struct ehci_qh), sizeof(struct ehci_qtd),
+		sizeof(struct ehci_itd), sizeof(struct ehci_sitd));
 
-	return pci_register_driver (&ehci_pci_driver);
+	return pci_register_driver(&ehci_pci_driver);
 }
-module_init (ehci_hcd_pci_init);
+module_init(ehci_hcd_pci_init);
 
-static void __exit ehci_hcd_pci_cleanup (void)
+static void __exit ehci_hcd_pci_cleanup(void)
 {
-	pci_unregister_driver (&ehci_pci_driver);
+	pci_unregister_driver(&ehci_pci_driver);
 }
-module_exit (ehci_hcd_pci_cleanup);
+module_exit(ehci_hcd_pci_cleanup);

--
