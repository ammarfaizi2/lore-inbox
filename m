Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267248AbUHIVOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267248AbUHIVOU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 17:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267230AbUHIVNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 17:13:13 -0400
Received: from gprs214-227.eurotel.cz ([160.218.214.227]:640 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267226AbUHIVMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 17:12:06 -0400
Date: Mon, 9 Aug 2004 14:48:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: -mm swsusp: fix highmem handling
Message-ID: <20040809124825.GA602@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes highmem handling, and adds some comments so that others do
not fall into the same trap I fallen in: code does not continue below
swsusp_arch_resume if things go okay.

Please apply,
								Pavel

--- clean-mm/kernel/power/swsusp.c	2004-07-28 23:39:49.000000000 +0200
+++ linux-mm/kernel/power/swsusp.c	2004-08-09 11:54:04.000000000 +0200
@@ -870,8 +866,12 @@
 	local_irq_disable();
 	save_processor_state();
 	error = swsusp_arch_suspend();
+	/* Restore control flow magically appears here */
 	restore_processor_state();
 	local_irq_enable();
+#ifdef CONFIG_HIGHMEM
+	restore_highmem();
+#endif
 	return error;
 }
 
@@ -890,8 +889,12 @@
 {
 	int error;
 	local_irq_disable();
 	save_processor_state();
 	error = swsusp_arch_resume();
+	/* Code below is only ever reached in case of failure. Otherwise
+	 * execution continues at place where swsusp_arch_suspend was called
+         */
+	BUG_ON(!error);
 	restore_processor_state();
 	local_irq_enable();
 	return error;



-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
