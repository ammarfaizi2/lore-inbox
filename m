Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262614AbSI0TqX>; Fri, 27 Sep 2002 15:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262612AbSI0Tp0>; Fri, 27 Sep 2002 15:45:26 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:8206 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262609AbSI0Toa>;
	Fri, 27 Sep 2002 15:44:30 -0400
Date: Fri, 27 Sep 2002 12:48:06 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] More USB changes for 2.5.38
Message-ID: <20020927194806.GK12909@kroah.com>
References: <20020927193723.GA12909@kroah.com> <20020927193855.GB12909@kroah.com> <20020927194025.GC12909@kroah.com> <20020927194054.GD12909@kroah.com> <20020927194240.GE12909@kroah.com> <20020927194258.GF12909@kroah.com> <20020927194314.GG12909@kroah.com> <20020927194330.GH12909@kroah.com> <20020927194353.GI12909@kroah.com> <20020927194420.GJ12909@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020927194420.GJ12909@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.611.1.9 -> 1.611.1.10
#	drivers/pci/pci-driver.c	1.18    -> 1.19   
#	drivers/pci/hotplug.c	1.5     -> 1.6    
#	               (new)	        -> 1.1     drivers/pci/pci.h
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/27	greg@kroah.com	1.611.1.10
# converted PCI to use the driver core's hotplug call.
# --------------------------------------------
#
diff -Nru a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
--- a/drivers/pci/hotplug.c	Fri Sep 27 12:30:03 2002
+++ b/drivers/pci/hotplug.c	Fri Sep 27 12:30:03 2002
@@ -1,52 +1,68 @@
 #include <linux/pci.h>
 #include <linux/module.h>
-#include <linux/kmod.h>		/* for hotplug_path */
+#include "pci.h"
 
-#ifndef FALSE
-#define FALSE	(0)
-#define TRUE	(!FALSE)
-#endif
 
 #ifdef CONFIG_HOTPLUG
-static void run_sbin_hotplug(struct pci_dev *pdev, int insert)
+int pci_hotplug (struct device *dev, char **envp, int num_envp,
+		 char *buffer, int buffer_size)
 {
-	int i;
-	char *argv[3], *envp[8];
-	char id[20], sub_id[24], bus_id[24], class_id[20];
-
-	if (!hotplug_path[0])
-		return;
+	struct pci_dev *pdev;
+	char *scratch;
+	int i = 0;
+	int length = 0;
+
+	if (!dev)
+		return -ENODEV;
+
+	pdev = to_pci_dev(dev);
+	if (!pdev)
+		return -ENODEV;
+
+	scratch = buffer;
+
+	/* stuff we want to pass to /sbin/hotplug */
+	envp[i++] = scratch;
+	length += snprintf (scratch, buffer_size - length, "PCI_CLASS=%04X",
+			    pdev->class);
+	if ((buffer_size - length <= 0) || (i >= num_envp))
+		return -ENOMEM;
+	++length;
+	scratch += length;
+
+	envp[i++] = scratch;
+	length += snprintf (scratch, buffer_size - length, "PCI_ID=%04X:%04X",
+			    pdev->vendor, pdev->device);
+	if ((buffer_size - length <= 0) || (i >= num_envp))
+		return -ENOMEM;
+	++length;
+	scratch += length;
+
+	envp[i++] = scratch;
+	length += snprintf (scratch, buffer_size - length,
+			    "PCI_SUBSYS_ID=%04X:%04X", pdev->subsystem_vendor,
+			    pdev->subsystem_device);
+	if ((buffer_size - length <= 0) || (i >= num_envp))
+		return -ENOMEM;
+	++length;
+	scratch += length;
+
+	envp[i++] = scratch;
+	length += snprintf (scratch, buffer_size - length, "PCI_SLOT_NAME=%s",
+			    pdev->slot_name);
+	if ((buffer_size - length <= 0) || (i >= num_envp))
+		return -ENOMEM;
 
-	sprintf(class_id, "PCI_CLASS=%04X", pdev->class);
-	sprintf(id, "PCI_ID=%04X:%04X", pdev->vendor, pdev->device);
-	sprintf(sub_id, "PCI_SUBSYS_ID=%04X:%04X", pdev->subsystem_vendor, pdev->subsystem_device);
-	sprintf(bus_id, "PCI_SLOT_NAME=%s", pdev->slot_name);
-
-	i = 0;
-	argv[i++] = hotplug_path;
-	argv[i++] = "pci";
-	argv[i] = 0;
-
-	i = 0;
-	/* minimal command environment */
-	envp[i++] = "HOME=/";
-	envp[i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
-	
-	/* other stuff we want to pass to /sbin/hotplug */
-	envp[i++] = class_id;
-	envp[i++] = id;
-	envp[i++] = sub_id;
-	envp[i++] = bus_id;
-	if (insert)
-		envp[i++] = "ACTION=add";
-	else
-		envp[i++] = "ACTION=remove";
 	envp[i] = 0;
 
-	call_usermodehelper (argv [0], argv, envp);
+	return 0;
 }
 #else
-static void run_sbin_hotplug(struct pci_dev *pdev, int insert) { }
+int pci_hotplug (struct device *dev, char **envp, int num_envp,
+		 char *buffer, int buffer_size)
+{
+	return -ENODEV;
+}
 #endif
 
 /**
@@ -66,8 +82,6 @@
 #ifdef CONFIG_PROC_FS
 	pci_proc_attach_device(dev);
 #endif
-	/* notify userspace of new hotplug device */
-	run_sbin_hotplug(dev, TRUE);
 }
 
 static void
@@ -99,8 +113,6 @@
 #ifdef CONFIG_PROC_FS
 	pci_proc_detach_device(dev);
 #endif
-	/* notify userspace of hotplug device removal */
-	run_sbin_hotplug(dev, FALSE);
 }
 
 #ifdef CONFIG_HOTPLUG
diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Fri Sep 27 12:30:03 2002
+++ b/drivers/pci/pci-driver.c	Fri Sep 27 12:30:03 2002
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include "pci.h"
 
 /*
  *  Registration of PCI drivers and handling of hot-pluggable devices.
@@ -199,8 +200,9 @@
 }
 
 struct bus_type pci_bus_type = {
-	name:	"pci",
-	match:	pci_bus_match,
+	name:		"pci",
+	match:		pci_bus_match,
+	hotplug:	pci_hotplug,
 };
 
 static int __init pci_driver_init(void)
diff -Nru a/drivers/pci/pci.h b/drivers/pci/pci.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/pci/pci.h	Fri Sep 27 12:30:03 2002
@@ -0,0 +1,5 @@
+/* Functions internal to the PCI core code */
+
+extern int pci_hotplug (struct device *dev, char **envp, int num_envp,
+			 char *buffer, int buffer_size);
+
