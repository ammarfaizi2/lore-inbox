Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262300AbVCVCBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbVCVCBo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbVCVB7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 20:59:25 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:25739 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262336AbVCVBfn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:35:43 -0500
Message-Id: <20050322013459.094244000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:24:08 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-ttpcibudget-typhoon-cam.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 35/48] fix CAMs on Typhoon DVB-S
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix for CAMs on Typhoon DVB-S, where it would constantly reset itself.
(Kenneth Aafloy)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 dvb-core/dvb_ca_en50221.c |    2 +-
 ttpci/budget-av.c         |   13 ++++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvb_ca_en50221.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2005-03-21 23:27:57.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2005-03-22 00:23:49.000000000 +0100
@@ -974,7 +974,7 @@ static void dvb_ca_en50221_thread_update
 			if (ca->open) {
 				if ((!ca->slot_info[slot].da_irq_supported) ||
 				    (!(ca->flags & DVB_CA_EN50221_FLAG_IRQ_DA))) {
-					delay = HZ / 100;
+					delay = HZ / 10;
 				}
 			}
 			break;
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/budget-av.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/ttpci/budget-av.c	2005-03-22 00:16:28.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/budget-av.c	2005-03-22 00:23:49.000000000 +0100
@@ -121,6 +121,8 @@ static int ciintf_read_attribute_mem(str
 		return -EINVAL;
 
 	saa7146_setgpio(budget_av->budget.dev, 1, SAA7146_GPIO_OUTHI);
+	udelay(1);
+
 	result = ttpci_budget_debiread(&budget_av->budget, DEBICICAM, address & 0xfff, 1, 0, 0);
 
 	if (result == -ETIMEDOUT)
@@ -137,6 +139,8 @@ static int ciintf_write_attribute_mem(st
 		return -EINVAL;
 
 	saa7146_setgpio(budget_av->budget.dev, 1, SAA7146_GPIO_OUTHI);
+	udelay(1);
+
 	result = ttpci_budget_debiwrite(&budget_av->budget, DEBICICAM, address & 0xfff, 1, value, 0, 0);
 
 	if (result == -ETIMEDOUT)
@@ -153,6 +157,8 @@ static int ciintf_read_cam_control(struc
 		return -EINVAL;
 
 	saa7146_setgpio(budget_av->budget.dev, 1, SAA7146_GPIO_OUTLO);
+	udelay(1);
+
 	result = ttpci_budget_debiread(&budget_av->budget, DEBICICAM, address & 3, 1, 0, 0);
 
 	if (result == -ETIMEDOUT)
@@ -169,6 +175,8 @@ static int ciintf_write_cam_control(stru
 		return -EINVAL;
 
 	saa7146_setgpio(budget_av->budget.dev, 1, SAA7146_GPIO_OUTLO);
+	udelay(1);
+
 	result = ttpci_budget_debiwrite(&budget_av->budget, DEBICICAM, address & 3, 1, value, 0, 0);
 
 	if (result == -ETIMEDOUT)
@@ -190,7 +198,10 @@ static int ciintf_slot_reset(struct dvb_
 	saa7146_setgpio(saa, 0, SAA7146_GPIO_OUTHI);
 	msleep(100);
 	saa7146_setgpio(saa, 0, SAA7146_GPIO_OUTLO);
-	msleep(2000);		/* horrendous I know, but its the only way to be absolutely sure without an IRQ line! */
+
+	int max = 20;
+	while (--max > 0 && ciintf_read_attribute_mem(ca, slot, 0) != 0x1d)
+		msleep(100);
 
 	ttpci_budget_set_video_port(saa, BUDGET_VIDEO_PORTB);
 	return 0;

--

