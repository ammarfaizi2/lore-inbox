Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261777AbTCZQx6>; Wed, 26 Mar 2003 11:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261782AbTCZQx6>; Wed, 26 Mar 2003 11:53:58 -0500
Received: from smtp3.wanadoo.fr ([193.252.22.27]:29276 "EHLO
	mwinf0401.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261777AbTCZQxz>; Wed, 26 Mar 2003 11:53:55 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] USB speedtouch: handle failure of usb_set_interface.
Date: Wed, 26 Mar 2003 18:04:59 +0100
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303261804.59133.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 speedtch.c |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Wed Mar 26 18:02:57 2003
+++ b/drivers/usb/misc/speedtch.c	Wed Mar 26 18:02:57 2003
@@ -1034,6 +1034,23 @@
 **  USB  **
 **********/
 
+static int udsl_set_alternate (struct udsl_instance_data *instance)
+{
+	down (&instance->serialize); /* vs self */
+	if (!instance->firmware_loaded) {
+		int ret;
+
+		if ((ret = usb_set_interface (instance->usb_dev, 1, 1)) < 0) {
+			up (&instance->serialize);
+			return ret;
+		}
+		instance->firmware_loaded = 1;
+	}
+	up (&instance->serialize);
+	udsl_fire_receivers (instance);
+	return 0;
+}
+
 static int udsl_usb_ioctl (struct usb_interface *intf, unsigned int code, void *user_data)
 {
 	struct udsl_instance_data *instance = usb_get_intfdata (intf);
@@ -1048,14 +1065,7 @@
 	switch (code) {
 	case UDSL_IOCTL_START:
 		instance->atm_dev->signal = ATM_PHY_SIG_FOUND;
-		down (&instance->serialize); /* vs self */
-		if (!instance->firmware_loaded) {
-			usb_set_interface (instance->usb_dev, 1, 1);
-			instance->firmware_loaded = 1;
-		}
-		up (&instance->serialize);
-		udsl_fire_receivers (instance);
-		return 0;
+		return udsl_set_alternate (instance);
 	case UDSL_IOCTL_STOP:
 		instance->atm_dev->signal = ATM_PHY_SIG_LOST;
 		return 0;

