Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWF2Mor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWF2Mor (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 08:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWF2Moq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 08:44:46 -0400
Received: from cantor2.suse.de ([195.135.220.15]:18875 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750709AbWF2Mop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 08:44:45 -0400
Date: Thu, 29 Jun 2006 14:44:42 +0200
From: Karsten Keil <kkeil@suse.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [NEW VERSION PATCH] i4l:add some checks for valid drvid and driver pointer
Message-ID: <20060629124442.GC10273@pingi.kke.suse.de>
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

---

 drivers/isdn/i4l/isdn_common.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

9e5d3a74fd93148042d434d61699395190c895da
diff --git a/drivers/isdn/i4l/isdn_common.c b/drivers/isdn/i4l/isdn_common.c
index b26e509..1f551a0 100644
--- a/drivers/isdn/i4l/isdn_common.c
+++ b/drivers/isdn/i4l/isdn_common.c
@@ -338,8 +338,12 @@ isdn_command(isdn_ctrl *cmd)
 {
 	if (cmd->driver == -1) {
 		printk(KERN_WARNING "isdn_command command(%x) driver -1\n", cmd->command);
-		return(1);
+		return 1;
 	}
+	if (!dev->drv[cmd->driver])
+		return 1;
+	if (!dev->drv[cmd->driver]->interface)
+		return 1;
 	if (cmd->command == ISDN_CMD_SETL2) {
 		int idx = isdn_dc2minor(cmd->driver, cmd->arg & 255);
 		unsigned long l2prot = (cmd->arg >> 8) & 255;
@@ -1903,6 +1907,8 @@ isdn_free_channel(int di, int ch, int us
 {
 	int i;
 
+	if ((di < 0) || (ch < 0))
+		return;
 	for (i = 0; i < ISDN_MAX_CHANNELS; i++)
 		if (((!usage) || ((dev->usage[i] & ISDN_USAGE_MASK) == usage)) &&
 		    (dev->drvmap[i] == di) &&
@@ -1918,7 +1924,8 @@ isdn_free_channel(int di, int ch, int us
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
