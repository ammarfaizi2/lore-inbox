Return-Path: <linux-kernel-owner+w=401wt.eu-S1751395AbXANRYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbXANRYc (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 12:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbXANRYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 12:24:31 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:42958 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395AbXANRYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 12:24:31 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent:from;
        b=qiOZI9bsykfd7kKLml3CIxqse5GC2s9c3AfU+LbNWsmUC94gJUViYyMb3zbbxWXTeGIDVurisfxxkdkF3qTCefZsHzFjXQYrdh9cUaD9SNLMxTXFC/drlwaNwLsZ5+Un01P7ldGvDISUI7JPah6WR8r19wXrBsUGfzUkM7g4Ijs=
Date: Sun, 14 Jan 2007 19:24:21 +0200
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.20-rc5] intel_rng: substitue magic PCI IDs with macros
Message-ID: <20070114172421.GA3874@Ahmed>
Mail-Followup-To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Substitue intel_rng magic PCI IDs values used in the IDs table
with the macros defined in pci_ids.h


Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
---

I've used a small script to generate this patch then manually tried to 
make sure it's (hopefully) correct. 

#!/bin/bash

INTEL_RNG_FILE=drivers/char/hw_random/intel-rng.c
TMP_FILE=$(mktemp)
MAGIC_NUMS_FILE=$(mktemp)

# grep the contents of "pci_device_id pci_tbl[]"
grep "{ 0x8086"  drivers/char/hw_random/intel-rng.c > $TMP_FILE
# Extract the magic numbers to be replaced
cat $TMP_FILE | awk ' { print $3 } ' | cut -d, -f1 | grep "0x" > $MAGIC_NUMS_FILE

sed -i "s/0x8086/PCI_VENDOR_ID_INTEL/g" $INTEL_RNG_FILE

# For each magic number in MAGIC_NUMS_FILE, find its defined macro 
# in pci_ids.h then replace them.

for i in $(cat $MAGIC_NUMS_FILE); do 
    var=$(grep "PCI_DEVICE_ID" include/linux/pci_ids.h | grep "$i" | awk ' { print $2 } ')
    if [[ -n "$var" ]] ; then
	# sed: Side effect of replacing the magic number in the whole file
	# Collisions with other magics belonging to another family ?
	# Manual checking reveals no bad collisions happen.
	sed -i "s/${i}/${var}/g" $INTEL_RNG_FILE
    fi
done

rm -f $TMP_FILE
rm -f $MAGIC_NUMS_FILE

