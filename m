Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265433AbUBPSS0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 13:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265719AbUBPSS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 13:18:26 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:26764 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265433AbUBPSSY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 13:18:24 -0500
Subject: Re: [PATCH] PPC64 PCI Hotplug Driver for RPA
From: John Rose <johnrose@austin.ibm.com>
To: Rusty Russell <rusty@au1.ibm.com>
Cc: linux-kernel@vger.kernel.org, gregkh@us.ibm.com,
       Mike Wortman <wortman@us.ibm.com>
In-Reply-To: <20040215222211.4F99817DE7@ozlabs.au.ibm.com>
References: <20040215222211.4F99817DE7@ozlabs.au.ibm.com>
Content-Type: text/plain
Message-Id: <1076955537.10130.18.camel@verve.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 16 Feb 2004 12:18:57 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please:
> 	module_param(debug, int, 0644);

New patch below for this modification to the RPA PCI Hotplug Driver.

Thanks-
John

diff -Nru a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
--- a/drivers/pci/hotplug/Kconfig	Mon Feb 16 12:12:05 2004
+++ b/drivers/pci/hotplug/Kconfig	Mon Feb 16 12:12:05 2004
@@ -122,5 +122,16 @@
 
 	  When in doubt, say N.
 
+config HOTPLUG_PCI_RPA
+	tristate "RPA PCI Hotplug driver"
+	depends on HOTPLUG_PCI && PPC_PSERIES && PPC64
+	help
+	  Say Y here if you have a a RPA system that supports PCI Hotplug.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rpaphp.
+
+	  When in doubt, say N.
+
 endmenu
 
diff -Nru a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
--- a/drivers/pci/hotplug/Makefile	Mon Feb 16 12:12:05 2004
+++ b/drivers/pci/hotplug/Makefile	Mon Feb 16 12:12:05 2004
@@ -9,6 +9,7 @@
 obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+= acpiphp.o
 obj-$(CONFIG_HOTPLUG_PCI_CPCI_ZT5550)	+= cpcihp_zt5550.o
 obj-$(CONFIG_HOTPLUG_PCI_CPCI_GENERIC)	+= cpcihp_generic.o
+obj-$(CONFIG_HOTPLUG_PCI_RPA)		+= rpaphp.o
 
 pci_hotplug-objs	:=	pci_hotplug_core.o
 
@@ -32,6 +33,9 @@
 				acpiphp_glue.o	\
 				acpiphp_pci.o	\
 				acpiphp_res.o
+
+rpaphp-objs		:=	rpaphp_core.o	\
+				rpaphp_pci.o	
 
 ifdef CONFIG_HOTPLUG_PCI_ACPI
   EXTRA_CFLAGS  += -D_LINUX -I$(TOPDIR)/drivers/acpi
diff -Nru a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/pci/hotplug/rpaphp.h	Mon Feb 16 12:12:05 2004
@@ -0,0 +1,106 @@
+/*
+ * PCI Hot Plug Controller Driver for RPA-compliant PPC64 platform.
+ *
+ * Copyright (C) 2003 Linda Xie <lxie@us.ibm.com>
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify


