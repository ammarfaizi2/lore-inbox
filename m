Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWIZFjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWIZFjK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWIZFiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:38:52 -0400
Received: from mx1.suse.de ([195.135.220.2]:47841 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751339AbWIZFie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:38:34 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 10/47] Suspend changes for PCI core
Date: Mon, 25 Sep 2006 22:37:30 -0700
Message-Id: <11592491152668-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <1159249111668-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>

Changes the PCI core to use the new suspend infrastructure changes.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/pci/pci-driver.c |   41 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/pci.h      |    3 +++
 2 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 474e9cd..9e7d6ce 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -264,6 +264,19 @@ static int pci_device_remove(struct devi
 	return 0;
 }
 
+static int pci_device_suspend_prepare(struct device * dev, pm_message_t state)
+{
+	struct pci_dev * pci_dev = to_pci_dev(dev);
+	struct pci_driver * drv = pci_dev->driver;
+	int i = 0;
+
+	if (drv && drv->suspend_prepare) {
+		i = drv->suspend_prepare(pci_dev, state);
+		suspend_report_result(drv->suspend_prepare, i);
+	}
+	return i;
+}
+
 static int pci_device_suspend(struct device * dev, pm_message_t state)
 {
 	struct pci_dev * pci_dev = to_pci_dev(dev);
@@ -279,6 +292,18 @@ static int pci_device_suspend(struct dev
 	return i;
 }
 
+static int pci_device_suspend_late(struct device * dev, pm_message_t state)
+{
+	struct pci_dev * pci_dev = to_pci_dev(dev);
+	struct pci_driver * drv = pci_dev->driver;
+	int i = 0;
+
+	if (drv && drv->suspend_late) {
+		i = drv->suspend_late(pci_dev, state);
+		suspend_report_result(drv->suspend_late, i);
+	}
+	return i;
+}
 
 /*
  * Default resume method for devices that have no driver provided resume,
@@ -313,6 +338,17 @@ static int pci_device_resume(struct devi
 	return error;
 }
 
+static int pci_device_resume_early(struct device * dev)
+{
+	int error = 0;
+	struct pci_dev * pci_dev = to_pci_dev(dev);
+	struct pci_driver * drv = pci_dev->driver;
+
+	if (drv && drv->resume_early)
+		error = drv->resume_early(pci_dev);
+	return error;
+}
+
 static void pci_device_shutdown(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
@@ -508,9 +544,12 @@ struct bus_type pci_bus_type = {
 	.uevent		= pci_uevent,
 	.probe		= pci_device_probe,
 	.remove		= pci_device_remove,
+	.suspend_prepare= pci_device_suspend_prepare,
 	.suspend	= pci_device_suspend,
-	.shutdown	= pci_device_shutdown,
+	.suspend_late	= pci_device_suspend_late,
+	.resume_early	= pci_device_resume_early,
 	.resume		= pci_device_resume,
+	.shutdown	= pci_device_shutdown,
 	.dev_attrs	= pci_dev_attrs,
 };
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8565b81..4b2e629 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -345,7 +345,10 @@ struct pci_driver {
 	const struct pci_device_id *id_table;	/* must be non-NULL for probe to be called */
 	int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
 	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
+	int  (*suspend_prepare) (struct pci_dev *dev, pm_message_t state);
 	int  (*suspend) (struct pci_dev *dev, pm_message_t state);	/* Device suspended */
+	int  (*suspend_late) (struct pci_dev *dev, pm_message_t state);
+	int  (*resume_early) (struct pci_dev *dev);
 	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
 	int  (*enable_wake) (struct pci_dev *dev, pci_power_t state, int enable);   /* Enable wake event */
 	void (*shutdown) (struct pci_dev *dev);
-- 
1.4.2.1

