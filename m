Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262740AbVGKWNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbVGKWNT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262857AbVGKWNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:13:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:56028 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262739AbVGKWDr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:03:47 -0400
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: New max6875 driver may corrupt EEPROMs
In-Reply-To: <11211193772771@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 11 Jul 2005 15:02:57 -0700
Message-Id: <11211193773155@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: New max6875 driver may corrupt EEPROMs

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

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 9ab1ee2ab7d65979c0f14a60ee1f29f8988f5811
tree 48ad06b033dfe8a673e026e7a219608b15733199
parent 541e6a02768404efb06bd1ea5f33d614732f41fc
author Jean Delvare <khali@linux-fr.org> Fri, 24 Jun 2005 21:14:16 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 11 Jul 2005 14:10:36 -0700

 drivers/i2c/chips/max6875.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/chips/max6875.c b/drivers/i2c/chips/max6875.c
--- a/drivers/i2c/chips/max6875.c
+++ b/drivers/i2c/chips/max6875.c
@@ -37,7 +37,8 @@
 #include <linux/i2c-sensor.h>
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = {0x50, 0x52, I2C_CLIENT_END};
+/* No address scanned by default, as this could corrupt standard EEPROMS. */
+static unsigned short normal_i2c[] = {I2C_CLIENT_END};
 static unsigned int normal_isa[] = {I2C_CLIENT_ISA_END};
 
 /* Insmod parameters */
@@ -369,6 +370,9 @@ static int max6875_detect(struct i2c_ada
 	new_client->driver = &max6875_driver;
 	new_client->flags = 0;
 
+	/* Prevent 24RF08 corruption */
+	i2c_smbus_write_quick(new_client, 0);
+
 	/* Setup the user section */
 	data->blocks[max6875_eeprom_user].type    = max6875_eeprom_user;
 	data->blocks[max6875_eeprom_user].slices  = USER_EEPROM_SLICES;

