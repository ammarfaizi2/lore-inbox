Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270605AbTGZWqm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 18:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270626AbTGZWql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 18:46:41 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:32661 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S270605AbTGZWpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 18:45:54 -0400
Date: Sun, 27 Jul 2003 01:00:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: [PM] more callbacks for pci powermanagment
Message-ID: <20030726230059.GA546@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Some PCI devices need to act during power-on... Greg refused to apply
it waiting for you, but you probably remember that discussion.

								Pavel

Index: linux/drivers/pci/pci-driver.c
===================================================================
--- linux.orig/drivers/pci/pci-driver.c	2003-07-22 13:39:43.000000000 +0200
+++ linux/drivers/pci/pci-driver.c	2003-07-22 13:26:26.000000000 +0200
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
Index: linux/include/linux/pci.h
===================================================================
--- linux.orig/include/linux/pci.h	2003-07-22 13:39:42.000000000 +0200
+++ linux/include/linux/pci.h	2003-07-22 13:26:52.000000000 +0200
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
