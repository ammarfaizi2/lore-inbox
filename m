Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbTI3Wst (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 18:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbTI3Wsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 18:48:39 -0400
Received: from mail.kroah.org ([65.200.24.183]:38107 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261826AbTI3WrY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 18:47:24 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10649613491242@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test6
In-Reply-To: <1064961348862@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Sep 2003 15:35:49 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1305.5.3, 2003/09/26 09:38:37-07:00, mochel@osdl.org

[pci] Really delete drivers/pci/power.c


 drivers/pci/power.c |  159 ----------------------------------------------------
 1 files changed, 159 deletions(-)


diff -Nru a/drivers/pci/power.c b/drivers/pci/power.c
--- a/drivers/pci/power.c	Tue Sep 30 15:21:04 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,159 +0,0 @@
-#include <linux/pci.h>
-#include <linux/pm.h>
-#include <linux/init.h>
-
-/*
- * PCI Power management..
- *
- * This needs to be done centralized, so that we power manage PCI
- * devices in the right order: we should not shut down PCI bridges
- * before we've shut down the devices behind them, and we should
- * not wake up devices before we've woken up the bridge to the
- * device.. Eh?
- *
- * We do not touch devices that don't have a driver that exports
- * a suspend/resume function. That is just too dangerous. If the default
- * PCI suspend/resume functions work for a device, the driver can
- * easily implement them (ie just have a suspend function that calls
- * the pci_set_power_state() function).
- */
-
-static int pci_pm_save_state_device(struct pci_dev *dev, u32 state)
-{
-	int error = 0;
-	if (dev) {
-		struct pci_driver *driver = dev->driver;
-		if (driver && driver->save_state) 
-			error = driver->save_state(dev,state);
-	}
-	return error;
-}
-
-static int pci_pm_suspend_device(struct pci_dev *dev, u32 state)
-{
-	int error = 0;
-	if (dev) {
-		struct pci_driver *driver = dev->driver;
-		if (driver && driver->suspend)
-			error = driver->suspend(dev,state);
-	}
-	return error;
-}
-
-static int pci_pm_resume_device(struct pci_dev *dev)
-{
-	int error = 0;
-	if (dev) {
-		struct pci_driver *driver = dev->driver;
-		if (driver && driver->resume)
-			error = driver->resume(dev);
-	}
-	return error;
-}
-
-static int pci_pm_save_state_bus(struct pci_bus *bus, u32 state)
-{
-	struct list_head *list;
-	int error = 0;
-
-	list_for_each(list, &bus->children) {
-		error = pci_pm_save_state_bus(pci_bus_b(list),state);
-		if (error) return error;
-	}
-	list_for_each(list, &bus->devices) {
-		error = pci_pm_save_state_device(pci_dev_b(list),state);
-		if (error) return error;
-	}
-	return 0;
-}
-
-static int pci_pm_suspend_bus(struct pci_bus *bus, u32 state)
-{
-	struct list_head *list;
-
-	/* Walk the bus children list */
-	list_for_each(list, &bus->children) 
-		pci_pm_suspend_bus(pci_bus_b(list),state);
-
-	/* Walk the device children list */
-	list_for_each(list, &bus->devices)
-		pci_pm_suspend_device(pci_dev_b(list),state);
-	return 0;
-}
-
-static int pci_pm_resume_bus(struct pci_bus *bus)
-{
-	struct list_head *list;
-
-	/* Walk the device children list */
-	list_for_each(list, &bus->devices)
-		pci_pm_resume_device(pci_dev_b(list));
-
-	/* And then walk the bus children */
-	list_for_each(list, &bus->children)
-		pci_pm_resume_bus(pci_bus_b(list));
-	return 0;
-}
-
-static int pci_pm_save_state(u32 state)
-{
-	struct pci_bus *bus = NULL;
-	int error = 0;
-
-	while ((bus = pci_find_next_bus(bus)) != NULL) {
-		error = pci_pm_save_state_bus(bus,state);
-		if (!error)
-			error = pci_pm_save_state_device(bus->self,state);
-	}
-	return error;
-}
-
-static int pci_pm_suspend(u32 state)
-{
-	struct pci_bus *bus = NULL;
-
-	while ((bus = pci_find_next_bus(bus)) != NULL) {
-		pci_pm_suspend_bus(bus,state);
-		pci_pm_suspend_device(bus->self,state);
-	}
-	return 0;
-}
-
-static int pci_pm_resume(void)
-{
-	struct pci_bus *bus = NULL;
-
-	while ((bus = pci_find_next_bus(bus)) != NULL) {
-		pci_pm_resume_device(bus->self);
-		pci_pm_resume_bus(bus);
-	}
-	return 0;
-}
-
-static int 
-pci_pm_callback(struct pm_dev *pm_device, pm_request_t rqst, void *data)
-{
-	int error = 0;
-
-	switch (rqst) {
-	case PM_SAVE_STATE:
-		error = pci_pm_save_state((unsigned long)data);
-		break;
-	case PM_SUSPEND:
-		error = pci_pm_suspend((unsigned long)data);
-		break;
-	case PM_RESUME:
-		error = pci_pm_resume();
-		break;
-	default: break;
-	}
-	return error;
-}
-
-static int __init pci_pm_init(void)
-{
-	pm_register(PM_PCI_DEV, 0, pci_pm_callback);
-	return 0;
-}
-
-subsys_initcall(pci_pm_init);

