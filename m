Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263657AbVBCR4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263657AbVBCR4A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 12:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263652AbVBCRyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 12:54:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:15272 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262520AbVBCRlX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 12:41:23 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Fix i2c-sis5595 pci configuration accesses
In-Reply-To: <11074523383635@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Feb 2005 09:38:58 -0800
Message-Id: <11074523382465@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2045, 2005/02/03 00:30:21-08:00, khali@linux-fr.org

[PATCH] I2C: Fix i2c-sis5595 pci configuration accesses

The i2c-sis5595 bus driver has logic errors on pci configuration
accesses. It returns an error on success and vice versa. The 2.4 kernel
version of the driver, as found in the lm_sensors CVS repository, is
correct, so the problem was introducted when the driver was ported to
the 2.6 kernel tree  (in 2.6.0-test6). As odd as it sounds, the driver
has been sitting here broken and unusable for 17 months and nobody ever
reported, until yesterday.

Credits go to Sebastian Hesselbarth for discovering and analyzing the
problem.

Here is a patch that fixes the problem, succesfully tested by Aurelien
Jarno and Sebastian Hesselbarth. Please apply.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-sis5595.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
--- a/drivers/i2c/busses/i2c-sis5595.c	2005-02-03 09:34:55 -08:00
+++ b/drivers/i2c/busses/i2c-sis5595.c	2005-02-03 09:34:55 -08:00
@@ -181,9 +181,11 @@
 
 	if (force_addr) {
 		dev_info(&SIS5595_dev->dev, "forcing ISA address 0x%04X\n", sis5595_base);
-		if (!pci_write_config_word(SIS5595_dev, ACPI_BASE, sis5595_base))
+		if (pci_write_config_word(SIS5595_dev, ACPI_BASE, sis5595_base)
+		    != PCIBIOS_SUCCESSFUL)
 			goto error;
-		if (!pci_read_config_word(SIS5595_dev, ACPI_BASE, &a))
+		if (pci_read_config_word(SIS5595_dev, ACPI_BASE, &a)
+		    != PCIBIOS_SUCCESSFUL)
 			goto error;
 		if ((a & ~(SIS5595_EXTENT - 1)) != sis5595_base) {
 			/* doesn't work for some chips! */
@@ -192,13 +194,16 @@
 		}
 	}
 
-	if (!pci_read_config_byte(SIS5595_dev, SIS5595_ENABLE_REG, &val))
+	if (pci_read_config_byte(SIS5595_dev, SIS5595_ENABLE_REG, &val)
+	    != PCIBIOS_SUCCESSFUL)
 		goto error;
 	if ((val & 0x80) == 0) {
 		dev_info(&SIS5595_dev->dev, "enabling ACPI\n");
-		if (!pci_write_config_byte(SIS5595_dev, SIS5595_ENABLE_REG, val | 0x80))
+		if (pci_write_config_byte(SIS5595_dev, SIS5595_ENABLE_REG, val | 0x80)
+		    != PCIBIOS_SUCCESSFUL)
 			goto error;
-		if (!pci_read_config_byte(SIS5595_dev, SIS5595_ENABLE_REG, &val))
+		if (pci_read_config_byte(SIS5595_dev, SIS5595_ENABLE_REG, &val)
+		    != PCIBIOS_SUCCESSFUL)
 			goto error;
 		if ((val & 0x80) == 0) {
 			/* doesn't work for some chips? */

