Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265483AbTGCXST (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 19:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265499AbTGCXST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 19:18:19 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:21900 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S265483AbTGCXSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 19:18:06 -0400
Date: Thu, 3 Jul 2003 19:03:04 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz,
       alsa-devel@alsa-project.org
Subject: Re: 2.5.73: ALSA ISA pnp_init_resource_table compile errors
Message-ID: <20030703190304.GA17707@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Adrian Bunk <bunk@fs.tum.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz,
	alsa-devel@alsa-project.org
References: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com> <20030622234447.GB3710@fs.tum.de> <20030623000808.GA14945@neo.rr.com> <20030703025343.GC282@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030703025343.GC282@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 04:53:43AM +0200, Adrian Bunk wrote:
> I don't know whether it's related, but with 2.5.73 + your patch and
> 2.5.74 my soundcard stopped working (driver compiled statically into
> the kernel, no options given).
>
> >From dmesg:
> 
> 2.5.74:
> 
> <--  snip  -->
> 
> Advanced Linux Sound Architecture DriverVersion 0.9.4 (Mon Jun 09 12:01:18 2003 UTC).
> specify port
> pnp: the driver 'ad1816a' has been registered
> pnp: match found with the PnP device '01:01.00'and the driver 'ad1816a'
> pnp: match found with the PnP device '01:01.01'and the driver 'ad1816a'
> ad1816a: AUDIO the requested resources areinvalid, using auto config
> pnp: Unable to assign resources to device 01:01.00
> ALSA device list:
>   No soundcards found.
> 
> <--  snip  -->
> 
> 
> 2.5.72 (soundcard works):
> 
> 
> <--  snip  -->
> 
> Advanced Linux Sound Architecture DriverVersion 0.9.4 (Mon Jun 09 12:01:18 2003 UTC).
> specify port
> pnp: the driver 'ad1816a' has been registered
> pnp: match found with the PnP device '01:01.00'and the driver 'ad1816a'Jul  3 04:37:42 r063144 kernel: pnp: match found with the PnP device '01:01.01'and the driver 'ad1816a'
> pnp: res: the device '01:01.00' has beenactivated.
> pnp: res: the device '01:01.01' has beenactivated.
> ALSA device list:
>   #0: ADI SoundPort AD1816A soundcard, SS at0x530, irq 5, dma 1&3
>
> <--  snip  -->

Hi,

Some of my recent patches may correct this issue.  If not, it may be
an unresolvable resource conflict.  Try catting
/sys/bus/pnp1/devices/01:01.00/options and see if any of the needed
irqs are available, most importantly irq 5.

Also the 'resources' file can be used to configure the device.
try...
#"clear" > resources
#"activate" > resources

A printk will display if it was successful.

Let me know if this works.

Thanks,
Adam

P.S.: I'll be traveling so I'll try to get back to you as soon as I
can.

diff -urN a/drivers/pnp/interface.c b/drivers/pnp/interface.c
--- a/drivers/pnp/interface.c	2003-07-03 00:24:32.000000000 +0000
+++ b/drivers/pnp/interface.c	2003-07-02 23:44:01.000000000 +0000
@@ -259,7 +259,10 @@
 	for (i = 0; i < PNP_MAX_PORT; i++) {
 		if (pnp_port_valid(dev, i)) {
 			pnp_printf(buffer,"io");
-			pnp_printf(buffer," 0x%lx-0x%lx \n",
+			if (pnp_port_flags(dev, i) & IORESOURCE_DISABLED)
+				pnp_printf(buffer," disabled\n");
+			else
+				pnp_printf(buffer," 0x%lx-0x%lx\n",
 						pnp_port_start(dev, i),
 						pnp_port_end(dev, i));
 		}
@@ -267,7 +270,10 @@
 	for (i = 0; i < PNP_MAX_MEM; i++) {
 		if (pnp_mem_valid(dev, i)) {
 			pnp_printf(buffer,"mem");
-			pnp_printf(buffer," 0x%lx-0x%lx \n",
+			if (pnp_mem_flags(dev, i) & IORESOURCE_DISABLED)
+				pnp_printf(buffer," disabled\n");
+			else
+				pnp_printf(buffer," 0x%lx-0x%lx\n",
 						pnp_mem_start(dev, i),
 						pnp_mem_end(dev, i));
 		}
@@ -275,13 +281,21 @@
 	for (i = 0; i < PNP_MAX_IRQ; i++) {
 		if (pnp_irq_valid(dev, i)) {
 			pnp_printf(buffer,"irq");
-			pnp_printf(buffer," %ld \n", pnp_irq(dev, i));
+			if (pnp_irq_flags(dev, i) & IORESOURCE_DISABLED)
+				pnp_printf(buffer," disabled\n");
+			else
+				pnp_printf(buffer," %ld\n",
+						pnp_irq(dev, i));
 		}
 	}
 	for (i = 0; i < PNP_MAX_DMA; i++) {
 		if (pnp_dma_valid(dev, i)) {
 			pnp_printf(buffer,"dma");
-			pnp_printf(buffer," %ld \n", pnp_dma(dev, i));
+			if (pnp_dma_flags(dev, i) & IORESOURCE_DISABLED)
+				pnp_printf(buffer," disabled\n");
+			else
+				pnp_printf(buffer," %ld\n",
+						pnp_dma(dev, i));
 		}
 	}
 	ret = (buffer->curr - buf);
diff -urN a/drivers/pnp/manager.c b/drivers/pnp/manager.c
--- a/drivers/pnp/manager.c	2003-07-03 00:24:32.000000000 +0000
+++ b/drivers/pnp/manager.c	2003-07-02 23:43:10.000000000 +0000
@@ -40,6 +40,9 @@
 	if (!(dev->res.port_resource[idx].flags & IORESOURCE_AUTO))
 		return 1;
 
+	if (!rule->size)
+		return 1; /* skip disabled resource requests */
+
 	start = &dev->res.port_resource[idx].start;
 	end = &dev->res.port_resource[idx].end;
 	flags = &dev->res.port_resource[idx].flags;
@@ -76,6 +79,9 @@
 	if (!(dev->res.mem_resource[idx].flags & IORESOURCE_AUTO))
 		return 1;
 
+	if (!rule->size)
+		return 1; /* skip disabled resource requests */
+
 	start = &dev->res.mem_resource[idx].start;
 	end = &dev->res.mem_resource[idx].end;
 	flags = &dev->res.mem_resource[idx].flags;
@@ -128,6 +134,9 @@
 	if (!(dev->res.irq_resource[idx].flags & IORESOURCE_AUTO))
 		return 1;
 
+	if (!rule->map)
+		return 1; /* skip disabled resource requests */
+
 	start = &dev->res.irq_resource[idx].start;
 	end = &dev->res.irq_resource[idx].end;
 	flags = &dev->res.irq_resource[idx].flags;
@@ -168,6 +177,9 @@
 	if (!(dev->res.dma_resource[idx].flags & IORESOURCE_AUTO))
 		return 1;
 
+	if (!rule->map)
+		return 1; /* skip disabled resource requests */
+
 	start = &dev->res.dma_resource[idx].start;
 	end = &dev->res.dma_resource[idx].end;
 	flags = &dev->res.dma_resource[idx].flags;
diff -urN a/drivers/pnp/resource.c b/drivers/pnp/resource.c
--- a/drivers/pnp/resource.c	2003-07-03 00:24:32.000000000 +0000
+++ b/drivers/pnp/resource.c	2003-07-02 22:31:48.000000000 +0000
@@ -286,6 +286,8 @@
 			continue;
 		for (tmp = 0; tmp < PNP_MAX_PORT; tmp++) {
 			if (tdev->res.port_resource[tmp].flags & IORESOURCE_IO) {
+				if (pnp_port_flags(dev, tmp) & IORESOURCE_DISABLED)
+					continue;
 				tport = &tdev->res.port_resource[tmp].start;
 				tend = &tdev->res.port_resource[tmp].end;
 				if (ranged_conflict(port,end,tport,tend))
@@ -340,6 +342,8 @@
 			continue;
 		for (tmp = 0; tmp < PNP_MAX_MEM; tmp++) {
 			if (tdev->res.mem_resource[tmp].flags & IORESOURCE_MEM) {
+				if (pnp_mem_flags(dev, tmp) & IORESOURCE_DISABLED)
+					continue;
 				taddr = &tdev->res.mem_resource[tmp].start;
 				tend = &tdev->res.mem_resource[tmp].end;
 				if (ranged_conflict(addr,end,taddr,tend))
@@ -409,6 +413,8 @@
 			continue;
 		for (tmp = 0; tmp < PNP_MAX_IRQ; tmp++) {
 			if (tdev->res.irq_resource[tmp].flags & IORESOURCE_IRQ) {
+				if (pnp_irq_flags(dev, tmp) & IORESOURCE_DISABLED)
+					continue;
 				if ((tdev->res.irq_resource[tmp].start == *irq))
 					return 0;
 			}
@@ -462,6 +468,8 @@
 			continue;
 		for (tmp = 0; tmp < PNP_MAX_DMA; tmp++) {
 			if (tdev->res.dma_resource[tmp].flags & IORESOURCE_DMA) {
+				if (pnp_dma_flags(dev, tmp) & IORESOURCE_DISABLED)
+					continue;
 				if ((tdev->res.dma_resource[tmp].start == *dma))
 					return 0;
 			}
diff -urN a/drivers/pnp/support.c b/drivers/pnp/support.c
--- a/drivers/pnp/support.c	2003-07-03 00:24:32.000000000 +0000
+++ b/drivers/pnp/support.c	2003-07-02 22:31:48.000000000 +0000
@@ -68,9 +68,13 @@
 	int i = 0;
 	while ((res->irq_resource[i].flags & IORESOURCE_IRQ) && i < PNP_MAX_IRQ) i++;
 	if (i < PNP_MAX_IRQ) {
+		res->irq_resource[i].flags = IORESOURCE_IRQ;  // Also clears _UNSET flag
+		if (irq == -1) {
+			res->irq_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
 		res->irq_resource[i].start =
 		res->irq_resource[i].end = (unsigned long) irq;
-		res->irq_resource[i].flags = IORESOURCE_IRQ;  // Also clears _UNSET flag
 	}
 }
 
@@ -79,9 +83,13 @@
 	int i = 0;
 	while ((res->dma_resource[i].flags & IORESOURCE_DMA) && i < PNP_MAX_DMA) i++;
 	if (i < PNP_MAX_DMA) {
+		res->dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET flag
+		if (dma == -1) {
+			res->dma_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
 		res->dma_resource[i].start =
 		res->dma_resource[i].end = (unsigned long) dma;
-		res->dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET flag
 	}
 }
 
@@ -90,9 +98,13 @@
 	int i = 0;
 	while ((res->port_resource[i].flags & IORESOURCE_IO) && i < PNP_MAX_PORT) i++;
 	if (i < PNP_MAX_PORT) {
+		res->port_resource[i].flags = IORESOURCE_IO;  // Also clears _UNSET flag
+		if (len <= 0 || (io + len -1) >= 0x10003) {
+			res->port_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
 		res->port_resource[i].start = (unsigned long) io;
 		res->port_resource[i].end = (unsigned long)(io + len - 1);
-		res->port_resource[i].flags = IORESOURCE_IO;  // Also clears _UNSET flag
 	}
 }
 
@@ -101,9 +113,13 @@
 	int i = 0;
 	while ((res->mem_resource[i].flags & IORESOURCE_MEM) && i < PNP_MAX_MEM) i++;
 	if (i < PNP_MAX_MEM) {
+		res->mem_resource[i].flags = IORESOURCE_MEM;  // Also clears _UNSET flag
+		if (len <= 0) {
+			res->mem_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
 		res->mem_resource[i].start = (unsigned long) mem;
 		res->mem_resource[i].end = (unsigned long)(mem + len - 1);
-		res->mem_resource[i].flags = IORESOURCE_MEM;  // Also clears _UNSET flag
 	}
 }

--- a/include/linux/ioport.h	2003-07-02 20:42:17.000000000 +0000
+++ b/include/linux/ioport.h	2003-07-02 22:31:48.000000000 +0000
@@ -43,6 +43,7 @@
 #define IORESOURCE_SHADOWABLE	0x00010000
 #define IORESOURCE_BUS_HAS_VGA	0x00080000
 
+#define IORESOURCE_DISABLED	0x10000000
 #define IORESOURCE_UNSET	0x20000000
 #define IORESOURCE_AUTO		0x40000000
 #define IORESOURCE_BUSY		0x80000000	/* Driver has marked this resource busy */
diff -urN a/drivers/pnp/manager.c b/drivers/pnp/manager.c
--- a/drivers/pnp/manager.c	2003-07-03 00:55:25.000000000 +0000
+++ b/drivers/pnp/manager.c	2003-07-03 01:07:17.000000000 +0000
@@ -40,17 +40,20 @@
 	if (!(dev->res.port_resource[idx].flags & IORESOURCE_AUTO))
 		return 1;
 
-	if (!rule->size)
-		return 1; /* skip disabled resource requests */
-
 	start = &dev->res.port_resource[idx].start;
 	end = &dev->res.port_resource[idx].end;
 	flags = &dev->res.port_resource[idx].flags;
 
 	/* set the initial values */
+	*flags = *flags | rule->flags | IORESOURCE_IO;
+
+	if (!rule->size) {
+		*flags |= IORESOURCE_DISABLED;
+		return 1; /* skip disabled resource requests */
+	}
+
 	*start = rule->min;
 	*end = *start + rule->size - 1;
-	*flags = *flags | rule->flags | IORESOURCE_IO;
 
 	/* run through until pnp_check_port is happy */
 	while (!pnp_check_port(dev, idx)) {
@@ -79,16 +82,11 @@
 	if (!(dev->res.mem_resource[idx].flags & IORESOURCE_AUTO))
 		return 1;
 
-	if (!rule->size)
-		return 1; /* skip disabled resource requests */
-
 	start = &dev->res.mem_resource[idx].start;
 	end = &dev->res.mem_resource[idx].end;
 	flags = &dev->res.mem_resource[idx].flags;
 
 	/* set the initial values */
-	*start = rule->min;
-	*end = *start + rule->size -1;
 	*flags = *flags | rule->flags | IORESOURCE_MEM;
 
 	/* convert pnp flags to standard Linux flags */
@@ -101,6 +99,14 @@
 	if (rule->flags & IORESOURCE_MEM_SHADOWABLE)
 		*flags |= IORESOURCE_SHADOWABLE;
 
+	if (!rule->size) {
+		*flags |= IORESOURCE_DISABLED;
+		return 1; /* skip disabled resource requests */
+	}
+
+	*start = rule->min;
+	*end = *start + rule->size -1;
+
 	/* run through until pnp_check_mem is happy */
 	while (!pnp_check_mem(dev, idx)) {
 		*start += rule->align;
@@ -134,9 +140,6 @@
 	if (!(dev->res.irq_resource[idx].flags & IORESOURCE_AUTO))
 		return 1;
 
-	if (!rule->map)
-		return 1; /* skip disabled resource requests */
-
 	start = &dev->res.irq_resource[idx].start;
 	end = &dev->res.irq_resource[idx].end;
 	flags = &dev->res.irq_resource[idx].flags;
@@ -144,6 +147,11 @@
 	/* set the initial values */
 	*flags = *flags | rule->flags | IORESOURCE_IRQ;
 
+	if (!rule->map) {
+		*flags |= IORESOURCE_DISABLED;
+		return 1; /* skip disabled resource requests */
+	}
+
 	for (i = 0; i < 16; i++) {
 		if(rule->map & (1<<xtab[i])) {
 			*start = *end = xtab[i];
@@ -177,9 +185,6 @@
 	if (!(dev->res.dma_resource[idx].flags & IORESOURCE_AUTO))
 		return 1;
 
-	if (!rule->map)
-		return 1; /* skip disabled resource requests */
-
 	start = &dev->res.dma_resource[idx].start;
 	end = &dev->res.dma_resource[idx].end;
 	flags = &dev->res.dma_resource[idx].flags;
@@ -187,6 +192,11 @@
 	/* set the initial values */
 	*flags = *flags | rule->flags | IORESOURCE_DMA;
 
+	if (!rule->map) {
+		*flags |= IORESOURCE_DISABLED;
+		return 1; /* skip disabled resource requests */
+	}
+
 	for (i = 0; i < 8; i++) {
 		if(rule->map & (1<<xtab[i])) {
 			*start = *end = xtab[i];
--- a/drivers/pnp/manager.c	2003-07-03 15:28:06.000000000 +0000
+++ b/drivers/pnp/manager.c	2003-07-03 15:03:08.000000000 +0000
@@ -400,25 +400,24 @@
 	dev->res = *res;
 	if (!(mode & PNP_CONFIG_FORCE)) {
 		for (i = 0; i < PNP_MAX_PORT; i++) {
-			if(pnp_check_port(dev,i))
+			if(!pnp_check_port(dev,i))
 				goto fail;
 		}
 		for (i = 0; i < PNP_MAX_MEM; i++) {
-			if(pnp_check_mem(dev,i))
+			if(!pnp_check_mem(dev,i))
 				goto fail;
 		}
 		for (i = 0; i < PNP_MAX_IRQ; i++) {
-			if(pnp_check_irq(dev,i))
+			if(!pnp_check_irq(dev,i))
 				goto fail;
 		}
 		for (i = 0; i < PNP_MAX_DMA; i++) {
-			if(pnp_check_dma(dev,i))
+			if(!pnp_check_dma(dev,i))
 				goto fail;
 		}
 	}
 	up(&pnp_res_mutex);

-	pnp_auto_config_dev(dev);
 	kfree(bak);
 	return 0;
 
