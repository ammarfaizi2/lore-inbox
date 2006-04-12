Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWDLVrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWDLVrL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 17:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWDLVrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 17:47:11 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:54736 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932326AbWDLVrJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 17:47:09 -0400
Subject: [PATCH] tpm: use find_first_zero_bit
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
In-Reply-To: <20060411160206.4bffa1c2.akpm@osdl.org>
References: <1144679828.4917.11.camel@localhost.localdomain>
	 <20060410145030.0b719e18.akpm@osdl.org>
	 <1144795345.12054.36.camel@localhost.localdomain>
	 <20060411160206.4bffa1c2.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 12 Apr 2006 16:47:59 -0500
Message-Id: <1144878479.12054.91.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-11 at 16:02 -0700, Andrew Morton wrote:
> -			}
> +	/* This should use find_first_zero_bit() */
> +	for (dev_num = 0; dev_num < TPM_NUM_DEVICES; dev_num++) {

Given the suggestion in the code of your use-clear_bit-fix.  This patch
uses find_first_zero_bit to find a bit instead of the roll my own for
loop solution.

Signed-off-by: Kylie Hall <kjhall@us.ibm.com>
---
 drivers/char/tpm/tpm.c |   20 ++++++--------------
 1 files changed, 6 insertions(+), 14 deletions(-)

--- linux-2.6.17-rc1-mm2/drivers/char/tpm/tpm.c	2006-04-12 11:46:18.375300250 -0500
+++ linux-2.6.17-rc1/drivers/char/tpm/tpm.c	2006-04-12 12:34:41.692746250 -0500
@@ -1090,7 +1090,6 @@ struct tpm_chip *tpm_register_hardware(s
 
 	char *devname;
 	struct tpm_chip *chip;
-	int dev_num;
 
 	/* Driver specific per-device data */
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
@@ -1109,18 +1108,9 @@ struct tpm_chip *tpm_register_hardware(s
 
 	memcpy(&chip->vendor, entry, sizeof(struct tpm_vendor_specific));
 
-	chip->dev_num = -1;
-
-	/* This should use find_first_zero_bit() */
-	for (dev_num = 0; dev_num < TPM_NUM_DEVICES; dev_num++) {
-		if (!test_bit(dev_num, dev_mask)) {
-			chip->dev_num = dev_num;
-			set_bit(dev_num, dev_mask);
-			break;
-		}
-	}
-
-	if (chip->dev_num < 0) {
+	chip->dev_num = find_first_zero_bit(dev_mask, TPM_NUM_DEVICES);
+	
+	if (chip->dev_num < 0 || chip->dev_num > TPM_NUM_DEVICES) {
 		dev_err(dev, "No available tpm device numbers\n");
 		kfree(chip);
 		return NULL;
@@ -1129,6 +1119,8 @@ struct tpm_chip *tpm_register_hardware(s
 	else
 		chip->vendor.miscdev.minor = MISC_DYNAMIC_MINOR;
 
+	set_bit(chip->dev_num, dev_mask);
+
 	devname = kmalloc(DEVNAME_SIZE, GFP_KERNEL);
 	scnprintf(devname, DEVNAME_SIZE, "%s%d", "tpm", chip->dev_num);
 	chip->vendor.miscdev.name = devname;
@@ -1143,7 +1135,7 @@ struct tpm_chip *tpm_register_hardware(s
 			chip->vendor.miscdev.minor);
 		put_device(dev);
 		kfree(chip);
-		clear_bit(dev_num, dev_mask);
+		clear_bit(chip->dev_num, dev_mask);
 		return NULL;
 	}
 


