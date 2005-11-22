Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965203AbVKVVLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965203AbVKVVLX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965188AbVKVVKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:10:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50079 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965203AbVKVVKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:10:13 -0500
Date: Tue, 22 Nov 2005 13:09:05 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, Greg KH <greg@kroah.com>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Jean Delvare <khali@linux-fr.org>,
       Nicolas Mailhot <nicolas.mailhot@laposte.net>
Subject: [patch 23/23] hwmon: Fix missing it87 fan div init
Message-ID: <20051122210905.GX28140@shell0.pdx.osdl.net>
References: <20051122205223.099537000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="hwmon-fix-missing-it87-fan-div-init.patch"
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Fix a bug where setting the low fan speed limits will not work if no
data was ever read through the sysfs interface and the fan clock
dividers have not been explicitely set yet either. The reason is that
data->fan_div[nr] may currently be used before it is initialized from
the chip register values. The fix is to explicitely initialize
data->fan_div[nr] before using it.

Bug reported, and fix tested, by Nicolas Mailhot.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 drivers/hwmon/it87.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- linux-2.6.14.2.orig/drivers/hwmon/it87.c
+++ linux-2.6.14.2/drivers/hwmon/it87.c
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
