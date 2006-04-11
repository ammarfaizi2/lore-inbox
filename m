Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWDKWlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWDKWlf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 18:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWDKWlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 18:41:35 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:6848 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751264AbWDKWle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 18:41:34 -0400
Subject: [PATCH] tpm: use clear_bit
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
In-Reply-To: <20060410145030.0b719e18.akpm@osdl.org>
References: <1144679828.4917.11.camel@localhost.localdomain>
	 <20060410145030.0b719e18.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 11 Apr 2006 17:42:25 -0500
Message-Id: <1144795345.12054.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-10 at 14:50 -0700, Andrew Morton wrote:
> Kylene Jo Hall <kjhall@us.ibm.com> wrote:
> >
> > +	dev_mask[chip->dev_num / TPM_NUM_MASK_ENTRIES] &=
> >  +	    ~(1 << (chip->dev_num % TPM_NUM_MASK_ENTRIES));
> 
> If you were to make dev_mask[] an array of longs, this could perhaps become
> 
> 	clear_bit(dev_mask, chip->dev_num);
> 

Use set_bit and clear_bit for dev_mask manipulation.

Signed-off-by: Kylie Hall <kjhall@us.ibm.com>
---
 drivers/char/tpm/tpm.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

--- linux-2.6.17-rc1-mm2/drivers/char/tpm/tpm.c	2006-04-11 17:30:57.612009250 -0500
+++ linux-2.6.17-rc1/drivers/char/tpm/tpm.c	2006-04-11 17:47:23.097598250 -0500
@@ -32,7 +32,7 @@ enum tpm_const {
 	TPM_MINOR = 224,	/* officially assigned */
 	TPM_BUFSIZE = 2048,
 	TPM_NUM_DEVICES = 256,
-	TPM_NUM_MASK_ENTRIES = TPM_NUM_DEVICES / (8 * sizeof(int))
+	TPM_NUM_MASK_ENTRIES = TPM_NUM_DEVICES / (8 * sizeof(unsigned long))
 };
 
 enum tpm_duration {
@@ -48,7 +48,7 @@ enum tpm_duration {
 
 static LIST_HEAD(tpm_chip_list);
 static DEFINE_SPINLOCK(driver_lock);
-static int dev_mask[TPM_NUM_MASK_ENTRIES];
+static unsigned long dev_mask[TPM_NUM_MASK_ENTRIES];
 
 /*
  * Array with one entry per ordinal defining the maximum amount
@@ -1033,8 +1033,7 @@ void tpm_remove_hardware(struct device *
 	sysfs_remove_group(&dev->kobj, chip->vendor.attr_group);
 	tpm_bios_log_teardown(chip->bios_dir);
 
-	dev_mask[chip->dev_num / TPM_NUM_MASK_ENTRIES] &=
-	    ~(1 << (chip->dev_num % TPM_NUM_MASK_ENTRIES));
+	clear_bit(chip->dev_num , dev_mask);
 
 	kfree(chip);
 
@@ -1118,7 +1117,7 @@ struct tpm_chip *tpm_register_hardware(s
 			if ((dev_mask[i] & (1 << j)) == 0) {
 				chip->dev_num =
 				    i * TPM_NUM_MASK_ENTRIES + j;
-				dev_mask[i] |= 1 << j;
+				set_bit(chip->dev_num, dev_mask);
 				goto dev_num_search_complete;
 			}
 


