Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVAHIil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVAHIil (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbVAHIfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:35:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:4742 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261908AbVAHFsi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:38 -0500
Subject: Re: [PATCH] I2C patches for 2.6.10
In-Reply-To: <1105162775137@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:39:35 -0800
Message-Id: <11051627753674@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.445.2, 2004/12/15 11:36:57-08:00, khali@linux-fr.org

[PATCH] I2C: use chip driver name to request regions

> Trivial patch against 2.6.10-rc3-bk2.
> When request_region is called name is set to "", use module name.

Correct. I even think we should do the same for other chip drivers. For
now they all use an arbitrary string. Using the driver's name would be
both more consistent and more efficient (spares some bytes of memory).


Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/lm78.c     |    2 +-
 drivers/i2c/chips/pc87360.c  |    3 ++-
 drivers/i2c/chips/smsc47m1.c |    2 +-
 drivers/i2c/chips/via686a.c  |    2 +-
 drivers/i2c/chips/w83627hf.c |    2 +-
 drivers/i2c/chips/w83781d.c  |    3 ++-
 6 files changed, 8 insertions(+), 6 deletions(-)


diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	2005-01-07 14:56:14 -08:00
+++ b/drivers/i2c/chips/lm78.c	2005-01-07 14:56:14 -08:00
@@ -462,7 +462,7 @@
 
 	/* Reserve the ISA region */
 	if (is_isa)
-		if (!request_region(address, LM78_EXTENT, "lm78")) {
+		if (!request_region(address, LM78_EXTENT, lm78_driver.name)) {
 			err = -EBUSY;
 			goto ERROR0;
 		}
diff -Nru a/drivers/i2c/chips/pc87360.c b/drivers/i2c/chips/pc87360.c
--- a/drivers/i2c/chips/pc87360.c	2005-01-07 14:56:14 -08:00
+++ b/drivers/i2c/chips/pc87360.c	2005-01-07 14:56:14 -08:00
@@ -756,7 +756,8 @@
 
 	for (i = 0; i < 3; i++) {
 		if (((data->address[i] = extra_isa[i]))
-		 && !request_region(extra_isa[i], PC87360_EXTENT, "pc87360")) {
+		 && !request_region(extra_isa[i], PC87360_EXTENT,
+		 		    pc87360_driver.name)) {
 			dev_err(&new_client->dev, "Region 0x%x-0x%x already "
 				"in use!\n", extra_isa[i],
 				extra_isa[i]+PC87360_EXTENT-1);
diff -Nru a/drivers/i2c/chips/smsc47m1.c b/drivers/i2c/chips/smsc47m1.c
--- a/drivers/i2c/chips/smsc47m1.c	2005-01-07 14:56:14 -08:00
+++ b/drivers/i2c/chips/smsc47m1.c	2005-01-07 14:56:14 -08:00
@@ -400,7 +400,7 @@
 		return 0;
 	}
 
-	if (!request_region(address, SMSC_EXTENT, "smsc47m1")) {
+	if (!request_region(address, SMSC_EXTENT, smsc47m1_driver.name)) {
 		dev_err(&adapter->dev, "Region 0x%x already in use!\n", address);
 		return -EBUSY;
 	}
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	2005-01-07 14:56:14 -08:00
+++ b/drivers/i2c/chips/via686a.c	2005-01-07 14:56:14 -08:00
@@ -613,7 +613,7 @@
 	}
 
 	/* Reserve the ISA region */
-	if (!request_region(address, VIA686A_EXTENT, "via686a-sensor")) {
+	if (!request_region(address, VIA686A_EXTENT, via686a_driver.name)) {
 		dev_err(&adapter->dev,"region 0x%x already in use!\n",
 		       address);
 		return -ENODEV;
diff -Nru a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c	2005-01-07 14:56:14 -08:00
+++ b/drivers/i2c/chips/w83627hf.c	2005-01-07 14:56:14 -08:00
@@ -984,7 +984,7 @@
 	if(force_addr)
 		address = force_addr & ~(WINB_EXTENT - 1);
 
-	if (!request_region(address, WINB_EXTENT, "w83627hf")) {
+	if (!request_region(address, WINB_EXTENT, w83627hf_driver.name)) {
 		err = -EBUSY;
 		goto ERROR0;
 	}
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	2005-01-07 14:56:14 -08:00
+++ b/drivers/i2c/chips/w83781d.c	2005-01-07 14:56:14 -08:00
@@ -1065,7 +1065,8 @@
 	}
 	
 	if (is_isa)
-		if (!request_region(address, W83781D_EXTENT, "w83781d")) {
+		if (!request_region(address, W83781D_EXTENT,
+				    w83781d_driver.name)) {
 			dev_dbg(&adapter->dev, "Request of region "
 				"0x%x-0x%x for w83781d failed\n", address,
 				address + W83781D_EXTENT - 1);

