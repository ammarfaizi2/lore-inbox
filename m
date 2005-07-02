Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVGBB62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVGBB62 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 21:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263409AbVGBB4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 21:56:50 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:12780 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261683AbVGBBzU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 21:55:20 -0400
Message-Id: <20050702015618.622926000@abc>
References: <20050702015506.631451000@abc>
Date: Sat, 02 Jul 2005 03:55:09 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Oliver Endriss <o.endriss@gmx.de>
Content-Disposition: inline; filename=dvb-ttpci-preempt-timeout-fix.patch
X-SA-Exim-Connect-IP: 84.189.246.3
Subject: [DVB patch 3/8] ttpci: fix timeout handling to be save with PREEMPT
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Endriss <o.endriss@gmx.de>

Timeout handling fixed, especially for preemtible kernels and/or high system load.

Signed-off-by: Oliver Endriss <o.endriss@gmx.de>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/common/saa7146_core.c |   11 +++--
 drivers/media/dvb/ttpci/av7110_hw.c |   72 ++++++++++++++++++++++++------------
 2 files changed, 56 insertions(+), 27 deletions(-)

Index: linux-2.6.13-rc1-mm1/drivers/media/common/saa7146_core.c
===================================================================
--- linux-2.6.13-rc1-mm1.orig/drivers/media/common/saa7146_core.c	2005-07-02 03:22:09.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/media/common/saa7146_core.c	2005-07-02 03:22:28.000000000 +0200
@@ -62,13 +62,15 @@ void saa7146_setgpio(struct saa7146_dev 
 int saa7146_wait_for_debi_done(struct saa7146_dev *dev, int nobusyloop)
 {
 	unsigned long start;
+	int err;
 
 	/* wait for registers to be programmed */
 	start = jiffies;
 	while (1) {
-                if (saa7146_read(dev, MC2) & 2)
-                        break;
-		if (time_after(jiffies, start + HZ/20)) {
+		err = time_after(jiffies, start + HZ/20);
+		if (saa7146_read(dev, MC2) & 2)
+			break;
+		if (err) {
 			DEB_S(("timed out while waiting for registers getting programmed\n"));
 			return -ETIMEDOUT;
 		}
@@ -79,10 +81,11 @@ int saa7146_wait_for_debi_done(struct sa
 	/* wait for transfer to complete */
 	start = jiffies;
 	while (1) {
+		err = time_after(jiffies, start + HZ/4);
 		if (!(saa7146_read(dev, PSR) & SPCI_DEBI_S))
 			break;
 		saa7146_read(dev, MC2);
-		if (time_after(jiffies, start + HZ/4)) {
+		if (err) {
 			DEB_S(("timed out while waiting for transfer completion\n"));
 			return -ETIMEDOUT;
 		}
Index: linux-2.6.13-rc1-mm1/drivers/media/dvb/ttpci/av7110_hw.c
===================================================================
--- linux-2.6.13-rc1-mm1.orig/drivers/media/dvb/ttpci/av7110_hw.c	2005-07-02 03:22:09.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/media/dvb/ttpci/av7110_hw.c	2005-07-02 03:22:28.000000000 +0200
@@ -308,6 +308,7 @@ int av7110_wait_msgstate(struct av7110 *
 {
 	unsigned long start;
 	u32 stat;
+	int err;
 
 	if (FW_VERSION(av7110->arm_app) <= 0x261c) {
 		/* not supported by old firmware */
@@ -318,14 +319,14 @@ int av7110_wait_msgstate(struct av7110 *
 	/* new firmware */
 	start = jiffies;
 	for (;;) {
+		err = time_after(jiffies, start + ARM_WAIT_FREE);
 		if (down_interruptible(&av7110->dcomlock))
 			return -ERESTARTSYS;
 		stat = rdebi(av7110, DEBINOSWAP, MSGSTATE, 0, 2);
 		up(&av7110->dcomlock);
-		if ((stat & flags) == 0) {
+		if ((stat & flags) == 0)
 			break;
-		}
-		if (time_after(jiffies, start + ARM_WAIT_FREE)) {
+		if (err) {
 			printk(KERN_ERR "%s: timeout waiting for MSGSTATE %04x\n",
 				__FUNCTION__, stat & flags);
 			return -ETIMEDOUT;
@@ -342,6 +343,7 @@ static int __av7110_send_fw_cmd(struct a
 	char *type = NULL;
 	u16 flags[2] = {0, 0};
 	u32 stat;
+	int err;
 
 //	dprintk(4, "%p\n", av7110);
 
@@ -351,8 +353,11 @@ static int __av7110_send_fw_cmd(struct a
 	}
 
 	start = jiffies;
-	while (rdebi(av7110, DEBINOSWAP, COMMAND, 0, 2 )) {
-		if (time_after(jiffies, start + ARM_WAIT_FREE)) {
+	while (1) {
+		err = time_after(jiffies, start + ARM_WAIT_FREE);
+		if (rdebi(av7110, DEBINOSWAP, COMMAND, 0, 2) == 0)
+			break;
+		if (err) {
 			printk(KERN_ERR "dvb-ttpci: %s(): timeout waiting for COMMAND idle\n", __FUNCTION__);
 			return -ETIMEDOUT;
 		}
@@ -363,8 +368,11 @@ static int __av7110_send_fw_cmd(struct a
 
 #ifndef _NOHANDSHAKE
 	start = jiffies;
-	while (rdebi(av7110, DEBINOSWAP, HANDSHAKE_REG, 0, 2 )) {
-		if (time_after(jiffies, start + ARM_WAIT_SHAKE)) {
+	while (1) {
+		err = time_after(jiffies, start + ARM_WAIT_SHAKE);
+		if (rdebi(av7110, DEBINOSWAP, HANDSHAKE_REG, 0, 2) == 0)
+			break;
+		if (err) {
 			printk(KERN_ERR "dvb-ttpci: %s(): timeout waiting for HANDSHAKE_REG\n", __FUNCTION__);
 			return -ETIMEDOUT;
 		}
@@ -401,6 +409,7 @@ static int __av7110_send_fw_cmd(struct a
 		/* non-immediate COMMAND type */
 		start = jiffies;
 		for (;;) {
+			err = time_after(jiffies, start + ARM_WAIT_FREE);
 			stat = rdebi(av7110, DEBINOSWAP, MSGSTATE, 0, 2);
 			if (stat & flags[0]) {
 				printk(KERN_ERR "%s: %s QUEUE overflow\n",
@@ -409,7 +418,7 @@ static int __av7110_send_fw_cmd(struct a
 			}
 			if ((stat & flags[1]) == 0)
 				break;
-			if (time_after(jiffies, start + ARM_WAIT_FREE)) {
+			if (err) {
 				printk(KERN_ERR "%s: timeout waiting on busy %s QUEUE\n",
 					__FUNCTION__, type);
 				return -ETIMEDOUT;
@@ -432,12 +441,13 @@ static int __av7110_send_fw_cmd(struct a
 
 #ifdef COM_DEBUG
 	start = jiffies;
-	while (rdebi(av7110, DEBINOSWAP, COMMAND, 0, 2 )) {
-		if (time_after(jiffies, start + ARM_WAIT_FREE)) {
+	while (1) {
+		err = time_after(jiffies, start + ARM_WAIT_FREE);
+		if (rdebi(av7110, DEBINOSWAP, COMMAND, 0, 2) == 0)
+			break;
+		if (err) {
 			printk(KERN_ERR "dvb-ttpci: %s(): timeout waiting for COMMAND %d to complete\n",
-			       __FUNCTION__,
-				(buf[0] >> 8) & 0xff
-			       );
+			       __FUNCTION__, (buf[0] >> 8) & 0xff);
 			return -ETIMEDOUT;
 		}
 		msleep(1);
@@ -553,8 +563,11 @@ int av7110_fw_request(struct av7110 *av7
 	}
 
 	start = jiffies;
-	while (rdebi(av7110, DEBINOSWAP, COMMAND, 0, 2)) {
-		if (time_after(jiffies, start + ARM_WAIT_FREE)) {
+	while (1) {
+		err = time_after(jiffies, start + ARM_WAIT_FREE);
+		if (rdebi(av7110, DEBINOSWAP, COMMAND, 0, 2) == 0)
+			break;
+		if (err) {
 			printk(KERN_ERR "%s: timeout waiting for COMMAND to complete\n", __FUNCTION__);
 			up(&av7110->dcomlock);
 			return -ETIMEDOUT;
@@ -566,8 +579,11 @@ int av7110_fw_request(struct av7110 *av7
 
 #ifndef _NOHANDSHAKE
 	start = jiffies;
-	while (rdebi(av7110, DEBINOSWAP, HANDSHAKE_REG, 0, 2 )) {
-		if (time_after(jiffies, start + ARM_WAIT_SHAKE)) {
+	while (1) {
+		err = time_after(jiffies, start + ARM_WAIT_SHAKE);
+		if (rdebi(av7110, DEBINOSWAP, HANDSHAKE_REG, 0, 2) == 0)
+			break;
+		if (err) {
 			printk(KERN_ERR "%s: timeout waiting for HANDSHAKE_REG\n", __FUNCTION__);
 			up(&av7110->dcomlock);
 			return -ETIMEDOUT;
@@ -707,12 +723,16 @@ static inline int SetFont(struct av7110 
 static int FlushText(struct av7110 *av7110)
 {
 	unsigned long start;
+	int err;
 
 	if (down_interruptible(&av7110->dcomlock))
 		return -ERESTARTSYS;
 	start = jiffies;
-	while (rdebi(av7110, DEBINOSWAP, BUFF1_BASE, 0, 2)) {
-		if (time_after(jiffies, start + ARM_WAIT_OSD)) {
+	while (1) {
+		err = time_after(jiffies, start + ARM_WAIT_OSD);
+		if (rdebi(av7110, DEBINOSWAP, BUFF1_BASE, 0, 2) == 0)
+			break;
+		if (err) {
 			printk(KERN_ERR "dvb-ttpci: %s(): timeout waiting for BUFF1_BASE == 0\n",
 			       __FUNCTION__);
 			up(&av7110->dcomlock);
@@ -735,8 +755,11 @@ static int WriteText(struct av7110 *av71
 		return -ERESTARTSYS;
 
 	start = jiffies;
-	while (rdebi(av7110, DEBINOSWAP, BUFF1_BASE, 0, 2)) {
-		if (time_after(jiffies, start + ARM_WAIT_OSD)) {
+	while (1) {
+		ret = time_after(jiffies, start + ARM_WAIT_OSD);
+		if (rdebi(av7110, DEBINOSWAP, BUFF1_BASE, 0, 2) == 0)
+			break;
+		if (ret) {
 			printk(KERN_ERR "dvb-ttpci: %s: timeout waiting for BUFF1_BASE == 0\n",
 			       __FUNCTION__);
 			up(&av7110->dcomlock);
@@ -746,8 +769,11 @@ static int WriteText(struct av7110 *av71
 	}
 #ifndef _NOHANDSHAKE
 	start = jiffies;
-	while (rdebi(av7110, DEBINOSWAP, HANDSHAKE_REG, 0, 2)) {
-		if (time_after(jiffies, start + ARM_WAIT_SHAKE)) {
+	while (1) {
+		ret = time_after(jiffies, start + ARM_WAIT_SHAKE);
+		if (rdebi(av7110, DEBINOSWAP, HANDSHAKE_REG, 0, 2) == 0)
+			break;
+		if (ret) {
 			printk(KERN_ERR "dvb-ttpci: %s: timeout waiting for HANDSHAKE_REG\n",
 			       __FUNCTION__);
 			up(&av7110->dcomlock);

--

