Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVDDVWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVDDVWl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 17:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVDDVTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 17:19:46 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:42212 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261391AbVDDVRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 17:17:52 -0400
Subject: Re: iomapping a big endian area
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050403013757.GB24234@parcelfarce.linux.theplanet.co.uk>
References: <1112475134.5786.29.camel@mulgrave>
	 <20050403013757.GB24234@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 16:17:45 -0500
Message-Id: <1112649465.5813.106.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I sent the patch off to Andrew.  To complete the original problem,
the attached is the patch that uses it in the parisc lasi driver
(although, actually, it sets up 53c700 to work everywhere including BE
on a LE system).

I changed some of the flags around to reflect the fact that we now have
generic BE support in the driver (rather than the more limited
force_le_on_be flag).

James

===== drivers/scsi/53c700.h 1.25 vs edited =====
--- 1.25/drivers/scsi/53c700.h	2005-04-04 09:55:44 -05:00
+++ edited/drivers/scsi/53c700.h	2005-04-04 15:39:01 -05:00
@@ -177,10 +177,10 @@
 	struct device	*dev;
 	__u32	dmode_extra;	/* adjustable bus settings */
 	__u32	differential:1;	/* if we are differential */
-#ifdef CONFIG_53C700_LE_ON_BE
+#ifdef CONFIG_53C700_BE
 	/* This option is for HP only.  Set it if your chip is wired for
 	 * little endian on this platform (which is big endian) */
-	__u32	force_le_on_be:1;
+	__u32	chip_is_be:1;
 #endif
 	__u32	chip710:1;	/* set if really a 710 not 700 */
 	__u32	burst_disable:1;	/* set to 1 to disable 710 bursting */
@@ -229,24 +229,29 @@
 /*
  *	53C700 Register Interface - the offset from the Selected base
  *	I/O address */
-#ifdef CONFIG_53C700_LE_ON_BE
-#define bE	(hostdata->force_le_on_be ? 0 : 3)
-#define	bSWAP	(hostdata->force_le_on_be)
-/* This is terrible, but there's no raw version of ioread32.  That means
- * that on a be board we swap twice (once in ioread32 and once again to 
- * get the value correct) */
-#define bS_to_io(x)	((hostdata->force_le_on_be) ? (x) : cpu_to_le32(x))
-#elif defined(__BIG_ENDIAN)
+#ifdef CONFIG_53C700_BE
+#define bE	(hostdata->chip_is_be ? 3: 0)
+#ifdef __BIG_ENDIAN
+#define	bSWAP	(!hostdata->chip_is_be)
+#else
+#define bSWAP	(hostdata->chip_is_be);
+#endif
+#define NCR_ioread32(x)	((hostdata->chip_is_be) ? ioread32be(x) : ioread32(x))
+#define NCR_iowrite32(v, x) \
+	((hostdata->chip_is_be) ? iowrite32be((v), (x)) : iowrite32((v), (x)))
+#else
+#define NCR_ioread32(x)		ioread32(x)
+#define NCR_iowrite32(v, x)	iowrite32((v), (x))
+#if defined(__BIG_ENDIAN)
 #define bE	3
 #define bSWAP	0
-#define bS_to_io(x)	(x)
 #elif defined(__LITTLE_ENDIAN)
 #define bE	0
 #define bSWAP	0
-#define bS_to_io(x)	(x)
 #else
 #error "__BIG_ENDIAN or __LITTLE_ENDIAN must be defined, did you include byteorder.h?"
 #endif
+#endif
 #define bS_to_cpu(x)	(bSWAP ? le32_to_cpu(x) : (x))
 #define bS_to_host(x)	(bSWAP ? cpu_to_le32(x) : (x))
 
@@ -460,14 +465,13 @@
 {
 	const struct NCR_700_Host_Parameters *hostdata
 		= (struct NCR_700_Host_Parameters *)host->hostdata[0];
-	__u32 value = ioread32(hostdata->base + reg);
+	__u32 value = NCR_ioread32(hostdata->base + reg);
 #if 1
 	/* sanity check the register */
-	if((reg & 0x3) != 0)
-		BUG();
+	BUG_ON((reg & 0x3) != 0);
 #endif
 
-	return bS_to_io(value);
+	return value;
 }
 
 static inline void
@@ -487,11 +491,10 @@
 
 #if 1
 	/* sanity check the register */
-	if((reg & 0x3) != 0)
-		BUG();
+	BUG_ON((reg & 0x3) != 0);
 #endif
 
-	iowrite32(bS_to_io(value), hostdata->base + reg);
+	NCR_iowrite32(value, hostdata->base + reg);
 }
 
 #endif
===== drivers/scsi/Kconfig 1.88 vs edited =====
--- 1.88/drivers/scsi/Kconfig	2005-04-04 09:55:45 -05:00
+++ edited/drivers/scsi/Kconfig	2005-04-04 15:34:40 -05:00
@@ -951,7 +951,7 @@
 	  many PA-RISC workstations & servers.  If you do not know whether you
 	  have a Lasi chip, it is safe to say "Y" here.
 
-config 53C700_LE_ON_BE
+config 53C700_BE
 	bool
 	depends on SCSI_LASI700
 	default y
===== drivers/scsi/lasi700.c 1.27 vs edited =====
--- 1.27/drivers/scsi/lasi700.c	2005-04-04 09:55:45 -05:00
+++ edited/drivers/scsi/lasi700.c	2005-04-04 15:31:19 -05:00
@@ -117,15 +117,13 @@
 
 	if (dev->id.sversion == LASI_700_SVERSION) {
 		hostdata->clock = LASI700_CLOCK;
-		hostdata->force_le_on_be = 1;
+		hostdata->chip_is_be = 0;
 	} else {
 		hostdata->clock = LASI710_CLOCK;
-		hostdata->force_le_on_be = 0;
+		hostdata->chip_is_be = 1;
 		hostdata->chip710 = 1;
 		hostdata->dmode_extra = DMODE_FC2;
 	}
-
-	NCR_700_set_mem_mapped(hostdata);
 
 	host = NCR_700_detect(&lasi700_template, hostdata, &dev->dev);
 	if (!host)


