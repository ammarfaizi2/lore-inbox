Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262128AbSJ2Skj>; Tue, 29 Oct 2002 13:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262112AbSJ2Skj>; Tue, 29 Oct 2002 13:40:39 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:35341 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262128AbSJ2Skc>;
	Tue, 29 Oct 2002 13:40:32 -0500
Date: Tue, 29 Oct 2002 10:44:20 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PNP driver changes for 2.5.44
Message-ID: <20021029184419.GC27082@kroah.com>
References: <20021029184010.GA27082@kroah.com> <20021029184318.GB27082@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021029184318.GB27082@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.808.4.2, 2002/10/24 00:25:27-07:00, ambx1@neo.rr.com

[PATCH] PnP cleanups and resource changes - 2.5.44 (1/4)

This patch fixes a number of things pointed out by Arne Thomassen.  Also it
makes a few changes to the resource checking functions in that they now check to
make sure that resources do not conflict within the same device instead of only
other devices.  Although it is rare for this to be a factor it's nice to be able
to deal with such situations properly.


diff -Nru a/drivers/pnp/core.c b/drivers/pnp/core.c
--- a/drivers/pnp/core.c	Tue Oct 29 10:38:56 2002
+++ b/drivers/pnp/core.c	Tue Oct 29 10:38:56 2002
@@ -82,7 +82,6 @@
 	list_del_init(&protocol->protocol_list);
 	spin_unlock(&pnp_lock);
 	device_unregister(&protocol->dev);
-	return;
 }
 
 /**
@@ -105,7 +104,6 @@
 		pnp_free_resources(dev->res);
 	pnp_free_ids(dev);
 	kfree(dev);
-	return;
 }
 
 /**
@@ -118,7 +116,7 @@
 int pnp_add_device(struct pnp_dev *dev)
 {
 	int error = 0;
-	if (!dev && !dev->protocol)
+	if (!dev || !dev->protocol)
 		return -EINVAL;
 	if (dev->card)
 		sprintf(dev->dev.bus_id, "%02x:%02x.%02x", dev->protocol->number,
@@ -158,7 +156,6 @@
 	list_del_init(&dev->global_list);
 	list_del_init(&dev->dev_list);
 	spin_unlock(&pnp_lock);
-	return;
 }
 
 static int __init pnp_init(void)
diff -Nru a/drivers/pnp/driver.c b/drivers/pnp/driver.c
--- a/drivers/pnp/driver.c	Tue Oct 29 10:38:56 2002
+++ b/drivers/pnp/driver.c	Tue Oct 29 10:38:56 2002
@@ -150,7 +150,7 @@
 
 int pnp_register_driver(struct pnp_driver *drv)
 {
-	int count = 0;
+	int count;
 	pnp_dbg("the driver '%s' has been registered", drv->name);
 
 	drv->driver.name = drv->name;
@@ -194,7 +194,6 @@
 		struct pnp_id *pnp_id = to_pnp_id(pos);
 		kfree(pnp_id);
 	}
-	return;
 }
 
 EXPORT_SYMBOL(pnp_register_driver);
diff -Nru a/drivers/pnp/isapnp/compat.c b/drivers/pnp/isapnp/compat.c
--- a/drivers/pnp/isapnp/compat.c	Tue Oct 29 10:38:56 2002
+++ b/drivers/pnp/isapnp/compat.c	Tue Oct 29 10:38:56 2002
@@ -23,7 +23,6 @@
 			device & 0x0f,
 			(device >> 12) & 0x0f,
 			(device >> 8) & 0x0f);
-	return;
 }
 
 struct pnp_card *pnp_find_card(unsigned short vendor,
diff -Nru a/drivers/pnp/names.c b/drivers/pnp/names.c
--- a/drivers/pnp/names.c	Tue Oct 29 10:38:56 2002
+++ b/drivers/pnp/names.c	Tue Oct 29 10:38:56 2002
@@ -37,7 +37,6 @@
 			return;
 		}
 	}
-	return;
 }
 
 #else
diff -Nru a/drivers/pnp/quirks.c b/drivers/pnp/quirks.c
--- a/drivers/pnp/quirks.c	Tue Oct 29 10:38:56 2002
+++ b/drivers/pnp/quirks.c	Tue Oct 29 10:38:56 2002
@@ -164,6 +164,5 @@
 		}
 		i++;
 	}
-	return;
 }
 
diff -Nru a/drivers/pnp/resource.c b/drivers/pnp/resource.c
--- a/drivers/pnp/resource.c	Tue Oct 29 10:38:56 2002
+++ b/drivers/pnp/resource.c	Tue Oct 29 10:38:56 2002
@@ -308,7 +308,7 @@
 
 /* resource validity checking functions */
 
