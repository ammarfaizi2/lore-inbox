Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbTJZQty (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 11:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbTJZQty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 11:49:54 -0500
Received: from m77.net81-65-140.noos.fr ([81.65.140.77]:19881 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S263299AbTJZQtw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 11:49:52 -0500
Date: Sun, 26 Oct 2003 17:49:16 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4.23-pre8] ieee1394 nodemgr deadlock
Message-ID: <20031026164916.GS4013@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	marcelo.tosatti@cyclades.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch was submitted here a while ago, has been ack'ed by 
Ben Collins but it still hasn't made it into the 2.4 tree.

Marcelo, please apply it, without this patch kudzu deadlocks
on every boot on my RedHat laptop.

Thanks,

Stelian.

===== drivers/ieee1394/nodemgr.c 1.23 vs edited =====
--- 1.23/drivers/ieee1394/nodemgr.c	Sat Jul 19 18:11:56 2003
+++ edited/drivers/ieee1394/nodemgr.c	Mon Sep 29 10:31:17 2003
@@ -1317,8 +1317,10 @@
 		 * to make sure things settle down. */
 		for (i = 0; i < 4 ; i++) {
 			set_current_state(TASK_INTERRUPTIBLE);
-			if (schedule_timeout(HZ/16))
+			if (schedule_timeout(HZ/16)) {
+				up(&nodemgr_serialize);
 				goto caught_signal;
+			}
 
 			/* Now get the generation in which the node ID's we collect
 			 * are valid.  During the bus scan we will use this generation
-- 
Stelian Pop <stelian@popies.net>
