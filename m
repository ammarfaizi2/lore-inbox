Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265329AbTFSDzJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 23:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265387AbTFSDzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 23:55:08 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:50308 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S265329AbTFSDx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 23:53:28 -0400
Date: Wed, 18 Jun 2003 23:44:18 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PnP Changes for 2.5.72
Message-ID: <20030618234418.GC333@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1414  -> 1.1415 
#	drivers/serial/8250_pnp.c	1.11    -> 1.12   
#	drivers/pnp/interface.c	1.14    -> 1.15   
#	  drivers/pnp/base.h	1.4     -> 1.5    
#	  drivers/pnp/core.c	1.9     -> 1.10   
#	drivers/pnp/support.c	1.2     -> 1.3    
#	drivers/pnp/isapnp/core.c	1.36    -> 1.37   
#	drivers/pnp/resource.c	1.13    -> 1.14   
#	drivers/pnp/quirks.c	1.10    -> 1.11   
#	drivers/pnp/manager.c	1.6     -> 1.7    
#	 include/linux/pnp.h	1.20    -> 1.21   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/18	ambx1@neo.rr.com	1.1415
# [PNP] Resource Management Cleanups and Updates
# 
# This patch does the following...
# 1.) changes struct pnp_resources to pnp_option for clarity
# 2.) greatly cleans up resource option registration
# 3.) removes some of the current conflict prevention code in
# order to increase flexibility, (users will have more control)
# 4.) various manager cleanups, resulting code is more efficient
# 5.) fixes the locking bugs many have reported (now uses a mutex)
# 6.) removes the conflict displaying interface
#  - it is better to handle such things in user space
# 7.) also many misc. cleanups
# --------------------------------------------
#
diff -Nru a/drivers/pnp/base.h b/drivers/pnp/base.h
--- a/drivers/pnp/base.h	Wed Jun 18 23:02:24 2003
+++ b/drivers/pnp/base.h	Wed Jun 18 23:02:24 2003
@@ -4,29 +4,11 @@
 int pnp_interface_attach_device(struct pnp_dev *dev);
 void pnp_name_device(struct pnp_dev *dev);
 void pnp_fixup_device(struct pnp_dev *dev);
-void pnp_free_resources(struct pnp_resources *resources);
+void pnp_free_option(struct pnp_option *option);
 int __pnp_add_device(struct pnp_dev *dev);
 void __pnp_remove_device(struct pnp_dev *dev);
 
-/* resource conflict types */
-#define CONFLICT_TYPE_NONE	0x0000	/* there are no conflicts, other than those in the link */
-#define CONFLICT_TYPE_RESERVED	0x0001	/* the resource requested was reserved */
-#define CONFLICT_TYPE_IN_USE	0x0002	/* there is a conflict because the resource is in use */
-#define CONFLICT_TYPE_PCI	0x0004	/* there is a conflict with a pci device */
-#define CONFLICT_TYPE_INVALID	0x0008	/* the resource requested is invalid */
-#define CONFLICT_TYPE_INTERNAL	0x0010	/* resources within the device conflict with each ohter */
-#define CONFLICT_TYPE_PNP_WARM	0x0020	/* there is a conflict with a pnp device that is active */
-#define CONFLICT_TYPE_PNP_COLD	0x0040	/* there is a conflict with a pnp device that is disabled */
-
-/* conflict search modes */
-#define SEARCH_WARM 1	/* check for conflicts with active devices */
-#define SEARCH_COLD 0	/* check for conflicts with disabled devices */
-
-struct pnp_dev * pnp_check_port_conflicts(struct pnp_dev * dev, int idx, int mode);
 int pnp_check_port(struct pnp_dev * dev, int idx);
-struct pnp_dev * pnp_check_mem_conflicts(struct pnp_dev * dev, int idx, int mode);
 int pnp_check_mem(struct pnp_dev * dev, int idx);
-struct pnp_dev * pnp_check_irq_conflicts(struct pnp_dev * dev, int idx, int mode);
 int pnp_check_irq(struct pnp_dev * dev, int idx);
-struct pnp_dev * pnp_check_dma_conflicts(struct pnp_dev * dev, int idx, int mode);
 int pnp_check_dma(struct pnp_dev * dev, int idx);
diff -Nru a/drivers/pnp/core.c b/drivers/pnp/core.c
--- a/drivers/pnp/core.c	Wed Jun 18 23:02:24 2003
+++ b/drivers/pnp/core.c	Wed Jun 18 23:02:24 2003
@@ -104,8 +104,8 @@
 static void pnp_release_device(struct device *dmdev)
 {
 	struct pnp_dev * dev = to_pnp_dev(dmdev);
-	if (dev->possible)
-		pnp_free_resources(dev->possible);
+	pnp_free_option(dev->independent);
+	pnp_free_option(dev->dependent);
 	pnp_free_ids(dev);
 	kfree(dev);
 }
@@ -122,7 +122,7 @@
 	list_add_tail(&dev->global_list, &pnp_global);
 	list_add_tail(&dev->protocol_list, &dev->protocol->devices);
 	spin_unlock(&pnp_lock);
-	pnp_auto_config_dev(dev);
+
 	ret = device_register(&dev->dev);
 	if (ret == 0)
 		pnp_interface_attach_device(dev);
diff -Nru a/drivers/pnp/interface.c b/drivers/pnp/interface.c
--- a/drivers/pnp/interface.c	Wed Jun 18 23:02:24 2003
+++ b/drivers/pnp/interface.c	Wed Jun 18 23:02:24 2003
@@ -168,7 +168,8 @@
 	pnp_printf(buffer, ", %s\n", s);
 }
 
-static void pnp_print_resources(pnp_info_buffer_t *buffer, char *space, struct pnp_resources *res, int dep)
+static void pnp_print_option(pnp_info_buffer_t *buffer, char *space,
+			     struct pnp_option *option, int dep)
 {
 	char *s;
 	struct pnp_port *port;
@@ -176,49 +177,55 @@
 	struct pnp_dma *dma;
 	struct pnp_mem *mem;
 
-	switch (res->priority) {
-	case PNP_RES_PRIORITY_PREFERRED:
-		s = "preferred";
-		break;
-	case PNP_RES_PRIORITY_ACCEPTABLE:
-		s = "acceptable";
-		break;
-	case PNP_RES_PRIORITY_FUNCTIONAL:
-		s = "functional";
-		break;
-	default:
-		s = "invalid";
-	}
-	if (dep > 0)
+	if (dep) {
+		switch (option->priority) {
+			case PNP_RES_PRIORITY_PREFERRED:
+			s = "preferred";
+			break;
+			case PNP_RES_PRIORITY_ACCEPTABLE:
+			s = "acceptable";
+			break;
+			case PNP_RES_PRIORITY_FUNCTIONAL:
+			s = "functional";
+			break;
+			default:
+			s = "invalid";
+		}
 		pnp_printf(buffer, "Dependent: %02i - Priority %s\n",dep, s);
-	for (port = res->port; port; port = port->next)
+	}
+
+	for (port = option->port; port; port = port->next)
 		pnp_print_port(buffer, space, port);
-	for (irq = res->irq; irq; irq = irq->next)
+	for (irq = option->irq; irq; irq = irq->next)
 		pnp_print_irq(buffer, space, irq);
-	for (dma = res->dma; dma; dma = dma->next)
+	for (dma = option->dma; dma; dma = dma->next)
 		pnp_print_dma(buffer, space, dma);
-	for (mem = res->mem; mem; mem = mem->next)
+	for (mem = option->mem; mem; mem = mem->next)
 		pnp_print_mem(buffer, space, mem);
 }
 
-static ssize_t pnp_show_possible_resources(struct device *dmdev, char *buf)
+
+static ssize_t pnp_show_options(struct device *dmdev, char *buf)
 {
 	struct pnp_dev *dev = to_pnp_dev(dmdev);
-	struct pnp_resources * res = dev->possible;
-	int ret, dep = 0;
+	struct pnp_option * independent = dev->independent;
+	struct pnp_option * dependent = dev->dependent;
+	int ret, dep = 1;
+
 	pnp_info_buffer_t *buffer = (pnp_info_buffer_t *)
 				 pnp_alloc(sizeof(pnp_info_buffer_t));
 	if (!buffer)
 		return -ENOMEM;
+
 	buffer->len = PAGE_SIZE;
 	buffer->buffer = buf;
 	buffer->curr = buffer->buffer;
-	while (res){
-		if (dep == 0)
-			pnp_print_resources(buffer, "", res, dep);
-		else
-			pnp_print_resources(buffer, "   ", res, dep);
-		res = res->dep;
+	if (independent)
+		pnp_print_option(buffer, "", independent, 0);
+
+	while (dependent){
+		pnp_print_option(buffer, "   ", dependent, dep);
+		dependent = dependent->next;
 		dep++;
 	}
 	ret = (buffer->curr - buf);
@@ -226,97 +233,8 @@
 	return ret;
 }
 
-static DEVICE_ATTR(possible,S_IRUGO,pnp_show_possible_resources,NULL);
-
-static void pnp_print_conflict_node(pnp_info_buffer_t *buffer, struct pnp_dev * dev)
-{
-	if (!dev)
-		return;
-	pnp_printf(buffer, "'%s'.\n", dev->dev.bus_id);
-}
-
-static void pnp_print_conflict_desc(pnp_info_buffer_t *buffer, int conflict)
-{
-	if (!conflict)
-		return;
-	pnp_printf(buffer, "  Conflict Detected: %2x - ", conflict);
-	switch (conflict) {
-	case CONFLICT_TYPE_RESERVED:
-		pnp_printf(buffer, "manually reserved.\n");
-		break;
-
-	case CONFLICT_TYPE_IN_USE:
-		pnp_printf(buffer, "currently in use.\n");
-		break;
-
-	case CONFLICT_TYPE_PCI:
-		pnp_printf(buffer, "PCI device.\n");
-		break;
-
-	case CONFLICT_TYPE_INVALID:
-		pnp_printf(buffer, "invalid.\n");
-		break;
-
-	case CONFLICT_TYPE_INTERNAL:
-		pnp_printf(buffer, "another resource on this device.\n");
-		break;
-
-	case CONFLICT_TYPE_PNP_WARM:
-		pnp_printf(buffer, "active PnP device ");
-		break;
-
-	case CONFLICT_TYPE_PNP_COLD:
-		pnp_printf(buffer, "disabled PnP device ");
-		break;
-	default:
-		pnp_printf(buffer, "Unknown conflict.\n");
-		break;
-	}
-}
+static DEVICE_ATTR(options,S_IRUGO,pnp_show_options,NULL);
 
-static void pnp_print_conflict(pnp_info_buffer_t *buffer, struct pnp_dev * dev, int idx, int type)
-{
-	struct pnp_dev * cdev, * wdev = NULL;
-	int conflict;
-	switch (type) {
-	case IORESOURCE_IO:
-		conflict = pnp_check_port(dev, idx);
-		if (conflict == CONFLICT_TYPE_PNP_WARM)
-			wdev = pnp_check_port_conflicts(dev, idx, SEARCH_WARM);
-		cdev = pnp_check_port_conflicts(dev, idx, SEARCH_COLD);
-		break;
-	case IORESOURCE_MEM:
-		conflict = pnp_check_mem(dev, idx);
-		if (conflict == CONFLICT_TYPE_PNP_WARM)
-			wdev = pnp_check_mem_conflicts(dev, idx, SEARCH_WARM);
-		cdev = pnp_check_mem_conflicts(dev, idx, SEARCH_COLD);
-		break;
-	case IORESOURCE_IRQ:
-		conflict = pnp_check_irq(dev, idx);
-		if (conflict == CONFLICT_TYPE_PNP_WARM)
-			wdev = pnp_check_irq_conflicts(dev, idx, SEARCH_WARM);
-		cdev = pnp_check_irq_conflicts(dev, idx, SEARCH_COLD);
-		break;
-	case IORESOURCE_DMA:
-		conflict = pnp_check_dma(dev, idx);
-		if (conflict == CONFLICT_TYPE_PNP_WARM)
-			wdev = pnp_check_dma_conflicts(dev, idx, SEARCH_WARM);
-		cdev = pnp_check_dma_conflicts(dev, idx, SEARCH_COLD);
-		break;
-	default:
-		return;
-	}
-
-	pnp_print_conflict_desc(buffer, conflict);
-
-	if (wdev)
-		pnp_print_conflict_node(buffer, wdev);
-
-	if (cdev) {
-		pnp_print_conflict_desc(buffer, CONFLICT_TYPE_PNP_COLD);
-		pnp_print_conflict_node(buffer, cdev);
-	}
-}
 
 static ssize_t pnp_show_current_resources(struct device *dmdev, char *buf)
 {
@@ -332,12 +250,6 @@
 	buffer->buffer = buf;
 	buffer->curr = buffer->buffer;
 
-	pnp_printf(buffer,"mode = ");
-	if (dev->config_mode & PNP_CONFIG_MANUAL)
-		pnp_printf(buffer,"manual\n");
-	else
-		pnp_printf(buffer,"auto\n");
-
 	pnp_printf(buffer,"state = ");
 	if (dev->active)
 		pnp_printf(buffer,"active\n");
@@ -350,7 +262,6 @@
 			pnp_printf(buffer," 0x%lx-0x%lx \n",
 						pnp_port_start(dev, i),
 						pnp_port_end(dev, i));
-			pnp_print_conflict(buffer, dev, i, IORESOURCE_IO);
 		}
 	}
 	for (i = 0; i < PNP_MAX_MEM; i++) {
@@ -359,21 +270,18 @@
 			pnp_printf(buffer," 0x%lx-0x%lx \n",
 						pnp_mem_start(dev, i),
 						pnp_mem_end(dev, i));
-			pnp_print_conflict(buffer, dev, i, IORESOURCE_MEM);
 		}
 	}
 	for (i = 0; i < PNP_MAX_IRQ; i++) {
 		if (pnp_irq_valid(dev, i)) {
 			pnp_printf(buffer,"irq");
 			pnp_printf(buffer," %ld \n", pnp_irq(dev, i));
-			pnp_print_conflict(buffer, dev, i, IORESOURCE_IRQ);
 		}
 	}
 	for (i = 0; i < PNP_MAX_DMA; i++) {
 		if (pnp_dma_valid(dev, i)) {
 			pnp_printf(buffer,"dma");
 			pnp_printf(buffer," %ld \n", pnp_dma(dev, i));
-			pnp_print_conflict(buffer, dev, i, IORESOURCE_DMA);
 		}
 	}
 	ret = (buffer->curr - buf);
@@ -381,7 +289,7 @@
 	return ret;
 }
 
-extern int pnp_resolve_conflicts(struct pnp_dev *dev);
+extern struct semaphore pnp_res_mutex;
 
 static ssize_t
 pnp_set_current_resources(struct device * dmdev, const char * ubuf, size_t count)
@@ -390,6 +298,12 @@
 	char	*buf = (void *)ubuf;
 	int	retval = 0;
 
+	if (dev->status & PNP_ATTACHED) {
+		retval = -EBUSY;
+		pnp_info("Device %s cannot be configured because it is in use.", dev->dev.bus_id);
+		goto done;
+	}
+
 	while (isspace(*buf))
 		++buf;
 	if (!strnicmp(buf,"disable",7)) {
@@ -400,41 +314,23 @@
 		retval = pnp_activate_dev(dev);
 		goto done;
 	}
