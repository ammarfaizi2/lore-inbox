Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVAYQ03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVAYQ03 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 11:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVAYQ02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 11:26:28 -0500
Received: from mail9.messagelabs.com ([194.205.110.133]:15744 "HELO
	mail9.messagelabs.com") by vger.kernel.org with SMTP
	id S262005AbVAYQZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 11:25:05 -0500
X-VirusChecked: Checked
X-Env-Sender: icampbell@arcom.com
X-Msg-Ref: server-27.tower-9.messagelabs.com!1106670301!13219372!1
X-StarScan-Version: 5.4.5; banners=arcom.com,-,-
X-Originating-IP: [194.200.159.164]
Subject: Re: RFC: use datacs is smc91x driver
From: Ian Campbell <icampbell@arcom.com>
To: Nicolas Pitre <nico@cam.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0501251038030.16341@localhost.localdomain>
References: <1106569302.19123.49.camel@icampbell-debian>
	 <Pine.LNX.4.61.0501241459090.7307@localhost.localdomain>
	 <1106651657.19123.54.camel@icampbell-debian>
	 <1106665612.19123.142.camel@icampbell-debian>
	 <Pine.LNX.4.61.0501251038030.16341@localhost.localdomain>
Content-Type: text/plain
Organization: Arcom Control Systems
Date: Tue, 25 Jan 2005 16:24:59 +0000
Message-Id: <1106670299.19123.151.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-IMAIL-SPAM-VALHELO: (448856126)
X-IMAIL-SPAM-VALREVDNS: (448856126)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-25 at 10:41 -0500, Nicolas Pitre wrote:
> On Tue, 25 Jan 2005, Ian Campbell wrote:
> > so perhaps smc91x-datacs -attrib -iocs might be more appropriate names?
> 
> Probably, although "iocs" is rather criptic for someone not familiar 
> with the chip.  What about "smc91x-regs", "smc91x-attrib" and 
> "smc91x-data32" ?

Sounds good. Are you happy for me to send the version below to Andrew
and Jeff for inclusion? compiled on lubbock and neponset, compiled and
tested on my platform.

Cheers,
Ian.

Signed-off-by: Ian Campbell <icampbell@arcom.com>

Index: 2.6/drivers/net/smc91x.c
===================================================================
--- 2.6.orig/drivers/net/smc91x.c	2005-01-25 08:48:28.000000000 +0000
+++ 2.6/drivers/net/smc91x.c	2005-01-25 15:56:00.405373349 +0000
@@ -210,6 +210,10 @@
 
 	spinlock_t lock;
 
+#ifdef SMC_CAN_USE_DATACS
+	u32	*datacs;
+#endif
+
 #ifdef SMC_USE_PXA_DMA
 	/* DMA needs the physical address of the chip */
 	u_long physaddr;
@@ -1998,16 +2002,21 @@
 	return retval;
 }
 
-static int smc_enable_device(unsigned long attrib_phys)
+static int smc_enable_device(struct platform_device *pdev)
 {
 	unsigned long flags;
 	unsigned char ecor, ecsr;
 	void *addr;
+	struct resource * res;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "smc91x-attrib");
+	if (!res)
+		return 0;
 
 	/*
 	 * Map the attribute space.  This is overkill, but clean.
 	 */
-	addr = ioremap(attrib_phys, ATTRIB_SIZE);
+	addr = ioremap(res->start, ATTRIB_SIZE);
 	if (!addr)
 		return -ENOMEM;
 
@@ -2055,6 +2064,62 @@
 	return 0;
 }
 
