Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263218AbVFXTR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263218AbVFXTR7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 15:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263190AbVFXTOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 15:14:37 -0400
Received: from smtp-105-friday.noc.nerim.net ([62.4.17.105]:40456 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S263183AbVFXTOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 15:14:15 -0400
Date: Fri, 24 Jun 2005 21:14:16 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Ben Gardner <BGardner@Wabtec.com>, Greg KH <greg@kroah.com>
Cc: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: New max6875 driver may corrupt EEPROMs
Message-Id: <20050624211416.7330b4d5.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After a careful code analysis on the new max6875 driver
(drivers/i2c/chips/max6875.c), I have come to the conclusion that this
driver may cause EEPROM corruptions if used on random systems.

The EEPROM part of the MAX6875 chip is accessed using rather uncommon
I2C sequences. What is seen by the MAX6875 as reads can be seen by a
standard EEPROM (24C02) as writes. If you check the detection method
used by the driver, you'll find that the first SMBus command it will
send on the bus is i2c_smbus_write_byte_data(client, 0x80, 0x40). For
the MAX6875 it makes an internal pointer point to a specific offset of
the EEPROM waiting for a subsequent read command, so it's not an actual
data write operation, but for a standard EEPROM, this instead means
writing value 0x40 to offset 0x80. Blame Philips and Intel for the
obscure protocol.

Since the MAX6875 and the standard, common 24C02 EEPROMs share two I2C
addresses (0x50 and 0x52), loading the max6875 driver on a system with
standard EEPROMs at either address will trigger a write on these
EEPROMs, which will lead to their corruption if they happen not to be
write protected. This kind of EEPROMs can be found on memory modules
(SPD), ethernet adapters (MAC address), laptops (proprietary data) and
displays (EDID/DDC). Most of these are hopefully write-protected, but
not all of them.

For this reason, I would recommend that the max6875 driver be
neutralized, in a way that nobody can corrupt his/her EEPROMs by just
loading the driver. This means either deleting the driver completely, or
not listing any default address for it. I'd like this to be done before
2.6.13-rc1 is released.

Additionally, the max6875 driver lacks the 24RF08 corruption preventer
present in the eeprom driver, which means that loading this driver in a
system with such a chip would corrupt it as well.

Here is a proposed quick patch addressing the issue, although I wouldn't
mind a complete removal if it makes everyone feel safer. I think Ben
has plans to replace this driver by a much simplified one anyway.

Thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/chips/max6875.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

--- linux-2.6.12-git5.orig/drivers/i2c/chips/max6875.c	2005-06-23 21:32:01.000000000 +0200
+++ linux-2.6.12-git5/drivers/i2c/chips/max6875.c	2005-06-24 21:05:37.000000000 +0200
@@ -37,7 +37,8 @@
 #include <linux/i2c-sensor.h>
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = {0x50, 0x52, I2C_CLIENT_END};
+/* No address scanned by default, as this could corrupt standard EEPROMS. */
+static unsigned short normal_i2c[] = {I2C_CLIENT_END};
 static unsigned int normal_isa[] = {I2C_CLIENT_ISA_END};
 
 /* Insmod parameters */
@@ -369,6 +370,9 @@
 	new_client->driver = &max6875_driver;
 	new_client->flags = 0;
 
+	/* Prevent 24RF08 corruption */
+	i2c_smbus_write_quick(new_client, 0);
+
 	/* Setup the user section */
 	data->blocks[max6875_eeprom_user].type    = max6875_eeprom_user;
 	data->blocks[max6875_eeprom_user].slices  = USER_EEPROM_SLICES;


-- 
Jean Delvare