-	if (!strnicmp(buf,"reset",5)) {
-		if (!dev->active)
-			goto done;
-		retval = pnp_disable_dev(dev);
-		if (retval)
+	if (!strnicmp(buf,"fill",4)) {
+		if (dev->active)
 			goto done;
-		retval = pnp_activate_dev(dev);
+		retval = pnp_auto_config_dev(dev);
 		goto done;
 	}
 	if (!strnicmp(buf,"auto",4)) {
 		if (dev->active)
 			goto done;
+		pnp_init_resources(&dev->res);
 		retval = pnp_auto_config_dev(dev);
 		goto done;
 	}
 	if (!strnicmp(buf,"clear",5)) {
 		if (dev->active)
 			goto done;
-		spin_lock(&pnp_lock);
-		dev->config_mode = PNP_CONFIG_MANUAL;
-		pnp_init_resource_table(&dev->res);
-		if (dev->rule)
-			dev->rule->depnum = 0;
-		spin_unlock(&pnp_lock);
-		goto done;
-	}
-	if (!strnicmp(buf,"resolve",7)) {
-		retval = pnp_resolve_conflicts(dev);
-		goto done;
-	}
-	if (!strnicmp(buf,"get",3)) {
-		spin_lock(&pnp_lock);
-		if (pnp_can_read(dev))
-			dev->protocol->get(dev, &dev->res);
-		spin_unlock(&pnp_lock);
+		pnp_init_resources(&dev->res);
 		goto done;
 	}
 	if (!strnicmp(buf,"set",3)) {
@@ -442,9 +338,8 @@
 		if (dev->active)
 			goto done;
 		buf += 3;
-		spin_lock(&pnp_lock);
-		dev->config_mode = PNP_CONFIG_MANUAL;
-		pnp_init_resource_table(&dev->res);
+		pnp_init_resources(&dev->res);
+		down(&pnp_res_mutex);
 		while (1) {
 			while (isspace(*buf))
 				++buf;
@@ -514,7 +409,7 @@
 			}
 			break;
 		}
-		spin_unlock(&pnp_lock);
+		up(&pnp_res_mutex);
 		goto done;
 	}
  done:
@@ -543,7 +438,7 @@
 
 int pnp_interface_attach_device(struct pnp_dev *dev)
 {
-	device_create_file(&dev->dev,&dev_attr_possible);
+	device_create_file(&dev->dev,&dev_attr_options);
 	device_create_file(&dev->dev,&dev_attr_resources);
 	device_create_file(&dev->dev,&dev_attr_id);
 	return 0;
diff -Nru a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
--- a/drivers/pnp/isapnp/core.c	Wed Jun 18 23:02:24 2003
+++ b/drivers/pnp/isapnp/core.c	Wed Jun 18 23:02:24 2003
@@ -31,6 +31,7 @@
  *  2002-06-06  Made the use of dma channel 0 configurable
  *              Gerald Teschl <gerald.teschl@univie.ac.at>
  *  2002-10-06  Ported to PnP Layer - Adam Belay <ambx1@neo.rr.com>
+ *  2003-08-11	Resource Management Updates - Adam Belay <ambx1@neo.rr.com>
  */
 
 #include <linux/config.h>
@@ -460,6 +461,7 @@
 	dev->capabilities |= PNP_READ;
 	dev->capabilities |= PNP_WRITE;
 	dev->capabilities |= PNP_DISABLE;
+	pnp_init_resources(&dev->res);
 	return dev;
 }
 
@@ -468,8 +470,8 @@
  *  Add IRQ resource to resources list.
  */
 
-static void __init isapnp_add_irq_resource(struct pnp_dev *dev,
-                                               int depnum, int size)
+static void __init isapnp_parse_irq_resource(struct pnp_option *option,
+					       int size)
 {
 	unsigned char tmp[3];
 	struct pnp_irq *irq;
@@ -483,7 +485,7 @@
 		irq->flags = tmp[2];
 	else
 		irq->flags = IORESOURCE_IRQ_HIGHEDGE;
-	pnp_add_irq_resource(dev, depnum, irq);
+	pnp_register_irq_resource(option, irq);
 	return;
 }
 
@@ -491,8 +493,8 @@
  *  Add DMA resource to resources list.
  */
 
-static void __init isapnp_add_dma_resource(struct pnp_dev *dev,
-                                    	       int depnum, int size)
+static void __init isapnp_parse_dma_resource(struct pnp_option *option,
+                                    	       int size)
 {
 	unsigned char tmp[2];
 	struct pnp_dma *dma;
@@ -503,7 +505,7 @@
 		return;
 	dma->map = tmp[0];
 	dma->flags = tmp[1];
-	pnp_add_dma_resource(dev, depnum, dma);
+	pnp_register_dma_resource(option, dma);
 	return;
 }
 
@@ -511,8 +513,8 @@
  *  Add port resource to resources list.
  */
 
-static void __init isapnp_add_port_resource(struct pnp_dev *dev,
-						int depnum, int size)
+static void __init isapnp_parse_port_resource(struct pnp_option *option,
+						int size)
 {
 	unsigned char tmp[7];
 	struct pnp_port *port;
@@ -526,7 +528,7 @@
 	port->align = tmp[5];
 	port->size = tmp[6];
 	port->flags = tmp[0] ? PNP_PORT_FLAG_16BITADDR : 0;
-	pnp_add_port_resource(dev,depnum,port);
+	pnp_register_port_resource(option,port);
 	return;
 }
 
@@ -534,8 +536,8 @@
  *  Add fixed port resource to resources list.
  */
 
-static void __init isapnp_add_fixed_port_resource(struct pnp_dev *dev,
-						      int depnum, int size)
+static void __init isapnp_parse_fixed_port_resource(struct pnp_option *option,
+						      int size)
 {
 	unsigned char tmp[3];
 	struct pnp_port *port;
@@ -548,7 +550,7 @@
 	port->size = tmp[2];
 	port->align = 0;
 	port->flags = PNP_PORT_FLAG_FIXED;
-	pnp_add_port_resource(dev,depnum,port);
+	pnp_register_port_resource(option,port);
 	return;
 }
 
@@ -556,8 +558,8 @@
  *  Add memory resource to resources list.
  */
 
-static void __init isapnp_add_mem_resource(struct pnp_dev *dev,
-					       int depnum, int size)
+static void __init isapnp_parse_mem_resource(struct pnp_option *option,
+					       int size)
 {
 	unsigned char tmp[9];
 	struct pnp_mem *mem;
@@ -571,7 +573,7 @@
 	mem->align = (tmp[6] << 8) | tmp[5];
 	mem->size = ((tmp[8] << 8) | tmp[7]) << 8;
 	mem->flags = tmp[0];
-	pnp_add_mem_resource(dev,depnum,mem);
+	pnp_register_mem_resource(option,mem);
 	return;
 }
 
@@ -579,8 +581,8 @@
  *  Add 32-bit memory resource to resources list.
  */
 
-static void __init isapnp_add_mem32_resource(struct pnp_dev *dev,
-						 int depnum, int size)
+static void __init isapnp_parse_mem32_resource(struct pnp_option *option,
+						 int size)
 {
 	unsigned char tmp[17];
 	struct pnp_mem *mem;
@@ -594,15 +596,15 @@
 	mem->align = (tmp[12] << 24) | (tmp[11] << 16) | (tmp[10] << 8) | tmp[9];
 	mem->size = (tmp[16] << 24) | (tmp[15] << 16) | (tmp[14] << 8) | tmp[13];
 	mem->flags = tmp[0];
-	pnp_add_mem_resource(dev,depnum,mem);
+	pnp_register_mem_resource(option,mem);
 }
 
 /*
  *  Add 32-bit fixed memory resource to resources list.
  */
 
-static void __init isapnp_add_fixed_mem32_resource(struct pnp_dev *dev,
-						       int depnum, int size)
+static void __init isapnp_parse_fixed_mem32_resource(struct pnp_option *option,
+						       int size)
 {
 	unsigned char tmp[9];
 	struct pnp_mem *mem;
@@ -615,14 +617,14 @@
 	mem->size = (tmp[8] << 24) | (tmp[7] << 16) | (tmp[6] << 8) | tmp[5];
 	mem->align = 0;
 	mem->flags = tmp[0];
-	pnp_add_mem_resource(dev,depnum,mem);
+	pnp_register_mem_resource(option,mem);
 }
 
 /*
  *  Parse card name for ISA PnP device.
  */ 
- 
-static void __init 
+
+static void __init
 isapnp_parse_name(char *name, unsigned int name_max, unsigned short *size)
 {
 	if (name[0] == '\0') {
@@ -634,7 +636,7 @@
 		/* clean whitespace from end of string */
 		while (size1 > 0  &&  name[--size1] == ' ')
 			name[size1] = '\0';
-	}	
+	}
 }
 
 /*
@@ -644,14 +646,17 @@
 static int __init isapnp_create_device(struct pnp_card *card,
 				       unsigned short size)
 {
-	int number = 0, skip = 0, depnum = 0, dependent = 0, compat = 0;
+	int number = 0, skip = 0, priority = 0, compat = 0;
 	unsigned char type, tmp[17];
+	struct pnp_option *option;
 	struct pnp_dev *dev;
 	if ((dev = isapnp_parse_device(card, size, number++)) == NULL)
 		return 1;
-	if (pnp_build_resource(dev, 0) == NULL)
+	option = pnp_register_independent_option(dev);
+	if (!option)
 		return 1;
 	pnp_add_card_device(card,dev);
+
 	while (1) {
 		if (isapnp_read_tag(&type, &size)<0)
 			return 1;
@@ -662,15 +667,16 @@
 			if (size >= 5 && size <= 6) {
 				if ((dev = isapnp_parse_device(card, size, number++)) == NULL)
 					return 1;
-				pnp_build_resource(dev,0);
-				pnp_add_card_device(card,dev);
 				size = 0;
 				skip = 0;
+				option = pnp_register_independent_option(dev);
+				if (!option)
+					return 1;
+				pnp_add_card_device(card,dev);
 			} else {
 				skip = 1;
 			}
-			dependent = 0;
-			depnum = 0;
+			priority = 0;
 			compat = 0;
 			break;
 		case _STAG_COMPATDEVID:
@@ -684,43 +690,43 @@
 		case _STAG_IRQ:
 			if (size < 2 || size > 3)
 				goto __skip;
-			isapnp_add_irq_resource(dev, depnum, size);
+			isapnp_parse_irq_resource(option, size);
 			size = 0;
 			break;
 		case _STAG_DMA:
 			if (size != 2)
 				goto __skip;
-			isapnp_add_dma_resource(dev, depnum, size);
+			isapnp_parse_dma_resource(option, size);
 			size = 0;
 			break;
 		case _STAG_STARTDEP:
 			if (size > 1)
 				goto __skip;
-			dependent = 0x100 | PNP_RES_PRIORITY_ACCEPTABLE;
+			priority = 0x100 | PNP_RES_PRIORITY_ACCEPTABLE;
 			if (size > 0) {
 				isapnp_peek(tmp, size);
-				dependent = 0x100 | tmp[0];
+				priority = 0x100 | tmp[0];
 				size = 0;
 			}
-			pnp_build_resource(dev,dependent);
-			depnum = pnp_get_max_depnum(dev);
+			option = pnp_register_dependent_option(dev,priority);
+			if (!option)
+				return 1;
 			break;
 		case _STAG_ENDDEP:
 			if (size != 0)
 				goto __skip;
-			dependent = 0;
-			depnum = 0;
+			priority = 0;
 			break;
 		case _STAG_IOPORT:
 			if (size != 7)
 				goto __skip;
-			isapnp_add_port_resource(dev, depnum, size);
+			isapnp_parse_port_resource(option, size);
 			size = 0;
 			break;
 		case _STAG_FIXEDIO:
 			if (size != 3)
 				goto __skip;
-			isapnp_add_fixed_port_resource(dev, depnum, size);
+			isapnp_parse_fixed_port_resource(option, size);
 			size = 0;
 			break;
 		case _STAG_VENDOR:
@@ -728,7 +734,7 @@
 		case _LTAG_MEMRANGE:
 			if (size != 9)
 				goto __skip;
-			isapnp_add_mem_resource(dev, depnum, size);
+			isapnp_parse_mem_resource(option, size);
 			size = 0;
 			break;
 		case _LTAG_ANSISTR:
@@ -743,13 +749,13 @@
 		case _LTAG_MEM32RANGE:
 			if (size != 17)
 				goto __skip;
-			isapnp_add_mem32_resource(dev, depnum, size);
+			isapnp_parse_mem32_resource(option, size);
 			size = 0;
 			break;
 		case _LTAG_FIXEDMEM32RANGE:
 			if (size != 9)
 				goto __skip;
-			isapnp_add_fixed_mem32_resource(dev, depnum, size);
+			isapnp_parse_fixed_mem32_resource(option, size);
 			size = 0;
 			break;
 		case _STAG_END:
@@ -859,63 +865,6 @@
 	pnp_add_card_id(id,card);
 }
 
-
-static int isapnp_parse_current_resources(struct pnp_dev *dev, struct pnp_resource_table * res)
-{
-	int tmp, ret;
-	struct pnp_rule_table rule;
-	if (dev->rule)
-		rule = *dev->rule;
-	else {
-		if (!pnp_generate_rule(dev,1,&rule))
-			return -EINVAL;
-	}
-
-	dev->active = isapnp_read_byte(ISAPNP_CFG_ACTIVATE);
-	if (dev->active) {
-		for (tmp = 0; tmp < PNP_MAX_PORT; tmp++) {
-			ret = isapnp_read_word(ISAPNP_CFG_PORT + (tmp << 1));
-			if (!ret)
-				continue;
-			res->port_resource[tmp].start = ret;
-			if (rule.port[tmp])
-				res->port_resource[tmp].end = ret + rule.port[tmp]->size - 1;
-			else
-				res->port_resource[tmp].end = ret + 1; /* all we can do is assume 1 :-( */
-			res->port_resource[tmp].flags = IORESOURCE_IO;
-		}
-		for (tmp = 0; tmp < PNP_MAX_MEM; tmp++) {
-			ret = isapnp_read_dword(ISAPNP_CFG_MEM + (tmp << 3));
-			if (!ret)
-				continue;
-			res->mem_resource[tmp].start = ret;
-			if (rule.mem[tmp])
-				res->mem_resource[tmp].end = ret + rule.mem[tmp]->size - 1;
-			else
-				res->mem_resource[tmp].end = ret + 1; /* all we can do is assume 1 :-( */
-			res->mem_resource[tmp].flags = IORESOURCE_MEM;
-		}
-		for (tmp = 0; tmp < PNP_MAX_IRQ; tmp++) {
-			ret = (isapnp_read_word(ISAPNP_CFG_IRQ + (tmp << 1)) >> 8);
-			if (!ret)
-				continue;
-			res->irq_resource[tmp].start = res->irq_resource[tmp].end = ret;
-			res->irq_resource[tmp].flags = IORESOURCE_IRQ;
-		}
-		for (tmp = 0; tmp < PNP_MAX_DMA; tmp++) {
-			ret = isapnp_read_byte(ISAPNP_CFG_DMA + tmp);
-			if (ret == 4)
-				continue;
-			if (rule.dma[tmp]) { /* some isapnp systems forget to set this to 4 so we have to check */
-				res->dma_resource[tmp].start = res->dma_resource[tmp].end = ret;
-				res->dma_resource[tmp].flags = IORESOURCE_DMA;
-			}
-		}
-	}
-	return 0;
-}
-
-
 /*
  *  Build device list for all present ISA PnP devices.
  */
