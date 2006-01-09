Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbWAIRIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbWAIRIe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWAIRIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:08:34 -0500
Received: from [81.2.110.250] ([81.2.110.250]:46753 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S964883AbWAIRIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:08:34 -0500
Subject: PATCH: EDAC - change default, also handle pulled hardware
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 09 Jan 2006 17:11:29 +0000
Message-Id: <1136826689.6659.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a card reports 0xFFFF check if the devid is also all 0xFFFFFFFF and
if so assume the card was pulled rather than showing parity errors. This
avoids us spewing errors when a card is yanked and hotplug hasn't caught
up with it.

Also default PCI scan to off as it has a performance impact and is
relevant to a minority of users only. Users can enable it when they need
it.

Alan

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-mm2/drivers/edac/edac_mc.c linux-2.6.15-mm2/drivers/edac/edac_mc.c
--- linux.vanilla-2.6.15-mm2/drivers/edac/edac_mc.c	2006-01-09 14:33:44.000000000 +0000
+++ linux-2.6.15-mm2/drivers/edac/edac_mc.c	2006-01-09 14:54:10.000000000 +0000
@@ -53,7 +53,7 @@
 static int panic_on_ue = 1;
 static int poll_msec = 1000;
 
-static int check_pci_parity = 1;	/* default YES check PCI parity */
+static int check_pci_parity = 0;	/* default NO check PCI parity */
 static int panic_on_pci_parity = 0;	/* default no panic on PCI Parity */
 static atomic_t pci_parity_count = ATOMIC_INIT(0);
 
@@ -1755,6 +1755,17 @@
 
 	where = secondary ? PCI_SEC_STATUS : PCI_STATUS;
 	pci_read_config_word(dev, where, &status);
+	
+	/* If we get back 0xFFFF then we must suspect that the card has been pulled but
+	   the Linux PCI layer has not yet finished cleaning up. We don't want to report
+	   on such devices */
+	   
+	if (status == 0xFFFF) {
+		u32 sanity;
+		pci_read_config_dword(dev, 0, &sanity);
+		if (sanity == 0xFFFFFFFF)
+			return 0;
+	}
 	status &= PCI_STATUS_DETECTED_PARITY | PCI_STATUS_SIG_SYSTEM_ERROR |
 		  PCI_STATUS_PARITY;
 

