Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270319AbTHCJjL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 05:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271089AbTHCJjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 05:39:11 -0400
Received: from zero.aec.at ([193.170.194.10]:14599 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S270319AbTHCJjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 05:39:10 -0400
Date: Sun, 3 Aug 2003 11:38:57 +0200
From: Andi Kleen <ak@muc.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Don't trigger NMI watchdog for panic delay
Message-ID: <20030803093857.GA11181@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In some cases panic can be called with interrupts off. Don't trigger
the NMI watchdog in this case when a panic= parameter is specified.

-Andi

--- linux-2.6.0test2-amd64/kernel/panic.c-o	2003-05-27 03:00:58.000000000 +0200
+++ linux-2.6.0test2-amd64/kernel/panic.c	2003-07-29 19:36:12.000000000 +0200
@@ -71,12 +71,16 @@
 
 	if (panic_timeout > 0)
 	{
+		int i;
 		/*
 	 	 * Delay timeout seconds before rebooting the machine. 
 		 * We can't use the "normal" timers since we just panicked..
 	 	 */
 		printk(KERN_EMERG "Rebooting in %d seconds..",panic_timeout);
-		mdelay(panic_timeout*1000);
+		for (i = 0; i < panic_timeout; i++) { 
+			touch_nmi_watchdog();
+			mdelay(1000);
+		} 
 		/*
 		 *	Should we run the reboot notifier. For the moment Im
 		 *	choosing not too. It might crash, be corrupt or do
