Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271337AbTGWVx1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 17:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271338AbTGWVx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 17:53:27 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:44769 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S271337AbTGWVxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 17:53:16 -0400
Date: Thu, 24 Jul 2003 00:08:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: weissg@vienna.at, kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: OHCI problems with suspend/resume
Message-ID: <20030723220805.GA278@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

In 2.6.0-test1, OHCI is non-functional after first suspend/resume, and
kills machine during secon suspend/resume cycle.

What happens is that ohci_irq gets ohci->hcca == NULL, and kills
machine. Why is ohci->hcca == NULL? ohci_stop was called from
hcd_panic() and freed ohci->hcca.

I believe that we should

1) not free ohci->hcca so that system has better chance surviving
hcd_panic()

and 

2) inform user when hcd panics.

This patch does both, please apply,

[Okay, you probably want to kill the ifdefs, and kill the code,
leaving just a comment...]
								Pavel

--- /usr/src/tmp/linux/drivers/usb/core/hcd.c	2003-07-06 20:07:49.000000000 +0200
+++ /usr/src/linux/drivers/usb/core/hcd.c	2003-07-23 23:32:55.000000000 +0200
@@ -1486,6 +1486,7 @@
 static void hcd_panic (void *_hcd)
 {
 	struct usb_hcd *hcd = _hcd;
+	printk(KERN_CRIT "Host controller panicked\n");
 	hcd->driver->stop (hcd);
 }
 
--- /usr/src/tmp/linux/drivers/usb/host/ohci-hcd.c	2003-05-27 13:43:39.000000000 +0200
+++ /usr/src/linux/drivers/usb/host/ohci-hcd.c	2003-07-23 23:31:46.000000000 +0200
@@ -627,12 +632,18 @@
 	
 	remove_debug_files (ohci);
 	ohci_mem_cleanup (ohci);
+#if 0
+	/* Freeing hcca at this point is bad idea, because ohci_irq
+	   can't cope with ohci->hcca being NULL, and therefore will
+	   crash the machine after hcd_panic()
+	 */
 	if (ohci->hcca) {
 		pci_free_consistent (ohci->hcd.pdev, sizeof *ohci->hcca,
 					ohci->hcca, ohci->hcca_dma);
 		ohci->hcca = NULL;
 		ohci->hcca_dma = 0;
 	}
+#endif
 }
 
 /*-------------------------------------------------------------------------*/

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
