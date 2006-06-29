Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932883AbWF2LQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932883AbWF2LQc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 07:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932885AbWF2LQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 07:16:32 -0400
Received: from mx1.suse.de ([195.135.220.2]:48616 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932883AbWF2LQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 07:16:31 -0400
Date: Thu, 29 Jun 2006 13:16:29 +0200
From: Karsten Keil <kkeil@suse.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] i4l:add some checks for valid drvid and driver pointer
Message-ID: <20060629111629.GB9501@pingi.kke.suse.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.16.13-4-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If all drivers go away before all ISDN network interfaces are closed we got
a OOps on removing interfaces, this patch avoid it.

Signed-off-by: Karsten Keil <kkeil@suse.de>

diff -ur linux-2.6.4.org/drivers/isdn/i4l/isdn_common.c linux-2.6.4/drivers/isdn/i4l/isdn_common.c
--- linux-2.6.4.org/drivers/isdn/i4l/isdn_common.c	2004-03-11 03:55:25.000000000 +0100
+++ linux-2.6.4/drivers/isdn/i4l/isdn_common.c	2004-03-30 18:35:38.000000000 +0200
@@ -341,6 +341,16 @@
 		printk(KERN_WARNING "isdn_command command(%x) driver -1\n", cmd->command);
 		return(1);
 	}
+	if (!dev->drv[cmd->driver]) {
+		printk(KERN_WARNING "isdn_command command(%x) dev->drv[%d] NULL\n",
+			cmd->command, cmd->driver);
+		return(1);
+	}
+	if (!dev->drv[cmd->driver]->interface) {
+		printk(KERN_WARNING "isdn_command command(%x) dev->drv[%d]->interface NULL\n",
+			cmd->command, cmd->driver);
+		return(1);
+	}
 	if (cmd->command == ISDN_CMD_SETL2) {
 		int idx = isdn_dc2minor(cmd->driver, cmd->arg & 255);
 		unsigned long l2prot = (cmd->arg >> 8) & 255;
@@ -1798,6 +1808,11 @@
 {
 	int i;

+	if ((di < 0) || (ch < 0)) {
+		printk(KERN_WARNING "%s: called with invalid drv(%d) or channel(%d)\n",
+			__FUNCTION__, di, ch);
+		return;
+	}
 	for (i = 0; i < ISDN_MAX_CHANNELS; i++)
 		if (((!usage) || ((dev->usage[i] & ISDN_USAGE_MASK) == usage)) &&
 		    (dev->drvmap[i] == di) &&
@@ -1813,7 +1828,8 @@
 			dev->v110[i] = NULL;
 // 20.10.99 JIM, try to reinitialize v110 !
 			isdn_info_update();
-			skb_queue_purge(&dev->drv[di]->rpqueue[ch]);
+			if (dev->drv[di])
+				skb_queue_purge(&dev->drv[di]->rpqueue[ch]);
 		}
 }

---

 drivers/isdn/i4l/isdn_common.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

6e755043580f8092019117eef0efcb4aada25e1f
diff --git a/drivers/isdn/i4l/isdn_common.c b/drivers/isdn/i4l/isdn_common.c
index b26e509..eb21063 100644
--- a/drivers/isdn/i4l/isdn_common.c
+++ b/drivers/isdn/i4l/isdn_common.c
@@ -340,6 +340,16 @@ isdn_command(isdn_ctrl *cmd)
 		printk(KERN_WARNING "isdn_command command(%x) driver -1\n", cmd->command);
 		return(1);
 	}
+	if (!dev->drv[cmd->driver]) {
+		printk(KERN_WARNING "isdn_command command(%x) dev->drv[%d] NULL\n",
+			cmd->command, cmd->driver);
+		return(1);
+	}
+	if (!dev->drv[cmd->driver]->interface) {
+		printk(KERN_WARNING "isdn_command command(%x) dev->drv[%d]->interface NULL\n",
+			cmd->command, cmd->driver);
+		return(1);
+	}
 	if (cmd->command == ISDN_CMD_SETL2) {
 		int idx = isdn_dc2minor(cmd->driver, cmd->arg & 255);
 		unsigned long l2prot = (cmd->arg >> 8) & 255;
@@ -1903,6 +1913,11 @@ isdn_free_channel(int di, int ch, int us
 {
 	int i;
 
+	if ((di < 0) || (ch < 0)) {
+		printk(KERN_WARNING "%s: called with invalid drv(%d) or channel(%d)\n",
+			__FUNCTION__, di, ch);
+		return;
+	}
 	for (i = 0; i < ISDN_MAX_CHANNELS; i++)
 		if (((!usage) || ((dev->usage[i] & ISDN_USAGE_MASK) == usage)) &&
 		    (dev->drvmap[i] == di) &&
@@ -1918,7 +1933,8 @@ isdn_free_channel(int di, int ch, int us
 			dev->v110[i] = NULL;
 // 20.10.99 JIM, try to reinitialize v110 !
 			isdn_info_update();
-			skb_queue_purge(&dev->drv[di]->rpqueue[ch]);
+			if (dev->drv[di])
+				skb_queue_purge(&dev->drv[di]->rpqueue[ch]);
 		}
 }
 
-- 
Karsten Keil
SuSE Labs
ISDN development
