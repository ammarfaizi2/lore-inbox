Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbTLKBaP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 20:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264332AbTLKBaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 20:30:15 -0500
Received: from mail.kroah.org ([65.200.24.183]:53455 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264283AbTLKBaH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 20:30:07 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1071106147425@kroah.com>
Subject: Re: [PATCH] USB Fixes for 2.6.0-test11
In-Reply-To: <1071106147533@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 10 Dec 2003 17:29:07 -0800
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1524, 2003/12/09 17:40:44-08:00, herbert@gondor.apana.org.au

[PATCH] USB: Fix connect/disconnect race

This patch was integrated by you in 2.4 six months ago.  Unfortunately
it never got into 2.5.  Without it you can end up with crashes such
as http://bugs.debian.org/218670


 drivers/usb/core/hub.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
--- a/drivers/usb/core/hub.c	Wed Dec 10 16:47:01 2003
+++ b/drivers/usb/core/hub.c	Wed Dec 10 16:47:01 2003
@@ -929,7 +929,6 @@
 			break;
 		}
 
-		hub->children[port] = dev;
 		dev->state = USB_STATE_POWERED;
 
 		/* Reset the device, and detect its speed */
@@ -982,8 +981,10 @@
 		dev->dev.parent = dev->parent->dev.parent->parent;
 
 		/* Run it through the hoops (find a driver, etc) */
-		if (!usb_new_device(dev, &hub->dev))
+		if (!usb_new_device(dev, &hub->dev)) {
+			hub->children[port] = dev;
 			goto done;
+		}
 
 		/* Free the configuration if there was an error */
 		usb_put_dev(dev);
@@ -992,7 +993,6 @@
 		delay = HUB_LONG_RESET_TIME;
 	}
 
-	hub->children[port] = NULL;
 	hub_port_disable(hub, port);
 done:
 	up(&usb_address0_sem);

