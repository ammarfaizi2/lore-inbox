Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUE1Waa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUE1Waa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 18:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264117AbUE1WHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 18:07:32 -0400
Received: from mail.kroah.org ([65.200.24.183]:37310 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264119AbUE1WBb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 18:01:31 -0400
Subject: Re: [PATCH] I2C update for 2.6.7-rc1
In-Reply-To: <10857816431154@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 28 May 2004 15:00:43 -0700
Message-Id: <10857816431296@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1717.6.28, 2004/05/19 00:26:34-07:00, ebs@ebshome.net

[PATCH] I2C PPC4xx IIC driver: 0-length transaction temporary fix

this patch adds temporary fix for 0-length requests (e.g. SMBUS_QUICK) to PPC4xx
IIC driver. This i2c controller doesn't support such transactions and this patch
just restores previous driver version behavior making SMBUS_QUICK-based bus scan
at least partially usable. This is temporary kludge until correct bit-banging
emulation is implemented.


 drivers/i2c/busses/i2c-ibm_iic.c |   10 ++++++++++
 1 files changed, 10 insertions(+)


diff -Nru a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
--- a/drivers/i2c/busses/i2c-ibm_iic.c	Fri May 28 14:52:12 2004
+++ b/drivers/i2c/busses/i2c-ibm_iic.c	Fri May 28 14:52:12 2004
@@ -455,6 +455,16 @@
 	}		
 	for (i = 0; i < num; ++i){
 		if (unlikely(msgs[i].len <= 0)){
+			if (num == 1 && !msgs[0].len){
+				/* Special case for I2C_SMBUS_QUICK emulation.
+				 * Although this logic is FAR FROM PERFECT, this 
+				 * is what previous driver version did.
+				 * IBM IIC doesn't support 0-length transactions
+				 * (except bit-banging through IICx_DIRECTCNTL).
+				 */
+				DBG("%d: zero-length msg kludge\n", dev->idx); 
+				return 0;
+			}
 			DBG("%d: invalid len %d in msg[%d]\n", dev->idx, 
 				msgs[i].len, i);
 			return -EINVAL;

