Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030534AbVKWXxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030534AbVKWXxz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030528AbVKWXrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:47:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:44482 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751326AbVKWXqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:46:42 -0500
Date: Wed, 23 Nov 2005 15:45:37 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       david-b@pacbell.net
Subject: [patch 18/22] USB: EHCI updates split init/reinit logic for resume
Message-ID: <20051123234537.GS527@kroah.com>
References: <20051123225156.624397000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-ehci-updates-split-init-reinit-logic-for-resume.patch"
In-Reply-To: <20051123234335.GA527@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>


Moving the PCI-specific parts of the EHCI driver into their own file
created a few issues ... notably on resume paths which (like swsusp)
require re-initializing the controller.  This patch:

 - Splits the EHCI startup code into run-once HCD setup code and
   separate "init the hardware" reinit code.  (That reinit code is
   a superset of the "early usb handoff" code.)

 - Then it makes the PCI init code run both, and the resume code only
   run the reinit code.

 - It also removes needless pci wrappers around EHCI start/stop methods.

 - Removes a byteswap issue that would be seen on big-endian hardware.

The HCD glue still doesn't actually provide a good way to do all this
run-one init stuff in one place though.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/host/ehci-hcd.c |  155 +++++++++++++++++++++--------------------
 drivers/usb/host/ehci-pci.c |  166 ++++++++++++++++++++------------------------
 2 files changed, 161 insertions(+), 160 deletions(-)

--- usb-2.6.orig/drivers/usb/host/ehci-hcd.c
+++ usb-2.6/drivers/usb/host/ehci-hcd.c
@@ -411,50 +411,39 @@ static void ehci_stop (struct usb_hcd *h
 	dbg_status (ehci, "ehci_stop completed", readl (&ehci->regs->status));
 }
 
