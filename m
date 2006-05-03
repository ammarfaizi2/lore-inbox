Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbWECRYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbWECRYP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 13:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbWECRYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 13:24:14 -0400
Received: from westfish.xiph.osuosl.org ([140.211.166.32]:51931 "EHLO
	mail.xiph.org") by vger.kernel.org with ESMTP id S1030258AbWECRYO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 13:24:14 -0400
Date: Wed, 3 May 2006 13:24:32 -0400
From: Monty <xiphmont@xiph.org>
To: linux-kernel@vger.kernel.org
Cc: xiphmont@gmail.com
Subject: patch to emi62.c and emi26.c (firmware loaders for Emagic USB audio boxes)
Message-ID: <20060503172431.GA6948@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello folks,

(It's been a few years since I've submitted any kernel patches, my
etiquette may be rusty.  Feel free to flame me.  This was not sent to
the listed maintainer as I don't think Tapio's been heard from in some

time.  Correct me if I'm wrong :-)

It's become apparent as machines get faster that the emagic kernel
firmware loaders (based on the ezusb loader) have a reset race.  a
400MHz TiBook never tripped it, but a 2GHz Pentium M seems to hit it

about 30% of the time.  The bug is seen as a hung USB box and the
kernel error:

drivers/usb/misc/emi62.c: emi62_load_firmware - error loading firmware:
error = -110

The patch below inserts a delay after deasserting reset to allow the

box to settle before a new command is issued.  This affects only device
startup.  It's against 2.6.27-rc3, but should apply to any 2.6 kernel;
I don't think the loader has changed for a long time.

(A side note; I notice the firmware loader is using a rather old

firmware version for both devices.  Several relatively harmless but
annoying bugs have since been fixed... how was the firmware from this
device originally extracted?  Was it taken from a device driver
belonging to another OS, or was it provided as a hexdump from emagic?)


Monty

diff -brwu linux-2.6.17-rc3/drivers/usb/misc/emi26.c
linux-2.6.17-rc3-monty/drivers/usb/misc/emi26.c
--- linux-2.6.17-rc3/drivers/usb/misc/emi26.c	2006-04-26
22:19:25.000000000 -0400
+++ linux-2.6.17-rc3-monty
/drivers/usb/misc/emi26.c	2006-05-02
22:22:50.000000000 -0400
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/usb.h>
+#include <linux/delay.h>


 #define MAX_INTEL_HEX_RECORD_LENGTH 16
 typedef struct _INTEL_HEX_RECORD
@@ -114,6 +115,7 @@

 	/* De-assert reset (let the CPU run) */
 	err = emi26_set_reset(dev,0);
+	msleep(250); /* let device settle */


 	/* 2. We upload the FPGA firmware into the EMI
 	 * Note: collect up to 1023 (yes!) bytes and send them with
@@ -157,6 +159,7 @@
 		err("%s - error loading firmware: error = %d", __FUNCTION__, err);

 		goto wraperr;
 	}
+	msleep(250); /* let device settle */

 	/* 4. We put the part of the firmware that lies in the external RAM into the EZ-USB */
 	for (i=0; g_Firmware[i].type == 0; i++) {
@@ -192,6 +195,7 @@

 		err("%s - error loading firmware: error = %d", __FUNCTION__, err);
 		goto wraperr;
 	}
+	msleep(250); /* let device settle */

 	/* return 1 to fail the driver inialization
 	 * and give real driver change to load */

diff -brwu linux-2.6.17-rc3/drivers/usb/misc/emi62.c
linux-2.6.17-rc3-monty/drivers/usb/misc/emi62.c
--- linux-2.6.17-rc3/drivers/usb/misc/emi62.c	2006-04-26
22:19:25.000000000 -0400
+++ linux-2.6.17-rc3-monty
/drivers/usb/misc/emi62.c	2006-05-02
22:54:40.000000000 -0400
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/usb.h>
+#include <linux/delay.h>


 #define MAX_INTEL_HEX_RECORD_LENGTH 16
 typedef struct _INTEL_HEX_RECORD
@@ -123,6 +124,7 @@

 	/* De-assert reset (let the CPU run) */
 	err = emi62_set_reset(dev,0);
+	msleep(250); /* let device settle */


 	/* 2. We upload the FPGA firmware into the EMI
 	 * Note: collect up to 1023 (yes!) bytes and send them with
@@ -166,6 +168,7 @@
 		err("%s - error loading firmware: error = %d", __FUNCTION__, err);

 		goto wraperr;
 	}
+	msleep(250); /* let device settle */

 	/* 4. We put the part of the firmware that lies in the external RAM into the EZ-USB */

@@ -228,6 +231,7 @@
 		err("%s - error loading firmware: error = %d", __FUNCTION__, err);

 		goto wraperr;
 	}
+	msleep(250); /* let device settle */
 
 	kfree(buf);

