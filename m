Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbVCaXhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbVCaXhD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 18:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbVCaXgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 18:36:15 -0500
Received: from mail.kroah.org ([69.55.234.183]:30688 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262078AbVCaXYI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 18:24:08 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Avoid repeated resets of i2c-viapro
In-Reply-To: <11123113921928@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 31 Mar 2005 15:23:13 -0800
Message-Id: <11123113921804@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2337, 2005/03/31 14:28:46-08:00, khali@linux-fr.org

[PATCH] I2C: Avoid repeated resets of i2c-viapro

It was reported that the i2c-viapro SMBus driver sometimes has trouble
on recent systems (VT8237 south bridge). The "Host Status" register has
at least one additional bit used when compared with older south bridges
of this family. The driver currently considers this additional bit as an
error condition when it's set, causing repeated bus resets and sometimes
read failures.

This patch makes the driver ignore the bits of the "Host Status"
register for which no definition is known. I wish I had a datasheet for
the VIA VT8237, so that I could check what the additional bit is
supposed to mean, but I don't. If someone has a datasheet or good
contacts at VIA, please let me know.

The patch was reported to fix the problem on a system with the VT8237,
and was also tested not to break the driver on older VIA south bridges,
so it seems to be safe. Thanks to Aurelien Jarno for the tests.

Additionally, the patch makes the post-transaction bus reset slightly
more efficient by sparing a few unneeded I/O operations.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/busses/i2c-viapro.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
--- a/drivers/i2c/busses/i2c-viapro.c	2005-03-31 15:17:32 -08:00
+++ b/drivers/i2c/busses/i2c-viapro.c	2005-03-31 15:17:32 -08:00
@@ -121,12 +121,12 @@
 		inb_p(SMBHSTDAT1));
 
 	/* Make sure the SMBus host is ready to start transmitting */
-	if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
+	if ((temp = inb_p(SMBHSTSTS)) & 0x1F) {
 		dev_dbg(&vt596_adapter.dev, "SMBus busy (0x%02x). "
 				"Resetting...\n", temp);
 		
 		outb_p(temp, SMBHSTSTS);
-		if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
+		if ((temp = inb_p(SMBHSTSTS)) & 0x1F) {
 			dev_dbg(&vt596_adapter.dev, "Failed! (0x%02x)\n", temp);
 			
 			return -1;
@@ -168,13 +168,14 @@
 		dev_dbg(&vt596_adapter.dev, "Error: no response!\n");
 	}
 
-	if (inb_p(SMBHSTSTS) != 0x00)
-		outb_p(inb(SMBHSTSTS), SMBHSTSTS);
-
-	if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
-		dev_dbg(&vt596_adapter.dev, "Failed reset at end of "
-			"transaction (%02x)\n", temp);
+	if ((temp = inb_p(SMBHSTSTS)) & 0x1F) {
+		outb_p(temp, SMBHSTSTS);
+		if ((temp = inb_p(SMBHSTSTS)) & 0x1F) {
+			dev_warn(&vt596_adapter.dev, "Failed reset at end "
+				 "of transaction (%02x)\n", temp);
+		}
 	}
+
 	dev_dbg(&vt596_adapter.dev, "Transaction (post): CNT=%02x, CMD=%02x, "
 		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT),
 		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0), 