+static int smc_request_attrib(struct platform_device *pdev)
+{
+	struct resource * res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "smc91x-attrib");
+
+	if (!res)
+		return 0;
+
+	if (!request_mem_region(res->start, ATTRIB_SIZE, CARDNAME))
+		return -EBUSY;
+
+	return 0;
+}
+
+static void smc_release_attrib(struct platform_device *pdev)
+{
+	struct resource * res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "smc91x-attrib");
+
+	if (res)
+		release_mem_region(res->start, ATTRIB_SIZE);
+}
+
+#ifdef SMC_CAN_USE_DATACS
+static void smc_request_datacs(struct platform_device *pdev, struct net_device *ndev)
+{
+	struct resource * res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "smc91x-data32");
+	struct smc_local *lp = netdev_priv(ndev);
+
+	if (!res)
+		return;
+
+	if(!request_mem_region(res->start, SMC_DATA_EXTENT, CARDNAME)) {
+		printk(KERN_INFO "%s: failed to request datacs memory region.\n", CARDNAME);
+		return;
+	}
+
+	lp->datacs = ioremap(res->start, SMC_DATA_EXTENT);
+}
+
+static void smc_release_datacs(struct platform_device *pdev, struct net_device *ndev)
+{
+	struct smc_local *lp = netdev_priv(ndev);
+	struct resource * res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "smc91x-data32");
+
+	if (lp->datacs)
+		iounmap(lp->datacs);
+
+	lp->datacs = NULL;
+
+	if (res)
+		release_mem_region(res->start, SMC_DATA_EXTENT);
+}
+#else 
+static void smc_request_datacs(struct platform_device *pdev, struct net_device *ndev) {}
+static void smc_release_datacs(struct platform_device *pdev, struct net_device *ndev) {}
+#endif
+
 /*
  * smc_init(void)
  *   Input parameters:
@@ -2070,20 +2135,20 @@
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct net_device *ndev;
-	struct resource *res, *ext = NULL;
+	struct resource *res;
 	unsigned int *addr;
 	int ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "smc91x-regs");
+	if (!res)
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		ret = -ENODEV;
 		goto out;
 	}
 
-	/*
-	 * Request the regions.
-	 */
-	if (!request_mem_region(res->start, SMC_IO_EXTENT, "smc91x")) {
+
+	if (!request_mem_region(res->start, SMC_IO_EXTENT, CARDNAME)) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -2092,7 +2157,7 @@
 	if (!ndev) {
 		printk("%s: could not allocate device.\n", CARDNAME);
 		ret = -ENOMEM;
-		goto release_1;
+		goto out_release_io;
 	}
 	SET_MODULE_OWNER(ndev);
 	SET_NETDEV_DEV(ndev, dev);
@@ -2100,42 +2165,26 @@
 	ndev->dma = (unsigned char)-1;
 	ndev->irq = platform_get_irq(pdev, 0);
 
-	ext = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (ext) {
-		if (!request_mem_region(ext->start, ATTRIB_SIZE, ndev->name)) {
-			ret = -EBUSY;
-			goto release_1;
-		}
-
+	ret = smc_request_attrib(pdev);
+	if (ret)
+		goto out_free_netdev;
 #if defined(CONFIG_SA1100_ASSABET)
-		NCR_0 |= NCR_ENET_OSC_EN;
+	NCR_0 |= NCR_ENET_OSC_EN;
 #endif
-
-		ret = smc_enable_device(ext->start);
-		if (ret)
-			goto release_both;
-	}
+	ret = smc_enable_device(pdev);
+	if (ret)
+		goto out_release_attrib;
 
 	addr = ioremap(res->start, SMC_IO_EXTENT);
 	if (!addr) {
 		ret = -ENOMEM;
-		goto release_both;
+		goto out_release_attrib;
 	}
 
 	dev_set_drvdata(dev, ndev);
 	ret = smc_probe(ndev, (unsigned long)addr);
-	if (ret != 0) {
-		dev_set_drvdata(dev, NULL);
-		iounmap(addr);
- release_both:
-		if (ext)
-			release_mem_region(ext->start, ATTRIB_SIZE);
-		free_netdev(ndev);
- release_1:
-		release_mem_region(res->start, SMC_IO_EXTENT);
- out:
-		printk("%s: not found (%d).\n", CARDNAME, ret);
-	}
+	if (ret != 0)
+		goto out_iounmap;
 #ifdef SMC_USE_PXA_DMA
 	else {
 		struct smc_local *lp = netdev_priv(ndev);
@@ -2143,6 +2192,22 @@
 	}
 #endif
 
+	smc_request_datacs(pdev, ndev);
+
+	return 0;
+
+ out_iounmap:
+	dev_set_drvdata(dev, NULL);
+	iounmap(addr);
+ out_release_attrib:
+	smc_release_attrib(pdev);
+ out_free_netdev:
+	free_netdev(ndev);
+ out_release_io:
+	release_mem_region(res->start, SMC_IO_EXTENT);
+ out:
+	printk("%s: not found (%d).\n", CARDNAME, ret);
+
 	return ret;
 }
 
