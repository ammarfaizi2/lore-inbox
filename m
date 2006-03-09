Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWCINK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWCINK4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 08:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbWCINK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 08:10:56 -0500
Received: from soohrt.org ([85.131.246.150]:28588 "EHLO quickstop.soohrt.org")
	by vger.kernel.org with ESMTP id S1750765AbWCINK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 08:10:56 -0500
Date: Thu, 9 Mar 2006 14:10:49 +0100
From: Horst Schirmeier <horst@schirmeier.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH] usbcore: usb_set_configuration oops (NULL ptr dereference)
Message-ID: <20060309131048.GL22994@quickstop.soohrt.org>
Mail-Followup-To: Alan Stern <stern@rowland.harvard.edu>,
	Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to deconfigure a device via usb_set_configuration(dev, 0),
2.6.16-rc kernels after 55c527187c9d78f840b284d596a0b298bc1493af oops
with "Unable to handle NULL pointer dereference at...". This is due to
an unchecked dereference of cp in the power budget part.

Signed-off-by: Horst Schirmeier <horst@schirmeier.com>

---

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 7135e54..96cabeb 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1388,11 +1388,13 @@ free_interfaces:
 	if (dev->state != USB_STATE_ADDRESS)
 		usb_disable_device (dev, 1);	// Skip ep0
 
-	i = dev->bus_mA - cp->desc.bMaxPower * 2;
-	if (i < 0)
-		dev_warn(&dev->dev, "new config #%d exceeds power "
-				"limit by %dmA\n",
-				configuration, -i);
+	if (cp) {
+		i = dev->bus_mA - cp->desc.bMaxPower * 2;
+		if (i < 0)
+			dev_warn(&dev->dev, "new config #%d exceeds power "
+					"limit by %dmA\n",
+					configuration, -i);
+	}
 
 	if ((ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
 			USB_REQ_SET_CONFIGURATION, 0, configuration, 0,
