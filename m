Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWDEABM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWDEABM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWDEAA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:00:56 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:8848 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1750959AbWDEAAr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:00:47 -0400
Date: Tue, 4 Apr 2006 16:59:56 -0700
From: gregkh@suse.de
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Alan Stern <stern@rowland.harvard.edu>,
       Horst Schirmeier <horst@schirmeier.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Adrian Bunk <bunk@stusta.de>
Subject: [patch 05/26] USB: usbcore: usb_set_configuration oops (NULL ptr dereference)
Message-ID: <20060404235956.GF27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-usbcore-usb_set_configuration-oops.patch"
In-Reply-To: <20060404235927.GA27049@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to deconfigure a device via usb_set_configuration(dev, 0),
2.6.16-rc kernels after 55c527187c9d78f840b284d596a0b298bc1493af oops
with "Unable to handle NULL pointer dereference at...". This is due to
an unchecked dereference of cp in the power budget part.

This patch was already included in Linus' tree.    

Signed-off-by: Horst Schirmeier <horst@schirmeier.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---
 drivers/usb/core/message.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- linux-2.6.16.1.orig/drivers/usb/core/message.c
+++ linux-2.6.16.1/drivers/usb/core/message.c
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

--
