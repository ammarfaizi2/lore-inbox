Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030363AbWHIHyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbWHIHyW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 03:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbWHIHyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 03:54:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26311 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030363AbWHIHyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 03:54:21 -0400
Date: Wed, 9 Aug 2006 00:54:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrew Clayton <andrew@digital-domain.net>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc strange hotplug/udev/uevent problem
Message-Id: <20060809005416.82f30445.akpm@osdl.org>
In-Reply-To: <20060809014104.0be41976@alpha.digital-domain.net>
References: <44D79574.8080703@digital-domain.net>
	<20060808060211.GA3206@kroah.com>
	<20060809014104.0be41976@alpha.digital-domain.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2006 01:41:04 +0100
Andrew Clayton <andrew@digital-domain.net> wrote:

> On Mon, 7 Aug 2006 23:02:11 -0700, Greg KH wrote:
>  
> > Can you use 'git bisect' to try to narrow it down which change caused
> > the problem?
> 
> I did 
> 
> git bisect start drivers/scsi drivers/usb
> git bad v2.6.18-rc1
> git good v2.6.17
> 
> Heres what git bisect came up with
> 
> c32ba30f76eb18b3d4449072fe9c345a9574796b is first bad commit
> commit c32ba30f76eb18b3d4449072fe9c345a9574796b
> Author: Paul Serice <paul@serice.net>
> Date:   Wed Jun 7 10:23:38 2006 -0700
> 
>     [PATCH] USB: EHCI works again on NVidia controllers with >2GB RAM
> 
>     From: Paul Serice <paul@serice.net>
> 
>     The workaround in commit f7201c3dcd7799f2aa3d6ec427b194225360ecee
>     broke.  The work around requires memory for DMA transfers for some
>     NVidia EHCI controllers to be below 2GB, but recent changes have
>     caused some DMA memory to be allocated before the DMA mask is set.
> 
>     Signed-off-by: Paul Serice <paul@serice.net>
>     Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> :040000 040000 754a9f8cccedc71e8e3689f2b0dee811d94fdc11 5559c0eafe042377430052272d027f0458805126 M      drivers
> 
> 
> What would be the way to revert that patch from 2.6.18-rc4 to confirm it's the culprit?
>  

Here's a backout patch, against 2.6.18-rc4:

From: Andrew Morton <akpm@osdl.org>

Revert c32ba30f76eb18b3d4449072fe9c345a9574796b: it broke Andrew Clayton's
machine.

Cc: Andrew Clayton <andrew@digital-domain.net>
Cc: Paul Serice <paul@serice.net>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/usb/host/ehci-pci.c |   39 +++++++++++++---------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff -puN drivers/usb/host/ehci-pci.c~revert-usb-ehci-works-again-on-nvidia-controllers-with-2gb-ram drivers/usb/host/ehci-pci.c
--- a/drivers/usb/host/ehci-pci.c~revert-usb-ehci-works-again-on-nvidia-controllers-with-2gb-ram
+++ a/drivers/usb/host/ehci-pci.c
@@ -76,30 +76,6 @@ static int ehci_pci_setup(struct usb_hcd
 	dbg_hcs_params(ehci, "reset");
 	dbg_hcc_params(ehci, "reset");
 
-        /* ehci_init() causes memory for DMA transfers to be
-         * allocated.  Thus, any vendor-specific workarounds based on
-         * limiting the type of memory used for DMA transfers must
-         * happen before ehci_init() is called. */
-	switch (pdev->vendor) {
-	case PCI_VENDOR_ID_NVIDIA:
-		/* NVidia reports that certain chips don't handle
-		 * QH, ITD, or SITD addresses above 2GB.  (But TD,
-		 * data buffer, and periodic schedule are normal.)
-		 */
-		switch (pdev->device) {
-		case 0x003c:	/* MCP04 */
-		case 0x005b:	/* CK804 */
-		case 0x00d8:	/* CK8 */
-		case 0x00e8:	/* CK8S */
-			if (pci_set_consistent_dma_mask(pdev,
-						DMA_31BIT_MASK) < 0)
-				ehci_warn(ehci, "can't enable NVidia "
-					"workaround for >2GB RAM\n");
-			break;
-		}
-		break;
-	}
-
 	/* cache this readonly data; minimize chip reads */
 	ehci->hcs_params = readl(&ehci->caps->hcs_params);
 
@@ -112,6 +88,8 @@ static int ehci_pci_setup(struct usb_hcd
 	if (retval)
 		return retval;
 
+	/* NOTE:  only the parts below this line are PCI-specific */
+
 	switch (pdev->vendor) {
 	case PCI_VENDOR_ID_TDI:
 		if (pdev->device == PCI_DEVICE_ID_TDI_EHCI) {
@@ -129,6 +107,19 @@ static int ehci_pci_setup(struct usb_hcd
 		break;
 	case PCI_VENDOR_ID_NVIDIA:
 		switch (pdev->device) {
+		/* NVidia reports that certain chips don't handle
+		 * QH, ITD, or SITD addresses above 2GB.  (But TD,
+		 * data buffer, and periodic schedule are normal.)
+		 */
+		case 0x003c:	/* MCP04 */
+		case 0x005b:	/* CK804 */
+		case 0x00d8:	/* CK8 */
+		case 0x00e8:	/* CK8S */
+			if (pci_set_consistent_dma_mask(pdev,
+						DMA_31BIT_MASK) < 0)
+				ehci_warn(ehci, "can't enable NVidia "
+					"workaround for >2GB RAM\n");
+			break;
 		/* Some NForce2 chips have problems with selective suspend;
 		 * fixed in newer silicon.
 		 */
_

