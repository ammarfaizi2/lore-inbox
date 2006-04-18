Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWDRQ2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWDRQ2L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 12:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWDRQ2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 12:28:11 -0400
Received: from gate.crashing.org ([63.228.1.57]:19670 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750863AbWDRQ2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 12:28:09 -0400
Date: Tue, 18 Apr 2006 11:23:30 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       <khali@linux-fr.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] I2C-MPC: Fix up error handling
Message-ID: <Pine.LNX.4.44.0604181122360.15940-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* If we have an Unfinished (MCF) or Arbitration Lost (MAL) error and
  the bus is still busy reset the controller.  This prevents the
  controller from getting in a hung state for transactions for other
  devices.

* Fixed up propogating the errors from i2c_wait.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 17ce1b687bda4abb8ff0989b63a140225c33de09
tree 0463714babd656b80a032ed5b9ec6f42c42ef2e5
parent 735344d2f587938da9012070f881b725269c4dc9
author Kumar Gala <galak@kernel.crashing.org> Tue, 18 Apr 2006 11:24:28 -0500
committer Kumar Gala <galak@kernel.crashing.org> Tue, 18 Apr 2006 11:24:28 -0500

 drivers/i2c/busses/i2c-mpc.c |   43 ++++++++++++++++++++++++++++++------------
 1 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 2721e4c..8d2c866 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -115,11 +115,20 @@ static int i2c_wait(struct mpc_i2c *i2c,
 
 	if (!(x & CSR_MCF)) {
 		pr_debug("I2C: unfinished\n");
+
+		/* reset the controller if the bus is still busy */
+		if (x & CSR_MBB)
+			writeccr(i2c, 0);
+
 		return -EIO;
 	}
 
 	if (x & CSR_MAL) {
 		pr_debug("I2C: MAL\n");
+
+		/* reset the controller if the bus is still busy */
+		if (x & CSR_MBB)
+			writeccr(i2c, 0);
 		return -EIO;
 	}
 
@@ -160,7 +169,7 @@ static void mpc_i2c_stop(struct mpc_i2c 
 static int mpc_write(struct mpc_i2c *i2c, int target,
 		     const u8 * data, int length, int restart)
 {
-	int i;
+	int i, ret;
 	unsigned timeout = i2c->adap.timeout;
 	u32 flags = restart ? CCR_RSTA : 0;
 
@@ -172,15 +181,17 @@ static int mpc_write(struct mpc_i2c *i2c
 	/* Write target byte */
 	writeb((target << 1), i2c->base + MPC_I2C_DR);
 
-	if (i2c_wait(i2c, timeout, 1) < 0)
-		return -1;
+	ret = i2c_wait(i2c, timeout, 1);
+	if (ret < 0)
+		return ret;
 
 	for (i = 0; i < length; i++) {
 		/* Write data byte */
 		writeb(data[i], i2c->base + MPC_I2C_DR);
 
-		if (i2c_wait(i2c, timeout, 1) < 0)
-			return -1;
+		ret = i2c_wait(i2c, timeout, 1);
+		if (ret < 0)
+			return ret;
 	}
 
 	return 0;
@@ -190,7 +201,7 @@ static int mpc_read(struct mpc_i2c *i2c,
 		    u8 * data, int length, int restart)
 {
 	unsigned timeout = i2c->adap.timeout;
-	int i;
+	int i, ret;
 	u32 flags = restart ? CCR_RSTA : 0;
 
 	/* Start with MEN */
@@ -201,8 +212,9 @@ static int mpc_read(struct mpc_i2c *i2c,
 	/* Write target address byte - this time with the read flag set */
 	writeb((target << 1) | 1, i2c->base + MPC_I2C_DR);
 
-	if (i2c_wait(i2c, timeout, 1) < 0)
-		return -1;
+	ret = i2c_wait(i2c, timeout, 1);
+	if (ret < 0)
+		return ret;
 
 	if (length) {
 		if (length == 1)
@@ -214,8 +226,9 @@ static int mpc_read(struct mpc_i2c *i2c,
 	}
 
 	for (i = 0; i < length; i++) {
-		if (i2c_wait(i2c, timeout, 0) < 0)
-			return -1;
+		ret = i2c_wait(i2c, timeout, 0);
+		if (ret < 0)
+			return ret;
 
 		/* Generate txack on next to last byte */
 		if (i == length - 2)
@@ -246,8 +259,13 @@ static int mpc_xfer(struct i2c_adapter *
 			return -EINTR;
 		}
 		if (time_after(jiffies, orig_jiffies + HZ)) {
-			pr_debug("I2C: timeout\n");
-			return -EIO;
+			writeccr(i2c, 0);
+
+			/* try one more time before we error */
+			if (readb(i2c->base + MPC_I2C_SR) & CSR_MBB) {
+				pr_debug("I2C: timeout\n");
+				return -EIO;
+			}
 		}
 		schedule();
 	}
@@ -325,6 +343,7 @@ static int fsl_i2c_probe(struct platform
 			goto fail_irq;
 		}
 
+	writeccr(i2c, 0);
 	mpc_i2c_setclock(i2c);
 	platform_set_drvdata(pdev, i2c);
 


