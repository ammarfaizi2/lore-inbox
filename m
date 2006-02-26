Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWBZVQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWBZVQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 16:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWBZVQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 16:16:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39440 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751168AbWBZVQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 16:16:52 -0500
Date: Sun, 26 Feb 2006 22:16:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: greg@kroah.com
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/pci/hotplug/cpqphp_ctrl.c: board_replaced(): remove dead code
Message-ID: <20060226211651.GN3674@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

he Coverity checker correctly noted, that in function board_replaced in
drivers/pci/hotplug/cpqphp_ctrl.c, the variable src always has the
value 8, and therefore much code after the

...
                        if (rc || src) {
...
                                if (rc)
                                        return rc;
                                else
                                        return 1;
                        }
...


can never be called.

This patch removes the unreachable code in this function fixing kernel 
Bugzilla #6073.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/pci/hotplug/cpqphp_ctrl.c |   76 +++++-------------------------
 1 file changed, 14 insertions(+), 62 deletions(-)

--- linux-2.6.16-rc4-mm2-full/drivers/pci/hotplug/cpqphp_ctrl.c.old	2006-02-26 19:01:10.000000000 +0100
+++ linux-2.6.16-rc4-mm2-full/drivers/pci/hotplug/cpqphp_ctrl.c	2006-02-26 19:07:44.000000000 +0100
@@ -1282,9 +1282,7 @@
 	u8 hp_slot;
 	u8 temp_byte;
 	u8 adapter_speed;
-	u32 index;
 	u32 rc = 0;
-	u32 src = 8;
 
 	hp_slot = func->device - ctrl->slot_device_offset;
 
@@ -1368,68 +1366,17 @@
 
 			rc = cpqhp_configure_board(ctrl, func);
 
-			if (rc || src) {
-				/* If configuration fails, turn it off
-				 * Get slot won't work for devices behind
-				 * bridges, but in this case it will always be
-				 * called for the "base" bus/dev/func of an
-				 * adapter. */
-
-				mutex_lock(&ctrl->crit_sect);
-
-				amber_LED_on (ctrl, hp_slot);
-				green_LED_off (ctrl, hp_slot);
-				slot_disable (ctrl, hp_slot);
-
-				set_SOGO(ctrl);
-
-				/* Wait for SOBS to be unset */
-				wait_for_ctrl_irq (ctrl);
-
-				mutex_unlock(&ctrl->crit_sect);
-
-				if (rc)
-					return rc;
-				else
-					return 1;
-			}
-
-			func->status = 0;
-			func->switch_save = 0x10;
-
-			index = 1;
-			while (((func = cpqhp_slot_find(func->bus, func->device, index)) != NULL) && !rc) {
-				rc |= cpqhp_configure_board(ctrl, func);
-				index++;
-			}
-
-			if (rc) {
-				/* If configuration fails, turn it off
-				 * Get slot won't work for devices behind
-				 * bridges, but in this case it will always be
-				 * called for the "base" bus/dev/func of an
-				 * adapter. */
-
-				mutex_lock(&ctrl->crit_sect);
-
-				amber_LED_on (ctrl, hp_slot);
-				green_LED_off (ctrl, hp_slot);
-				slot_disable (ctrl, hp_slot);
-
-				set_SOGO(ctrl);
-
-				/* Wait for SOBS to be unset */
-				wait_for_ctrl_irq (ctrl);
-
-				mutex_unlock(&ctrl->crit_sect);
-
-				return rc;
-			}
-			/* Done configuring so turn LED on full time */
+			/* If configuration fails, turn it off
+			 * Get slot won't work for devices behind
+			 * bridges, but in this case it will always be
+			 * called for the "base" bus/dev/func of an
+			 * adapter. */
 
 			mutex_lock(&ctrl->crit_sect);
 
-			green_LED_on (ctrl, hp_slot);
+			amber_LED_on (ctrl, hp_slot);
+			green_LED_off (ctrl, hp_slot);
+			slot_disable (ctrl, hp_slot);
 
 			set_SOGO(ctrl);
 
@@ -1437,7 +1384,12 @@
 			wait_for_ctrl_irq (ctrl);
 
 			mutex_unlock(&ctrl->crit_sect);
-			rc = 0;
+
+			if (rc)
+				return rc;
+			else
+				return 1;
+
 		} else {
 			/* Something is wrong
 

