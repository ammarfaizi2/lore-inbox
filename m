Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268014AbTBWDAr>; Sat, 22 Feb 2003 22:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268015AbTBWDAr>; Sat, 22 Feb 2003 22:00:47 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:43179 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S268014AbTBWDAo>;
	Sat, 22 Feb 2003 22:00:44 -0500
Date: Sat, 22 Feb 2003 22:10:04 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Aditional PnP Changes for 2.5.62
Message-ID: <20030222221004.GC1212@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1023  -> 1.1024 
#	drivers/pnp/interface.c	1.11    -> 1.12   
#	drivers/pnp/manager.c	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/22	ambx1@neo.rr.com	1.1024
# Large Stack Usage Fix
# 
# Reduces the stack memory usage in the following PnP Functions:
# pnp_printf
# pnp_set_current_resources
# pnp_manual_config_dev
# pnp_activate_dev
# --------------------------------------------
#
diff -Nru a/drivers/pnp/interface.c b/drivers/pnp/interface.c
--- a/drivers/pnp/interface.c	Sat Feb 22 22:04:59 2003
+++ b/drivers/pnp/interface.c	Sat Feb 22 22:04:59 2003
@@ -32,18 +32,16 @@
 {
 	va_list args;
 	int res;
-	char sbuffer[512];
 
 	if (buffer->stop || buffer->error)
 		return 0;
 	va_start(args, fmt);
-	res = vsprintf(sbuffer, fmt, args);
+	res = vsnprintf(buffer->curr, buffer->len - buffer->size, fmt, args);
 	va_end(args);
 	if (buffer->size + res >= buffer->len) {
 		buffer->stop = 1;
 		return 0;
 	}
-	strcpy(buffer->curr, sbuffer);
 	buffer->curr += res;
 	buffer->size += res;
 	return res;
@@ -432,13 +430,13 @@
 		goto done;
 	}
 	if (!strnicmp(buf,"set",3)) {
-		struct pnp_resource_table res;
 		int nport = 0, nmem = 0, nirq = 0, ndma = 0;
-
 		if (dev->active)
 			goto done;
 		buf += 3;
-		pnp_init_resource_table(&res);
+		spin_lock(&pnp_lock);
+		dev->config_mode = PNP_CONFIG_MANUAL;
+		pnp_init_resource_table(&dev->res);
 		while (1) {
 			while (isspace(*buf))
 				++buf;
@@ -446,17 +444,17 @@
 				buf += 2;
 				while (isspace(*buf))
 					++buf;
-				res.port_resource[nport].start = simple_strtoul(buf,&buf,0);
+				dev->res.port_resource[nport].start = simple_strtoul(buf,&buf,0);
 				while (isspace(*buf))
 					++buf;
 				if(*buf == '-') {
 					buf += 1;
 					while (isspace(*buf))
 						++buf;
-					res.port_resource[nport].end = simple_strtoul(buf,&buf,0);
+					dev->res.port_resource[nport].end = simple_strtoul(buf,&buf,0);
 				} else
-					res.port_resource[nport].end = res.port_resource[nport].start;
-				res.port_resource[nport].flags = IORESOURCE_IO;
+					dev->res.port_resource[nport].end = dev->res.port_resource[nport].start;
+				dev->res.port_resource[nport].flags = IORESOURCE_IO;
 				nport++;
 				if (nport >= PNP_MAX_PORT)
 					break;
@@ -466,17 +464,17 @@
 				buf += 3;
 				while (isspace(*buf))
 					++buf;
-				res.mem_resource[nmem].start = simple_strtoul(buf,&buf,0);
+				dev->res.mem_resource[nmem].start = simple_strtoul(buf,&buf,0);
 				while (isspace(*buf))
 					++buf;
 				if(*buf == '-') {
 					buf += 1;
 					while (isspace(*buf))
 						++buf;
-					res.mem_resource[nmem].end = simple_strtoul(buf,&buf,0);
+					dev->res.mem_resource[nmem].end = simple_strtoul(buf,&buf,0);
 				} else
-					res.mem_resource[nmem].end = res.mem_resource[nmem].start;
-				res.mem_resource[nmem].flags = IORESOURCE_MEM;
+					dev->res.mem_resource[nmem].end = dev->res.mem_resource[nmem].start;
+				dev->res.mem_resource[nmem].flags = IORESOURCE_MEM;
 				nmem++;
 				if (nmem >= PNP_MAX_MEM)
 					break;
@@ -486,9 +484,9 @@
 				buf += 3;
 				while (isspace(*buf))
 					++buf;
-				res.irq_resource[nirq].start =
-				res.irq_resource[nirq].end = simple_strtoul(buf,&buf,0);
-				res.irq_resource[nirq].flags = IORESOURCE_IRQ;
+				dev->res.irq_resource[nirq].start =
+				dev->res.irq_resource[nirq].end = simple_strtoul(buf,&buf,0);
+				dev->res.irq_resource[nirq].flags = IORESOURCE_IRQ;
 				nirq++;
 				if (nirq >= PNP_MAX_IRQ)
 					break;
@@ -498,9 +496,9 @@
 				buf += 3;
 				while (isspace(*buf))
 					++buf;
-				res.dma_resource[ndma].start =
-				res.dma_resource[ndma].end = simple_strtoul(buf,&buf,0);
-				res.dma_resource[ndma].flags = IORESOURCE_DMA;
+				dev->res.dma_resource[ndma].start =
+				dev->res.dma_resource[ndma].end = simple_strtoul(buf,&buf,0);
+				dev->res.dma_resource[ndma].flags = IORESOURCE_DMA;
 				ndma++;
 				if (ndma >= PNP_MAX_DMA)
 					break;
@@ -508,9 +506,6 @@
 			}
 			break;
 		}
