Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267367AbTBIQzG>; Sun, 9 Feb 2003 11:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267371AbTBIQzG>; Sun, 9 Feb 2003 11:55:06 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:38284 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267342AbTBIQxR>;
	Sun, 9 Feb 2003 11:53:17 -0500
Date: Sun, 9 Feb 2003 12:03:48 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] pnp - Interface Improvements (4/12) 2.5.59-bk3
Message-ID: <20030209120347.GA20005@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will allow the user to see exactly where a resource conflict is
occuring.  It also adds a manual set resource capability but I recommend only
advanced users use it at this point.  These interface changes will be documented
in pnp.txt soon.

Please apply,
Adam


diff -urN a/drivers/pnp/interface.c b/drivers/pnp/interface.c
--- a/drivers/pnp/interface.c	Tue Jan 14 05:58:11 2003
+++ b/drivers/pnp/interface.c	Sun Feb  9 09:21:36 2003
@@ -1,7 +1,7 @@
 /*
  * interface.c - contains everything related to the user interface
  *
- * Some code is based on isapnp_proc.c (c) Jaroslav Kysela <perex@suse.cz>
+ * Some code, especially possible resource dumping is based on isapnp_proc.c (c) Jaroslav Kysela <perex@suse.cz>
  * Copyright 2002 Adam Belay <ambx1@neo.rr.com>
  *
  */
@@ -12,6 +12,8 @@
 #include <linux/list.h>
 #include <linux/types.h>
 #include <linux/stat.h>
+#include <linux/ctype.h>
+#include <asm/uaccess.h>
 
 #include "base.h"
 
@@ -158,27 +160,15 @@
 	case IORESOURCE_MEM_8AND16BIT:
 		s = "8-bit&16-bit";
 		break;
+	case IORESOURCE_MEM_32BIT:
+		s = "32-bit";
+		break;
 	default:
 		s = "16-bit";
 	}
 	pnp_printf(buffer, ", %s\n", s);
 }
 
-static void pnp_print_mem32(pnp_info_buffer_t *buffer, char *space, struct pnp_mem32 *mem32)
-{
-	int first = 1, i;
-
-	pnp_printf(buffer, "%s32-bit memory ", space);
-	for (i = 0; i < 17; i++) {
-		if (first) {
-			first = 0;
-		} else {
-			pnp_printf(buffer, ":");
-		}
-		pnp_printf(buffer, "%02x", mem32->data[i]);
-	}
-}
-
 static void pnp_print_resources(pnp_info_buffer_t *buffer, char *space, struct pnp_resources *res, int dep)
 {
 	char *s;
@@ -186,7 +176,6 @@
 	struct pnp_irq *irq;
 	struct pnp_dma *dma;
 	struct pnp_mem *mem;
-	struct pnp_mem32 *mem32;
 
 	switch (res->priority) {
 	case PNP_RES_PRIORITY_PREFERRED:
@@ -211,18 +200,15 @@
 		pnp_print_dma(buffer, space, dma);
 	for (mem = res->mem; mem; mem = mem->next)
 		pnp_print_mem(buffer, space, mem);
-	for (mem32 = res->mem32; mem32; mem32 = mem32->next)
-		pnp_print_mem32(buffer, space, mem32);
 }
 
 static ssize_t pnp_show_possible_resources(struct device *dmdev, char *buf)
 {
 	struct pnp_dev *dev = to_pnp_dev(dmdev);
-	struct pnp_resources * res = dev->res;
-	int dep = 0;
-	pnp_info_buffer_t *buffer;
-
-	buffer = (pnp_info_buffer_t *) pnp_alloc(sizeof(pnp_info_buffer_t));
+	struct pnp_resources * res = dev->possible;
+	int ret, dep = 0;
+	pnp_info_buffer_t *buffer = (pnp_info_buffer_t *)
+				 pnp_alloc(sizeof(pnp_info_buffer_t));
 	if (!buffer)
 		return -ENOMEM;
 	buffer->len = PAGE_SIZE;
@@ -236,97 +222,272 @@
 		res = res->dep;
 		dep++;
 	}
-	return (buffer->curr - buf);
+	ret = (buffer->curr - buf);
+	kfree(buffer);
+	return ret;
 }
 
 static DEVICE_ATTR(possible,S_IRUGO,pnp_show_possible_resources,NULL);
 