@@ -925,7 +874,6 @@
 	int csn;
 	unsigned char header[9], checksum;
 	struct pnp_card *card;
-	struct pnp_dev *dev;
 
 	isapnp_wait();
 	isapnp_key();
@@ -959,13 +907,6 @@
 		card->checksum = isapnp_checksum_value;
 		card->protocol = &isapnp_protocol;
 
-		/* read the current resource data */
-		card_for_each_dev(card,dev) {
-			isapnp_device(dev->number);
-		pnp_init_resource_table(&dev->res);
-			isapnp_parse_current_resources(dev, &dev->res);
-		}
-
 		pnp_add_card(card);
 	}
 	isapnp_wait();
@@ -1041,12 +982,50 @@
 EXPORT_SYMBOL(isapnp_wake);
 EXPORT_SYMBOL(isapnp_device);
 
+static int isapnp_read_resources(struct pnp_dev *dev, struct pnp_resource_table *res)
+{
+	int tmp, ret;
+
+	dev->active = isapnp_read_byte(ISAPNP_CFG_ACTIVATE);
+	if (dev->active) {
+		for (tmp = 0; tmp < PNP_MAX_PORT; tmp++) {
+			ret = isapnp_read_word(ISAPNP_CFG_PORT + (tmp << 1));
+			if (!ret)
+				continue;
+			res->port_resource[tmp].start = ret;
+			res->port_resource[tmp].flags = IORESOURCE_IO;
+		}
+		for (tmp = 0; tmp < PNP_MAX_MEM; tmp++) {
+			ret = isapnp_read_dword(ISAPNP_CFG_MEM + (tmp << 3));
+			if (!ret)
+				continue;
+			res->mem_resource[tmp].start = ret;
+			res->mem_resource[tmp].flags = IORESOURCE_MEM;
+		}
+		for (tmp = 0; tmp < PNP_MAX_IRQ; tmp++) {
+			ret = (isapnp_read_word(ISAPNP_CFG_IRQ + (tmp << 1)) >> 8);
+			if (!ret)
+				continue;
+			res->irq_resource[tmp].start = res->irq_resource[tmp].end = ret;
+			res->irq_resource[tmp].flags = IORESOURCE_IRQ;
+		}
+		for (tmp = 0; tmp < PNP_MAX_DMA; tmp++) {
+			ret = isapnp_read_byte(ISAPNP_CFG_DMA + tmp);
+			if (ret == 4)
+				continue;
+			res->dma_resource[tmp].start = res->dma_resource[tmp].end = ret;
+			res->dma_resource[tmp].flags = IORESOURCE_DMA;
+		}
+	}
+	return 0;
+}
+
 static int isapnp_get_resources(struct pnp_dev *dev, struct pnp_resource_table * res)
 {
 	int ret;
-	pnp_init_resource_table(res);
+	pnp_init_resources(res);
 	isapnp_cfg_begin(dev->card->number, dev->number);
-	ret = isapnp_parse_current_resources(dev, res);
+	ret = isapnp_read_resources(dev, res);
 	isapnp_cfg_end();
 	return ret;
 }
diff -Nru a/drivers/pnp/manager.c b/drivers/pnp/manager.c
--- a/drivers/pnp/manager.c	Wed Jun 18 23:02:24 2003
+++ b/drivers/pnp/manager.c	Wed Jun 18 23:02:24 2003
@@ -1,6 +1,7 @@
 /*
  * manager.c - Resource Management, Conflict Resolution, Activation and Disabling of Devices
  *
+ * based on isapnp.c resource management (c) Jaroslav Kysela <perex@suse.cz>
  * Copyright 2003 Adam Belay <ambx1@neo.rr.com>
  *
  */
@@ -20,549 +21,339 @@
 #include <linux/pnp.h>
 #include "base.h"
 
+DECLARE_MUTEX(pnp_res_mutex);
 
-int pnp_max_moves = 4;
-
-
-static int pnp_next_port(struct pnp_dev * dev, int idx)
+static int pnp_assign_port(struct pnp_dev *dev, struct pnp_port *rule, int idx)
 {
-	struct pnp_port *port;
 	unsigned long *start, *end, *flags;
-	if (!dev || idx < 0 || idx >= PNP_MAX_PORT)
-		return 0;
-	port = dev->rule->port[idx];
-	if (!port)
+
+	if (!dev || !rule)
+		return -EINVAL;
+
+	if (idx >= PNP_MAX_PORT) {
+		pnp_err("More than 4 ports is incompatible with pnp specifications.");
+		/* pretend we were successful so at least the manager won't try again */
+		return 1;
+	}
+
+	/* check if this resource has been manually set, if so skip */
+	if (!(dev->res.port_resource[idx].flags & IORESOURCE_AUTO))
 		return 1;
 
 	start = &dev->res.port_resource[idx].start;
 	end = &dev->res.port_resource[idx].end;
 	flags = &dev->res.port_resource[idx].flags;
 
-	/* set the initial values if this is the first time */
-	if (*start == 0) {
-		*start = port->min;
-		*end = *start + port->size - 1;
-		*flags = port->flags | IORESOURCE_IO;
-		if (!pnp_check_port(dev, idx))
-			return 1;
-	}
+	/* set the initial values */
+	*start = rule->min;
+	*end = *start + rule->size - 1;
+	*flags = *flags | rule->flags | IORESOURCE_IO;
 
 	/* run through until pnp_check_port is happy */
-	do {
-		*start += port->align;
-		*end = *start + port->size - 1;
-		if (*start > port->max || !port->align)
+	while (!pnp_check_port(dev, idx)) {
+		*start += rule->align;
+		*end = *start + rule->size - 1;
+		if (*start > rule->max || !rule->align)
 			return 0;
-	} while (pnp_check_port(dev, idx));
+	}
 	return 1;
 }
 
-static int pnp_next_mem(struct pnp_dev * dev, int idx)
+static int pnp_assign_mem(struct pnp_dev *dev, struct pnp_mem *rule, int idx)
 {
-	struct pnp_mem *mem;
 	unsigned long *start, *end, *flags;
-	if (!dev || idx < 0 || idx >= PNP_MAX_MEM)
-		return 0;
-	mem = dev->rule->mem[idx];
-	if (!mem)
+
+	if (!dev || !rule)
+		return -EINVAL;
+
+	if (idx >= PNP_MAX_MEM) {
+		pnp_err("More than 8 mems is incompatible with pnp specifications.");
+		/* pretend we were successful so at least the manager won't try again */
+		return 1;
+	}
+
+	/* check if this resource has been manually set, if so skip */
+	if (!(dev->res.mem_resource[idx].flags & IORESOURCE_AUTO))
 		return 1;
 
 	start = &dev->res.mem_resource[idx].start;
 	end = &dev->res.mem_resource[idx].end;
 	flags = &dev->res.mem_resource[idx].flags;
 
-	/* set the initial values if this is the first time */
-	if (*start == 0) {
-		*start = mem->min;
-		*end = *start + mem->size -1;
-		*flags = mem->flags | IORESOURCE_MEM;
-		if (!(mem->flags & IORESOURCE_MEM_WRITEABLE))
-			*flags |= IORESOURCE_READONLY;
-		if (mem->flags & IORESOURCE_MEM_CACHEABLE)
-			*flags |= IORESOURCE_CACHEABLE;
-		if (mem->flags & IORESOURCE_MEM_RANGELENGTH)
-			*flags |= IORESOURCE_RANGELENGTH;
-		if (mem->flags & IORESOURCE_MEM_SHADOWABLE)
-			*flags |= IORESOURCE_SHADOWABLE;
-		if (!pnp_check_mem(dev, idx))
-			return 1;
-	}
+	/* set the initial values */
+	*start = rule->min;
+	*end = *start + rule->size -1;
+	*flags = *flags | rule->flags | IORESOURCE_MEM;
+
+	/* convert pnp flags to standard Linux flags */
+	if (!(rule->flags & IORESOURCE_MEM_WRITEABLE))
+		*flags |= IORESOURCE_READONLY;
+	if (rule->flags & IORESOURCE_MEM_CACHEABLE)
+		*flags |= IORESOURCE_CACHEABLE;
+	if (rule->flags & IORESOURCE_MEM_RANGELENGTH)
+		*flags |= IORESOURCE_RANGELENGTH;
+	if (rule->flags & IORESOURCE_MEM_SHADOWABLE)
+		*flags |= IORESOURCE_SHADOWABLE;
 
 	/* run through until pnp_check_mem is happy */
-	do {
-		*start += mem->align;
-		*end = *start + mem->size - 1;
-		if (*start > mem->max || !mem->align)
+	while (!pnp_check_mem(dev, idx)) {
+		*start += rule->align;
+		*end = *start + rule->size - 1;
+		if (*start > rule->max || !rule->align)
 			return 0;
-	} while (pnp_check_mem(dev, idx));
+	}
 	return 1;
 }
 
