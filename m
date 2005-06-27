Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbVF0MTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVF0MTr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 08:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbVF0MSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 08:18:06 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:63972 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261998AbVF0MP7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:15:59 -0400
Message-Id: <20050627121414.473893000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:25 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-ttpci-firmware-timeout-handling-fix.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 25/51] ttpci: fix bug in timeout handling
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix bug in timeout handling.

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/ttpci/av7110_hw.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110_hw.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/ttpci/av7110_hw.c	2005-06-27 13:24:17.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110_hw.c	2005-06-27 13:24:18.000000000 +0200
@@ -352,11 +352,11 @@ static int __av7110_send_fw_cmd(struct a
 
 	start = jiffies;
 	while (rdebi(av7110, DEBINOSWAP, COMMAND, 0, 2 )) {
-		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_FREE)) {
 			printk(KERN_ERR "dvb-ttpci: %s(): timeout waiting for COMMAND idle\n", __FUNCTION__);
 			return -ETIMEDOUT;
 		}
+		msleep(1);
 	}
 
 	wdebi(av7110, DEBINOSWAP, COM_IF_LOCK, 0xffff, 2);
@@ -364,11 +364,11 @@ static int __av7110_send_fw_cmd(struct a
 #ifndef _NOHANDSHAKE
 	start = jiffies;
 	while (rdebi(av7110, DEBINOSWAP, HANDSHAKE_REG, 0, 2 )) {
-		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_SHAKE)) {
 			printk(KERN_ERR "dvb-ttpci: %s(): timeout waiting for HANDSHAKE_REG\n", __FUNCTION__);
 			return -ETIMEDOUT;
 		}
+		msleep(1);
 	}
 #endif
 
@@ -433,7 +433,6 @@ static int __av7110_send_fw_cmd(struct a
 #ifdef COM_DEBUG
 	start = jiffies;
 	while (rdebi(av7110, DEBINOSWAP, COMMAND, 0, 2 )) {
-		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_FREE)) {
 			printk(KERN_ERR "dvb-ttpci: %s(): timeout waiting for COMMAND %d to complete\n",
 			       __FUNCTION__,
@@ -441,6 +440,7 @@ static int __av7110_send_fw_cmd(struct a
 			       );
 			return -ETIMEDOUT;
 		}
+		msleep(1);
 	}
 
 	stat = rdebi(av7110, DEBINOSWAP, MSGSTATE, 0, 2);
@@ -554,25 +554,25 @@ int av7110_fw_request(struct av7110 *av7
 
 	start = jiffies;
 	while (rdebi(av7110, DEBINOSWAP, COMMAND, 0, 2)) {
-#ifdef _NOHANDSHAKE
-		msleep(1);
-#endif
 		if (time_after(jiffies, start + ARM_WAIT_FREE)) {
 			printk(KERN_ERR "%s: timeout waiting for COMMAND to complete\n", __FUNCTION__);
 			up(&av7110->dcomlock);
 			return -ETIMEDOUT;
 		}
+#ifdef _NOHANDSHAKE
+		msleep(1);
+#endif
 	}
 
 #ifndef _NOHANDSHAKE
 	start = jiffies;
 	while (rdebi(av7110, DEBINOSWAP, HANDSHAKE_REG, 0, 2 )) {
-		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_SHAKE)) {
 			printk(KERN_ERR "%s: timeout waiting for HANDSHAKE_REG\n", __FUNCTION__);
 			up(&av7110->dcomlock);
 			return -ETIMEDOUT;
 		}
+		msleep(1);
 	}
 #endif
 
@@ -712,13 +712,13 @@ static int FlushText(struct av7110 *av71
 		return -ERESTARTSYS;
 	start = jiffies;
 	while (rdebi(av7110, DEBINOSWAP, BUFF1_BASE, 0, 2)) {
-		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_OSD)) {
 			printk(KERN_ERR "dvb-ttpci: %s(): timeout waiting for BUFF1_BASE == 0\n",
 			       __FUNCTION__);
 			up(&av7110->dcomlock);
 			return -ETIMEDOUT;
 		}
+		msleep(1);
 	}
 	up(&av7110->dcomlock);
 	return 0;
@@ -736,24 +736,24 @@ static int WriteText(struct av7110 *av71
 
 	start = jiffies;
 	while (rdebi(av7110, DEBINOSWAP, BUFF1_BASE, 0, 2)) {
-		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_OSD)) {
 			printk(KERN_ERR "dvb-ttpci: %s: timeout waiting for BUFF1_BASE == 0\n",
 			       __FUNCTION__);
 			up(&av7110->dcomlock);
 			return -ETIMEDOUT;
 		}
+		msleep(1);
 	}
 #ifndef _NOHANDSHAKE
 	start = jiffies;
 	while (rdebi(av7110, DEBINOSWAP, HANDSHAKE_REG, 0, 2)) {
-		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_SHAKE)) {
 			printk(KERN_ERR "dvb-ttpci: %s: timeout waiting for HANDSHAKE_REG\n",
 			       __FUNCTION__);
 			up(&av7110->dcomlock);
 			return -ETIMEDOUT;
 		}
+		msleep(1);
 	}
 #endif
 	for (i = 0; i < length / 2; i++)

--

