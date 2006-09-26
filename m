Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWIZFmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWIZFmr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWIZFlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:41:00 -0400
Received: from cantor.suse.de ([195.135.220.2]:2274 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751466AbWIZFkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:40:25 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 44/47] PCI: enable driver multi-threaded probe
Date: Mon, 25 Sep 2006 22:38:04 -0700
Message-Id: <1159249226922-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592492221573-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491512
 235-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com> <11592491672052-git-send-email-greg@kroah.com> <11592491704137-git-send-email-greg@kroah.com> <11592491744040-git-send-email-greg@kroah.com> <1159249177618-git-send-email-greg@kroah.com> <11592491803904-git-send-email-greg@kroah.com> <11592491833450-git-send-email-greg@kroah.com> <11592491862904-git-send-email-greg@kroah.com> <11592491901464-git-send-email-greg@kroah.com> <11592491924093-git-send-email-greg@kroah.com> <1159249196427-git-send-email-greg@kroah.com> <1159249200793-git-send-email-greg@kroah.com> <11592492023883-git-send-email-greg@kroah.com> <11592492061208-git-send-email-greg@kroah.com> <1159249209773-git-send-email-greg@kroah.com> <11592492123695-git-send-email-greg@kroah.com> <11592492153066-git-send-email-greg@kroah.com> <11592492193773-gi
 t-send-email-greg@kroah.com> <11592492221573-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

This provides a build and run-time option to turn on multhreaded probe
for all PCI drivers.  It can cause bad problems on multi-processor
machines that take a while to find their root disks, and play havoc on
machines that don't use persistant device names for block or network
devices.

But it can cause speedups on some machines, my tiny laptop's boot goes
up by 0.4 seconds, and my desktop boots up several seconds faster.

Use at your own risk!!!

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/pci/Kconfig      |   25 +++++++++++++++++++++++++
 drivers/pci/pci-driver.c |   11 +++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 4d762fc..c27e782 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -17,6 +17,31 @@ config PCI_MSI
 
 	   If you don't know what to do here, say N.
 
+config PCI_MULTITHREAD_PROBE
+	bool "PCI Multi-threaded probe (EXPERIMENTAL)"
+	depends on PCI && EXPERIMENTAL
+	help
+	  Say Y here if you want the PCI core to spawn a new thread for
+	  every PCI device that is probed.  This can cause a huge
+	  speedup in boot times on multiprocessor machines, and even a
+	  smaller speedup on single processor machines.
+
+	  But it can also cause lots of bad things to happen.  A number
+	  of PCI drivers can not properly handle running in this way,
+	  some will just not work properly at all, while others might
+	  decide to blow up power supplies with a huge load all at once,
+	  so use this option at your own risk.
+
+	  It is very unwise to use this option if you are not using a
+	  boot process that can handle devices being created in any
+	  order.  A program that can create persistant block and network
+	  device names (like udev) is a good idea if you wish to use
+	  this option.
+
+	  Again, use this option at your own risk, you have been warned!
+
+	  When in doubt, say N.
+
 config PCI_DEBUG
 	bool "PCI Debugging"
 	depends on PCI && DEBUG_KERNEL
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 8948ac9..d8ace1f 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -17,6 +17,16 @@ #include "pci.h"
  *  Registration of PCI drivers and handling of hot-pluggable devices.
  */
 
+/* multithreaded probe logic */
+static int pci_multithread_probe =
+#ifdef CONFIG_PCI_MULTITHREAD_PROBE
+	1;
+#else
+	0;
+#endif
+__module_param_call("", pci_multithread_probe, param_set_bool, param_get_bool, &pci_multithread_probe, 0644);
+
+
 /*
  * Dynamic device IDs are disabled for !CONFIG_HOTPLUG
  */
@@ -408,6 +418,7 @@ int __pci_register_driver(struct pci_dri
 	drv->driver.bus = &pci_bus_type;
 	drv->driver.owner = owner;
 	drv->driver.kobj.ktype = &pci_driver_kobj_type;
+	drv->driver.multithread_probe = pci_multithread_probe;
 
 	spin_lock_init(&drv->dynids.lock);
 	INIT_LIST_HEAD(&drv->dynids.list);
-- 
1.4.2.1