-static int ehci_run (struct usb_hcd *hcd)
+/* one-time init, only for memory state */
+static int ehci_init(struct usb_hcd *hcd)
 {
-	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
+	struct ehci_hcd		*ehci = hcd_to_ehci(hcd);
 	u32			temp;
 	int			retval;
 	u32			hcc_params;
-	int			first;
 
-	/* skip some things on restart paths */
-	first = (ehci->watchdog.data == 0);
-	if (first) {
-		init_timer (&ehci->watchdog);
-		ehci->watchdog.function = ehci_watchdog;
-		ehci->watchdog.data = (unsigned long) ehci;
-	}
+	spin_lock_init(&ehci->lock);
+
+	init_timer(&ehci->watchdog);
+	ehci->watchdog.function = ehci_watchdog;
+	ehci->watchdog.data = (unsigned long) ehci;
 
 	/*
 	 * hw default: 1K periodic list heads, one per frame.
 	 * periodic_size can shrink by USBCMD update if hcc_params allows.
 	 */
 	ehci->periodic_size = DEFAULT_I_TDPS;
-	if (first && (retval = ehci_mem_init (ehci, GFP_KERNEL)) < 0)
+	if ((retval = ehci_mem_init(ehci, GFP_KERNEL)) < 0)
 		return retval;
 
 	/* controllers may cache some of the periodic schedule ... */
-	hcc_params = readl (&ehci->caps->hcc_params);
-	if (HCC_ISOC_CACHE (hcc_params)) 	// full frame cache
+	hcc_params = readl(&ehci->caps->hcc_params);
+	if (HCC_ISOC_CACHE(hcc_params)) 	// full frame cache
 		ehci->i_thresh = 8;
 	else					// N microframes cached
-		ehci->i_thresh = 2 + HCC_ISOC_THRES (hcc_params);
+		ehci->i_thresh = 2 + HCC_ISOC_THRES(hcc_params);
 
 	ehci->reclaim = NULL;
 	ehci->reclaim_ready = 0;
 	ehci->next_uframe = -1;
 
-	/* controller state:  unknown --> reset */
-
-	/* EHCI spec section 4.1 */
-	if ((retval = ehci_reset (ehci)) != 0) {
-		ehci_mem_cleanup (ehci);
-		return retval;
-	}
-	writel (ehci->periodic_dma, &ehci->regs->frame_list);
-
 	/*
 	 * dedicate a qh for the async ring head, since we couldn't unlink
 	 * a 'real' qh without stopping the async schedule [4.8].  use it
@@ -462,37 +451,13 @@ static int ehci_run (struct usb_hcd *hcd
 	 * its dummy is used in hw_alt_next of many tds, to prevent the qh
 	 * from automatically advancing to the next td after short reads.
 	 */
-	if (first) {
-		ehci->async->qh_next.qh = NULL;
-		ehci->async->hw_next = QH_NEXT (ehci->async->qh_dma);
-		ehci->async->hw_info1 = cpu_to_le32 (QH_HEAD);
-		ehci->async->hw_token = cpu_to_le32 (QTD_STS_HALT);
-		ehci->async->hw_qtd_next = EHCI_LIST_END;
-		ehci->async->qh_state = QH_STATE_LINKED;
-		ehci->async->hw_alt_next = QTD_NEXT (ehci->async->dummy->qtd_dma);
-	}
-	writel ((u32)ehci->async->qh_dma, &ehci->regs->async_next);
-
-	/*
-	 * hcc_params controls whether ehci->regs->segment must (!!!)
-	 * be used; it constrains QH/ITD/SITD and QTD locations.
-	 * pci_pool consistent memory always uses segment zero.
-	 * streaming mappings for I/O buffers, like pci_map_single(),
-	 * can return segments above 4GB, if the device allows.
-	 *
-	 * NOTE:  the dma mask is visible through dma_supported(), so
-	 * drivers can pass this info along ... like NETIF_F_HIGHDMA,
-	 * Scsi_Host.highmem_io, and so forth.  It's readonly to all
-	 * host side drivers though.
-	 */
-	if (HCC_64BIT_ADDR (hcc_params)) {
-		writel (0, &ehci->regs->segment);
-#if 0
-// this is deeply broken on almost all architectures
-		if (!dma_set_mask (hcd->self.controller, DMA_64BIT_MASK))
-			ehci_info (ehci, "enabled 64bit DMA\n");
-#endif
-	}
+	ehci->async->qh_next.qh = NULL;
+	ehci->async->hw_next = QH_NEXT(ehci->async->qh_dma);
+	ehci->async->hw_info1 = cpu_to_le32(QH_HEAD);
+	ehci->async->hw_token = cpu_to_le32(QTD_STS_HALT);
+	ehci->async->hw_qtd_next = EHCI_LIST_END;
+	ehci->async->qh_state = QH_STATE_LINKED;
+	ehci->async->hw_alt_next = QTD_NEXT(ehci->async->dummy->qtd_dma);
 
 	/* clear interrupt enables, set irq latency */
 	if (log2_irq_thresh < 0 || log2_irq_thresh > 6)
@@ -507,13 +472,13 @@ static int ehci_run (struct usb_hcd *hcd
 		 * make problems:  throughput reduction (!), data errors...
 		 */
 		if (park) {
-			park = min (park, (unsigned) 3);
+			park = min(park, (unsigned) 3);
 			temp |= CMD_PARK;
 			temp |= park << 8;
 		}
-		ehci_info (ehci, "park %d\n", park);
+		ehci_dbg(ehci, "park %d\n", park);
 	}
-	if (HCC_PGM_FRAMELISTLEN (hcc_params)) {
+	if (HCC_PGM_FRAMELISTLEN(hcc_params)) {
 		/* periodic schedule size can be smaller than default */
 		temp &= ~(3 << 2);
 		temp |= (EHCI_TUNE_FLS << 2);
@@ -521,16 +486,63 @@ static int ehci_run (struct usb_hcd *hcd
 		case 0: ehci->periodic_size = 1024; break;
 		case 1: ehci->periodic_size = 512; break;
 		case 2: ehci->periodic_size = 256; break;
-		default:	BUG ();
+		default:	BUG();
 		}
 	}
+	ehci->command = temp;
+
+	ehci->reboot_notifier.notifier_call = ehci_reboot;
+	register_reboot_notifier(&ehci->reboot_notifier);
+
+	return 0;
+}
+
+/* start HC running; it's halted, ehci_init() has been run (once) */
+static int ehci_run (struct usb_hcd *hcd)
+{
+	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
+	int			retval;
+	u32			temp;
+	u32			hcc_params;
+
+	/* EHCI spec section 4.1 */
+	if ((retval = ehci_reset(ehci)) != 0) {
+		unregister_reboot_notifier(&ehci->reboot_notifier);
+		ehci_mem_cleanup(ehci);
+		return retval;
+	}
+	writel(ehci->periodic_dma, &ehci->regs->frame_list);
+	writel((u32)ehci->async->qh_dma, &ehci->regs->async_next);
+
+	/*
+	 * hcc_params controls whether ehci->regs->segment must (!!!)
+	 * be used; it constrains QH/ITD/SITD and QTD locations.
+	 * pci_pool consistent memory always uses segment zero.
+	 * streaming mappings for I/O buffers, like pci_map_single(),
+	 * can return segments above 4GB, if the device allows.
+	 *
+	 * NOTE:  the dma mask is visible through dma_supported(), so
+	 * drivers can pass this info along ... like NETIF_F_HIGHDMA,
+	 * Scsi_Host.highmem_io, and so forth.  It's readonly to all
+	 * host side drivers though.
+	 */
+	hcc_params = readl(&ehci->caps->hcc_params);
+	if (HCC_64BIT_ADDR(hcc_params)) {
+		writel(0, &ehci->regs->segment);
+#if 0
+// this is deeply broken on almost all architectures
+		if (!dma_set_mask(hcd->self.controller, DMA_64BIT_MASK))
+			ehci_info(ehci, "enabled 64bit DMA\n");
+#endif
+	}
+
+
 	// Philips, Intel, and maybe others need CMD_RUN before the
 	// root hub will detect new devices (why?); NEC doesn't
-	temp |= CMD_RUN;
-	writel (temp, &ehci->regs->command);
-	dbg_cmd (ehci, "init", temp);
-
-	/* set async sleep time = 10 us ... ? */
+	ehci->command &= ~(CMD_LRESET|CMD_IAAD|CMD_PSE|CMD_ASE|CMD_RESET);
+	ehci->command |= CMD_RUN;
+	writel (ehci->command, &ehci->regs->command);
+	dbg_cmd (ehci, "init", ehci->command);
 
 	/*
 	 * Start, enabling full USB 2.0 functionality ... usb 1.1 devices
@@ -538,26 +550,23 @@ static int ehci_run (struct usb_hcd *hcd
 	 * involved with the root hub.  (Except where one is integrated,
 	 * and there's no companion controller unless maybe for USB OTG.)
 	 */
-	if (first) {
-		ehci->reboot_notifier.notifier_call = ehci_reboot;
-		register_reboot_notifier (&ehci->reboot_notifier);
-	}
-
 	hcd->state = HC_STATE_RUNNING;
 	writel (FLAG_CF, &ehci->regs->configured_flag);
-	readl (&ehci->regs->command);	/* unblock posted write */
+	readl (&ehci->regs->command);	/* unblock posted writes */
 
 	temp = HC_VERSION(readl (&ehci->caps->hc_capbase));
 	ehci_info (ehci,
-		"USB %x.%x %s, EHCI %x.%02x, driver %s\n",
+		"USB %x.%x started, EHCI %x.%02x, driver %s\n",
 		((ehci->sbrn & 0xf0)>>4), (ehci->sbrn & 0x0f),
-		first ? "initialized" : "restarted",
 		temp >> 8, temp & 0xff, DRIVER_VERSION);
 
 	writel (INTR_MASK, &ehci->regs->intr_enable); /* Turn On Interrupts */
 
-	if (first)
-		create_debug_files (ehci);
+	/* GRR this is run-once init(), being done every time the HC starts.
+	 * So long as they're part of class devices, we can't do it init()
+	 * since the class device isn't created that early.
+	 */
+	create_debug_files(ehci);
 
 	return 0;
 }
--- usb-2.6.orig/drivers/usb/host/ehci-pci.c
+++ usb-2.6/drivers/usb/host/ehci-pci.c
@@ -58,15 +58,76 @@ static int bios_handoff(struct ehci_hcd 
 	return 0;
 }
 
-/* called by khubd or root hub init threads */
+/* called after powerup, by probe or system-pm "wakeup" */
+static int ehci_pci_reinit(struct ehci_hcd *ehci, struct pci_dev *pdev)
+{
+	u32			temp;
+	int			retval;
+	unsigned		count = 256/4;
+
+	/* optional debug port, normally in the first BAR */
+	temp = pci_find_capability(pdev, 0x0a);
+	if (temp) {
+		pci_read_config_dword(pdev, temp, &temp);
+		temp >>= 16;
+		if ((temp & (3 << 13)) == (1 << 13)) {
+			temp &= 0x1fff;
+			ehci->debug = ehci_to_hcd(ehci)->regs + temp;
+			temp = readl(&ehci->debug->control);
+			ehci_info(ehci, "debug port %d%s\n",
+				HCS_DEBUG_PORT(ehci->hcs_params),
+				(temp & DBGP_ENABLED)
+					? " IN USE"
+					: "");
+			if (!(temp & DBGP_ENABLED))
+				ehci->debug = NULL;
+		}
+	}
+
+	temp = HCC_EXT_CAPS(readl(&ehci->caps->hcc_params));
+
+	/* EHCI 0.96 and later may have "extended capabilities" */
+	while (temp && count--) {
+		u32		cap;
+
+		pci_read_config_dword(pdev, temp, &cap);
+		ehci_dbg(ehci, "capability %04x at %02x\n", cap, temp);
+		switch (cap & 0xff) {
+		case 1:			/* BIOS/SMM/... handoff */
+			if (bios_handoff(ehci, temp, cap) != 0)
+				return -EOPNOTSUPP;
+			break;
+		case 0:			/* illegal reserved capability */
+			ehci_dbg(ehci, "illegal capability!\n");
+			cap = 0;
+			/* FALLTHROUGH */
+		default:		/* unknown */
+			break;
+		}
+		temp = (cap >> 8) & 0xff;
+	}
+	if (!count) {
+		ehci_err(ehci, "bogus capabilities ... PCI problems!\n");
+		return -EIO;
+	}
+
+	/* PCI Memory-Write-Invalidate cycle support is optional (uncommon) */
+	retval = pci_set_mwi(pdev);
+	if (!retval)
+		ehci_dbg(ehci, "MWI active\n");
+
+	ehci_port_power(ehci, 0);
+
+	return 0;
+}
+
+/* called by khubd or root hub (re)init threads; leaves HC in halt state */
 static int ehci_pci_reset(struct usb_hcd *hcd)
 {
 	struct ehci_hcd		*ehci = hcd_to_ehci(hcd);
 	struct pci_dev		*pdev = to_pci_dev(hcd->self.controller);
 	u32			temp;
-	unsigned		count = 256/4;
-
-	spin_lock_init (&ehci->lock);
+	int			retval;
 
 	ehci->caps = hcd->regs;
 	ehci->regs = hcd->regs + HC_LENGTH(readl(&ehci->caps->hc_capbase));
@@ -76,6 +137,10 @@ static int ehci_pci_reset(struct usb_hcd
 	/* cache this readonly data; minimize chip reads */
 	ehci->hcs_params = readl(&ehci->caps->hcs_params);
 
+	retval = ehci_halt(ehci);
+	if (retval)
+		return retval;
+
 	/* NOTE:  only the parts below this line are PCI-specific */
 
 	switch (pdev->vendor) {
@@ -111,57 +176,9 @@ static int ehci_pci_reset(struct usb_hcd
 		break;
 	}
 
-	/* optional debug port, normally in the first BAR */
-	temp = pci_find_capability(pdev, 0x0a);
-	if (temp) {
-		pci_read_config_dword(pdev, temp, &temp);
-		temp >>= 16;
-		if ((temp & (3 << 13)) == (1 << 13)) {
-			temp &= 0x1fff;
-			ehci->debug = hcd->regs + temp;
-			temp = readl(&ehci->debug->control);
-			ehci_info(ehci, "debug port %d%s\n",
-				HCS_DEBUG_PORT(ehci->hcs_params),
-				(temp & DBGP_ENABLED)
-					? " IN USE"
-					: "");
-			if (!(temp & DBGP_ENABLED))
-				ehci->debug = NULL;
-		}
-	}
-
-	temp = HCC_EXT_CAPS(readl(&ehci->caps->hcc_params));
-
-	/* EHCI 0.96 and later may have "extended capabilities" */
-	while (temp && count--) {
-		u32		cap;
-
-		pci_read_config_dword(to_pci_dev(hcd->self.controller),
-				temp, &cap);
-		ehci_dbg(ehci, "capability %04x at %02x\n", cap, temp);
-		switch (cap & 0xff) {
-		case 1:			/* BIOS/SMM/... handoff */
-			if (bios_handoff(ehci, temp, cap) != 0)
-				return -EOPNOTSUPP;
-			break;
-		case 0:			/* illegal reserved capability */
-			ehci_warn(ehci, "illegal capability!\n");
-			cap = 0;
-			/* FALLTHROUGH */
-		default:		/* unknown */
-			break;
-		}
-		temp = (cap >> 8) & 0xff;
-	}
-	if (!count) {
-		ehci_err(ehci, "bogus capabilities ... PCI problems!\n");
-		return -EIO;
-	}
 	if (ehci_is_TDI(ehci))
 		ehci_reset(ehci);
 
-	ehci_port_power(ehci, 0);
-
 	/* at least the Genesys GL880S needs fixup here */
 	temp = HCS_N_CC(ehci->hcs_params) * HCS_N_PCC(ehci->hcs_params);
 	temp &= 0x0f;
@@ -184,39 +201,15 @@ static int ehci_pci_reset(struct usb_hcd
 		}
 	}
 
-	/* force HC to halt state */
-	return ehci_halt(ehci);
-}
-
-static int ehci_pci_start(struct usb_hcd *hcd)
-{
-	struct ehci_hcd		*ehci = hcd_to_ehci(hcd);
-	int			result = 0;
-	struct pci_dev		*pdev;
-	u16			port_wake;
-
-	pdev = to_pci_dev(hcd->self.controller);
-
 	/* Serial Bus Release Number is at PCI 0x60 offset */
 	pci_read_config_byte(pdev, 0x60, &ehci->sbrn);
 
-	/* port wake capability, reported by boot firmware */
-	pci_read_config_word(pdev, 0x62, &port_wake);
-	hcd->can_wakeup = (port_wake & 1) != 0;
-
-	/* PCI Memory-Write-Invalidate cycle support is optional (uncommon) */
-	result = pci_set_mwi(pdev);
-	if (!result)
-		ehci_dbg(ehci, "MWI active\n");
-
-	return ehci_run(hcd);
-}
+	/* REVISIT:  per-port wake capability (PCI 0x62) currently unused */
 
-/* always called by thread; normally rmmod */
+	retval = ehci_pci_reinit(ehci, pdev);
 
-static void ehci_pci_stop(struct usb_hcd *hcd)
-{
-	ehci_stop(hcd);
+	/* finish init */
+	return ehci_init(hcd);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -250,6 +243,7 @@ static int ehci_pci_resume(struct usb_hc
 	struct ehci_hcd		*ehci = hcd_to_ehci(hcd);
 	unsigned		port;
 	struct usb_device	*root = hcd->self.root_hub;
+	struct pci_dev		*pdev = to_pci_dev(hcd->self.controller);
 	int			retval = -EINVAL;
 
 	// maybe restore FLADJ
@@ -258,7 +252,7 @@ static int ehci_pci_resume(struct usb_hc
 		msleep(100);
 
 	/* If CF is clear, we lost PCI Vaux power and need to restart.  */
-	if (readl(&ehci->regs->configured_flag) != cpu_to_le32(FLAG_CF))
+	if (readl(&ehci->regs->configured_flag) != FLAG_CF)
 		goto restart;
 
 	/* If any port is suspended (or owned by the companion),
@@ -292,7 +286,7 @@ restart:
 	 */
 	(void) ehci_halt(ehci);
 	(void) ehci_reset(ehci);
-	(void) ehci_pci_reset(hcd);
+	(void) ehci_pci_reinit(ehci, pdev);
 
 	/* emptying the schedule aborts any urbs */
 	spin_lock_irq(&ehci->lock);
@@ -304,9 +298,7 @@ restart:
 	/* restart; khubd will disconnect devices */
 	retval = ehci_run(hcd);
 
-	/* here we "know" root ports should always stay powered;
-	 * but some controllers may lose all power.
-	 */
+	/* here we "know" root ports should always stay powered */
 	ehci_port_power(ehci, 1);
 
 	return retval;
@@ -328,12 +320,12 @@ static const struct hc_driver ehci_pci_h
 	 * basic lifecycle operations
 	 */
 	.reset =		ehci_pci_reset,
-	.start =		ehci_pci_start,
+	.start =		ehci_run,
 #ifdef	CONFIG_PM
 	.suspend =		ehci_pci_suspend,
 	.resume =		ehci_pci_resume,
 #endif
-	.stop =			ehci_pci_stop,
+	.stop =			ehci_stop,
 
 	/*
 	 * managing i/o requests and associated device resources

--
