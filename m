Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267856AbUJTAhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267856AbUJTAhB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 20:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267840AbUJTAdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:33:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:12724 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267880AbUJTATd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:33 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <10982315051472@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:25 -0700
Message-Id: <10982315052653@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1867.7.7, 2004/09/21 16:39:57-07:00, khali@linux-fr.org

[PATCH] I2C: Cleanup lm78 init

This patch cleans the init part of the lm78 driver.

* Do not reset the chip.

* Get rid of useless code, which was accidentally left in when we
removed the limit initialization from the driver.

* Do not enable monitoring if it is already enabled (it wouldn't hurt,
but since we can avoid it at no cost...)

Similar changes were applied to the Linux 2.4 driver, which I
successfully tested on my own LM78 chip.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/lm78.c |   22 ++++------------------
 1 files changed, 4 insertions(+), 18 deletions(-)


diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	2004-10-19 16:54:56 -07:00
+++ b/drivers/i2c/chips/lm78.c	2004-10-19 16:54:56 -07:00
@@ -692,26 +692,12 @@
 /* Called when we have found a new LM78. It should set limits, etc. */
 static void lm78_init_client(struct i2c_client *client)
 {
-	struct lm78_data *data = i2c_get_clientdata(client);
-	int vid;
-
-	/* Reset all except Watchdog values and last conversion values
-	   This sets fan-divs to 2, among others */
-	lm78_write_value(client, LM78_REG_CONFIG, 0x80);
-
-	vid = lm78_read_value(client, LM78_REG_VID_FANDIV) & 0x0f;
-	if (data->type == lm79)
-		vid |=
-		    (lm78_read_value(client, LM78_REG_CHIPID) & 0x01) << 4;
-	else
-		vid |= 0x10;
-	vid = VID_FROM_REG(vid);
+	u8 config = lm78_read_value(client, LM78_REG_CONFIG);
 
 	/* Start monitoring */
-	lm78_write_value(client, LM78_REG_CONFIG,
-			 (lm78_read_value(client, LM78_REG_CONFIG) & 0xf7)
-			 | 0x01);
-
+	if (!(config & 0x01))
+		lm78_write_value(client, LM78_REG_CONFIG,
+				 (config & 0xf7) | 0x01);
 }
 
 static struct lm78_data *lm78_update_device(struct device *dev)

