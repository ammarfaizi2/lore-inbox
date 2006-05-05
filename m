Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751656AbWEERaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbWEERaV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 13:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbWEERaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 13:30:20 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:56993 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751656AbWEERaT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 13:30:19 -0400
Date: Fri, 5 May 2006 13:30:02 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Greg KH <gregkh@suse.de>, Morton Andrew Morton <akpm@osdl.org>
Subject: [RFC][PATCH 2/6] kconfigurable resources driver pci changes
Message-ID: <20060505173002.GD6450@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060505172847.GC6450@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060505172847.GC6450@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Changes to drivers/pci/* for kconfigurable resources.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 drivers/pci/bus.c       |   10 +++++-----
 drivers/pci/pci-sysfs.c |    4 ++--
 drivers/pci/pci.h       |    6 +++---
 drivers/pci/proc.c      |    4 ++--
 drivers/pci/setup-res.c |    6 +++---
 include/linux/pci.h     |   13 +++++++------
 6 files changed, 22 insertions(+), 21 deletions(-)

diff -puN include/linux/pci.h~kconfigurable-resources-drivers-pci-changes include/linux/pci.h
--- linux-2.6.17-rc3-mm1-1M/include/linux/pci.h~kconfigurable-resources-drivers-pci-changes	2006-05-05 11:55:02.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/include/linux/pci.h	2006-05-05 11:55:02.000000000 -0400
@@ -403,8 +403,8 @@ int pcibios_enable_device(struct pci_dev
 char *pcibios_setup (char *str);
 
 /* Used only when drivers/pci/setup.c is used */
-void pcibios_align_resource(void *, struct resource *,
-			    u64, u64);
+void pcibios_align_resource(void *, struct resource *, resource_size_t,
+				resource_size_t);
 void pcibios_update_irq(struct pci_dev *, int irq);
 
 /* Generic PCI functions used internally */
@@ -531,10 +531,10 @@ void pci_release_region(struct pci_dev *
 
 /* drivers/pci/bus.c */
 int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
-			   u64 size, u64 align,
-			   u64 min, unsigned int type_mask,
+			   resource_size_t size, resource_size_t align,
+			   resource_size_t min, unsigned int type_mask,
 			   void (*alignf)(void *, struct resource *,
-					  u64, u64),
+					  resource_size_t, resource_size_t),
 			   void *alignf_data);
 void pci_enable_bridges(struct pci_bus *bus);
 
