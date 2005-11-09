Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030446AbVKIWSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030446AbVKIWSO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030447AbVKIWSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:18:14 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24010 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030446AbVKIWSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:18:12 -0500
Date: Wed, 9 Nov 2005 23:17:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, dwmw2@infradead.org,
       Andrew Morton <akpm@osdl.org>
Subject: latest mtd changes broke collie
Message-ID: <20051109221712.GA28385@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Latest mtd changes break collie...it now oopses during boot. This
reverts the bad patch.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/mtd/chips/sharp.c b/drivers/mtd/chips/sharp.c
--- a/drivers/mtd/chips/sharp.c
+++ b/drivers/mtd/chips/sharp.c
@@ -4,7 +4,7 @@
  * Copyright 2000,2001 David A. Schleef <ds@schleef.org>
  *           2000,2001 Lineo, Inc.
  *
- * $Id: sharp.c,v 1.16 2005/11/07 11:14:23 gleixner Exp $
+ * $Id: sharp.c,v 1.14 2004/08/09 13:19:43 dwmw2 Exp $
  *
  * Devices supported:
  *   LH28F016SCT Symmetrical block flash memory, 2Mx8
@@ -32,7 +32,6 @@
 #include <linux/mtd/cfi.h>
 #include <linux/delay.h>
 #include <linux/init.h>
-#include <linux/slab.h>
 
 #define CMD_RESET		0xffffffff
 #define CMD_READ_ID		0x90909090
@@ -234,7 +233,7 @@ static int sharp_probe_map(struct map_in
 /* This function returns with the chip->mutex lock held. */
 static int sharp_wait(struct map_info *map, struct flchip *chip)
 {
-	int status, i;
+	__u32 status;
 	unsigned long timeo = jiffies + HZ;
 	DECLARE_WAITQUEUE(wait, current);
 	int adr = 0;
@@ -247,11 +246,13 @@ retry:
 		map_write32(map, CMD_READ_STATUS, adr);
 		chip->state = FL_STATUS;
 	case FL_STATUS:
-		for(i=0;i<100;i++){
-			status = map_read32(map,adr);
-			if((status & SR_READY)==SR_READY)
-				break;
-			udelay(1);
+		status = map_read32(map,adr);
+		if ((status & SR_READY) == SR_READY)
+			break;
+		spin_unlock_bh(chip->mutex);
+		if (time_after(jiffies, timeo)) {
+			printk("Waiting for chip to be ready timed out in erase\n");
+			return -EIO;
 		}
 		sharp_udelay(1);
 		goto retry;
@@ -491,11 +492,7 @@ static inline int sharp_do_wait_for_read
 		spin_lock_bh(chip->mutex);
 
 		remove_wait_queue(&chip->wq, &wait);
-
-		if (signal_pending(current)){
-			ret = -EINTR;
-			goto out;
-		}
+		set_current_state(TASK_RUNNING);
 	}
 	ret = -ETIME;
 out:



-- 
Thanks, Sharp!
