Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264875AbTK3Hs2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 02:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264876AbTK3Hs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 02:48:28 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:63499 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S264875AbTK3Hs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 02:48:26 -0500
Date: Sun, 30 Nov 2003 18:48:14 +1100
To: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [USB] Fix connect/disconnect race
Message-ID: <20031130074814.GA13002@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg:

This patch was integrated by you in 2.4 six months ago.  Unfortunately
it never got into 2.5.  Without it you can end up with crashes such
as http://bugs.debian.org/218670

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-source-2.5/drivers/usb/core/hub.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/usb/core/hub.c,v
retrieving revision 1.1.1.15
diff -u -r1.1.1.15 hub.c
--- kernel-source-2.5/drivers/usb/core/hub.c	28 Sep 2003 04:44:16 -0000	1.1.1.15
+++ kernel-source-2.5/drivers/usb/core/hub.c	30 Nov 2003 07:44:40 -0000
@@ -926,7 +926,6 @@
 			break;
 		}
 
-		hub->children[port] = dev;
 		dev->state = USB_STATE_POWERED;
 
 		/* Reset the device, and detect its speed */
@@ -979,8 +978,10 @@
 		dev->dev.parent = dev->parent->dev.parent->parent;
 
 		/* Run it through the hoops (find a driver, etc) */
-		if (!usb_new_device(dev, &hub->dev))
+		if (!usb_new_device(dev, &hub->dev)) {
+			hub->children[port] = dev;
 			goto done;
+		}
 
 		/* Free the configuration if there was an error */
 		usb_put_dev(dev);
@@ -989,7 +990,6 @@
 		delay = HUB_LONG_RESET_TIME;
 	}
 
-	hub->children[port] = NULL;
 	hub_port_disable(hub, port);
 done:
 	up(&usb_address0_sem);

--HlL+5n6rz5pIUxbD--
