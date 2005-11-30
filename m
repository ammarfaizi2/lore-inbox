Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbVK3F6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbVK3F6r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 00:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbVK3F6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 00:58:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:30107 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750881AbVK3F6q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 00:58:46 -0500
Cc: david-b@pacbell.net
Subject: [PATCH] USB: ehci fixups
In-Reply-To: <1133330317951@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 29 Nov 2005 21:58:37 -0800
Message-Id: <1133330317542@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] USB: ehci fixups

Rename the EHCI "reset" routine so it better matches what it does (setup);
and move the one-time data structure setup earlier, before doing anything
that implicitly relies on it having been completed already.

From: David Brownell <david-b@pacbell.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 8926bfa7462d4c3f8b05cca929e0c4bcde93ae38
tree 52f6841e035827751efee6b4616f84606db70663
parent 8de98402652c01839ae321be6cb3054cf5735d83
author David Brownell <david-b@pacbell.net> Mon, 28 Nov 2005 08:40:38 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 29 Nov 2005 21:39:23 -0800

 drivers/usb/host/ehci-pci.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
index 14fff57..13f73a8 100644
--- a/drivers/usb/host/ehci-pci.c
+++ b/drivers/usb/host/ehci-pci.c
@@ -121,8 +121,8 @@ static int ehci_pci_reinit(struct ehci_h
 	return 0;
 }
 
-/* called by khubd or root hub (re)init threads; leaves HC in halt state */
-static int ehci_pci_reset(struct usb_hcd *hcd)
+/* called during probe() after chip reset completes */
+static int ehci_pci_setup(struct usb_hcd *hcd)
 {
 	struct ehci_hcd		*ehci = hcd_to_ehci(hcd);
 	struct pci_dev		*pdev = to_pci_dev(hcd->self.controller);
@@ -141,6 +141,11 @@ static int ehci_pci_reset(struct usb_hcd
 	if (retval)
 		return retval;
 
+	/* data structure init */
+	retval = ehci_init(hcd);
+	if (retval)
+		return retval;
+
 	/* NOTE:  only the parts below this line are PCI-specific */
 
 	switch (pdev->vendor) {
@@ -154,7 +159,8 @@ static int ehci_pci_reset(struct usb_hcd
 		/* AMD8111 EHCI doesn't work, according to AMD errata */
 		if (pdev->device == 0x7463) {
 			ehci_info(ehci, "ignoring AMD8111 (errata)\n");
-			return -EIO;
+			retval = -EIO;
+			goto done;
 		}
 		break;
 	case PCI_VENDOR_ID_NVIDIA:
@@ -207,9 +213,8 @@ static int ehci_pci_reset(struct usb_hcd
 	/* REVISIT:  per-port wake capability (PCI 0x62) currently unused */
 
 	retval = ehci_pci_reinit(ehci, pdev);
-
-	/* finish init */
-	return ehci_init(hcd);
+done:
+	return retval;
 }
 
 /*-------------------------------------------------------------------------*/
@@ -344,7 +349,7 @@ static const struct hc_driver ehci_pci_h
 	/*
 	 * basic lifecycle operations
 	 */
-	.reset =		ehci_pci_reset,
+	.reset =		ehci_pci_setup,
 	.start =		ehci_run,
 #ifdef	CONFIG_PM
 	.suspend =		ehci_pci_suspend,

