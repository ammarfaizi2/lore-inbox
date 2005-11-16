Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030554AbVKPWsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030554AbVKPWsT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 17:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030551AbVKPWry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 17:47:54 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:56001 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030550AbVKPWrw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 17:47:52 -0500
Subject: Re: [PATCH 2 of 2] tpm: updates for new hardware
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Jake Moilanen <moilanen@us.ibm.com>, Tom Lendacky <toml@us.ibm.com>
In-Reply-To: <200511141710.41230.bjorn.helgaas@hp.com>
References: <1131739595.5048.15.camel@localhost.localdomain>
	 <200511141710.41230.bjorn.helgaas@hp.com>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 16:48:16 -0600
Message-Id: <1132181296.4872.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to use ioread8 and iowrite8 as suggested.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>

On Mon, 2005-11-14 at 17:10 -0700, Bjorn Helgaas wrote:
> On Friday 11 November 2005 1:06 pm, Kylene Jo Hall wrote:
> > +#ifdef CONFIG_PPC64
> > +#define atmel_getb(chip, offset) readb(chip->vendor->iobase + offset);
> > +#define atmel_putb(val, chip, offset) writeb(val, chip->vendor->iobase + offset)
> > ...
> > +#else
> > +#define atmel_getb(chip, offset) inb(chip->vendor->base + offset)
> > +#define atmel_putb(val, chip, offset) outb(val, chip->vendor->base + offset)
> 
> Why don't you use ioread8() instead of defining atmel_getb()?
> 
> You'd still need something PPC64-specific to initialize the iomem cookie,
> but the accessors would go away.
> 
> Unfortunately, ioread8() and associated interfaces aren't mentioned
> under Documentation/, but there are some hints in lib/iomap.c.
> 
---
--- linux-2.6.15-rc1/drivers/char/tpm/tpm_atmel.c	2005-11-16 16:02:31.000000000 +0100
+++ linux-2.6.15-rc1-git4/drivers/char/tpm/tpm_atmel.c	2005-11-16 16:34:32.000000000 +0100
@@ -47,13 +47,12 @@ static int tpm_atml_recv(struct tpm_chip
 		return -EIO;
 
 	for (i = 0; i < 6; i++) {
-		status = atmel_getb(chip, 1);
+		status = ioread8(chip->vendor->iobase + 1);
 		if ((status & ATML_STATUS_DATA_AVAIL) == 0) {
-			dev_err(chip->dev,
-				"error reading header\n");
+			dev_err(chip->dev, "error reading header\n");
 			return -EIO;
 		}
-		*buf++ = atmel_getb(chip, 0);
+		*buf++ = ioread8(chip->vendor->iobase);
 	}
 
 	/* size of the data received */
@@ -64,10 +63,9 @@ static int tpm_atml_recv(struct tpm_chip
 		dev_err(chip->dev,
 			"Recv size(%d) less than available space\n", size);
 		for (; i < size; i++) {	/* clear the waiting data anyway */
-			status = atmel_getb(chip, 1);
+			status = ioread8(chip->vendor->iobase + 1);
 			if ((status & ATML_STATUS_DATA_AVAIL) == 0) {
-				dev_err(chip->dev,
-					"error reading data\n");
+				dev_err(chip->dev, "error reading data\n");
 				return -EIO;
 			}
 		}
@@ -76,17 +74,17 @@ static int tpm_atml_recv(struct tpm_chip
 
 	/* read all the data available */
 	for (; i < size; i++) {
-		status = atmel_getb(chip, 1);
+		status = ioread8(chip->vendor->iobase + 1);
 		if ((status & ATML_STATUS_DATA_AVAIL) == 0) {
-			dev_err(chip->dev,
-				"error reading data\n");
+			dev_err(chip->dev, "error reading data\n");
 			return -EIO;
 		}
-		*buf++ = atmel_getb(chip, 0);
+		*buf++ = ioread8(chip->vendor->iobase);
 	}
 
 	/* make sure data available is gone */
-	status = atmel_getb(chip, 1);
+	status = ioread8(chip->vendor->iobase + 1);
+
 	if (status & ATML_STATUS_DATA_AVAIL) {
 		dev_err(chip->dev, "data available is stuck\n");
 		return -EIO;
@@ -102,7 +100,7 @@ static int tpm_atml_send(struct tpm_chip
 	dev_dbg(chip->dev, "tpm_atml_send:\n");
 	for (i = 0; i < count; i++) {
 		dev_dbg(chip->dev, "%d 0x%x(%d)\n",  i, buf[i], buf[i]);
-		atmel_putb(buf[i], chip, 0);
+ 		iowrite8(buf[i], chip->vendor->iobase);
 	}
 
 	return count;
@@ -110,12 +108,12 @@ static int tpm_atml_send(struct tpm_chip
 
 static void tpm_atml_cancel(struct tpm_chip *chip)
 {
-	atmel_putb(ATML_STATUS_ABORT, chip, 1);
+	iowrite8(ATML_STATUS_ABORT, chip->vendor->iobase + 1);
 }
 
 static u8 tpm_atml_status(struct tpm_chip *chip)
 {
-	return atmel_getb(chip, 1);
+	return ioread8(chip->vendor->iobase + 1);
 }
 
 static struct file_operations atmel_ops = {
@@ -162,7 +160,8 @@ static void atml_plat_remove(void)
 
 	if (chip) {
 		if (chip->vendor->have_region)
-			atmel_release_region(chip->vendor->base, chip->vendor->region_size);
+			atmel_release_region(chip->vendor->base,
+					     chip->vendor->region_size);
 		atmel_put_base_addr(chip->vendor);
 		tpm_remove_hardware(chip->dev);
 		platform_device_unregister(pdev);
@@ -183,14 +182,19 @@ static int __init init_atmel(void)
 
 	driver_register(&atml_drv);
 
-	if (atmel_get_base_addr(&tpm_atmel) != 0) {
+	if ((tpm_atmel.iobase = atmel_get_base_addr(&tpm_atmel)) == NULL) {
 		rc = -ENODEV;
 		goto err_unreg_drv;
 	}
 
-	tpm_atmel.have_region = (atmel_request_region( tpm_atmel.base, tpm_atmel.region_size, "tpm_atmel0") == NULL) ? 0 : 1;
-
-	if (IS_ERR(pdev = platform_device_register_simple("tpm_atmel", -1, NULL, 0 ))) {
+	tpm_atmel.have_region =
+	    (atmel_request_region
+	     (tpm_atmel.base, tpm_atmel.region_size,
+	      "tpm_atmel0") == NULL) ? 0 : 1;
+
+	if (IS_ERR
+	    (pdev =
+	     platform_device_register_simple("tpm_atmel", -1, NULL, 0))) {
 		rc = PTR_ERR(pdev);
 		goto err_rel_reg;
 	}
@@ -202,9 +206,10 @@ static int __init init_atmel(void)
 err_unreg_dev:
 	platform_device_unregister(pdev);
 err_rel_reg:
-	if (tpm_atmel.have_region)
-		atmel_release_region(tpm_atmel.base, tpm_atmel.region_size);
 	atmel_put_base_addr(&tpm_atmel);
+	if (tpm_atmel.have_region)
+		atmel_release_region(tpm_atmel.base,
+				     tpm_atmel.region_size);
 err_unreg_drv:
 	driver_unregister(&atml_drv);
 	return rc;
--- linux-2.6.15-rc1/drivers/char/tpm/tpm_atmel.h	2005-11-16 16:02:31.000000000 +0100
+++ linux-2.6.15-rc1-git4/drivers/char/tpm/tpm_atmel.h	2005-11-16 15:43:26.000000000 +0100
@@ -27,12 +27,14 @@
 #define atmel_putb(val, chip, offset) writeb(val, chip->vendor->iobase + offset)
 #define atmel_request_region request_mem_region
 #define atmel_release_region release_mem_region
-static inline void atmel_put_base_addr(struct tpm_vendor_specific *vendor)
+
+static inline void atmel_put_base_addr(struct tpm_vendor_specific
+					 *vendor)
 {
 	iounmap(vendor->iobase);
 }
 
-static int atmel_get_base_addr(struct tpm_vendor_specific *vendor)
+static void __iomem * atmel_get_base_addr(struct tpm_vendor_specific *vendor)
 {
 	struct device_node *dn;
 	unsigned long address, size;
@@ -44,11 +46,11 @@ static int atmel_get_base_addr(struct tp
 	dn = of_find_node_by_name(NULL, "tpm");
 
 	if (!dn)
-		return 1;
+		return NULL;
 
 	if (!device_is_compatible(dn, "AT97SC3201")) {
 		of_node_put(dn);
-		return 1;
+		return NULL;
 	}
 
 	reg = (unsigned int *) get_property(dn, "reg", &reglen);
@@ -71,8 +73,7 @@ static int atmel_get_base_addr(struct tp
 
 	vendor->base = address;
 	vendor->region_size = size;
-	vendor->iobase = ioremap(address, size);
-	return 0;
+	return ioremap(vendor->base, vendor->region_size);
 }
 #else
 #define atmel_getb(chip, offset) inb(chip->vendor->base + offset)
@@ -105,18 +106,19 @@ static int atmel_verify_tpm11(void)
 	return 0;
 }
 
-static inline void atmel_put_base_addr(struct tpm_vendor_specific *vendor)
+static inline void atmel_put_base_addr(struct tpm_vendor_specific
+					 *vendor)
 {
 }
 
 /* Determine where to talk to device */
-static unsigned long atmel_get_base_addr(struct tpm_vendor_specific
+static void __iomem * atmel_get_base_addr(struct tpm_vendor_specific
 					 *vendor)
 {
 	int lo, hi;
 
 	if (atmel_verify_tpm11() != 0)
-		return 1;
+		return NULL;
 
 	lo = tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_LO);
 	hi = tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_HI);
@@ -124,6 +126,6 @@ static unsigned long atmel_get_base_addr
 	vendor->base = (hi << 8) | lo;
 	vendor->region_size = 2;
 
-	return 0;
+	return ioport_map(vendor->base, vendor->region_size);
 }
 #endif


