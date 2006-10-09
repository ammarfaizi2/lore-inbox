Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751664AbWJIJLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbWJIJLq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 05:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbWJIJLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 05:11:46 -0400
Received: from yacht.ocn.ne.jp ([222.146.40.168]:2266 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S1751662AbWJIJLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 05:11:46 -0400
Date: Mon, 9 Oct 2006 18:12:01 +0900
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH] driver core: handle bus_attach_device() failure
Message-ID: <20061009091201.GA6448@localhost>
Mail-Followup-To: akinobu.mita@gmail.com, linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net,
	Greg Kroah-Hartman <gregkh@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: akinobu.mita@gmail.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch handles bus_attach_device() failure in device_add().

Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/base/core.c |   22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

Index: 2.6-mm/drivers/base/core.c
===================================================================
--- 2.6-mm.orig/drivers/base/core.c	2006-10-03 22:58:40.000000000 +0900
+++ 2.6-mm/drivers/base/core.c	2006-10-09 16:57:52.000000000 +0900
@@ -530,7 +530,9 @@ int device_add(struct device *dev)
 	if ((error = bus_add_device(dev)))
 		goto BusError;
 	kobject_uevent(&dev->kobj, KOBJ_ADD);
-	bus_attach_device(dev);
+	if ((error = bus_attach_device(dev)))
+		goto BusAttachError;
+
 	if (parent)
 		klist_add_tail(&dev->knode_parent, &parent->klist_children);
 
@@ -548,6 +550,8 @@ int device_add(struct device *dev)
  Done:
 	put_device(dev);
 	return error;
+ BusAttachError:
+	bus_remove_device(dev);
  BusError:
 	device_pm_remove(dev);
  PMError:
