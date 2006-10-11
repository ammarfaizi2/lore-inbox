Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161153AbWJKROM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161153AbWJKROM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 13:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161150AbWJKROL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 13:14:11 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:21175 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1161152AbWJKROG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 13:14:06 -0400
Message-ID: <452D2660.5000804@free.fr>
Date: Wed, 11 Oct 2006 19:14:08 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060809 Debian/1.7.13-0.3
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: greg@kroah.com
CC: linux-kernel@vger.kernel.org, usbatm@lists.infradead.org,
       linux-usb-devel@lists.sourceforge.net, ueagle <ueagleatm-dev@gna.org>,
       Andrew Morton <akpm@osdl.org>, bunk@stusta.de,
       Ernst Herzberg <list-lkml@net4u.de>, laurent.riffard@free.fr
Subject: [PATCH 1/1] UEAGLE : fix ueagle-atm Oops on 2.6.19-rc1 and 2.6.19-rc1-mm
Content-Type: multipart/mixed;
 boundary="------------040607090306030607040803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040607090306030607040803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,


this patch fix :

Subject    : ueagle-atm Oops
References : http://lkml.org/lkml/2006/10/6/390
Submitter  : Ernst Herzberg <list-lkml@net4u.de>
Caused-By  : Greg Kroah-Hartman <gregkh@suse.de>
              commit e7ccdfec087f02930c5cdc81143d4a045ae8d361
Handled-By : Matthieu Castet <castet.matthieu@free.fr>
              Laurent Riffard
Patch      : https://mail.gna.org/public/ueagleatm-dev/2006-10/msg00022.html
Status     : "patch available, but some cleaning is needed"

---



--------------040607090306030607040803
Content-Type: text/plain;
 name="ueagle-sysfsfix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ueagle-sysfsfix"

The array of attribute passed to sysfs_create_group() must be
NULL-terminated.
The sysfs entries are created before the start of the modem state machine to avoid to stop it in case of errors in sysfs creation.
Also {destroy,create}_fs_entries are removed as they do nothing.


Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
Index: linux-2.6.16/drivers/usb/atm/ueagle-atm.c
===================================================================
--- linux-2.6.16.orig/drivers/usb/atm/ueagle-atm.c	2006-10-10 19:29:39.000000000 +0200
+++ linux-2.6.16/drivers/usb/atm/ueagle-atm.c	2006-10-11 19:05:44.000000000 +0200
@@ -1648,16 +1648,12 @@
 	&dev_attr_stat_usunc.attr,
 	&dev_attr_stat_dsunc.attr,
 	&dev_attr_stat_firmid.attr,
+	NULL,
 };
 static struct attribute_group attr_grp = {
 	.attrs = attrs,
 };
 
-static int create_fs_entries(struct usb_interface *intf)
-{
-	return sysfs_create_group(&intf->dev.kobj, &attr_grp);
-}
-
 static int uea_bind(struct usbatm_data *usbatm, struct usb_interface *intf,
 		   const struct usb_device_id *id)
 {
@@ -1717,31 +1713,25 @@
 		}
 	}
 
+	ret = sysfs_create_group(&intf->dev.kobj, &attr_grp);
+	if (ret < 0)
+		goto error;
+
 	ret = uea_boot(sc);
-	if (ret < 0) {
-		kfree(sc);
-		return ret;
-	}
+	if (ret < 0)
+		goto error;
 
-	ret = create_fs_entries(intf);
-	if (ret) {
-		uea_stop(sc);
-		kfree(sc);
-		return ret;
-	}
 	return 0;
-}
-
-static void destroy_fs_entries(struct usb_interface *intf)
-{
-	sysfs_remove_group(&intf->dev.kobj, &attr_grp);
+error:
+	kfree(sc);
+	return ret;
 }
 
 static void uea_unbind(struct usbatm_data *usbatm, struct usb_interface *intf)
 {
 	struct uea_softc *sc = usbatm->driver_data;
 
-	destroy_fs_entries(intf);
+	sysfs_remove_group(&intf->dev.kobj, &attr_grp);
 	uea_stop(sc);
 	kfree(sc);
 }

--------------040607090306030607040803--
