Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264467AbUAOBpi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 20:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbUAOBm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 20:42:58 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:48809 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265200AbUAOBlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 20:41:04 -0500
Subject: Re: cdc-acm problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040113130529.03f5dbac.colin@colino.net>
References: <20040113130529.03f5dbac.colin@colino.net>
Content-Type: text/plain
Message-Id: <1074130473.5123.41.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 15 Jan 2004 12:34:42 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-13 at 23:05, Colin Leroy wrote:
> Hi,
> 
> I have problems with cdc-acm killing ohci. I tried to narrow down the problem,
> but didn't get far.
> Basically `killall -HUP pppd` gives (in dmesg):
> 
> drivers/usb/class/cdc-acm.c: acm_ctrl_irq - urb shutting down with status: -2
> ohci_hcd 0001:01:1b.1: OHCI Unrecoverable Error, disabled
> ohci_hcd 0001:01:1b.1: HC died; cleaning up

The above is interesting, looks like a PCI error. I keep getting those
unrecoverable errors with those new USB2 capable chips, I don't know
what's going on yet. Can try this patch and tell me what it dumps ?


===== drivers/usb/host/ohci-hcd.c 1.53 vs edited =====
--- 1.53/drivers/usb/host/ohci-hcd.c	Wed Dec 31 15:25:17 2003
+++ edited/drivers/usb/host/ohci-hcd.c	Wed Jan 14 13:20:52 2004
@@ -316,6 +316,11 @@
 	/* ASSERT:  any requests/urbs are being unlinked */
 	/* ASSERT:  nobody can be submitting urbs for this any more */
 
+	if (!HCD_IS_RUNNING (ohci->hcd.state)) {
+		ed->state = ED_IDLE;
+		finish_unlinks (ohci, 0, 0);
+	}
+
 	epnum <<= 1;
 	if (epnum != 0 && !(ep & USB_DIR_IN))
 		epnum |= 1;
@@ -571,9 +576,17 @@
 		disable (ohci);
 		ohci_err (ohci, "OHCI Unrecoverable Error, disabled\n");
 		// e.g. due to PCI Master/Target Abort
+#if 1
+		if (hcd->pdev) {
+			u16 status;
+
+			pci_read_config_word(hcd->pdev, PCI_STATUS, &status);
+			printk(KERN_ERR "OHCI PCI Status: 0x%04x\n", status);
+		}
+#endif
 
 		ohci_dump (ohci, 1);
-		hc_reset (ohci);
+       		hc_reset (ohci);
 	}
   
 	if (ints & OHCI_INTR_WDH) {
===== drivers/usb/host/ohci-pci.c 1.20 vs edited =====
--- 1.20/drivers/usb/host/ohci-pci.c	Tue Oct 28 15:36:00 2003
+++ edited/drivers/usb/host/ohci-pci.c	Wed Jan 14 13:23:07 2004
@@ -36,6 +36,17 @@
 	int		ret;
 
 	if (hcd->pdev) {
+#if 1
+		u16 status;
+
+		pci_read_config_word(hcd->pdev, PCI_STATUS, &status);
+		printk(KERN_ERR "OHCI PCI Status: 0x%04x\n", status);
+		if (status & 0xf900) {
+			printk(KERN_ERR "Initial error ! clearing ...\n");
+			pci_write_config_word(hcd->pdev, PCI_STATUS, status);
+		}
+#endif
+
 		ohci->hcca = pci_alloc_consistent (hcd->pdev,
 				sizeof *ohci->hcca, &ohci->hcca_dma);
 		if (!ohci->hcca)


