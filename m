Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWDSTRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWDSTRe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWDSTRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:17:34 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:29347 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751181AbWDSTRd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:17:33 -0400
Subject: [PATCH] tpm: fix ordering bug in error path
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 14:13:35 -0500
Message-Id: <1145474015.4894.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The clear_bit of chip->dev_num ended up after the kfree of chip in the
error path of the tpm_register_hardware function.  This patch fixes
things to avoid a potential segmentation fault.

This bug was found by Coverity.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
 drivers/char/tpm/tpm.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17-rc1/drivers/char/tpm/tpm.c	2006-04-18 15:14:45.630390500 -0500
+++ linux-2.6.17-rc1-tpm/drivers/char/tpm/tpm.c	2006-04-19 13:17:51.363688750 -0500
@@ -1139,8 +1139,8 @@ struct tpm_chip *tpm_register_hardware(s
 			chip->vendor.miscdev.name,
 			chip->vendor.miscdev.minor);
 		put_device(dev);
-		kfree(chip);
 		clear_bit(chip->dev_num, dev_mask);
+		kfree(chip);
 		return NULL;
 	}
 