-static int pnp_next_irq(struct pnp_dev * dev, int idx)
+static int pnp_assign_irq(struct pnp_dev * dev, struct pnp_irq *rule, int idx)
 {
-	struct pnp_irq *irq;
 	unsigned long *start, *end, *flags;
-	int i, mask;
-	if (!dev || idx < 0 || idx >= PNP_MAX_IRQ)
-		return 0;
-	irq = dev->rule->irq[idx];
-	if (!irq)
-		return 1;
+	int i;
 
-	start = &dev->res.irq_resource[idx].start;
-	end = &dev->res.irq_resource[idx].end;
-	flags = &dev->res.irq_resource[idx].flags;
+	/* IRQ priority: this table is good for i386 */
+	static unsigned short xtab[16] = {
+		5, 10, 11, 12, 9, 14, 15, 7, 3, 4, 13, 0, 1, 6, 8, 2
+	};
 
-	/* set the initial values if this is the first time */
-	if (*start == -1) {
-		*start = *end = 0;
-		*flags = irq->flags | IORESOURCE_IRQ;
-		if (!pnp_check_irq(dev, idx))
-			return 1;
-	}
+	if (!dev || !rule)
+		return -EINVAL;
 
-	mask = irq->map;
-	for (i = *start + 1; i < 16; i++)
-	{
-		if(mask>>i & 0x01) {
-			*start = *end = i;
-			if(!pnp_check_irq(dev, idx))
-				return 1;
-		}
+	if (idx >= PNP_MAX_IRQ) {
+		pnp_err("More than 2 irqs is incompatible with pnp specifications.");
+		/* pretend we were successful so at least the manager won't try again */
+		return 1;
 	}
-	return 0;
-}
 
-static int pnp_next_dma(struct pnp_dev * dev, int idx)
-{
-	struct pnp_dma *dma;
-	unsigned long *start, *end, *flags;
-	int i, mask;
-	if (!dev || idx < 0 || idx >= PNP_MAX_DMA)
-		return -EINVAL;
-	dma = dev->rule->dma[idx];
-	if (!dma)
+	/* check if this resource has been manually set, if so skip */
+	if (!(dev->res.irq_resource[idx].flags & IORESOURCE_AUTO))
 		return 1;
 
-	start = &dev->res.dma_resource[idx].start;
-	end = &dev->res.dma_resource[idx].end;
-	flags = &dev->res.dma_resource[idx].flags;
+	start = &dev->res.irq_resource[idx].start;
+	end = &dev->res.irq_resource[idx].end;
+	flags = &dev->res.irq_resource[idx].flags;
 
-	/* set the initial values if this is the first time */
-	if (*start == -1) {
-		*start = *end = 0;
-		*flags = dma->flags | IORESOURCE_DMA;
-		if (!pnp_check_dma(dev, idx))
-			return 1;
-	}
+	/* set the initial values */
+	*flags = *flags | rule->flags | IORESOURCE_IRQ;
 
-	mask = dma->map;
-	for (i = *start + 1; i < 8; i++)
-	{
-		if(mask>>i & 0x01) {
-			*start = *end = i;
-			if(!pnp_check_dma(dev, idx))
+	for (i = 0; i < 16; i++) {
+		if(rule->map & (1<<xtab[i])) {
+			*start = *end = xtab[i];
+			if(pnp_check_irq(dev, idx))
 				return 1;
 		}
 	}
 	return 0;
 }
 
-static int pnp_next_rule(struct pnp_dev *dev)
-{
-	int depnum = dev->rule->depnum;
-        int max = pnp_get_max_depnum(dev);
-	int priority = PNP_RES_PRIORITY_PREFERRED;
-
-	if (depnum < 0)
-		return 0;
-
-	if (max == 0) {
-		if (pnp_generate_rule(dev, 0, dev->rule)) {
-			dev->rule->depnum = -1;
-			return 1;
-		}
-	}
-
-	if(depnum > 0) {
-		struct pnp_resources * res = pnp_find_resources(dev, depnum);
-		priority = res->priority;
-	}
-
-	for (; priority <= PNP_RES_PRIORITY_FUNCTIONAL; priority++, depnum = 0) {
-		depnum += 1;
-		for (; depnum <= max; depnum++) {
-			struct pnp_resources * res = pnp_find_resources(dev, depnum);
-			if (res->priority == priority) {
-				if(pnp_generate_rule(dev, depnum, dev->rule)) {
-					dev->rule->depnum = depnum;
-					return 1;
-				}
-			}
-		}
-	}
-	return 0;
-}
-
-struct pnp_change {
-	struct list_head change_list;
-	struct list_head changes;
-	struct pnp_resource_table res_bak;
-	struct pnp_rule_table rule_bak;
-	struct pnp_dev * dev;
-};
-
-static void pnp_free_changes(struct pnp_change * parent)
-{
-	struct list_head * pos, * temp;
-	list_for_each_safe(pos, temp, &parent->changes) {
-		struct pnp_change * change = list_entry(pos, struct pnp_change, change_list);
-		list_del(&change->change_list);
-		kfree(change);
-	}
-}
-
-static void pnp_undo_changes(struct pnp_change * parent)
-{
-	struct list_head * pos, * temp;
-	list_for_each_safe(pos, temp, &parent->changes) {
-		struct pnp_change * change = list_entry(pos, struct pnp_change, change_list);
-		*change->dev->rule = change->rule_bak;
-		change->dev->res = change->res_bak;
-		list_del(&change->change_list);
-		kfree(change);
-	}
-}
-
-static struct pnp_change * pnp_add_change(struct pnp_change * parent, struct pnp_dev * dev)
-{
-	struct pnp_change * change = pnp_alloc(sizeof(struct pnp_change));
-	if (!change)
-		return NULL;
-	change->res_bak = dev->res;
-	change->rule_bak = *dev->rule;
-	change->dev = dev;
-	INIT_LIST_HEAD(&change->changes);
-	if (parent)
-		list_add(&change->change_list, &parent->changes);
-	return change;
-}
-
-static void pnp_commit_changes(struct pnp_change * parent, struct pnp_change * change)
-{
-	/* check if it's the root change */
-	if (!parent)
-		return;
-	if (!list_empty(&change->changes))
-		list_splice_init(&change->changes, &parent->changes);
-}
-
-static int pnp_next_config(struct pnp_dev * dev, int move, struct pnp_change * parent);
-
-static int pnp_next_request(struct pnp_dev * dev, int move, struct pnp_change * parent, struct pnp_change * change)
+static int pnp_assign_dma(struct pnp_dev *dev, struct pnp_dma *rule, int idx)
 {
+	unsigned long *start, *end, *flags;
 	int i;
-	struct pnp_dev * cdev;
 
-	for (i = 0; i < PNP_MAX_PORT; i++) {
-		if (dev->res.port_resource[i].start == 0
-		 || pnp_check_port_conflicts(dev,i,SEARCH_WARM)) {
-			if (!pnp_next_port(dev,i))
-				return 0;
-		}
-		do {
-			cdev = pnp_check_port_conflicts(dev,i,SEARCH_COLD);
-			if (cdev && (!move || !pnp_next_config(cdev,move,change))) {
-				pnp_undo_changes(change);
-				if (!pnp_next_port(dev,i))
-					return 0;
-			}
-		} while (cdev);
-		pnp_commit_changes(parent, change);
-	}
-	for (i = 0; i < PNP_MAX_MEM; i++) {
-		if (dev->res.mem_resource[i].start == 0
-		 || pnp_check_mem_conflicts(dev,i,SEARCH_WARM)) {
-			if (!pnp_next_mem(dev,i))
-				return 0;
-		}
-		do {
-			cdev = pnp_check_mem_conflicts(dev,i,SEARCH_COLD);
-			if (cdev && (!move || !pnp_next_config(cdev,move,change))) {
-				pnp_undo_changes(change);
-				if (!pnp_next_mem(dev,i))
-					return 0;
-			}
-		} while (cdev);
-		pnp_commit_changes(parent, change);
-	}
-	for (i = 0; i < PNP_MAX_IRQ; i++) {
-		if (dev->res.irq_resource[i].start == -1
-		 || pnp_check_irq_conflicts(dev,i,SEARCH_WARM)) {
-			if (!pnp_next_irq(dev,i))
-				return 0;
-		}
-		do {
-			cdev = pnp_check_irq_conflicts(dev,i,SEARCH_COLD);
-			if (cdev && (!move || !pnp_next_config(cdev,move,change))) {
-				pnp_undo_changes(change);
-				if (!pnp_next_irq(dev,i))
-					return 0;
-			}
-		} while (cdev);
-		pnp_commit_changes(parent, change);
-	}
-	for (i = 0; i < PNP_MAX_DMA; i++) {
-		if (dev->res.dma_resource[i].start == -1
-		 || pnp_check_dma_conflicts(dev,i,SEARCH_WARM)) {
-			if (!pnp_next_dma(dev,i))
-				return 0;
-		}
-		do {
-			cdev = pnp_check_dma_conflicts(dev,i,SEARCH_COLD);
-			if (cdev && (!move || !pnp_next_config(cdev,move,change))) {
-				pnp_undo_changes(change);
-				if (!pnp_next_dma(dev,i))
-					return 0;
-			}
-		} while (cdev);
-		pnp_commit_changes(parent, change);
-	}
-	return 1;
-}
-
-static int pnp_next_config(struct pnp_dev * dev, int move, struct pnp_change * parent)
-{
-	struct pnp_change * change;
-	move--;
-	if (!dev->rule)
-		return 0;
-	change = pnp_add_change(parent,dev);
-	if (!change)
-		return 0;
-	if (!pnp_can_configure(dev))
-		goto fail;
-	if (!dev->rule->depnum) {
-		if (!pnp_next_rule(dev))
-			goto fail;
-	}
-	while (!pnp_next_request(dev, move, parent, change)) {
-		if(!pnp_next_rule(dev))
-			goto fail;
-		pnp_init_resource_table(&dev->res);
-	}
-	if (!parent) {
-		pnp_free_changes(change);
-		kfree(change);
-	}
-	return 1;
+	/* DMA priority: this table is good for i386 */
+	static unsigned short xtab[8] = {
+		1, 3, 5, 6, 7, 0, 2, 4
+	};
 
-fail:
-	if (!parent)
-		kfree(change);
-	return 0;
-}
+	if (!dev || !rule)
+		return -EINVAL;
 
-/* this advanced algorithm will shuffle other configs to make room and ensure that the most possible devices have configs */
-static int pnp_advanced_config(struct pnp_dev * dev)
-{
-	int move;
-	/* if the device cannot be configured skip it */
-	if (!pnp_can_configure(dev))
+	if (idx >= PNP_MAX_DMA) {
+		pnp_err("More than 2 dmas is incompatible with pnp specifications.");
+		/* pretend we were successful so at least the manager won't try again */
 		return 1;
-	if (!dev->rule) {
-		dev->rule = pnp_alloc(sizeof(struct pnp_rule_table));
-		if (!dev->rule)
-			return -ENOMEM;
 	}
 
-	spin_lock(&pnp_lock);
-	for (move = 1; move <= pnp_max_moves; move++) {
-		dev->rule->depnum = 0;
-		pnp_init_resource_table(&dev->res);
-		if (pnp_next_config(dev,move,NULL)) {
-			spin_unlock(&pnp_lock);
-			return 1;
-		}
-	}
-
-	pnp_init_resource_table(&dev->res);
-	dev->rule->depnum = 0;
-	spin_unlock(&pnp_lock);
-	pnp_err("res: Unable to resolve resource conflicts for the device '%s', some devices may not be usable.", dev->dev.bus_id);
-	return 0;
-}
+	/* check if this resource has been manually set, if so skip */
+	if (!(dev->res.dma_resource[idx].flags & IORESOURCE_AUTO))
+		return 1;
 
-int pnp_resolve_conflicts(struct pnp_dev *dev)
-{
-	int i;
-	struct pnp_dev * cdev;
+	start = &dev->res.dma_resource[idx].start;
+	end = &dev->res.dma_resource[idx].end;
+	flags = &dev->res.dma_resource[idx].flags;
 
-	for (i = 0; i < PNP_MAX_PORT; i++)
-	{
-		do {
-			cdev = pnp_check_port_conflicts(dev,i,SEARCH_COLD);
-			if (cdev)
-				pnp_advanced_config(cdev);
-		} while (cdev);
-	}
-	for (i = 0; i < PNP_MAX_MEM; i++)
-	{
-		do {
-			cdev = pnp_check_mem_conflicts(dev,i,SEARCH_COLD);
-			if (cdev)
-				pnp_advanced_config(cdev);
-		} while (cdev);
-	}
-	for (i = 0; i < PNP_MAX_IRQ; i++)
-	{
-		do {
-			cdev = pnp_check_irq_conflicts(dev,i,SEARCH_COLD);
-			if (cdev)
-				pnp_advanced_config(cdev);
-		} while (cdev);
-	}
-	for (i = 0; i < PNP_MAX_DMA; i++)
-	{
-		do {
-			cdev = pnp_check_dma_conflicts(dev,i,SEARCH_COLD);
-			if (cdev)
-				pnp_advanced_config(cdev);
-		} while (cdev);
-	}
-	return 1;
-}
+	/* set the initial values */
+	*flags = *flags | rule->flags | IORESOURCE_DMA;
 
-/* this is a much faster algorithm but it may not leave resources for other devices to use */
-static int pnp_simple_config(struct pnp_dev * dev)
-{
-	int i;
-	spin_lock(&pnp_lock);
-	if (dev->active) {
-		spin_unlock(&pnp_lock);
-		return 1;
-	}
-	if (!dev->rule) {
-		dev->rule = pnp_alloc(sizeof(struct pnp_rule_table));
-		if (!dev->rule) {
-			spin_unlock(&pnp_lock);
-			return -ENOMEM;
-		}
-	}
-	dev->rule->depnum = 0;
-	pnp_init_resource_table(&dev->res);
-	while (pnp_next_rule(dev)) {
-		for (i = 0; i < PNP_MAX_PORT; i++) {
-			if (!pnp_next_port(dev,i))
-				continue;
-		}
-		for (i = 0; i < PNP_MAX_MEM; i++) {
-			if (!pnp_next_mem(dev,i))
-				continue;
-		}
-		for (i = 0; i < PNP_MAX_IRQ; i++) {
-			if (!pnp_next_irq(dev,i))
-				continue;
-		}
-		for (i = 0; i < PNP_MAX_DMA; i++) {
-			if (!pnp_next_dma(dev,i))
-				continue;
+	for (i = 0; i < 8; i++) {
+		if(rule->map & (1<<xtab[i])) {
+			*start = *end = xtab[i];
+			if(pnp_check_dma(dev, idx))
+				return 1;
 		}
-		goto done;
 	}
-	pnp_init_resource_table(&dev->res);
-	dev->rule->depnum = 0;
-	spin_unlock(&pnp_lock);
 	return 0;
-
-done:
-	pnp_resolve_conflicts(dev);	/* this is required or we will break the advanced configs */
-	return 1;
 }
 
-static int pnp_compare_resources(struct pnp_resource_table * resa, struct pnp_resource_table * resb)
+/**
+ * pnp_init_resources - Resets a resource table to default values.
+ * @table: pointer to the desired resource table
+ *
+ */
+void pnp_init_resources(struct pnp_resource_table *table)
 {
 	int idx;
+	down(&pnp_res_mutex);
 	for (idx = 0; idx < PNP_MAX_IRQ; idx++) {
-		if (resa->irq_resource[idx].start != resb->irq_resource[idx].start)
-			return 1;
+		table->irq_resource[idx].name = NULL;
+		table->irq_resource[idx].start = -1;
+		table->irq_resource[idx].end = -1;
+		table->irq_resource[idx].flags = IORESOURCE_AUTO;
 	}
 	for (idx = 0; idx < PNP_MAX_DMA; idx++) {
-		if (resa->dma_resource[idx].start != resb->dma_resource[idx].start)
-			return 1;
+		table->dma_resource[idx].name = NULL;
+		table->dma_resource[idx].start = -1;
+		table->dma_resource[idx].end = -1;
+		table->dma_resource[idx].flags = IORESOURCE_AUTO;
 	}
 	for (idx = 0; idx < PNP_MAX_PORT; idx++) {
-		if (resa->port_resource[idx].start != resb->port_resource[idx].start)
-			return 1;
-		if (resa->port_resource[idx].end != resb->port_resource[idx].end)
-			return 1;
+		table->port_resource[idx].name = NULL;
+		table->port_resource[idx].start = 0;
+		table->port_resource[idx].end = 0;
+		table->port_resource[idx].flags = IORESOURCE_AUTO;
 	}
 	for (idx = 0; idx < PNP_MAX_MEM; idx++) {
-		if (resa->mem_resource[idx].start != resb->mem_resource[idx].start)
-			return 1;
-		if (resa->mem_resource[idx].end != resb->mem_resource[idx].end)
-			return 1;
+		table->mem_resource[idx].name = NULL;
+		table->mem_resource[idx].start = 0;
+		table->mem_resource[idx].end = 0;
+		table->mem_resource[idx].flags = IORESOURCE_AUTO;
 	}
-	return 0;
+	up(&pnp_res_mutex);
 }
 
-
-/*
- * PnP Device Resource Management
- */
-
 /**
- * pnp_auto_config_dev - determines the best possible resource configuration based on available information
- * @dev: pointer to the desired device
+ * pnp_clean_resources - clears resources that were not manually set
+ * @res - the resources to clean
  *
  */
-
-int pnp_auto_config_dev(struct pnp_dev *dev)
-{
-	int error;
-	if(!dev)
-		return -EINVAL;
-
-	dev->config_mode = PNP_CONFIG_AUTO;
-
-	if(dev->active)
-		error = pnp_resolve_conflicts(dev);
-	else
-		error = pnp_advanced_config(dev);
-	return error;
-}
-
-static void pnp_process_manual_resources(struct pnp_resource_table * ctab, struct pnp_resource_table * ntab)
+static void pnp_clean_resources(struct pnp_resource_table * res)
 {
 	int idx;
 	for (idx = 0; idx < PNP_MAX_IRQ; idx++) {
-		if (ntab->irq_resource[idx].flags & IORESOURCE_AUTO)
+		if (!(res->irq_resource[idx].flags & IORESOURCE_AUTO))
 			continue;
-		ctab->irq_resource[idx].start = ntab->irq_resource[idx].start;
-		ctab->irq_resource[idx].end = ntab->irq_resource[idx].end;
-		ctab->irq_resource[idx].flags = ntab->irq_resource[idx].flags;
+		res->irq_resource[idx].start = -1;
+		res->irq_resource[idx].end = -1;
+		res->irq_resource[idx].flags = IORESOURCE_AUTO;
 	}
 	for (idx = 0; idx < PNP_MAX_DMA; idx++) {
-		if (ntab->dma_resource[idx].flags & IORESOURCE_AUTO)
+		if (!(res->dma_resource[idx].flags & IORESOURCE_AUTO))
 			continue;
-		ctab->dma_resource[idx].start = ntab->dma_resource[idx].start;
-		ctab->dma_resource[idx].end = ntab->dma_resource[idx].end;
-		ctab->dma_resource[idx].flags = ntab->dma_resource[idx].flags;
+		res->dma_resource[idx].start = -1;
+		res->dma_resource[idx].end = -1;
+		res->dma_resource[idx].flags = IORESOURCE_AUTO;
 	}
 	for (idx = 0; idx < PNP_MAX_PORT; idx++) {
-		if (ntab->port_resource[idx].flags & IORESOURCE_AUTO)
+		if (!(res->port_resource[idx].flags & IORESOURCE_AUTO))
 			continue;
-		ctab->port_resource[idx].start = ntab->port_resource[idx].start;
-		ctab->port_resource[idx].end = ntab->port_resource[idx].end;
-		ctab->port_resource[idx].flags = ntab->port_resource[idx].flags;
+		res->port_resource[idx].start = 0;
+		res->port_resource[idx].end = 0;
+		res->port_resource[idx].flags = IORESOURCE_AUTO;
 	}
 	for (idx = 0; idx < PNP_MAX_MEM; idx++) {
-		if (ntab->irq_resource[idx].flags & IORESOURCE_AUTO)
+		if (!(res->mem_resource[idx].flags & IORESOURCE_AUTO))
 			continue;
-		ctab->irq_resource[idx].start = ntab->mem_resource[idx].start;
-		ctab->irq_resource[idx].end = ntab->mem_resource[idx].end;
-		ctab->irq_resource[idx].flags = ntab->mem_resource[idx].flags;
+		res->mem_resource[idx].start = 0;
+		res->mem_resource[idx].end = 0;
+		res->mem_resource[idx].flags = IORESOURCE_AUTO;
+	}
+}
+
+/**
+ * pnp_assign_resources - assigns resources to the device based on the specified dependent number
+ * @dev: pointer to the desired device
+ * @depnum: the dependent function number
+ *
+ * Only set depnum to 0 if the device does not have dependent options.
+ */
+int pnp_assign_resources(struct pnp_dev *dev, int depnum)
+{
+	struct pnp_port *port;
+	struct pnp_mem *mem;
+	struct pnp_irq *irq;
+	struct pnp_dma *dma;
+	int nport = 0, nmem = 0, nirq = 0, ndma = 0;
+
+	if (!pnp_can_configure(dev))
+		return -ENODEV;
+
+	down(&pnp_res_mutex);
+	pnp_clean_resources(&dev->res); /* start with a fresh slate */
+	if (dev->independent) {
+		port = dev->independent->port;
+		mem = dev->independent->mem;
+		irq = dev->independent->irq;
+		dma = dev->independent->dma;
+		while (port) {
+			if (!pnp_assign_port(dev, port, nport))
+				goto fail;
+			nport++;
+			port = port->next;
+		}
+		while (mem) {
+			if (!pnp_assign_mem(dev, mem, nmem))
+				goto fail;
+			nmem++;
+			mem = mem->next;
+		}
+		while (irq) {
+			if (!pnp_assign_irq(dev, irq, nirq))
+				goto fail;
+			nirq++;
+			irq = irq->next;
+		}
+		while (dma) {
+			if (!pnp_assign_dma(dev, dma, ndma))
+				goto fail;
+			ndma++;
+			dma = dma->next;
+		}
 	}
+
+	if (depnum) {
+		struct pnp_option *dep;
+		int i;
+		for (i=1,dep=dev->dependent; i<depnum; i++, dep=dep->next)
+			if(!dep)
+				goto fail;
+		port =dep->port;
+		mem = dep->mem;
+		irq = dep->irq;
+		dma = dep->dma;
+		while (port) {
+			if (!pnp_assign_port(dev, port, nport))
+				goto fail;
+			nport++;
+			port = port->next;
+		}
+		while (mem) {
+			if (!pnp_assign_mem(dev, mem, nmem))
+				goto fail;
+			nmem++;
+			mem = mem->next;
+		}
+		while (irq) {
+			if (!pnp_assign_irq(dev, irq, nirq))
+				goto fail;
+			nirq++;
+			irq = irq->next;
+		}
+		while (dma) {
+			if (!pnp_assign_dma(dev, dma, ndma))
+				goto fail;
+			ndma++;
+			dma = dma->next;
+		}
+	} else if (dev->dependent)
+		goto fail;
+
+	up(&pnp_res_mutex);
+	return 1;
+
+fail:
+	pnp_clean_resources(&dev->res);
+	up(&pnp_res_mutex);
+	return 0;
 }
 
 /**
@@ -572,22 +363,21 @@
  *
  * This function can be used by drivers that want to manually set thier resources.
  */
-
 int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table * res, int mode)
 {
 	int i;
 	struct pnp_resource_table * bak;
 	if (!dev || !res)
 		return -EINVAL;
-	if (dev->active)
-		return -EBUSY;
+	if (!pnp_can_configure(dev))
+		return -ENODEV;
 	bak = pnp_alloc(sizeof(struct pnp_resource_table));
 	if (!bak)
 		return -ENOMEM;
 	*bak = dev->res;
 
-	spin_lock(&pnp_lock);
-	pnp_process_manual_resources(&dev->res, res);
+	down(&pnp_res_mutex);
+	dev->res = *res;
 	if (!(mode & PNP_CONFIG_FORCE)) {
 		for (i = 0; i < PNP_MAX_PORT; i++) {
 			if(pnp_check_port(dev,i))
@@ -606,27 +396,64 @@
 				goto fail;
 		}
 	}
-	dev->config_mode = PNP_CONFIG_MANUAL;
-	spin_unlock(&pnp_lock);
+	up(&pnp_res_mutex);
 
-	pnp_resolve_conflicts(dev);
+	pnp_auto_config_dev(dev);
 	kfree(bak);
 	return 0;
 
 fail:
 	dev->res = *bak;
-	spin_unlock(&pnp_lock);
+	up(&pnp_res_mutex);
 	kfree(bak);
 	return -EINVAL;
 }
 
 /**
- * pnp_activate_dev - activates a PnP device for use
+ * pnp_auto_config_dev - automatically assigns resources to a device
  * @dev: pointer to the desired device
  *
- * finds the best resource configuration and then informs the correct pnp protocol
  */
+int pnp_auto_config_dev(struct pnp_dev *dev)
+{
+	struct pnp_option *dep;
+	int i = 1;
+
+	if(!dev)
+		return -EINVAL;
+
+	if(!pnp_can_configure(dev)) {
+		pnp_info("Device %s does not support resource configuration.", dev->dev.bus_id);
+		return -ENODEV;
+	}
+
+	if (!dev->dependent) {
+		if (pnp_assign_resources(dev, 0))
+			return 1;
+		else
+			return 0;
+	}
+
+	dep = dev->dependent;
+	do {
+		if (pnp_assign_resources(dev, i))
+			return 1;
 
+		/* if this dependent resource failed, try the next one */
+		dep = dep->next;
+		i++;
+	} while (dep);
+
+	pnp_err("Unable to assign resources to device %s.", dev->dev.bus_id);
+	return 0;
+}
+
+/**
+ * pnp_activate_dev - activates a PnP device for use
+ * @dev: pointer to the desired device
+ *
+ * does not validate or set resources so be careful.
+ */
 int pnp_activate_dev(struct pnp_dev *dev)
 {
 	if (!dev)
@@ -634,55 +461,25 @@
 	if (dev->active) {
 		return 0; /* the device is already active */
 	}
-	/* If this condition is true, advanced configuration failed, we need to get this device up and running
-	 * so we use the simple config engine which ignores cold conflicts, this of course may lead to new failures */
-	if (!pnp_is_active(dev)) {
-		if (!pnp_simple_config(dev)) {
-			pnp_err("res: Unable to resolve resource conflicts for the device '%s'.", dev->dev.bus_id);
-			goto fail;
-		}
-	}
 
-	spin_lock(&pnp_lock);	/* we lock just in case the device is being configured during this call */
-	dev->active = 1;
-	spin_unlock(&pnp_lock); /* once the device is claimed active we know it won't be configured so we can unlock */
+	/* ensure resources are allocated */
+	if (!pnp_auto_config_dev(dev))
+		return -EBUSY;
 
-	if (dev->config_mode & PNP_CONFIG_INVALID) {
-		pnp_info("res: Unable to activate the PnP device '%s' because its resource configuration is invalid.", dev->dev.bus_id);
-		goto fail;
-	}
-	if (dev->status != PNP_READY && dev->status != PNP_ATTACHED){
-		pnp_err("res: Activation failed because the PnP device '%s' is busy.", dev->dev.bus_id);
-		goto fail;
-	}
 	if (!pnp_can_write(dev)) {
-		pnp_info("res: Unable to activate the PnP device '%s' because this feature is not supported.", dev->dev.bus_id);
-		goto fail;
+		pnp_info("Device %s does not supported activation.", dev->dev.bus_id);
+		return -EINVAL;
 	}
+
 	if (dev->protocol->set(dev, &dev->res)<0) {
-		pnp_err("res: The protocol '%s' reports that activating the PnP device '%s' has failed.", dev->protocol->name, dev->dev.bus_id);
-		goto fail;
-	}
-	if (pnp_can_read(dev)) {
-		struct pnp_resource_table * res = pnp_alloc(sizeof(struct pnp_resource_table));
-		if (!res)
-			goto fail;
-		dev->protocol->get(dev, res);
-		if (pnp_compare_resources(&dev->res, res)) /* if this happens we may be in big trouble but it's best just to continue */
-			pnp_err("res: The resources requested do not match those set for the PnP device '%s'.", dev->dev.bus_id);
-		kfree(res);
-	} else
-		dev->active = pnp_is_active(dev);
-	pnp_dbg("res: the device '%s' has been activated.", dev->dev.bus_id);
-	if (dev->rule) {
-		kfree(dev->rule);
-		dev->rule = NULL;
+		pnp_err("Failed to activate device %s.", dev->dev.bus_id);
+		return -EIO;
 	}
-	return 0;
 
-fail:
-	dev->active = 0; /* fixes incorrect active state */
-	return -EINVAL;
+	dev->active = 1;
+	pnp_info("Device %s activated.", dev->dev.bus_id);
+
+	return 1;
 }
 
 /**
@@ -691,7 +488,6 @@
  *
  * inform the correct pnp protocol so that resources can be used by other devices
  */
-
 int pnp_disable_dev(struct pnp_dev *dev)
 {
         if (!dev)
@@ -699,21 +495,25 @@
 	if (!dev->active) {
 		return 0; /* the device is already disabled */
 	}
-	if (dev->status != PNP_READY){
-		pnp_info("res: Disable failed becuase the PnP device '%s' is busy.", dev->dev.bus_id);
-		return -EINVAL;
-	}
+
 	if (!pnp_can_disable(dev)) {
-		pnp_info("res: Unable to disable the PnP device '%s' because this feature is not supported.", dev->dev.bus_id);
+		pnp_info("Device %s does not supported disabling.", dev->dev.bus_id);
 		return -EINVAL;
 	}
 	if (dev->protocol->disable(dev)<0) {
-		pnp_err("res: The protocol '%s' reports that disabling the PnP device '%s' has failed.", dev->protocol->name, dev->dev.bus_id);
-		return -1;
+		pnp_err("Failed to disable device %s.", dev->dev.bus_id);
+		return -EIO;
 	}
-	dev->active = 0; /* just in case the protocol doesn't do this */
-	pnp_dbg("res: the device '%s' has been disabled.", dev->dev.bus_id);
-	return 0;
+
+	dev->active = 0;
+	pnp_info("Device %s disabled.", dev->dev.bus_id);
+
+	/* release the resources so that other devices can use them */
+	down(&pnp_res_mutex);
+	pnp_clean_resources(&dev->res);
+	up(&pnp_res_mutex);
+
+	return 1;
 }
 
 /**
@@ -723,7 +523,6 @@
  * @size: size of region
  *
  */
-
 void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size)
 {
 	if (resource == NULL)
@@ -734,19 +533,10 @@
 }
 
 
-EXPORT_SYMBOL(pnp_auto_config_dev);
+EXPORT_SYMBOL(pnp_assign_resources);
 EXPORT_SYMBOL(pnp_manual_config_dev);
+EXPORT_SYMBOL(pnp_auto_config_dev);
 EXPORT_SYMBOL(pnp_activate_dev);
 EXPORT_SYMBOL(pnp_disable_dev);
 EXPORT_SYMBOL(pnp_resource_change);
-
-
-/* format is: pnp_max_moves=num */
-
-static int __init pnp_setup_max_moves(char *str)
-{
-	get_option(&str,&pnp_max_moves);
-	return 1;
-}
-
-__setup("pnp_max_moves=", pnp_setup_max_moves);
+EXPORT_SYMBOL(pnp_init_resources);
diff -Nru a/drivers/pnp/quirks.c b/drivers/pnp/quirks.c
--- a/drivers/pnp/quirks.c	Wed Jun 18 23:02:24 2003
+++ b/drivers/pnp/quirks.c	Wed Jun 18 23:02:24 2003
@@ -30,7 +30,7 @@
 static void quirk_awe32_resources(struct pnp_dev *dev)
 {
 	struct pnp_port *port, *port2, *port3;
-	struct pnp_resources *res = dev->possible->dep;
+	struct pnp_option *res = dev->dependent;
 
 	/*
 	 * Unfortunately the isapnp_add_port_resource is too tightly bound
@@ -38,7 +38,7 @@
 	 * two extra ports (at offset 0x400 and 0x800 from the one given) by
 	 * hand.
 	 */
-	for ( ; res ; res = res->dep ) {
+	for ( ; res ; res = res->next ) {
 		port2 = pnp_alloc(sizeof(struct pnp_port));
 		if (!port2)
 			return;
@@ -62,9 +62,9 @@
 
 static void quirk_cmi8330_resources(struct pnp_dev *dev)
 {
-	struct pnp_resources *res = dev->possible->dep;
+	struct pnp_option *res = dev->dependent;
 
-	for ( ; res ; res = res->dep ) {
+	for ( ; res ; res = res->next ) {
 
 		struct pnp_irq *irq;
 		struct pnp_dma *dma;
@@ -82,7 +82,7 @@
 static void quirk_sb16audio_resources(struct pnp_dev *dev)
 {
 	struct pnp_port *port;
-	struct pnp_resources *res = dev->possible->dep;
+	struct pnp_option *res = dev->dependent;
 	int    changed = 0;
 
 	/*
@@ -91,7 +91,7 @@
 	 * auto-configured.
 	 */
 
-	for( ; res ; res = res->dep ) {
+	for( ; res ; res = res->next ) {
 		port = res->port;
 		if(!port)
 			continue;
@@ -118,11 +118,11 @@
 	 * doesn't allow a DMA channel of 0, afflicted card is an
 	 * OPL3Sax where x=4.
 	 */
-	struct pnp_resources *res;
+	struct pnp_option *res;
 	int max;
-	res = dev->possible;
+	res = dev->dependent;
 	max = 0;
-	for (res = res->dep; res; res = res->dep) {
+	for (; res; res = res->next) {
 		if (res->dma->map > max)
 			max = res->dma->map;
 	}
diff -Nru a/drivers/pnp/resource.c b/drivers/pnp/resource.c
--- a/drivers/pnp/resource.c	Wed Jun 18 23:02:24 2003
+++ b/drivers/pnp/resource.c	Wed Jun 18 23:02:24 2003
@@ -10,18 +10,19 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
-#include <linux/pci.h>
 #include <linux/kernel.h>
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <asm/irq.h>
+#include <linux/pci.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
 
 #include <linux/pnp.h>
 #include "base.h"
 
-int pnp_allow_dma0 = -1;		        /* allow dma 0 during auto activation: -1=off (:default), 0=off (set by user), 1=on */
+int pnp_allow_dma0 = -1;		        /* allow dma 0 during auto activation:
+						 * -1=off (:default), 0=off (set by user), 1=on */
 int pnp_skip_pci_scan;				/* skip PCI resource scanning */
 int pnp_reserve_irq[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some IRQ */
 int pnp_reserve_dma[8] = { [0 ... 7] = -1 };	/* reserve (don't use) some DMA */
@@ -30,88 +31,75 @@
 
 
 /*
- * possible resource registration
+ * option registration
  */
 
-struct pnp_resources * pnp_build_resource(struct pnp_dev *dev, int dependent)
+static struct pnp_option * pnp_build_option(int priority)
 {
-	struct pnp_resources *res, *ptr, *ptra;
+	struct pnp_option *option = pnp_alloc(sizeof(struct pnp_option));
 
-	res = pnp_alloc(sizeof(struct pnp_resources));
-	if (!res)
+	/* check if pnp_alloc ran out of memory */
+	if (!option)
 		return NULL;
-	ptr = dev->possible;
-	if (ptr) { /* add to another list */
-		ptra = ptr->dep;
-		while (ptra && ptra->dep)
-			ptra = ptra->dep;
-		if (!ptra)
-			ptr->dep = res;
-		else
-			ptra->dep = res;
-	} else
-		dev->possible = res;
-	if (dependent) {
-		res->priority = dependent & 0xff;
-		if (res->priority > PNP_RES_PRIORITY_FUNCTIONAL)
-			res->priority = PNP_RES_PRIORITY_INVALID;
-	} else
-		res->priority = PNP_RES_PRIORITY_PREFERRED;
-	return res;
+
+	option->priority = priority & 0xff;
+	/* make sure the priority is valid */
+	if (option->priority > PNP_RES_PRIORITY_FUNCTIONAL)
+		option->priority = PNP_RES_PRIORITY_INVALID;
+
+	return option;
 }
 
-struct pnp_resources * pnp_find_resources(struct pnp_dev *dev, int depnum)
+struct pnp_option * pnp_register_independent_option(struct pnp_dev *dev)
 {
-	int i;
-	struct pnp_resources *res;
+	struct pnp_option *option;
 	if (!dev)
 		return NULL;
-	res = dev->possible;
-	if (!res)
-		return NULL;
-	for (i = 0; i < depnum; i++)
-	{
-		if (res->dep)
-			res = res->dep;
-		else
-			return NULL;
-	}
-	return res;
+
+	option = pnp_build_option(PNP_RES_PRIORITY_PREFERRED);
+
+	/* this should never happen but if it does we'll try to continue */
+	if (dev->independent)
+		pnp_err("independent resource already registered");
+	dev->independent = option;
+	return option;
 }
 
-int pnp_get_max_depnum(struct pnp_dev *dev)
+struct pnp_option * pnp_register_dependent_option(struct pnp_dev *dev, int priority)
 {
-	int num = 0;
-	struct pnp_resources *res;
+	struct pnp_option *option;
 	if (!dev)
-		return -EINVAL;
-	res = dev->possible;
-	if (!res)
-		return -EINVAL;
-	while (res->dep){
-		res = res->dep;
-		num++;
-	}
-	return num;
+		return NULL;
+
+	option = pnp_build_option(priority);
+
+	if (dev->dependent) {
+		struct pnp_option *parent = dev->dependent;
+		while (parent->next)
+			parent = parent->next;
+		parent->next = option;
+	} else
+		dev->dependent = option;
+	return option;
 }
 
-int pnp_add_irq_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data)
+int pnp_register_irq_resource(struct pnp_option *option, struct pnp_irq *data)
 {
 	int i;
-	struct pnp_resources *res;
 	struct pnp_irq *ptr;
-	res = pnp_find_resources(dev,depnum);
-	if (!res)
+	if (!option)
 		return -EINVAL;
 	if (!data)
 		return -EINVAL;
-	ptr = res->irq;
+
+	ptr = option->irq;
 	while (ptr && ptr->next)
 		ptr = ptr->next;
 	if (ptr)
 		ptr->next = data;
 	else
-		res->irq = data;
+		option->irq = data;
+
 #ifdef CONFIG_PCI
 	for (i=0; i<16; i++)
 		if (data->map & (1<<i))
@@ -120,60 +108,59 @@
 	return 0;
 }
 
-int pnp_add_dma_resource(struct pnp_dev *dev, int depnum, struct pnp_dma *data)
+int pnp_register_dma_resource(struct pnp_option *option, struct pnp_dma *data)
 {
-	struct pnp_resources *res;
 	struct pnp_dma *ptr;
-	res = pnp_find_resources(dev,depnum);
-	if (!res)
+	if (!option)
 		return -EINVAL;
 	if (!data)
 		return -EINVAL;
-	ptr = res->dma;
+
+	ptr = option->dma;
 	while (ptr && ptr->next)
 		ptr = ptr->next;
 	if (ptr)
 		ptr->next = data;
 	else
-		res->dma = data;
+		option->dma = data;
+
 	return 0;
 }
 
-int pnp_add_port_resource(struct pnp_dev *dev, int depnum, struct pnp_port *data)
+int pnp_register_port_resource(struct pnp_option *option, struct pnp_port *data)
 {
-	struct pnp_resources *res;
 	struct pnp_port *ptr;
-	res = pnp_find_resources(dev,depnum);
-	if (!res)
+	if (!option)
 		return -EINVAL;
 	if (!data)
 		return -EINVAL;
-	ptr = res->port;
+
+	ptr = option->port;
 	while (ptr && ptr->next)
 		ptr = ptr->next;
 	if (ptr)
 		ptr->next = data;
 	else
-		res->port = data;
+		option->port = data;
+
 	return 0;
 }
 
-int pnp_add_mem_resource(struct pnp_dev *dev, int depnum, struct pnp_mem *data)
+int pnp_register_mem_resource(struct pnp_option *option, struct pnp_mem *data)
 {
-	struct pnp_resources *res;
 	struct pnp_mem *ptr;
-	res = pnp_find_resources(dev,depnum);
-	if (!res)
+	if (!option)
 		return -EINVAL;
 	if (!data)
 		return -EINVAL;
-	ptr = res->mem;
+
+	ptr = option->mem;
 	while (ptr && ptr->next)
 		ptr = ptr->next;
 	if (ptr)
 		ptr->next = data;
 	else
-		res->mem = data;
+		option->mem = data;
 	return 0;
 }
 
@@ -221,18 +208,18 @@
 	}
 }
 
-void pnp_free_resources(struct pnp_resources *resources)
+void pnp_free_option(struct pnp_option *option)
 {
-	struct pnp_resources *next;
+	struct pnp_option *next;
 
-	while (resources) {
-		next = resources->dep;
-		pnp_free_port(resources->port);
-		pnp_free_irq(resources->irq);
-		pnp_free_dma(resources->dma);
-		pnp_free_mem(resources->mem);
-		kfree(resources);
-		resources = next;
+	while (option) {
+		next = option->next;
+		pnp_free_port(option->port);
+		pnp_free_irq(option->irq);
+		pnp_free_dma(option->dma);
+		pnp_free_mem(option->mem);
+		kfree(option);
+		option = next;
 	}
 }
 
@@ -253,50 +240,23 @@
  (*(enda) >= *(startb) && *(enda) <= *(endb)) || \
  (*(starta) < *(startb) && *(enda) > *(endb)))
 
-struct pnp_dev * pnp_check_port_conflicts(struct pnp_dev * dev, int idx, int mode)
-{
-	int tmp;
-	unsigned long *port, *end, *tport, *tend;
-	struct pnp_dev *tdev;
-	port = &dev->res.port_resource[idx].start;
-	end = &dev->res.port_resource[idx].end;
-
-	/* if the resource doesn't exist, don't complain about it */
-	if (dev->res.port_resource[idx].start == 0)
-		return NULL;
-
-	/* check for cold conflicts */
-	pnp_for_each_dev(tdev) {
-		/* Is the device configurable? */
-		if (tdev == dev || (mode ? !tdev->active : tdev->active))
-			continue;
-		for (tmp = 0; tmp < PNP_MAX_PORT; tmp++) {
-			if (tdev->res.port_resource[tmp].flags & IORESOURCE_IO) {
-				tport = &tdev->res.port_resource[tmp].start;
-				tend = &tdev->res.port_resource[tmp].end;
-				if (ranged_conflict(port,end,tport,tend))
-					return tdev;
-			}
-		}
-	}
-	return NULL;
-}
-
 int pnp_check_port(struct pnp_dev * dev, int idx)
 {
 	int tmp;
+	struct pnp_dev *tdev;
 	unsigned long *port, *end, *tport, *tend;
 	port = &dev->res.port_resource[idx].start;
 	end = &dev->res.port_resource[idx].end;
 
 	/* if the resource doesn't exist, don't complain about it */
 	if (dev->res.port_resource[idx].start == 0)
-		return 0;
+		return 1;
 
-	/* check if the resource is already in use, skip if the device is active because it itself may be in use */
+	/* check if the resource is already in use, skip if the
+	 * device is active because it itself may be in use */
 	if(!dev->active) {
 		if (check_region(*port, length(port,end)))
-			return CONFLICT_TYPE_IN_USE;
+			return 0;
 	}
 
 	/* check if the resource is reserved */
@@ -304,7 +264,7 @@
 		int rport = pnp_reserve_io[tmp << 1];
 		int rend = pnp_reserve_io[(tmp << 1) + 1] + rport - 1;
 		if (ranged_conflict(port,end,&rport,&rend))
-			return CONFLICT_TYPE_RESERVED;
+			return 0;
 	}
 
 	/* check for internal conflicts */
@@ -313,61 +273,44 @@
 			tport = &dev->res.port_resource[tmp].start;
 			tend = &dev->res.port_resource[tmp].end;
 			if (ranged_conflict(port,end,tport,tend))
-				return CONFLICT_TYPE_INTERNAL;
+				return 0;
 		}
 	}
 
-	/* check for warm conflicts */
-	if (pnp_check_port_conflicts(dev, idx, SEARCH_WARM))
-		return CONFLICT_TYPE_PNP_WARM;
-
-	return 0;
-}
-
-struct pnp_dev * pnp_check_mem_conflicts(struct pnp_dev * dev, int idx, int mode)
-{
-	int tmp;
-	unsigned long *addr, *end, *taddr, *tend;
-	struct pnp_dev *tdev;
-	addr = &dev->res.mem_resource[idx].start;
-	end = &dev->res.mem_resource[idx].end;
-
-	/* if the resource doesn't exist, don't complain about it */
-	if (dev->res.mem_resource[idx].start == 0)
-		return NULL;
-
-	/* check for cold conflicts */
+	/* check for conflicts with other pnp devices */
 	pnp_for_each_dev(tdev) {
-		/* Is the device configurable? */
-		if (tdev == dev || (mode ? !tdev->active : tdev->active))
+		if (tdev == dev)
 			continue;
-		for (tmp = 0; tmp < PNP_MAX_MEM; tmp++) {
-			if (tdev->res.mem_resource[tmp].flags & IORESOURCE_MEM) {
-				taddr = &tdev->res.mem_resource[tmp].start;
-				tend = &tdev->res.mem_resource[tmp].end;
-				if (ranged_conflict(addr,end,taddr,tend))
-					return tdev;
+		for (tmp = 0; tmp < PNP_MAX_PORT; tmp++) {
+			if (tdev->res.port_resource[tmp].flags & IORESOURCE_IO) {
+				tport = &tdev->res.port_resource[tmp].start;
+				tend = &tdev->res.port_resource[tmp].end;
+				if (ranged_conflict(port,end,tport,tend))
+					return 0;
 			}
 		}
 	}
-	return NULL;
+
+	return 1;
 }
 
 int pnp_check_mem(struct pnp_dev * dev, int idx)
 {
 	int tmp;
+	struct pnp_dev *tdev;
 	unsigned long *addr, *end, *taddr, *tend;
 	addr = &dev->res.mem_resource[idx].start;
 	end = &dev->res.mem_resource[idx].end;
 
 	/* if the resource doesn't exist, don't complain about it */
 	if (dev->res.mem_resource[idx].start == 0)
-		return 0;
+		return 1;
 
-	/* check if the resource is already in use, skip if the device is active because it itself may be in use */
+	/* check if the resource is already in use, skip if the
+	 * device is active because it itself may be in use */
 	if(!dev->active) {
 		if (__check_region(&iomem_resource, *addr, length(addr,end)))
-			return CONFLICT_TYPE_IN_USE;
+			return 0;
 	}
 
 	/* check if the resource is reserved */
@@ -375,7 +318,7 @@
 		int raddr = pnp_reserve_mem[tmp << 1];
 		int rend = pnp_reserve_mem[(tmp << 1) + 1] + raddr - 1;
 		if (ranged_conflict(addr,end,&raddr,&rend))
-			return CONFLICT_TYPE_RESERVED;
+			return 0;
 	}
 
 	/* check for internal conflicts */
@@ -384,40 +327,25 @@
 			taddr = &dev->res.mem_resource[tmp].start;
 			tend = &dev->res.mem_resource[tmp].end;
 			if (ranged_conflict(addr,end,taddr,tend))
-				return CONFLICT_TYPE_INTERNAL;
+				return 0;
 		}
 	}
 
-	/* check for warm conflicts */
-	if (pnp_check_mem_conflicts(dev, idx, SEARCH_WARM))
-		return CONFLICT_TYPE_PNP_WARM;
-
-	return 0;
-}
-
-struct pnp_dev * pnp_check_irq_conflicts(struct pnp_dev * dev, int idx, int mode)
-{
-	int tmp;
-	struct pnp_dev * tdev;
-	unsigned long * irq = &dev->res.irq_resource[idx].start;
-
-	/* if the resource doesn't exist, don't complain about it */
-	if (dev->res.irq_resource[idx].start == -1)
-		return NULL;
-
-	/* check for cold conflicts */
+	/* check for conflicts with other pnp devices */
 	pnp_for_each_dev(tdev) {
-		/* Is the device configurable? */
-		if (tdev == dev || (mode ? !tdev->active : tdev->active))
+		if (tdev == dev)
 			continue;
-		for (tmp = 0; tmp < PNP_MAX_IRQ; tmp++) {
-			if (tdev->res.irq_resource[tmp].flags & IORESOURCE_IRQ) {
-				if ((tdev->res.irq_resource[tmp].start == *irq))
-					return tdev;
+		for (tmp = 0; tmp < PNP_MAX_MEM; tmp++) {
+			if (tdev->res.mem_resource[tmp].flags & IORESOURCE_MEM) {
+				taddr = &tdev->res.mem_resource[tmp].start;
+				tend = &tdev->res.mem_resource[tmp].end;
+				if (ranged_conflict(addr,end,taddr,tend))
+					return 0;
 			}
 		}
 	}
-	return NULL;
+
+	return 1;
 }
 
 static irqreturn_t pnp_test_handler(int irq, void *dev_id, struct pt_regs *regs)
@@ -428,27 +356,28 @@
 int pnp_check_irq(struct pnp_dev * dev, int idx)
 {
 	int tmp;
+	struct pnp_dev *tdev;
 	unsigned long * irq = &dev->res.irq_resource[idx].start;
 
 	/* if the resource doesn't exist, don't complain about it */
 	if (dev->res.irq_resource[idx].start == -1)
-		return 0;
+		return 1;
 
 	/* check if the resource is valid */
 	if (*irq < 0 || *irq > 15)
-		return CONFLICT_TYPE_INVALID;
+		return 0;
 
 	/* check if the resource is reserved */
 	for (tmp = 0; tmp < 16; tmp++) {
 		if (pnp_reserve_irq[tmp] == *irq)
-			return CONFLICT_TYPE_RESERVED;
+			return 0;
 	}
 
 	/* check for internal conflicts */
 	for (tmp = 0; tmp < PNP_MAX_IRQ && tmp != idx; tmp++) {
 		if (dev->res.irq_resource[tmp].flags & IORESOURCE_IRQ) {
 			if (dev->res.irq_resource[tmp].start == *irq)
-				return CONFLICT_TYPE_INTERNAL;
+				return 0;
 		}
 	}
 
@@ -458,233 +387,94 @@
 		struct pci_dev * pci = NULL;
 		while ((pci = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pci)) != NULL) {
 			if (pci->irq == *irq)
-				return CONFLICT_TYPE_PCI;
+				return 0;
 		}
 	}
 #endif
 
-	/* check if the resource is already in use, skip if the device is active because it itself may be in use */
+	/* check if the resource is already in use, skip if the
+	 * device is active because it itself may be in use */
 	if(!dev->active) {
 		if (request_irq(*irq, pnp_test_handler, SA_INTERRUPT, "pnp", NULL))
-			return CONFLICT_TYPE_IN_USE;
+			return 0;
 		free_irq(*irq, NULL);
 	}
 
-	/* check for warm conflicts */
-	if (pnp_check_irq_conflicts(dev, idx, SEARCH_WARM))
-		return CONFLICT_TYPE_PNP_WARM;
-
-	return 0;
-}
-
-
-struct pnp_dev * pnp_check_dma_conflicts(struct pnp_dev * dev, int idx, int mode)
-{
-	int tmp;
-	struct pnp_dev * tdev;
-	unsigned long * dma = &dev->res.dma_resource[idx].start;
-
-	/* if the resource doesn't exist, don't complain about it */
-	if (dev->res.dma_resource[idx].start == -1)
-		return NULL;
-
-	/* check for cold conflicts */
+	/* check for conflicts with other pnp devices */
 	pnp_for_each_dev(tdev) {
-		/* Is the device configurable? */
-		if (tdev == dev || (mode ? !tdev->active : tdev->active))
+		if (tdev == dev)
 			continue;
-		for (tmp = 0; tmp < PNP_MAX_DMA; tmp++) {
-			if (tdev->res.dma_resource[tmp].flags & IORESOURCE_DMA) {
-				if ((tdev->res.dma_resource[tmp].start == *dma))
-					return tdev;
+		for (tmp = 0; tmp < PNP_MAX_IRQ; tmp++) {
+			if (tdev->res.irq_resource[tmp].flags & IORESOURCE_IRQ) {
+				if ((tdev->res.irq_resource[tmp].start == *irq))
+					return 0;
 			}
 		}
 	}
-	return NULL;
+
+	return 1;
 }
 
 int pnp_check_dma(struct pnp_dev * dev, int idx)
 {
 	int tmp, mindma = 1;
+	struct pnp_dev *tdev;
 	unsigned long * dma = &dev->res.dma_resource[idx].start;
 
 	/* if the resource doesn't exist, don't complain about it */
 	if (dev->res.dma_resource[idx].start == -1)
-		return 0;
+		return 1;
 
 	/* check if the resource is valid */
 	if (pnp_allow_dma0 == 1)
 		mindma = 0;
 	if (*dma < mindma || *dma == 4 || *dma > 7)
-		return CONFLICT_TYPE_INVALID;
+		return 0;
 
 	/* check if the resource is reserved */
 	for (tmp = 0; tmp < 8; tmp++) {
 		if (pnp_reserve_dma[tmp] == *dma)
-			return CONFLICT_TYPE_RESERVED;
+			return 0;
 	}
 
 	/* check for internal conflicts */
 	for (tmp = 0; tmp < PNP_MAX_DMA && tmp != idx; tmp++) {
 		if (dev->res.dma_resource[tmp].flags & IORESOURCE_DMA) {
 			if (dev->res.dma_resource[tmp].start == *dma)
-				return CONFLICT_TYPE_INTERNAL;
+				return 0;
 		}
 	}
 
-	/* check if the resource is already in use, skip if the device is active because it itself may be in use */
+	/* check if the resource is already in use, skip if the
+	 * device is active because it itself may be in use */
 	if(!dev->active) {
 		if (request_dma(*dma, "pnp"))
-			return CONFLICT_TYPE_IN_USE;
+			return 0;
 		free_dma(*dma);
 	}
 
-	/* check for warm conflicts */
-	if (pnp_check_dma_conflicts(dev, idx, SEARCH_WARM))
-		return CONFLICT_TYPE_PNP_WARM;
-	return 0;
-}
-
-
-/**
- * pnp_init_resource_table - Resets a resource table to default values.
- * @table: pointer to the desired resource table
- *
- */
-
-void pnp_init_resource_table(struct pnp_resource_table *table)
-{
-	int idx;
-	for (idx = 0; idx < PNP_MAX_IRQ; idx++) {
-		table->irq_resource[idx].name = NULL;
-		table->irq_resource[idx].start = -1;
-		table->irq_resource[idx].end = -1;
-		table->irq_resource[idx].flags = IORESOURCE_AUTO;
-	}
-	for (idx = 0; idx < PNP_MAX_DMA; idx++) {
-		table->dma_resource[idx].name = NULL;
-		table->dma_resource[idx].start = -1;
-		table->dma_resource[idx].end = -1;
-		table->dma_resource[idx].flags = IORESOURCE_AUTO;
-	}
-	for (idx = 0; idx < PNP_MAX_PORT; idx++) {
-		table->port_resource[idx].name = NULL;
-		table->port_resource[idx].start = 0;
-		table->port_resource[idx].end = 0;
-		table->port_resource[idx].flags = IORESOURCE_AUTO;
-	}
-	for (idx = 0; idx < PNP_MAX_MEM; idx++) {
-		table->mem_resource[idx].name = NULL;
-		table->mem_resource[idx].start = 0;
-		table->mem_resource[idx].end = 0;
-		table->mem_resource[idx].flags = IORESOURCE_AUTO;
-	}
-}
-
-
-/**
- * pnp_generate_rule - Creates a rule table structure based on depnum and device.
- * @dev: pointer to the desired device
- * @depnum: dependent function, if not valid will return an error
- * @rule: pointer to a rule structure to record data to
- *
- */
-
-int pnp_generate_rule(struct pnp_dev * dev, int depnum, struct pnp_rule_table * rule)
-{
-	int nport = 0, nirq = 0, ndma = 0, nmem = 0;
-	struct pnp_resources * res;
-	struct pnp_port * port;
-	struct pnp_mem * mem;
-	struct pnp_irq * irq;
-	struct pnp_dma * dma;
-
-	if (depnum < 0 || !rule)
-		return -EINVAL;
-
-	/* independent */
-	res = pnp_find_resources(dev, 0);
-	if (!res)
-		return -ENODEV;
-	port = res->port;
-	mem = res->mem;
-	irq = res->irq;
-	dma = res->dma;
-	while (port){
-		rule->port[nport] = port;
-		nport++;
-		port = port->next;
-	}
-	while (mem){
-		rule->mem[nmem] = mem;
-		nmem++;
-		mem = mem->next;
-	}
-	while (irq){
-		rule->irq[nirq] = irq;
-		nirq++;
-		irq = irq->next;
-	}
-	while (dma){
-		rule->dma[ndma] = dma;
-		ndma++;
-		dma = dma->next;
+	/* check for conflicts with other pnp devices */
+	pnp_for_each_dev(tdev) {
+		if (tdev == dev)
+			continue;
+		for (tmp = 0; tmp < PNP_MAX_DMA; tmp++) {
+			if (tdev->res.dma_resource[tmp].flags & IORESOURCE_DMA) {
+				if ((tdev->res.dma_resource[tmp].start == *dma))
+					return 0;
+			}
+		}
 	}
 
-	/* dependent */
-	if (depnum == 0)
-		return 1;
-	res = pnp_find_resources(dev, depnum);
-	if (!res)
-		return -ENODEV;
-	port = res->port;
-	mem = res->mem;
-	irq = res->irq;
-	dma = res->dma;
-	while (port){
-		rule->port[nport] = port;
-		nport++;
-		port = port->next;
-	}
-	while (mem){
-		rule->mem[nmem] = mem;
-		nmem++;
-		mem = mem->next;
-	}
-
-	while (irq){
-		rule->irq[nirq] = irq;
-		nirq++;
-		irq = irq->next;
-	}
-	while (dma){
-		rule->dma[ndma] = dma;
-		ndma++;
-		dma = dma->next;
-	}
-
-	/* clear the remaining values */
-	for (; nport < PNP_MAX_PORT; nport++)
-		rule->port[nport] = NULL;
-	for (; nmem < PNP_MAX_MEM; nmem++)
-		rule->mem[nmem] = NULL;
-	for (; nirq < PNP_MAX_IRQ; nirq++)
-		rule->irq[nirq] = NULL;
-	for (; ndma < PNP_MAX_DMA; ndma++)
-		rule->dma[ndma] = NULL;
 	return 1;
 }
 
 
-EXPORT_SYMBOL(pnp_build_resource);
-EXPORT_SYMBOL(pnp_find_resources);
-EXPORT_SYMBOL(pnp_get_max_depnum);
-EXPORT_SYMBOL(pnp_add_irq_resource);
-EXPORT_SYMBOL(pnp_add_dma_resource);
-EXPORT_SYMBOL(pnp_add_port_resource);
-EXPORT_SYMBOL(pnp_add_mem_resource);
-EXPORT_SYMBOL(pnp_init_resource_table);
-EXPORT_SYMBOL(pnp_generate_rule);
+EXPORT_SYMBOL(pnp_register_dependent_resource);
+EXPORT_SYMBOL(pnp_register_independent_resource);
+EXPORT_SYMBOL(pnp_register_irq_resource);
+EXPORT_SYMBOL(pnp_register_dma_resource);
+EXPORT_SYMBOL(pnp_register_port_resource);
+EXPORT_SYMBOL(pnp_register_mem_resource);
 
 
 /* format is: allowdma0 */
diff -Nru a/drivers/pnp/support.c b/drivers/pnp/support.c
--- a/drivers/pnp/support.c	Wed Jun 18 23:02:24 2003
+++ b/drivers/pnp/support.c	Wed Jun 18 23:02:24 2003
@@ -1,7 +1,7 @@
 /*
  * support.c - provides standard pnp functions for the use of pnp protocol drivers,
  *
- * Copyright 2002 Adam Belay <ambx1@neo.rr.com>
+ * Copyright 2003 Adam Belay <ambx1@neo.rr.com>
  *
  * Resource parsing functions are based on those in the linux pnpbios driver.
  * Copyright Christian Schmidt, Tom Lees, David Hinds, Alan Cox, Thomas Hood,
@@ -10,6 +10,7 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/ctype.h>
 
 #ifdef CONFIG_PNP_DEBUG
 	#define DEBUG
@@ -122,7 +123,7 @@
 		return NULL;
 
 	/* Blank the resource table values */
-	pnp_init_resource_table(res);
+	pnp_init_resources(res);
 
 	while ((char *)p < (char *)end) {
 
@@ -250,7 +251,7 @@
  * Possible resource reading functions *
  */
 
-static void possible_mem(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
+static void possible_mem(unsigned char *p, int size, struct pnp_option *option)
 {
 	struct pnp_mem * mem;
 	mem = pnp_alloc(sizeof(struct pnp_mem));
@@ -261,11 +262,11 @@
 	mem->align = (p[7] << 8) | p[6];
 	mem->size = ((p[9] << 8) | p[8]) << 8;
 	mem->flags = p[1];
-	pnp_add_mem_resource(dev,depnum,mem);
+	pnp_register_mem_resource(option,mem);
 	return;
 }
 
-static void possible_mem32(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
+static void possible_mem32(unsigned char *p, int size, struct pnp_option *option)
 {
 	struct pnp_mem * mem;
 	mem = pnp_alloc(sizeof(struct pnp_mem));
@@ -276,11 +277,11 @@
 	mem->align = (p[13] << 24) | (p[12] << 16) | (p[11] << 8) | p[10];
 	mem->size = (p[17] << 24) | (p[16] << 16) | (p[15] << 8) | p[14];
 	mem->flags = p[1];
-	pnp_add_mem_resource(dev,depnum,mem);
+	pnp_register_mem_resource(option,mem);
 	return;
 }
 
-static void possible_fixed_mem32(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
+static void possible_fixed_mem32(unsigned char *p, int size, struct pnp_option *option)
 {
 	struct pnp_mem * mem;
 	mem = pnp_alloc(sizeof(struct pnp_mem));
@@ -290,11 +291,11 @@
 	mem->size = (p[9] << 24) | (p[8] << 16) | (p[7] << 8) | p[6];
 	mem->align = 0;
 	mem->flags = p[1];
-	pnp_add_mem_resource(dev,depnum,mem);
+	pnp_register_mem_resource(option,mem);
 	return;
 }
 
-static void possible_irq(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
+static void possible_irq(unsigned char *p, int size, struct pnp_option *option)
 {
 	struct pnp_irq * irq;
 	irq = pnp_alloc(sizeof(struct pnp_irq));
@@ -303,11 +304,13 @@
 	irq->map = (p[2] << 8) | p[1];
 	if (size > 2)
 		irq->flags = p[3];
-	pnp_add_irq_resource(dev,depnum,irq);
+	else
+		irq->flags = IORESOURCE_IRQ_HIGHEDGE;
+	pnp_register_irq_resource(option,irq);
 	return;
 }
 
-static void possible_dma(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
+static void possible_dma(unsigned char *p, int size, struct pnp_option *option)
 {
 	struct pnp_dma * dma;
 	dma = pnp_alloc(sizeof(struct pnp_dma));
@@ -315,11 +318,11 @@
 		return;
 	dma->map = p[1];
 	dma->flags = p[2];
-	pnp_add_dma_resource(dev,depnum,dma);
+	pnp_register_dma_resource(option,dma);
 	return;
 }
 
-static void possible_port(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
+static void possible_port(unsigned char *p, int size, struct pnp_option *option)
 {
 	struct pnp_port * port;
 	port = pnp_alloc(sizeof(struct pnp_port));
@@ -330,11 +333,11 @@
 	port->align = p[6];
 	port->size = p[7];
 	port->flags = p[1] ? PNP_PORT_FLAG_16BITADDR : 0;
-	pnp_add_port_resource(dev,depnum,port);
+	pnp_register_port_resource(option,port);
 	return;
 }
 
-static void possible_fixed_port(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
+static void possible_fixed_port(unsigned char *p, int size, struct pnp_option *option)
 {
 	struct pnp_port * port;
 	port = pnp_alloc(sizeof(struct pnp_port));
@@ -344,7 +347,7 @@
 	port->size = p[3];
 	port->align = 0;
 	port->flags = PNP_PORT_FLAG_FIXED;
-	pnp_add_port_resource(dev,depnum,port);
+	pnp_register_port_resource(option,port);
 	return;
 }
 
@@ -358,12 +361,14 @@
 
 unsigned char * pnp_parse_possible_resources(unsigned char * p, unsigned char * end, struct pnp_dev *dev)
 {
-	int len, depnum = 0, dependent = 0;
+	int len, priority = 0;
+	struct pnp_option *option;
 
 	if (!p)
 		return NULL;
 
-	if (pnp_build_resource(dev, 0) == NULL)
+	option = pnp_register_independent_option(dev);
+	if (!option)
 		return NULL;
 
 	while ((char *)p < (char *)end) {
@@ -375,21 +380,21 @@
 			{
 				if (len != 9)
 					goto lrg_err;
-				possible_mem(p,len,depnum,dev);
+				possible_mem(p,len,option);
 				break;
 			}
 			case LARGE_TAG_MEM32:
 			{
 				if (len != 17)
 					goto lrg_err;
-				possible_mem32(p,len,depnum,dev);
+				possible_mem32(p,len,option);
 				break;
 			}
 			case LARGE_TAG_FIXEDMEM32:
 			{
 				if (len != 9)
 					goto lrg_err;
-				possible_fixed_mem32(p,len,depnum,dev);
+				possible_fixed_mem32(p,len,option);
 				break;
 			}
 			default: /* an unkown tag */
@@ -410,46 +415,46 @@
 		{
 			if (len < 2 || len > 3)
 				goto sm_err;
-			possible_irq(p,len,depnum,dev);
+			possible_irq(p,len,option);
 			break;
 		}
 		case SMALL_TAG_DMA:
 		{
 			if (len != 2)
 				goto sm_err;
-			possible_dma(p,len,depnum,dev);
+			possible_dma(p,len,option);
 			break;
 		}
 		case SMALL_TAG_STARTDEP:
 		{
 			if (len > 1)
 				goto sm_err;
-			dependent = 0x100 | PNP_RES_PRIORITY_ACCEPTABLE;
+			priority = 0x100 | PNP_RES_PRIORITY_ACCEPTABLE;
 			if (len > 0)
-				dependent = 0x100 | p[1];
-			pnp_build_resource(dev,dependent);
-			depnum = pnp_get_max_depnum(dev);
+				priority = 0x100 | p[1];
+			option = pnp_register_dependent_option(dev, priority);
+			if (!option)
+				return NULL;
 			break;
 		}
 		case SMALL_TAG_ENDDEP:
 		{
 			if (len != 0)
 				goto sm_err;
-			depnum = 0;
 			break;
 		}
 		case SMALL_TAG_PORT:
 		{
 			if (len != 7)
 				goto sm_err;
-			possible_port(p,len,depnum,dev);
+			possible_port(p,len,option);
 			break;
 		}
 		case SMALL_TAG_FIXEDPORT:
 		{
 			if (len != 3)
 				goto sm_err;
-			possible_fixed_port(p,len,depnum,dev);
+			possible_fixed_port(p,len,option);
 			break;
 		}
 		case SMALL_TAG_END:
diff -Nru a/drivers/serial/8250_pnp.c b/drivers/serial/8250_pnp.c
--- a/drivers/serial/8250_pnp.c	Wed Jun 18 23:02:24 2003
+++ b/drivers/serial/8250_pnp.c	Wed Jun 18 23:02:24 2003
@@ -315,19 +315,6 @@
 
 MODULE_DEVICE_TABLE(pnp, pnp_dev_table);
 
-static inline void avoid_irq_share(struct pnp_dev *dev)
-{
-	unsigned int map = 0x1FF8;
-	struct pnp_irq *irq;
-	struct pnp_resources *res = dev->possible;
-
-	serial8250_get_irq_map(&map);
-
-	for ( ; res; res = res->dep)
-		for (irq = res->irq; irq; irq = irq->next)
-			irq->map = map;
-}
-
 static char *modem_names[] __devinitdata = {
 	"MODEM", "Modem", "modem", "FAX", "Fax", "fax",
 	"56K", "56k", "K56", "33.6", "28.8", "14.4",
@@ -346,6 +333,29 @@
 	return 0;
 }
 
+static int __devinit check_resources(struct pnp_option *option)
+{
+	struct pnp_option *tmp;
+	if (!option)
+		return 0;
+
+	for (tmp = option; tmp; tmp = tmp->next) {
+		struct pnp_port *port;
+		for (port = tmp->port; port; port = port->next)
+			if ((port->size == 8) &&
+			    ((port->min == 0x2f8) ||
+			     (port->min == 0x3f8) ||
+			     (port->min == 0x2e8) ||
+#ifdef CONFIG_X86_PC9800
+			     (port->min == 0x8b0) ||
+#endif
+			     (port->min == 0x3e8)))
+				return 1;
+	}
+
+	return 0;
+}
+
 /*
  * Given a complete unknown PnP device, try to use some heuristics to
  * detect modems. Currently use such heuristic set:
@@ -357,30 +367,16 @@
  * PnP modems, alternatively we must hardcode all modems in pnp_devices[]
  * table.
  */
-static int serial_pnp_guess_board(struct pnp_dev *dev, int *flags)
+static int __devinit serial_pnp_guess_board(struct pnp_dev *dev, int *flags)
 {
-	struct pnp_resources *res = dev->possible;
-	struct pnp_resources *resa;
-
 	if (!(check_name(dev->dev.name) || (dev->card && check_name(dev->card->dev.name))))
 		return -ENODEV;
 
-	if (!res)
-		return -ENODEV;
+	if (check_resources(dev->independent))
+		return 0;
 
-	for (resa = res->dep; resa; resa = resa->dep) {
-		struct pnp_port *port;
-		for (port = res->port; port; port = port->next)
-			if ((port->size == 8) &&
-			    ((port->min == 0x2f8) ||
-			     (port->min == 0x3f8) ||
-			     (port->min == 0x2e8) ||
-#ifdef CONFIG_X86_PC9800
-			     (port->min == 0x8b0) ||
-#endif
-			     (port->min == 0x3e8)))
-				return 0;
-	}
+	if (check_resources(dev->dependent))
+		return 0;
 
 	return -ENODEV;
 }
@@ -395,8 +391,6 @@
 		if (ret < 0)
 			return ret;
 	}
-	if (flags & SPCI_FL_NO_SHIRQ)
-		avoid_irq_share(dev);
 	memset(&serial_req, 0, sizeof(serial_req));
 	serial_req.irq = pnp_irq(dev,0);
 	serial_req.port = pnp_port_start(dev, 0);
diff -Nru a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Wed Jun 18 23:02:24 2003
+++ b/include/linux/pnp.h	Wed Jun 18 23:02:24 2003
@@ -102,22 +102,13 @@
 #define PNP_RES_PRIORITY_FUNCTIONAL	2
 #define PNP_RES_PRIORITY_INVALID	65535
 
-struct pnp_resources {
+struct pnp_option {
 	unsigned short priority;	/* priority */
 	struct pnp_port *port;		/* first port */
 	struct pnp_irq *irq;		/* first IRQ */
 	struct pnp_dma *dma;		/* first DMA */
 	struct pnp_mem *mem;		/* first memory resource */
-	struct pnp_dev *dev;		/* parent */
-	struct pnp_resources *dep;	/* dependent resources */
-};
-
-struct pnp_rule_table {
-	int depnum;
-	struct pnp_port *port[PNP_MAX_PORT];
-	struct pnp_irq *irq[PNP_MAX_IRQ];
-	struct pnp_dma *dma[PNP_MAX_DMA];
-	struct pnp_mem *mem[PNP_MAX_MEM];
+	struct pnp_option *next;	/* used to chain dependent resources */
 };
 
 struct pnp_resource_table {
@@ -187,8 +178,6 @@
 struct pnp_dev {
 	struct device dev;		/* Driver Model device interface */
 	unsigned char number;		/* used as an index, must be unique */
-	int active;
-	int capabilities;
 	int status;
 
 	struct list_head global_list;	/* node in global list of devices */
@@ -201,11 +190,13 @@
 	struct pnp_driver * driver;
 	struct pnp_card_link * card_link;
 
-	struct pnp_id		      * id;		/* supported EISA IDs*/
-	struct pnp_resource_table	res;		/* contains the currently chosen resources */
-	struct pnp_resources	      * possible;	/* a list of possible resources */
-	struct pnp_rule_table	      * rule;		/* the current possible resource set */
-	int 				config_mode;	/* flags that determine how the device's resources should be configured */
+	struct pnp_id	* id;	/* supported EISA IDs*/
+
+	int active;
+	int capabilities;
+	struct pnp_option * independent;
+	struct pnp_option * dependent;
+	struct pnp_resource_table res;
 
 	void * protocol_data;		/* Used to store protocol specific data */
 	unsigned short	regs;		/* ISAPnP: supported registers */
@@ -252,11 +243,9 @@
 	void (*quirk_function)(struct pnp_dev *dev);	/* fixup function */
 };
 
-/* config modes */
-#define PNP_CONFIG_AUTO		0x0001	/* Use the Resource Configuration Engine to determine resource settings */
-#define PNP_CONFIG_MANUAL	0x0002	/* the config has been manually specified */
-#define PNP_CONFIG_FORCE	0x0004	/* disables validity checking */
-#define PNP_CONFIG_INVALID	0x0008	/* If this flag is set, the pnp layer will refuse to activate the device */
+/* config parameters */
+#define PNP_CONFIG_NORMAL	0x0001
+#define PNP_CONFIG_FORCE	0x0002	/* disables validity checking */
 
 /* capabilities */
 #define PNP_READ		0x0001
@@ -271,7 +260,7 @@
 				 ((dev)->capabilities & PNP_WRITE))
 #define pnp_can_disable(dev)	(((dev)->protocol) && ((dev)->protocol->disable) && \
 				 ((dev)->capabilities & PNP_DISABLE))
-#define pnp_can_configure(dev)	((!(dev)->active) && ((dev)->config_mode & PNP_CONFIG_AUTO) && \
+#define pnp_can_configure(dev)	((!(dev)->active) && \
 				 ((dev)->capabilities & PNP_CONFIGURABLE))
 
 #ifdef CONFIG_ISAPNP
@@ -383,7 +372,7 @@
 
 #if defined(CONFIG_PNP)
 
-/* core */
+/* device management */
 int pnp_register_protocol(struct pnp_protocol *protocol);
 void pnp_unregister_protocol(struct pnp_protocol *protocol);
 int pnp_add_device(struct pnp_dev *dev);
@@ -392,7 +381,7 @@
 void pnp_device_detach(struct pnp_dev *pnp_dev);
 extern struct list_head pnp_global;
 
-/* card */
+/* multidevice card support */
 int pnp_add_card(struct pnp_card *card);
 void pnp_remove_card(struct pnp_card *card);
 int pnp_add_card_device(struct pnp_card *card, struct pnp_dev *dev);
@@ -404,41 +393,35 @@
 void pnp_unregister_card_driver(struct pnp_card_driver * drv);
 extern struct list_head pnp_cards;
 
-/* resource */
-struct pnp_resources * pnp_build_resource(struct pnp_dev *dev, int dependent);
-struct pnp_resources * pnp_find_resources(struct pnp_dev *dev, int depnum);
-int pnp_get_max_depnum(struct pnp_dev *dev);
-int pnp_add_irq_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data);
-int pnp_add_dma_resource(struct pnp_dev *dev, int depnum, struct pnp_dma *data);
-int pnp_add_port_resource(struct pnp_dev *dev, int depnum, struct pnp_port *data);
-int pnp_add_mem_resource(struct pnp_dev *dev, int depnum, struct pnp_mem *data);
-void pnp_init_resource_table(struct pnp_resource_table *table);
-int pnp_generate_rule(struct pnp_dev * dev, int depnum, struct pnp_rule_table * rule);
-
-/* manager */
+/* resource management */
+struct pnp_option * pnp_register_independent_option(struct pnp_dev *dev);
+struct pnp_option * pnp_register_dependent_option(struct pnp_dev *dev, int priority);
+int pnp_register_irq_resource(struct pnp_option *option, struct pnp_irq *data);
+int pnp_register_dma_resource(struct pnp_option *option, struct pnp_dma *data);
+int pnp_register_port_resource(struct pnp_option *option, struct pnp_port *data);
+int pnp_register_mem_resource(struct pnp_option *option, struct pnp_mem *data);
+void pnp_init_resources(struct pnp_resource_table *table);
+int pnp_assign_resources(struct pnp_dev *dev, int depnum);
+int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res, int mode);
+int pnp_auto_config_dev(struct pnp_dev *dev);
+int pnp_validate_config(struct pnp_dev *dev);
 int pnp_activate_dev(struct pnp_dev *dev);
 int pnp_disable_dev(struct pnp_dev *dev);
 void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size);
-int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res, int mode);
-int pnp_auto_config_dev(struct pnp_dev *dev);
-
-/* driver */
-int compare_pnp_id(struct pnp_id * pos, const char * id);
-int pnp_add_id(struct pnp_id *id, struct pnp_dev *dev);
-int pnp_register_driver(struct pnp_driver *drv);
-void pnp_unregister_driver(struct pnp_driver *drv);
 
-/* support */
+/* protocol helpers */
 int pnp_is_active(struct pnp_dev * dev);
 unsigned char * pnp_parse_current_resources(unsigned char * p, unsigned char * end, struct pnp_resource_table * res);
 unsigned char * pnp_parse_possible_resources(unsigned char * p, unsigned char * end, struct pnp_dev * dev);
 unsigned char * pnp_write_resources(unsigned char * p, unsigned char * end, struct pnp_resource_table * res);
+int compare_pnp_id(struct pnp_id * pos, const char * id);
+int pnp_add_id(struct pnp_id *id, struct pnp_dev *dev);
+int pnp_register_driver(struct pnp_driver *drv);
+void pnp_unregister_driver(struct pnp_driver *drv);
 
 #else
 
-/* just in case anyone decides to call these without PnP Support Enabled */
-
-/* core */
+/* device management */
 static inline int pnp_register_protocol(struct pnp_protocol *protocol) { return -ENODEV; }
 static inline void pnp_unregister_protocol(struct pnp_protocol *protocol) { }
 static inline int pnp_init_device(struct pnp_dev *dev) { return -ENODEV; }
@@ -447,7 +430,7 @@
 static inline int pnp_device_attach(struct pnp_dev *pnp_dev) { return -ENODEV; }
 static inline void pnp_device_detach(struct pnp_dev *pnp_dev) { ; }
 
-/* card */
+/* multidevice card support */
 static inline int pnp_add_card(struct pnp_card *card) { return -ENODEV; }
 static inline void pnp_remove_card(struct pnp_card *card) { ; }
 static inline int pnp_add_card_device(struct pnp_card *card, struct pnp_dev *dev) { return -ENODEV; }
@@ -458,35 +441,31 @@
 static inline int pnp_register_card_driver(struct pnp_card_driver * drv) { return -ENODEV; }
 static inline void pnp_unregister_card_driver(struct pnp_card_driver * drv) { ; }
 
-/* resource */
-static inline struct pnp_resources * pnp_build_resource(struct pnp_dev *dev, int dependent) { return NULL; }
-static inline struct pnp_resources * pnp_find_resources(struct pnp_dev *dev, int depnum) { return NULL; }
-static inline int pnp_get_max_depnum(struct pnp_dev *dev) { return -ENODEV; }
-static inline int pnp_add_irq_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data) { return -ENODEV; }
-static inline int pnp_add_dma_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data) { return -ENODEV; }
-static inline int pnp_add_port_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data) { return -ENODEV; }
-static inline int pnp_add_mem_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data) { return -ENODEV; }
-static inline void pnp_init_resource_table(struct pnp_resource_table *table) { ; }
-static inline int pnp_generate_rule(struct pnp_dev * dev, int depnum, struct pnp_rule_table * rule) { return -ENODEV; }
-
-/* manager */
-static inline int pnp_activate_dev(struct pnp_dev *dev) { return -ENODEV; }
-static inline int pnp_disable_dev(struct pnp_dev *dev) { return -ENODEV; }
-static inline void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size) { ; }
+/* resource management */
+static inline struct pnp_option * pnp_register_independent_option(struct pnp_dev *dev) { return NULL; }
+static inline struct pnp_option * pnp_register_dependent_option(struct pnp_dev *dev, int priority) { return NULL; }
+static inline int pnp_register_irq_resource(struct pnp_option *option, struct pnp_irq *data) { return -ENODEV; }
+static inline int pnp_register_dma_resource(struct pnp_option *option, struct pnp_dma *data) { return -ENODEV; }
+static inline int pnp_register_port_resource(struct pnp_option *option, struct pnp_port *data) { return -ENODEV; }
+static inline int pnp_register_mem_resource(struct pnp_option *option, struct pnp_mem *data) { return -ENODEV; }
+static inline void pnp_init_resources(struct pnp_resource_table *table) { }
+static inline int pnp_assign_resources(struct pnp_dev *dev, int depnum) { return -ENODEV; }
 static inline int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res, int mode) { return -ENODEV; }
 static inline int pnp_auto_config_dev(struct pnp_dev *dev) { return -ENODEV; }
+static inline int pnp_validate_config(struct pnp_dev *dev) { return -ENODEV; }
+static inline int pnp_activate_dev(struct pnp_dev *dev) { return -ENODEV; }
+static inline int pnp_disable_dev(struct pnp_dev *dev) { return -ENODEV; }
+static inline void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size) { }
 
-/* driver */
-static inline int compare_pnp_id(struct list_head * id_list, const char * id) { return -ENODEV; }
-static inline int pnp_add_id(struct pnp_id *id, struct pnp_dev *dev) { return -ENODEV; }
-static inline int pnp_register_driver(struct pnp_driver *drv) { return -ENODEV; }
-static inline void pnp_unregister_driver(struct pnp_driver *drv) { ; }
-
-/* support */
-static inline int pnp_is_active(struct pnp_dev * dev) { return -ENODEV; }
+/* protocol helpers */
+static inline int pnp_is_active(struct pnp_dev * dev) { return 0; }
 static inline unsigned char * pnp_parse_current_resources(unsigned char * p, unsigned char * end, struct pnp_resource_table * res) { return NULL; }
 static inline unsigned char * pnp_parse_possible_resources(unsigned char * p, unsigned char * end, struct pnp_dev * dev) { return NULL; }
 static inline unsigned char * pnp_write_resources(unsigned char * p, unsigned char * end, struct pnp_resource_table * res) { return NULL; }
+static inline int compare_pnp_id(struct pnp_id * pos, const char * id) { return -ENODEV; }
+static inline int pnp_add_id(struct pnp_id *id, struct pnp_dev *dev) { return -ENODEV; }
+static inline int pnp_register_driver(struct pnp_driver *drv) { return -ENODEV; }
+static inline void pnp_unregister_driver(struct pnp_driver *drv) { ; }
 
 #endif /* CONFIG_PNP */
 
