Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTKGWZL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbTKGWYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:24:46 -0500
Received: from mail.kroah.org ([65.200.24.183]:49320 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264600AbTKGT2m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 14:28:42 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1068233275468@kroah.com>
Subject: Re: [PATCH] More fixes for 2.6.0-test9
In-Reply-To: <1068233275660@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Nov 2003 11:27:55 -0800
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1420, 2003/11/07 10:19:35-08:00, david-b@pacbell.net

[PATCH] USB: usb ignores 64bit dma

The dma hooks whereby EHCI can pass 64bit DMA support
up the driver stack (to avoid buffer copies) turn out
to broken on most architectures(*).  This patch just
disables them all, since it looks like those mechanisms
won't get fixed before 2.6.0-final.  For now it'd only
matter on a few big Intel boxes anyway.

Please merge.

- Dave

(*) On x86, mips, and arm dma_supported() doesn't
     even compare with the device's mask.  On several
     other architectures (reported on ppc, alpha,
     and sparc64), asking that question for non-PCI
     devices will just BUG() -- even though all info
     needed to answer the question is right at hand.


 drivers/usb/host/ehci-hcd.c |    3 +++
 drivers/usb/net/kaweth.c    |    3 +++
 drivers/usb/net/usbnet.c    |    3 +++
 3 files changed, 9 insertions(+)


diff -Nru a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
--- a/drivers/usb/host/ehci-hcd.c	Fri Nov  7 11:22:04 2003
+++ b/drivers/usb/host/ehci-hcd.c	Fri Nov  7 11:22:04 2003
@@ -426,8 +426,11 @@
 	 */
 	if (HCC_64BIT_ADDR (hcc_params)) {
 		writel (0, &ehci->regs->segment);
+#if 0
+// this is deeply broken on almost all architectures
 		if (!pci_set_dma_mask (ehci->hcd.pdev, 0xffffffffffffffffULL))
 			ehci_info (ehci, "enabled 64bit PCI DMA\n");
+#endif
 	}
 
 	/* help hc dma work well with cachelines */
diff -Nru a/drivers/usb/net/kaweth.c b/drivers/usb/net/kaweth.c
--- a/drivers/usb/net/kaweth.c	Fri Nov  7 11:22:04 2003
+++ b/drivers/usb/net/kaweth.c	Fri Nov  7 11:22:04 2003
@@ -1120,8 +1120,11 @@
 
 	usb_set_intfdata(intf, kaweth);
 
+#if 0
+// dma_supported() is deeply broken on almost all architectures
 	if (dma_supported (&intf->dev, 0xffffffffffffffffULL))
 		kaweth->net->features |= NETIF_F_HIGHDMA;
+#endif
 
 	SET_NETDEV_DEV(netdev, &intf->dev);
 	if (register_netdev(netdev) != 0) {
diff -Nru a/drivers/usb/net/usbnet.c b/drivers/usb/net/usbnet.c
--- a/drivers/usb/net/usbnet.c	Fri Nov  7 11:22:04 2003
+++ b/drivers/usb/net/usbnet.c	Fri Nov  7 11:22:04 2003
@@ -2972,9 +2972,12 @@
 	strcpy (net->name, "usb%d");
 	memcpy (net->dev_addr, node_id, sizeof node_id);
 
+#if 0
+// dma_supported() is deeply broken on almost all architectures
 	// possible with some EHCI controllers
 	if (dma_supported (&udev->dev, 0xffffffffffffffffULL))
 		net->features |= NETIF_F_HIGHDMA;
+#endif
 
 	net->change_mtu = usbnet_change_mtu;
 	net->get_stats = usbnet_get_stats;

