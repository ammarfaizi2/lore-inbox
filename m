Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265405AbTFRSOY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 14:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265402AbTFRSOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 14:14:20 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:53906 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265406AbTFRSLr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 14:11:47 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10559607081639@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.72
In-Reply-To: <10559607072903@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 18 Jun 2003 11:25:08 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1318.3.4, 2003/06/16 11:32:06-07:00, azarah@gentoo.org

[PATCH] I2C: ICH5 SMBus and W83627THF additions

I have been trying to get the W83627THF chip working on this
board.  It is an Asus P4C800 with Intel 875p chipset and a
W83627THF connected via the SMBus.

There are no data sheet for the W83627THF as far as I can see,
but supposidly it is a W83627HF with advance Fan control, etc.

I have applied attached patches, and tried various other things
to get it to work, but no avail.  The SMBus on the ICH5 seems to
work, and it seems to detect the sensor chip just fine, but it
do not seem to read any values from the W83627THF.


 drivers/i2c/busses/i2c-i801.c |   10 +++++++++-
 drivers/i2c/chips/w83781d.c   |    2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	Wed Jun 18 11:19:35 2003
+++ b/drivers/i2c/busses/i2c-i801.c	Wed Jun 18 11:19:35 2003
@@ -27,6 +27,7 @@
     82801BA		2443           
     82801CA/CAM		2483           
     82801DB		24C3   (HW PEC supported, 32 byte buffer not supported)
+    82801EB		24D3   (HW PEC supported, 32 byte buffer not supported)
 
     This driver supports several versions of Intel's I/O Controller Hubs (ICH).
     For SMBus support, they are similar to the PIIX4 and are part
@@ -121,7 +122,8 @@
 		return -ENODEV;
 
 	I801_dev = dev;
-	if (dev->device == PCI_DEVICE_ID_INTEL_82801DB_3)
+	if ((dev->device == PCI_DEVICE_ID_INTEL_82801DB_3) ||
+	    (dev->device == PCI_DEVICE_ID_INTEL_82801EB_3))
 		isich4 = 1;
 	else
 		isich4 = 0;
@@ -584,6 +586,12 @@
 		.device =	PCI_DEVICE_ID_INTEL_82801DB_3,
 		.subvendor =	PCI_ANY_ID,
 		.subdevice =	PCI_ANY_ID,
+	},
+	{
+		.vendor =   PCI_VENDOR_ID_INTEL,
+		.device =   PCI_DEVICE_ID_INTEL_82801EB_3,
+		.subvendor =    PCI_ANY_ID,
+		.subdevice =    PCI_ANY_ID,
 	},
 	{ 0, }
 };
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Wed Jun 18 11:19:35 2003
+++ b/drivers/i2c/chips/w83781d.c	Wed Jun 18 11:19:35 2003
@@ -1285,7 +1285,7 @@
 			kind = w83782d;
 		else if (val1 == 0x40 && vendid == winbond && !is_isa)
 			kind = w83783s;
-		else if (val1 == 0x20 && vendid == winbond)
+		else if ((val1 == 0x20 || val1 == 0x72) && vendid == winbond)
 			kind = w83627hf;
 		else if (val1 == 0x30 && vendid == asus && !is_isa)
 			kind = as99127f;

