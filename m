Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbUK0FSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbUK0FSF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 00:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbUK0FSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 00:18:00 -0500
Received: from fmr17.intel.com ([134.134.136.16]:45986 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262163AbUK0FRE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 00:17:04 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [linux-pm] [PATCH] make pm_suspend_disk suspend/resume sysdev and dpm_off_irq
Date: Thu, 25 Nov 2004 12:59:39 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8403BD586A@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [linux-pm] [PATCH] make pm_suspend_disk suspend/resume sysdev and dpm_off_irq
Thread-Index: AcTSEBbEYEjWCHqnRW+NBJ6gsq2orQAm2kSg
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>, <linux-pm@lists.osdl.org>
X-OriginalArrivalTime: 25 Nov 2004 04:59:41.0353 (UTC) FILETIME=[92927990:01C4D2AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>> This patch makes the new swsusp code ( pm_suspend_disk since
>> 2.6.9-rc3) call suspend/resume functions for sysdev and devices in
>> dpm_off_irq list. Otherwise, PCI link device in the system won't
>> provide correct interrupt for PCI devices during resume.
> 
> I do not think this is right approach; you enable interrupts
> then disable that again, potentially without interrupt controller
> being initialized. 
> 
> This should be better patch:

Agreed. Your patch solves the bug. But do you plan to deal with the 
devices in dpm_off_irq list?

Thanks,
-yi

> --- clean/kernel/power/swsusp.c	2004-10-19
> 14:16:29.000000000 +0200
> +++ linux/kernel/power/swsusp.c	2004-11-23
> 23:11:04.000000000 +0100
> @@ -854,11 +840,13 @@
>  	if ((error = arch_prepare_suspend()))
>  		return error;
>  	local_irq_disable();
> +	sysdev_suspend(3);
>  	save_processor_state();
>  	error = swsusp_arch_suspend();
>  	/* Restore control flow magically appears here */ 
>  	restore_processor_state(); restore_highmem();
> +	sysdev_resume();
>  	local_irq_enable();
>  	return error;
>  }
> @@ -878,6 +866,7 @@
>  {
>  	int error;
>  	local_irq_disable();
> +	sysdev_suspend(3);
>  	/* We'll ignore saved state, but this gets preempt
> count (etc) right */
>  	save_processor_state();
>  	error = swsusp_arch_resume();
> @@ -887,6 +876,7 @@
>  	BUG_ON(!error);
>  	restore_processor_state();
>  	restore_highmem();
> +	sysdev_resume();
>  	local_irq_enable();
>  	return error;
>  }

