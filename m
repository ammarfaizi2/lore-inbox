Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274260AbSITAxW>; Thu, 19 Sep 2002 20:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274207AbSITAwp>; Thu, 19 Sep 2002 20:52:45 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:43018 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S274260AbSITAwa>;
	Thu, 19 Sep 2002 20:52:30 -0400
Date: Thu, 19 Sep 2002 17:57:22 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI hotplug changes for 2.5.36
Message-ID: <20020920005722.GH18583@kroah.com>
References: <20020920005408.GA18583@kroah.com> <20020920005428.GB18583@kroah.com> <20020920005444.GC18583@kroah.com> <20020920005500.GD18583@kroah.com> <20020920005517.GE18583@kroah.com> <20020920005555.GF18583@kroah.com> <20020920005658.GG18583@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020920005658.GG18583@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.563   -> 1.564  
#	drivers/hotplug/pci_hotplug_core.c	1.23    -> 1.24   
#	  drivers/pci/proc.c	1.18    -> 1.19   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/19	greg@kroah.com	1.564
# PCI Hotplug: created /proc/bus/pci/slots for pcihpfs to be mounted on.
# 
# proc_bus_pci_dir had to be exported for this to work properly.
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Thu Sep 19 17:50:33 2002
+++ b/drivers/hotplug/pci_hotplug_core.c	Thu Sep 19 17:50:33 2002
@@ -39,6 +39,7 @@
 #include <linux/namei.h>
 #include <linux/pci.h>
 #include <linux/dnotify.h>
+#include <linux/proc_fs.h>
 #include <asm/uaccess.h>
 #include "pci_hotplug.h"
 
@@ -113,6 +114,12 @@
 	"133 MHz PCIX 533",	/* 0x13 */
 };
 
+#ifdef CONFIG_PROC_FS		
+extern struct proc_dir_entry *proc_bus_pci_dir;
+static struct proc_dir_entry *slotdir = NULL;
+static const char *slotdir_name = "slots";
+#endif
+
 static struct inode *pcihpfs_get_inode (struct super_block *sb, int mode, int dev)
 {
 	struct inode *inode = new_inode(sb);
@@ -1265,6 +1272,11 @@
 		goto exit;
 	}
 
+#ifdef CONFIG_PROC_FS
+	/* create mount point for pcihpfs */
+	slotdir = proc_mkdir(slotdir_name, proc_bus_pci_dir);
+#endif
+
 	info (DRIVER_DESC " version: " DRIVER_VERSION "\n");
 
 exit:
@@ -1274,6 +1286,11 @@
 static void __exit pci_hotplug_exit (void)
 {
 	unregister_filesystem(&pcihpfs_type);
+
+#ifdef CONFIG_PROC_FS
+	if (slotdir)
+		remove_proc_entry(slotdir_name, proc_bus_pci_dir);
+#endif
 }
 
 module_init(pci_hotplug_init);
diff -Nru a/drivers/pci/proc.c b/drivers/pci/proc.c
--- a/drivers/pci/proc.c	Thu Sep 19 17:50:33 2002
+++ b/drivers/pci/proc.c	Thu Sep 19 17:50:33 2002
@@ -371,7 +371,7 @@
 	show:	show_device
 };
 
-static struct proc_dir_entry *proc_bus_pci_dir;
+struct proc_dir_entry *proc_bus_pci_dir;
 
 /* driverfs files */
 static ssize_t pci_show_irq(struct device * dev, char * buf, size_t count, loff_t off)
@@ -621,5 +621,6 @@
 EXPORT_SYMBOL(pci_proc_detach_device);
 EXPORT_SYMBOL(pci_proc_attach_bus);
 EXPORT_SYMBOL(pci_proc_detach_bus);
+EXPORT_SYMBOL(proc_bus_pci_dir);
 #endif
 
