Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265434AbTFRSSW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 14:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265407AbTFRSPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 14:15:40 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:60562 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265408AbTFRSLt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 14:11:49 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10559607091816@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.72
In-Reply-To: <10559607092693@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 18 Jun 2003 11:25:09 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1318.3.8, 2003/06/17 15:37:40-07:00, greg@kroah.com

I2C: fix resource leak in i2c-ali15x3.c


 drivers/i2c/busses/i2c-ali15x3.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c	Wed Jun 18 11:19:16 2003
+++ b/drivers/i2c/busses/i2c-ali15x3.c	Wed Jun 18 11:19:16 2003
@@ -177,17 +177,18 @@
 	if(force_addr) {
 		dev_info(&ALI15X3_dev->dev, "forcing ISA address 0x%04X\n",
 			ali15x3_smba);
-		if (PCIBIOS_SUCCESSFUL !=
-		    pci_write_config_word(ALI15X3_dev, SMBBA, ali15x3_smba))
-			return -ENODEV;
-		if (PCIBIOS_SUCCESSFUL !=
-		    pci_read_config_word(ALI15X3_dev, SMBBA, &a))
-			return -ENODEV;
+		if (PCIBIOS_SUCCESSFUL != pci_write_config_word(ALI15X3_dev,
+								SMBBA,
+								ali15x3_smba))
+			goto error;
+		if (PCIBIOS_SUCCESSFUL != pci_read_config_word(ALI15X3_dev,
+								SMBBA, &a))
+			goto error;
 		if ((a & ~(ALI15X3_SMB_IOSIZE - 1)) != ali15x3_smba) {
 			/* make sure it works */
 			dev_err(&ALI15X3_dev->dev,
 				"force address failed - not supported?\n");
-			return -ENODEV;
+			goto error;
 		}
 	}
 	/* check if whole device is enabled */
@@ -219,6 +220,9 @@
 	dev_dbg(&ALI15X3_dev->dev, "iALI15X3_smba = 0x%X\n", ali15x3_smba);
 
 	return 0;
+error:
+	release_region(ali15x3_smba, ALI15X3_SMB_IOSIZE);
+	return -ENODEV;
 }
 
 /* Internally used pause function */

