Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263184AbUDYSGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbUDYSGu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 14:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbUDYSGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 14:06:50 -0400
Received: from sitemail2.everyone.net ([216.200.145.36]:48269 "EHLO
	omta10.mta.everyone.net") by vger.kernel.org with ESMTP
	id S263184AbUDYSGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 14:06:48 -0400
X-Eon-Sig: AQHOS7NAi/44uQ9TxgIAAAAC,6ac3b826d8192a647fe63e7361ecbe65
Date: Sun, 25 Apr 2004 14:06:45 -0400
From: "Kevin O'Connor" <kevin@koconnor.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] support I2C_M_NO_RD_ACK in i2c-algo-bit
Message-ID: <20040425180645.GA32199@ohio.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a message resend - the original didn't make it to lkml.

Hi Greg,

I have an I2C device (Samsung ks0127 video grabber) with a peculiar i2c
implementation.  When reading bytes, it only senses for the stop condition
in the place where the acknowledge bit should be.  So, to properly support
this device acks need to be turned off during reads.

There is an I2C_M_NO_RD_ACK bit already defined in i2c.h which appears to
be what I want.  Unfortunately it doesn't seem to be used anywhere in the
current tree.  At the end of this message is a patch to teach i2c_algo_bit
to honor the bit.

-Kevin


--- gold-2.6/drivers/i2c/algos/i2c-algo-bit.c	2004-04-04 13:56:03.000000000 -0400
+++ linux-2.6.5/drivers/i2c/algos/i2c-algo-bit.c	2004-04-20 00:35:39.103934872 -0400
@@ -381,7 +381,13 @@
 			break;
 		}
 
-		if ( count > 1 ) {		/* send ack */
+		temp++;
+		count--;
+
+		if (msg->flags & I2C_M_NO_RD_ACK)
+			continue;
+
+		if ( count > 0 ) {		/* send ack */
 			sdalo(adap);
 			DEBPROTO(printk(" Am "));
 		} else {
@@ -395,8 +401,6 @@
 		};
 		scllo(adap);
 		sdahi(adap);
-		temp++;
-		count--;
 	}
 	return rdcount;
 }
