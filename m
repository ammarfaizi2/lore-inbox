Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263136AbVCDXIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263136AbVCDXIB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbVCDWF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 17:05:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:5794 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263161AbVCDUyd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:33 -0500
Cc: icampbell@arcom.com
Subject: [PATCH] I2C: improve debugging output
In-Reply-To: <11099685961559@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:36 -0800
Message-Id: <11099685961542@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2102, 2005/03/02 12:18:03-08:00, icampbell@arcom.com

[PATCH] I2C: improve debugging output

Rework the pca_xfer() function to always print the number of
successfully completed transfers in a series when debugging, even when
exiting with an error.

Signed-off-by: Ian Campbell <icampbell@arcom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/algos/i2c-algo-pca.c |   28 ++++++++++++++++------------
 1 files changed, 16 insertions(+), 12 deletions(-)


diff -Nru a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
--- a/drivers/i2c/algos/i2c-algo-pca.c	2005-03-04 12:24:16 -08:00
+++ b/drivers/i2c/algos/i2c-algo-pca.c	2005-03-04 12:24:16 -08:00
@@ -186,6 +186,7 @@
         int curmsg;
 	int numbytes = 0;
 	int state;
+	int ret;
 
 	state = pca_status(adap);
 	if ( state != 0xF8 ) {
@@ -218,6 +219,7 @@
 	}
 
 	curmsg = 0;
+	ret = -EREMOTEIO;
 	while (curmsg < num) {
 		state = pca_status(adap);
 
@@ -251,7 +253,7 @@
 		case 0x20: /* SLA+W has been transmitted; NOT ACK has been received */
 			DEB2("NOT ACK received after SLA+W\n");
 			pca_stop(adap);
-			return -EREMOTEIO;
+			goto out;
 
 		case 0x40: /* SLA+R has been transmitted; ACK has been received */
 			pca_rx_ack(adap, msg->len > 1);
@@ -263,7 +265,7 @@
 				numbytes++;
 				pca_rx_ack(adap, numbytes < msg->len - 1);
 				break;
-			} 
+			}
 			curmsg++; numbytes = 0;
 			if (curmsg == num)
 				pca_stop(adap);
@@ -274,15 +276,15 @@
 		case 0x48: /* SLA+R has been transmitted; NOT ACK has been received */
 			DEB2("NOT ACK received after SLA+R\n");
 			pca_stop(adap);
-			return -EREMOTEIO;
+			goto out;
 
 		case 0x30: /* Data byte in I2CDAT has been transmitted; NOT ACK has been received */
 			DEB2("NOT ACK received after data byte\n");
-			return -EREMOTEIO;
+			goto out;
 
 		case 0x38: /* Arbitration lost during SLA+W, SLA+R or data bytes */
 			DEB2("Arbitration lost\n");
-			return -EREMOTEIO;
+			goto out;
 			
 		case 0x58: /* Data byte has been received; NOT ACK has been returned */
 			if ( numbytes == msg->len - 1 ) {
@@ -297,21 +299,21 @@
 				     "Not final byte. numbytes %d. len %d\n",
 				     numbytes, msg->len);
 				pca_stop(adap);
-				return -EREMOTEIO;
+				goto out;
 			}
 			break;
 		case 0x70: /* Bus error - SDA stuck low */
 			DEB2("BUS ERROR - SDA Stuck low\n");
 			pca_reset(adap);
-			return -EREMOTEIO;
+			goto out;
 		case 0x90: /* Bus error - SCL stuck low */
 			DEB2("BUS ERROR - SCL Stuck low\n");
 			pca_reset(adap);
-			return -EREMOTEIO;
+			goto out;
 		case 0x00: /* Bus error during master or slave mode due to illegal START or STOP condition */
 			DEB2("BUS ERROR - Illegal START or STOP\n");
 			pca_reset(adap);
-			return -EREMOTEIO;
+			goto out;
 		default:
 			printk(KERN_ERR DRIVER ": unhandled SIO state 0x%02x\n", state);
 			break;
@@ -319,11 +321,13 @@
 		
 	}
 
-	DEB1(KERN_CRIT "}}} transfered %d messages. "
+	ret = curmsg;
+ out:
+	DEB1(KERN_CRIT "}}} transfered %d/%d messages. "
 	     "status is %#04x. control is %#04x\n", 
-	     num, pca_status(adap),
+	     curmsg, num, pca_status(adap),
 	     pca_get_con(adap));
-	return curmsg;
+	return ret;
 }
 
 static u32 pca_func(struct i2c_adapter *adap)

