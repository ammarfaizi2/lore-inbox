Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVCaXZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVCaXZv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 18:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbVCaXZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 18:25:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:20192 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262041AbVCaXYA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 18:24:00 -0500
Cc: ebrower@gmail.com
Subject: [PATCH] I2C: lost arbitration detection for PCF8584
In-Reply-To: <11123113933537@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 31 Mar 2005 15:23:14 -0800
Message-Id: <1112311394943@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2342, 2005/03/31 14:30:24-08:00, ebrower@gmail.com

[PATCH] I2C: lost arbitration detection for PCF8584

[PATCH] lost arbitration detection for PCF8584 algo driver

Patch against a slightly-dated linux-2.6 BK tree

This patch provides lost arbitration detection for the PCF8584
I2C algorithm driver.  The PCF8584 LAB bit is set whenever lost
arbitration is detected, so we check the bit in the wait_for_pin
function and if LAB is detected we return -EINTR.  The -EINTR
value bubbles-up all the way to the master_xfer API call so
callers may detect this condition explicitly.  LAB could be checked
more often, at the expense of code readability/maintainability.

Signed-off-by: Eric Brower <ebrower@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/algos/i2c-algo-pcf.c |   44 ++++++++++++++++++++++++++++++++++++---
 1 files changed, 41 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
--- a/drivers/i2c/algos/i2c-algo-pcf.c	2005-03-31 15:16:56 -08:00
+++ b/drivers/i2c/algos/i2c-algo-pcf.c	2005-03-31 15:16:56 -08:00
@@ -78,7 +78,6 @@
 	set_pcf(adap, 1, I2C_PCF_STOP);
 }
 
-
 static int wait_for_bb(struct i2c_algo_pcf_data *adap) {
 
 	int timeout = DEF_TIMEOUT;
@@ -109,6 +108,26 @@
 		adap->waitforpin();
 		*status = get_pcf(adap, 1);
 	}
+	if (*status & I2C_PCF_LAB) {
+		DEB2(printk(KERN_INFO 
+			"i2c-algo-pcf.o: lost arbitration (CSR 0x%02x)\n",
+			 *status));
+		/* Cleanup from LAB-- reset and enable ESO.
+		 * This resets the PCF8584; since we've lost the bus, no
+		 * further attempts should be made by callers to clean up 
+		 * (no i2c_stop() etc.)
+		 */
+		set_pcf(adap, 1, I2C_PCF_PIN);
+		set_pcf(adap, 1, I2C_PCF_ESO);
+		/* TODO: we should pause for a time period sufficient for any
+		 * running I2C transaction to complete-- the arbitration
+		 * logic won't work properly until the next START is seen.
+		 */
+		DEB2(printk(KERN_INFO 
+			"i2c-algo-pcf.o: reset LAB condition (CSR 0x%02x)\n", 
+			get_pcf(adap,1)));
+		return(-EINTR);
+	}
 #endif
 	if (timeout <= 0)
 		return(-1);
@@ -188,16 +207,22 @@
 		       unsigned char addr, int retries)
 {
 	int i, status, ret = -1;
+	int wfp;
 	for (i=0;i<retries;i++) {
 		i2c_outb(adap, addr);
 		i2c_start(adap);
 		status = get_pcf(adap, 1);
-		if (wait_for_pin(adap, &status) >= 0) {
+		if ((wfp = wait_for_pin(adap, &status)) >= 0) {
 			if ((status & I2C_PCF_LRB) == 0) { 
 				i2c_stop(adap);
 				break;	/* success! */
 			}
 		}
+		if (wfp == -EINTR) {
+			/* arbitration lost */
+			udelay(adap->udelay);
+			return -EINTR;
+		}
 		i2c_stop(adap);
 		udelay(adap->udelay);
 	}
@@ -219,6 +244,10 @@
 		i2c_outb(adap, buf[wrcount]);
 		timeout = wait_for_pin(adap, &status);
 		if (timeout) {
+			if (timeout == -EINTR) {
+				/* arbitration lost */
+				return -EINTR;
+			}
 			i2c_stop(adap);
 			dev_err(&i2c_adap->dev, "i2c_write: error - timeout.\n");
 			return -EREMOTEIO; /* got a better one ?? */
@@ -247,11 +276,16 @@
 {
 	int i, status;
 	struct i2c_algo_pcf_data *adap = i2c_adap->algo_data;
+	int wfp;
 
 	/* increment number of bytes to read by one -- read dummy byte */
 	for (i = 0; i <= count; i++) {
 
-		if (wait_for_pin(adap, &status)) {
+		if ((wfp = wait_for_pin(adap, &status))) {
+			if (wfp == -EINTR) {
+				/* arbitration lost */
+				return -EINTR;
+			}
 			i2c_stop(adap);
 			dev_err(&i2c_adap->dev, "pcf_readbytes timed out.\n");
 			return (-1);
@@ -366,6 +400,10 @@
 		/* Wait for PIN (pending interrupt NOT) */
 		timeout = wait_for_pin(adap, &status);
 		if (timeout) {
+			if (timeout == -EINTR) {
+				/* arbitration lost */
+				return (-EINTR);
+			}
 			i2c_stop(adap);
 			DEB2(printk(KERN_ERR "i2c-algo-pcf.o: Timeout waiting "
 				    "for PIN(1) in pcf_xfer\n");)

