Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263222AbUB1AMl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 19:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263223AbUB1AKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 19:10:42 -0500
Received: from mail.kroah.org ([65.200.24.183]:50853 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263217AbUB1AJs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 19:09:48 -0500
Subject: Re: [PATCH] PCI fixes for 2.6.4-rc1
In-Reply-To: <10779269831109@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 27 Feb 2004 16:09:43 -0800
Message-Id: <10779269834095@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1617, 2004/02/24 11:08:29-08:00, dlsy@snoqualmie.dp.intel.com

[PATCH] PCI Hotplug: Patch to get polling mode in SHPC hot-plug driver properly working

Here is the patch to get polling mode in SHPC hot-plug properly
working.


 drivers/pci/hotplug/pciehp_ctrl.c |    2 +
 drivers/pci/hotplug/shpchp.h      |    4 +--
 drivers/pci/hotplug/shpchp_ctrl.c |    2 +
 drivers/pci/hotplug/shpchp_hpc.c  |   49 ++++++++++++++++++++++----------------
 4 files changed, 35 insertions(+), 22 deletions(-)


diff -Nru a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
--- a/drivers/pci/hotplug/pciehp_ctrl.c	Fri Feb 27 15:57:17 2004
+++ b/drivers/pci/hotplug/pciehp_ctrl.c	Fri Feb 27 15:57:17 2004
@@ -188,11 +188,13 @@
 		/*
 		 * Card Present
 		 */
+		info("Card present on Slot(%d)\n", ctrl->first_slot + hp_slot);
 		taskInfo->event_type = INT_PRESENCE_ON;
 	} else {
 		/*
 		 * Not Present
 		 */
+		info("Card not present on Slot(%d)\n", ctrl->first_slot + hp_slot);
 		taskInfo->event_type = INT_PRESENCE_OFF;
 	}
 
diff -Nru a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
--- a/drivers/pci/hotplug/shpchp.h	Fri Feb 27 15:57:17 2004
+++ b/drivers/pci/hotplug/shpchp.h	Fri Feb 27 15:57:17 2004
@@ -390,8 +390,8 @@
 		/* Sleep for up to 1 second */
 		schedule_timeout(1*HZ);
 	} else {
-		/* Sleep for up to 1.5 second */
-		schedule_timeout(1.5*HZ);
+		/* Sleep for up to 2 seconds */
+		schedule_timeout(2*HZ);
 	}
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&ctrl->queue, &wait);
diff -Nru a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
--- a/drivers/pci/hotplug/shpchp_ctrl.c	Fri Feb 27 15:57:17 2004
+++ b/drivers/pci/hotplug/shpchp_ctrl.c	Fri Feb 27 15:57:17 2004
@@ -192,11 +192,13 @@
 		/*
 		 * Card Present
 		 */
+		info("Card present on Slot(%d)\n", ctrl->first_slot + hp_slot);
 		taskInfo->event_type = INT_PRESENCE_ON;
 	} else {
 		/*
 		 * Not Present
 		 */
+		info("Card not present on Slot(%d)\n", ctrl->first_slot + hp_slot);
 		taskInfo->event_type = INT_PRESENCE_OFF;
 	}
 
diff -Nru a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
--- a/drivers/pci/hotplug/shpchp_hpc.c	Fri Feb 27 15:57:17 2004
+++ b/drivers/pci/hotplug/shpchp_hpc.c	Fri Feb 27 15:57:17 2004
@@ -1071,9 +1071,14 @@
 	if (!shpchp_poll_mode) { 
 		ctrl = (struct controller *)dev_id;
 		php_ctlr = ctrl->hpc_ctlr_handle;
-	} else 
+	} else { 
 		php_ctlr = (struct php_ctlr_state_s *) dev_id;
+		ctrl = (struct controller *)php_ctlr->callback_instance_id;
+	}
 
+	if (!ctrl)
+		return IRQ_NONE;
+	
 	if (!php_ctlr || !php_ctlr->creg)
 		return IRQ_NONE;
 
@@ -1085,18 +1090,20 @@
 	dbg("%s: shpc_isr proceeds\n", __FUNCTION__);
 	dbg("%s: intr_loc = %x\n",__FUNCTION__, intr_loc); 
 
-	/* Mask Global Interrupt Mask - see implementation note on p. 139 */
-	/* of SHPC spec rev 1.0*/
-	temp_dword = readl(php_ctlr->creg + SERR_INTR_ENABLE);
-	dbg("%s: Before masking global interrupt, temp_dword = %x\n",
-		__FUNCTION__, temp_dword); 
-	temp_dword |= 0x00000001;
-	dbg("%s: After masking global interrupt, temp_dword = %x\n",
-		__FUNCTION__, temp_dword); 
-	writel(temp_dword, php_ctlr->creg + SERR_INTR_ENABLE);
+	if(!shpchp_poll_mode) {
+		/* Mask Global Interrupt Mask - see implementation note on p. 139 */
+		/* of SHPC spec rev 1.0*/
+		temp_dword = readl(php_ctlr->creg + SERR_INTR_ENABLE);
+		dbg("%s: Before masking global interrupt, temp_dword = %x\n",
+			__FUNCTION__, temp_dword); 
+		temp_dword |= 0x00000001;
+		dbg("%s: After masking global interrupt, temp_dword = %x\n",
+			__FUNCTION__, temp_dword); 
+		writel(temp_dword, php_ctlr->creg + SERR_INTR_ENABLE);
 
-	intr_loc2 = readl(php_ctlr->creg + INTR_LOC);  
-	dbg("%s: intr_loc2 = %x\n",__FUNCTION__, intr_loc2); 
+		intr_loc2 = readl(php_ctlr->creg + INTR_LOC);  
+		dbg("%s: intr_loc2 = %x\n",__FUNCTION__, intr_loc2); 
+	}
 
 	if (intr_loc & 0x0001) {
 		/* 
@@ -1159,14 +1166,16 @@
 			dbg("%s: intr_loc2 = %x\n",__FUNCTION__, intr_loc2); 
 		}
 	}
-	/* Unmask Global Interrupt Mask */
-	temp_dword = readl(php_ctlr->creg + SERR_INTR_ENABLE);
-	dbg("%s: 2-Before unmasking global interrupt, temp_dword = %x\n",
-		__FUNCTION__, temp_dword); 
-	temp_dword &= 0xfffffffe;
-	dbg("%s: 2-After unmasking global interrupt, temp_dword = %x\n",
-		__FUNCTION__, temp_dword); 
-	writel(temp_dword, php_ctlr->creg + SERR_INTR_ENABLE);
+	if (!shpchp_poll_mode) {
+		/* Unmask Global Interrupt Mask */
+		temp_dword = readl(php_ctlr->creg + SERR_INTR_ENABLE);
+		dbg("%s: 2-Before unmasking global interrupt, temp_dword = %x\n",
+			__FUNCTION__, temp_dword); 
+		temp_dword &= 0xfffffffe;
+		dbg("%s: 2-After unmasking global interrupt, temp_dword = %x\n",
+			__FUNCTION__, temp_dword); 
+		writel(temp_dword, php_ctlr->creg + SERR_INTR_ENABLE);
+	}
 	
 	return IRQ_HANDLED;
 }