@@ -728,7 +728,8 @@ static inline char *pci_name(struct pci_
  */
 #ifndef HAVE_ARCH_PCI_RESOURCE_TO_USER
 static inline void pci_resource_to_user(const struct pci_dev *dev, int bar,
-                const struct resource *rsrc, u64 *start, u64 *end)
+                const struct resource *rsrc, resource_size_t *start,
+		resource_size_t *end)
 {
 	*start = rsrc->start;
 	*end = rsrc->end;
diff -puN drivers/pci/pci.h~kconfigurable-resources-drivers-pci-changes drivers/pci/pci.h
--- linux-2.6.17-rc3-mm1-1M/drivers/pci/pci.h~kconfigurable-resources-drivers-pci-changes	2006-05-05 11:55:02.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/drivers/pci/pci.h	2006-05-05 11:55:02.000000000 -0400
@@ -6,10 +6,10 @@ extern int pci_create_sysfs_dev_files(st
 extern void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
 extern void pci_cleanup_rom(struct pci_dev *dev);
 extern int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
-				  u64 size, u64 align,
-				  u64 min, unsigned int type_mask,
+				  resource_size_t size, resource_size_t align,
+				  resource_size_t min, unsigned int type_mask,
 				  void (*alignf)(void *, struct resource *,
-					  	 u64, u64),
+					      resource_size_t, resource_size_t),
 				  void *alignf_data);
 /* Firmware callbacks */
 extern int (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
diff -puN drivers/pci/bus.c~kconfigurable-resources-drivers-pci-changes drivers/pci/bus.c
--- linux-2.6.17-rc3-mm1-1M/drivers/pci/bus.c~kconfigurable-resources-drivers-pci-changes	2006-05-05 11:55:02.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/drivers/pci/bus.c	2006-05-05 11:55:02.000000000 -0400
@@ -34,11 +34,11 @@
  */
 int
 pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
-	u64 size, u64 align, u64 min,
-	unsigned int type_mask,
-	void (*alignf)(void *, struct resource *,
-			u64, u64),
-	void *alignf_data)
+		resource_size_t size, resource_size_t align,
+		resource_size_t min, unsigned int type_mask,
+		void (*alignf)(void *, struct resource *, resource_size_t,
+				resource_size_t),
+		void *alignf_data)
 {
 	int i, ret = -ENOMEM;
 
diff -puN drivers/pci/pci-sysfs.c~kconfigurable-resources-drivers-pci-changes drivers/pci/pci-sysfs.c
--- linux-2.6.17-rc3-mm1-1M/drivers/pci/pci-sysfs.c~kconfigurable-resources-drivers-pci-changes	2006-05-05 11:55:02.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/drivers/pci/pci-sysfs.c	2006-05-05 11:55:02.000000000 -0400
@@ -65,7 +65,7 @@ resource_show(struct device * dev, struc
 	char * str = buf;
 	int i;
 	int max = 7;
-	u64 start, end;
+	resource_size_t start, end;
 
 	if (pci_dev->subordinate)
 		max = DEVICE_COUNT_RESOURCE;
@@ -341,7 +341,7 @@ pci_mmap_resource(struct kobject *kobj, 
 						       struct device, kobj));
 	struct resource *res = (struct resource *)attr->private;
 	enum pci_mmap_state mmap_type;
-	u64 start, end;
+	resource_size_t start, end;
 	int i;
 
 	for (i = 0; i < PCI_ROM_RESOURCE; i++)
diff -puN drivers/pci/proc.c~kconfigurable-resources-drivers-pci-changes drivers/pci/proc.c
--- linux-2.6.17-rc3-mm1-1M/drivers/pci/proc.c~kconfigurable-resources-drivers-pci-changes	2006-05-05 11:55:02.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/drivers/pci/proc.c	2006-05-05 11:55:02.000000000 -0400
@@ -350,14 +350,14 @@ static int show_device(struct seq_file *
 			dev->irq);
 	/* Here should be 7 and not PCI_NUM_RESOURCES as we need to preserve compatibility */
 	for (i=0; i<7; i++) {
-		u64 start, end;
+		resource_size_t start, end;
 		pci_resource_to_user(dev, i, &dev->resource[i], &start, &end);
 		seq_printf(m, "\t%16llx",
 			(unsigned long long)(start |
 			(dev->resource[i].flags & PCI_REGION_FLAG_MASK)));
 	}
 	for (i=0; i<7; i++) {
-		u64 start, end;
+		resource_size_t start, end;
 		pci_resource_to_user(dev, i, &dev->resource[i], &start, &end);
 		seq_printf(m, "\t%16llx",
 			dev->resource[i].start < dev->resource[i].end ?
diff -puN drivers/pci/setup-res.c~kconfigurable-resources-drivers-pci-changes drivers/pci/setup-res.c
--- linux-2.6.17-rc3-mm1-1M/drivers/pci/setup-res.c~kconfigurable-resources-drivers-pci-changes	2006-05-05 11:55:02.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/drivers/pci/setup-res.c	2006-05-05 11:55:02.000000000 -0400
@@ -121,7 +121,7 @@ int pci_assign_resource(struct pci_dev *
 {
 	struct pci_bus *bus = dev->bus;
 	struct resource *res = dev->resource + resno;
-	u64 size, min, align;
+	resource_size_t size, min, align;
 	int ret;
 
 	size = res->end - res->start + 1;
@@ -206,7 +206,7 @@ pdev_sort_resources(struct pci_dev *dev,
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		struct resource *r;
 		struct resource_list *list, *tmp;
-		u64 r_align;
+		resource_size_t r_align;
 
 		r = &dev->resource[i];
 		r_align = r->end - r->start;
@@ -222,7 +222,7 @@ pdev_sort_resources(struct pci_dev *dev,
 		}
 		r_align = (i < PCI_BRIDGE_RESOURCES) ? r_align + 1 : r->start;
 		for (list = head; ; list = list->next) {
-			u64 align = 0;
+			resource_size_t align = 0;
 			struct resource_list *ln = list->next;
 			int idx;
 
_
