Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268396AbTGTVRf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 17:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268419AbTGTVRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 17:17:35 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:16084 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S268396AbTGTVRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 17:17:33 -0400
Date: Sun, 20 Jul 2003 23:29:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: greg@kroah.com, kernel list <linux-kernel@vger.kernel.org>,
       ole.rohne@cern.ch
Subject: More powermanagment hooks for pci
Message-ID: <20030720212943.GA724@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Apparently, some pci driver (8390too) need to do something at poweron
before interrupts are enabled. Please apply,
								Pavel 

--- /usr/src/tmp/linux/drivers/pci/pci-driver.c	2003-07-06 20:07:38.000000000 +0200
+++ /usr/src/linux/drivers/pci/pci-driver.c	2003-07-20 22:42:26.000000000 +0200
@@ -179,11 +179,9 @@
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 
 	if (pci_dev->driver) {
-		/* We may not call PCI drivers resume at
-		   RESUME_POWER_ON because interrupts are not yet
-		   working at that point. Calling resume at
-		   RESUME_RESTORE_STATE seems like solution. */
-		if (level == RESUME_RESTORE_STATE && pci_dev->driver->resume)
+	        if (level == RESUME_POWER_ON && pci_dev->driver->power_on)
+			pci_dev->driver->power_on(pci_dev);
+		else if (level == RESUME_RESTORE_STATE && pci_dev->driver->resume)
 			pci_dev->driver->resume(pci_dev);
 	}
 	return 0;
--- /usr/src/tmp/linux/include/linux/pci.h	2003-07-11 21:38:47.000000000 +0200
+++ /usr/src/linux/include/linux/pci.h	2003-07-20 22:42:26.000000000 +0200
@@ -512,6 +512,7 @@
 	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
 	int  (*save_state) (struct pci_dev *dev, u32 state);    /* Save Device Context */
 	int  (*suspend) (struct pci_dev *dev, u32 state);	/* Device suspended */
+	int  (*power_on) (struct pci_dev *dev);	                /* Device power on */
 	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
 	int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);   /* Enable wake event */
 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