diff --git a/drivers/char/hw_random/intel-rng.c b/drivers/char/hw_random/intel-rng.c
index f22e78e..85b0374 100644
--- a/drivers/char/hw_random/intel-rng.c
+++ b/drivers/char/hw_random/intel-rng.c
@@ -95,50 +95,96 @@
  * want to register another driver on the same PCI id.
  */
 static const struct pci_device_id pci_tbl[] = {
-/* AA
-	{ 0x8086, 0x2418, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, */
-	{ 0x8086, 0x2410, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* AA */
-/* AB
-	{ 0x8086, 0x2428, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, */
-	{ 0x8086, 0x2420, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* AB */
-/* ??
-	{ 0x8086, 0x2430, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, */
-/* BAM, CAM, DBM, FBM, GxM
-	{ 0x8086, 0x2448, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, */
-	{ 0x8086, 0x244c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* BAM */
-	{ 0x8086, 0x248c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* CAM */
-	{ 0x8086, 0x24cc, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* DBM */
-	{ 0x8086, 0x2641, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* FBM */
-	{ 0x8086, 0x27b9, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* GxM */
-	{ 0x8086, 0x27bd, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* GxM DH */
-/* BA, CA, DB, Ex, 6300, Fx, 631x/632x, Gx
-	{ 0x8086, 0x244e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, */
-	{ 0x8086, 0x2440, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* BA */
-	{ 0x8086, 0x2480, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* CA */
-	{ 0x8086, 0x24c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* DB */
-	{ 0x8086, 0x24d0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* Ex */
-	{ 0x8086, 0x25a1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 6300 */
-	{ 0x8086, 0x2640, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* Fx */
-	{ 0x8086, 0x2670, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
-	{ 0x8086, 0x2671, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
-	{ 0x8086, 0x2672, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
-	{ 0x8086, 0x2673, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
-	{ 0x8086, 0x2674, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
-	{ 0x8086, 0x2675, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
-	{ 0x8086, 0x2676, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
-	{ 0x8086, 0x2677, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
-	{ 0x8086, 0x2678, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
-	{ 0x8086, 0x2679, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
-	{ 0x8086, 0x267a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
-	{ 0x8086, 0x267b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
-	{ 0x8086, 0x267c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
-	{ 0x8086, 0x267d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
-	{ 0x8086, 0x267e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
-	{ 0x8086, 0x267f, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
-	{ 0x8086, 0x27b8, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* Gx */
-/* E
-	{ 0x8086, 0x245e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, */
-	{ 0x8086, 0x2450, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* E  */
+/* 
+ * AA
+ *	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_8, PCI_ANY_ID, 
+ *	PCI_ANY_ID, 0, 0, 0, }, 
+ */
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0, PCI_ANY_ID,
+	  PCI_ANY_ID, 0, 0, 0, },
+/* 
+ * AB
+ *	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_8, PCI_ANY_ID, 
+ *	PCI_ANY_ID, 0, 0, 0, }, 
+ */
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0, PCI_ANY_ID, 
+	  PCI_ANY_ID, 0, 0, 0, },
+/* 
+ * ??
+ *	{ PCI_VENDOR_ID_INTEL, 0x2430, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, 
+ *
+ * BAM, CAM, DBM, FBM, GxM
+ *	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_6, PCI_ANY_ID, 
+ *	PCI_ANY_ID, 0, 0, 0, }, 
+ */
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10, PCI_ANY_ID,
+	  PCI_ANY_ID, 0, 0, 0, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12, PCI_ANY_ID,
+	  PCI_ANY_ID, 0, 0, 0, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_12, PCI_ANY_ID,
+	  PCI_ANY_ID, 0, 0, 0, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_1, PCI_ANY_ID, 
+	  PCI_ANY_ID, 0, 0, 0, }, /* FBM */
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_1, PCI_ANY_ID, 
+	  PCI_ANY_ID, 0, 0, 0, }, /* GxM */
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_31, PCI_ANY_ID, 
+	  PCI_ANY_ID, 0, 0, 0, }, /* GxM DH */
+/*
+ * BA, CA, DB, Ex, 6300, Fx, 631x/632x, Gx
+ *	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_11, PCI_ANY_ID, 
+ *	PCI_ANY_ID, 0, 0, 0, }, 
+ */
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0, PCI_ANY_ID, 
+	  PCI_ANY_ID, 0, 0, 0, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_0, PCI_ANY_ID, 
+	  PCI_ANY_ID, 0, 0, 0, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0, PCI_ANY_ID, 
+	  PCI_ANY_ID, 0, 0, 0, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0, PCI_ANY_ID, 
+	  PCI_ANY_ID, 0, 0, 0, }, /* Ex */
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_1, PCI_ANY_ID, 
+	  PCI_ANY_ID, 0, 0, 0, }, /* 6300 */
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_0, PCI_ANY_ID,
+	  PCI_ANY_ID, 0, 0, 0, }, /* Fx */
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB2_0, PCI_ANY_ID,
+	  PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
+	{ PCI_VENDOR_ID_INTEL, 0x2671, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	{ PCI_VENDOR_ID_INTEL, 0x2672, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, 
+	/* 631x/632x */
+	{ PCI_VENDOR_ID_INTEL, 0x2673, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, 
+        /* 631x/632x */
+	{ PCI_VENDOR_ID_INTEL, 0x2674, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	/* 631x/632x */
+	{ PCI_VENDOR_ID_INTEL, 0x2675, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	/* 631x/632x */
+	{ PCI_VENDOR_ID_INTEL, 0x2676, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	/* 631x/632x */
+	{ PCI_VENDOR_ID_INTEL, 0x2677, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	/* 631x/632x */
+	{ PCI_VENDOR_ID_INTEL, 0x2678, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	/* 631x/632x */
+	{ PCI_VENDOR_ID_INTEL, 0x2679, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	/* 631x/632x */
+	{ PCI_VENDOR_ID_INTEL, 0x267a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	/* 631x/632x */
+	{ PCI_VENDOR_ID_INTEL, 0x267b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	/* 631x/632x */
+	{ PCI_VENDOR_ID_INTEL, 0x267c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	/* 631x/632x */
+	{ PCI_VENDOR_ID_INTEL, 0x267d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, 
+	/* 631x/632x */
+	{ PCI_VENDOR_ID_INTEL, 0x267e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	/* 631x/632x */
+	{ PCI_VENDOR_ID_INTEL, 0x267f, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	/* 631x/632x */
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_0, PCI_ANY_ID, 
+	  PCI_ANY_ID, 0, 0, 0, }, /* Gx */
+/* 
+ * E
+ *	{ PCI_VENDOR_ID_INTEL, 0x245e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, 
+ */
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801E_0, PCI_ANY_ID, 
+	  PCI_ANY_ID, 0, 0, 0, }, /* E  */
 	{ 0, },	/* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, pci_tbl);
@@ -251,7 +297,7 @@ static int __init mod_init(void)
 	}
 
 	/* Check for Intel 82802 */
-	if (dev->device < 0x2640) {
+	if (dev->device < PCI_DEVICE_ID_INTEL_ICH6_0) {
 		fwh_dec_en1_off = FWH_DEC_EN1_REG_OLD;
 		bios_cntl_off = BIOS_CNTL_REG_OLD;
 	} else {

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
