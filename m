Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161015AbWJXMO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbWJXMO2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 08:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161018AbWJXMO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 08:14:27 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:45842 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S1161015AbWJXMO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 08:14:27 -0400
Date: Tue, 24 Oct 2006 14:14:23 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.18-rt6] BUG / typo
In-Reply-To: <Pine.LNX.4.63.0610241003280.1852@pcgl.dsa-ac.de>
Message-ID: <Pine.LNX.4.63.0610241408000.1852@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0610240954420.1852@pcgl.dsa-ac.de>
 <Pine.LNX.4.63.0610241003280.1852@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2006, Guennadi Liakhovetski wrote:

> On Tue, 24 Oct 2006, Guennadi Liakhovetski wrote:
>
>> [22644.590000] BUG: scheduling with irqs disabled: 
>> posix_cpu_timer/0x00000001/2
>> [22644.590000] caller is schedule+0x10/0x118
> [...]
>
> Hm, got the same BUG with the patch from the previous email. Looking further, 
> unless somebody has an idea?

Could the reason have been that I in my (pxa) timer ISR had 
irq_enter()/_exit around the call to handle_event, as suggested in 
i386/kernel/apic.c:

 	/*
 	 * update_process_times() expects us to have done irq_enter().
 	 * Besides, if we don't timer interrupts ignore the global
 	 * interrupt lock, which is the WrongThing (tm) to do.
 	 */
 	irq_enter();
 	/*
 	 * If the task is currently running in user mode, don't
 	 * detect soft lockups.  If CONFIG_DETECT_SOFTLOCKUP is not
 	 * configured, this should be optimized out.
 	 */
 	if (user_mode(regs))
 		touch_softlockup_watchdog();

 	evt->event_handler(regs);
 	irq_exit();

? Anyway, I cannot SEEM to reproduce it anymore now I've removed those 
calls. Will test further.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
