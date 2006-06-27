Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161162AbWF0QlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161162AbWF0QlY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161177AbWF0QlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:41:08 -0400
Received: from mail.suse.de ([195.135.220.2]:32470 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161181AbWF0Qhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:37:52 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 14/17] [PATCH] 64bit resource: change pnp core to use resource_size_t
Reply-To: Greg KH <greg@kroah.com>
Date: Tue, 27 Jun 2006 09:33:50 -0700
Message-Id: <115142608072-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11514260761750-git-send-email-greg@kroah.com>
References: <20060627163317.GA31073@kroah.com> <11514260331421-git-send-email-greg@kroah.com> <11514260373971-git-send-email-greg@kroah.com> <115142604066-git-send-email-greg@kroah.com> <11514260442539-git-send-email-greg@kroah.com> <11514260483754-git-send-email-greg@kroah.com> <11514260513485-git-send-email-greg@kroah.com> <11514260543854-git-send-email-greg@kroah.com> <11514260583661-git-send-email-greg@kroah.com> <11514260612035-git-send-email-greg@kroah.com> <11514260651070-git-send-email-greg@kroah.com> <11514260692919-git-send-email-greg@kroah.com> <11514260722341-git-send-email-greg@kroah.com> <11514260761750-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Based on a patch series originally from Vivek Goyal <vgoyal@in.ibm.com>

Cc: Vivek Goyal <vgoyal@in.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/pnp/interface.c |    8 ++++----
 drivers/pnp/manager.c   |   15 ++++++++++-----
 drivers/pnp/resource.c  |    8 ++++----
 include/linux/pnp.h     |    7 +++++--
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/pnp/interface.c b/drivers/pnp/interface.c
index a2d8ce7..3163e3d 100644
--- a/drivers/pnp/interface.c
+++ b/drivers/pnp/interface.c
@@ -264,7 +264,7 @@ static ssize_t pnp_show_current_resource
 			if (pnp_port_flags(dev, i) & IORESOURCE_DISABLED)
 				pnp_printf(buffer," disabled\n");
 			else
-				pnp_printf(buffer," 0x%lx-0x%lx\n",
+				pnp_printf(buffer," 0x%llx-0x%llx\n",
 						pnp_port_start(dev, i),
 						pnp_port_end(dev, i));
 		}
@@ -275,7 +275,7 @@ static ssize_t pnp_show_current_resource
 			if (pnp_mem_flags(dev, i) & IORESOURCE_DISABLED)
 				pnp_printf(buffer," disabled\n");
 			else
-				pnp_printf(buffer," 0x%lx-0x%lx\n",
+				pnp_printf(buffer," 0x%llx-0x%llx\n",
 						pnp_mem_start(dev, i),
 						pnp_mem_end(dev, i));
 		}
@@ -286,7 +286,7 @@ static ssize_t pnp_show_current_resource
 			if (pnp_irq_flags(dev, i) & IORESOURCE_DISABLED)
 				pnp_printf(buffer," disabled\n");
 			else
-				pnp_printf(buffer," %ld\n",
+				pnp_printf(buffer," %lld\n",
 						pnp_irq(dev, i));
 		}
 	}
@@ -296,7 +296,7 @@ static ssize_t pnp_show_current_resource
 			if (pnp_dma_flags(dev, i) & IORESOURCE_DISABLED)
 				pnp_printf(buffer," disabled\n");
 			else
-				pnp_printf(buffer," %ld\n",
+				pnp_printf(buffer," %lld\n",
 						pnp_dma(dev, i));
 		}
 	}
