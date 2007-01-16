Return-Path: <linux-kernel-owner+w=401wt.eu-S1750917AbXAPLPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbXAPLPd (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 06:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbXAPLPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 06:15:33 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59989 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750788AbXAPLPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 06:15:32 -0500
Date: Tue, 16 Jan 2007 12:15:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       gregkh@elf.ucw.cz
Subject: pci power management: remove noise on non-manageable hw
Message-ID: <20070116111507.GA19343@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Return early from pci_set_power_state() if hardware does not support
power management. This way, we do not generate noise in the logs.

Signed-off-by: Pavel Machek <pavel@suse.cz>


diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 206c834..6158497 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -392,6 +392,14 @@ pci_set_power_state(struct pci_dev *dev,
 	if (state > PCI_D3hot)
 		state = PCI_D3hot;
 
+	/*
+	 * If the device or the parent bridge can't support PCI PM, ignore
+	 * the request if we're doing anything besides putting it into D0
+	 * (which would only happen on boot).
+	 */
+	if ((state == PCI_D1 || state == PCI_D2) && pci_no_d1d2(dev))
+		return 0;
+
 	/* Validate current state:
 	 * Can enter D0 from any state, but if we can only go deeper 
 	 * to sleep if we're already in a low power state
@@ -403,13 +411,6 @@ pci_set_power_state(struct pci_dev *dev,
 	} else if (dev->current_state == state)
 		return 0;        /* we're already there */
 
-	/*
-	 * If the device or the parent bridge can't support PCI PM, ignore
-	 * the request if we're doing anything besides putting it into D0
-	 * (which would only happen on boot).
-	 */
-	if ((state == PCI_D1 || state == PCI_D2) && pci_no_d1d2(dev))
-		return 0;
 
 	/* find PCI PM capability in list */
 	pm = pci_find_capability(dev, PCI_CAP_ID_PM);

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
