Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264291AbUBHWx2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 17:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264284AbUBHWx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 17:53:28 -0500
Received: from mail2.scram.de ([195.226.127.112]:47633 "EHLO mail2.scram.de")
	by vger.kernel.org with ESMTP id S264291AbUBHWxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 17:53:05 -0500
Date: Sun, 8 Feb 2004 23:52:55 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@localhost
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: tms380tr patch 3/3 (get firmware out of kernel)
Message-ID: <Pine.LNX.4.58.0402082349470.1327@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

the last one makes tms380tr use the kernel firmware loader instead of
linking some propriatary code into the kernel, probably violating the
GPL.

drivers/net/tokenring/tms380tr_microcode.h can go after this patch has
been applied.

--jochen

 tms380tr.c |   34 ++++++++++++++++++++++++++++++----
 1 files changed, 30 insertions(+), 4 deletions(-)

diff -u -p -r1.17 tms380tr.c
--- drivers/net/tokenring/tms380tr.c	2004-02-08 23:29:18.000000000 +0100
+++ drivers/net/tokenring/tms380tr.c	2004-02-08 11:09:38.000000000 +0100
@@ -95,6 +95,7 @@ static const char version[] = "tms380tr.
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/trdevice.h>
+#include <linux/firmware.h>

 #include <asm/system.h>
 #include <asm/bitops.h>
@@ -104,7 +105,6 @@ static const char version[] = "tms380tr.
 #include <asm/uaccess.h>

 #include "tms380tr.h"		/* Our Stuff */
-#include "tms380tr_microcode.h"	/* TI microcode for COMMprocessor */

 /* Use 0 for production, 1 for verification, 2 for debug, and
  * 3 for very verbose debug.
@@ -114,6 +114,8 @@ static const char version[] = "tms380tr.
 #endif
 static unsigned int tms380tr_debug = TMS380TR_DEBUG;

+static struct device tms_device;
+
 /* Index to functions, as function prototypes.
  * Alphabetical by function name.
  */
@@ -1301,8 +1279,20 @@ static void tms380tr_exec_sifcmd(struct
 static int tms380tr_reset_adapter(struct net_device *dev)
 {
 	struct net_local *tp = (struct net_local *)dev->priv;
-	unsigned short *fw_ptr = (unsigned short *)&tms380tr_code;
-	unsigned short count, c;
+	unsigned short *fw_ptr;
+	unsigned short count, c, count2;
+	const struct firmware *fw_entry = NULL;
+
+	strncpy(tms_device.bus_id,dev->name, BUS_ID_SIZE);
+
+	if (request_firmware(&fw_entry, "tms380tr.bin", &tms_device) != 0) {
+		printk(KERN_ALERT "%s: firmware %s is missing, cannot start.\n",
+			dev->name, "tms380tr.bin");
+		return (-1);
+	}
+
+	fw_ptr = (unsigned short *)fw_entry->data;
+	count2 = fw_entry->size / 2;

 	/* Hardware adapter reset */
 	SIFWRITEW(ACL_ARESET, SIFACL);
@@ -1329,23 +1319,31 @@ static int tms380tr_reset_adapter(struct
 	SIFWRITEW(c, SIFACL);
 	tms380tr_wait(40);

+	count = 0;
 	/* Download firmware via DIO interface: */
 	do {
+		if (count2 < 3) continue;
+
 		/* Download first address part */
 		SIFWRITEW(*fw_ptr, SIFADX);
 		fw_ptr++;
-
+		count2--;
 		/* Download second address part */
 		SIFWRITEW(*fw_ptr, SIFADD);
 		fw_ptr++;
+		count2--;

 		if((count = *fw_ptr) != 0)	/* Load loop counter */
 		{
 			fw_ptr++;	/* Download block data */
+			count2--;
+			if (count > count2) continue;
+
 			for(; count > 0; count--)
 			{
 				SIFWRITEW(*fw_ptr, SIFINC);
 				fw_ptr++;
+				count2--;
 			}
 		}
 		else	/* Stop, if last block downloaded */
@@ -1355,10 +1353,14 @@ static int tms380tr_reset_adapter(struct

 			/* Clear CPHALT and start BUD */
 			SIFWRITEW(c, SIFACL);
+			if (fw_entry)
+				release_firmware(fw_entry);
 			return (1);
 		}
 	} while(count == 0);

+	if (fw_entry)
+		release_firmware(fw_entry);
 	printk(KERN_INFO "%s: Adapter Download Failed\n", dev->name);
 	return (-1);
 }
