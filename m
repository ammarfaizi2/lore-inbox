Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWBJQG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWBJQG3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWBJQG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:06:29 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:51120 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751275AbWBJQGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:06:19 -0500
Date: Fri, 10 Feb 2006 11:06:19 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/8] Notifier chain update: Changes to dcdbas.c
Message-ID: <Pine.LNX.4.44L0.0602101105510.5227-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Notifier chain re-implementation (as637b): dcdbas re-registers itself
from within the callout. This is incorrect in two respects:

	1. Callouts should not register/unregister.
	2. It re-registers while the block is still in the list,
	   which would corrupt the list.

This patch fixes the problem by registering the callout to be the last
one to be called when the event happens.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Chandra Seetharaman <sekharan@us.ibm.com>

Index: l2616/drivers/firmware/dcdbas.c
===================================================================
--- l2616.orig/drivers/firmware/dcdbas.c
+++ l2616/drivers/firmware/dcdbas.c
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