-static int pnp_check_port(int port, int size)
+static int pnp_check_port(int port, int size, int idx, struct pnp_cfg *config)
 {
 	int i, tmp, rport, rsize;
 	struct pnp_dev *dev;
@@ -338,10 +338,20 @@
 			}
 		}
 	}
+	for (tmp = 0; tmp < 8 && tmp != idx; tmp++) {
+		if (dev->resource[tmp].flags) {
+			rport = config->request.resource[tmp].start;
+			rsize = (config->request.resource[tmp].end - rport) + 1;
+			if (port >= rport && port < rport + rsize)
+				return 1;
+			if (port + size > rport && port + size < (rport + rsize) - 1)
+				return 1;
+		}
+	}
 	return 0;
 }
 
-static int pnp_check_mem(unsigned int addr, unsigned int size)
+static int pnp_check_mem(unsigned int addr, unsigned int size, int idx, struct pnp_cfg *config)
 {
 	int i, tmp;
 	unsigned int raddr, rsize;
@@ -360,7 +370,7 @@
 	pnp_for_each_dev(dev) {
 		if (dev->active) {
 			for (tmp = 0; tmp < 4; tmp++) {
-				if (dev->resource[tmp].flags) {
+				if (dev->resource[tmp + 8].flags) {
 					raddr = dev->resource[tmp + 8].start;
 					rsize = (dev->resource[tmp + 8].end - raddr) + 1;
 					if (addr >= raddr && addr < raddr + rsize)
@@ -371,6 +381,16 @@
 			}
 		}
 	}
+	for (tmp = 0; tmp < 4 && tmp != idx; tmp++) {
+		if (dev->resource[tmp + 8].flags) {
+			raddr = config->request.resource[tmp + 8].start;
+			rsize = (config->request.resource[tmp + 8].end - raddr) + 1;
+			if (addr >= raddr && addr < raddr + rsize)
+				return 1;
+			if (addr + size > raddr && addr + size < (raddr + rsize) - 1)
+				return 1;
+		}
+	}
 	return 0;
 }
 
@@ -453,10 +473,11 @@
 /* config generation functions */
 static int pnp_generate_port(struct pnp_cfg *config, int num)
 {
-	struct pnp_port *port = config->port[num];
+	struct pnp_port *port;
 	unsigned long *value1, *value2, *value3;
 	if (!config || num < 0 || num > 7)
 		return -EINVAL;
+	port = config->port[num];
 	if (!port)
 		return 0;
 	value1 = &config->request.resource[num].start;
@@ -465,7 +486,7 @@
 	*value1 = port->min;
 	*value2 = *value1 + port->size -1;
 	*value3 = port->flags | IORESOURCE_IO;
-	while (pnp_check_port(*value1, port->size)) {
+	while (pnp_check_port(*value1, port->size, num, config)) {
 		*value1 += port->align;
 		*value2 = *value1 + port->size - 1;
 		if (*value1 > port->max || !port->align)
@@ -476,10 +497,11 @@
 
 static int pnp_generate_mem(struct pnp_cfg *config, int num)
 {
-	struct pnp_mem *mem = config->mem[num];
+	struct pnp_mem *mem;
 	unsigned long *value1, *value2, *value3;
 	if (!config || num < 0 || num > 3)
 		return -EINVAL;
+	mem = config->mem[num];
 	if (!mem)
 		return 0;
 	value1 = &config->request.resource[num + 8].start;
@@ -496,7 +518,7 @@
 		*value3 |= IORESOURCE_RANGELENGTH;
 	if (mem->flags & IORESOURCE_MEM_SHADOWABLE)
 		*value3 |= IORESOURCE_SHADOWABLE;
-	while (pnp_check_mem(*value1, mem->size)) {
+	while (pnp_check_mem(*value1, mem->size, num, config)) {
 		*value1 += mem->align;
 		*value2 = *value1 + mem->size - 1;
 		if (*value1 > mem->max || !mem->align)
@@ -507,7 +529,7 @@
 
 static int pnp_generate_irq(struct pnp_cfg *config, int num)
 {
-	struct pnp_irq *irq = config->irq[num];
+	struct pnp_irq *irq;
 	unsigned long *value1, *value2, *value3;
 	/* IRQ priority: this table is good for i386 */
 	static unsigned short xtab[16] = {
@@ -516,6 +538,7 @@
 	int i;
 	if (!config || num < 0 || num > 1)
 		return -EINVAL;
+	irq = config->irq[num];
 	if (!irq)
 		return 0;
 	value1 = &config->request.irq_resource[num].start;
@@ -536,16 +559,16 @@
 
 static int pnp_generate_dma(struct pnp_cfg *config, int num)
 {
-	struct pnp_dma *dma = config->dma[num];
+	struct pnp_dma *dma;
 	unsigned long *value1, *value2, *value3;
 	/* DMA priority: this table is good for i386 */
 	static unsigned short xtab[16] = {
 		1, 3, 5, 6, 7, 0, 2, 4
 	};
 	int i;
-
 	if (!config || num < 0 || num > 1)
 		return -EINVAL;
+	dma = config->dma[num];
 	if (!dma)
 		return 0;
 	value1 = &config->request.dma_resource[num].start;
@@ -566,10 +589,11 @@
 
 static int pnp_prepare_request(struct pnp_cfg *config)
 {
-	struct pnp_dev *dev = &config->request;
+	struct pnp_dev *dev;
 	int idx;
 	if (!config)
 		return -EINVAL;
+	dev = &config->request;
 	if (dev == NULL)
 		return -EINVAL;
 	if (dev->active || dev->ro)
@@ -629,21 +653,29 @@
 
 static struct pnp_cfg * pnp_generate_config(struct pnp_dev *dev, int depnum)
 {
-	struct pnp_cfg * config = pnp_alloc(sizeof(struct pnp_cfg));
+	struct pnp_cfg * config;
 	int nport = 0, nirq = 0, ndma = 0, nmem = 0;
-	struct pnp_resources * res = dev->res;
-	struct pnp_port * port = res->port;
-	struct pnp_mem * mem = res->mem;
-	struct pnp_irq * irq = res->irq;
-	struct pnp_dma * dma = res->dma;
+	struct pnp_resources * res;
+	struct pnp_port * port;
+	struct pnp_mem * mem;
+	struct pnp_irq * irq;
+	struct pnp_dma * dma;
 	if (!dev)
 		return NULL;
 	if (depnum < 0)
 		return NULL;
+	config = pnp_alloc(sizeof(struct pnp_cfg));
 	if (!config)
 		return NULL;
 
 	/* independent */
+	res = pnp_find_resources(dev, 0);
+	if (!res)
+		goto fail;
+	port = res->port;
+	mem = res->mem;
+	irq = res->irq;
+	dma = res->dma;
 	while (port){
 		config->port[nport] = port;
 		nport++;
@@ -669,6 +701,8 @@
 	if (depnum == 0)
 		return config;
 	res = pnp_find_resources(dev, depnum);
+	if (!res)
+		goto fail;
 	port = res->port;
 	mem = res->mem;
 	irq = res->irq;
@@ -695,6 +729,10 @@
 		dma = dma->next;
 	}
 	return config;
+	
+	fail:
+	kfree(config);
+	return NULL;
 }
 
 /* PnP Device Resource Management */
