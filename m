Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264298AbTCYXDo>; Tue, 25 Mar 2003 18:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264306AbTCYXDo>; Tue, 25 Mar 2003 18:03:44 -0500
Received: from fw-az.mvista.com ([65.200.49.158]:48110 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S264298AbTCYXDk>; Tue, 25 Mar 2003 18:03:40 -0500
Date: Tue, 25 Mar 2003 16:16:22 -0700
From: Deepak Saxena <dsaxena@mvista.com>
To: mochel@osdl.org, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] Make root PCI bus child of system_bus in device tree
Message-ID: <20030325231622.GA8231@xanadu.az.mvista.com>
Reply-To: dsaxena@mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: MontaVista Software, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

The following patch updates the PCI subsystem so that root PCI host 
bridges appear as devices hanging off the system bus instead of root 
level devices.  To me, this makes more sense from a topology point of 
view since most systems look as such:

  cpu0 <-- sys_bus --> Memory Controller/PCI Bridge  <-- sys_bus --> cpu1
                                  |
                                  |
                                  |
  <---------------------------- Root Level PCI Bus -------------------->


Even on system on a chip designs, the PCI bridge unit and the CPU core are 
physically connected over the system bus.  A PCI host bridge always connects 
the system/cpu/local bus to the PCI bus, so I think the device tree should 
represent this.  

I'm not sure if this is the best solution as we could have embedded systems 
where the root PCI bus is hanging off from something like a Rapid I/O bus or 
other non-CPU bus, so maybe we should just kill pci_scan_bus() and force all 
platforms to use pci_scan_bus_parented() so developers can best determine how 
to map their system's topology to the device tree?

Thanks,
~Deepak


diff -Nru a/drivers/base/sys.c b/drivers/base/sys.c
--- a/drivers/base/sys.c	Tue Mar 25 16:07:06 2003
+++ b/drivers/base/sys.c	Tue Mar 25 16:07:06 2003
@@ -21,7 +21,7 @@
 #include <linux/string.h>
 
 /* The default system device parent. */
-static struct device system_bus = {
+struct device system_bus = {
        .name           = "System Bus",
        .bus_id         = "sys",
 };
@@ -144,6 +144,7 @@
 	return device_register(&system_bus);
 }
 
+EXPORT_SYMBOL(system_bus);
 EXPORT_SYMBOL(system_bus_type);
 EXPORT_SYMBOL(sys_device_register);
 EXPORT_SYMBOL(sys_device_unregister);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Tue Mar 25 16:07:06 2003
+++ b/include/linux/device.h	Tue Mar 25 16:07:06 2003
@@ -353,6 +353,7 @@
 extern void sys_device_unregister(struct sys_device *);
 
 extern struct bus_type system_bus_type;
+extern struct device system_bus;
 
 /* drivers/base/platform.c */
 
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Tue Mar 25 16:07:06 2003
+++ b/include/linux/pci.h	Tue Mar 25 16:07:06 2003
@@ -537,12 +537,12 @@
 struct pci_bus *pci_scan_bus_parented(struct device *parent, int bus, struct pci_ops *ops, void *sysdata);
 static inline struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata)
 {
-	return pci_scan_bus_parented(NULL, bus, ops, sysdata);
+	return pci_scan_bus_parented(&system_bus, bus, ops, sysdata);
 }
 struct pci_bus *pci_alloc_primary_bus_parented(struct device * parent, int bus);
 static inline struct pci_bus *pci_alloc_primary_bus(int bus)
 {
-	return pci_alloc_primary_bus_parented(NULL, bus);
+	return pci_alloc_primary_bus_parented(&system_bus, bus);
 }
 int pci_scan_slot(struct pci_bus *bus, int devfn);
 void pci_bus_add_devices(struct pci_bus *bus);

-- 
Deepak Saxena
MontaVista Software - Powering the Embedded Revolution - www.mvista.com

