Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266927AbTAIRmW>; Thu, 9 Jan 2003 12:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266928AbTAIRmW>; Thu, 9 Jan 2003 12:42:22 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:19460 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S266927AbTAIRmU>; Thu, 9 Jan 2003 12:42:20 -0500
Date: Thu, 9 Jan 2003 20:48:36 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Grant Grundler <grundler@cup.hp.com>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Subject: [patch 2.5] 2-pass PCI probing, hotplug changes
Message-ID: <20030109204836.B2007@jurassic.park.msu.ru>
References: <1041942820.20658.2.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0301070942440.1913-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0301070942440.1913-100000@home.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 07, 2003 at 09:44:53AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As the hotplug drivers use low-level probing functions
(pci_do_scan_bus and pci_scan_bridge), they have to
use the phase #2 routine directly.

Ivan.

diff -urpN 2.5.55/drivers/hotplug/acpiphp_glue.c linux/drivers/hotplug/acpiphp_glue.c
--- 2.5.55/drivers/hotplug/acpiphp_glue.c	Thu Jan  9 07:03:59 2003
+++ linux/drivers/hotplug/acpiphp_glue.c	Thu Jan  9 15:33:29 2003
@@ -947,6 +947,7 @@ static int enable_device (struct acpiphp
 		pci_read_config_byte(dev, PCI_SECONDARY_BUS, &bus);
 		child = (struct pci_bus*) pci_add_new_bus(dev->bus, dev, bus);
 		pci_do_scan_bus(child);
+		pci_probe_resources(child);
 	}
 
 	/* associate pci_dev to our representation */
diff -urpN 2.5.55/drivers/hotplug/cpci_hotplug_pci.c linux/drivers/hotplug/cpci_hotplug_pci.c
--- 2.5.55/drivers/hotplug/cpci_hotplug_pci.c	Thu Jan  9 07:04:17 2003
+++ linux/drivers/hotplug/cpci_hotplug_pci.c	Thu Jan  9 15:59:12 2003
@@ -395,6 +395,7 @@ static int cpci_configure_bridge(struct 
 	/* Scan behind bridge */
 	n = pci_scan_bridge(bus, dev, max, 2);
 	child = pci_find_bus(max + 1);
+	pci_probe_resources(child);
 #ifdef CONFIG_PROC_FS
 	pci_proc_attach_bus(child);
 #endif
diff -urpN 2.5.55/drivers/hotplug/cpqphp_pci.c linux/drivers/hotplug/cpqphp_pci.c
--- 2.5.55/drivers/hotplug/cpqphp_pci.c	Thu Jan  9 07:04:25 2003
+++ linux/drivers/hotplug/cpqphp_pci.c	Thu Jan  9 15:34:07 2003
@@ -284,7 +284,7 @@ int cpqhp_configure_device (struct contr
 		pci_read_config_byte(func->pci_dev, PCI_SECONDARY_BUS, &bus);
 		child = (struct pci_bus*) pci_add_new_bus(func->pci_dev->bus, (func->pci_dev), bus);
 		pci_do_scan_bus(child);
-
+		pci_probe_resources(child);
 	}
 
 	temp = func->pci_dev;
diff -urpN 2.5.55/drivers/hotplug/ibmphp_core.c linux/drivers/hotplug/ibmphp_core.c
--- 2.5.55/drivers/hotplug/ibmphp_core.c	Thu Jan  9 07:04:28 2003
+++ linux/drivers/hotplug/ibmphp_core.c	Thu Jan  9 15:38:25 2003
@@ -1071,6 +1071,7 @@ static int ibm_configure_device (struct 
 		pci_read_config_byte (func->dev, PCI_SECONDARY_BUS, &bus);
 		child = (struct pci_bus *) pci_add_new_bus (func->dev->bus, (func->dev), bus);
 		pci_do_scan_bus (child);
+		pci_probe_resources (child);
 	}
 
 	temp = func->dev;
