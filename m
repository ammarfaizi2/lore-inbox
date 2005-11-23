Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbVKWXsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbVKWXsA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVKWXrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:47:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:30914 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751333AbVKWXqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:46:34 -0500
Date: Wed, 23 Nov 2005 15:44:31 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       khali@linux-fr.org
Subject: [patch 07/22] hwmon: Fix missing it87 fan div init
Message-ID: <20051123234431.GH527@kroah.com>
References: <20051123225156.624397000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="hwmon-fix-missing-it87-fan-div-init.patch"
In-Reply-To: <20051123234335.GA527@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>

Fix a bug where setting the low fan speed limits will not work if no
data was ever read through the sysfs interface and the fan clock
dividers have not been explicitely set yet either. The reason is that
data->fan_div[nr] may currently be used before it is initialized from
the chip register values. The fix is to explicitely initialize
data->fan_div[nr] before using it.

Bug reported, and fix tested, by Nicolas Mailhot.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/hwmon/it87.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- usb-2.6.orig/drivers/hwmon/it87.c
+++ usb-2.6/drivers/hwmon/it87.c
@@ -522,8 +522,15 @@ static ssize_t set_fan_min(struct device
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
+	u8 reg = it87_read_value(client, IT87_REG_FAN_DIV);
 
 	down(&data->update_lock);
+	switch (nr) {
+	case 0: data->fan_div[nr] = reg & 0x07; break;
+	case 1: data->fan_div[nr] = (reg >> 3) & 0x07; break;
+	case 2: data->fan_div[nr] = (reg & 0x40) ? 3 : 1; break;
+	}
+
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	it87_write_value(client, IT87_REG_FAN_MIN(nr), data->fan_min[nr]);
 	up(&data->update_lock);

--
