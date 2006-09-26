Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751618AbWIZFvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbWIZFvL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbWIZFuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:50:35 -0400
Received: from ns2.suse.de ([195.135.220.15]:35285 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751380AbWIZFjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:39:13 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 22/47] PM: no suspend_prepare() phase
Date: Mon, 25 Sep 2006 22:37:42 -0700
Message-Id: <11592491551919-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592491512235-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491512
 235-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

Remove the new suspend_prepare() phase.  It doesn't seem very usable,
has never been tested, doesn't address fault cleanup, and would need
a sibling resume_complete(); plus there are no real use cases.  It
could be restored later if those issues get resolved.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Cc: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/power/suspend.c |   27 ---------------------------
 drivers/pci/pci-driver.c     |   14 --------------
 include/linux/device.h       |    1 -
 include/linux/pci.h          |    1 -
 kernel/power/main.c          |    4 ----
 5 files changed, 0 insertions(+), 47 deletions(-)

diff --git a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
index e86db83..6453c25 100644
--- a/drivers/base/power/suspend.c
+++ b/drivers/base/power/suspend.c
@@ -118,33 +118,6 @@ static int suspend_device_late(struct de
 }
 
 /**
- *	device_prepare_suspend - save state and prepare to suspend
- *
- *	NOTE! Devices cannot detach at this point - not only do we
- *	hold the device list semaphores over the whole prepare, but
- *	the whole point is to do non-invasive preparatory work, not
- *	the actual suspend.
- */
-int device_prepare_suspend(pm_message_t state)
-{
-	int error = 0;
-	struct device * dev;
-
-	down(&dpm_sem);
-	down(&dpm_list_sem);
-	list_for_each_entry_reverse(dev, &dpm_active, power.entry) {
-		if (!dev->bus || !dev->bus->suspend_prepare)
-			continue;
-		error = dev->bus->suspend_prepare(dev, state);
-		if (error)
-			break;
-	}
-	up(&dpm_list_sem);
-	up(&dpm_sem);
-	return error;
-}
-
-/**
  *	device_suspend - Save state and stop all devices in system.
  *	@state:		Power state to put each device in.
  *
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 9e7d6ce..8948ac9 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -264,19 +264,6 @@ static int pci_device_remove(struct devi
 	return 0;
 }
 
-static int pci_device_suspend_prepare(struct device * dev, pm_message_t state)
-{
-	struct pci_dev * pci_dev = to_pci_dev(dev);
-	struct pci_driver * drv = pci_dev->driver;
-	int i = 0;
-
-	if (drv && drv->suspend_prepare) {
-		i = drv->suspend_prepare(pci_dev, state);
-		suspend_report_result(drv->suspend_prepare, i);
-	}
-	return i;
-}
-
 static int pci_device_suspend(struct device * dev, pm_message_t state)
 {
 	struct pci_dev * pci_dev = to_pci_dev(dev);
@@ -544,7 +531,6 @@ struct bus_type pci_bus_type = {
 	.uevent		= pci_uevent,
 	.probe		= pci_device_probe,
 	.remove		= pci_device_remove,
-	.suspend_prepare= pci_device_suspend_prepare,
 	.suspend	= pci_device_suspend,
 	.suspend_late	= pci_device_suspend_late,
 	.resume_early	= pci_device_resume_early,
diff --git a/include/linux/device.h b/include/linux/device.h
index b40be6f..b364646 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -52,7 +52,6 @@ struct bus_type {
 	int		(*remove)(struct device * dev);
 	void		(*shutdown)(struct device * dev);
 
-	int (*suspend_prepare)(struct device * dev, pm_message_t state);
 	int (*suspend)(struct device * dev, pm_message_t state);
 	int (*suspend_late)(struct device * dev, pm_message_t state);
 	int (*resume_early)(struct device * dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4b2e629..9514bbf 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -345,7 +345,6 @@ struct pci_driver {
 	const struct pci_device_id *id_table;	/* must be non-NULL for probe to be called */
 	int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
 	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
-	int  (*suspend_prepare) (struct pci_dev *dev, pm_message_t state);
 	int  (*suspend) (struct pci_dev *dev, pm_message_t state);	/* Device suspended */
 	int  (*suspend_late) (struct pci_dev *dev, pm_message_t state);
 	int  (*resume_early) (struct pci_dev *dev);
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 0c3ed6a..6d295c7 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -57,10 +57,6 @@ static int suspend_prepare(suspend_state
 	if (!pm_ops || !pm_ops->enter)
 		return -EPERM;
 
-	error = device_prepare_suspend(PMSG_SUSPEND);
-	if (error)
-		return error;
-
 	pm_prepare_console();
 
 	disable_nonboot_cpus();
-- 
1.4.2.1

