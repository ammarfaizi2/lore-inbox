Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274563AbSITA5T>; Thu, 19 Sep 2002 20:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274205AbSITA4P>; Thu, 19 Sep 2002 20:56:15 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:51210 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S274493AbSITAy5>;
	Thu, 19 Sep 2002 20:54:57 -0400
Date: Thu, 19 Sep 2002 17:59:49 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] More PCI Hotplug changes for 2.4.20-pre7
Message-ID: <20020920005949.GP18583@kroah.com>
References: <20020920005749.GI18583@kroah.com> <20020920005806.GJ18583@kroah.com> <20020920005823.GK18583@kroah.com> <20020920005840.GL18583@kroah.com> <20020920005857.GM18583@kroah.com> <20020920005913.GN18583@kroah.com> <20020920005929.GO18583@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020920005929.GO18583@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.689   -> 1.690  
#	drivers/hotplug/pci_hotplug_core.c	1.8     -> 1.9    
#	   drivers/pci/pci.c	1.35    -> 1.36   
#	 include/linux/pci.h	1.27    -> 1.28   
#	  drivers/pci/proc.c	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/19	greg@kroah.com	1.690
# PCI Hotplug: created /proc/bus/pci/slots for pcihpfs to be mounted on.
# 
# proc_bus_pci_dir had to be exported for this to work properly.
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Thu Sep 19 17:18:53 2002
+++ b/drivers/hotplug/pci_hotplug_core.c	Thu Sep 19 17:18:53 2002
@@ -38,6 +38,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/dnotify.h>
+#include <linux/proc_fs.h>
 #include <asm/uaccess.h>
 #include "pci_hotplug.h"
 
@@ -57,7 +58,7 @@
 /* local variables */
 static int debug;
 
-#define DRIVER_VERSION	"0.4"
+#define DRIVER_VERSION	"0.5"
 #define DRIVER_AUTHOR	"Greg Kroah-Hartman <greg@kroah.com>"
 #define DRIVER_DESC	"PCI Hot Plug PCI Core"
 
@@ -126,6 +127,12 @@
 	return NULL;
 }
 
+#ifdef CONFIG_PROC_FS		
+extern struct proc_dir_entry *proc_bus_pci_dir;
+static struct proc_dir_entry *slotdir = NULL;
+static const char *slotdir_name = "slots";
+#endif
+
 static struct inode *pcihpfs_get_inode (struct super_block *sb, int mode, int dev)
 {
 	struct inode *inode = new_inode(sb);
@@ -1259,6 +1266,11 @@
 		goto exit;
 	}
 
+#ifdef CONFIG_PROC_FS
+	/* create mount point for pcihpfs */
+	slotdir = proc_mkdir(slotdir_name, proc_bus_pci_dir);
+#endif
+
 	info (DRIVER_DESC " version: " DRIVER_VERSION "\n");
 
 exit:
@@ -1268,6 +1280,11 @@
 static void __exit pci_hotplug_exit (void)
 {
 	unregister_filesystem(&pcihpfs_fs_type);
+
+#ifdef CONFIG_PROC_FS
+	if (slotdir)
+		remove_proc_entry(slotdir_name, proc_bus_pci_dir);
+#endif
 }
 
 module_init(pci_hotplug_init);
diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	Thu Sep 19 17:18:53 2002
+++ b/drivers/pci/pci.c	Thu Sep 19 17:18:53 2002
@@ -2158,6 +2158,7 @@
 EXPORT_SYMBOL(pci_proc_detach_device);
 EXPORT_SYMBOL(pci_proc_attach_bus);
 EXPORT_SYMBOL(pci_proc_detach_bus);
+EXPORT_SYMBOL(proc_bus_pci_dir);
 #endif
 #endif
 
diff -Nru a/drivers/pci/proc.c b/drivers/pci/proc.c
--- a/drivers/pci/proc.c	Thu Sep 19 17:18:53 2002
+++ b/drivers/pci/proc.c	Thu Sep 19 17:18:53 2002
@@ -369,7 +369,7 @@
 	show:	show_device
 };
 
-static struct proc_dir_entry *proc_bus_pci_dir;
+struct proc_dir_entry *proc_bus_pci_dir;
 
 int pci_proc_attach_device(struct pci_dev *dev)
 {
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Sep 19 17:18:53 2002
+++ b/include/linux/pci.h	Thu Sep 19 17:18:53 2002
@@ -439,6 +439,7 @@
 extern struct list_head pci_root_buses;	/* list of all known PCI buses */
 extern struct list_head pci_devices;	/* list of all devices */
 
+extern struct proc_dir_entry *proc_bus_pci_dir;
 /*
  * Error values that may be returned by PCI functions.
  */
