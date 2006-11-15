Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161209AbWKOTwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161209AbWKOTwn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161219AbWKOTwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:52:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28621 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161209AbWKOTwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:52:42 -0500
Date: Wed, 15 Nov 2006 11:49:28 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
Message-ID: <20061115114928.6ff0936e@freekitty>
In-Reply-To: <455B6928.5030202@garzik.org>
References: <20061114.192117.112621278.davem@davemloft.net>
	<Pine.LNX.4.64.0611141935390.3349@woody.osdl.org>
	<455A938A.4060002@garzik.org>
	<20061114.201549.69019823.davem@davemloft.net>
	<455A9664.50404@garzik.org>
	<20061115110953.6cafdef8@freekitty>
	<455B6928.5030202@garzik.org>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 14:23:20 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> Stephen Hemminger wrote:
> > On Tue, 14 Nov 2006 23:24:04 -0500
> > Jeff Garzik <jeff@garzik.org> wrote:
> > 
> >> David Miller wrote:
> >>> Is this absolutely true?  I've never been sure about this point, and I
> >>> was rather convinced after reading various documents that once you
> >>> program up the MSI registers to start generating MSI this implicitly
> >>> disabled INTX and this was even in the PCI specification.
> >>>
> >>> It would be great to get a definitive answer on this.
> >>>
> >>> If it is mandatory, perhaps the driver shouldn't be doing it and
> >>> rather the PCI layer MSI enabling should.
> > 
> > pci_enable_msi() calls msi_capability_init() and that disables intx
> > already.
> [...]
> > The driver shouldn't deal with this, pci_disable_msi() does.
> 
> Explicit code reference please?
> 
> AFAICS the PCI layer only touched INTx bit for PCI-Express devices.

Yeah, why is that? Shouldn't it always be adjusting intx. 
Are there are any MSI capable devices on non-PCI express?
Sorry, don't have PCI spec (costs real $$) to check.

--- 2.6.19-rc5.orig/drivers/pci/msi.c	2006-11-15 11:46:23.000000000 -0800
+++ 2.6.19-rc5/drivers/pci/msi.c	2006-11-15 11:46:55.000000000 -0800
@@ -255,10 +255,7 @@
 		pci_write_config_word(dev, msi_control_reg(pos), control);
 		dev->msix_enabled = 1;
 	}
-    	if (pci_find_capability(dev, PCI_CAP_ID_EXP)) {
-		/* PCI Express Endpoint device detected */
-		pci_intx(dev, 0);  /* disable intx */
-	}
+	pci_intx(dev, 0);  /* disable intx */
 }
 
 void disable_msi_mode(struct pci_dev *dev, int pos, int type)
@@ -276,10 +273,8 @@
 		pci_write_config_word(dev, msi_control_reg(pos), control);
 		dev->msix_enabled = 0;
 	}
-    	if (pci_find_capability(dev, PCI_CAP_ID_EXP)) {
-		/* PCI Express Endpoint device detected */
-		pci_intx(dev, 1);  /* enable intx */
-	}
+
+	pci_intx(dev, 1);  /* re-enable intx */
 }
 
 static int msi_lookup_irq(struct pci_dev *dev, int type)

		


-- 
Stephen Hemminger <shemminger@osdl.org>
