Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262601AbUKXK2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbUKXK2J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 05:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbUKXK0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 05:26:41 -0500
Received: from gprs214-63.eurotel.cz ([160.218.214.63]:46464 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262595AbUKXK0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 05:26:14 -0500
Date: Wed, 24 Nov 2004 11:25:57 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Zhu, Yi" <yi.zhu@intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
Subject: Re: [linux-pm] [PATCH] make pm_suspend_disk suspend/resume sysdev and dpm_off_irq
Message-ID: <20041124102557.GB1107@elf.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F8403BD5868@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8403BD5868@pdsmsx403>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch makes the new swsusp code ( pm_suspend_disk since 2.6.9-rc3) 
> call suspend/resume functions for sysdev and devices in dpm_off_irq
> list. 
> Otherwise, PCI link device in the system won't provide correct interrupt
> for PCI
> devices during resume.

I do not think this is right approach; you enable interrupts then
disable that again, potentially without interrupt controller being
initialized.

This should be better patch:
								Pavel

--- clean/kernel/power/swsusp.c	2004-10-19 14:16:29.000000000 +0200
+++ linux/kernel/power/swsusp.c	2004-11-23 23:11:04.000000000 +0100
@@ -854,11 +840,13 @@
 	if ((error = arch_prepare_suspend()))
 		return error;
 	local_irq_disable();
+	sysdev_suspend(3);
 	save_processor_state();
 	error = swsusp_arch_suspend();
 	/* Restore control flow magically appears here */
 	restore_processor_state();
 	restore_highmem();
+	sysdev_resume();
 	local_irq_enable();
 	return error;
 }
@@ -878,6 +866,7 @@
 {
 	int error;
 	local_irq_disable();
+	sysdev_suspend(3);
 	/* We'll ignore saved state, but this gets preempt count (etc) right */
 	save_processor_state();
 	error = swsusp_arch_resume();
@@ -887,6 +876,7 @@
 	BUG_ON(!error);
 	restore_processor_state();
 	restore_highmem();
+	sysdev_resume();
 	local_irq_enable();
 	return error;
 }




-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
