Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbVEMWOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbVEMWOP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 18:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbVEMWNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 18:13:44 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:64672 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262574AbVEMWKT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 18:10:19 -0400
Message-Id: <20050513220225.941792000@abc>
References: <20050513220019.907667000@abc>
Date: Sat, 14 May 2005 00:00:27 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-flexcop-modulerefcnt.patch
X-SA-Exim-Connect-IP: 217.231.56.126
Subject: [DVB patch 08/11] flexcop: fix module refcount handling
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corrected the THIS_MODULE handling for the flexcop-stuff and dvb-usb which lead
to oopses because of misorganized module dependencies.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/b2c2/flexcop-common.h |    2 ++
 drivers/media/dvb/b2c2/flexcop-pci.c    |    1 +
 drivers/media/dvb/b2c2/flexcop-usb.c    |    1 +
 drivers/media/dvb/b2c2/flexcop.c        |    2 +-
 4 files changed, 5 insertions(+), 1 deletion(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-common.h
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/b2c2/flexcop-common.h	2005-05-12 01:30:45.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-common.h	2005-05-12 01:30:55.000000000 +0200
@@ -75,6 +75,8 @@ struct flexcop_device {
 	struct i2c_adapter i2c_adap;
 	struct semaphore i2c_sem;
 
+	struct module *owner;
+
 	/* options and status */
 	int extra_feedcount;
 	int feedcount;
Index: linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-pci.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/b2c2/flexcop-pci.c	2005-05-12 01:30:45.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-pci.c	2005-05-12 01:30:55.000000000 +0200
@@ -309,6 +309,7 @@ static int flexcop_pci_probe(struct pci_
 	fc->bus_type = FC_PCI;
 
 	fc->dev = &pdev->dev;
+	fc->owner = THIS_MODULE;
 
 /* bus specific part */
 	fc_pci->pdev = pdev;
Index: linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-usb.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/b2c2/flexcop-usb.c	2005-05-12 01:30:26.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-usb.c	2005-05-12 01:30:55.000000000 +0200
@@ -498,6 +498,7 @@ static int flexcop_usb_probe(struct usb_
 	fc->bus_type = FC_USB;
 
 	fc->dev = &udev->dev;
+	fc->owner = THIS_MODULE;
 
 /* bus specific part */
 	fc_usb->udev = udev;
Index: linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/b2c2/flexcop.c	2005-05-12 01:30:26.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop.c	2005-05-12 01:30:55.000000000 +0200
@@ -67,7 +67,7 @@ static int flexcop_dvb_stop_feed(struct 
 static int flexcop_dvb_init(struct flexcop_device *fc)
 {
 	int ret;
-	if ((ret = dvb_register_adapter(&fc->dvb_adapter,"FlexCop Digital TV device",THIS_MODULE)) < 0) {
+	if ((ret = dvb_register_adapter(&fc->dvb_adapter,"FlexCop Digital TV device",fc->owner)) < 0) {
 		err("error registering DVB adapter");
 		return ret;
 	}

--

