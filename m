Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUHQLHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUHQLHJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 07:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268179AbUHQLHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 07:07:08 -0400
Received: from gprs214-89.eurotel.cz ([160.218.214.89]:1408 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265093AbUHQLHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 07:07:04 -0400
Date: Tue, 17 Aug 2004 13:03:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: swsusp: fix highmem
Message-ID: <20040817110329.GA1522@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This actually calls highmem_resume(), so swsusp has chance to work on
highmem machines. It also adds comments about code flow, which is
quite interesting at that point.

Please apply,
								Pavel 

--- clean-mm/kernel/power/swsusp.c	2004-08-17 12:21:44.000000000 +0200
+++ linux-mm/kernel/power/swsusp.c	2004-08-17 13:01:35.000000000 +0200
@@ -854,8 +854,10 @@
 	local_irq_disable();
 	save_processor_state();
 	error = swsusp_arch_suspend();
+	/* Restore control flow magically appears here */
 	restore_processor_state();
 	local_irq_enable();
+	restore_highmem();
 	return error;
 }
 
@@ -874,8 +876,13 @@
 {
 	int error;
 	local_irq_disable();
+	/* We'll ignore saved state, but this gets preempt count (etc) right */
 	save_processor_state();
 	error = swsusp_arch_resume();
+	/* Code below is only ever reached in case of failure. Otherwise
+	 * execution continues at place where swsusp_arch_suspend was called
+         */
+	BUG_ON(!error);
 	restore_processor_state();
 	restore_highmem();
 	local_irq_enable();


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
