Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbVJaRv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbVJaRv1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 12:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbVJaRv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 12:51:26 -0500
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:50694 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932520AbVJaRvZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 12:51:25 -0500
Date: Mon, 31 Oct 2005 18:51:21 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] i2c-viapro: Some adjustments
Message-Id: <20051031185121.6700d67e.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.0.3 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Can you please apply the following patch to your git tree? Thanks.

* * * * *

The big i2c-viapro SMBus driver update which went into 2.6.14-git1
introduced a few minor issues. Nothing critical, but I would like a
few adjustments to be merged in to fix the following problems:

* VIA should not be spelled Via.
* Frodo Looijaard and Philip Edelbrock did not write the i2c-viapro
  driver.
* When debugging is disabled, half of messages would be logged.
* Drop an unneeded masking.
* Some port reads can be avoided now that the transaction size is
  passed as a parameter to vt596_transaction().
* SMBus Receive Byte transactions are used for probing too (for
  EEPROMs), so hide errors on these too.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---

 Documentation/i2c/busses/i2c-viapro |    6 ++----
 drivers/i2c/busses/i2c-viapro.c     |   27 ++++++++++++++-------------
 2 files changed, 16 insertions(+), 17 deletions(-)

--- linux-2.6.14-git.orig/Documentation/i2c/busses/i2c-viapro	2005-10-31 14:18:19.000000000 +0100
+++ linux-2.6.14-git/Documentation/i2c/busses/i2c-viapro	2005-10-31 18:48:32.000000000 +0100
@@ -7,12 +7,10 @@
   * VIA Technologies, Inc. VT82C686A/B
     Datasheet: Sometimes available at the VIA website
 
-  * VIA Technologies, Inc. VT8231, VT8233, VT8233A, VT8235, VT8237
-    Datasheet: available on request from Via
+  * VIA Technologies, Inc. VT8231, VT8233, VT8233A, VT8235, VT8237R
+    Datasheet: available on request from VIA
 
 Authors:
-	Frodo Looijaard <frodol@dds.nl>,
-	Philip Edelbrock <phil@netroedge.com>,
 	Kyösti Mälkki <kmalkki@cc.hut.fi>,
 	Mark D. Studebaker <mdsxyz123@yahoo.com>,
 	Jean Delvare <khali@linux-fr.org>
--- linux-2.6.14-git.orig/drivers/i2c/busses/i2c-viapro.c	2005-10-31 14:18:30.000000000 +0100
+++ linux-2.6.14-git/drivers/i2c/busses/i2c-viapro.c	2005-10-31 18:46:36.000000000 +0100
@@ -142,19 +142,18 @@
 	/* Make sure the SMBus host is ready to start transmitting */
 	if ((temp = inb_p(SMBHSTSTS)) & 0x1F) {
 		dev_dbg(&vt596_adapter.dev, "SMBus busy (0x%02x). "
-			"Resetting... ", temp);
+			"Resetting...\n", temp);
 
 		outb_p(temp, SMBHSTSTS);
 		if ((temp = inb_p(SMBHSTSTS)) & 0x1F) {
-			printk("Failed! (0x%02x)\n", temp);
+			dev_err(&vt596_adapter.dev, "SMBus reset failed! "
+				"(0x%02x)\n", temp);
 			return -1;
-		} else {
-			printk("Successful!\n");
 		}
 	}
 
 	/* Start the transaction by setting bit 6 */
-	outb_p(0x40 | (size & 0x3C), SMBHSTCNT);
+	outb_p(0x40 | size, SMBHSTCNT);
 
 	/* We will always wait for a fraction of a second */
 	do {
@@ -171,7 +170,7 @@
 	if (temp & 0x10) {
 		result = -1;
 		dev_err(&vt596_adapter.dev, "Transaction failed (0x%02x)\n",
-			inb_p(SMBHSTCNT) & 0x3C);
+			size);
 	}
 
 	if (temp & 0x08) {
@@ -180,11 +179,13 @@
 	}
 
 	if (temp & 0x04) {
+		int read = inb_p(SMBHSTADD) & 0x01;
 		result = -1;
-		/* Quick commands are used to probe for chips, so
-		   errors are expected, and we don't want to frighten the
-		   user. */
-		if ((inb_p(SMBHSTCNT) & 0x3C) != VT596_QUICK)
+		/* The quick and receive byte commands are used to probe
+		   for chips, so errors are expected, and we don't want
+		   to frighten the user. */
+		if (!((size == VT596_QUICK && !read) ||
+		      (size == VT596_BYTE && read)))
 			dev_err(&vt596_adapter.dev, "Transaction error!\n");
 	}
 
@@ -462,9 +463,9 @@
 	}
 }
 
-MODULE_AUTHOR(
-    "Frodo Looijaard <frodol@dds.nl> and "
-    "Philip Edelbrock <phil@netroedge.com>");
+MODULE_AUTHOR("Kyosti Malkki <kmalkki@cc.hut.fi>, "
+	      "Mark D. Studebaker <mdsxyz123@yahoo.com> and "
+	      "Jean Delvare <khali@linux-fr.org>");
 MODULE_DESCRIPTION("vt82c596 SMBus driver");
 MODULE_LICENSE("GPL");
 

-- 
Jean Delvare