@@ -2163,10 +2228,13 @@
 		pxa_free_dma(ndev->dma);
 #endif
 	iounmap((void *)ndev->base_addr);
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (res)
-		release_mem_region(res->start, ATTRIB_SIZE);
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	smc_release_datacs(pdev,ndev);
+	smc_release_attrib(pdev);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "smc91x-regs");
+	if (!res)
+		platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(res->start, SMC_IO_EXTENT);
 
 	free_netdev(ndev);
@@ -2195,9 +2263,7 @@
 
 	if (ndev && level == RESUME_ENABLE) {
 		struct smc_local *lp = netdev_priv(ndev);
-
-		if (pdev->num_resources == 3)
-			smc_enable_device(pdev->resource[2].start);
+		smc_enable_device(pdev);
 		if (netif_running(ndev)) {
 			smc_reset(ndev);
 			smc_enable(ndev);
Index: 2.6/drivers/net/smc91x.h
===================================================================
--- 2.6.orig/drivers/net/smc91x.h	2005-01-04 14:11:08.000000000 +0000
+++ 2.6/drivers/net/smc91x.h	2005-01-25 14:47:42.000000000 +0000
@@ -362,7 +362,7 @@
 #define SMC_IO_SHIFT	0
 #endif
 #define SMC_IO_EXTENT	(16 << SMC_IO_SHIFT)
-
+#define SMC_DATA_EXTENT (4)
 
 /*
  . Bank Select Register:
@@ -883,7 +883,7 @@
 #endif
 
 #if SMC_CAN_USE_32BIT
-#define SMC_PUSH_DATA(p, l)						\
+#define _SMC_PUSH_DATA(p, l)						\
 	do {								\
 		char *__ptr = (p);					\
 		int __len = (l);					\
@@ -898,7 +898,7 @@
 			SMC_outw( *((u16 *)__ptr), ioaddr, DATA_REG );	\
 		}							\
 	} while (0)
-#define SMC_PULL_DATA(p, l)						\
+#define _SMC_PULL_DATA(p, l)						\
 	do {								\
 		char *__ptr = (p);					\
 		int __len = (l);					\
@@ -918,11 +918,11 @@
 		SMC_insl( ioaddr, DATA_REG, __ptr, __len >> 2);		\
 	} while (0)
 #elif SMC_CAN_USE_16BIT
-#define SMC_PUSH_DATA(p, l)	SMC_outsw( ioaddr, DATA_REG, p, (l) >> 1 )
-#define SMC_PULL_DATA(p, l)	SMC_insw ( ioaddr, DATA_REG, p, (l) >> 1 )
+#define _SMC_PUSH_DATA(p, l)	SMC_outsw( ioaddr, DATA_REG, p, (l) >> 1 )
+#define _SMC_PULL_DATA(p, l)	SMC_insw ( ioaddr, DATA_REG, p, (l) >> 1 )
 #elif SMC_CAN_USE_8BIT
-#define SMC_PUSH_DATA(p, l)	SMC_outsb( ioaddr, DATA_REG, p, l )
-#define SMC_PULL_DATA(p, l)	SMC_insb ( ioaddr, DATA_REG, p, l )
+#define _SMC_PUSH_DATA(p, l)	SMC_outsb( ioaddr, DATA_REG, p, l )
+#define _SMC_PULL_DATA(p, l)	SMC_insb ( ioaddr, DATA_REG, p, l )
 #endif
 
 #if ! SMC_CAN_USE_16BIT
@@ -941,6 +941,51 @@
 	})
 #endif
 
+#if SMC_CAN_USE_DATACS
+#define SMC_PUSH_DATA(p, l)						\
+	if ( lp->datacs ) {						\
+		unsigned char *__ptr = (p);				\
+		int __len = (l);					\
+ 		if (__len >= 2 && (unsigned long)__ptr & 2) {		\
+ 			__len -= 2;					\
+ 			SMC_outw( *((u16 *)__ptr), ioaddr, DATA_REG );	\
+ 			__ptr += 2;					\
+ 		}							\
+		outsl(lp->datacs, __ptr, __len >> 2);			\
+ 		if (__len & 2) {					\
+ 			__ptr += (__len & ~3);				\
+ 			SMC_outw( *((u16 *)__ptr), ioaddr, DATA_REG );	\
+ 		}							\
+	} else {							\
+		_SMC_PUSH_DATA(p, l);					\
+	}
+
+#define SMC_PULL_DATA(p, l)						\
+	if ( lp->datacs ) { 						\
+		unsigned char *__ptr = (p);				\
+		int __len = (l);					\
+		if ((unsigned long)__ptr & 2) {			 	\
+			/*						\
+			 * We want 32bit alignment here.		\
+			 * Since some buses perform a full 32bit	\
+			 * fetch even for 16bit data we can't use	\
+			 * SMC_inw() here.  Back both source (on chip	\
+			 * and destination) pointers of 2 bytes.	\
+			 */						\
+			__ptr -= 2;					\
+			__len += 2;					\
+			SMC_SET_PTR( 2|PTR_READ|PTR_RCV|PTR_AUTOINC ); 	\
+		}							\
+		__len += 2;						\
+		insl( lp->datacs, __ptr, __len >> 2);			\
+	} else {							\
+		_SMC_PULL_DATA(p, l);					\
+	}
+#else
+#define SMC_PUSH_DATA(p, l) _SMC_PUSH_DATA(p, l)
+#define SMC_PULL_DATA(p, l) _SMC_PULL_DATA(p, l)
+#endif
+
 #if !defined (SMC_INTERRUPT_PREAMBLE)
 # define SMC_INTERRUPT_PREAMBLE
 #endif