diff --git a/drivers/pnp/manager.c b/drivers/pnp/manager.c
index 6fff109..1d7a5b8 100644
--- a/drivers/pnp/manager.c
+++ b/drivers/pnp/manager.c
@@ -20,7 +20,8 @@ DECLARE_MUTEX(pnp_res_mutex);
 
 static int pnp_assign_port(struct pnp_dev *dev, struct pnp_port *rule, int idx)
 {
-	unsigned long *start, *end, *flags;
+	resource_size_t *start, *end;
+	unsigned long *flags;
 
 	if (!dev || !rule)
 		return -EINVAL;
@@ -63,7 +64,8 @@ static int pnp_assign_port(struct pnp_de
 
 static int pnp_assign_mem(struct pnp_dev *dev, struct pnp_mem *rule, int idx)
 {
-	unsigned long *start, *end, *flags;
+	resource_size_t *start, *end;
+	unsigned long *flags;
 
 	if (!dev || !rule)
 		return -EINVAL;
@@ -116,7 +118,8 @@ static int pnp_assign_mem(struct pnp_dev
 
 static int pnp_assign_irq(struct pnp_dev * dev, struct pnp_irq *rule, int idx)
 {
-	unsigned long *start, *end, *flags;
+	resource_size_t *start, *end;
+	unsigned long *flags;
 	int i;
 
 	/* IRQ priority: this table is good for i386 */
@@ -168,7 +171,8 @@ static int pnp_assign_irq(struct pnp_dev
 
 static int pnp_assign_dma(struct pnp_dev *dev, struct pnp_dma *rule, int idx)
 {
-	unsigned long *start, *end, *flags;
+	resource_size_t *start, *end;
+	unsigned long *flags;
 	int i;
 
 	/* DMA priority: this table is good for i386 */
@@ -582,7 +586,8 @@ int pnp_disable_dev(struct pnp_dev *dev)
  * @size: size of region
  *
  */
-void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size)
+void pnp_resource_change(struct resource *resource, resource_size_t start,
+				resource_size_t size)
 {
 	if (resource == NULL)
 		return;
diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
index 6ded527..7bb892f 100644
--- a/drivers/pnp/resource.c
+++ b/drivers/pnp/resource.c
@@ -241,7 +241,7 @@ int pnp_check_port(struct pnp_dev * dev,
 {
 	int tmp;
 	struct pnp_dev *tdev;
-	unsigned long *port, *end, *tport, *tend;
+	resource_size_t *port, *end, *tport, *tend;
 	port = &dev->res.port_resource[idx].start;
 	end = &dev->res.port_resource[idx].end;
 
@@ -297,7 +297,7 @@ int pnp_check_mem(struct pnp_dev * dev, 
 {
 	int tmp;
 	struct pnp_dev *tdev;
-	unsigned long *addr, *end, *taddr, *tend;
+	resource_size_t *addr, *end, *taddr, *tend;
 	addr = &dev->res.mem_resource[idx].start;
 	end = &dev->res.mem_resource[idx].end;
 
@@ -358,7 +358,7 @@ int pnp_check_irq(struct pnp_dev * dev, 
 {
 	int tmp;
 	struct pnp_dev *tdev;
-	unsigned long * irq = &dev->res.irq_resource[idx].start;
+	resource_size_t * irq = &dev->res.irq_resource[idx].start;
 
 	/* if the resource doesn't exist, don't complain about it */
 	if (cannot_compare(dev->res.irq_resource[idx].flags))
@@ -423,7 +423,7 @@ int pnp_check_dma(struct pnp_dev * dev, 
 #ifndef CONFIG_IA64
 	int tmp;
 	struct pnp_dev *tdev;
-	unsigned long * dma = &dev->res.dma_resource[idx].start;
+	resource_size_t * dma = &dev->res.dma_resource[idx].start;
 
 	/* if the resource doesn't exist, don't complain about it */
 	if (cannot_compare(dev->res.dma_resource[idx].flags))
diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index 93b0959..ab8a8dd 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -389,7 +389,8 @@ int pnp_start_dev(struct pnp_dev *dev);
 int pnp_stop_dev(struct pnp_dev *dev);
 int pnp_activate_dev(struct pnp_dev *dev);
 int pnp_disable_dev(struct pnp_dev *dev);
-void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size);
+void pnp_resource_change(struct resource *resource, resource_size_t start,
+				resource_size_t size);
 
 /* protocol helpers */
 int pnp_is_active(struct pnp_dev * dev);
@@ -434,7 +435,9 @@ static inline int pnp_start_dev(struct p
 static inline int pnp_stop_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_activate_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_disable_dev(struct pnp_dev *dev) { return -ENODEV; }
-static inline void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size) { }
+static inline void pnp_resource_change(struct resource *resource,
+					resource_size_t start,
+					resource_size_t size) { }
 
 /* protocol helpers */
 static inline int pnp_is_active(struct pnp_dev * dev) { return 0; }
-- 
1.4.0

