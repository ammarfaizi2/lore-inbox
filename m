Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265835AbTL3WGY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265832AbTL3WGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:06:24 -0500
Received: from mail.kroah.org ([65.200.24.183]:41665 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265917AbTL3WGW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:06:22 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.0
In-Reply-To: <1072821970466@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Dec 2003 14:06:10 -0800
Message-Id: <1072821970727@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1496.23.2, 2003/12/19 11:37:00-08:00, trini@kernel.crashing.org

[PATCH] I2C: make i2c-piix4 fix optional

On Thu, Dec 18, 2003 at 10:26:40AM -0800, Greg KH wrote:


 drivers/i2c/busses/i2c-piix4.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Tue Dec 30 12:29:37 2003
+++ b/drivers/i2c/busses/i2c-piix4.c	Tue Dec 30 12:29:37 2003
@@ -99,6 +99,13 @@
 		 "Forcibly enable the PIIX4 at the given address. "
 		 "EXTREMELY DANGEROUS!");
 
+/* If fix_hstcfg is set to anything different from 0, we reset one of the
+   registers to be a valid value. */
+static int fix_hstcfg = 0;
+MODULE_PARM(fix_hstcfg, "i");
+MODULE_PARM_DESC(fix_hstcfg,
+		"Fix config register. Needed on some boards (Force CPCI735).");
+
 static int piix4_transaction(void);
 
 
@@ -164,9 +171,17 @@
 	/* Some BIOS will set up the chipset incorrectly and leave a register
 	   in an undefined state (causing I2C to act very strangely). */
 	if (temp & 0x02) {
-		dev_info(&PIIX4_dev->dev, "Worked around buggy BIOS (I2C)\n");
-		temp = temp & 0xfd;
-		pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp);
+		if (fix_hstcfg) {
+			dev_info(&PIIX4_dev->dev, "Working around buggy BIOS "
+					"(I2C)\n");
+			temp &= 0xfd;
+			pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp);
+		} else {
+			dev_info(&PIIX4_dev->dev, "Unusual config register "
+					"value\n");
+			dev_info(&PIIX4_dev->dev, "Try using fix_hstcfg=1 if "
+					"you experience problems\n");
+		}
 	}
  
 	/* If force_addr is set, we program the new address here. Just to make

