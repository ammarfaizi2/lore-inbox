Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWEQWOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWEQWOm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWEQWMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:12:47 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:58243 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751238AbWEQWMR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:12:17 -0400
Message-Id: <20060517221353.122609000@sous-sol.org>
References: <20060517221312.227391000@sous-sol.org>
Date: Wed, 17 May 2006 00:00:03 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, greg@kroah.com
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Pete Zaitcev <zaitcev@redhat.com>,
       linux-usb-devel@lists.sourceforge.net,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 03/22] USB: ub oops in block_uevent
Content-Disposition: inline; filename=usb-ub-oops-in-block_uevent.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

In kernel 2.6.16, if a mounted storage device is removed, an oops happens
because ub supplies an interface device (and kobject) to the block layer,
but neglects to pin it. And apparently, the block layer expects its users
to pin device structures.

The code in ub was broken this way for years. But the bug was exposed only
by 2.6.16 when it started to call block_uevent on close, which traverses
device structures (kobjects actually).

Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 drivers/block/ub.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--- linux-2.6.16.16.orig/drivers/block/ub.c
+++ linux-2.6.16.16/drivers/block/ub.c
@@ -704,6 +704,9 @@ static void ub_cleanup(struct ub_dev *sc
 		kfree(lun);
 	}
 
+	usb_set_intfdata(sc->intf, NULL);
+	usb_put_intf(sc->intf);
+	usb_put_dev(sc->dev);
 	kfree(sc);
 }
 
@@ -2428,7 +2431,12 @@ static int ub_probe(struct usb_interface
 	// sc->ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
 	usb_set_intfdata(intf, sc);
 	usb_get_dev(sc->dev);
-	// usb_get_intf(sc->intf);	/* Do we need this? */
+	/*
+	 * Since we give the interface struct to the block level through
+	 * disk->driverfs_dev, we have to pin it. Otherwise, block_uevent
+	 * oopses on close after a disconnect (kernels 2.6.16 and up).
+	 */
+	usb_get_intf(sc->intf);
 
 	snprintf(sc->name, 12, DRV_NAME "(%d.%d)",
 	    sc->dev->bus->busnum, sc->dev->devnum);
@@ -2509,7 +2517,7 @@ static int ub_probe(struct usb_interface
 err_diag:
 err_dev_desc:
 	usb_set_intfdata(intf, NULL);
-	// usb_put_intf(sc->intf);
+	usb_put_intf(sc->intf);
 	usb_put_dev(sc->dev);
 	kfree(sc);
 err_core:
@@ -2688,12 +2696,6 @@ static void ub_disconnect(struct usb_int
 	 */
 
 	device_remove_file(&sc->intf->dev, &dev_attr_diag);
-	usb_set_intfdata(intf, NULL);
-	// usb_put_intf(sc->intf);
-	sc->intf = NULL;
-	usb_put_dev(sc->dev);
-	sc->dev = NULL;
-
 	ub_put(sc);
 }
 

--
