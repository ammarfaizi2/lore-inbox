Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbUCPAEu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbUCPAE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:04:27 -0500
Received: from mail.kroah.org ([65.200.24.183]:8623 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262882AbUCPACF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:05 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <10793913932371@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:33 -0800
Message-Id: <10793913932709@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1597.1.11, 2004/03/03 10:07:50-08:00, dave.jiang@intel.com

[PATCH] I2C: IOP3xx i2c driver update

  Here's a small patch update to the i2c-iop3xx.c in
drivers/i2c/busses/. It fixes some functions' return value and updated
the irq handler to be compatible with kernel 2.6. Thanks!


 drivers/i2c/busses/i2c-iop3xx.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
--- a/drivers/i2c/busses/i2c-iop3xx.c	Mon Mar 15 14:35:39 2004
+++ b/drivers/i2c/busses/i2c-iop3xx.c	Mon Mar 15 14:35:39 2004
@@ -129,7 +129,7 @@
  * NB: the handler has to clear the source of the interrupt! 
  * Then it passes the SR flags of interest to BH via adap data
  */
-static void iop3xx_i2c_handler(int this_irq, 
+static irqreturn_t iop3xx_i2c_handler(int this_irq, 
 				void *dev_id, 
 				struct pt_regs *regs) 
 {
@@ -142,6 +142,7 @@
 		iop3xx_adap->biu->SR_received |= sr;
 		wake_up_interruptible(&iop3xx_adap->waitq);
 	}
+	return IRQ_HANDLED;
 }
 
 /* check all error conditions, clear them , report most important */
@@ -185,7 +186,7 @@
 	unsigned sr = 0;
 	int interrupted;
 	int done;
-	int rc;
+	int rc = 0;
 
 	do {
 		interrupted = wait_event_interruptible_timeout (
@@ -198,13 +199,13 @@
 			return rc;
 		}else if (!interrupted) {
 			*status = sr;
-			return rc = -ETIMEDOUT;
+			return -ETIMEDOUT;
 		}
 	} while(!done);
 
 	*status = sr;
 
-	return rc = 0;
+	return 0;
 }
 
 /*
@@ -284,7 +285,7 @@
 {
 	unsigned cr = *iop3xx_adap->biu->CR;
 	int status;
-	int rc;
+	int rc = 0;
 
 	*iop3xx_adap->biu->DBR = byte;
 	cr &= ~IOP321_ICR_MSTART;
@@ -304,7 +305,7 @@
 {
 	unsigned cr = *iop3xx_adap->biu->CR;
 	int status;
-	int rc;
+	int rc = 0;
 
 	cr &= ~IOP321_ICR_MSTART;
 
@@ -386,13 +387,16 @@
 	iop3xx_adap_reset(iop3xx_adap);
 	iop3xx_adap_enable(iop3xx_adap);
 
-	for (im = 0; ret == 0 && im != num; ++im) {
+	for (im = 0; ret == 0 && im != num; im++) {
 		ret = iop3xx_handle_msg(i2c_adap, &msgs[im]);
 	}
 
 	iop3xx_adap_transaction_cleanup(iop3xx_adap);
+	
+	if(ret)
+		return ret;
 
-	return ret;   
+	return im;   
 }
 
 static int algo_control(struct i2c_adapter *adapter, unsigned int cmd,

