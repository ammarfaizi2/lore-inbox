Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbULAAXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbULAAXY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbULAAUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:20:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:50404 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261282AbULAAOZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:14:25 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] More PCI fixes for 2.6.10-rc2
User-Agent: Mutt/1.5.6i
In-Reply-To: <1101859804222@kroah.com>
Date: Tue, 30 Nov 2004 16:10:04 -0800
Message-Id: <11018598042987@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2223.2.3, 2004/11/29 11:12:54-08:00, ak@suse.de

[PATCH] PCI: Add sysfs file to map PCI busses to cpus

Add sysfs file to map PCI busses to cpus

Export the information from pcibus_to_cpumask() to sysfs. This
is useful for some user space programs who want to optimize their IO
using O_DIRECT.

There was some indecision on whether it's more useful to report
cpus or nodes here. In the end cpus was chosen because that is
what the existing macros report.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci-sysfs.c |   11 +++++++++++
 1 files changed, 11 insertions(+)


diff -Nru a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
--- a/drivers/pci/pci-sysfs.c	2004-11-30 15:47:18 -08:00
+++ b/drivers/pci/pci-sysfs.c	2004-11-30 15:47:18 -08:00
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/stat.h>
+#include <linux/topology.h>
 
 #include "pci.h"
 
@@ -42,6 +43,15 @@
 pci_config_attr(class, "0x%06x\n");
 pci_config_attr(irq, "%u\n");
 
+static ssize_t local_cpus_show(struct device *dev, char *buf)
+{		
+	struct pci_dev *pdev = to_pci_dev(dev);
+	cpumask_t mask = pcibus_to_cpumask(pdev->bus->number);
+	int len = cpumask_scnprintf(buf, PAGE_SIZE-2, mask);
+	strcat(buf,"\n"); 
+	return 1+len;
+}
+
 /* show resources */
 static ssize_t
 resource_show(struct device * dev, char * buf)
@@ -71,6 +81,7 @@
 	__ATTR_RO(subsystem_device),
 	__ATTR_RO(class),
 	__ATTR_RO(irq),
+	__ATTR_RO(local_cpus),
 	__ATTR_NULL,
 };
 