+static void pnp_print_conflict_desc(pnp_info_buffer_t *buffer, int conflict)
+{
+	if (!conflict)
+		return;
+	pnp_printf(buffer, "  Conflict Detected: %2x - ", conflict);
+	switch (conflict) {
+	case CONFLICT_TYPE_RESERVED:
+		pnp_printf(buffer, "This resource was manually reserved.\n");
+		break;
+
+	case CONFLICT_TYPE_IN_USE:
+		pnp_printf(buffer, "This resource resource is currently in use.\n");
+		break;
+
+	case CONFLICT_TYPE_PCI:
+		pnp_printf(buffer, "This resource conflicts with a PCI device.\n");
+		break;
+
+	case CONFLICT_TYPE_INVALID:
+		pnp_printf(buffer, "This resource is invalid.\n");
+		break;
+
+	case CONFLICT_TYPE_INTERNAL:
+		pnp_printf(buffer, "This resource conflicts with another resource on this device.\n");
+		break;
+
+	case CONFLICT_TYPE_PNP_WARM:
+		pnp_printf(buffer, "This resource conflicts with the active PnP device ");
+		break;
+
+	case CONFLICT_TYPE_PNP_COLD:
+		pnp_printf(buffer, "This resource conflicts with the resources that PnP plans to assign to the device ");
+		break;
+	default:
+		pnp_printf(buffer, "Unknown conflict.\n");
+		break;
+	}
+}
+
+static void pnp_print_conflict_node(pnp_info_buffer_t *buffer, struct pnp_dev * dev)
+{
+	if (!dev)
+		return;
+	pnp_printf(buffer, "%s.\n", dev->dev.bus_id);
+}
+
+static void pnp_print_conflict(pnp_info_buffer_t *buffer, struct pnp_dev * dev, int idx, int type)
+{
+	struct pnp_dev * cdev, * wdev;
+	int conflict;
+	switch (type) {
+	case IORESOURCE_IO:
+		conflict = pnp_check_port(dev, idx);
+		if (conflict == CONFLICT_TYPE_PNP_WARM)
+			wdev = pnp_check_port_conflicts(dev, idx, SEARCH_WARM);
+		cdev = pnp_check_port_conflicts(dev, idx, SEARCH_COLD);
+		break;
+	case IORESOURCE_MEM:
+		conflict = pnp_check_mem(dev, idx);
+		if (conflict == CONFLICT_TYPE_PNP_WARM)
+			wdev = pnp_check_mem_conflicts(dev, idx, SEARCH_WARM);
+		cdev = pnp_check_mem_conflicts(dev, idx, SEARCH_COLD);
+		break;
+	case IORESOURCE_IRQ:
+		conflict = pnp_check_irq(dev, idx);
+		if (conflict == CONFLICT_TYPE_PNP_WARM)
+			wdev = pnp_check_irq_conflicts(dev, idx, SEARCH_WARM);
+		cdev = pnp_check_irq_conflicts(dev, idx, SEARCH_COLD);
+		break;
+	case IORESOURCE_DMA:
+		conflict = pnp_check_dma(dev, idx);
+		if (conflict == CONFLICT_TYPE_PNP_WARM)
+			wdev = pnp_check_dma_conflicts(dev, idx, SEARCH_WARM);
+		cdev = pnp_check_dma_conflicts(dev, idx, SEARCH_COLD);
+		break;
+	default:
+		return;
+	}
+
+	pnp_print_conflict_desc(buffer, conflict);
+
+
+	if (cdev) {
+		pnp_print_conflict_desc(buffer, CONFLICT_TYPE_PNP_COLD);
+		pnp_print_conflict_node(buffer, cdev);
+	}
+}
+
 static ssize_t pnp_show_current_resources(struct device *dmdev, char *buf)
 {
 	struct pnp_dev *dev = to_pnp_dev(dmdev);
-	char *str = buf;
-	int i;
+	int i, ret;
+	pnp_info_buffer_t *buffer = (pnp_info_buffer_t *)
+				pnp_alloc(sizeof(pnp_info_buffer_t));
+	if (!buffer)
+		return -ENOMEM;
+	if (!dev)
+		return -EINVAL;
+	buffer->len = PAGE_SIZE;
+	buffer->buffer = buf;
+	buffer->curr = buffer->buffer;
 
-	if (!dev->active){
-		str += sprintf(str,"DISABLED\n");
-		goto done;
-	}
-	for (i = 0; i < DEVICE_COUNT_IO; i++) {
+	pnp_printf(buffer,"state = ");
+	if (dev->active)
+		pnp_printf(buffer,"active\n");
+	else
+		pnp_printf(buffer,"disabled\n");
+	for (i = 0; i < PNP_MAX_PORT; i++) {
 		if (pnp_port_valid(dev, i)) {
-			str += sprintf(str,"io");
-			str += sprintf(str," 0x%lx-0x%lx \n",
+			pnp_printf(buffer,"io");
+			pnp_printf(buffer," 0x%lx-0x%lx \n",
 						pnp_port_start(dev, i),
 						pnp_port_end(dev, i));
+			pnp_print_conflict(buffer, dev, i, IORESOURCE_IO);
 		}
 	}
-	for (i = 0; i < DEVICE_COUNT_MEM; i++) {
+	for (i = 0; i < PNP_MAX_MEM; i++) {
 		if (pnp_mem_valid(dev, i)) {
-			str += sprintf(str,"mem");
-			str += sprintf(str," 0x%lx-0x%lx \n",
+			pnp_printf(buffer,"mem");
+			pnp_printf(buffer," 0x%lx-0x%lx \n",
 						pnp_mem_start(dev, i),
 						pnp_mem_end(dev, i));
+			pnp_print_conflict(buffer, dev, i, IORESOURCE_MEM);
 		}
 	}
-	for (i = 0; i < DEVICE_COUNT_IRQ; i++) {
+	for (i = 0; i < PNP_MAX_IRQ; i++) {
 		if (pnp_irq_valid(dev, i)) {
-			str += sprintf(str,"irq");
-			str += sprintf(str," %ld \n", pnp_irq(dev, i));
+			pnp_printf(buffer,"irq");
+			pnp_printf(buffer," %ld \n", pnp_irq(dev, i));
+			pnp_print_conflict(buffer, dev, i, IORESOURCE_IRQ);
 		}
 	}
-	for (i = 0; i < DEVICE_COUNT_DMA; i++) {
+	for (i = 0; i < PNP_MAX_DMA; i++) {
 		if (pnp_dma_valid(dev, i)) {
-			str += sprintf(str,"dma");
-			str += sprintf(str," %ld \n", pnp_dma(dev, i));
+			pnp_printf(buffer,"dma");
+			pnp_printf(buffer," %ld \n", pnp_dma(dev, i));
+			pnp_print_conflict(buffer, dev, i, IORESOURCE_DMA);
 		}
 	}
-	done:
-	return (str - buf);
+	ret = (buffer->curr - buf);
+	kfree(buffer);
+	return ret;
 }
 
+extern int pnp_resolve_conflicts(struct pnp_dev *dev);
+
 static ssize_t
-pnp_set_current_resources(struct device * dmdev, const char * buf, size_t count)
+pnp_set_current_resources(struct device * dmdev, const char * ubuf, size_t count)
 {
 	struct pnp_dev *dev = to_pnp_dev(dmdev);
-	char	command[20];
-	int	num_args;
-	int	error = 0;
-	int	depnum;
+	char	*buf = (void *)ubuf;
+	int	retval = 0;
 
-	num_args = sscanf(buf,"%10s %i",command,&depnum);
-	if (!num_args)
-		goto done;
-	if (!strnicmp(command,"lock",4)) {
-		if (dev->active) {
-			dev->lock_resources = 1;
-		} else {
-			error = -EINVAL;
-		}
+	while (isspace(*buf))
+		++buf;
+	if (!strnicmp(buf,"disable",7)) {
+		retval = pnp_disable_dev(dev);
 		goto done;
 	}
-	if (!strnicmp(command,"unlock",6)) {
-		if (dev->lock_resources) {
-			dev->lock_resources = 0;
-		} else {
-			error = -EINVAL;
-		}
+	if (!strnicmp(buf,"activate",8)) {
+		retval = pnp_activate_dev(dev);
 		goto done;
 	}
-	if (!strnicmp(command,"disable",7)) {
-		error = pnp_disable_dev(dev);
+	if (!strnicmp(buf,"auto-config",11)) {
+		if (dev->active)
+			goto done;
+		retval = pnp_auto_config_dev(dev);
 		goto done;
 	}
-	if (!strnicmp(command,"auto",4)) {
-		error = pnp_activate_dev(dev,NULL);
+	if (!strnicmp(buf,"resolve",7)) {
+		retval = pnp_resolve_conflicts(dev);
 		goto done;
 	}
-	if (!strnicmp(command,"manual",6)) {
-		if (num_args != 2)
+	if (!strnicmp(buf,"set",3)) {
+		if (dev->active)
 			goto done;
-		error = pnp_raw_set_dev(dev,depnum,NULL);
+		buf += 3;
+		struct pnp_resource_table res;
+		int nport = 0, nmem = 0, nirq = 0, ndma = 0;
+		pnp_init_resource_table(&res);
+		while (1) {
+			while (isspace(*buf))
+				++buf;
+			if (!strnicmp(buf,"io",2)) {
+				buf += 2;
+				while (isspace(*buf))
+					++buf;
+				res.port_resource[nport].start = simple_strtoul(buf,&buf,0);
+				while (isspace(*buf))
+					++buf;
+				if(*buf == '-') {
+					buf += 1;
+					while (isspace(*buf))
+						++buf;
+					res.port_resource[nport].end = simple_strtoul(buf,&buf,0);
+				} else
+					res.port_resource[nport].end = res.port_resource[nport].start;
+				res.port_resource[nport].flags = IORESOURCE_IO;
+				nport++;
+				if (nport >= PNP_MAX_PORT)
+					break;
+				continue;
+			}
+			if (!strnicmp(buf,"mem",3)) {
+				buf += 3;
+				while (isspace(*buf))
+					++buf;
+				res.mem_resource[nmem].start = simple_strtoul(buf,&buf,0);
+				while (isspace(*buf))
+					++buf;
+				if(*buf == '-') {
+					buf += 1;
+					while (isspace(*buf))
+						++buf;
+					res.mem_resource[nmem].end = simple_strtoul(buf,&buf,0);
+				} else
+					res.mem_resource[nmem].end = res.mem_resource[nmem].start;
+				res.mem_resource[nmem].flags = IORESOURCE_MEM;
+				nmem++;
+				if (nmem >= PNP_MAX_MEM)
+					break;
+				continue;
+			}
+			if (!strnicmp(buf,"irq",3)) {
+				buf += 3;
+				while (isspace(*buf))
+					++buf;
+				res.irq_resource[nirq].start =
+				res.irq_resource[nirq].end = simple_strtoul(buf,&buf,0);
+				res.irq_resource[nirq].flags = IORESOURCE_IRQ;
+				nirq++;
+				if (nirq >= PNP_MAX_IRQ)
+					break;
+				continue;
+			}
+			if (!strnicmp(buf,"dma",3)) {
+				buf += 3;
+				while (isspace(*buf))
+					++buf;
+				res.dma_resource[ndma].start =
+				res.dma_resource[ndma].end = simple_strtoul(buf,&buf,0);
+				res.dma_resource[ndma].flags = IORESOURCE_DMA;
+				ndma++;
+				if (ndma >= PNP_MAX_DMA)
+					break;
+				continue;
+			}
+			break;
+		}
+		spin_lock(&pnp_lock);
+		dev->config_mode = PNP_CONFIG_MANUAL;
+		dev->res = res;
+		spin_unlock(&pnp_lock);
 		goto done;
 	}
  done:
-	return error < 0 ? error : count;
+	if (retval)
+		return retval;
+	return count;
 }

 static DEVICE_ATTR(resources,S_IRUGO | S_IWUSR,
