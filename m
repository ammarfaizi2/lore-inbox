Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262613AbUKZTzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbUKZTzK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 14:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263955AbUKZTyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:54:14 -0500
Received: from zeus.kernel.org ([204.152.189.113]:53187 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262479AbUKZTbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:31:23 -0500
Date: Thu, 25 Nov 2004 12:34:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Zhu, Yi" <yi.zhu@intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
Subject: Re: [linux-pm] [PATCH] make pm_suspend_disk suspend/resume sysdev and dpm_off_irq
Message-ID: <20041125113400.GA1027@elf.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F8403BD586A@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8403BD586A@pdsmsx403>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> This patch makes the new swsusp code ( pm_suspend_disk since
> >> 2.6.9-rc3) call suspend/resume functions for sysdev and devices in
> >> dpm_off_irq list. Otherwise, PCI link device in the system won't
> >> provide correct interrupt for PCI devices during resume.
> > 
> > I do not think this is right approach; you enable interrupts
> > then disable that again, potentially without interrupt controller
> > being initialized. 
> > 
> > This should be better patch:
> 
> Agreed. Your patch solves the bug. But do you plan to deal with the 
> devices in dpm_off_irq list?

Okay, this should be better patch. It works here.

								Pavel

--- clean/kernel/power/swsusp.c	2004-10-19 14:16:29.000000000 +0200
+++ linux/kernel/power/swsusp.c	2004-11-25 12:27:35.000000000 +0100
@@ -854,11 +840,13 @@
 	if ((error = arch_prepare_suspend()))
 		return error;
 	local_irq_disable();
+	device_power_down(3);
 	save_processor_state();
 	error = swsusp_arch_suspend();
 	/* Restore control flow magically appears here */
 	restore_processor_state();
 	restore_highmem();
+	device_power_up();
 	local_irq_enable();
 	return error;
 }
@@ -878,6 +866,7 @@
 {
 	int error;
 	local_irq_disable();
+	device_power_down(3);
 	/* We'll ignore saved state, but this gets preempt count (etc) right */
 	save_processor_state();
 	error = swsusp_arch_resume();
@@ -887,6 +876,7 @@
 	BUG_ON(!error);
 	restore_processor_state();
 	restore_highmem();
+	device_power_up();
 	local_irq_enable();
 	return error;
 }

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
