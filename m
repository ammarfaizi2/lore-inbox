Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbVAJRi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbVAJRi0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbVAJRfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:35:46 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:39313 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262364AbVAJRVI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:21:08 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI patches for 2.6.10
User-Agent: Mutt/1.5.6i
In-Reply-To: <11053776585@kroah.com>
Date: Mon, 10 Jan 2005 09:20:58 -0800
Message-Id: <11053776582129@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.447.14, 2004/12/21 16:21:25-08:00, pavel@suse.cz

[PATCH] PCI: clean up state usage in pci core

> Now, care to send patches to fix up all of the new sparse warnings in
> the drivers/pci/* directory?

This should reduce number of warnings in pci.c. It will still warn on
comparison (because we are using __bitwise, but in fact we want
something like "this is unique but arithmetic is still ok"), but that
probably needs to be fixed in sparse.

Also killed "function does not return anything" warning.


Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)


diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	2005-01-10 09:00:25 -08:00
+++ b/drivers/pci/pci.c	2005-01-10 09:00:25 -08:00
@@ -248,13 +248,14 @@
 	u16 pmcsr, pmc;
 
 	/* bound the state we're entering */
-	if (state > 3) state = 3;
+	if (state > PCI_D3hot)
+		state = PCI_D3hot;
 
 	/* Validate current state:
 	 * Can enter D0 from any state, but if we can only go deeper 
 	 * to sleep if we're already in a low power state
 	 */
-	if (state > 0 && dev->current_state > state)
+	if (state != PCI_D0 && dev->current_state > state)
 		return -EINVAL;
 	else if (dev->current_state == state) 
 		return 0;        /* we're already there */
@@ -263,7 +264,8 @@
 	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
 	
 	/* abort if the device doesn't support PM capabilities */
-	if (!pm) return -EIO; 
+	if (!pm)
+		return -EIO; 
 
 	pci_read_config_word(dev,pm + PCI_PM_PMC,&pmc);
 	if ((pmc & PCI_PM_CAP_VER_MASK) != 2) {
@@ -274,16 +276,18 @@
 	}
 
 	/* check if this device supports the desired state */
-	if (state == 1 || state == 2) {
-		if (state == 1 && !(pmc & PCI_PM_CAP_D1)) return -EIO;
-		else if (state == 2 && !(pmc & PCI_PM_CAP_D2)) return -EIO;
+	if (state == PCI_D1 || state == PCI_D2) {
+		if (state == PCI_D1 && !(pmc & PCI_PM_CAP_D1))
+			return -EIO;
+		else if (state == PCI_D2 && !(pmc & PCI_PM_CAP_D2))
+			return -EIO;
 	}
 
 	/* If we're in D3, force entire word to 0.
 	 * This doesn't affect PME_Status, disables PME_En, and
 	 * sets PowerState to 0.
 	 */
-	if (dev->current_state >= 3)
+	if (dev->current_state >= PCI_D3hot)
 		pmcsr = 0;
 	else {
 		pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
@@ -296,9 +300,9 @@
 
 	/* Mandatory power management transition delays */
 	/* see PCI PM 1.1 5.6.1 table 18 */
-	if(state == 3 || dev->current_state == 3)
+	if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
 		msleep(10);
-	else if(state == 2 || dev->current_state == 2)
+	else if (state == PCI_D2 || dev->current_state == PCI_D2)
 		udelay(200);
 	dev->current_state = state;
 
@@ -325,6 +329,7 @@
 	case 3: return PCI_D3hot;
 	default: BUG();
 	}
+	return PCI_D0;
 }
 
 EXPORT_SYMBOL(pci_choose_state);

