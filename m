Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbUB1AMi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 19:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263222AbUB1AKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 19:10:06 -0500
Received: from mail.kroah.org ([65.200.24.183]:49829 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263218AbUB1AJq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 19:09:46 -0500
Subject: Re: [PATCH] PCI fixes for 2.6.4-rc1
In-Reply-To: <10779269821259@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 27 Feb 2004 16:09:43 -0800
Message-Id: <10779269831109@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1616, 2004/02/24 11:08:13-08:00, lxiep@ltcfwd.linux.ibm.com

[PATCH] PCI Hotplug: fix rpaphp bugs

The attached patch has a fix for the conflict between  fakephp and
rpaphp so that fakephp and rpaphp can't be built into the kernel at the
same time and a couple of  problems I missed in my previous patch.
(Sorry about that).


 drivers/pci/hotplug/Kconfig       |    2 +-
 drivers/pci/hotplug/rpaphp.h      |    2 +-
 drivers/pci/hotplug/rpaphp_core.c |    4 +---
 3 files changed, 3 insertions(+), 5 deletions(-)


diff -Nru a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
--- a/drivers/pci/hotplug/Kconfig	Fri Feb 27 15:57:21 2004
+++ b/drivers/pci/hotplug/Kconfig	Fri Feb 27 15:57:21 2004
@@ -191,7 +191,7 @@
 
 config HOTPLUG_PCI_RPA
 	tristate "RPA PCI Hotplug driver"
-	depends on HOTPLUG_PCI && PPC_PSERIES && PPC64
+	depends on HOTPLUG_PCI && PPC_PSERIES && PPC64 && !HOTPLUG_PCI_FAKE
 	help
 	  Say Y here if you have a a RPA system that supports PCI Hotplug.
 
diff -Nru a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
--- a/drivers/pci/hotplug/rpaphp.h	Fri Feb 27 15:57:21 2004
+++ b/drivers/pci/hotplug/rpaphp.h	Fri Feb 27 15:57:21 2004
@@ -54,7 +54,7 @@
 
 #define dbg(format, arg...)					\
 	do {							\
-		if (rpaphp_debug)				\
+		if (debug)					\
 			printk(KERN_DEBUG "%s: " format,	\
 				MY_NAME , ## arg); 		\
 	} while (0)
diff -Nru a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
--- a/drivers/pci/hotplug/rpaphp_core.c	Fri Feb 27 15:57:21 2004
+++ b/drivers/pci/hotplug/rpaphp_core.c	Fri Feb 27 15:57:21 2004
@@ -39,7 +39,7 @@
 #include "pci_hotplug.h"
 
 
-static int debug = 1;
+static int debug;
 static struct semaphore rpaphp_sem;
 static LIST_HEAD (rpaphp_slot_head);
 static int num_slots;
@@ -837,8 +837,6 @@
 	int retval = 0;
 
 	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
-
-	rpaphp_debug = debug;
 
 	/* read all the PRA info from the system */
 	retval = init_rpa();

