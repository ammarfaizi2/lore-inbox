Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbUKSWAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbUKSWAK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbUKSV7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 16:59:01 -0500
Received: from mail.kroah.org ([69.55.234.183]:13463 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261622AbUKSV5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 16:57:04 -0500
Date: Fri, 19 Nov 2004 13:56:41 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PCI fixes for 2.6.10-rc2
Message-ID: <20041119215640.GB15863@kroah.com>
References: <20041119215618.GA15863@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119215618.GA15863@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.2164, 2004/11/19 10:01:54-08:00, bunk@stusta.de

[PATCH] PCI Hotplug: remove unused drivers/pci/hotplug/pciehp_sysfs.c

Remove unused the drivers/pci/hotplug/pciehp_sysfs.c

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/pciehp_sysfs.c |  143 -------------------------------------
 drivers/pci/hotplug/Makefile       |    1 
 drivers/pci/hotplug/pciehp.h       |    3 
 3 files changed, 147 deletions(-)


diff -Nru a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
--- a/drivers/pci/hotplug/Makefile	2004-11-19 13:20:15 -08:00
+++ b/drivers/pci/hotplug/Makefile	2004-11-19 13:20:15 -08:00
@@ -51,7 +51,6 @@
 pciehp-objs		:=	pciehp_core.o	\
 				pciehp_ctrl.o	\
 				pciehp_pci.o	\
-				pciehp_sysfs.o	\
 				pciehp_hpc.o
 ifdef CONFIG_ACPI_BUS
 	pciehp-objs += pciehprm_acpi.o
diff -Nru a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
--- a/drivers/pci/hotplug/pciehp.h	2004-11-19 13:20:15 -08:00
+++ b/drivers/pci/hotplug/pciehp.h	2004-11-19 13:20:15 -08:00
@@ -207,9 +207,6 @@
 #define msg_button_cancel	"PCI slot #%d - action canceled due to button press.\n"
 #define msg_button_ignore	"PCI slot #%d - button press ignored.  (action in progress...)\n"
 
-/* sysfs function for the hotplug controller info */
-extern void pciehp_create_ctrl_files	(struct controller *ctrl);
-
 /* controller functions */
 extern int	pciehprm_find_available_resources	(struct controller *ctrl);
 extern int	pciehp_event_start_thread	(void);
diff -Nru a/drivers/pci/hotplug/pciehp_sysfs.c b/drivers/pci/hotplug/pciehp_sysfs.c
--- a/drivers/pci/hotplug/pciehp_sysfs.c	2004-11-19 13:20:15 -08:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,143 +0,0 @@
-/*
- * PCI Express Hot Plug Controller Driver
- *
- * Copyright (C) 1995,2001 Compaq Computer Corporation
- * Copyright (C) 2001,2003 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (C) 2001 IBM Corp.
- *
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or (at
- * your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
- * NON INFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * Send feedback to <greg@kroah.com>
- *
- */
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/proc_fs.h>
-#include <linux/workqueue.h>
-#include <linux/pci.h>
-#include "pciehp.h"
-
-
-/* A few routines that create sysfs entries for the hot plug controller */
-
-static ssize_t show_ctrl (struct device *dev, char *buf)
-{
-	struct pci_dev *pci_dev;
-	struct controller *ctrl;
-	char * out = buf;
-	int index;
-	struct pci_resource *res;
-
-	pci_dev = container_of (dev, struct pci_dev, dev);
-	ctrl = pci_get_drvdata(pci_dev);
-
-	out += sprintf(buf, "Free resources: memory\n");
-	index = 11;
-	res = ctrl->mem_head;
-	while (res && index--) {
-		out += sprintf(out, "start = %8.8x, length = %8.8x\n", res->base, res->length);
-		res = res->next;
-	}
-	out += sprintf(out, "Free resources: prefetchable memory\n");
-	index = 11;
-	res = ctrl->p_mem_head;
-	while (res && index--) {
-		out += sprintf(out, "start = %8.8x, length = %8.8x\n", res->base, res->length);
-		res = res->next;
-	}
-	out += sprintf(out, "Free resources: IO\n");
-	index = 11;
-	res = ctrl->io_head;
-	while (res && index--) {
-		out += sprintf(out, "start = %8.8x, length = %8.8x\n", res->base, res->length);
-		res = res->next;
-	}
-	out += sprintf(out, "Free resources: bus numbers\n");
-	index = 11;
-	res = ctrl->bus_head;
-	while (res && index--) {
-		out += sprintf(out, "start = %8.8x, length = %8.8x\n", res->base, res->length);
-		res = res->next;
-	}
-
-	return out - buf;
-}
-static DEVICE_ATTR (ctrl, S_IRUGO, show_ctrl, NULL);
-
-static ssize_t show_dev (struct device *dev, char *buf)
-{
-	struct pci_dev *pci_dev;
-	struct controller *ctrl;
-	char * out = buf;
-	int index;
-	struct pci_resource *res;
-	struct pci_func *new_slot;
-	struct slot *slot;
-
-	pci_dev = container_of (dev, struct pci_dev, dev);
-	ctrl = pci_get_drvdata(pci_dev);
-
-	slot=ctrl->slot;
-
-	while (slot) {
-		new_slot = pciehp_slot_find(slot->bus, slot->device, 0);
-		if (!new_slot)
-			break;
-		out += sprintf(out, "assigned resources: memory\n");
-		index = 11;
-		res = new_slot->mem_head;
-		while (res && index--) {
-			out += sprintf(out, "start = %8.8x, length = %8.8x\n", res->base, res->length);
-			res = res->next;
-		}
-		out += sprintf(out, "assigned resources: prefetchable memory\n");
-		index = 11;
-		res = new_slot->p_mem_head;
-		while (res && index--) {
-			out += sprintf(out, "start = %8.8x, length = %8.8x\n", res->base, res->length);
-			res = res->next;
-		}
-		out += sprintf(out, "assigned resources: IO\n");
-		index = 11;
-		res = new_slot->io_head;
-		while (res && index--) {
-			out += sprintf(out, "start = %8.8x, length = %8.8x\n", res->base, res->length);
-			res = res->next;
-		}
-		out += sprintf(out, "assigned resources: bus numbers\n");
-		index = 11;
-		res = new_slot->bus_head;
-		while (res && index--) {
-			out += sprintf(out, "start = %8.8x, length = %8.8x\n", res->base, res->length);
-			res = res->next;
-		}
-		slot=slot->next;
-	}
-
-	return out - buf;
-}
-static DEVICE_ATTR (dev, S_IRUGO, show_dev, NULL);
-
-void pciehp_create_ctrl_files (struct controller *ctrl)
-{
-	device_create_file (&ctrl->pci_dev->dev, &dev_attr_ctrl);
-	device_create_file (&ctrl->pci_dev->dev, &dev_attr_dev);
-}
