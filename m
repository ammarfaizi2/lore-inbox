Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWATUAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWATUAI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 15:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWATUAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 15:00:08 -0500
Received: from gate.crashing.org ([63.228.1.57]:10627 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932112AbWATUAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 15:00:07 -0500
Date: Fri, 20 Jan 2006 13:52:57 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: dbrownell@users.sourceforge.net
cc: Randy Vinson <rvinson@mvista.com>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: [PATCH] USB: Work around errata in Freescale EHCI controller
Message-ID: <Pine.LNX.4.44.0601201351520.19827-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the MPC834x processors the multiport host (MPH) EHCI controller has an
errata in which the port number in the queue head expects to be 0..N-1
instead of 1..N.  If we are on one of these chips we subtract one from
the port number before putting it into the queue head.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit fe49a3f53c2572bf26a9dfd77e54fda1aa853887
tree 520c792893ce5d7b3a85228b71c83822f943799c
parent 0c9fa1fea4d28facfe2a28171a40a0fd47641f9a
author Kumar Gala <galak@kernel.crashing.org> Fri, 20 Jan 2006 13:57:34 -0600
committer Kumar Gala <galak@kernel.crashing.org> Fri, 20 Jan 2006 13:57:34 -0600

 drivers/usb/host/ehci-fsl.c |   10 ++++++++++
 drivers/usb/host/ehci-q.c   |    9 ++++++++-
 drivers/usb/host/ehci.h     |   14 ++++++++++++++
 3 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 8e68de6..6d82054 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -198,6 +198,16 @@ static void mpc83xx_usb_setup(struct usb
 		mpc83xx_setup_phy(ehci, pdata->phy_mode, 0);
 
 	if (pdata->operating_mode == FSL_USB2_MPH_HOST) {
+		unsigned int chip, rev, svr;
+
+		svr = mfspr(SPRN_SVR);
+		chip = svr >> 16;
+		rev = (svr >> 4) & 0xf;
+
+		/* Deal with USB Errata #14 on MPC834x Rev 1.0 & 1.1 chips */
+		if ((rev == 1) && (chip >= 0x8050) && (chip <= 0x8055))
+			ehci->has_fsl_port_bug = 1;
+
 		if (pdata->port_enables & FSL_USB2_PORT0_ENABLED)
 			mpc83xx_setup_phy(ehci, pdata->phy_mode, 0);
 		if (pdata->port_enables & FSL_USB2_PORT1_ENABLED)
diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index 9b13bf2..fd58cee 100644
--- a/drivers/usb/host/ehci-q.c
+++ b/drivers/usb/host/ehci-q.c
@@ -721,7 +721,14 @@ qh_make (
 		info1 |= maxp << 16;
 
 		info2 |= (EHCI_TUNE_MULT_TT << 30);
-		info2 |= urb->dev->ttport << 23;
+
+		/* Some Freescale processors have an errata in which the
+		 * port number in the queue head was 0..N-1 instead of 1..N.
+		 */
+		if (ehci_has_fsl_portno_bug(ehci))
+			info2 |= (urb->dev->ttport-1) << 23;
+		else
+			info2 |= urb->dev->ttport << 23;
 
 		/* set the address of the TT; for TDI's integrated
 		 * root hub tt, leave it zeroed.
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index 18e257c..5bcbbea 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -89,6 +89,8 @@ struct ehci_hcd {			/* one per controlle
 	u32			command;
 
 	unsigned		is_tdi_rh_tt:1;	/* TDI roothub with TT */
+	/* FSL controller with port number errata */
+	unsigned		has_fsl_port_bug:1;
 
 	/* irq statistics */
 #ifdef EHCI_STATS
@@ -638,6 +640,18 @@ ehci_port_speed(struct ehci_hcd *ehci, u
 
 /*-------------------------------------------------------------------------*/
 
+#ifdef CONFIG_PPC_83xx
+/* Some Freescale processors have an errata in which the
+ * port number in the queue head was 0..N-1 instead of 1..N.
+ */
+#define	ehci_has_fsl_portno_bug(e)		((e)->has_fsl_port_bug)
+#else
+#define	ehci_has_fsl_portno_bug(e)		(0)
+#endif
+
+
+/*-------------------------------------------------------------------------*/
+
 #ifndef DEBUG
 #define STUB_DEBUG_FILES
 #endif	/* DEBUG */

