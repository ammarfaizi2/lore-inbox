Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVAMUSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVAMUSy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 15:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVAMUQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 15:16:01 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:23436 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261403AbVAMUNm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 15:13:42 -0500
Subject: Re: [PATCH] release_pcibus_dev() crash
From: John Rose <johnrose@austin.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050113183729.GA25049@kroah.com>
References: <1105576756.8062.17.camel@sinatra.austin.ibm.com>
	 <1105638551.30960.16.camel@sinatra.austin.ibm.com>
	 <20050113181850.GA24952@kroah.com>
	 <200501131021.19434.jbarnes@engr.sgi.com>
	 <20050113183729.GA25049@kroah.com>
Content-Type: text/plain
Message-Id: <1105647135.30960.22.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 14:12:15 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, does the patch below fix the problem for you?
> (warning, not even compile tested)

Unfortunately, the class device attribute and pci_remove_legacy_files()
are statically defined in probe.c.  The patch below augments yours to account
for this.

This set of changes also fixes the crash.  I'll let you decide if explicitly
cleaning up these files is worth exporting this stuff outside of probe.c.  
Also, suggestions are welcome for a cleaner way to do this, I'm not totally
comfortable with the ifdef's and inlines :)

Thanks-
John

Signed-off-by: John Rose <johnrose@austin.ibm.com>

diff -puN drivers/pci/probe.c~01_release_pcibus_dev drivers/pci/probe.c
--- 2_6_linus_2/drivers/pci/probe.c~01_release_pcibus_dev	2005-01-13 13:41:08.000000000 -0600
+++ 2_6_linus_2-johnrose/drivers/pci/probe.c	2005-01-13 13:57:27.000000000 -0600
@@ -70,7 +70,7 @@ static void pci_remove_legacy_files(stru
 }
 #else /* !HAVE_PCI_LEGACY */
 static inline void pci_create_legacy_files(struct pci_bus *bus) { return; }
-static inline void pci_remove_legacy_files(struct pci_bus *bus) { return; }
+inline void pci_remove_legacy_files(struct pci_bus *bus) { return; }
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
--- 2_6_linus_2/drivers/pci/remove.c~01_release_pcibus_dev	2005-01-13 13:42:39.000000000 -0600
+++ 2_6_linus_2-johnrose/drivers/pci/remove.c	2005-01-13 13:47:18.000000000 -0600
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
 
diff -puN include/linux/pci.h~01_release_pcibus_dev include/linux/pci.h
--- 2_6_linus_2/include/linux/pci.h~01_release_pcibus_dev	2005-01-13 13:53:28.000000000 -0600
+++ 2_6_linus_2-johnrose/include/linux/pci.h	2005-01-13 13:58:06.000000000 -0600
@@ -1055,8 +1055,10 @@ enum pci_fixup_pass {
 
 
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev);
+void pci_remove_legacy_files(struct pci_bus *bus);
 
 extern int pci_pci_problems;
+extern struct class_device_attribute class_device_attr_cpuaffinity;
 #define PCIPCI_FAIL		1
 #define PCIPCI_TRITON		2
 #define PCIPCI_NATOMA		4

_

