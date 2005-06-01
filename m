Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVFAFHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVFAFHr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 01:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVFAFF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 01:05:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:53469 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261269AbVFAE7x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 00:59:53 -0400
Cc: R.Marek@sh.cvut.cz
Subject: [PATCH] I2C: ALI1563 SMBus driver fix
In-Reply-To: <20050601050942.GA26994@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 31 May 2005 22:10:14 -0700
Message-Id: <11176026144049@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: ALI1563 SMBus driver fix

This patch fixes "grave" bugs in i2c-ali1563 driver. It seems on recent
chipset revisions the HSTS_DONE is set only for block transfers, so we
must detect the end of ordinary transaction other way. Also due to missing
and mask, setting other transfer modes was not possible. Moreover the
continous byte mode transfer uses DAT0 for command rather than CMD command.
All those changes were tested with help of Chunhao Huang from Winbond.

I'm willing to maintain the driver. Second patch adds me as maintainer
if this is neccessary.

Signed-Off-By: Rudolf Marek <r.marek@sh.cvut.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 4a4e5787e0b721021fe0a456ddc987a04cebfc8d
tree 8e713a04651d591c239c847f62221432281db630
parent 2e3e80c2b75e3815a0160cbd23d4fdb767d66b35
author R.Marek@sh.cvut.cz <R.Marek@sh.cvut.cz> Thu, 21 Apr 2005 09:07:56 +0000
committer Greg KH <gregkh@suse.de> Tue, 31 May 2005 14:03:05 -0700

 MAINTAINERS                      |    6 +++++
 drivers/i2c/busses/i2c-ali1563.c |   46 ++++++++++++++++++++++++++------------
 2 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -239,6 +239,12 @@ L:	linux-usb-devel@lists.sourceforge.net
 W:	http://www.linux-usb.org/SpeedTouch/
 S:	Maintained
 
+ALI1563 I2C DRIVER
+P:	Rudolf Marek
+M:	r.marek@sh.cvut.cz
+L:	sensors@stimpy.netroedge.com
+S:	Maintained
+
 ALPHA PORT
 P:	Richard Henderson
 M:	rth@twiddle.net
diff --git a/drivers/i2c/busses/i2c-ali1563.c b/drivers/i2c/busses/i2c-ali1563.c
--- a/drivers/i2c/busses/i2c-ali1563.c
+++ b/drivers/i2c/busses/i2c-ali1563.c
@@ -2,6 +2,7 @@
  *	i2c-ali1563.c - i2c driver for the ALi 1563 Southbridge
  *
  *	Copyright (C) 2004 Patrick Mochel
+ *		      2005 Rudolf Marek <r.marek@sh.cvut.cz>
  *
  *	The 1563 southbridge is deceptively similar to the 1533, with a
  *	few notable exceptions. One of those happens to be the fact they
@@ -57,10 +58,11 @@
 #define HST_CNTL2_BLOCK		0x05
 
 
+#define HST_CNTL2_SIZEMASK	0x38
 
 static unsigned short ali1563_smba;
 
-static int ali1563_transaction(struct i2c_adapter * a)
+static int ali1563_transaction(struct i2c_adapter * a, int size)
 {
 	u32 data;
 	int timeout;
@@ -73,7 +75,7 @@ static int ali1563_transaction(struct i2
 
 	data = inb_p(SMB_HST_STS);
 	if (data & HST_STS_BAD) {
-		dev_warn(&a->dev,"ali1563: Trying to reset busy device\n");
+		dev_err(&a->dev, "ali1563: Trying to reset busy device\n");
 		outb_p(data | HST_STS_BAD,SMB_HST_STS);
 		data = inb_p(SMB_HST_STS);
 		if (data & HST_STS_BAD)
@@ -94,19 +96,31 @@ static int ali1563_transaction(struct i2
 
 	if (timeout && !(data & HST_STS_BAD))
 		return 0;
-	dev_warn(&a->dev, "SMBus Error: %s%s%s%s%s\n",
-		timeout ? "Timeout " : "",
-		data & HST_STS_FAIL ? "Transaction Failed " : "",
-		data & HST_STS_BUSERR ? "No response or Bus Collision " : "",
-		data & HST_STS_DEVERR ? "Device Error " : "",
-		!(data & HST_STS_DONE) ? "Transaction Never Finished " : "");
 
-	if (!(data & HST_STS_DONE))
+	if (!timeout) {
+		dev_err(&a->dev, "Timeout - Trying to KILL transaction!\n");
 		/* Issue 'kill' to host controller */
 		outb_p(HST_CNTL2_KILL,SMB_HST_CNTL2);
-	else
-		/* Issue timeout to reset all devices on bus */
+		data = inb_p(SMB_HST_STS);
+ 	}
+
+	/* device error - no response, ignore the autodetection case */
+	if ((data & HST_STS_DEVERR) && (size != HST_CNTL2_QUICK)) {
+		dev_err(&a->dev, "Device error!\n");
+	}
+
+	/* bus collision */
+	if (data & HST_STS_BUSERR) {
+		dev_err(&a->dev, "Bus collision!\n");
+		/* Issue timeout, hoping it helps */
 		outb_p(HST_CNTL1_TIMEOUT,SMB_HST_CNTL1);
+	}
+
+	if (data & HST_STS_FAIL) {
+		dev_err(&a->dev, "Cleaning fail after KILL!\n");
+		outb_p(0x0,SMB_HST_CNTL2);
+	}
+
 	return -1;
 }
 
@@ -149,7 +163,7 @@ static int ali1563_block_start(struct i2
 
 	if (timeout && !(data & HST_STS_BAD))
 		return 0;
-	dev_warn(&a->dev, "SMBus Error: %s%s%s%s%s\n",
+	dev_err(&a->dev, "SMBus Error: %s%s%s%s%s\n",
 		timeout ? "Timeout " : "",
 		data & HST_STS_FAIL ? "Transaction Failed " : "",
 		data & HST_STS_BUSERR ? "No response or Bus Collision " : "",
@@ -242,13 +256,15 @@ static s32 ali1563_access(struct i2c_ada
 	}
 
 	outb_p(((addr & 0x7f) << 1) | (rw & 0x01), SMB_HST_ADD);
-	outb_p(inb_p(SMB_HST_CNTL2) | (size << 3), SMB_HST_CNTL2);
+	outb_p((inb_p(SMB_HST_CNTL2) & ~HST_CNTL2_SIZEMASK) | (size << 3), SMB_HST_CNTL2);
 
 	/* Write the command register */
+
 	switch(size) {
 	case HST_CNTL2_BYTE:
 		if (rw== I2C_SMBUS_WRITE)
-			outb_p(cmd, SMB_HST_CMD);
+			/* Beware it uses DAT0 register and not CMD! */
+			outb_p(cmd, SMB_HST_DAT0);
 		break;
 	case HST_CNTL2_BYTE_DATA:
 		outb_p(cmd, SMB_HST_CMD);
@@ -268,7 +284,7 @@ static s32 ali1563_access(struct i2c_ada
 		goto Done;
 	}
 
-	if ((error = ali1563_transaction(a)))
+	if ((error = ali1563_transaction(a, size)))
 		goto Done;
 
 	if ((rw == I2C_SMBUS_WRITE) || (size == HST_CNTL2_QUICK))

