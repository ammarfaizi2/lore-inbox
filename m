Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVAXOJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVAXOJh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 09:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVAXOJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 09:09:37 -0500
Received: from mail9.messagelabs.com ([194.205.110.133]:24007 "HELO
	mail9.messagelabs.com") by vger.kernel.org with SMTP
	id S261511AbVAXOI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 09:08:56 -0500
X-VirusChecked: Checked
X-Env-Sender: icampbell@arcom.com
X-Msg-Ref: server-18.tower-9.messagelabs.com!1106569333!11039292!1
X-StarScan-Version: 5.4.5; banners=arcom.com,-,-
X-Originating-IP: [194.200.159.164]
Subject: RFC: use datacs is smc91x driver
From: Ian Campbell <icampbell@arcom.com>
To: Nicolas Pitre <nico@cam.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Arcom Control Systems
Date: Mon, 24 Jan 2005 12:21:42 +0000
Message-Id: <1106569302.19123.49.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-IMAIL-SPAM-VALHELO: (715194684)
X-IMAIL-SPAM-VALREVDNS: (715194684)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nico,

Below is a first cut at supporting the second 32-bit DATACS chipselect
in the smc91x driver to transfer data.

My platform has a 16-bit chip select for the primary IO region and no
DMA. I found that throughput went from roughly 50mbit/s to 80mbit/s. I
tested by throwing UDP packets at it using mgen (9000 packets/second
with UDP payload of 1472 bytes is roughly 100mbit/s, I think) and
counting the packets received in 60s, I then did the same for
transmitting. The measurements are very rough but the improvement seems
fairly significant to me. Perhaps there is another benchmark you would
like me to try?

I did consider adding a define for 'NEEDS_ATTRIB_ENABLE' but decided not
to in the end for backwards compat, and because I have no platforms to
test that bit on. That is why the attrib stuff has been factored out of
smc_probe(), I think it is tidier that way anyway.

I'm not entirely happy with using the SMC_*_RESOURCE defines to find the
correct resources, but I don't think you can have a placeholder for the
attrib space at index 1 (when you don't have an attrib space) and still
have datacs at index 2.

What do you think?

Ian.

Signed-off-by: Ian Campbell <icampbell@arcom.com>

Index: 2.6/drivers/net/smc91x.c
===================================================================
--- 2.6.orig/drivers/net/smc91x.c	2005-01-24 10:22:49.000000000 +0000
+++ 2.6/drivers/net/smc91x.c	2005-01-24 11:58:13.543739813 +0000
@@ -201,6 +201,10 @@
 
 	spinlock_t lock;
 
+#ifdef SMC_CAN_USE_DATACS
+	u32	*datacs;
+#endif
+
 #ifdef SMC_USE_PXA_DMA
 	/* DMA needs the physical address of the chip */
 	u_long physaddr;
@@ -1989,16 +1993,21 @@
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
+	res = platform_get_resource(pdev, IORESOURCE_MEM, SMC_ATTRIB_RESOURCE);
+	if (!res)
+		return 0;
 
 	/*
 	 * Map the attribute space.  This is overkill, but clean.
 	 */
-	addr = ioremap(attrib_phys, ATTRIB_SIZE);
+	addr = ioremap(res->start, ATTRIB_SIZE);
 	if (!addr)
 		return -ENOMEM;
 
@@ -2046,6 +2055,72 @@
 	return 0;
 }
 
+static int smc_request_attrib(struct platform_device *pdev)
+{
+	struct resource * res = platform_get_resource(pdev, IORESOURCE_MEM, SMC_ATTRIB_RESOURCE);
+
+	if (res) {
+		if (!request_mem_region(res->start, ATTRIB_SIZE, CARDNAME))
+			return -EBUSY;
+	}
+	return 0;
+}
+
+static void smc_release_attrib(struct platform_device *pdev)
+{
+	struct resource * res = platform_get_resource(pdev, IORESOURCE_MEM, SMC_ATTRIB_RESOURCE);
+
+	if (res)
+		release_mem_region(res->start, ATTRIB_SIZE);
+}
+
+#ifdef SMC_CAN_USE_DATACS
+static void smc_request_datacs(struct platform_device *pdev, struct net_device *ndev)
+{
+	struct resource * res = platform_get_resource(pdev, IORESOURCE_MEM, SMC_DATACS_RESOURCE);
+	struct smc_local *lp = netdev_priv(ndev);
+
+	if (!res) {
+		printk(KERN_CRIT "no datacs resource\n");
+		return;
+	}
+
+	if(!request_mem_region(res->start, SMC_DATA_EXTENT, CARDNAME)) {
+		printk(KERN_CRIT "failed request region\n");
+		return;
+	}
+
+	printk(KERN_CRIT "%s: requested datacs memory region %#010lx-%#010lx\n", 
+	       CARDNAME, res->start, res->end);
+
+	lp->datacs = ioremap(res->start, SMC_DATA_EXTENT);
+	printk(KERN_CRIT "%s: remapped datacs to %p\n", CARDNAME, lp->datacs);
+
+}
+
+static void smc_release_datacs(struct platform_device *pdev, struct net_device *ndev)
+{
+	struct smc_local *lp = netdev_priv(ndev);
+	struct resource * res = platform_get_resource(pdev, IORESOURCE_MEM, SMC_DATACS_RESOURCE);
+
+	if (lp->datacs) {
+		printk(KERN_CRIT "%s: releasing datacs at %p\n", CARDNAME, lp->datacs);
+		iounmap(lp->datacs);
+	}
+
+	lp->datacs = NULL;
+
+	if (res) {
+		release_mem_region(res->start, SMC_DATA_EXTENT);
+		printk(KERN_CRIT "%s: released datacs memory region %#010lx-%#010lx\n", 
+		       CARDNAME, res->start, res->end);
+	}
+}
+#else 
+static void smc_request_datacs(struct platform_device *pdev, struct net_device *ndev) {}
+static void smc_release_datacs(struct platform_device *pdev, struct net_device *ndev) {}
+#endif
+
 /*
  * smc_init(void)
  *   Input parameters:
@@ -2061,20 +2136,18 @@
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct net_device *ndev;
-	struct resource *res, *ext = NULL;
+	struct resource *res;
 	unsigned int *addr;
 	int ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, SMC_IO_RESOURCE);
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
@@ -2083,7 +2156,7 @@
 	if (!ndev) {
 		printk("%s: could not allocate device.\n", CARDNAME);
 		ret = -ENOMEM;
-		goto release_1;
+		goto out_release_io;
 	}
 	SET_MODULE_OWNER(ndev);
 	SET_NETDEV_DEV(ndev, dev);
@@ -2091,42 +2164,27 @@
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
+	printk(KERN_CRIT "%s: mapped IO to %p\n", CARDNAME, addr);
 
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
@@ -2134,6 +2192,22 @@
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
 
@@ -2154,10 +2228,11 @@
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
+	res = platform_get_resource(pdev, IORESOURCE_MEM, SMC_IO_RESOURCE);
 	release_mem_region(res->start, SMC_IO_EXTENT);
 
 	free_netdev(ndev);
@@ -2186,9 +2261,7 @@
 
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
--- 2.6.orig/drivers/net/smc91x.h	2005-01-24 10:22:49.000000000 +0000
+++ 2.6/drivers/net/smc91x.h	2005-01-24 11:36:35.297811106 +0000
@@ -380,7 +381,16 @@
 #define SMC_IO_SHIFT	0
 #endif
 #define SMC_IO_EXTENT	(16 << SMC_IO_SHIFT)
+#define SMC_DATA_EXTENT (4)
 
+#define SMC_IO_RESOURCE 	0
+
+#if defined (SMC_CAN_USE_DATACS)
+# define SMC_DATACS_RESOURCE	1
+# define SMC_ATTRIB_RESOURCE	2
+#else
+# define SMC_ATTRIB_RESOURCE	1
+#endif
 
 /*
  . Bank Select Register:
@@ -901,7 +911,7 @@
 #endif
 
 #if SMC_CAN_USE_32BIT
-#define SMC_PUSH_DATA(p, l)						\
+#define _SMC_PUSH_DATA(p, l)						\
 	do {								\
 		char *__ptr = (p);					\
 		int __len = (l);					\
@@ -916,7 +926,7 @@
 			SMC_outw( *((u16 *)__ptr), ioaddr, DATA_REG );	\
 		}							\
 	} while (0)
-#define SMC_PULL_DATA(p, l)						\
+#define _SMC_PULL_DATA(p, l)						\
 	do {								\
 		char *__ptr = (p);					\
 		int __len = (l);					\
@@ -936,11 +946,11 @@
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
@@ -959,6 +969,51 @@
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



-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200


_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been virus scanned by MessageLabs.
