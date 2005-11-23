Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030510AbVKWXlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030510AbVKWXlI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbVKWXlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:41:07 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:42880 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030510AbVKWXkv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:40:51 -0500
Subject: [PATCH 6/7]: Do not register from callout
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       stern@rowland.harvard.edu, Douglas_Warzecha@dell.com,
       Abhay_Salunke@dell.com
Content-Type: text/plain
Organization: IBM
Date: Wed, 23 Nov 2005 15:40:49 -0800
Message-Id: <1132789249.9460.23.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dcdbas re-registers itself from within the callout. This is incorrect in
two respects:

        1. Callout should not register/unregister.
        2. It re-registers while the block is still in the list, which
           would corrupt the list.

This patch fixes the problem by registering the callout to be the last one
to be called when the event happens.

Signed-off-by:  Chandra Seetharaman <sekharan@us.ibm.com>
Signed-off-by:  Alan Stern <stern@rowland.harvard.edu>
acked-by: Abhay_Salunke@dell.com
-----
 drivers/firmware/dcdbas.c |   19 ++++---------------
 1 files changed, 4 insertions(+), 15 deletions(-)

Index: l2615-rc1-notifiers/drivers/firmware/dcdbas.c
===================================================================
--- l2615-rc1-notifiers.orig/drivers/firmware/dcdbas.c
+++ l2615-rc1-notifiers/drivers/firmware/dcdbas.c
@@ -483,26 +483,15 @@ static void dcdbas_host_control(void)
 static int dcdbas_reboot_notify(struct notifier_block *nb, unsigned long code,
 				void *unused)
 {
-	static unsigned int notify_cnt = 0;
-
 	switch (code) {
 	case SYS_DOWN:
 	case SYS_HALT:
 	case SYS_POWER_OFF:
 		if (host_control_on_shutdown) {
 			/* firmware is going to perform host control action */
-			if (++notify_cnt == 2) {
-				printk(KERN_WARNING
-				       "Please wait for shutdown "
-				       "action to complete...\n");
-				dcdbas_host_control();
-			}
-			/*
-			 * register again and initiate the host control
-			 * action on the second notification to allow
-			 * everyone that registered to be notified
-			 */
-			register_reboot_notifier(nb);
+			printk(KERN_WARNING "Please wait for shutdown "
+			       "action to complete...\n");
+			dcdbas_host_control();
 		}
 		break;
 	}
@@ -513,7 +502,7 @@ static int dcdbas_reboot_notify(struct n
 static struct notifier_block dcdbas_reboot_nb = {
 	.notifier_call = dcdbas_reboot_notify,
 	.next = NULL,
-	.priority = 0
+	.priority = INT_MIN
 };
 
 static DCDBAS_BIN_ATTR_RW(smi_data);

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


