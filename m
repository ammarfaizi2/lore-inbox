Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270235AbUJTArn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270235AbUJTArn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 20:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270233AbUJTApT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:45:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:63155 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266196AbUJTATZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:25 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <1098231507961@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:27 -0700
Message-Id: <10982315072286@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2078, 2004/10/19 16:19:10-07:00, kraxel@bytesex.org

[PATCH] I2C: i2c bus power management support

The patch below adds power management support to the i2c bus.
It adds just two small functions which call down to the devices
power management functions if they are present, so the i2c device
drivers will receive the suspend and resume events.

From: Gerd Knorr <kraxel@bytesex.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/i2c-core.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	2004-10-19 16:53:27 -07:00
+++ b/drivers/i2c/i2c-core.c	2004-10-19 16:53:27 -07:00
@@ -517,9 +517,29 @@
 	return 1;
 }
 
+static int i2c_bus_suspend(struct device * dev, u32 state)
+{
+	int rc = 0;
+
+	if (dev->driver && dev->driver->suspend)
+		rc = dev->driver->suspend(dev,state,0);
+	return rc;
+}
+
+static int i2c_bus_resume(struct device * dev)
+{
+	int rc = 0;
+	
+	if (dev->driver && dev->driver->resume)
+		rc = dev->driver->resume(dev,0);
+	return rc;
+}
+
 struct bus_type i2c_bus_type = {
 	.name =		"i2c",
 	.match =	i2c_device_match,
+	.suspend =      i2c_bus_suspend,
+	.resume =       i2c_bus_resume,
 };
 
 static int __init i2c_init(void)