Index: 2.6/arch/arm/mach-sa1100/neponset.c
===================================================================
--- 2.6.orig/arch/arm/mach-sa1100/neponset.c	2005-01-04 14:10:53.000000000 +0000
+++ 2.6/arch/arm/mach-sa1100/neponset.c	2005-01-25 15:56:00.130447587 +0000
@@ -266,6 +266,7 @@
 
 static struct resource smc91x_resources[] = {
 	[0] = {
+		.name	= "smc91x-regs",
 		.start	= SA1100_CS3_PHYS,
 		.end	= SA1100_CS3_PHYS + 0x01ffffff,
 		.flags	= IORESOURCE_MEM,
@@ -276,6 +277,7 @@
 		.flags	= IORESOURCE_IRQ,
 	},
 	[2] = {
+		.name	= "smc91x-attrib",
 		.start	= SA1100_CS3_PHYS + 0x02000000,
 		.end	= SA1100_CS3_PHYS + 0x03ffffff,
 		.flags	= IORESOURCE_MEM,
Index: 2.6/arch/arm/mach-pxa/lubbock.c
===================================================================
--- 2.6.orig/arch/arm/mach-pxa/lubbock.c	2005-01-04 14:10:53.000000000 +0000
+++ 2.6/arch/arm/mach-pxa/lubbock.c	2005-01-25 15:56:00.048469724 +0000
@@ -137,6 +137,7 @@
 
 static struct resource smc91x_resources[] = {
 	[0] = {
+		.name	= "smc91x-regs",
 		.start	= 0x0c000000,
 		.end	= 0x0c0fffff,
 		.flags	= IORESOURCE_MEM,
@@ -147,6 +148,7 @@
 		.flags	= IORESOURCE_IRQ,
 	},
 	[2] = {
+		.name	= "smc91x-attrib",
 		.start	= 0x0e000000,
 		.end	= 0x0e0fffff,
 		.flags	= IORESOURCE_MEM,



-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200


_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been virus scanned by MessageLabs.
