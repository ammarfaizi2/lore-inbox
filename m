Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVAMV03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVAMV03 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVAMVYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:24:25 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:59385 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261713AbVAMVTO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:19:14 -0500
Subject: Re: [PATCH] release_pcibus_dev() crash
From: John Rose <johnrose@austin.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050113210501.GA31402@kroah.com>
References: <1105576756.8062.17.camel@sinatra.austin.ibm.com>
	 <1105638551.30960.16.camel@sinatra.austin.ibm.com>
	 <20050113181850.GA24952@kroah.com>
	 <200501131021.19434.jbarnes@engr.sgi.com>
	 <20050113183729.GA25049@kroah.com>
	 <1105647135.30960.22.camel@sinatra.austin.ibm.com>
	 <20050113202532.GA30780@kroah.com>
	 <1105649679.30960.27.camel@sinatra.austin.ibm.com>
	 <20050113210501.GA31402@kroah.com>
Content-Type: text/plain
Message-Id: <1105651078.30960.33.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 15:17:58 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Closer (you forgot a changelog entry too...)

Just to be a brat, I'll point out that I couldn't find a single user of
CLASS_DEVICE_ATTR that explicitly cleans things up like we're doing here.  That
would include firmware and net-sysfs stuff.  Maybe enforcing such a policy upon
device removal would increase participation :)  But okay, here's another try:

During the course of a hotplug removal of a PCI bus, release_pcibus_dev()
attempts to remove attribute files from a kobject directory that no longer
exists.  This patch moves these calls to pci_remove_bus(), where they can work
as intended.

Signed-off-by: John Rose <johnrose@austin.ibm.com>

diff -puN drivers/pci/probe.c~01_release_pcibus_dev drivers/pci/probe.c
--- 2_6_linus_2/drivers/pci/probe.c~01_release_pcibus_dev	2005-01-13 14:49:21.000000000 -0600
+++ 2_6_linus_2-johnrose/drivers/pci/probe.c	2005-01-13 15:09:28.000000000 -0600
@@ -62,7 +62,7 @@ static void pci_create_legacy_files(stru
 	}
 }
 
-static void pci_remove_legacy_files(struct pci_bus *b)
+void pci_remove_legacy_files(struct pci_bus *b)
 {
 	class_device_remove_bin_file(&b->class_dev, b->legacy_io);
 	class_device_remove_bin_file(&b->class_dev, b->legacy_mem);
@@ -70,7 +70,7 @@ static void pci_remove_legacy_files(stru
 }
 #else /* !HAVE_PCI_LEGACY */
 static inline void pci_create_legacy_files(struct pci_bus *bus) { return; }
-static inline void pci_remove_legacy_files(struct pci_bus *bus) { return; }
+void pci_remove_legacy_files(struct pci_bus *bus) { return; }
 #endif /* HAVE_PCI_LEGACY */
 
 /*
@@ -86,7 +86,7 @@ static ssize_t pci_bus_show_cpuaffinity(
 		buf[ret++] = '\n';
 	return ret;
 }
-static CLASS_DEVICE_ATTR(cpuaffinity, S_IRUGO, pci_bus_show_cpuaffinity, NULL);
+CLASS_DEVICE_ATTR(cpuaffinity, S_IRUGO, pci_bus_show_cpuaffinity, NULL);
 
 /*
  * PCI Bus Class
@@ -95,10 +95,6 @@ static void release_pcibus_dev(struct cl
 {
 	struct pci_bus *pci_bus = to_pci_bus(class_dev);
 
-	pci_remove_legacy_files(pci_bus);
-	class_device_remove_file(&pci_bus->class_dev,
-				 &class_device_attr_cpuaffinity);
-	sysfs_remove_link(&pci_bus->class_dev.kobj, "bridge");
 	if (pci_bus->bridge)
 		put_device(pci_bus->bridge);
 	kfree(pci_bus);
diff -puN drivers/pci/remove.c~01_release_pcibus_dev drivers/pci/remove.c
--- 2_6_linus_2/drivers/pci/remove.c~01_release_pcibus_dev	2005-01-13 14:49:21.000000000 -0600
+++ 2_6_linus_2-johnrose/drivers/pci/remove.c	2005-01-13 14:49:21.000000000 -0600
@@ -61,15 +61,18 @@ int pci_remove_device_safe(struct pci_de
 }
 EXPORT_SYMBOL(pci_remove_device_safe);
 
-void pci_remove_bus(struct pci_bus *b)
+void pci_remove_bus(struct pci_bus *pci_bus)
 {
-	pci_proc_detach_bus(b);
+	pci_proc_detach_bus(pci_bus);
 
 	spin_lock(&pci_bus_lock);
-	list_del(&b->node);
+	list_del(&pci_bus->node);
 	spin_unlock(&pci_bus_lock);
-
-	class_device_unregister(&b->class_dev);
+	pci_remove_legacy_files(pci_bus);
+	class_device_remove_file(&pci_bus->class_dev,
+		&class_device_attr_cpuaffinity);
+	sysfs_remove_link(&pci_bus->class_dev.kobj, "bridge");
+	class_device_unregister(&pci_bus->class_dev);
 }
 EXPORT_SYMBOL(pci_remove_bus);
 
diff -puN drivers/pci/pci.h~01_release_pcibus_dev drivers/pci/pci.h
--- 2_6_linus_2/drivers/pci/pci.h~01_release_pcibus_dev	2005-01-13 14:49:21.000000000 -0600
+++ 2_6_linus_2-johnrose/drivers/pci/pci.h	2005-01-13 14:50:06.000000000 -0600
@@ -59,12 +59,14 @@ struct pci_visit {
 extern int pci_visit_dev(struct pci_visit *fn,
 			 struct pci_dev_wrapped *wrapped_dev,
 			 struct pci_bus_wrapped *wrapped_parent);
+extern void pci_remove_legacy_files(struct pci_bus *bus);
 
 /* Lock for read/write access to pci device and bus lists */
 extern spinlock_t pci_bus_lock;
 
 extern int pcie_mch_quirk;
 extern struct device_attribute pci_dev_attrs[];
+extern struct class_device_attribute class_device_attr_cpuaffinity;
 
 /**
  * pci_match_one_device - Tell if a PCI device structure has a matching

_


