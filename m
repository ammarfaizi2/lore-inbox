Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271298AbTGWUdK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 16:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271300AbTGWUdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 16:33:10 -0400
Received: from [200.199.201.149] ([200.199.201.149]:59777 "EHLO
	smtp1.brturbo.com") by vger.kernel.org with ESMTP id S271298AbTGWUdE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 16:33:04 -0400
From: Marcelo Penna Guerra <eu@marcelopenna.org>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       sensors@stimpy.netroedge.com
Subject: Re: [PATCH] i2c driver changes 2.6.0-test1
Date: Wed, 23 Jul 2003 14:43:55 -0300
User-Agent: KMail/1.5.9
References: <10586300964092@kroah.com>
In-Reply-To: <10586300964092@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_blsH/oJL/ioXXuh"
Message-Id: <200307231443.56168.eu@marcelopenna.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_blsH/oJL/ioXXuh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

This code doesn't work well. I was porting this code to 2.5 myself, so I did 
some fixes to the code in 2.6.0-test1-ac3.

On Saturday 19 July 2003 12:54, Greg KH wrote:

> +	smbus->adapter.algo_data = smbus;
> +*/

The problem is here. If you leave this line commented out, you'll have 
problems when inserting the chip module.

>  	smbus->adapter = nforce2_adapter;

Also, I don't see the point in commenting out all this lines just to introduce 
a nforce2_adapter struct. If this is the correct aprouch, just remove the 
duplicate code instead of just commenting it out.

Attached is a patch to fix this problems. I can't test it very well as I can 
only see the sensors in my board with i2c-isa, but everything loads fine.
This patch also moves the PCI ids to the pci_ids.h file.

Marcelo Penna Guerra

--Boundary-00=_blsH/oJL/ioXXuh
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="i2c-nforce2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="i2c-nforce2.diff"

diff -Naur linux-2.6.0-test1/drivers/i2c/busses/i2c-nforce2.c linux-2.6.0-test1.new/drivers/i2c/busses/i2c-nforce2.c
--- linux-2.6.0-test1/drivers/i2c/busses/i2c-nforce2.c	2003-07-23 09:49:38.093802760 -0300
+++ linux-2.6.0-test1.new/drivers/i2c/busses/i2c-nforce2.c	2003-07-23 09:58:07.000000000 -0300
@@ -48,9 +48,6 @@
 MODULE_DESCRIPTION("nForce2 SMBus driver");
 
 
-#ifndef PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS
-#define PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS   0x0064
-#endif
 /* TODO: sync with lm-sensors */
 #ifndef I2C_HW_SMBUS_NFORCE2
 #define I2C_HW_SMBUS_NFORCE2	0x0c
@@ -120,16 +117,6 @@
 	.functionality = nforce2_func,
 };
 
-static struct i2c_adapter nforce2_adapter = {
-	.owner          = THIS_MODULE,
-	.id             = I2C_ALGO_SMBUS | I2C_HW_SMBUS_NFORCE2,
-	.class          = I2C_ADAP_CLASS_SMBUS,
-	.algo           = &smbus_algorithm,
-	.dev            = {
-		.name   = "unset",
-	},
-};
-
 
 #if 0
 /* Internally used pause function */
@@ -334,13 +321,12 @@
 			smbus->base, smbus->base+smbus->size-1, name);
 		return -1;
 	}
-/*
+
 	smbus->adapter.owner = THIS_MODULE;
 	smbus->adapter.id = I2C_ALGO_SMBUS | I2C_HW_SMBUS_NFORCE2;
 	smbus->adapter.algo = &smbus_algorithm;
 	smbus->adapter.algo_data = smbus;
-*/
-	smbus->adapter = nforce2_adapter;
+	smbus->adapter.class = I2C_ADAP_CLASS_SMBUS;
 	smbus->adapter.dev.parent = &dev->dev;
 	snprintf(smbus->adapter.dev.name, DEVICE_NAME_SIZE,
 		"SMBus nForce2 adapter at %04x", smbus->base);

diff -Naur linux-2.6.0-test1/include/linux/pci_ids.h linux-2.6.0-test1.new/include/linux/pci_ids.h
--- linux-2.6.0-test1/include/linux/pci_ids.h	2003-07-23 10:04:27.268627640 -0300
+++ linux-2.6.0-test1.new/include/linux/pci_ids.h	2003-07-23 09:52:12.000000000 -0300
@@ -1024,6 +1024,7 @@
 #define PCI_DEVICE_ID_NVIDIA_NFORCE		0x01a4
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_IDE		0x01bc
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2		0x01e0
+#define PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS	0x0064
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE3		0x0200
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE3_1		0x0201
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE3_2		0x0202

--Boundary-00=_blsH/oJL/ioXXuh--