-		spin_lock(&pnp_lock);
-		dev->config_mode = PNP_CONFIG_MANUAL;
-		dev->res = res;
 		spin_unlock(&pnp_lock);
 		goto done;
 	}
diff -Nru a/drivers/pnp/manager.c b/drivers/pnp/manager.c
--- a/drivers/pnp/manager.c	Sat Feb 22 22:04:59 2003
+++ b/drivers/pnp/manager.c	Sat Feb 22 22:04:59 2003
@@ -543,14 +543,18 @@
 int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table * res, int mode)
 {
 	int i;
-	struct pnp_resource_table bak = dev->res;
+	struct pnp_resource_table * bak;
 	if (!dev || !res)
 		return -EINVAL;
 	if (dev->active)
 		return -EBUSY;
+	bak = pnp_alloc(sizeof(struct pnp_resource_table));
+	if (!bak)
+		return -ENOMEM;
+	*bak = dev->res;
+
 	spin_lock(&pnp_lock);
 	dev->res = *res;
-
 	if (!(mode & PNP_CONFIG_FORCE)) {
 		for (i = 0; i < PNP_MAX_PORT; i++) {
 			if(pnp_check_port(dev,i))
@@ -569,15 +573,17 @@
 				goto fail;
 		}
 	}
+	dev->config_mode = PNP_CONFIG_MANUAL;
 	spin_unlock(&pnp_lock);
 
 	pnp_resolve_conflicts(dev);
-	dev->config_mode = PNP_CONFIG_MANUAL;
+	kfree(bak);
 	return 0;
 
 fail:
-	dev->res = bak;
+	dev->res = *bak;
 	spin_unlock(&pnp_lock);
+	kfree(bak);
 	return -EINVAL;
 }
 
@@ -625,10 +631,13 @@
 		goto fail;
 	}
 	if (pnp_can_read(dev)) {
-		struct pnp_resource_table res;
-		dev->protocol->get(dev, &res);
-		if (pnp_compare_resources(&dev->res, &res)) /* if this happens we may be in big trouble but it's best just to continue */
+		struct pnp_resource_table * res = pnp_alloc(sizeof(struct pnp_resource_table));
+		if (!res)
+			goto fail;
+		dev->protocol->get(dev, res);
+		if (pnp_compare_resources(&dev->res, res)) /* if this happens we may be in big trouble but it's best just to continue */
 			pnp_err("res: The resources requested do not match those set for the PnP device '%s'.", dev->dev.bus_id);
+		kfree(res);
 	} else
 		dev->active = pnp_is_active(dev);
 	pnp_dbg("res: the device '%s' has been activated.", dev->dev.bus_id);
