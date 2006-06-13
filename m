Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932689AbWFMAfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689AbWFMAfo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 20:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932703AbWFMAfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 20:35:05 -0400
Received: from ns2.suse.de ([195.135.220.15]:63723 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932691AbWFMAel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 20:34:41 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 14/16] 64bit resource: change pnp core to use resource_size_t
Reply-To: Greg KH <greg@kroah.com>
Date: Mon, 12 Jun 2006 17:31:16 -0700
Message-Id: <11501587273612-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11501587223213-git-send-email-greg@kroah.com>
References: <20060613003033.GA10717@kroah.com> <11501586781628-git-send-email-greg@kroah.com> <1150158683636-git-send-email-greg@kroah.com> <11501586871870-git-send-email-greg@kroah.com> <11501586902008-git-send-email-greg@kroah.com> <11501586942938-git-send-email-greg@kroah.com> <11501586982289-git-send-email-greg@kroah.com> <11501587011194-git-send-email-greg@kroah.com> <11501587043722-git-send-email-greg@kroah.com> <11501587082203-git-send-email-greg@kroah.com> <11501587122736-git-send-email-greg@kroah.com> <11501587153872-git-send-email-greg@kroah.com> <11501587193060-git-send-email-greg@kroah.com> <11501587223213-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Based on a patch series originally from Vivek Goyal <vgoyal@in.ibm.com>

Cc: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
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

