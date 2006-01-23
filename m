Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbWAWWQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbWAWWQO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 17:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbWAWWQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 17:16:14 -0500
Received: from gate.crashing.org ([63.228.1.57]:35749 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964954AbWAWWQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 17:16:13 -0500
Date: Mon, 23 Jan 2006 16:08:49 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: dbrownell@users.sourceforge.net
cc: Randy Vinson <rvinson@mvista.com>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: [PATCH] USB: Disable clock for MPH ports not in use on Freescale
 EHCI
Message-ID: <Pine.LNX.4.44.0601231607080.19842-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In some systems using the Freescale EHCI controller if only one port
of the multiport host (MPH) is being used the other port must be
disabled if there is no clock signal.  Since we dont know how someone
will wire a board, we disable the clock if the port is not enabled.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 984d42232fd47ddbeef7c825ec2bafbca9aed5a0
tree 166532f0cd229b1a6f090c43b3617fd49ff3068a
parent 2497a5e4242d500178d6d0f0ce4ee9249a38f5dc
author Kumar Gala <galak@kernel.crashing.org> Mon, 23 Jan 2006 16:13:21 -0600
committer Kumar Gala <galak@kernel.crashing.org> Mon, 23 Jan 2006 16:13:21 -0600

 drivers/usb/host/ehci-fsl.c |    7 +++++++
 drivers/usb/host/ehci-fsl.h |    1 +
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index f40ee41..032fa6b 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -161,6 +161,7 @@ static void mpc83xx_setup_phy(struct ehc
 			      unsigned int port_offset)
 {
 	u32 portsc = 0;
+
 	switch (phy_mode) {
 	case FSL_USB2_PHY_ULPI:
 		portsc |= PORT_PTS_ULPI;
@@ -175,6 +176,7 @@ static void mpc83xx_setup_phy(struct ehc
 		portsc |= PORT_PTS_UTMI;
 		break;
 	case FSL_USB2_PHY_NONE:
+		portsc |= PORT_PHCD;
 		break;
 	}
 	writel(portsc, &ehci->regs->port_status[port_offset]);
@@ -209,8 +211,13 @@ static void mpc83xx_usb_setup(struct usb
 
 		if (pdata->port_enables & FSL_USB2_PORT0_ENABLED)
 			mpc83xx_setup_phy(ehci, pdata->phy_mode, 0);
+		else
+			mpc83xx_setup_phy(ehci, FSL_USB2_PHY_NONE, 0);
+
 		if (pdata->port_enables & FSL_USB2_PORT1_ENABLED)
 			mpc83xx_setup_phy(ehci, pdata->phy_mode, 1);
+		else
+			mpc83xx_setup_phy(ehci, FSL_USB2_PHY_NONE, 1);
 	}
 
 	/* put controller in host mode. */
diff --git a/drivers/usb/host/ehci-fsl.h b/drivers/usb/host/ehci-fsl.h
index caac0d1..f579254 100644
--- a/drivers/usb/host/ehci-fsl.h
+++ b/drivers/usb/host/ehci-fsl.h
@@ -26,6 +26,7 @@
 #define PORT_PTS_ULPI		(2<<30)
 #define	PORT_PTS_SERIAL		(3<<30)
 #define PORT_PTS_PTW		(1<<28)
+#define PORT_PHCD		(1<<23)
 #define FSL_SOC_USB_PORTSC2	0x188
 #define FSL_SOC_USB_USBMODE	0x1a8
 #define FSL_SOC_USB_SNOOP1	0x400	/* NOTE: big-endian */

