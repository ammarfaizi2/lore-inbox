Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbVHIVNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbVHIVNS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 17:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVHIVNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 17:13:18 -0400
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:54801 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S964970AbVHIVNR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 17:13:17 -0400
Date: Tue, 9 Aug 2005 23:13:28 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: I2C block reads with i2c-viapro: testers wanted
Message-Id: <20050809231328.0726537b.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am implementing I2C block reads in the i2c-viapro driver, and am
looking for testers. I was able to test on my own VT8237R chip, it works
OK, now I'd need to know how it works on older VIA south bridges, namely
the VT8235 and the VT82C686B. South bridges before that (VT82C686A,
VT8233A and older) are supposed not to work according to the datasheets,
but a confirmation would be welcome, who knows, it might simply not be
documented.

My experimental patch follows. I have enabled the I2C block read
function for all VIA south bridges, so that it can be tested on all
chips. I'll restrict that after the test phase, of course.

The easiest way to test the patch is to use i2c-viapro in conjunction
with the eeprom driver. This supposes that you do actually have a VIA
south bridge with EEPROMs (typically SPD) on the SMBus. If not, you
won't be able to test, sorry.

In order to verify whether I2C block reads work for you, just compare
the contents of this file:
  /sys/bus/i2c/devices/0-0050/eeprom
before and after applying the patch (and cycling i2c-viapro, obviously).
If it works, the contents should be identical. Note that the bus number
(0 above) and exact address (0050 above) may change depending on the
hardware setup.

You can also use lm_sensors' utilities to test the I2C block read
function: i2cdump has an I2C block mode ("i"), and even "sensors" will
display the SPD information. If it's correct after applying the patch,
it means that the I2C block read function is working OK for you.

On my system, the dump is down from over 2 seconds without the patch to
below 0.2 second with the patch, which proves how efficient I2C block
reads are and explains why I want to implement this function.

Thanks.

 drivers/i2c/busses/i2c-viapro.c |   40 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 38 insertions(+), 2 deletions(-)

--- linux-2.6.13-rc6.orig/drivers/i2c/busses/i2c-viapro.c	2005-08-08 18:55:48.000000000 +0200
+++ linux-2.6.13-rc6/drivers/i2c/busses/i2c-viapro.c	2005-08-09 22:52:56.000000000 +0200
@@ -88,6 +88,7 @@
 #define VT596_BYTE_DATA  0x08
 #define VT596_WORD_DATA  0x0C
 #define VT596_BLOCK_DATA 0x14
+#define VT596_I2C_BLOCK_DATA	0x34
 
 
 /* If force is set to anything different from 0, we forcibly enable the
@@ -107,6 +108,9 @@
 
 static struct i2c_adapter vt596_adapter;
 
+#define FEATURE_I2CBLOCK	(1<<0)
+static int vt596_features;
+
 /* Another internally used function */
 static int vt596_transaction(void)
 {
@@ -242,9 +246,21 @@
 		}
 		size = VT596_BLOCK_DATA;
 		break;
+	case I2C_SMBUS_I2C_BLOCK_DATA:
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		outb_p(command, SMBHSTCMD);
+		if (read_write == I2C_SMBUS_WRITE) {
+			dev_warn(&vt596_adapter.dev,
+				 "I2C block write not supported!\n");
+			return -1;
+		}
+		outb_p(I2C_SMBUS_BLOCK_MAX, SMBHSTDAT0);
+		size = VT596_I2C_BLOCK_DATA;
+		break;
 	}
 
-	outb_p((size & 0x1C) + (ENABLE_INT9 & 1), SMBHSTCNT);
+	outb_p((size & 0x3C) + (ENABLE_INT9 & 1), SMBHSTCNT);
 
 	if (vt596_transaction()) /* Error in transaction */
 		return -1;
@@ -267,6 +283,7 @@
 		data->word = inb_p(SMBHSTDAT0) + (inb_p(SMBHSTDAT1) << 8);
 		break;
 	case VT596_BLOCK_DATA:
+	case VT596_I2C_BLOCK_DATA:
 		data->block[0] = inb_p(SMBHSTDAT0);
 		if (data->block[0] > I2C_SMBUS_BLOCK_MAX)
 			data->block[0] = I2C_SMBUS_BLOCK_MAX;
@@ -280,9 +297,15 @@
 
 static u32 vt596_func(struct i2c_adapter *adapter)
 {
-	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+	u32 func = I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
 	    I2C_FUNC_SMBUS_BLOCK_DATA;
+
+#if 0
+	if (vt596_features & FEATURE_I2CBLOCK)
+#endif
+		func |= I2C_FUNC_SMBUS_READ_I2C_BLOCK;
+	return func;
 }
 
 static struct i2c_algorithm smbus_algorithm = {
@@ -391,6 +414,19 @@
 		vt596_pdev = NULL;
 	}
 
+	if (pdev->device == PCI_DEVICE_ID_VIA_8235
+	 || pdev->device == PCI_DEVICE_ID_VIA_8237) {
+		vt596_features |= FEATURE_I2CBLOCK;
+	} else if (pdev->device == PCI_DEVICE_ID_VIA_82C686_4) {
+		u8 rev;
+
+		/* VT82C686B (rev 0x40) does support I2C block mode, but
+		   VT82C686A (rev 0x30) doesn't. */
+		if (!pci_read_config_byte(pdev, PCI_REVISION_ID, &rev)
+		 && rev >= 0x40)
+			vt596_features |= FEATURE_I2CBLOCK;
+	}
+
 	/* Always return failure here.  This is to allow other drivers to bind
 	 * to this pci device.  We don't really want to have control over the
 	 * pci device, we only wanted to read as few register values from it.


-- 
Jean Delvare
