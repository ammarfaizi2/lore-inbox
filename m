Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVCYLbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVCYLbD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 06:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVCYLbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 06:31:01 -0500
Received: from mail.sf-mail.de ([62.27.20.61]:27777 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S261608AbVCYLaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 06:30:24 -0500
From: Rolf Eike Beer <eike-hotplug@sf-tec.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: drivers/pci/hotplug/cpqphp_ctrl.c: board_replaced: dead code
Date: Thu, 24 Mar 2005 19:07:23 +0100
User-Agent: KMail/1.8
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
References: <20050322205956.GJ1948@stusta.de>
In-Reply-To: <20050322205956.GJ1948@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503241907.26357.eike-hotplug@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> The Coverity checker correctly noted, that in function board_replaced in
> drivers/pci/hotplug/cpqphp_ctrl.c, the variable src always has the
> value 8, and therefore much code after the
>
> ...
>                         if (rc || src) {
> ...
>                                 if (rc)
>                                         return rc;
>                                 else
>                                         return 1;
>                         }
> ...
>
>
> can never be called.

Yes, this is the only use of src in the whole function. If this is not a bug
than this patch removes all the dead code.

Eike

Signed-off-by: Rolf Eike Beer <eike-hotplug@sf-tec.de>

--- linux-2.6.11/drivers/pci/hotplug/cpqphp_ctrl.c	2005-03-02 08:37:55.000000000 +0100
+++ linux-2.6.12-rc1/drivers/pci/hotplug/cpqphp_ctrl.c	2005-03-24 19:01:23.000000000 +0100
@@ -1284,7 +1284,6 @@ static u32 board_replaced(struct pci_fun
 	u8 adapter_speed;
 	u32 index;
 	u32 rc = 0;
-	u32 src = 8;
 
 	hp_slot = func->device - ctrl->slot_device_offset;
 
@@ -1367,98 +1366,25 @@ static u32 board_replaced(struct pci_fun
 			/* It must be the same board */
 
 			rc = cpqhp_configure_board(ctrl, func);
+		}
+		/* If configuration fails, turn it off
+		 * Get slot won't work for devices behind
+		 * bridges, but in this case it will always be
+		 * called for the "base" bus/dev/func of an
+		 * adapter. */
 
-			if (rc || src) {
-				/* If configuration fails, turn it off
-				 * Get slot won't work for devices behind
-				 * bridges, but in this case it will always be
-				 * called for the "base" bus/dev/func of an
-				 * adapter. */
-
-				down(&ctrl->crit_sect);
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
-				up(&ctrl->crit_sect);
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
-				down(&ctrl->crit_sect);
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
-				up(&ctrl->crit_sect);
-
-				return rc;
-			}
-			/* Done configuring so turn LED on full time */
-
-			down(&ctrl->crit_sect);
-
-			green_LED_on (ctrl, hp_slot);
-
-			set_SOGO(ctrl);
-
-			/* Wait for SOBS to be unset */
-			wait_for_ctrl_irq (ctrl);
-
-			up(&ctrl->crit_sect);
-			rc = 0;
-		} else {
-			/* Something is wrong
-
-			 * Get slot won't work for devices behind bridges, but
-			 * in this case it will always be called for the "base"
-			 * bus/dev/func of an adapter. */
-
-			down(&ctrl->crit_sect);
-
-			amber_LED_on (ctrl, hp_slot);
-			green_LED_off (ctrl, hp_slot);
-			slot_disable (ctrl, hp_slot);
+		down(&ctrl->crit_sect);
 
-			set_SOGO(ctrl);
+		amber_LED_on(ctrl, hp_slot);
+		green_LED_off(ctrl, hp_slot);
+		slot_disable(ctrl, hp_slot);
 
-			/* Wait for SOBS to be unset */
-			wait_for_ctrl_irq (ctrl);
+		set_SOGO(ctrl);
 
-			up(&ctrl->crit_sect);
-		}
+		/* Wait for SOBS to be unset */
+		wait_for_ctrl_irq(ctrl);
 
+		up(&ctrl->crit_sect);
 	}
 	return rc;
 
