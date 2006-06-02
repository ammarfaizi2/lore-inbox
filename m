Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030295AbWFBVZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbWFBVZd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 17:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWFBVZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 17:25:33 -0400
Received: from smtp4.poczta.interia.pl ([80.48.65.10]:42427 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S1030295AbWFBVZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 17:25:32 -0400
Message-ID: <4480ACC0.2020806@interia.pl>
Date: Fri, 02 Jun 2006 23:25:20 +0200
From: =?windows-1252?Q?Rafa=3F_Bilski?= <rafalbilski@interia.pl>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PCI - Unnecessary high-level?
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-EMID: 5290acc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why pci_device->suspend() is called with pm_message_t?
IMO this is low-level PCI driver specific function.
All drivers are calling pci_choose_state(). If this function
would be called with pci_power_t maybe would be more PCI aware
code compatible. Maybe code below would be better? 


--- linux-2.6.17-rc5/include/linux/pci.h.orig	2006-05-31 09:00:42.000000000 +0200
+++ linux-2.6.17-rc5/include/linux/pci.h	2006-06-02 22:41:11.000000000 +0200
@@ -342,7 +342,7 @@ struct pci_driver {
 	const struct pci_device_id *id_table;	/* must be non-NULL for probe to be called */
 	int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
 	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
-	int  (*suspend) (struct pci_dev *dev, pm_message_t state);	/* Device suspended */
+	int  (*suspend) (struct pci_dev *dev, pci_power_t state);	/* Device suspended */
 	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
 	int  (*enable_wake) (struct pci_dev *dev, pci_power_t state, int enable);   /* Enable wake event */
 	void (*shutdown) (struct pci_dev *dev);


--- linux-2.6.17-rc5/drivers/pci/pci-driver.c.orig	2006-05-31 09:00:31.000000000 +0200
+++ linux-2.6.17-rc5/drivers/pci/pci-driver.c	2006-06-02 22:44:18.000000000 +0200
@@ -272,7 +272,7 @@ static int pci_device_suspend(struct dev
 	int i = 0;
 
 	if (drv && drv->suspend) {
-		i = drv->suspend(pci_dev, state);
+		i = drv->suspend( pci_dev, pci_choose_state(state) );
 		suspend_report_result(drv->suspend, i);
 	} else {
 		pci_save_state(pci_dev);


----------------------------------------------------------------------
Poznaj Stefana! Zmien komunikator! >>> http://link.interia.pl/f1924

