Return-Path: <linux-kernel-owner+w=401wt.eu-S1751229AbXAORum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbXAORum (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 12:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbXAORum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 12:50:42 -0500
Received: from wr-out-0506.google.com ([64.233.184.225]:31349 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbXAORul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 12:50:41 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=GgF/wojU5sdmyl3Gktz5LiTApiExifZOb19ZQ9InDh/kyH0pHLfKQgjgfjLZDnwDkdmMU49H+oX7CH27Ce0abz5LMOur85fuzS0Q1p4WYL/rzvJ+PabcblwfWv1KYzNTQTJaKYelK89WGQ9vU+Fv9ZYtAK6u94Y3Ees/apYhzz0=
Date: Mon, 15 Jan 2007 19:50:23 +0200
To: greg@kroah.com
Cc: jgarzik@pobox.com, arjan@infradead.org, linux-kernel@vger.kernel.org,
       trivial@kernel.org
Subject: Re: [PATCH 2.6.20-rc5] intel_rng: substitue magic PCI IDs with macros
Message-ID: <20070115175023.GA29070@Ahmed>
Mail-Followup-To: greg@kroah.com, jgarzik@pobox.com, arjan@infradead.org,
	linux-kernel@vger.kernel.org, trivial@kernel.org
References: <20070114172421.GA3874@Ahmed> <1168796241.3123.954.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168796241.3123.954.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2007 at 04:29:48PM -0800, Greg KH wrote:
> Why not use the PCI_DEVICE() macro too? It should make the lines even
> smaller.

Hi all, Here's the updated patch. 

Substitue magic values used in the PCI IDs table with macros defined in 
pci_ids.h + using the PCI_DEVICE macro.

Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
---

I've used a script to generate that patch, then checked the results manually
to make sure that it's (hopefully) correct.

#!/bin/bash

INTEL_RNG_FILE=drivers/char/hw_random/intel-rng.c
TMP_FILE=$(mktemp)
# File to hold Magic PCI deviceIDs in the "pci_device_id pci_tbl[]"
MAGIC_DEVICE_IDS=$(mktemp)

# All pci_tbl[] contents begin with a "{ 0x8086"
grep "{ 0x8086"  drivers/char/hw_random/intel-rng.c > $TMP_FILE
awk ' { print $3 } ' $TMP_FILE | cut -d, -f1 | grep "0x" > $MAGIC_DEVICE_IDS

sed -i "s/{ 0x8086/{ PCI_VENDOR_ID_INTEL/g" $INTEL_RNG_FILE

# For each magic number in MAGIC_DEVICE_IDS, find its defined macro 
# in pci_ids.h then use it in the PCI IDs table.

for i in $(cat $MAGIC_DEVICE_IDS); do 
    macro=$(grep "PCI_DEVICE_ID" include/linux/pci_ids.h | grep "$i" | awk ' { print $2 } ')
    if [[ -n "$macro" ]] ; then
	sed -i "s/{ PCI_VENDOR_ID_INTEL, ${i},.*}/{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, ${macro}) }/" \
	    $INTEL_RNG_FILE
    else
	sed -i "s/{ PCI_VENDOR_ID_INTEL, ${i},.*}/{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, ${i}) }/" \
	    $INTEL_RNG_FILE
    fi
done

rm -f $TMP_FILE
rm -f $MAGIC_DEVICE_IDS

diff --git a/drivers/char/hw_random/intel-rng.c b/drivers/char/hw_random/intel-rng.c
index f22e78e..d25d5e1 100644
--- a/drivers/char/hw_random/intel-rng.c
+++ b/drivers/char/hw_random/intel-rng.c
@@ -96,49 +96,49 @@
  */
 static const struct pci_device_id pci_tbl[] = {
 /* AA
-	{ 0x8086, 0x2418, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, */
-	{ 0x8086, 0x2410, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* AA */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_8) }, */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0) },
 /* AB
-	{ 0x8086, 0x2428, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, */
-	{ 0x8086, 0x2420, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* AB */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_8) }, */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0) },
 /* ??
-	{ 0x8086, 0x2430, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2430) }, */
 /* BAM, CAM, DBM, FBM, GxM
-	{ 0x8086, 0x2448, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, */
-	{ 0x8086, 0x244c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* BAM */
-	{ 0x8086, 0x248c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* CAM */
-	{ 0x8086, 0x24cc, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* DBM */
-	{ 0x8086, 0x2641, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* FBM */
-	{ 0x8086, 0x27b9, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* GxM */
-	{ 0x8086, 0x27bd, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* GxM DH */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_6) }, */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_12) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_1) }, 
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_1) }, 
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_31) },
 /* BA, CA, DB, Ex, 6300, Fx, 631x/632x, Gx
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
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_11) }, */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_0) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_1) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_0) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB2_0) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2671) }, /* 631x/632x */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2672) }, /* 631x/632x */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2673) }, /* 631x/632x */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2674) }, /* 631x/632x */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2675) }, /* 631x/632x */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2676) }, /* 631x/632x */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2677) }, /* 631x/632x */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2678) }, /* 631x/632x */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2679) }, /* 631x/632x */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x267a) }, /* 631x/632x */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x267b) }, /* 631x/632x */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x267c) }, /* 631x/632x */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x267d) }, /* 631x/632x */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x267e) }, /* 631x/632x */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x267f) }, /* 631x/632x */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_0) },
 /* E
-	{ 0x8086, 0x245e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, */
-	{ 0x8086, 0x2450, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* E  */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x245e) }, */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801E_0) },
 	{ 0, },	/* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, pci_tbl);


-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
